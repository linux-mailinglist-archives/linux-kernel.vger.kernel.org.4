Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAD065C4C2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjACRGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238458AbjACRG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:06:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ED113D27;
        Tue,  3 Jan 2023 09:02:29 -0800 (PST)
Date:   Tue, 03 Jan 2023 17:02:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672765325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NbNZL1/2Oiy5t6PrYaYGRIsq5R0jMZs5rC//ELbFRzM=;
        b=TNYIJvGpuQwWmnzUvVYVnhSEdmUuw/SyTdiFvQwEMEp1uCD3i/2+aXvvGSEqANqTgw7DxW
        +53YKF8x94VexfUCcI8pThiwZwK6VqsuSP/JIkVlTWZW6nls9iI7F3vIe3qnVoeoc4xoMV
        pcnqvhv8kdKrMLwvz3rwJwDEIt6inLEZyg4np02ZISmqWD8101cfONdMyf5GiuMljWm9b9
        +tWml/ti89GvGFrFz3WtkKHmIIGAyYl3gCJ2c6yoc6D+9f0bPZi1lyTXbt00CozrBTriRb
        vwHsKIYLeZ0FmujN7EJzSqwHB8BKblFMVRehghJxUqZ9rQyTCEW0HbtXs1375w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672765325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NbNZL1/2Oiy5t6PrYaYGRIsq5R0jMZs5rC//ELbFRzM=;
        b=1t6X4m25ig6UDQKuPKFIvKKEolexytJu2Y8OUkC5URrfHJjcs67mQp/Z6j3aVXxH0Rwj9T
        lZ7NsdP78axbSfBQ==
From:   "tip-bot2 for Anuradha Weeraman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/lib: Fix compiler and kernel-doc warnings
Cc:     Anuradha Weeraman <anuradha@debian.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230103114725.108431-1-anuradha@debian.org>
References: <20230103114725.108431-1-anuradha@debian.org>
MIME-Version: 1.0
Message-ID: <167276532531.4906.13323918838111480270.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     f843bfeee3d95782677569856ea7f33b87bfd3d0
Gitweb:        https://git.kernel.org/tip/f843bfeee3d95782677569856ea7f33b87bfd3d0
Author:        Anuradha Weeraman <anuradha@debian.org>
AuthorDate:    Tue, 03 Jan 2023 17:17:24 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Jan 2023 17:56:08 +01:00

x86/lib: Fix compiler and kernel-doc warnings

Fix the following W=1 warnings:

arch/x86/lib/cmdline.c:

  - Include <asm/cmdline.h> to fix missing-prototypes warnings.

  - Update comment for __cmdline_find_option_bool to fix a kernel-doc warning.

Signed-off-by: Anuradha Weeraman <anuradha@debian.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230103114725.108431-1-anuradha@debian.org
---
 arch/x86/lib/cmdline.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/cmdline.c b/arch/x86/lib/cmdline.c
index b6da093..80570eb 100644
--- a/arch/x86/lib/cmdline.c
+++ b/arch/x86/lib/cmdline.c
@@ -7,16 +7,18 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <asm/setup.h>
+#include <asm/cmdline.h>
 
 static inline int myisspace(u8 c)
 {
 	return c <= ' ';	/* Close enough approximation */
 }
 
-/**
+/*
  * Find a boolean option (like quiet,noapic,nosmp....)
  *
  * @cmdline: the cmdline string
+ * @max_cmdline_size: the maximum size of cmdline
  * @option: option string to look for
  *
  * Returns the position of that @option (starts counting with 1)
