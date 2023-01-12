Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4E06673D5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjALOAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjALN7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:59:52 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4064A532AA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:59:31 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id m21so26945681edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IOgG4eKjPYKS7EoOjZ7QgExUrhV27SwGOcYeDK/QSfQ=;
        b=UiHw34pHfhygR/6vgLXXCP2/BU1MT2FetomDPNmlVYtT0UBFPnGYwLX2glic4YotVb
         i7RGf3cUbowpFUZz393qH/WdEo4134BZJK6pmQWsREbwb64T/paDdKsme+cFNv3Ldfzv
         Bmi1oA8ohf6IsXwW+ea1scOxwQFokJfPH2dDxkbyqPkBgEd32H8qAC7vSvWkjI5+1lpf
         pND92rftPvZ1LcBkyxn2Pn2bM61eHphxw0bXH+8H5jiZI5svvA0CyxfGgUcRx94Kw9aX
         VXbGQwBrhG3m5SwUm9cQaZLfdF8PY7R+C1y8O0lJtus+McNJH5oPzV/pd2fDk7hZPd6P
         t85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOgG4eKjPYKS7EoOjZ7QgExUrhV27SwGOcYeDK/QSfQ=;
        b=EUKHQJzeltmhQBn1vlrjKosJVMdnDutZxCwEtjGV2rFaY1+Z2v66IxBKUXUQPuZBv4
         hXEytpSxVicEOg7JdwPzUGwV3sniFELwuTzSqoK9sIe69Wpf3y2crLzk5jnx5SGjIJAZ
         o9IPVgKkZSJsrgSDoTZ+Ok67pcJz/8xw9Y3Q8293dth6c5rfg111f4yy22TitwgJh5/a
         nJm1LIa+XVuflJEg9QjyIyV1oIDeOSG/z7zyylFjH43YSs02FOFJ+p69s37bLcMkTUBV
         k92My0NZA+iXCfPGcn5ZsZlhPtr5faGPYPPQ488hTIma3U0m83XUaDa9jGJD2fUY547Q
         jLBA==
X-Gm-Message-State: AFqh2kr8p9W8JiZxWGTE5lNNVL1t4lnGK4XuzSZd76s+yHTQ2De3Teel
        24yI8Q4rIQCzoWfc89qH5ZQ8hA==
X-Google-Smtp-Source: AMrXdXs4diXMPLEwXalKr+SJyaBNgNtcYGwkpGuF7N33G7oWjKunLeWnb6DR7gQs7UBVkjqol7i7cQ==
X-Received: by 2002:a05:6402:3201:b0:48e:a96c:fd64 with SMTP id g1-20020a056402320100b0048ea96cfd64mr35765310eda.25.1673531969690;
        Thu, 12 Jan 2023 05:59:29 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906329100b007c0bb571da5sm7376494ejw.41.2023.01.12.05.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 05:59:29 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: qcom: sm8550: Add UFS host controller and phy nodes
Date:   Thu, 12 Jan 2023 15:59:25 +0200
Message-Id: <20230112135926.1572191-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Add UFS host controller and PHY nodes.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v1:
 * dropped ufs_mem_phy_lanes child node, like Johan suggested
 * addressed Konrad comments.

 arch/arm64/boot/dts/qcom/sm8550.dtsi | 78 ++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 59756ec11564..d20b5fbcb2c3 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -649,9 +649,9 @@ gcc: clock-controller@100000 {
 				 <0>,
 				 <0>,
 				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
+				 <&ufs_mem_phy 0>,
+				 <&ufs_mem_phy 1>,
+				 <&ufs_mem_phy 2>,
 				 <0>;
 		};
 
@@ -1571,6 +1571,78 @@ crypto: crypto@1de0000 {
 			interconnect-names = "memory";
 		};
 
+		ufs_mem_phy: phy@1d80000 {
+			compatible = "qcom,sm8550-qmp-ufs-phy";
+			reg = <0x0 0x01d80000 0x0 0x2000>;
+			clock-names = "ref", "qref";
+			clocks = <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&tcsr TCSR_UFS_CLKREF_EN>;
+
+			power-domains = <&gcc UFS_MEM_PHY_GDSC>;
+
+			resets = <&ufs_mem_hc 0>;
+			reset-names = "ufsphy";
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+
+			#phy-cells = <0>;
+
+			#clock-cells = <1>;
+
+			ranges;
+
+			status = "disabled";
+		};
+
+		ufs_mem_hc: ufshc@1d84000 {
+			compatible = "qcom,sm8550-ufshc", "qcom,ufshc",
+				     "jedec,ufs-2.0";
+			reg = <0x0 0x01d84000 0x0 0x3000>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&ufs_mem_phy>;
+			phy-names = "ufsphy";
+			lanes-per-direction = <2>;
+			#reset-cells = <1>;
+			resets = <&gcc GCC_UFS_PHY_BCR>;
+			reset-names = "rst";
+
+			power-domains = <&gcc UFS_PHY_GDSC>;
+
+			iommus = <&apps_smmu 0x60 0x0>;
+
+			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
+
+			interconnect-names = "ufs-ddr", "cpu-ufs";
+			clock-names = "core_clk",
+				      "bus_aggr_clk",
+				      "iface_clk",
+				      "core_clk_unipro",
+				      "ref_clk",
+				      "tx_lane0_sync_clk",
+				      "rx_lane0_sync_clk",
+				      "rx_lane1_sync_clk";
+			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_UFS_PHY_AHB_CLK>,
+				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
+				 <&rpmhcc RPMH_LN_BB_CLK3>,
+				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
+			freq-table-hz =
+				<75000000 300000000>,
+				<0 0>,
+				<0 0>,
+				<75000000 300000000>,
+				<100000000 403000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>;
+			status = "disabled";
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0 0x01f40000 0 0x20000>;
-- 
2.34.1

