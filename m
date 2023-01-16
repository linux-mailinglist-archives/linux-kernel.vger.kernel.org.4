Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBAE66C22C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjAPO0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjAPO01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:26:27 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9893FF1C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:10:29 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id az20so49287138ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ADJXZ8kNsgv3vcrTQzysSsEWOj1WOI4LxJL3Kvfr5dM=;
        b=KcRVOHaYBJvNxPvlZAP8dXYYf/AAs0EdCHAX1OubPlt++a06CkeHn3Y9g3CUQEuYp1
         vPkBkZcp4JgdzNCrcQVXJM25JFuNb8Q/c8GaYE40YRaZudYtD7e/s/F86O9PoEqduy2t
         1m+6ZA7KlF/k/2Dze/KQ/ghuG97COwzY0UzIbjyjSocuyOCFw1ytQfMo2JwefWHrNRm3
         cEbg/e7CS8kwaHZyx2WED5Zq/0vpOxFXVTIc3UGKMYDpQm1/J6/if2At0WREoMJex68D
         j3FDzUNSPQAGfbvOj/xPdP3Rnk66U4Komo7Cj6jIp4rCyGP8IeM42lDjJswKh8BVnrHs
         piFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADJXZ8kNsgv3vcrTQzysSsEWOj1WOI4LxJL3Kvfr5dM=;
        b=RPdRFDpRNSFRmM36FHm+8ymtHkWUMzQxpDgpps8kKMNbAvOEQb8MvSXdyBwD0b/Du5
         2Hrazr8HjW5B5IgLPHBjp831kJC1ufCgpKTKFpBsJm/cWkhTkAxoDpL8AxKtstw/DRlT
         Av/iWPUx9d+EeIs9gFocgo5B83kHdigJB3pLEaMNe2BQ0imS9Yw8UX4UMrMb+KIZQcTW
         Wpe4uKrX9F4Ug68bRcugK65ZUPklxBzLkDr1QXHdIG68vNqavdhgGSxcOu3JL8/FaozS
         cYJ/LHMGWi+9o9U8pEw+kNQLTzoAtmofwM1qviy7vk7a+ybNpsOtMjWNAsxYcHPyg/UY
         Blrg==
X-Gm-Message-State: AFqh2krFtWjNjNYvrGsMMTCFQWSGteqCiyL/Tf2Muk+2kA1d4ZdoUwcn
        u6vwW5xeKL5YLFGEL76kbUgrRg==
X-Google-Smtp-Source: AMrXdXuqLnI363kobIndikhQNFwzd6Lx+VZdNIHk+U/Wpmpxs/Dr86HRpUDxXn14YqZiPBKjvsVIuw==
X-Received: by 2002:a17:906:d4a:b0:7bd:43e9:d3ab with SMTP id r10-20020a1709060d4a00b007bd43e9d3abmr12803479ejh.52.1673878209601;
        Mon, 16 Jan 2023 06:10:09 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b0084d368b1628sm10704150ejc.40.2023.01.16.06.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 06:10:08 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 1/2] arm64: dts: qcom: sm8550: Add UFS host controller and phy nodes
Date:   Mon, 16 Jan 2023 16:09:59 +0200
Message-Id: <20230116141000.1831351-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UFS host controller and PHY nodes.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v2:
 * reversed phy clocks and changed their names to ref and ref_aux
 * dropped both address-cells and size-cells from phy node
 * dropped the extra newline
 * moved #clocks-cells above #phy-cells
 * dropped ranges property
 * renamed ufshc to ufs
 * replaced RPMH_LN_BB_CLK3 clock with TCSR_UFS_PAD_CLKREF_EN for the
   ufs host controller node
 * added required-opps property to the ufs host controller node

 arch/arm64/boot/dts/qcom/sm8550.dtsi | 73 ++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 59756ec11564..3d47281a276b 100644
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
 
@@ -1571,6 +1571,73 @@ crypto: crypto@1de0000 {
 			interconnect-names = "memory";
 		};
 
+		ufs_mem_phy: phy@1d80000 {
+			compatible = "qcom,sm8550-qmp-ufs-phy";
+			reg = <0x0 0x01d80000 0x0 0x2000>;
+			clocks = <&tcsr TCSR_UFS_CLKREF_EN>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+			clock-names = "ref", "ref_aux";
+
+			power-domains = <&gcc UFS_MEM_PHY_GDSC>;
+
+			resets = <&ufs_mem_hc 0>;
+			reset-names = "ufsphy";
+
+			#clock-cells = <1>;
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		ufs_mem_hc: ufs@1d84000 {
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
+			required-opps = <&rpmhpd_opp_nom>;
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
+				 <&tcsr TCSR_UFS_PAD_CLKREF_EN>,
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

