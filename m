Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9BC688947
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjBBVxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjBBVxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:53:34 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38D24FC12
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 13:53:32 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 141so2383201pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 13:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0MCj0cFQfLc6l+F+joHSy2ngku9zmGXjqJjBuWdwnqo=;
        b=THonEsNsrNwwDbGNAqMP0NR+bqP30aRxRaMPF9aTDsX2pPqFLiPILalesYfvBvM2gD
         e9miAlWLqAArGKWpKox5efYs1QYJxBieHICLgKW7iip0R14dfj6wlAwQ4oF2dIrH10vc
         FD57j/5KRh7NE3/TpOqv9remFAGIp720df5UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0MCj0cFQfLc6l+F+joHSy2ngku9zmGXjqJjBuWdwnqo=;
        b=nLZaqh2NlR7d1sGQ1L7CaMUJnYDPpI6m6gZCss8tZ/EkrgbkjXS8kG0XFlB0BstFu4
         A41muUxo010cTHNa/yVviJ3LtsF8W4vtDqCfZOUE83HFDAU75TGcdHTJxxSAz0hoQwe4
         4kSYEK1ypikndVZap0oi7WY1Gtmg+TIT+/hBKKomv9wBIIsJAccah8Ej4MgtLjyyrF/i
         uZKfWGJhRN7q+eiBbRt2cAZHBqb8rs9AaFGKNiUtnh1xunZdik7IgQdNT8l3hmQI4Mfj
         Pn9RxlukDWgC0mv77aWI0yUT6qBNON0vSok71SpN0W/Yf3p9m27e+5Crle93xoFo7qG6
         7HZA==
X-Gm-Message-State: AO0yUKUZRkYPHOcYX6cpmEuKLT2B2ortppQ6A/L8CDGJJ7Ocx1esZ23/
        6O8ppEZ7uY0buEp5M+0JkFJVKg==
X-Google-Smtp-Source: AK7set+QJxtFkEvINMG9wGwgRXKwCl9zJpvCZ3GD62ypGcPQW9TH9CoPBFotF6iO9/XlA9iDu4OdOA==
X-Received: by 2002:a62:4ecc:0:b0:593:c41e:474 with SMTP id c195-20020a624ecc000000b00593c41e0474mr6856838pfb.9.1675374812326;
        Thu, 02 Feb 2023 13:53:32 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:11a:201:4d8f:351:ff3d:e8eb])
        by smtp.gmail.com with ESMTPSA id j22-20020a62b616000000b00594235980e4sm147447pff.181.2023.02.02.13.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 13:53:31 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2] phy: qcom-qmp: Introduce Kconfig symbols for discrete drivers
Date:   Thu,  2 Feb 2023 13:53:29 -0800
Message-Id: <20230202215330.2152726-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a config option for each QMP PHY driver now that the QMP PHY
mega-driver has been split up into different modules. This allows kernel
configurators to limit the binary size of the kernel by only compiling
in the QMP PHY driver that they need.

