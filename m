Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23A7612A70
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 12:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJ3Lwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 07:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3Lwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 07:52:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A244BF65;
        Sun, 30 Oct 2022 04:52:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso8143024pjc.2;
        Sun, 30 Oct 2022 04:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tpHuQsULyA7jJv8z07IMO2M4eKkpFdFDjMxeWVxud1A=;
        b=LEARYJeXKpd3vY0Fod9xyjgmctMETijid29LG4ts0WlfMDMQ4LCWwh+Ji5IgcLQepH
         fMNyWjAiZVtZYAwrv/ppeF7a9VrUe52GtiBiwXfgbYwIvVJ7zQ5PQZZc6Xe5GIfcayhc
         7kCTAExFs+OvGS/CAdcavG7HAEohtzjsVRQgi4+NeYBsPNrcJaObDoild9Xb3GbzpAil
         CB91jCNNMcTb+56R2xzRrG5EF+fCphaXjbODbs22DqksxqUv4pbyyFAgB9E5tkcytvGE
         3626Af4J+hiH8CU7YNlKtr3dYBNZE9i+v9oo8eYIxGxhDr39WVwAQ1ED2qFtdqmi8g4T
         bD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpHuQsULyA7jJv8z07IMO2M4eKkpFdFDjMxeWVxud1A=;
        b=s2u7zqhnKVtfPbu8dTlk2+0KcC5owVu8Z6i0bbSEo7TlMRQ0OaXTUVoi/MbMOeX2x3
         cS5si0KayPnhhgq7j/U5Q480g8AfnwhbxY/rXG0RT+NvAGYoWrykr28CsNly21oPf+FZ
         GcmB8T64eylL2+/ZN3VXtR/8k7PD7iGS69z6FtBk/4D7QnEPHhDAX6JQDA23BH3UmEQj
         uA0Z1tJ1HyEZ4xeiiYi4hfG2SmyuCVbwoYLLijPDzsaTAQgqe9N/U8ARnRAURTLZrxt7
         s1AJMXXkZi1/pe5Y//BJcQclY3WF7x0myFnLKpi9HUHyuQ1POQiW/vnxByEoNURu8PnM
         FmYA==
X-Gm-Message-State: ACrzQf3cs+0x0Gb2JmbBU1/Rdkbn40TydhhJWyx4A/PAHPphAQXC9pXD
        hlHB/tSFkFdfLKhnvONHh10=
X-Google-Smtp-Source: AMsMyM5rdf5YeoMDQ4oqQF4l57ebGo4x8dFcRZUrGKHYYjgK+vR102tcyfb9VAt6pCmlO8JuFHOivQ==
X-Received: by 2002:a17:902:ea02:b0:181:f8d2:1c2b with SMTP id s2-20020a170902ea0200b00181f8d21c2bmr9009085plg.107.1667130760598;
        Sun, 30 Oct 2022 04:52:40 -0700 (PDT)
