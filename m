Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D462E638F94
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 19:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiKYSSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 13:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKYSSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 13:18:30 -0500
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535E44A5B9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 10:18:29 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id ydHPo88zt1SdMydHPoYhIK; Fri, 25 Nov 2022 19:18:27 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 25 Nov 2022 19:18:27 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] initramfs: Remove a useless include
Date:   Fri, 25 Nov 2022 19:18:25 +0100
Message-Id: <06ab5dd1d3ed3f5e08d10efd4391aae5b1264e67.1669400298.git.christophe.jaillet@wanadoo.fr>
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

<linux/dirent.h> only define the 'linux_dirent64' structure that is not
used in this file since commit	b2a74d5f9d44 ("initramfs: remove
clean_rootfs")

So remove the useless include.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 init/initramfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 62321883fe61..3eae875d1ff7 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -7,7 +7,6 @@
 #include <linux/fcntl.h>
 #include <linux/delay.h>
 #include <linux/string.h>
-#include <linux/dirent.h>
 #include <linux/syscalls.h>
 #include <linux/utime.h>
 #include <linux/file.h>
-- 
2.34.1

