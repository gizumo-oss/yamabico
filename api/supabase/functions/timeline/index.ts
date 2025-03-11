import "https://esm.sh/@supabase/functions-js/src/edge-runtime.d.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

Deno.serve(async (req) => {
  // supabaseクライアント作成
  const supaURL: string | undefined = Deno.env.get("SUPABASE_URL");
  const supaAnonKey: string | undefined = Deno.env.get("SUPABASE_ANON_KEY");
  if (supaURL === undefined || supaAnonKey === undefined) {
    return new Response(
      JSON.stringify('環境変数を設定してください'),
      {
        headers: { "Content-Type": "application/json" },
        status: 401
      },
    );
  }
  const supabase = createClient(supaURL, supaAnonKey);

  // user情報を取得
  let token = req.headers.get('authorization');
  const userInfo = await supabase.auth.getUser(token.slice(7));

  // エンドポイントから情報の抜き出し
  const url = new URL(req.url);
  const params = new URLSearchParams(url.search);
  const sortedBy = params.get('sortedBy');

  // DBへのリクエスト
  const query = supabase
    .from('audios')
    .select('*')
    .neq('created_by', userInfo.data.user.id);

  // ソート
  if (sortedBy) {
    query.order(sortedBy, { ascending: (params.get('orderBy') ?? 'asc') === 'asc' });
  }

  return new Response(
    JSON.stringify(await query),
    { headers: { "Content-Type": "application/json" } },
  );
});
