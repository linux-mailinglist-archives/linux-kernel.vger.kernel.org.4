Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D314567F50C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 06:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjA1FnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 00:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbjA1FnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 00:43:08 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDACE19686
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 21:43:05 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9so6928456pll.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 21:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/8VxpsHV5WKUuSdcC12zr6rfa3YLWkOF8OKQA8HH7Pw=;
        b=yNVhadQdNEzFR3QzmUk6DP0j5rURrnaO7xTF1izrpoNBEfXaGt177Wd+S0rSuCHgX0
         t6FE5XYq0J/Wh/VJ0vmDNHnkmeX+1eznr5gMmzaI0apjX9Gg9w/FMEpcVNo5P+gqSqpz
         9145+9eNCL07tZC+a93bO2Q18242OYkW6C9KleXUThUo4YuAqc8Y5lH+kaSr0cTO79Qy
         EbX3lYJhyS4RtvrSCy0flENaaf70Dfkx0H93tKvaEWkhcHm9v7nuHzclokdJmLH5IzB1
         HDqFug0GyOBwE1+CyWNkktu6zVYWAx6W0vejpdcGwa7Kdz6L1Ywideb8Smb/K4wFHtY7
         HOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8VxpsHV5WKUuSdcC12zr6rfa3YLWkOF8OKQA8HH7Pw=;
        b=ic2ts+LVX13rdyCfGIjD8fp5U7oywOMoeq9Sdt9yNGb08fDMV1rX5i/dDAwzYeclac
         1B8ttoFvQODn7ZUZadKiVykqj4r4H8yQuriMzD4kskCVmGoVeUgC+BGeD6B0pMUWxua7
         onDefJleacG/XeQqrrC8Dx53GkSyW9WO22TWqneujuSyKrgEba3QD60ezWXHD4IMLzCW
         DOyQnOhUTcSpAfZVwMHLA7RRobSaxkSHgUM2k7FQmjS2lbIfv5Qu5daFDhvKZPdx1cNS
         YgioPo/JdYGX2q6enhh4O+/+R2LFwueynd/Lbg3GF6jGJyS3rfkpv+umXhkUpBxOns16
         0CoA==
X-Gm-Message-State: AO0yUKUo7DEwoBDmxd7eOp3ZLkTvhSP+6I5xynRDsnzATQ37dPdsPAka
        1/tpCxuEfRLUT73gHLeUV10utg==
X-Google-Smtp-Source: AK7set+RI9a8eoE9bIEwgagbR47Be5Hxl5I1KNRdY4e5CP3wOgr/IWCKymk6YXZ6J1Coivgm4nNntw==
X-Received: by 2002:a17:903:41d0:b0:196:3096:82a4 with SMTP id u16-20020a17090341d000b00196309682a4mr13171934ple.63.1674884585292;
        Fri, 27 Jan 2023 21:43:05 -0800 (PST)
Received: from localhost.localdomain ([223.233.74.24])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902b60d00b001947982eb8fsm2041317pls.60.2023.01.27.21.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 21:43:04 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, linux-remoteproc@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sm6115: Add remoteproc nodes
Date:   Sat, 28 Jan 2023 11:12:56 +0530
Message-Id: <20230128054256.2100501-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
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

Add the adsp, cdsp and modem remoteproc nodes to sm6115.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
- Depends on the dt-binding and driver change submitted via [1].
[1]. https://lore.kernel.org/linux-arm-msm/20230128053504.2099620-1-bhupesh.sharma@linaro.org

 arch/arm64/boot/dts/qcom/sm6115.dtsi | 184 +++++++++++++++++++++++++++
 1 file changed, 184 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 3c66f998a81b..3540cd24af5c 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1309,6 +1309,39 @@ dispcc: clock-controller@5f00000 {
 			#power-domain-cells = <1>;
 		};
 
+		remoteproc_mpss: remoteproc@6080000 {
+			compatible = "qcom,sm6115-mpss-pas";
+			reg = <0x06080000 0x100>;
+
+			interrupts-extended = <&intc GIC_SPI 307 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready", "handover",
+					  "stop-ack", "shutdown-ack";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
+
+			power-domains = <&rpmpd SM6115_VDDCX>;
+
+			memory-region = <&pil_modem_mem>;
+
+			qcom,smem-states = <&modem_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 68 IRQ_TYPE_EDGE_RISING>;
+				label = "mpss";
+				qcom,remote-pid = <1>;
+				mboxes = <&apcs_glb 12>;
+			};
+		};
+
 		stm@8002000 {
 			compatible = "arm,coresight-stm", "arm,primecell";
 			reg = <0x08002000 0x1000>,
@@ -1921,6 +1954,157 @@ funnel_apss1_in: endpoint {
 			};
 		};
 
+		remoteproc_adsp: remoteproc@ab00000 {
+			compatible = "qcom,sm6115-adsp-pas";
+			reg = <0x0ab00000 0x100>;
+
+			interrupts-extended = <&intc GIC_SPI 282 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
+
+			power-domains = <&rpmpd SM6115_VDD_LPI_CX>,
+					<&rpmpd SM6115_VDD_LPI_MX>;
+
+			memory-region = <&pil_adsp_mem>;
+
+			qcom,smem-states = <&adsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 277 IRQ_TYPE_EDGE_RISING>;
+				label = "lpass";
+				qcom,remote-pid = <2>;
+				mboxes = <&apcs_glb 8>;
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "adsp";
+					qcom,non-secure-domain;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&apps_smmu 0x01c3 0x0>;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&apps_smmu 0x01c4 0x0>;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&apps_smmu 0x01c5 0x0>;
+					};
+
+					compute-cb@6 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <6>;
+						iommus = <&apps_smmu 0x01c6 0x0>;
+					};
+
+					compute-cb@7 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <7>;
+						iommus = <&apps_smmu 0x01c7 0x0>;
+					};
+				};
+			};
+		};
+
+		remoteproc_cdsp: remoteproc@b300000 {
+			compatible = "qcom,sm6115-cdsp-pas";
+			reg = <0x0b300000 0x100000>;
+
+			interrupts-extended = <&intc GIC_SPI 265 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
+
+			power-domains = <&rpmpd SM6115_VDDCX>;
+
+			memory-region = <&pil_cdsp_mem>;
+
+			qcom,smem-states = <&cdsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 261 IRQ_TYPE_EDGE_RISING>;
+				label = "cdsp";
+				qcom,remote-pid = <5>;
+				mboxes = <&apcs_glb 28>;
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "cdsp";
+					qcom,non-secure-domain;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					compute-cb@1 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <1>;
+						iommus = <&apps_smmu 0x0c01 0x0>;
+					};
+
+					compute-cb@2 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <2>;
+						iommus = <&apps_smmu 0x0c02 0x0>;
+					};
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&apps_smmu 0x0c03 0x0>;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&apps_smmu 0x0c04 0x0>;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&apps_smmu 0x0c05 0x0>;
+					};
+
+					compute-cb@6 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <6>;
+						iommus = <&apps_smmu 0x0c06 0x0>;
+					};
+
+					/* note: secure cb9 in downstream */
+				};
+			};
+		};
+
 		apps_smmu: iommu@c600000 {
 			compatible = "qcom,sm6115-smmu-500", "qcom,smmu-500", "arm,mmu-500";
 			reg = <0x0c600000 0x80000>;
-- 
2.38.1

