Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8A16F7D20
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjEEGlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjEEGlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:41:12 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C72816090
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 23:41:00 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aafa03f541so13471965ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 23:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683268860; x=1685860860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxVNud7lt4L0J09lKeSHXN8bCCY+H6qtBEVB86DAgHc=;
        b=pG6cxxOnT7ZzHNZFW7wk2DaYUQZHzcSCFunQQPo1u4M9sGnLJ9ePXWeC80ZGs0t5U5
         QUt6aJGe3INKw+y44Jna0AjaeZRel0mXf3bATixfLlbSslTSvG8DF4SpSdwGn69oL/UB
         jxeioA5ipghNNOFiJ/w/ZWgJFJsg4ET2wEpyTP/9TDd9mx88GuN97wTkN0eA1naBsco8
         RZ44f4q5BnPS0F4YRMJ7DpdBqVnor6pojKPjgPaadgBxsyKTsTPucqQI5lh4LO7IEZ2H
         JwNrJMpgWiiWmTQq/UqXEusMLqespijhgJZn9wi100HVzePg+jwbMIbYhaRwpDQ3lRx/
         2Nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683268860; x=1685860860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxVNud7lt4L0J09lKeSHXN8bCCY+H6qtBEVB86DAgHc=;
        b=a2fxeDSsm23Lr84gQRMGq/JjKz/b5YF+fOZQrvNyvcN4TaH2lBsITr1UvAJ1704+qW
         Uo89tWZVaPohSjOqj1FlDcpeerRN+2E1mkaVtzHHpe+iyH29Xnw1X4pKrvGCRDhoaA1n
         3dUuvsc9Q0tF+KJCKS3SGQmWkCApOf/CeBZqNnR8lODf1/Mh52PqB0M2fGbkLK8NtXT3
         cpiq9M1JgULHQT25vgc+GBdRWT3PEOx8/diytqKUgGcq32Ecu48aRfpmZFJQtEI8Dxhv
         7EpuKSM1PbtsXIOkgHzdCQ++EJS4+WE+PILOy0EkUjEtfjhbtATwHfKlJWapF5D/zdTc
         O2+A==
X-Gm-Message-State: AC+VfDydSR+tZZuY4Pq4+UQBmaIc4LCD1E8SmzVYxU/8R8HvTch30Jc5
        m/18R+G9TfF10obElM7+efOTKw==
X-Google-Smtp-Source: ACHHUZ5buzCzQbEwgXi0+mHxszj8GDmkaw7oUkfsSz0xQdw9m2Od5FTxCnXJoUd1l+bonjHp+F5rjQ==
X-Received: by 2002:a17:902:d304:b0:1a9:21bc:65f8 with SMTP id b4-20020a170902d30400b001a921bc65f8mr436390plc.11.1683268860246;
        Thu, 04 May 2023 23:41:00 -0700 (PDT)
Received: from localhost.localdomain ([223.233.65.180])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902848400b001ab0b2dad2fsm816251plo.211.2023.05.04.23.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 23:40:59 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org
Subject: [PATCH v4 3/5] usb: misc: eud: Add driver support for SM6115 / SM4250
Date:   Fri,  5 May 2023 12:10:37 +0530
Message-Id: <20230505064039.1630025-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230505064039.1630025-1-bhupesh.sharma@linaro.org>
References: <20230505064039.1630025-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SM6115 / SM4250 SoC EUD support in qcom_eud driver.

On some SoCs (like the SM6115 / SM4250 SoC), the mode manager
needs to be accessed only via the secure world (through 'scm'
calls).

Also, the enable bit inside 'tcsr_check_reg' needs to be set
first to set the eud in 'enable' mode on these SoCs.

Since this difference comes from how the firmware is configured, so
the driver now relies on the presence of an extra boolean DT property
to identify if secure access is needed.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/usb/misc/Kconfig    |  1 +
 drivers/usb/misc/qcom_eud.c | 74 +++++++++++++++++++++++++++++++++----
 2 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 99b15b77dfd5..fe1b5fec1dfc 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -147,6 +147,7 @@ config USB_APPLEDISPLAY
 config USB_QCOM_EUD
 	tristate "QCOM Embedded USB Debugger(EUD) Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
+	select QCOM_SCM
 	select USB_ROLE_SWITCH
 	help
 	  This module enables support for Qualcomm Technologies, Inc.
diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
index b7f13df00764..18a2dee3b4b9 100644
--- a/drivers/usb/misc/qcom_eud.c
+++ b/drivers/usb/misc/qcom_eud.c
@@ -5,12 +5,14 @@
 
 #include <linux/bitops.h>
 #include <linux/err.h>
+#include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
@@ -22,23 +24,35 @@
 #define EUD_REG_VBUS_INT_CLR	0x0080
 #define EUD_REG_CSR_EUD_EN	0x1014
 #define EUD_REG_SW_ATTACH_DET	0x1018
