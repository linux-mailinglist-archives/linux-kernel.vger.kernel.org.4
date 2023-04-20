Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CA76E9A10
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjDTQ4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjDTQza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:55:30 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33424C0A;
        Thu, 20 Apr 2023 09:55:12 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-38be107e467so366903b6e.2;
        Thu, 20 Apr 2023 09:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682009712; x=1684601712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERiuGLSSLt14Zm3/7WEsnxh0ydwhBcPd1KCXT7ReQ90=;
        b=DjBAOGFRa7uMiMhUhFUB8PPl8ch/83lLQzh/4ecUdFZlljeiCD9XUzsv++VDNrX4D8
         oGQrdJdYTgzo7lmIAQhX3vFm/UT/O/96jU44MtiD+EXEzdUrmpjgS+qP7WO//S7BaII8
         95e4bc2yzzMM4hVztyQvzkTUZWIxuq1a0qCXR8QoUUA/4bZZEOYbfht4SznSg+XoddzM
         HfnmrwWbVcuLa1Q8scoPqwDv4DBtidZfnqlQVg7dv3CTH6UEiorvDtQjJBnCUey1lDZe
         auH74v6n2sqUZhdwFHt6iTchCmF0hTbKVfvtCJ9SFgtY9v3/DIBTahXIl7D9sa1QMsjS
         1VxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682009712; x=1684601712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERiuGLSSLt14Zm3/7WEsnxh0ydwhBcPd1KCXT7ReQ90=;
        b=cqCaAVgDzP+aBsGSOzJCDJrHB2mymb2A1uF+oiyjPe/70/rgfF1OJvfy7kuQgWVACx
         5zdjUv8gV+F8rSv0dfGm8rm1jenpVxaY+8jfW1e4r8b7QZp/vE/NiX/0hn5jyNH/31su
         2tK6rVQVEkE4RoZe9mbKrmR6hQZfUqKeu1TjKOdY6JXKygYbHbv01qtCvVBVzx+L4Bws
         HkSx1MxjA3+/EG0Gi4nnHO/4yrUF9gn3X/v/LpdzGZuS/xA2mb/ar2Y9m0LmgBujVhHB
         3KEu/PcN0AuydQvhUdB5fB6K6BTawQw9pykfpxu3olXEBCep9g0sKeBK+EOYyiZHm9Zl
         M+bQ==
X-Gm-Message-State: AAQBX9eBBF/ApIBCDXkTnUlG7wuMWlt6HrtLdXG0/9uzHN37XQvTE1wT
        Sfyzk57KfnDePYYTDalo0qDdmz6XmPw=
X-Google-Smtp-Source: AKy350aoddBkpZ+/HbSqG5gtSmwAvwFJiWs+U53YeExoxdWXSankEjLSBlGr0GmjcQpCeJx5Nid5wg==
X-Received: by 2002:a05:6808:130e:b0:386:f961:4287 with SMTP id y14-20020a056808130e00b00386f9614287mr1446590oiv.18.1682009711982;
        Thu, 20 Apr 2023 09:55:11 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:d090:9746:e449:eb46])
        by smtp.gmail.com with ESMTPSA id s129-20020a4a5187000000b005252e5b6604sm791913ooa.36.2023.04.20.09.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:55:11 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v11 13/14] HP BIOSCFG driver  - Makefile
Date:   Thu, 20 Apr 2023 11:54:53 -0500
Message-Id: <20230420165454.9517-14-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420165454.9517-1-jorge.lopez2@hp.com>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
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

