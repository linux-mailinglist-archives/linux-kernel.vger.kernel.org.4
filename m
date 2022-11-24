Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A37637792
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiKXLXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiKXLXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:23:05 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7261E3F2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:23:01 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v1so1988213wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVkt5++p8oGqYObEuTjRqXFfLlaxkEjYJdU5DWIoexs=;
        b=JZERqt5TQM+sTo//Dx6ZCVjp93+xVKJYKFSStG9PGgw08D3zd2Eda15ifbuGOwGQzI
         C5h5oNpBvXhevLYhBQSC0c8EjpQwXFMIbKIzT6OM+RuuMbzXTnekHK/80/soCfK/njej
         eAtd3a2ZkFuw9LviMFB9GlaXtIIsDcBuxM/8lAH3ab9DYpFMgcC7yDwpsTEf2G31hnZt
         uVlgm/xHZkk/pO9Yzkza76ElOsGrgz7P2cemTJm9lkcr8Z3+Gcqp9YZMpeJtgK6p8Wj9
         19FXxBnKZ4DmJIgFqBM5Z3YprwCenAqkyfFxPEDRSWKDDaLFnd/V4CzJnavzEjmLOkBW
         rBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVkt5++p8oGqYObEuTjRqXFfLlaxkEjYJdU5DWIoexs=;
        b=VBd2pKORwzSQPgv7wkjMxgvhdEU5B5iaAKrlZXeYXWuln7y4/HioczT9GRuXA5yzob
         kb1KGQNY3y5E579zNFALO5S1/fBNind7bYe+ji0GP8URvBFpSm8CHdvFCzEmemdOsUxn
         eowsHJjdl2zOd667whBXgfXJmcgcv4i+HXQy2t/qJBa9oItiuPAjknb6quMVbWONoXES
         GGFy27oEzvsf1khYYcuNxghkv369EtMyxxEJW2+zYG4SieeRTarLpHQGjH9CXbhd/499
         6S345qXlu6k5/RH9f71OSYdMSlGe0EigNm5BoGkzSFSQ5DQ6IrP85s7IHVMZ1bDg3GRT
         xlyQ==
X-Gm-Message-State: ANoB5pl317rJmVjf1ph6bytF8E8IllBPNPKftHxJCVltOH8DO9x/6RLT
        YvGAXVUPSMx3BHLbtNdlLx2ejQ==
X-Google-Smtp-Source: AA0mqf4Hzh7sJdxNuBzUxKQRaSK+FQyLxceItxeMaTr+6ytj/F2WfJmkZeJ71y9pPthGKsNH7oAV0g==
X-Received: by 2002:a5d:45c4:0:b0:241:e819:b56a with SMTP id b4-20020a5d45c4000000b00241e819b56amr5996658wrs.26.1669288981022;
        Thu, 24 Nov 2022 03:23:01 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003cf57329221sm5839461wms.14.2022.11.24.03.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 03:23:00 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Melody Olvera <quic_molvera@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: interconnect: Add Qualcomm SM8550
Date:   Thu, 24 Nov 2022 13:22:31 +0200
Message-Id: <20221124112232.1704144-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124112232.1704144-1-abel.vesa@linaro.org>
References: <20221124112232.1704144-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SM8550 SoC has several bus fabrics that could be
controlled and tuned dynamically according to the bandwidth demand

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../dt-bindings/interconnect/qcom,sm8550.h    | 190 ++++++++++++++++++
 1 file changed, 190 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8550.h

