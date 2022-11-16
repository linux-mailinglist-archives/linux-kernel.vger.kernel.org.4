Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DB462BD1D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiKPMIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbiKPMHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:07:31 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3EC6337
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:02:03 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so2709855wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wX9qpNkrbnl5A0QhGpEqRLSUx0C8wD+o3edhdmvnluM=;
        b=X40gSJiG3IRXKMxdfNu64IAElGZXzTxaFulbYFf+InWSOJv7269RzS3C3Pt8kLHJw3
         XMUfobA9hUAbr3W0PyJuiGR6zuvmBkB0bJdN5ZUaixjKhe3V4oGNUXIxOg4hCsvH4wp7
         tFz7eZP4oZNpNaJ5B5FFM54+kejimysLd6rPGTRMJg+7ialZ87FNLvN2XmKMr7a6IThs
         /6N4UHjf+eV+meRWS0nStvBFTqwsKsqs90fTbMTNbcd5nPxYPFgJ+ZlW9UzbyMRwQzfD
         jE+k0ur71qKBydDzCCHj7rGjYvkuSgy2MAV02aLC13moG+m+ExFrjroiM8c5tcMexSf3
         lSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wX9qpNkrbnl5A0QhGpEqRLSUx0C8wD+o3edhdmvnluM=;
        b=vLMdobw+bgTU5hEyRJgVt2DxD3bOKGckvXL2vp3rTRBtBU417tmJRcr2ttW/d/l21x
         LOfheTOgE7cr2374vPsMi8zreSXe1CatIIhNQ4L4ZdXxi8Sk73iEkcT1lLDaRydgDZQP
         zC7cd+RuZLsiWK/YdAf8qxKRD2sCUY6vvZUsWJlHsMllGCL6qa3ZyXnDbmZPUogoSkP4
         juJ7p5N79lP9vgReuEdrlGa20hNQ7+C/P886iE3Bz/D3vErTEdFlRx8S/9kNHeEc5K6P
         TbEAoN5mgSzN6Rh9AOKmGJG2W7hpK1rQmtRopYVG5rAtkqmWBzvZHAFKOz9TiDKFEA07
         JGSw==
X-Gm-Message-State: ANoB5pkdNum3mS3e9eGL1b2BDbaByYM2cN2P1UC6SaHOh5qyKjCyUMf8
        ZVKAlPjbastE1xt+JOAvx7cjLw==
X-Google-Smtp-Source: AA0mqf4ut1SjxsowApW3BQJOKuCOmRPs+VG5d0vAPEjv59+mODMEbR6SpXK3cuAuOVCQ8X5ziZ5PRQ==
X-Received: by 2002:a05:600c:1c84:b0:3cf:e137:b31d with SMTP id k4-20020a05600c1c8400b003cfe137b31dmr1873471wms.205.1668600121605;
        Wed, 16 Nov 2022 04:02:01 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b002206203ed3dsm15120109wrx.29.2022.11.16.04.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:02:01 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH 01/10] phy: qcom-qmp: qserdes-com: Add v6 register offsets
Date:   Wed, 16 Nov 2022 14:01:48 +0200
Message-Id: <20221116120157.2706810-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116120157.2706810-1-abel.vesa@linaro.org>
References: <20221116120157.2706810-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new SM8550 SoC bumps up the HW version of QMP phy to v6 for USB,
UFS and PCIE g3x2, and v6.20 for PCIE g4x2. Add the new offsets to
each table dedicated file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h   | 15 ++++
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h    | 23 ++++++
 .../phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h    | 31 ++++++++
 .../phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h    | 31 ++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h    | 16 ++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h | 18 +++++
 .../qualcomm/phy-qcom-qmp-qserdes-com-v6.h    | 75 +++++++++++++++++++
 .../phy-qcom-qmp-qserdes-ln-shrd-v6.h         | 32 ++++++++
 .../phy-qcom-qmp-qserdes-txrx-ufs-v6.h        | 30 ++++++++
 .../qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h   | 68 +++++++++++++++++
 .../phy-qcom-qmp-qserdes-txrx-v6_20.h         | 45 +++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           | 13 ++++
 12 files changed, 397 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-ln-shrd-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
