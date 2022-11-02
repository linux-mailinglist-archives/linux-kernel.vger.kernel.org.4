Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC23C615FB0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiKBJ2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiKBJ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:27:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B3AE12;
        Wed,  2 Nov 2022 02:27:36 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:27:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667381254;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QwHtpybh8uWFCp4slmM5agXbdIBRLz4PaWVEeRw61p0=;
        b=iw5sdEGqwTVUxG+i2IXxe5fj5Kmxyfm6Ykb6l0YWsKnnnlHb00FqkKTQ7+afx6fpCl/GEP
        znDd53DKEs81+duQ336DMfwKm7difvItY/o8MMOv4NBdLYWHv7pVGQ3xzg+vbhQPalLM9c
        EcrvgdxC0x2rSw3GXRbYq72sAftnd4YCSmdKa7qReL7tSfosCbn4A99+917mdH3YbS4uDd
        lTT7XU8D2DF0T2G1F5z/ve/OWaQTylA7VE99nNd5K9XvemiRmBG28s67oFfFaB0+fgt/b1
        +brseP3nwIYIyEDHsw8DQU9zpYrun/iVPhGwCDRjOWS5dnX4UbPVRpAaRQsJsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667381254;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QwHtpybh8uWFCp4slmM5agXbdIBRLz4PaWVEeRw61p0=;
        b=ByfRd5Nj7z73Vgwk4FDSy7g/uoZSy7jOYJRyjpvIAjHOSMn8tdSNUcQwnwDQyY+bTvPR9Z
        68Xs+QUUU3btIKCg==
From:   "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/boot: Repair kernel-doc for boot_kstrtoul()
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221031094835.15923-1-lukas.bulwahn@gmail.com>
References: <20221031094835.15923-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Message-ID: <166738125354.7716.16790203039429417490.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     d632bf6ff1f6f733e1de9c5331fd643f4ecbe483
Gitweb:        https://git.kernel.org/tip/d632bf6ff1f6f733e1de9c5331fd643f4ecbe483
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Mon, 31 Oct 2022 10:48:35 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 02 Nov 2022 10:20:02 +01:00

x86/boot: Repair kernel-doc for boot_kstrtoul()

Adjust the kernel-doc comment to have the proper function name:
boot_kstrtoul().

  [ bp: Massage commit message. ]

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221031094835.15923-1-lukas.bulwahn@gmail.com
---
 arch/x86/boot/string.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 8a3fff9..1c8541a 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -350,7 +350,7 @@ static int _kstrtoul(const char *s, unsigned int base, unsigned long *res)
 }
 
 /**
- * kstrtoul - convert a string to an unsigned long
+ * boot_kstrtoul - convert a string to an unsigned long
  * @s: The start of the string. The string must be null-terminated, and may also
  *  include a single newline before its terminating null. The first character
  *  may also be a plus sign, but not a minus sign.
