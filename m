Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80599654D7F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 09:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbiLWIcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 03:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiLWIcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:32:39 -0500
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1CBA5FA7;
        Fri, 23 Dec 2022 00:32:37 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 6541F1E80D9F;
        Fri, 23 Dec 2022 16:27:27 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lyBlRVQ4w07q; Fri, 23 Dec 2022 16:27:24 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id A0DE41E80D96;
        Fri, 23 Dec 2022 16:27:24 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?module:=20main:=20remove=20unnecessary=20?= =?UTF-8?q?=E2=80=980=E2=80=99=20values=20from=20err?=
Date:   Fri, 23 Dec 2022 16:32:32 +0800
Message-Id: <20221223083232.4189-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

err is assigned before use, so it does not need to initialize the
assignment.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 kernel/module/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index ff2dfd1f548d..6e6e0428b183 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2669,7 +2669,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 		       int flags)
 {
 	struct module *mod;
-	long err = 0;
+	long err;
 	char *after_dashes;
 
 	/*
-- 
2.18.2