Received: from localhost.localdomain (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id p10-20020a17090a348a00b00212d4cbcbfdsm2322092pjb.22.2022.10.30.04.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 04:52:39 -0700 (PDT)
From:   Akira Yokosawa <akiyks@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>,
        Kosuke Fujimoto <fujimotokosuke0@gmail.com>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>
Subject: [PATCH] docs/ja_JP/howto: Update for v6.1
Date:   Sun, 30 Oct 2022 20:52:09 +0900
Message-Id: <20221030115209.25924-1-akiyks@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reflect changes made in commits listed below:

  388f9b20f98d ("Documentation/process/howto: Only send regression fixes after -rc1").
  bc0ef4a7e4c3 ("Doc: Delete reference to the kernel-mentors mailing list")
  bcd3cf0855c5 ("Doc: Remove outdated info about bugzilla mailing lists")
  dad051395413 ("Doc: add a missing cross-reference")
  9799445af124 ("Doc: tidy up TOCs and refs to license-rules.rst")
  fb0e0ffe7fc8 ("Documentation: bring process docs up to date")
  e7b4311ebcac ("Replace HTTP links with HTTPS ones: Documentation/process")
  f1eebe92c265 ("Documentation/HOWTO: adjust external link references")
  da514157c4f0 ("docs: make reporting-bugs.rst obsolete")
  cf6d6fc27936 ("docs: process/howto.rst: make sections on bug reporting match practice")

Co-developed-by: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
Signed-off-by: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
---
Brief history of the change:

I (Akira) asked Kosuke of updating ja_JP/howto.rst after the merge of
his earlier contributions:
  e0bd6f14c28f ("docs/ja_JP/index: update section title in Japanese")
  6548e96edb50 ("docs/trans/ja_JP/howto: Don't mention specific kernel versions")

Kosuke made his WIP commits public at:
    https://github.com/KosukeFujimoto/linux/tree/WIP-docs-ja-jp-howto
    
He moved over to other responsibilities soon after and could not make
them ready for submission. Seeing almost half a year had passed without
any activity, I took over and assembled those small changes into a single
patch.

I picked Kosuke's S-o-b from his github commits.
As I also improved some of translations along the way, I assigned myself
as the author and added Kosuke's co-developed-by tag.
    
Shibata-san, hopefully can you review this update?

Jon, I'll ask you when I feel like this one is ready to be applied.

        Thanks, Akira
--
 Documentation/translations/ja_JP/howto.rst | 66 ++++++++++------------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/translations/ja_JP/howto.rst
index b8eeb45a02d4..9b0b3436dfcf 100644
--- a/Documentation/translations/ja_JP/howto.rst
+++ b/Documentation/translations/ja_JP/howto.rst
@@ -86,9 +86,14 @@ info ページ( info gcc )を見てください。
 --------
 
 Linux カーネルのソースコードは GPL ライセンスの下でリリースされていま
-す。ライセンスの詳細については、ソースツリーのメインディレクトリに存在
-する、COPYING のファイルを見てください。もしライセンスについてさらに質
-問があれば、Linux Kernel メーリングリストに質問するのではなく、どうぞ
+す。ソースツリーのメインディレクトリにある COPYING のファイルを見てく
+ださい。Linux カーネルのライセンスルールとソースコード内の
+`SPDX <https://spdx.org/>`_ 識別子の使い方は
+:ref:`Documentation/process/license-rules.rst <kernel_licensing>`
+に説明されています。
+
+もしライセンスについてさらに質問があれば、
+Linux Kernel メーリングリストに質問するのではなく、どうぞ
 法律家に相談してください。メーリングリストの人達は法律家ではなく、法的
 問題については彼らの声明はあてにするべきではありません。
 
@@ -111,7 +116,7 @@ linux-api@vger.kernel.org に送ることを勧めます。
 以下はカーネルソースツリーに含まれている読んでおくべきファイルの一覧で
 す-
 
-  README
+  :ref:`Documentation/admin-guide/README.rst <readme>`
     このファイルは Linuxカーネルの簡単な背景とカーネルを設定(訳注
     configure )し、生成(訳注 build )するために必要なことは何かが書かれ
     ています。 カーネルに関して初めての人はここからスタートすると良い
@@ -145,7 +150,8 @@ linux-api@vger.kernel.org に送ることを勧めます。
     この他にパッチを作る方法についてのよくできた記述は-
 
        "The Perfect Patch"
-		http://www.ozlabs.org/~akpm/stuff/tpp.txt
+		https://www.ozlabs.org/~akpm/stuff/tpp.txt
+
        "Linux kernel patch submission format"
 		https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html
 
@@ -237,13 +243,6 @@ Linux カーネルソースツリーの中に含まれる、きれいにし、
 れるための基礎を学ぶことができ、そしてもしあなたがまだアイディアを持っ
 ていない場合には、次にやる仕事の方向性が見えてくるかもしれません。
 
-もしあなたが、すでにひとまとまりコードを書いていて、カーネルツリーに入
-れたいと思っていたり、それに関する適切な支援を求めたい場合、カーネルメ
-ンターズプロジェクトはそのような皆さんを助けるためにできました。ここに
-はメーリングリストがあり、以下から参照できます -
-
-	https://selenic.com/mailman/listinfo/kernel-mentors
-
 実際に Linux カーネルのコードについて修正を加える前に、どうやってその
 コードが動作するのかを理解することが必要です。そのためには、特別なツー
 ルの助けを借りてでも、それを直接よく読むことが最良の方法です(ほとんど
@@ -280,9 +279,11 @@ https://kernel.org のリポジトリに存在します。
     大きな変更は git(カーネルのソース管理ツール、詳細は
     http://git-scm.com/ 参照) を使って送るのが好ましいやり方ですが、パッ
     チファイルの形式のまま送るのでも十分です。
-  - 2週間後、-rc1 カーネルがリリースされ、この後にはカーネル全体の安定
-    性に影響をあたえるような新機能は含まない類のパッチしか取り込むこと
-    はできません。新しいドライバ(もしくはファイルシステム)のパッチは
+  - 2週間後 -rc1 カーネルがリリースされ、新しいカーネルを可能な限り堅牢に
+    することに焦点が移ります。この期間のパッチのほとんどは退行を修正する
+    ものとなります。以前から存在していたバグは退行には当たらないため、
+    送るのは重要な修正だけにしてください。
+    新しいドライバ (もしくはファイルシステム) のパッチは
     -rc1 の後で受け付けられることもあることを覚えておいてください。な
     ぜなら、変更が独立していて、追加されたコードの外の領域に影響を与え
     ない限り、退行のリスクは無いからです。-rc1 がリリースされた後、
@@ -308,9 +309,12 @@ Andrew Morton が Linux-kernel メーリングリストにカーネルリリー
 
 バージョン番号が3つの数字に分かれているカーネルは -stable カーネルです。
 これには最初の2つのバージョン番号の数字に対応した、
-メインラインリリースで見つかったセキュリティ問題や
+メジャーメインラインリリースで見つかったセキュリティ問題や
 重大な後戻りに対する比較的小さい重要な修正が含まれます。
 
+メジャー安定版シリーズのそれぞれのリリースは
+バージョン番号の3番目を増加させ、最初の2つの番号は同じ値を保ちます。
+
 これは、開発/実験的バージョンのテストに協力することに興味が無く、最新
 の安定したカーネルを使いたいユーザに推奨するブランチです。
 
@@ -366,16 +370,10 @@ linux-next の実行テストを行う冒険好きなテスターは大いに歓
 バグレポート
 -------------
 
-https://bugzilla.kernel.org は Linux カーネル開発者がカーネルのバグを追跡する
-場所です。ユーザは見つけたバグの全てをこのツールで報告すべきです。どう
-kernel bugzilla を使うかの詳細は、以下を参照してください -
-
-	https://bugzilla.kernel.org/page.cgi?id=faq.html
-
 メインカーネルソースディレクトリにあるファイル
-admin-guide/reporting-bugs.rstはカーネルバグらしいものについてどうレポー
-トするかの良いテンプレートであり、問題の追跡を助けるためにカーネル開発
-者にとってどんな情報が必要なのかの詳細が書かれています。
+'Documentation/admin-guide/reporting-issues.rst'
+は、カーネルバグらしきものの報告の仕方、および、カーネル開発者が問題を
+追跡する際の手がかりとなる情報についての詳細を説明しています。
 
 バグレポートの管理
 -------------------
@@ -388,15 +386,13 @@ admin-guide/reporting-bugs.rstはカーネルバグらしいものについて
 道です、なぜなら多くの人は他人のバグの修正に時間を浪費することを好まな
 いからです。
 
-すでにレポートされたバグのために仕事をするためには、
-https://bugzilla.kernel.org に行ってください。もし今後のバグレポートに
-ついてアドバイスを受けたいのであれば、bugme-new メーリングリスト(新し
-いバグレポートだけがここにメールされる) または bugme-janitor メーリン
-グリスト(bugzilla の変更毎にここにメールされる)を購読できます。
-
-	https://lists.linux-foundation.org/mailman/listinfo/bugme-new
-
-	https://lists.linux-foundation.org/mailman/listinfo/bugme-janitors
+すでにレポートされたバグの作業をするためには、興味のあるサブシステムを
+見つけ、そのサブシステムのバグの報告先 (多くの場合メーリングリスト、
+稀にバグトラッカー) を MAINTAINERS ファイルで調べてください。
+そのアーカイブで最近の報告を検索し、できそうなものに力を貸してください。
+https://bugzilla.kernel.org でバグ報告を調べようとする人もいるでしょう。
+これは限られた一部のサブシステムのバグ報告と追跡に利用されるとともに、
+とりわけ、カーネル全体に対するバグの登録先となっています。
 
 メーリングリスト
 ----------------
@@ -621,7 +617,7 @@ Linux カーネルコミュニティは、一度に大量のコードの塊を
 ントの ChangeLog セクションを見てください -
 
   "The Perfect Patch"
-      http://www.ozlabs.org/~akpm/stuff/tpp.txt
+      https://www.ozlabs.org/~akpm/stuff/tpp.txt
 
 これらはどれも、実行することが時にはとても困難です。これらの例を完璧に
 実施するには数年かかるかもしれません。これは継続的な改善のプロセスであ

base-commit: f907bf630e9c057e80f4883d5e1a3d9a395bb6d2
-- 
2.25.1

