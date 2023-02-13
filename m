Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905C8694D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjBMQxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjBMQxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:53:48 -0500
Received: from fallback23.mail.ru (fallback23.m.smailru.net [94.100.187.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0B33C22;
        Mon, 13 Feb 2023 08:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=S1R+aVR4x/BhQEDfc6Ae7MYJJSIFSyY4MNA6fjCmK8s=;
        t=1676307221;x=1676397221; 
        b=Q7EDO3Gt/Ft3xtkCjS52koeU1xtqxATtToBOnUAwWskP3Gosbf1ygMY5T7jahYtrHJtZn4PoMCCgZxTIATveMsQTXurEQvgQgu2qLwg8ba0k3Dgs31L4bT66arQQO5EwmgWZLmlAkvTurDB+Ps0BPs7ow2GrviM1c0FWX+AJVAg=;
Received: from [10.161.25.38] (port=40762 helo=smtp61.i.mail.ru)
        by fallback23.m.smailru.net with esmtp (envelope-from <danila@jiaxyga.com>)
        id 1pRc5D-0008HX-97; Mon, 13 Feb 2023 19:53:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=S1R+aVR4x/BhQEDfc6Ae7MYJJSIFSyY4MNA6fjCmK8s=;
        t=1676307219;x=1676397219; 
        b=FxZJQVTggWz2z334aJ6hSxbcvV4wksYyb/qSf5g8ej0GA8wUHosiRa6YSAhKxIrUsK0tmjCFg7lBqloDGsuPK4hQR8zAOt4pDd4zYBOa+LsG1ONHIqaaxQ1lfilKtPwRQfER1MA6mDVuIrmnyR0+qnW3mHf8yRdvVKLKbsKueW8=;
Received: by smtp61.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1pRc4w-000849-Uw; Mon, 13 Feb 2023 19:53:23 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danila Tikhonov <danila@jiaxyga.com>,
        David Wronek <davidwronek@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: clock: Add SM7150 GCC clocks
Date:   Mon, 13 Feb 2023 19:53:17 +0300
Message-Id: <20230213165318.127160-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213165318.127160-1-danila@jiaxyga.com>
References: <20230213165318.127160-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9D95CB639AA8C08F87D4CAA4928A9F877727D117528FCAA88182A05F53808504014EE5EC7D116427BA57361F60B1775FD9DEDE516D9CD1702227CE00B72701CE6
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7CFFD65163E56A654EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063731DAA1EEC3F3B9028638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D84508579D4EC51E6268CAB7BBFE29B241117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC972D20C7389F068BA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520C65AC60A1F0286FEC26CFBAC0749D213D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE599709FD55CB46A6500AC0B2F9B62304D8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE3724336BCC0EE1BA8040F9FF01DFDA4A8C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947C2FFDA4F57982C5F42E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89FD2A95C73FD1EFF4542539A7722CA490CB5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A51E6A75A69280BFFF45C51A79B6683C198D8053C32E841E7F4EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D349A949488F6BF46DDEDBD4365DB0AF9D51108DC66AEC380842CD61464E041D80B068A2CE7DEEFB2281D7E09C32AA3244C4FF4A894E3C540DA46E3D9DB98AD0CEEE8FBBEFAE1C4874C0D282625F6E20647
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojgB/I+mAIlFFoFig4ftnteA==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949818C37C8FDF4D04B0C583387FBE15C28339B2D0682BA6A040C643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 78E4E2B564C1792B
X-77F55803: 6242723A09DB00B4B4CD5912039A6B9829DBEE41324865EEFCC1CC1B4317E43368F3CF0E9FE49B69225E8D1F4DC7B2F550123945066C7FB2196E7E6197E92F2D75CB94C950349B0C
X-7FA49CB5: 0D63561A33F958A5EE57A9F68F3081DD01B787C27E891782F3EFC8F08E14FF8A8941B15DA834481FA18204E546F3947CB6617C399FBFD4B4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637A3E1607A70BC73F0389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F790063736AE1FDB94A6797ED81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636AAAE862A0553A39223F8577A6DFFEA7CD5703B978803C49E43847C11F186F3C59DAA53EE0834AAEE
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojgB/I+mAIlFEExIl2w7LR9w==
X-Mailru-MI: 800
X-Mras: Ok
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for global clock subsystem clock
controller for Qualcomm Technology Inc's SM7150 SoCs.

Co-developed-by: David Wronek <davidwronek@gmail.com>
Signed-off-by: David Wronek <davidwronek@gmail.com>
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/qcom,sm7150-gcc.yaml       |  53 +++++
 include/dt-bindings/clock/qcom,sm7150-gcc.h   | 186 ++++++++++++++++++
 2 files changed, 239 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm7150-gcc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
new file mode 100644
index 000000000000..34c6da8b2d8f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm7150-gcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller on SM7150
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Danila Tikhonov <danila@jiaxyga.com>
+  - David Wronek <davidwronek@gmail.com>
+
+description: |
+  Qualcomm global clock control module provides the clocks, resets and power
+  domains on SM7150
+
+  See also:: include/dt-bindings/clock/qcom,sm7150-gcc.h
+
+properties:
+  compatible:
+    const: qcom,sm7150-gcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Board XO Active-Only source
+      - description: Sleep clock source
+
+required:
+  - compatible
+  - clocks
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@100000 {
+      compatible = "qcom,sm7150-gcc";
+      reg = <0x00100000 0x001f0000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&rpmhcc RPMH_CXO_CLK_A>,
+               <&sleep_clk>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
+
diff --git a/include/dt-bindings/clock/qcom,sm7150-gcc.h b/include/dt-bindings/clock/qcom,sm7150-gcc.h
new file mode 100644
index 000000000000..7719ffc86139
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm7150-gcc.h
@@ -0,0 +1,186 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Danila Tikhonov <danila@jiaxyga.com>
+ * Copyright (c) 2023, David Wronek <davidwronek@gmail.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GCC_SM7150_H
+#define _DT_BINDINGS_CLK_QCOM_GCC_SM7150_H
+
+/* GCC clock registers */
+#define GCC_GPLL0_MAIN_DIV_CDIV				0
+#define GPLL0						1
+#define GPLL0_OUT_EVEN					2
+#define GPLL6						3
+#define GPLL7						4
+#define GCC_AGGRE_NOC_PCIE_TBU_CLK			5
+#define GCC_AGGRE_UFS_PHY_AXI_CLK			6
+#define GCC_AGGRE_UFS_PHY_AXI_HW_CTL_CLK		7
+#define GCC_AGGRE_USB3_PRIM_AXI_CLK			8
+#define GCC_APC_VS_CLK					9
+#define GCC_BOOT_ROM_AHB_CLK				10
+#define GCC_CAMERA_HF_AXI_CLK				11
+#define GCC_CAMERA_SF_AXI_CLK				12
+#define GCC_CE1_AHB_CLK					13
+#define GCC_CE1_AXI_CLK					14
+#define GCC_CE1_CLK					15
+#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK			16
+#define GCC_CPUSS_AHB_CLK				17
+#define GCC_CPUSS_AHB_CLK_SRC				18
+#define GCC_CPUSS_RBCPR_CLK				19
+#define GCC_CPUSS_RBCPR_CLK_SRC				20
+#define GCC_DDRSS_GPU_AXI_CLK				21
+#define GCC_DISP_GPLL0_CLK_SRC				22
+#define GCC_DISP_GPLL0_DIV_CLK_SRC			23
+#define GCC_DISP_HF_AXI_CLK				24
+#define GCC_DISP_SF_AXI_CLK				25
+#define GCC_GP1_CLK					26
+#define GCC_GP1_CLK_SRC					27
+#define GCC_GP2_CLK					28
+#define GCC_GP2_CLK_SRC					29
+#define GCC_GP3_CLK					30
+#define GCC_GP3_CLK_SRC					31
+#define GCC_GPU_GPLL0_CLK_SRC				32
+#define GCC_GPU_GPLL0_DIV_CLK_SRC			33
+#define GCC_GPU_MEMNOC_GFX_CLK				34
+#define GCC_GPU_SNOC_DVM_GFX_CLK			35
+#define GCC_GPU_VS_CLK					36
+#define GCC_NPU_AXI_CLK					37
+#define GCC_NPU_CFG_AHB_CLK				38
+#define GCC_NPU_GPLL0_CLK_SRC				39
+#define GCC_NPU_GPLL0_DIV_CLK_SRC			40
+#define GCC_PCIE_0_AUX_CLK				41
+#define GCC_PCIE_0_AUX_CLK_SRC				42
+#define GCC_PCIE_0_CFG_AHB_CLK				43
+#define GCC_PCIE_0_CLKREF_CLK				44
+#define GCC_PCIE_0_MSTR_AXI_CLK				45
+#define GCC_PCIE_0_PIPE_CLK				46
+#define GCC_PCIE_0_SLV_AXI_CLK				47
+#define GCC_PCIE_0_SLV_Q2A_AXI_CLK			48
+#define GCC_PCIE_PHY_AUX_CLK				49
+#define GCC_PCIE_PHY_REFGEN_CLK				50
+#define GCC_PCIE_PHY_REFGEN_CLK_SRC			51
+#define GCC_PDM2_CLK					52
+#define GCC_PDM2_CLK_SRC				53
+#define GCC_PDM_AHB_CLK					54
+#define GCC_PDM_XO4_CLK					55
+#define GCC_PRNG_AHB_CLK				56
+#define GCC_QUPV3_WRAP0_CORE_2X_CLK			57
+#define GCC_QUPV3_WRAP0_CORE_CLK			58
+#define GCC_QUPV3_WRAP0_S0_CLK				59
+#define GCC_QUPV3_WRAP0_S0_CLK_SRC			60
+#define GCC_QUPV3_WRAP0_S1_CLK				61
+#define GCC_QUPV3_WRAP0_S1_CLK_SRC			62
+#define GCC_QUPV3_WRAP0_S2_CLK				63
+#define GCC_QUPV3_WRAP0_S2_CLK_SRC			64
+#define GCC_QUPV3_WRAP0_S3_CLK				65
+#define GCC_QUPV3_WRAP0_S3_CLK_SRC			66
+#define GCC_QUPV3_WRAP0_S4_CLK				67
+#define GCC_QUPV3_WRAP0_S4_CLK_SRC			68
+#define GCC_QUPV3_WRAP0_S5_CLK				69
+#define GCC_QUPV3_WRAP0_S5_CLK_SRC			70
+#define GCC_QUPV3_WRAP0_S6_CLK				71
+#define GCC_QUPV3_WRAP0_S6_CLK_SRC			72
+#define GCC_QUPV3_WRAP0_S7_CLK				73
+#define GCC_QUPV3_WRAP0_S7_CLK_SRC			74
+#define GCC_QUPV3_WRAP1_CORE_2X_CLK			75
+#define GCC_QUPV3_WRAP1_CORE_CLK			76
+#define GCC_QUPV3_WRAP1_S0_CLK				77
+#define GCC_QUPV3_WRAP1_S0_CLK_SRC			78
+#define GCC_QUPV3_WRAP1_S1_CLK				79
+#define GCC_QUPV3_WRAP1_S1_CLK_SRC			80
+#define GCC_QUPV3_WRAP1_S2_CLK				81
+#define GCC_QUPV3_WRAP1_S2_CLK_SRC			82
+#define GCC_QUPV3_WRAP1_S3_CLK				83
+#define GCC_QUPV3_WRAP1_S3_CLK_SRC			84
+#define GCC_QUPV3_WRAP1_S4_CLK				85
+#define GCC_QUPV3_WRAP1_S4_CLK_SRC			86
+#define GCC_QUPV3_WRAP1_S5_CLK				87
+#define GCC_QUPV3_WRAP1_S5_CLK_SRC			88
+#define GCC_QUPV3_WRAP1_S6_CLK				89
+#define GCC_QUPV3_WRAP1_S6_CLK_SRC			90
+#define GCC_QUPV3_WRAP1_S7_CLK				91
+#define GCC_QUPV3_WRAP1_S7_CLK_SRC			92
+#define GCC_QUPV3_WRAP_0_M_AHB_CLK			93
+#define GCC_QUPV3_WRAP_0_S_AHB_CLK			94
+#define GCC_QUPV3_WRAP_1_M_AHB_CLK			95
+#define GCC_QUPV3_WRAP_1_S_AHB_CLK			96
+#define GCC_SDCC1_AHB_CLK				97
+#define GCC_SDCC1_APPS_CLK				98
+#define GCC_SDCC1_APPS_CLK_SRC				99
+#define GCC_SDCC1_ICE_CORE_CLK				100
+#define GCC_SDCC1_ICE_CORE_CLK_SRC			101
+#define GCC_SDCC2_AHB_CLK				102
+#define GCC_SDCC2_APPS_CLK				103
+#define GCC_SDCC2_APPS_CLK_SRC				104
+#define GCC_SDCC4_AHB_CLK				105
+#define GCC_SDCC4_APPS_CLK				106
+#define GCC_SDCC4_APPS_CLK_SRC				107
+#define GCC_SYS_NOC_CPUSS_AHB_CLK			108
+#define GCC_TSIF_AHB_CLK				109
+#define GCC_TSIF_INACTIVITY_TIMERS_CLK			110
+#define GCC_TSIF_REF_CLK				111
+#define GCC_TSIF_REF_CLK_SRC				112
+#define GCC_UFS_MEM_CLKREF_CLK				113
+#define GCC_UFS_PHY_AHB_CLK				114
+#define GCC_UFS_PHY_AXI_CLK				115
+#define GCC_UFS_PHY_AXI_CLK_SRC				116
+#define GCC_UFS_PHY_AXI_HW_CTL_CLK			117
+#define GCC_UFS_PHY_ICE_CORE_CLK			118
+#define GCC_UFS_PHY_ICE_CORE_CLK_SRC			119
+#define GCC_UFS_PHY_ICE_CORE_HW_CTL_CLK			120
+#define GCC_UFS_PHY_PHY_AUX_CLK				121
+#define GCC_UFS_PHY_PHY_AUX_CLK_SRC			122
+#define GCC_UFS_PHY_PHY_AUX_HW_CTL_CLK			123
+#define GCC_UFS_PHY_RX_SYMBOL_0_CLK			124
+#define GCC_UFS_PHY_TX_SYMBOL_0_CLK			125
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK			126
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC			127
+#define GCC_UFS_PHY_UNIPRO_CORE_HW_CTL_CLK		128
+#define GCC_USB30_PRIM_MASTER_CLK			129
+#define GCC_USB30_PRIM_MASTER_CLK_SRC			130
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK			131
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC		132
+#define GCC_USB30_PRIM_SLEEP_CLK			133
+#define GCC_USB3_PRIM_CLKREF_CLK			134
+#define GCC_USB3_PRIM_PHY_AUX_CLK			135
+#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC			136
+#define GCC_USB3_PRIM_PHY_COM_AUX_CLK			137
+#define GCC_USB3_PRIM_PHY_PIPE_CLK			138
+#define GCC_USB_PHY_CFG_AHB2PHY_CLK			139
+#define GCC_VDDA_VS_CLK					140
+#define GCC_VDDCX_VS_CLK				141
+#define GCC_VDDMX_VS_CLK				142
+#define GCC_VIDEO_AXI_CLK				143
+#define GCC_VS_CTRL_AHB_CLK				144
+#define GCC_VS_CTRL_CLK					145
+#define GCC_VS_CTRL_CLK_SRC				146
+#define GCC_VSENSOR_CLK_SRC				147
+
+/* GCC Resets */
+#define GCC_PCIE_0_BCR					0
+#define GCC_PCIE_PHY_BCR				1
+#define GCC_PCIE_PHY_COM_BCR				2
+#define GCC_UFS_PHY_BCR					3
+#define GCC_USB30_PRIM_BCR				4
+#define GCC_USB3_DP_PHY_PRIM_BCR			5
+#define GCC_USB3_DP_PHY_SEC_BCR				6
+#define GCC_USB3_PHY_PRIM_BCR				7
+#define GCC_USB3_PHY_SEC_BCR				8
+#define GCC_QUSB2PHY_PRIM_BCR				9
+#define GCC_VIDEO_AXI_CLK_BCR				10
+
+/* GCC GDSCRs */
+#define PCIE_0_GDSC					0
+#define UFS_PHY_GDSC					1
+#define USB30_PRIM_GDSC					2
+#define HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_GDSC		3
+#define HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC		4
+#define HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_GDSC		5
+#define HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_GDSC		6
+#define HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC		7
+#define HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC		8
+#define HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC		9
+
+#endif
-- 
2.39.1