-#define EUD_REG_EUD_EN2        0x0000
+#define EUD_REG_EUD_EN2		0x0000
 
 #define EUD_ENABLE		BIT(0)
-#define EUD_INT_PET_EUD	BIT(0)
+#define EUD_INT_PET_EUD		BIT(0)
 #define EUD_INT_VBUS		BIT(2)
 #define EUD_INT_SAFE_MODE	BIT(4)
 #define EUD_INT_ALL		(EUD_INT_VBUS | EUD_INT_SAFE_MODE)
 
+#define EUD_EN2_SECURE_EN	BIT(0)
+#define EUD_EN2_NONSECURE_EN	(1)
+#define EUD_EN2_DISABLE		(0)
+#define TCSR_CHECK_EN		BIT(0)
+
+struct eud_soc_cfg {
+	u32 tcsr_check_offset;
+};
+
 struct eud_chip {
 	struct device			*dev;
 	struct usb_role_switch		*role_sw;
+	const struct eud_soc_cfg	*eud_cfg;
 	void __iomem			*base;
 	void __iomem			*mode_mgr;
 	unsigned int			int_status;
 	int				irq;
 	bool				enabled;
 	bool				usb_attached;
+	bool				secure_mode_enable;
+	phys_addr_t			secure_mode_mgr;
 };
 
 static int enable_eud(struct eud_chip *priv)
@@ -46,7 +60,11 @@ static int enable_eud(struct eud_chip *priv)
 	writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
 	writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
 			priv->base + EUD_REG_INT1_EN_MASK);
-	writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
+
+	if (priv->secure_mode_mgr)
+		qcom_scm_io_writel(priv->secure_mode_mgr + EUD_REG_EUD_EN2, EUD_EN2_SECURE_EN);
+	else
+		writel(EUD_EN2_NONSECURE_EN, priv->mode_mgr + EUD_REG_EUD_EN2);
 
 	return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
 }
@@ -54,7 +72,11 @@ static int enable_eud(struct eud_chip *priv)
 static void disable_eud(struct eud_chip *priv)
 {
 	writel(0, priv->base + EUD_REG_CSR_EUD_EN);
-	writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
+
+	if (priv->secure_mode_mgr)
+		qcom_scm_io_writel(priv->secure_mode_mgr + EUD_REG_EUD_EN2, EUD_EN2_DISABLE);
+	else
+		writel(EUD_EN2_DISABLE, priv->mode_mgr + EUD_REG_EUD_EN2);
 }
 
 static ssize_t enable_show(struct device *dev,
@@ -178,6 +200,8 @@ static void eud_role_switch_release(void *data)
 static int eud_probe(struct platform_device *pdev)
 {
 	struct eud_chip *chip;
+	struct resource *res;
+	phys_addr_t tcsr_base, tcsr_check;
 	int ret;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
@@ -200,9 +224,40 @@ static int eud_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->base))
 		return PTR_ERR(chip->base);
 
-	chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(chip->mode_mgr))
-		return PTR_ERR(chip->mode_mgr);
+	chip->secure_mode_enable = of_property_read_bool(chip->dev->of_node,
+						"qcom,secure-mode-enable");
+	/*
+	 * EUD block on a few Qualcomm SoCs need secure register access.
+	 * Check for the same.
+	 */
+	if (chip->secure_mode_enable) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!res)
+			return dev_err_probe(chip->dev, -ENODEV,
+					     "failed to get secure_mode_mgr reg base\n");
+
+		chip->secure_mode_mgr = res->start;
+	} else {
+		chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(chip->mode_mgr))
+			return PTR_ERR(chip->mode_mgr);
+	}
+
+	/* Check for any SoC specific config data */
+	chip->eud_cfg = of_device_get_match_data(&pdev->dev);
+	if (chip->eud_cfg) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "tcsr-base");
+		if (!res)
+			return dev_err_probe(chip->dev, -ENODEV,
+					     "failed to get tcsr reg base\n");
+
+		tcsr_base = res->start;
+		tcsr_check = tcsr_base + chip->eud_cfg->tcsr_check_offset;
+
+		ret = qcom_scm_io_writel(tcsr_check, TCSR_CHECK_EN);
+		if (ret)
+			return dev_err_probe(chip->dev, ret, "failed to write tcsr check reg\n");
+	}
 
 	chip->irq = platform_get_irq(pdev, 0);
 	ret = devm_request_threaded_irq(&pdev->dev, chip->irq, handle_eud_irq,
@@ -230,8 +285,13 @@ static int eud_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct eud_soc_cfg sm6115_eud_cfg = {
+	.tcsr_check_offset = 0x25018,
+};
+
 static const struct of_device_id eud_dt_match[] = {
 	{ .compatible = "qcom,sc7280-eud" },
+	{ .compatible = "qcom,sm6115-eud", .data = &sm6115_eud_cfg },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, eud_dt_match);
-- 
2.38.1

