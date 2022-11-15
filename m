Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A15B62981B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238307AbiKOMFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbiKOMFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:05:16 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831FC2A274
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:04:06 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso16706772pjg.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ro+MbMf8dmkiUANLm/CwPovVdgr4UdCaFJg+MF49rQ8=;
        b=PbP1Ulu/JiFnhwpwtGz0nkEQ2hyf22Xg4Z4+kNMReSzV6x3OMqbiMGWwe0VBcpyYdj
         nseU7LSIXnY+xlilewdlau6ZZruDM2UN+0HOlXg6oPSgSEgAEOVJhHAfNtpnpHPYMb3G
         NqJU+Q1T6oZkGv459GFaVKa/D39UkfQ59dQthiQrr8KKrBn1fX3zePrrVqCfHCm5YZJO
         VlW/nz42IseGDGgmkoUUg/vIu4DKgESJqVWBBpvd2/hRfiERfUCNfef0adxYf+c6H+b7
         MyQRp1Ylnz9I5FXceFCPw5mQbOoxgHm6o/cxxjYWUQswMpAWi23RVgvCYmkoT11DMYU8
         CoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ro+MbMf8dmkiUANLm/CwPovVdgr4UdCaFJg+MF49rQ8=;
        b=M45KNHOLO3Aan3QSxQYEGvR97hJfaWM6spzPd2FVpbl2f3OPaTRnmA3fm8DWN5r4DC
         +vgQ2AR1VxGdUpRXM9TmoT2IfjDdSWwyH7Evt2bnHSOV7cepe1CYmM0JQ6nyKT9YXZbo
         TYWa8zqRaJm6G/2S8NmYWbt0UPiXGhlyxw6YSgO16fs2XtL0fFkDqm4+VqMNgStxVjr0
         ZbF0gvz7ni0SYxbeRFqdKycXQFcV9eheFUG4/m56R4htdBKAfqY+Gr3rREQ1V9/CXL+D
         wsYSKHv4sB+91tEy/PbXDvuI2mAcZjWW7LQ18kgFEDUBYskbwxzFw5VSrFADfdqov73r
         GJCg==
X-Gm-Message-State: ANoB5plKxrYwKtxFvLdYGYnQCrX9LLGWilDC2e/x4WvFedH3ipQDLeny
        5UH1XbfP3T49KlGg5WE2Smg=
X-Google-Smtp-Source: AA0mqf6IvBrEBvruKwdpmy3i/NzpejidAEnwySJxvA91X+K0YWBJC4+9znmUE22AIvqdiamduu5z/w==
X-Received: by 2002:a17:90a:d587:b0:20a:c032:da66 with SMTP id v7-20020a17090ad58700b0020ac032da66mr260167pju.19.1668513846021;
        Tue, 15 Nov 2022 04:04:06 -0800 (PST)
Received: from localhost ([58.34.94.196])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001708c4ebbaesm9651411plg.309.2022.11.15.04.04.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Nov 2022 04:04:05 -0800 (PST)
From:   "Jiazi.Li" <jqqlijiazi@gmail.com>
X-Google-Original-From: "Jiazi.Li" <jiazi.li@transsion.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, arve@android.com,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>
Cc:     "Jiazi.Li" <jiazi.li@transsion.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] binder: remove unneeded size check code
Date:   Tue, 15 Nov 2022 20:03:51 +0800
Message-Id: <20221115120351.2769-1-jiazi.li@transsion.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In binder_ioctl function, the legitimacy check of cmd size has been
done in switch-case code:
switch (cmd) {
	case BINDER_WRITE_READ;//BINDER_WRITE_READ contains size info

So unneeded do size check in binder_ioctl and binder_ioctl_write_read
again.

In the following version of Google GKI:

Linux version 5.10.110-android12-9-00011-g2c814f559132-ab8969555

It seems that the compiler has made optimization and has not passed
cmd parameters to binder_ioctl_write_read:
<binder_ioctl+628>:  mov     w8, #0x6201                     // #25089
<binder_ioctl+632>:  movk    w8, #0xc030, lsl #16
<binder_ioctl+636>:  cmp     w20, w8
<binder_ioctl+640>:  b.ne    0xffffffda8aa97880 <binder_ioctl+3168>
<binder_ioctl+644>:  mov     x0, x23 //filp
<binder_ioctl+648>:  mov     x1, x27 //arg
<binder_ioctl+652>:  mov     x2, x22 //thread
<binder_ioctl+656>:  bl      0xffffffda8aa9e6e4 <binder_ioctl_write_read>
<binder_ioctl+660>:  mov     w26, w0

Signed-off-by: Jiazi.Li <jiazi.li@transsion.com>
---
 drivers/android/binder.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 880224ec6abb..48e5a3531282 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5006,20 +5006,14 @@ static __poll_t binder_poll(struct file *filp,
 	return 0;
 }
 
-static int binder_ioctl_write_read(struct file *filp,
-				unsigned int cmd, unsigned long arg,
+static int binder_ioctl_write_read(struct file *filp, unsigned long arg,
 				struct binder_thread *thread)
 {
 	int ret = 0;
 	struct binder_proc *proc = filp->private_data;
-	unsigned int size = _IOC_SIZE(cmd);
 	void __user *ubuf = (void __user *)arg;
 	struct binder_write_read bwr;
 
-	if (size != sizeof(struct binder_write_read)) {
-		ret = -EINVAL;
-		goto out;
-	}
 	if (copy_from_user(&bwr, ubuf, sizeof(bwr))) {
 		ret = -EFAULT;
 		goto out;
@@ -5296,7 +5290,6 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	int ret;
 	struct binder_proc *proc = filp->private_data;
 	struct binder_thread *thread;
-	unsigned int size = _IOC_SIZE(cmd);
 	void __user *ubuf = (void __user *)arg;
 
 	/*pr_info("binder_ioctl: %d:%d %x %lx\n",
@@ -5318,7 +5311,7 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	switch (cmd) {
 	case BINDER_WRITE_READ:
-		ret = binder_ioctl_write_read(filp, cmd, arg, thread);
+		ret = binder_ioctl_write_read(filp, arg, thread);
 		if (ret)
 			goto err;
 		break;
@@ -5361,10 +5354,6 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case BINDER_VERSION: {
 		struct binder_version __user *ver = ubuf;
 
-		if (size != sizeof(struct binder_version)) {
-			ret = -EINVAL;
-			goto err;
-		}
 		if (put_user(BINDER_CURRENT_PROTOCOL_VERSION,
 			     &ver->protocol_version)) {
 			ret = -EINVAL;
-- 
2.17.1