Leave the old config QCOM_QMP in place and make it into a menuconfig so
that 'make olddefconfig' continues to work. Furthermore, set the default
of the new Kconfig symbols to be QCOM_QMP so that the transition is
smooth.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1 (https://lore.kernel.org/r/20230114000910.1256462-1-swboyd@chromium.org):
 * Pick up review tags
 * Update commit text to better reflect reality
 * Rebase to phy tree's next branch

 drivers/phy/qualcomm/Kconfig  | 50 ++++++++++++++++++++++++++++++++---
 drivers/phy/qualcomm/Makefile | 12 ++++-----
 2 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index eb9ddc685b38..62cf51aab1b8 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -50,14 +50,56 @@ config PHY_QCOM_PCIE2
 	  Enable this to support the Qualcomm PCIe PHY, used with the Synopsys
 	  based PCIe controller.
 
-config PHY_QCOM_QMP
-	tristate "Qualcomm QMP PHY Driver"
+menuconfig PHY_QCOM_QMP
+	tristate "Qualcomm QMP PHY Drivers"
 	depends on OF && COMMON_CLK && (ARCH_QCOM || COMPILE_TEST)
+
+if PHY_QCOM_QMP
+
+config PHY_QCOM_QMP_COMBO
+	tristate "Qualcomm QMP Combo PHY Driver"
+	default PHY_QCOM_QMP
 	select GENERIC_PHY
 	select MFD_SYSCON
 	help
-	  Enable this to support the QMP PHY transceiver that is used
-	  with controllers such as PCIe, UFS, and USB on Qualcomm chips.
+	  Enable this to support the QMP Combo PHY transceiver that is used
+	  with USB3 and DisplayPort controllers on Qualcomm chips.
+
+config PHY_QCOM_QMP_PCIE
+	tristate "Qualcomm QMP PCIe PHY Driver"
+	depends on PCI || COMPILE_TEST
+	select GENERIC_PHY
+	default PHY_QCOM_QMP
+	help
+	  Enable this to support the QMP PCIe PHY transceiver that is used
+	  with PCIe controllers on Qualcomm chips.
+
+config PHY_QCOM_QMP_PCIE_8996
+	tristate "Qualcomm QMP PCIe 8996 PHY Driver"
+	depends on PCI || COMPILE_TEST
+	select GENERIC_PHY
+	default PHY_QCOM_QMP
+	help
+	  Enable this to support the QMP PCIe PHY transceiver that is used
+	  with PCIe controllers on Qualcomm msm8996 chips.
+
+config PHY_QCOM_QMP_UFS
+	tristate "Qualcomm QMP UFS PHY Driver"
+	select GENERIC_PHY
+	default PHY_QCOM_QMP
+	help
+	  Enable this to support the QMP UFS PHY transceiver that is used
+	  with UFS controllers on Qualcomm chips.
+
+config PHY_QCOM_QMP_USB
+	tristate "Qualcomm QMP USB PHY Driver"
+	select GENERIC_PHY
+	default PHY_QCOM_QMP
+	help
+	  Enable this to support the QMP USB PHY transceiver that is used
+	  with USB3 controllers on Qualcomm chips.
+
+endif # PHY_QCOM_QMP
 
 config PHY_QCOM_QUSB2
 	tristate "Qualcomm QUSB2 PHY Driver"
diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
index 65f6c30a3e93..79dd4e507961 100644
--- a/drivers/phy/qualcomm/Makefile
+++ b/drivers/phy/qualcomm/Makefile
@@ -5,12 +5,12 @@ obj-$(CONFIG_PHY_QCOM_EDP)		+= phy-qcom-edp.o
 obj-$(CONFIG_PHY_QCOM_IPQ4019_USB)	+= phy-qcom-ipq4019-usb.o
 obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
 obj-$(CONFIG_PHY_QCOM_PCIE2)		+= phy-qcom-pcie2.o
-obj-$(CONFIG_PHY_QCOM_QMP)		+= \
-	phy-qcom-qmp-combo.o \
-	phy-qcom-qmp-pcie.o \
-	phy-qcom-qmp-pcie-msm8996.o \
-	phy-qcom-qmp-ufs.o \
-	phy-qcom-qmp-usb.o
+
+obj-$(CONFIG_PHY_QCOM_QMP_COMBO)	+= phy-qcom-qmp-combo.o
+obj-$(CONFIG_PHY_QCOM_QMP_PCIE)		+= phy-qcom-qmp-pcie.o
+obj-$(CONFIG_PHY_QCOM_QMP_PCIE_8996)	+= phy-qcom-qmp-pcie-msm8996.o
+obj-$(CONFIG_PHY_QCOM_QMP_UFS)		+= phy-qcom-qmp-ufs.o
+obj-$(CONFIG_PHY_QCOM_QMP_USB)		+= phy-qcom-qmp-usb.o
 
 obj-$(CONFIG_PHY_QCOM_QUSB2)		+= phy-qcom-qusb2.o
 obj-$(CONFIG_PHY_QCOM_USB_HS) 		+= phy-qcom-usb-hs.o

base-commit: b41499a1085b9278d73c6132d49849a6a86a81bc
-- 
https://chromeos.dev

