Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B396E7DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjDSPO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbjDSPNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:13:55 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C66FA;
        Wed, 19 Apr 2023 08:13:41 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6a5f7d10dd5so1481680a34.0;
        Wed, 19 Apr 2023 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681917220; x=1684509220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERiuGLSSLt14Zm3/7WEsnxh0ydwhBcPd1KCXT7ReQ90=;
        b=ira0HYJhcP5Y2+/1OMa2uJ3iYofcyda0Pcxvh5pY+1rb8HHarN4m9wLyLHOAWBiRqb
         C86ej8E1afVWP4f8yyqFZM6P23UVzuncgPJOk/GUi6N1TOsCV36ATpb5VfJE5D1EAvJ3
         O6F4/vjY3frumyxx2twjF8w9kiYPoZaX9zV8tPc5I8Bls3KLNmHvZ4IEkEVvh5hZC5vn
         dFLI0GCaOn8RGatgcOe4RgoDZvMDbexmAWLh/GfdAE2E8EqPjCDAvchrpZhARAv/woz5
         tkPXyPW1+iFV58hdAjN2olMWEGQpmbfJ+VkgbCtnoMEfn/uTa0FFyz6mAYSUIvuKPprM
         /xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681917220; x=1684509220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERiuGLSSLt14Zm3/7WEsnxh0ydwhBcPd1KCXT7ReQ90=;
        b=Y5DJuiW5VEbfDSBFd7K0ffWLRfIKDZGTPUX/uIMDITHQiBF66Rl3mkcy9vyYAzTFTP
         aPj/s3Rt79SPWy5ifYkXaWoOM/1ddXsn+h8QiTrSYilXz+w74WwwYevVrHHNXeMsQY/U
         yHzXNUfKW/7dgnkLMrDaQf1p+pBg+vKyYPVcBUNnM+1OzaNTrPuhBxhTePLFixmivaV8
         layh6qwn4dmthNrr6TpAFIYcuCfHu2zovGpbot72t60q2VhJ6AG3xpYPL2MfecEuhZhA
         Ej7J4fDA09KLHMoAsbZJVHeKaMufQimT5eUnMcY/BA8TGu+rCQawUhoj0xrJP4GKU/FZ
         gmkA==
X-Gm-Message-State: AAQBX9enN47IXEKz2aMO61AapcWRMWwp4wlVqDfhp4xz1nnBKFA7miCr
        Xe9WBZs+kcnLdsnVDmA14MU=
X-Google-Smtp-Source: AKy350aRb2tBYVAj1ac6yl800KVlFsYoST8mE++/HNokSAx1c8Indo/uHGci2C6+vVKeMD6ue6r4Ow==
X-Received: by 2002:a05:6830:1206:b0:6a5:d98d:e943 with SMTP id r6-20020a056830120600b006a5d98de943mr2914726otp.29.1681917220568;
        Wed, 19 Apr 2023 08:13:40 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:e175:6963:338:7453])
        by smtp.gmail.com with ESMTPSA id f17-20020a056830205100b00690e990e61asm4308842otp.14.2023.04.19.08.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 08:13:40 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v10 13/14] HP BIOSCFG driver  - Makefile
Date:   Wed, 19 Apr 2023 10:13:20 -0500
Message-Id: <20230419151321.6167-14-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419151321.6167-1-jorge.lopez2@hp.com>
References: <20230419151321.6167-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP BIOS Configuration driver purpose is to provide a driver supporting
the latest sysfs class firmware attributes framework allowing the user
to change BIOS settings and security solutions on HP Inc.’s commercial
notebooks.

Many features of HP Commercial notebooks can be managed using Windows
Management Instrumentation (WMI). WMI is an implementation of Web-Based
Enterprise Management (WBEM) that provides a standards-based interface
for changing and monitoring system settings. HP BIOSCFG driver provides
a native Linux solution and the exposed features facilitates the
migration to Linux environments.

The Linux security features to be provided in hp-bioscfg driver enables
managing the BIOS settings and security solutions via sysfs, a virtual
filesystem that can be used by user-mode applications. The new
documentation cover HP-specific firmware sysfs attributes such Secure
Platform Management and Sure Start. Each section provides security
feature description and identifies sysfs directories and files exposed
by the driver.

Many HP Commercial notebooks include a feature called Secure Platform
Management (SPM), which replaces older password-based BIOS settings
management with public key cryptography. PC secure product management
begins when a target system is provisioned with cryptographic keys
that are used to ensure the integrity of communications between system
management utilities and the BIOS.

HP Commercial notebooks have several BIOS settings that control its
behaviour and capabilities, many of which are related to security.
To prevent unauthorized changes to these settings, the system can
be configured to use a cryptographic signature-based authorization
string that the BIOS will use to verify authorization to modify the
setting.

Linux Security components are under development and not published yet.
The only linux component is the driver (hp bioscfg) at this time.
Other published security components are under Windows.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 drivers/platform/x86/hp/Kconfig             | 16 ++++++++++++++++
 drivers/platform/x86/hp/Makefile            |  1 +
 drivers/platform/x86/hp/hp-bioscfg/Makefile | 13 +++++++++++++
 3 files changed, 30 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/Makefile

diff --git a/drivers/platform/x86/hp/Kconfig b/drivers/platform/x86/hp/Kconfig
index ae165955311c..7fef4f12e498 100644
--- a/drivers/platform/x86/hp/Kconfig
+++ b/drivers/platform/x86/hp/Kconfig
@@ -60,4 +60,20 @@ config TC1100_WMI
 	  This is a driver for the WMI extensions (wireless and bluetooth power
 	  control) of the HP Compaq TC1100 tablet.
 
+config HP_BIOSCFG
+	tristate "HP BIOS Configuration Driver"
+	default m
+	depends on ACPI_WMI
+	select NLS
+	select FW_ATTR_CLASS
+	help
+	  This driver enables administrators to securely manage BIOS settings
+	  using digital certificates and public-key cryptography that eliminate
+	  the need for passwords for both remote and local management. It supports
+	  changing BIOS settings on many HP machines from 2018 and newer without
+	  the use of any additional software.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called hp-bioscfg.
+
 endif # X86_PLATFORM_DRIVERS_HP
diff --git a/drivers/platform/x86/hp/Makefile b/drivers/platform/x86/hp/Makefile
index db1eed4cd7c7..e4f908a61acf 100644
--- a/drivers/platform/x86/hp/Makefile
+++ b/drivers/platform/x86/hp/Makefile
@@ -8,3 +8,4 @@
 obj-$(CONFIG_HP_ACCEL)		+= hp_accel.o
 obj-$(CONFIG_HP_WMI)		+= hp-wmi.o
 obj-$(CONFIG_TC1100_WMI)	+= tc1100-wmi.o
+obj-$(CONFIG_HP_BIOSCFG)	+= hp-bioscfg/
diff --git a/drivers/platform/x86/hp/hp-bioscfg/Makefile b/drivers/platform/x86/hp/hp-bioscfg/Makefile
new file mode 100644
index 000000000000..529eba6fa47f
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/Makefile
@@ -0,0 +1,13 @@
+obj-$(CONFIG_HP_BIOSCFG) := hp-bioscfg.o
+
+hp-bioscfg-objs := bioscfg.o	\
+	enum-attributes.o	\
+	int-attributes.o	\
+	string-attributes.o	\
+	passwdobj-attributes.o	\
+	biosattr-interface.o	\
+	passwdattr-interface.o	\
+	ordered-attributes.o	\
+	surestart-attributes.o	\
+	spmobj-attributes.o
+
-- 
2.34.1

