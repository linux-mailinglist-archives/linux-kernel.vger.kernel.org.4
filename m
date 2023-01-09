Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B765A663187
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbjAIUbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbjAIUba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:31:30 -0500
Received: from fallback17.mail.ru (fallback17.m.smailru.net [94.100.176.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBBF265E;
        Mon,  9 Jan 2023 12:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=iI1EsHQ5/B84OdNxKfDAtyiNF0MBkGUB0+jEsAFn5no=;
        t=1673296287;x=1673386287; 
        b=TJfWHSQgrgQXLdny8fH7unaTDsGJguUnEZeEhMtk4ZgOfIDsyy9etSpKaNh8BTfwzlxUh2CFXC9MthhRhTc7yilk9SOPlLe1uLLPBVey/boCun8HRAcKLECyURksoAyHmn5K7g2hgk0Q+xNsVXm9CGo4KB8wtkA9V0Dqdqc01Hc=;
Received: from [10.161.64.59] (port=38562 helo=smtp51.i.mail.ru)
        by fallback17.m.smailru.net with esmtp (envelope-from <danila@jiaxyga.com>)
        id 1pExrI-0004v0-LN; Mon, 09 Jan 2023 22:31:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=iI1EsHQ5/B84OdNxKfDAtyiNF0MBkGUB0+jEsAFn5no=;
        t=1673292660;x=1673382660; 
        b=qvO09wxiwZqlAfyzp2w2Jv73KxAmRRhI1AewuV6vbUUZ1m8J5+B6i0/12phiq0efP25IIlDr4Hj/WfWtvDbZd+nmQZgazsamMArERSEtSCXRwOcb8ESqZJAIXt5CMbMmlFXwjeYgfIsV1Q+AqSXkaJs6yPlY8PPr+xT5nfLsmMo=;
Received: by smtp51.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1pExrB-0001ej-Ip; Mon, 09 Jan 2023 22:30:54 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danila Tikhonov <danila@jiaxyga.com>,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH 1/2] dt-bindings: clock: Add SM7150 GCC clock binding
Date:   Mon,  9 Jan 2023 22:30:29 +0300
Message-Id: <20230109193030.42764-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109193030.42764-1-danila@jiaxyga.com>
References: <20230109193030.42764-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD90D1502B3BE350FE43D89E966E4BF1214A8024498517A0AAB00894C459B0CD1B9B35A3FE547FE2C2681C1929044F9656F54974B6CF8F786DE0BFFC594198189FC
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7CFBED06DEBEC9C92EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637EFBEC025CA971C75EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B6F1F7B995052D5CE2862E00926380B6BC054A8AE33C1797CCC7F00164DA146DAFE8445B8C89999728AA50765F790063767B9C6E70FBE8DD8389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC810A7BA5215B3CCECF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C7707068D21E84A34302FCEF25BFAB3454AD6D5ED66289B52698AB9A7B718F8C46E0066C2D8992A16725E5C173C3A84C342C55675E09872E5BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7BB1D8AFE8C29F51C731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5CF6AA1D5C8D6DCA3FB4F5DD83CD21BBF200547F613B137F04EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D3483E1FCD56FEA62E6AB463196B43D06037223D981E0D2CBB5BF45B781F73DD0C6D4717F0EC498C0061D7E09C32AA3244CE76EB9A297B593B04EFBECE9816A9B808894E9C85370243E98DBA7662A2C9987
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojqOyU7017cIv8x2yvI94BJg==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981E397D480C3580E4E050C66BB87AABB5B4AAA9FFB96F90F32643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B41CF11DA7185A12D6EDB6E73F4F4D890D24DE7E8B7CD9457368F3CF0E9FE49B69FEFBE5D651DB9B98F00F49499BF30ECC34D38D5DAC957D197743418DB97B0D59
X-7FA49CB5: 0D63561A33F958A51212E5DFA8B47D9CDC9E588DBDECD1A76C9C283C6EAC9FAB8941B15DA834481FA18204E546F3947CAC7A5202D916A59BF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637EA2971CAAFF25811389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637E6A834C15E0B64FBD81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636AAAE862A0553A39223F8577A6DFFEA7CF9F898F0AFF6A1A243847C11F186F3C59DAA53EE0834AAEE
X-B7AD71C0: 1B70FBA5C9BEEE72C9761FC34675ADEB871C96603B655635EE9D5CB6078CC77C48C7A1893680B168135824B3FEAB4495
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojqOyU7017cIv7E4RpKbqZuA==
X-Mailru-MI: 1000000000800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
---
 .../bindings/clock/qcom,sm7150-gcc.yaml       |  50 +++++
 include/dt-bindings/clock/qcom,sm7150-gcc.h   | 193 ++++++++++++++++++
 2 files changed, 243 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm7150-gcc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
new file mode 100644
index 000000000000..6ce7a1877b00
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
@@ -0,0 +1,50 @@
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
+additionalProperties: false
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
\ No newline at end of file
diff --git a/include/dt-bindings/clock/qcom,sm7150-gcc.h b/include/dt-bindings/clock/qcom,sm7150-gcc.h
new file mode 100644
index 000000000000..3e5f8d32796d
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm7150-gcc.h
@@ -0,0 +1,193 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
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
+#define GCC_CAMERA_AHB_CLK				11
+#define GCC_CAMERA_HF_AXI_CLK				12
+#define GCC_CAMERA_SF_AXI_CLK				13
+#define GCC_CAMERA_XO_CLK				14
+#define GCC_CE1_AHB_CLK					15
+#define GCC_CE1_AXI_CLK					16
+#define GCC_CE1_CLK					17
+#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK			18
+#define GCC_CPUSS_AHB_CLK				19
+#define GCC_CPUSS_AHB_CLK_SRC				20
+#define GCC_CPUSS_GNOC_CLK				21
+#define GCC_CPUSS_RBCPR_CLK				22
+#define GCC_CPUSS_RBCPR_CLK_SRC				23
+#define GCC_DDRSS_GPU_AXI_CLK				24
+#define GCC_DISP_AHB_CLK				25
+#define GCC_DISP_GPLL0_CLK_SRC				26
+#define GCC_DISP_GPLL0_DIV_CLK_SRC			27
+#define GCC_DISP_HF_AXI_CLK				28
+#define GCC_DISP_SF_AXI_CLK				29
+#define GCC_DISP_XO_CLK					30
+#define GCC_GP1_CLK					31
+#define GCC_GP1_CLK_SRC					32
+#define GCC_GP2_CLK					33
+#define GCC_GP2_CLK_SRC					34
+#define GCC_GP3_CLK					35
+#define GCC_GP3_CLK_SRC					36
+#define GCC_GPU_CFG_AHB_CLK				37
+#define GCC_GPU_GPLL0_CLK_SRC				38
+#define GCC_GPU_GPLL0_DIV_CLK_SRC			39
+#define GCC_GPU_MEMNOC_GFX_CLK				40
+#define GCC_GPU_SNOC_DVM_GFX_CLK			41
+#define GCC_GPU_VS_CLK					42
+#define GCC_NPU_AXI_CLK					43
+#define GCC_NPU_CFG_AHB_CLK				44
+#define GCC_NPU_GPLL0_CLK_SRC				45
+#define GCC_NPU_GPLL0_DIV_CLK_SRC			46
+#define GCC_PCIE_0_AUX_CLK				47
+#define GCC_PCIE_0_AUX_CLK_SRC				48
+#define GCC_PCIE_0_CFG_AHB_CLK				49
+#define GCC_PCIE_0_CLKREF_CLK				50
+#define GCC_PCIE_0_MSTR_AXI_CLK				51
+#define GCC_PCIE_0_PIPE_CLK				52
+#define GCC_PCIE_0_SLV_AXI_CLK				53
+#define GCC_PCIE_0_SLV_Q2A_AXI_CLK			54
+#define GCC_PCIE_PHY_AUX_CLK				55
+#define GCC_PCIE_PHY_REFGEN_CLK				56
+#define GCC_PCIE_PHY_REFGEN_CLK_SRC			57
+#define GCC_PDM2_CLK					58
+#define GCC_PDM2_CLK_SRC				59
+#define GCC_PDM_AHB_CLK					60
+#define GCC_PDM_XO4_CLK					61
+#define GCC_PRNG_AHB_CLK				62
+#define GCC_QUPV3_WRAP0_CORE_2X_CLK			63
+#define GCC_QUPV3_WRAP0_CORE_CLK			64
+#define GCC_QUPV3_WRAP0_S0_CLK				65
+#define GCC_QUPV3_WRAP0_S0_CLK_SRC			66
+#define GCC_QUPV3_WRAP0_S1_CLK				67
+#define GCC_QUPV3_WRAP0_S1_CLK_SRC			68
+#define GCC_QUPV3_WRAP0_S2_CLK				69
+#define GCC_QUPV3_WRAP0_S2_CLK_SRC			70
+#define GCC_QUPV3_WRAP0_S3_CLK				71
+#define GCC_QUPV3_WRAP0_S3_CLK_SRC			72
+#define GCC_QUPV3_WRAP0_S4_CLK				73
+#define GCC_QUPV3_WRAP0_S4_CLK_SRC			74
+#define GCC_QUPV3_WRAP0_S5_CLK				75
+#define GCC_QUPV3_WRAP0_S5_CLK_SRC			76
+#define GCC_QUPV3_WRAP0_S6_CLK				77
+#define GCC_QUPV3_WRAP0_S6_CLK_SRC			78
+#define GCC_QUPV3_WRAP0_S7_CLK				79
+#define GCC_QUPV3_WRAP0_S7_CLK_SRC			80
+#define GCC_QUPV3_WRAP1_CORE_2X_CLK			81
+#define GCC_QUPV3_WRAP1_CORE_CLK			82
+#define GCC_QUPV3_WRAP1_S0_CLK				83
+#define GCC_QUPV3_WRAP1_S0_CLK_SRC			84
+#define GCC_QUPV3_WRAP1_S1_CLK				85
+#define GCC_QUPV3_WRAP1_S1_CLK_SRC			86
+#define GCC_QUPV3_WRAP1_S2_CLK				87
+#define GCC_QUPV3_WRAP1_S2_CLK_SRC			88
+#define GCC_QUPV3_WRAP1_S3_CLK				89
+#define GCC_QUPV3_WRAP1_S3_CLK_SRC			90
+#define GCC_QUPV3_WRAP1_S4_CLK				91
+#define GCC_QUPV3_WRAP1_S4_CLK_SRC			92
+#define GCC_QUPV3_WRAP1_S5_CLK				93
+#define GCC_QUPV3_WRAP1_S5_CLK_SRC			94
+#define GCC_QUPV3_WRAP1_S6_CLK				95
+#define GCC_QUPV3_WRAP1_S6_CLK_SRC			96
+#define GCC_QUPV3_WRAP1_S7_CLK				97
+#define GCC_QUPV3_WRAP1_S7_CLK_SRC			98
+#define GCC_QUPV3_WRAP_0_M_AHB_CLK			99
+#define GCC_QUPV3_WRAP_0_S_AHB_CLK			100
+#define GCC_QUPV3_WRAP_1_M_AHB_CLK			101
+#define GCC_QUPV3_WRAP_1_S_AHB_CLK			102
+#define GCC_SDCC1_AHB_CLK				103
+#define GCC_SDCC1_APPS_CLK				104
+#define GCC_SDCC1_APPS_CLK_SRC				105
+#define GCC_SDCC1_ICE_CORE_CLK				106
+#define GCC_SDCC1_ICE_CORE_CLK_SRC			107
+#define GCC_SDCC2_AHB_CLK				108
+#define GCC_SDCC2_APPS_CLK				109
+#define GCC_SDCC2_APPS_CLK_SRC				110
+#define GCC_SDCC4_AHB_CLK				111
+#define GCC_SDCC4_APPS_CLK				112
+#define GCC_SDCC4_APPS_CLK_SRC				113
+#define GCC_SYS_NOC_CPUSS_AHB_CLK			114
+#define GCC_TSIF_AHB_CLK				115
+#define GCC_TSIF_INACTIVITY_TIMERS_CLK			116
+#define GCC_TSIF_REF_CLK				117
+#define GCC_TSIF_REF_CLK_SRC				118
+#define GCC_UFS_MEM_CLKREF_CLK				119
+#define GCC_UFS_PHY_AHB_CLK				120
+#define GCC_UFS_PHY_AXI_CLK				121
+#define GCC_UFS_PHY_AXI_CLK_SRC				122
+#define GCC_UFS_PHY_AXI_HW_CTL_CLK			123
+#define GCC_UFS_PHY_ICE_CORE_CLK			124
+#define GCC_UFS_PHY_ICE_CORE_CLK_SRC			125
+#define GCC_UFS_PHY_ICE_CORE_HW_CTL_CLK			126
+#define GCC_UFS_PHY_PHY_AUX_CLK				127
+#define GCC_UFS_PHY_PHY_AUX_CLK_SRC			128
+#define GCC_UFS_PHY_PHY_AUX_HW_CTL_CLK			129
+#define GCC_UFS_PHY_RX_SYMBOL_0_CLK			130
+#define GCC_UFS_PHY_TX_SYMBOL_0_CLK			131
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK			132
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC			133
+#define GCC_UFS_PHY_UNIPRO_CORE_HW_CTL_CLK		134
+#define GCC_USB30_PRIM_MASTER_CLK			135
+#define GCC_USB30_PRIM_MASTER_CLK_SRC			136
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK			137
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC		138
+#define GCC_USB30_PRIM_SLEEP_CLK			139
+#define GCC_USB3_PRIM_CLKREF_CLK			140
+#define GCC_USB3_PRIM_PHY_AUX_CLK			141
+#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC			142
+#define GCC_USB3_PRIM_PHY_COM_AUX_CLK			143
+#define GCC_USB3_PRIM_PHY_PIPE_CLK			144
+#define GCC_USB_PHY_CFG_AHB2PHY_CLK			145
+#define GCC_VDDA_VS_CLK					146
+#define GCC_VDDCX_VS_CLK				147
+#define GCC_VDDMX_VS_CLK				148
+#define GCC_VIDEO_AHB_CLK				149
+#define GCC_VIDEO_AXI_CLK				150
+#define GCC_VIDEO_XO_CLK				151
+#define GCC_VS_CTRL_AHB_CLK				152
+#define GCC_VS_CTRL_CLK					153
+#define GCC_VS_CTRL_CLK_SRC				154
+#define GCC_VSENSOR_CLK_SRC				155
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
2.39.0

