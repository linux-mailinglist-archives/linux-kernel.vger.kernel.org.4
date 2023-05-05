Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9B56F8C28
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 00:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjEEWCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 18:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjEEWBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 18:01:39 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D6E61B0;
        Fri,  5 May 2023 15:01:01 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6a5d9853d97so914812a34.2;
        Fri, 05 May 2023 15:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683324061; x=1685916061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6CoM5GMH444ZskGEUrIXRG45UOSkoRvxV3Ug2BdYBw=;
        b=YF9ij/GHfEor/Y9uAWVXhTzeT88nAwEszjIgvNgmlosh2iGty/clNs3CEXdLl7hcWB
         iN/bbnf3ZYje+1jKueDlEdmwnnbJD1HVHmRJXj5rBKTVJQi0lEQAPTV1BC4ax3bQLlau
         LAgKFvC0gqwd5sTDoecasRE7CoeiYMkKxmn6Wr3lgsEmgK3kR9URrJqciH+8EumTCfsL
         vzfpvH1pbzCIycDlav1xQJASv3IeilcNSDqbTcx0QiSE9TEf+S2Wthz2GRXWBydKUUdr
         3lBFhB2+yKFQczp3sQ0jdOjd1/uSuCXFwY4CES/plgQ7x0yd0wHvA3aLc4qujYdbwzIP
         GuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683324061; x=1685916061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6CoM5GMH444ZskGEUrIXRG45UOSkoRvxV3Ug2BdYBw=;
        b=D5sAi5eFzQP+vPGpNWWB8nd9xqVw3sJyGE0gGqDfR0qED6upGMiflxnczXe43+TIIn
         vum/t8HHiyfmgxbi7YAQzhthUXwG4X47IPttT2YXrFl/SWztjiftoFVqU9JB5mCHrYF4
         +2i6rfUmk/6m9ssDUMbJnB9KwNgEFyFP19jzymOpmRLHVsOMwsPHrcsj5qsP+/1IUbQM
         qQ0+xqiTyn6qtgyGf35Koqt2EZLEnSc1P9cI/YcWP8en0OYnpfCUQ0Wzm4lPF4uiIVGA
         CHcLphRWQn2usvnPrgv2hEJIFroNlsEnps59GksPE68MHDdzRfSdPuWZYQjaPBPOOzk5
         Rg+g==
X-Gm-Message-State: AC+VfDzZlVv2DZzDxGWaSV26oKnPqfUdJNX8JnhtvYSGSt5I3yHEGC17
        jCc/jKBi3N68QEgLUqRo3Zlt2L2WKwY=
X-Google-Smtp-Source: ACHHUZ5uNb1XV5RUKcEts5pVa2zDYNle9SZ5JQJavKJVbNJH2L6WbGICS6uXFHzP81HWRjvveq9Qzg==
X-Received: by 2002:a9d:7350:0:b0:6a7:cab0:9802 with SMTP id l16-20020a9d7350000000b006a7cab09802mr1340402otk.17.1683324060884;
        Fri, 05 May 2023 15:01:00 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:90cc:2e0a:7522:8ecc])
        by smtp.gmail.com with ESMTPSA id w15-20020a056830060f00b006a61bef7968sm1359547oti.53.2023.05.05.15.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 15:01:00 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v12 12/13] HP BIOSCFG driver  - Makefile
Date:   Fri,  5 May 2023 17:00:42 -0500
Message-Id: <20230505220043.39036-13-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505220043.39036-1-jorge.lopez2@hp.com>
References: <20230505220043.39036-1-jorge.lopez2@hp.com>
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
 drivers/platform/x86/hp/hp-bioscfg/Makefile | 12 ++++++++++++
 3 files changed, 29 insertions(+)
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
index 000000000000..78a347298873
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/Makefile
@@ -0,0 +1,12 @@
+obj-$(CONFIG_HP_BIOSCFG) := hp-bioscfg.o
+
+hp-bioscfg-objs := bioscfg.o	\
+	enum-attributes.o	\
+	int-attributes.o	\
+	string-attributes.o	\
+	passwdobj-attributes.o	\
+	biosattr-interface.o	\
+	ordered-attributes.o	\
+	surestart-attributes.o	\
+	spmobj-attributes.o
+
-- 
2.34.1

