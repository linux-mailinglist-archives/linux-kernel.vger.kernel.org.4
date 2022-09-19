Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0181E5BC115
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 03:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiISBoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 21:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiISBoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 21:44:13 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47232167F1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 18:44:12 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id EC9CF1E80D75;
        Mon, 19 Sep 2022 09:41:14 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0J9KB7csbfqy; Mon, 19 Sep 2022 09:41:11 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id B8C161E80CAB;
        Mon, 19 Sep 2022 09:41:11 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     akpm@linux-foundation.org, nicolas@fjasle.eu, masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] usr: Remove unnecessary -1 values from int file
Date:   Mon, 19 Sep 2022 09:44:06 +0800
Message-Id: <20220919014406.3242-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file variable is assigned first, it does not need to be initialized.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 usr/gen_init_cpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index dc838e26a5b9..ee01e40e8bc6 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -326,7 +326,7 @@ static int cpio_mkfile(const char *name, const char *location,
 	char s[256];
 	struct stat buf;
 	unsigned long size;
-	int file = -1;
+	int file;
 	int retval;
 	int rc = -1;
 	int namesize;
-- 
2.18.2