diff --git a/include/dt-bindings/interconnect/qcom,sm8550.h b/include/dt-bindings/interconnect/qcom,sm8550.h
new file mode 100644
index 000000000000..9cfc67d0b032
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm8550.h
@@ -0,0 +1,190 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM8550_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SM8550_H
+
+#define MASTER_QSPI_0				0
+#define MASTER_QUP_1				1
+#define MASTER_SDCC_4				2
+#define MASTER_UFS_MEM				3
+#define MASTER_USB3_0				4
+#define SLAVE_A1NOC_SNOC			5
+
+#define MASTER_QDSS_BAM				0
+#define MASTER_QUP_2				1
+#define MASTER_CRYPTO				2
+#define MASTER_IPA				3
+#define MASTER_SP				4
+#define MASTER_QDSS_ETR				5
+#define MASTER_QDSS_ETR_1			6
+#define MASTER_SDCC_2				7
+#define SLAVE_A2NOC_SNOC			8
+
+#define MASTER_QUP_CORE_0			0
+#define MASTER_QUP_CORE_1			1
+#define MASTER_QUP_CORE_2			2
+#define SLAVE_QUP_CORE_0			3
+#define SLAVE_QUP_CORE_1			4
+#define SLAVE_QUP_CORE_2			5
+
+#define MASTER_CNOC_CFG				0
+#define SLAVE_AHB2PHY_SOUTH			1
+#define SLAVE_AHB2PHY_NORTH			2
+#define SLAVE_APPSS				3
+#define SLAVE_CAMERA_CFG			4
+#define SLAVE_CLK_CTL				5
+#define SLAVE_RBCPR_CX_CFG			6
+#define SLAVE_RBCPR_MMCX_CFG			7
+#define SLAVE_RBCPR_MXA_CFG			8
+#define SLAVE_RBCPR_MXC_CFG			9
+#define SLAVE_CPR_NSPCX				10
+#define SLAVE_CRYPTO_0_CFG			11
+#define SLAVE_CX_RDPM				12
+#define SLAVE_DISPLAY_CFG			13
+#define SLAVE_GFX3D_CFG				14
+#define SLAVE_I2C				15
+#define SLAVE_IMEM_CFG				16
+#define SLAVE_IPA_CFG				17
+#define SLAVE_IPC_ROUTER_CFG			18
+#define SLAVE_CNOC_MSS				19
+#define SLAVE_MX_RDPM				20
+#define SLAVE_PCIE_0_CFG			21
+#define SLAVE_PCIE_1_CFG			22
+#define SLAVE_PDM				23
+#define SLAVE_PIMEM_CFG				24
+#define SLAVE_PRNG				25
+#define SLAVE_QDSS_CFG				26
+#define SLAVE_QSPI_0				27
+#define SLAVE_QUP_1				28
+#define SLAVE_QUP_2				29
+#define SLAVE_SDCC_2				30
+#define SLAVE_SDCC_4				31
+#define SLAVE_SPSS_CFG				32
+#define SLAVE_TCSR				33
+#define SLAVE_TLMM				34
+#define SLAVE_UFS_MEM_CFG			35
+#define SLAVE_USB3_0				36
+#define SLAVE_VENUS_CFG				37
+#define SLAVE_VSENSE_CTRL_CFG			38
+#define SLAVE_LPASS_QTB_CFG			39
+#define SLAVE_CNOC_MNOC_CFG			40
+#define SLAVE_NSP_QTB_CFG			41
+#define SLAVE_PCIE_ANOC_CFG			42
+#define SLAVE_QDSS_STM				43
+#define SLAVE_TCU				44
+
+#define MASTER_GEM_NOC_CNOC			0
+#define MASTER_GEM_NOC_PCIE_SNOC		1
+#define SLAVE_AOSS				2
+#define SLAVE_TME_CFG				3
+#define SLAVE_CNOC_CFG				4
+#define SLAVE_DDRSS_CFG				5
+#define SLAVE_BOOT_IMEM				6
+#define SLAVE_IMEM				7
+#define SLAVE_PCIE_0				8
+#define SLAVE_PCIE_1				9
+
+#define MASTER_GPU_TCU				0
+#define MASTER_SYS_TCU				1
+#define MASTER_APPSS_PROC			2
+#define MASTER_GFX3D				3
+#define MASTER_LPASS_GEM_NOC			4
+#define MASTER_MSS_PROC				5
+#define MASTER_MNOC_HF_MEM_NOC			6
+#define MASTER_MNOC_SF_MEM_NOC			7
+#define MASTER_COMPUTE_NOC			8
+#define MASTER_ANOC_PCIE_GEM_NOC		9
+#define MASTER_SNOC_GC_MEM_NOC			10
+#define MASTER_SNOC_SF_MEM_NOC			11
+#define SLAVE_GEM_NOC_CNOC			12
+#define SLAVE_LLCC				13
+#define SLAVE_MEM_NOC_PCIE_SNOC			14
+#define MASTER_MNOC_HF_MEM_NOC_DISP		15
+#define MASTER_ANOC_PCIE_GEM_NOC_DISP		16
+#define SLAVE_LLCC_DISP				17
+#define MASTER_MNOC_HF_MEM_NOC_CAM_IFE_0	18
+#define MASTER_MNOC_SF_MEM_NOC_CAM_IFE_0	19
+#define MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_0	20
+#define SLAVE_LLCC_CAM_IFE_0			21
+#define MASTER_MNOC_HF_MEM_NOC_CAM_IFE_1	22
+#define MASTER_MNOC_SF_MEM_NOC_CAM_IFE_1	23
+#define MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_1	24
+#define SLAVE_LLCC_CAM_IFE_1			25
+#define MASTER_MNOC_HF_MEM_NOC_CAM_IFE_2	26
+#define MASTER_MNOC_SF_MEM_NOC_CAM_IFE_2	27
+#define MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_2	28
+#define SLAVE_LLCC_CAM_IFE_2			29
+
+
+#define MASTER_LPIAON_NOC			0
+#define SLAVE_LPASS_GEM_NOC			1
+
+#define MASTER_LPASS_LPINOC			0
+#define SLAVE_LPIAON_NOC_LPASS_AG_NOC		1
+
+#define MASTER_LPASS_PROC			0
+#define SLAVE_LPICX_NOC_LPIAON_NOC		1
+
+#define MASTER_LLCC				0
+#define SLAVE_EBI1				1
+#define MASTER_LLCC_DISP			2
+#define SLAVE_EBI1_DISP				3
+#define MASTER_LLCC_CAM_IFE_0			4
+#define SLAVE_EBI1_CAM_IFE_0			5
+#define MASTER_LLCC_CAM_IFE_1			6
+#define SLAVE_EBI1_CAM_IFE_1			7
+#define MASTER_LLCC_CAM_IFE_2			8
+#define SLAVE_EBI1_CAM_IFE_2			9
+
+#define MASTER_CAMNOC_HF			0
+#define MASTER_CAMNOC_ICP			1
+#define MASTER_CAMNOC_SF			2
+#define MASTER_MDP				3
+#define MASTER_CDSP_HCP				4
+#define MASTER_VIDEO				5
+#define MASTER_VIDEO_CV_PROC			6
+#define MASTER_VIDEO_PROC			7
+#define MASTER_VIDEO_V_PROC			8
+#define MASTER_CNOC_MNOC_CFG			9
+#define SLAVE_MNOC_HF_MEM_NOC			10
+#define SLAVE_MNOC_SF_MEM_NOC			11
+#define SLAVE_SERVICE_MNOC			12
+#define MASTER_MDP_DISP				13
+#define SLAVE_MNOC_HF_MEM_NOC_DISP		14
+#define MASTER_CAMNOC_HF_CAM_IFE_0		15
+#define MASTER_CAMNOC_ICP_CAM_IFE_0		16
+#define MASTER_CAMNOC_SF_CAM_IFE_0		17
+#define SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_0		18
+#define SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_0		19
+#define MASTER_CAMNOC_HF_CAM_IFE_1		20
+#define MASTER_CAMNOC_ICP_CAM_IFE_1		21
+#define MASTER_CAMNOC_SF_CAM_IFE_1		22
+#define SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_1		23
+#define SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_1		24
+#define MASTER_CAMNOC_HF_CAM_IFE_2		25
+#define MASTER_CAMNOC_ICP_CAM_IFE_2		26
+#define MASTER_CAMNOC_SF_CAM_IFE_2		27
+#define SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_2		28
+#define SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_2		29
+
+#define MASTER_CDSP_PROC			0
+#define SLAVE_CDSP_MEM_NOC			1
+
+#define MASTER_PCIE_ANOC_CFG			0
+#define MASTER_PCIE_0				1
+#define MASTER_PCIE_1				2
+#define SLAVE_ANOC_PCIE_GEM_NOC			3
+#define SLAVE_SERVICE_PCIE_ANOC			4
+
+#define MASTER_GIC_AHB				0
+#define MASTER_A1NOC_SNOC			1
+#define MASTER_A2NOC_SNOC			2
+#define MASTER_GIC				3
+#define SLAVE_SNOC_GEM_NOC_GC			4
+#define SLAVE_SNOC_GEM_NOC_SF			5
+
+#endif
-- 
2.34.1