new file mode 100644
index 000000000000..b00c47e323d8
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_PCIE_V6_H_
+#define QCOM_PHY_QMP_PCS_PCIE_V6_H_
+
+/* Only for QMP V6 PHY - PCIE have different offsets than V5 */
+#define QPHY_PCIE_V6_PCS_PCIE_POWER_STATE_CONFIG2	0x0c
+#define QPHY_PCIE_V6_PCS_PCIE_POWER_STATE_CONFIG4	0x14
+#define QPHY_PCIE_V6_PCS_PCIE_ENDPOINT_REFCLK_DRIVE	0x20
+#define QPHY_PCIE_V6_PCS_PCIE_OSC_DTCT_ACTIONS		0x94
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
new file mode 100644
index 000000000000..332d7539899d
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_PCIE_V6_20_H_
+#define QCOM_PHY_QMP_PCS_PCIE_V6_20_H_
+
+/* Only for QMP V6_20 PHY - PCIE have different offsets than V5 */
+#define QPHY_PCIE_V6_20_PCS_POWER_STATE_CONFIG2		0x00c
+#define QPHY_PCIE_V6_20_PCS_TX_RX_CONFIG		0x018
+#define QPHY_PCIE_V6_20_PCS_ENDPOINT_REFCLK_DRIVE	0x01c
+#define QPHY_PCIE_V6_20_PCS_OSC_DTCT_ATCIONS		0x090
+#define QPHY_PCIE_V6_20_PCS_EQ_CONFIG1			0x0a0
+#define QPHY_PCIE_V6_20_PCS_EQ_CONFIG5			0x108
+#define QPHY_PCIE_V6_20_PCS_G4_PRE_GAIN			0x15c
+#define QPHY_PCIE_V6_20_PCS_RX_MARGINING_CONFIG1	0x17c
+#define QPHY_PCIE_V6_20_PCS_RX_MARGINING_CONFIG3	0x184
+#define QPHY_PCIE_V6_20_PCS_RX_MARGINING_CONFIG5	0x18c
+#define QPHY_PCIE_V6_20_PCS_G3_FOM_EQ_CONFIG5		0x1ac
+#define QPHY_PCIE_V6_20_PCS_G4_FOM_EQ_CONFIG5		0x1c0
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
new file mode 100644
index 000000000000..dde8830257b5
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_UFS_V6_H_
+#define QCOM_PHY_QMP_PCS_UFS_V6_H_
+
+/* Only for QMP V6 PHY - UFS PCS registers */
+#define QPHY_V6_PCS_UFS_PHY_START			0x000
+#define QPHY_V6_PCS_UFS_POWER_DOWN_CONTROL		0x004
+#define QPHY_V6_PCS_UFS_SW_RESET			0x008
+#define QPHY_V6_PCS_UFS_TIMER_20US_CORECLK_STEPS_MSB	0x00c
+#define QPHY_V6_PCS_UFS_TIMER_20US_CORECLK_STEPS_LSB	0x010
+#define QPHY_V6_PCS_UFS_PLL_CNTL			0x02c
+#define QPHY_V6_PCS_UFS_TX_LARGE_AMP_DRV_LVL		0x030
+#define QPHY_V6_PCS_UFS_TX_SMALL_AMP_DRV_LVL		0x038
+#define QPHY_V6_PCS_UFS_BIST_FIXED_PAT_CTRL		0x060
+#define QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY		0x074
+#define QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY		0x0bc
+#define QPHY_V6_PCS_UFS_DEBUG_BUS_CLKSEL		0x158
+#define QPHY_V6_PCS_UFS_LINECFG_DISABLE			0x17c
+#define QPHY_V6_PCS_UFS_RX_MIN_HIBERN8_TIME		0x184
+#define QPHY_V6_PCS_UFS_RX_SIGDET_CTRL2			0x18c
+#define QPHY_V6_PCS_UFS_TX_PWM_GEAR_BAND		0x178
+#define QPHY_V6_PCS_UFS_TX_HS_GEAR_BAND			0x174
+#define QPHY_V6_PCS_UFS_READY_STATUS			0x1a8
+#define QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1		0x1f4
+#define QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1		0x1fc
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h
new file mode 100644
index 000000000000..9510e63ba9d8
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_USB_V6_H_
+#define QCOM_PHY_QMP_PCS_USB_V6_H_
+
+/* Only for QMP V6 PHY - USB3 have different offsets than V5 */
+#define QPHY_USB_V6_PCS_LOCK_DETECT_CONFIG1		0xc4
+#define QPHY_USB_V6_PCS_LOCK_DETECT_CONFIG2		0xc8
+#define QPHY_USB_V6_PCS_LOCK_DETECT_CONFIG3		0xcc
+#define QPHY_USB_V6_PCS_LOCK_DETECT_CONFIG6		0xd8
+#define QPHY_USB_V6_PCS_REFGEN_REQ_CONFIG1		0xdc
+#define QPHY_USB_V6_PCS_USB3_POWER_STATE_CONFIG1	0x90
+#define QPHY_USB_V6_PCS_RX_SIGDET_LVL			0x188
+#define QPHY_USB_V6_PCS_RCVR_DTCT_DLY_P1U2_L		0x190
+#define QPHY_USB_V6_PCS_RCVR_DTCT_DLY_P1U2_H		0x194
+#define QPHY_USB_V6_PCS_CDR_RESET_TIME			0x1b0
+#define QPHY_USB_V6_PCS_ALIGN_DETECT_CONFIG1		0x1c0
+#define QPHY_USB_V6_PCS_ALIGN_DETECT_CONFIG2		0x1c4
+#define QPHY_USB_V6_PCS_PCS_TX_RX_CONFIG		0x1d0
+#define QPHY_USB_V6_PCS_EQ_CONFIG1			0x1dc
+#define QPHY_USB_V6_PCS_EQ_CONFIG5			0x1ec
+
+#define QPHY_USB_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL	0x18
+#define QPHY_USB_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2	0x3c
+#define QPHY_USB_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L		0x40
+#define QPHY_USB_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H		0x44
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h
new file mode 100644
index 000000000000..c6c42a0f1509
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V6_H_
+#define QCOM_PHY_QMP_PCS_V6_H_
+
+/* Only for QMP V6 PHY - USB/PCIe PCS registers */
+#define QPHY_V6_PCS_REFGEN_REQ_CONFIG1		0xdc
+#define QPHY_V6_PCS_RX_SIGDET_LVL		0x188
+#define QPHY_V6_PCS_RATE_SLEW_CNTRL1		0x198
+#define QPHY_V6_PCS_EQ_CONFIG2			0x1e0
+#define QPHY_V6_PCS_PCS_TX_RX_CONFIG		0x1d0
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h
new file mode 100644
index 000000000000..084752d9f0fc
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V6_20_H_
+#define QCOM_PHY_QMP_PCS_V6_20_H_
+
+/* Only for QMP V6_20 PHY - USB/PCIe PCS registers */
+#define QPHY_V6_20_PCS_G3S2_PRE_GAIN			0x178
+#define QPHY_V6_20_PCS_RX_SIGDET_LVL			0x190
+#define QPHY_V6_20_PCS_COM_ELECIDLE_DLY_SEL		0x1b8
+#define QPHY_V6_20_PCS_TX_RX_CONFIG1			0x1dc
+#define QPHY_V6_20_PCS_TX_RX_CONFIG2			0x1e0
+#define QPHY_V6_20_PCS_EQ_CONFIG4			0x1f8
+#define QPHY_V6_20_PCS_EQ_CONFIG5			0x1fc
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
new file mode 100644
index 000000000000..1b926812461f
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_COM_V6_H_
+#define QCOM_PHY_QMP_QSERDES_COM_V6_H_
+
+/* Only for QMP V6 PHY - QSERDES COM registers */
+
+#define QSERDES_V6_COM_SSC_STEP_SIZE1_MODE1			0x00
+#define QSERDES_V6_COM_SSC_STEP_SIZE2_MODE1			0x04
+#define QSERDES_V6_COM_CP_CTRL_MODE1				0x10
+#define QSERDES_V6_COM_PLL_RCTRL_MODE1				0x14
+#define QSERDES_V6_COM_PLL_CCTRL_MODE1				0x18
+#define QSERDES_V6_COM_CORECLK_DIV_MODE1			0x1c
+#define QSERDES_V6_COM_LOCK_CMP1_MODE1				0x20
+#define QSERDES_V6_COM_LOCK_CMP2_MODE1				0x24
+#define QSERDES_V6_COM_DEC_START_MODE1				0x28
+#define QSERDES_V6_COM_DEC_START_MSB_MODE1			0x2c
+#define QSERDES_V6_COM_DIV_FRAC_START1_MODE1			0x30
+#define QSERDES_V6_COM_DIV_FRAC_START2_MODE1			0x34
+#define QSERDES_V6_COM_DIV_FRAC_START3_MODE1			0x38
+#define QSERDES_V6_COM_HSCLK_SEL_1				0x3c
+#define QSERDES_V6_COM_VCO_TUNE1_MODE1				0x48
+#define QSERDES_V6_COM_VCO_TUNE2_MODE1				0x4c
+#define QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE1		0x50
+#define QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE1		0x54
+#define QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE0		0x58
+#define QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE0		0x5c
+#define QSERDES_V6_COM_SSC_STEP_SIZE1_MODE0			0x60
+#define QSERDES_V6_COM_SSC_STEP_SIZE2_MODE0			0x64
+#define QSERDES_V6_COM_CP_CTRL_MODE0				0x70
+#define QSERDES_V6_COM_PLL_RCTRL_MODE0				0x74
+#define QSERDES_V6_COM_PLL_CCTRL_MODE0				0x78
+#define QSERDES_V6_COM_PLL_CORE_CLK_DIV_MODE0			0x7c
+#define QSERDES_V6_COM_LOCK_CMP1_MODE0				0x80
+#define QSERDES_V6_COM_LOCK_CMP2_MODE0				0x84
+#define QSERDES_V6_COM_DEC_START_MODE0				0x88
+#define QSERDES_V6_COM_DEC_START_MSB_MODE0			0x8c
+#define QSERDES_V6_COM_DIV_FRAC_START1_MODE0			0x90
+#define QSERDES_V6_COM_DIV_FRAC_START2_MODE0			0x94
+#define QSERDES_V6_COM_DIV_FRAC_START3_MODE0			0x98
+#define QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1			0x9c
+#define QSERDES_V6_COM_VCO_TUNE1_MODE0				0xa8
+#define QSERDES_V6_COM_VCO_TUNE2_MODE0				0xac
+#define QSERDES_V6_COM_BG_TIMER					0xbc
+#define QSERDES_V6_COM_SSC_EN_CENTER				0xc0
+#define QSERDES_V6_COM_SSC_PER1					0xcc
+#define QSERDES_V6_COM_SSC_PER2					0xd0
+#define QSERDES_V6_COM_PLL_POST_DIV_MUX				0xd8
+#define QSERDES_V6_COM_PLL_BIAS_EN_CLK_BUFLR_EN			0xdc
+#define QSERDES_V6_COM_CLK_ENABLE1				0xe0
+#define QSERDES_V6_COM_SYS_CLK_CTRL				0xe4
+#define QSERDES_V6_COM_SYSCLK_BUF_ENABLE			0xe8
+#define QSERDES_V6_COM_PLL_IVCO					0xf4
+#define QSERDES_V6_COM_SYSCLK_EN_SEL				0x110
+#define QSERDES_V6_COM_LOCK_CMP_EN				0x120
+#define QSERDES_V6_COM_LOCK_CMP_CFG				0x124
+#define QSERDES_V6_COM_VCO_TUNE_MAP				0x140
+#define QSERDES_V6_COM_VCO_TUNE_INITVAL2			0x148
+#define QSERDES_V6_COM_CLK_SELECT				0x164
+#define QSERDES_V6_COM_CORE_CLK_EN				0x170
+#define QSERDES_V6_COM_CMN_CONFIG_1				0x174
+#define QSERDES_V6_COM_CMN_MISC_1				0x184
+#define QSERDES_V6_COM_CMN_MODE					0x188
+#define QSERDES_V6_COM_PLL_VCO_DC_LEVEL_CTRL			0x198
+#define QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_1			0x1a4
+#define QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_2			0x1a8
+#define QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_3			0x1ac
+#define QSERDES_V6_COM_ADDITIONAL_MISC				0x1b4
+#define QSERDES_V6_COM_ADDITIONAL_MISC_2			0x1b8
+#define QSERDES_V6_COM_ADDITIONAL_MISC_3			0x1bc
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-ln-shrd-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-ln-shrd-v6.h
new file mode 100644
index 000000000000..51bb34e944cb
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-ln-shrd-v6.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_LN_SHRD_V6_H_
+#define QCOM_PHY_QMP_QSERDES_LN_SHRD_V6_H_
+
+#define QSERDES_V6_LN_SHRD_RXCLK_DIV2_CTRL			0xa0
+#define QSERDES_V6_LN_SHRD_RX_Q_EN_RATES			0xb0
+#define QSERDES_V6_LN_SHRD_DFE_DAC_ENABLE1			0xb4
+#define QSERDES_V6_LN_SHRD_TX_ADAPT_POST_THRESH1		0xc4
+#define QSERDES_V6_LN_SHRD_TX_ADAPT_POST_THRESH2		0xc8
+#define QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B0			0xd4
+#define QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B1			0xd8
+#define QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B2			0xdc
+#define QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B3			0xe0
+#define QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B4			0xe4
+#define QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B5			0xe8
+#define QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B6			0xec
+#define QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH1_RATE210	0xf0
+#define QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH1_RATE3		0xf4
+#define QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH2_RATE210	0xf8
+#define QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH2_RATE3		0xfc
+#define QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH3_RATE210	0x100
+#define QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH3_RATE3		0x104
+#define QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH4_RATE3		0x10c
+#define QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH5_RATE3		0x114
+#define QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH6_RATE3		0x11c
+#define QSERDES_V6_LN_SHRD_RX_SUMMER_CAL_SPD_MODE		0x128
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
new file mode 100644
index 000000000000..e4d38fefdf18
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_UFS_V6_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_UFS_V6_H_
+
+#define QSERDES_UFS_V6_TX_RES_CODE_LANE_TX			0x28
+#define QSERDES_UFS_V6_TX_RES_CODE_LANE_RX			0x2c
+#define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX		0x30
+#define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_RX		0x34
+#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2			0x08
+#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4			0x10
+
+#define QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL			0x178
+#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0			0x208
+#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1			0x20c
+#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3			0x214
+#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B6			0x220
+#define QSERDES_UFS_V6_RX_MODE_RATE2_B3				0x238
+#define QSERDES_UFS_V6_RX_MODE_RATE2_B6				0x244
+#define QSERDES_UFS_V6_RX_MODE_RATE3_B3				0x25c
+#define QSERDES_UFS_V6_RX_MODE_RATE3_B4				0x260
+#define QSERDES_UFS_V6_RX_MODE_RATE3_B5				0x264
+#define QSERDES_UFS_V6_RX_MODE_RATE3_B8				0x270
+#define QSERDES_UFS_V6_RX_MODE_RATE4_B3				0x280
+#define QSERDES_UFS_V6_RX_MODE_RATE4_B6				0x28c
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h
new file mode 100644
index 000000000000..a51bc8b5a693
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_USB_V6_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_USB_V6_H_
+
+#define QSERDES_V6_TX_RES_CODE_LANE_TX				0x34
+#define QSERDES_V6_TX_RES_CODE_LANE_RX				0x38
+#define QSERDES_V6_TX_RES_CODE_LANE_OFFSET_TX			0x3c
+#define QSERDES_V6_TX_RES_CODE_LANE_OFFSET_RX			0x40
+#define QSERDES_V6_TX_BIST_PATTERN7				0x7c
+#define QSERDES_V6_TX_LANE_MODE_1				0x84
+#define QSERDES_V6_TX_LANE_MODE_3				0x8c
+#define QSERDES_V6_TX_LANE_MODE_4				0x90
+#define QSERDES_V6_TX_LANE_MODE_5				0x94
+#define QSERDES_V6_TX_RCV_DETECT_LVL_2				0xa4
+#define QSERDES_V6_TX_PI_QEC_CTRL				0xe4
+
+#define QSERDES_V6_RX_UCDR_FO_GAIN				0x08
+#define QSERDES_V6_RX_UCDR_SO_GAIN				0x14
+#define QSERDES_V6_RX_UCDR_FASTLOCK_FO_GAIN			0x30
+#define QSERDES_V6_RX_UCDR_SO_SATURATION_AND_ENABLE		0x34
+#define QSERDES_V6_RX_UCDR_FASTLOCK_COUNT_LOW			0x3c
+#define QSERDES_V6_RX_UCDR_FASTLOCK_COUNT_HIGH			0x40
+#define QSERDES_V6_RX_UCDR_PI_CONTROLS				0x44
+#define QSERDES_V6_RX_UCDR_SB2_THRESH1				0x4c
+#define QSERDES_V6_RX_UCDR_SB2_THRESH2				0x50
+#define QSERDES_V6_RX_UCDR_SB2_GAIN1				0x54
+#define QSERDES_V6_RX_UCDR_SB2_GAIN2				0x58
+#define QSERDES_V6_RX_AUX_DATA_TCOARSE_TFINE			0x60
+#define QSERDES_V6_RX_TX_ADAPT_POST_THRESH			0xcc
+#define QSERDES_V6_RX_VGA_CAL_CNTRL1				0xd4
+#define QSERDES_V6_RX_VGA_CAL_CNTRL2				0xd8
+#define QSERDES_V6_RX_GM_CAL					0xdc
+#define QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL2			0xec
+#define QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL3			0xf0
+#define QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL4			0xf4
+#define QSERDES_V6_RX_RX_IDAC_TSETTLE_LOW			0xf8
+#define QSERDES_V6_RX_RX_IDAC_TSETTLE_HIGH			0xfc
+#define QSERDES_V6_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1		0x110
+#define QSERDES_V6_RX_SIDGET_ENABLES				0x118
+#define QSERDES_V6_RX_SIGDET_CNTRL				0x11c
+#define QSERDES_V6_RX_SIGDET_DEGLITCH_CNTRL			0x124
+#define QSERDES_V6_RX_RX_MODE_00_LOW				0x15c
+#define QSERDES_V6_RX_RX_MODE_00_HIGH				0x160
+#define QSERDES_V6_RX_RX_MODE_00_HIGH2				0x164
+#define QSERDES_V6_RX_RX_MODE_00_HIGH3				0x168
+#define QSERDES_V6_RX_RX_MODE_00_HIGH4				0x16c
+#define QSERDES_V6_RX_RX_MODE_01_LOW				0x170
+#define QSERDES_V6_RX_RX_MODE_01_HIGH				0x174
+#define QSERDES_V6_RX_RX_MODE_01_HIGH2				0x178
+#define QSERDES_V6_RX_RX_MODE_01_HIGH3				0x17c
+#define QSERDES_V6_RX_RX_MODE_01_HIGH4				0x180
+#define QSERDES_V6_RX_RX_MODE_10_LOW				0x184
+#define QSERDES_V6_RX_RX_MODE_10_HIGH				0x188
+#define QSERDES_V6_RX_RX_MODE_10_HIGH2				0x18c
+#define QSERDES_V6_RX_RX_MODE_10_HIGH3				0x190
+#define QSERDES_V6_RX_RX_MODE_10_HIGH4				0x194
+#define QSERDES_V6_RX_DFE_EN_TIMER				0x1a0
+#define QSERDES_V6_RX_DFE_CTLE_POST_CAL_OFFSET			0x1a4
+#define QSERDES_V6_RX_DCC_CTRL1					0x1a8
+#define QSERDES_V6_RX_VTH_CODE					0x1b0
+#define QSERDES_V6_RX_SIGDET_CAL_CTRL1				0x1e4
+#define QSERDES_V6_RX_SIGDET_CAL_TRIM				0x1f8
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
new file mode 100644
index 000000000000..6009b088882f
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_PCIE_V6_20_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_PCIE_V6_20_H_
+
+#define QSERDES_V6_20_TX_RES_CODE_LANE_OFFSET_TX		0x30
+#define QSERDES_V6_20_TX_RES_CODE_LANE_OFFSET_RX		0x34
+#define QSERDES_V6_20_TX_TRAN_DRVR_EMP_EN			0xac
+#define QSERDES_V6_20_TX_LANE_MODE_1				0x78
+#define QSERDES_V6_20_TX_LANE_MODE_2				0x7c
+#define QSERDES_V6_20_TX_LANE_MODE_3				0x80
+
+#define QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_2			0x08
+#define QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_3			0x0c
+#define QSERDES_V6_20_RX_UCDR_PI_CONTROLS			0x20
+#define QSERDES_V6_20_RX_UCDR_SO_ACC_DEFAULT_VAL_RATE3		0x34
+#define QSERDES_V6_20_RX_IVCM_CAL_CTRL2				0x9c
+#define QSERDES_V6_20_RX_IVCM_POSTCAL_OFFSET			0xa0
+#define QSERDES_V6_20_RX_DFE_3					0xb4
+#define QSERDES_V6_20_RX_VGA_CAL_MAN_VAL			0xe8
+#define QSERDES_V6_20_RX_GM_CAL					0x10c
+#define QSERDES_V6_20_RX_EQU_ADAPTOR_CNTRL4			0x120
+#define QSERDES_V6_20_RX_SIGDET_ENABLES				0x148
+#define QSERDES_V6_20_RX_PHPRE_CTRL				0x188
+#define QSERDES_V6_20_RX_DFE_CTLE_POST_CAL_OFFSET		0x194
+#define QSERDES_V6_20_RX_Q_PI_INTRINSIC_BIAS_RATE32		0x1dc
+#define QSERDES_V6_20_RX_MODE_RATE2_B0				0x1f4
+#define QSERDES_V6_20_RX_MODE_RATE2_B1				0x1f8
+#define QSERDES_V6_20_RX_MODE_RATE2_B2				0x1fc
+#define QSERDES_V6_20_RX_MODE_RATE2_B3				0x200
+#define QSERDES_V6_20_RX_MODE_RATE2_B4				0x204
+#define QSERDES_V6_20_RX_MODE_RATE2_B5				0x208
+#define QSERDES_V6_20_RX_MODE_RATE2_B6				0x20c
+#define QSERDES_V6_20_RX_MODE_RATE3_B0				0x210
+#define QSERDES_V6_20_RX_MODE_RATE3_B1				0x214
+#define QSERDES_V6_20_RX_MODE_RATE3_B2				0x218
+#define QSERDES_V6_20_RX_MODE_RATE3_B3				0x21c
+#define QSERDES_V6_20_RX_MODE_RATE3_B4				0x220
+#define QSERDES_V6_20_RX_MODE_RATE3_B5				0x224
+#define QSERDES_V6_20_RX_MODE_RATE3_B6				0x228
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 29a48f0436d2..91a908c384d1 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -21,6 +21,12 @@
 #include "phy-qcom-qmp-qserdes-txrx-v5_20.h"
 #include "phy-qcom-qmp-qserdes-txrx-v5_5nm.h"
 
+#include "phy-qcom-qmp-qserdes-com-v6.h"
+#include "phy-qcom-qmp-qserdes-ln-shrd-v6.h"
+#include "phy-qcom-qmp-qserdes-txrx-v6.h"
+#include "phy-qcom-qmp-qserdes-txrx-v6_20.h"
+#include "phy-qcom-qmp-qserdes-txrx-ufs-v6.h"
+
 #include "phy-qcom-qmp-qserdes-pll.h"
 
 #include "phy-qcom-qmp-pcs-v2.h"
@@ -45,6 +51,13 @@
 
 #include "phy-qcom-qmp-pcs-pcie-v5_20.h"
 
+#include "phy-qcom-qmp-pcs-v6.h"
+#include "phy-qcom-qmp-pcs-v6_20.h"
+#include "phy-qcom-qmp-pcs-pcie-v6.h"
+#include "phy-qcom-qmp-pcs-pcie-v6_20.h"
+#include "phy-qcom-qmp-pcs-ufs-v6.h"
+#include "phy-qcom-qmp-pcs-usb-v6.h"
+
 #include "phy-qcom-qmp-pcie-qhp.h"
 
 /* Only for QMP V3 & V4 PHY - DP COM registers */
-- 
2.34.1

