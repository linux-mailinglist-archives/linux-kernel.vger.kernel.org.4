Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E818572D0F8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjFLUs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbjFLUr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:47:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9072956
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D7CB62F02
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3993C433B0;
        Mon, 12 Jun 2023 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602716;
        bh=aYadX67GYiG+Nuff8Hdg1wAWmzTfTdurTxNUVvBVt1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=agyfhPJYVc0kbRjDsZN7YsXptG8VkUsAwx0AOQgpsw68zsjgDkvW/O/PHyC8v73zP
         Mv7zeQ8mtAtabnhDqyZHb/tO4A0ckb6YbsJHih2kZH0O60Aoj/SqWFWJbqTCNmmtgR
         IwkAOjwkOUtQ1+eL2Mh7f7rOD87s0nTgbCnPBhqYZYKomZtgDyklK+K5jNPM6NQfDo
         P7sz9BR/HKOsjpSX1HNu+xoY7TxJFc7xSXr3T/T9TdhZaYuwjedjnen4UKD3hvu6iU
         xxnoAaF6Ijd0Wqf4ga7PSs6N/igt1FCcRwM8QBSIOCDjXGKel01BI6OKz513fMvvik
         jXx3PrvcOZu8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CAE30CE3A56; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 15/53] tools/nolibc: remove LINUX_REBOOT_ constants
Date:   Mon, 12 Jun 2023 13:44:36 -0700
Message-Id: <20230612204514.292087-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

The same constants and some more have been exposed to userspace via
linux/reboot.h for a long time.

To avoid conflicts and trim down nolibc a bit drop the custom
definitions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/sys.h   | 1 +
 tools/include/nolibc/types.h | 8 --------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 60dffb1cbf96..d5792a5de70b 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -21,6 +21,7 @@
 #include <linux/auxvec.h>
 #include <linux/fcntl.h> /* for O_* and AT_* */
 #include <linux/stat.h>  /* for statx() */
+#include <linux/reboot.h> /* for LINUX_REBOOT_* */
 
 #include "arch.h"
 #include "errno.h"
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index aedd7d9e3f64..15b0baffd336 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -86,14 +86,6 @@
 #define SEEK_CUR       1
 #define SEEK_END       2
 
-/* cmd for reboot() */
-#define LINUX_REBOOT_MAGIC1         0xfee1dead
-#define LINUX_REBOOT_MAGIC2         0x28121969
-#define LINUX_REBOOT_CMD_HALT       0xcdef0123
-#define LINUX_REBOOT_CMD_POWER_OFF  0x4321fedc
-#define LINUX_REBOOT_CMD_RESTART    0x01234567
-#define LINUX_REBOOT_CMD_SW_SUSPEND 0xd000fce2
-
 /* Macros used on waitpid()'s return status */
 #define WEXITSTATUS(status) (((status) & 0xff00) >> 8)
 #define WIFEXITED(status)   (((status) & 0x7f) == 0)
-- 
2.40.1

