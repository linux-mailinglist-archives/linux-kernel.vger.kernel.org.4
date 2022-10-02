Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58725F2569
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 23:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiJBVLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 17:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiJBVLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 17:11:13 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39D62ED69
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 14:11:11 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id f6Evo1J2RsfCIf6EvozjHg; Sun, 02 Oct 2022 23:11:09 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Oct 2022 23:11:09 +0200
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] lib: Drop some empty comment blocks
Date:   Sun,  2 Oct 2022 20:40:23 +0200
Message-Id: <5bcc0f7840594afa540be450bca3159a2c616bd3.1664736011.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 588cb88cedd5 ("treewide: Replace GPLv2 boilerplate/reference with
SPDX - rule 120") has left some empty comment blocks.

Remove them to save a few lines of code.

Also remove some useless empty lines between some #include.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 lib/ashldi3.c | 3 ---
 lib/cmpdi2.c  | 3 ---
 lib/muldi3.c  | 2 --
 lib/ucmpdi2.c | 2 --
 4 files changed, 10 deletions(-)

diff --git a/lib/ashldi3.c b/lib/ashldi3.c
index 8e6a69d59180..5dcaf1c89a9d 100644
--- a/lib/ashldi3.c
+++ b/lib/ashldi3.c
@@ -1,9 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/*
- */
 
 #include <linux/export.h>
-
 #include <linux/libgcc.h>
 
 long long notrace __ashldi3(long long u, word_type b)
diff --git a/lib/cmpdi2.c b/lib/cmpdi2.c
index f7cebd52bd68..37e435f0d0ef 100644
--- a/lib/cmpdi2.c
+++ b/lib/cmpdi2.c
@@ -1,9 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/*
- */
 
 #include <linux/export.h>
-
 #include <linux/libgcc.h>
 
 word_type notrace __cmpdi2(long long a, long long b)
diff --git a/lib/muldi3.c b/lib/muldi3.c
index 9150ac13050e..34cf53e45ca9 100644
--- a/lib/muldi3.c
+++ b/lib/muldi3.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/*
- */
 
 #include <linux/export.h>
 #include <linux/libgcc.h>
diff --git a/lib/ucmpdi2.c b/lib/ucmpdi2.c
index 726e394c9fcc..fc001a8f76cd 100644
--- a/lib/ucmpdi2.c
+++ b/lib/ucmpdi2.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/*
- */
 
 #include <linux/module.h>
 #include <linux/libgcc.h>
-- 
2.34.1

