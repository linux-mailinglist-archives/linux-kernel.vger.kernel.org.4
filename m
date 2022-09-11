Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0235B4CBA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 10:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiIKIsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 04:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIKIrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 04:47:53 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAF332A89
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 01:47:51 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 23566 invoked from network); 11 Sep 2022 10:47:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1662886068; bh=4B44hVCIwBDDIJlt2GEX1V1Y9tCngkDcNQ/p4zW1j8E=;
          h=From:To:Cc:Subject;
          b=FWM1/DbWx8e/+onvDZ8Rtr7RpK6Fyzzu7K0PQAoKFM0QJa9fgvcQPvsAh+rYbwRJu
           B8KaBts9eFAZ7RXYE3JdPiGW8PkEDNqnnSma4s4tqOUs7KgnqCD1sCzw5yihNr1zxN
           QtS+BWomw5UX6LiWJo33NhegldCrUbXiyEuL9h4w=
Received: from aafh243.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.137.243])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 11 Sep 2022 10:47:48 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 05/10] x86/Kconfig: move all X86_EXTENDED_PLATFORM options together
Date:   Sun, 11 Sep 2022 10:47:06 +0200
Message-Id: <20220911084711.13694-6-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911084711.13694-1-mat.jonczyk@o2.pl>
References: <20220911084711.13694-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: c75b25129d92ad3f73d4b296c2dd2913
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [oXNE]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

so that these options will be displayed together in menuconfig etc.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/Kconfig | 50 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 28f0c32fc65a..5a0bde075cae 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -642,6 +642,31 @@ config X86_INTEL_QUARK
 	  Say Y here if you have a Quark based system such as the Arduino
 	  compatible Intel Galileo.
 
+config X86_RDC321X
+	bool "RDC R-321x SoC"
+	depends on X86_32
+	depends on X86_EXTENDED_PLATFORM
+	select M486
+	select X86_REBOOTFIXUPS
+	help
+	  This option is needed for RDC R-321x system-on-chip, also known
+	  as R-8610-(G).
+	  If you don't have one of these chips, you should say N here.
+
+config STA2X11
+	bool "STA2X11 Companion Chip Support"
+	depends on X86_32 && SMP
+	depends on X86_EXTENDED_PLATFORM && PCI
+	select SWIOTLB
+	select MFD_STA2X11
+	select GPIOLIB
+	help
+	  This adds support for boards based on the STA2X11 IO-Hub,
+	  a.k.a. "ConneXt". The chip is used in place of the standard
+	  PC chipset, so all "standard" peripherals are missing. If this
+	  option is selected the kernel will still be able to boot on
+	  standard PC machines.
+
 config X86_INTEL_LPSS
 	bool "Intel Low Power Subsystem Support"
 	depends on X86 && ACPI && PCI
@@ -695,17 +720,6 @@ config IOSF_MBI_DEBUG
 
 	  If you don't require the option or are in doubt, say N.
 
-config X86_RDC321X
-	bool "RDC R-321x SoC"
-	depends on X86_32
-	depends on X86_EXTENDED_PLATFORM
-	select M486
-	select X86_REBOOTFIXUPS
-	help
-	  This option is needed for RDC R-321x system-on-chip, also known
-	  as R-8610-(G).
-	  If you don't have one of these chips, you should say N here.
-
 config X86_SUPPORTS_MEMORY_FAILURE
 	def_bool y
 	# MCE code calls memory_failure():
@@ -715,20 +729,6 @@ config X86_SUPPORTS_MEMORY_FAILURE
 	depends on X86_64 || !SPARSEMEM
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 
-config STA2X11
-	bool "STA2X11 Companion Chip Support"
-	depends on X86_32 && SMP
-	depends on X86_EXTENDED_PLATFORM && PCI
-	select SWIOTLB
-	select MFD_STA2X11
-	select GPIOLIB
-	help
-	  This adds support for boards based on the STA2X11 IO-Hub,
-	  a.k.a. "ConneXt". The chip is used in place of the standard
-	  PC chipset, so all "standard" peripherals are missing. If this
-	  option is selected the kernel will still be able to boot on
-	  standard PC machines.
-
 config X86_32_IRIS
 	tristate "Eurobraille/Iris poweroff module"
 	depends on X86_32
-- 
2.25.1

