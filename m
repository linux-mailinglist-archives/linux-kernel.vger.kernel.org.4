Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333D16F3B99
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 03:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjEBBC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 21:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjEBBC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 21:02:26 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06523A9C;
        Mon,  1 May 2023 18:02:22 -0700 (PDT)
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id XWE00114;
        Tue, 02 May 2023 09:02:14 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201619.home.langchao.com (10.100.2.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 2 May 2023 09:02:17 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <corbet@lwn.net>, <fujimotokosuke0@gmail.com>,
        <shibata@linuxfoundation.org>
CC:     <akiyks@gmail.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] docs/ja_JP/SubmittingPatches: fix typo of Reviewd
Date:   Mon, 1 May 2023 21:01:57 -0400
Message-ID: <20230502010157.1655-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.200.104.82]
X-ClientProxiedBy: Jtjnmail201618.home.langchao.com (10.100.2.18) To
 jtjnmail201619.home.langchao.com (10.100.2.19)
tUid:   2023502090214ecbadf59a02977aac4af6e63c57dbaa5
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

We should use the Reviewed replace the Reviewd.

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

