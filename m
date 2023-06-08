Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F71672851B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjFHQeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbjFHQdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:33:47 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1991D30C7;
        Thu,  8 Jun 2023 09:33:38 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-39a505b901dso550162b6e.0;
        Thu, 08 Jun 2023 09:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686242016; x=1688834016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NY+E29CzUH2+Eday2465qyVk0rRgPqFm8fhU0w76zGg=;
        b=Kwc4L5Oo+F+boN0oDcSFhvPtVDTaNNaizXqaqS07+Ye7FxEhXPYM4sA4gSbO05j/aH
         EeKLbTYT+WXyITnjwBSp/4Bw5kEsN2IqWZIM2Mr7lNEwL8e5xvpjiU6eIWwpVGy06po4
         VW6m/CbV5mvB8783bOW4MAYBGc4CNrW9W32QzodYSxJCtB+jLqOGu2xqjVRCpRNjYnxO
         8rXv8vyQqOfCPxqUCMEkM0AQDXHWv99mM2xMtILhQoDR4WQ3okKK58Wq9iguGVCjLfZ4
         f+aAmQ8zQ93UftOjNvguB6IkQ2/E5n2ix530MHx8rSgrRCq96ke/+pXuEI6+ZWGE8Ypr
         NRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242016; x=1688834016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NY+E29CzUH2+Eday2465qyVk0rRgPqFm8fhU0w76zGg=;
        b=GwDTJU/qQtVXPh9lAYaH8/q2He9JwiSmkuRFO9GHJjlX3VWepcVVf4KDtAb4ML5OH1
         Npq868U3xFUkhaae6pU7qtesO+8X2bOD6wYMGA8j/wXS/nAvxBRR1IrWWNsE9HoJ7Xwj
         BdWiHJud7qbGpQ5ISWkqZhhcW7tzij21ktRvkXRhx8YCrasxx4I7qKfmjcYx5RbrQ0/p
         QuwHXO5DJfWh7cgJCVaG5Pp5HMLGVtDDxw0+OzaoCOaWp0cAajhX9RDKlpWBh/hLnQpC
         JMlVGGUOIDXI8cPykErlmKb43EqCJewArhyxd6+jS/lw93DyCkyRGQFbiuDVbskEqDHG
         hrAg==
X-Gm-Message-State: AC+VfDye30dmPxZKJ2EDPJNxL2ds9uwVVezJ/ZO+o+npuKSXRAPldeuD
        +neRO899f5lWqVcMRszq7wbogLk8jBQ=
X-Google-Smtp-Source: ACHHUZ6BXVM/mO6CEjrwN7PQeOLYL8iy2QhqLZlVIQTP+cLnx+zXOi6P0+GY6Hrjo8DRqVlfr5D8kA==
X-Received: by 2002:aca:650c:0:b0:398:6292:23f5 with SMTP id m12-20020aca650c000000b00398629223f5mr8658021oim.53.1686242016338;
        Thu, 08 Jun 2023 09:33:36 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:a60f:2d4d:e52b:2fca])
        by smtp.gmail.com with ESMTPSA id e10-20020acab50a000000b003942036439dsm577500oif.46.2023.06.08.09.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:33:36 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v17 12/13] hp-bioscfg: Makefile
Date:   Thu,  8 Jun 2023 11:33:18 -0500
Message-Id: <20230608163319.18934-13-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608163319.18934-1-jorge.lopez2@hp.com>
References: <20230608163319.18934-1-jorge.lopez2@hp.com>
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

Add Makefile and Kconfig to build hp-bioscfg.

HP BIOS Configuration driver purpose is to provide a driver supporting
the latest sysfs class firmware attributes framework allowing the user
to change BIOS settings and security solutions on HP Inc.’s commercial
notebooks.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---

Based on the latest platform-drivers-x86.git/for-next
---
 drivers/platform/x86/hp/Kconfig             | 16 ++++++++++++++++
 drivers/platform/x86/hp/Makefile            |  1 +
 drivers/platform/x86/hp/hp-bioscfg/Makefile | 11 +++++++++++
 3 files changed, 28 insertions(+)
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
index 000000000000..67be0d917753
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/Makefile
@@ -0,0 +1,11 @@
+obj-$(CONFIG_HP_BIOSCFG) := hp-bioscfg.o
+
+hp-bioscfg-objs := bioscfg.o	\
+	biosattr-interface.o	\
+	enum-attributes.o	\
+	int-attributes.o	\
+	order-list-attributes.o	\
+	passwdobj-attributes.o	\
+	spmobj-attributes.o	\
+	string-attributes.o	\
+	surestart-attributes.o
-- 
2.34.1

