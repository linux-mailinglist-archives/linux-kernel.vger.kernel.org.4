Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8365B4CC0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 10:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiIKIsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 04:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiIKIrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 04:47:53 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84E432A94
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 01:47:52 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 26810 invoked from network); 11 Sep 2022 10:47:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1662886070; bh=k3EahYcub+EJllvtFBGiEfyX5Qgy1Bs09Fk9domEcdg=;
          h=From:To:Cc:Subject;
          b=f46Y/YF7O7S7czbkLwb1qW2QwPjBGgrPMOS8ObhCT5fjZdH7GdRtzQpQmrNecarwr
           j3ogDgchV7QlSYiaoCOu+Dnv0d/0AN7wr73MUS/bHc1woXm5M6883BNY30/mF/rzy2
           hqmLoX4muCPsfUBM2vXXIzdhtaxaetk3LbD/CljQ=
Received: from aafh243.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.137.243])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 11 Sep 2022 10:47:50 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 06/10] x86/Kconfig: update lists in X86_EXTENDED_PLATFORM
Date:   Sun, 11 Sep 2022 10:47:07 +0200
Message-Id: <20220911084711.13694-7-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911084711.13694-1-mat.jonczyk@o2.pl>
References: <20220911084711.13694-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: c0564d9aee1cf4fe327c74be756e07af
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [ofP0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The order of the entries matches the order they appear in Kconfig.

In 2011, AMD Elan was moved to Kconfig.cpu and the dependency on
X86_EXTENDED_PLATFORM was dropped in
commit ce9c99af8d4b ("x86, cpu: Move AMD Elan Kconfig under "Processor family"")

Support for Moorestown MID devices was removed in 2012 in
commit 1a8359e411eb ("x86/mid: Remove Intel Moorestown")

SGI 320/540 (Visual Workstation) was removed in 2014 in
commit c5f9ee3d665a ("x86, platforms: Remove SGI Visual Workstation")

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
v2: update entries' order, 
    Goldfish is now "mostly Android emualator"

 arch/x86/Kconfig | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5a0bde075cae..31c2c574c67d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -512,12 +512,12 @@ config X86_EXTENDED_PLATFORM
 
 	  If you enable this option then you'll be able to select support
 	  for the following (non-PC) 32 bit x86 platforms:
-		Goldfish (Android emulator)
-		AMD Elan
+		Goldfish (mostly Android emulator)
+		Intel CE media processor (CE4100) SoC
+		Intel MID (Mobile Internet Device)
+		Intel Quark
 		RDC R-321x SoC
-		SGI 320/540 (Visual Workstation)
 		STA2X11-based (e.g. Northville)
-		Moorestown MID devices
 
 	  If you have one of these systems, or if you want to build a
 	  generic distribution kernel, say Y here - otherwise say N.
@@ -537,6 +537,8 @@ config X86_EXTENDED_PLATFORM
 		Numascale NumaChip
 		ScaleMP vSMP
 		SGI Ultraviolet
+		Goldfish (mostly Android emulator)
+		Intel MID (Mobile Internet Device)
 
 	  If you have one of these systems, or if you want to build a
 	  generic distribution kernel, say Y here - otherwise say N.
-- 
2.25.1

