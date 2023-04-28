Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811E56F13E3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345451AbjD1JLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjD1JLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:11:34 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Apr 2023 02:11:29 PDT
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B071E2D67;
        Fri, 28 Apr 2023 02:11:29 -0700 (PDT)
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id YFN00120;
        Fri, 28 Apr 2023 17:10:20 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201619.home.langchao.com (10.100.2.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 17:10:21 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <corbet@lwn.net>, <fujimotokosuke0@gmail.com>,
        <shibata@linuxfoundation.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] Documentation/translations/ja_JP/SubmittingPatches: fix some typos
Date:   Fri, 28 Apr 2023 05:10:18 -0400
Message-ID: <20230428091018.1558-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.200.104.82]
X-ClientProxiedBy: Jtjnmail201617.home.langchao.com (10.100.2.17) To
 jtjnmail201619.home.langchao.com (10.100.2.19)
tUid:   20234281710205c6d46daffd72b31717b16de9d57a623
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix of  typos spotted reading documentation in Japanese.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 Documentation/translations/ja_JP/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documentation/translations/ja_JP/SubmittingPatches
index 04deb77b20c6..5334db471744 100644
--- a/Documentation/translations/ja_JP/SubmittingPatches
+++ b/Documentation/translations/ja_JP/SubmittingPatches
@@ -450,7 +450,7 @@ Reviewed-by: タグは、それとは異なり、下記のレビューア宣言
             状況においてその宣言した目的や機能が正しく実現することに関して、
             いかなる保証もしない(特にどこかで明示しない限り)。
 
-Reviewd-by タグはそのパッチがカーネルに対して適切な修正であって、深刻な技術的
+Reviewed-by タグはそのパッチがカーネルに対して適切な修正であって、深刻な技術的
 問題を残していないという意見の宣言です。興味のあるレビューアは誰でも(レビュー
 作業を終えたら)パッチに対して Reviewed-by タグを提示できます。このタグは
 レビューアの寄与をクレジットする働き、レビューの進捗の度合いをメンテナに
-- 
2.27.0

