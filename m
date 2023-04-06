Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29086D9DCF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbjDFQq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbjDFQq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:46:57 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98604A5DF;
        Thu,  6 Apr 2023 09:46:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680799568; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oE19mkzv/CNS5XuMRaOY7TrBMHY12yrbD1+cFeJJvIEPNEWc5pnF+Dqn/E7sDQBnGv
    T4S2dDZfHPmya+29cAPv2+Odjpps5nZCcA1vAnQmkvVZML+zFfPE+qDvNYKEadACkBF+
    fFbMQD7CJc+sLaH0zhiMY1mKa9ZzMtDyrilnm5L8HiPofJBhOPzmGgsvrPBWXhRqMWja
    mGFF879PrpTCs+Z+OEWUVWDt39k90Yt6mR93yvKEw853nGltVtHlzhz3HCuxqrVDFHxM
    FhWIArUqY0PODqagFjeSr8i5K8pMszRwbmB5vff5qkKX0weL/FWiXqMDyCuDKty1qu8n
    ye5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680799568;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=c3bjQR2QOWVeZlS0UtDjxrHT/QD0mgGnFhhfaYFB3KA=;
    b=HT6/SzIrXK+t2VEebtaksHGqO4D71pIVJVHQZsFl7yeEELvCW3XRsq7IDGkR5gj3wj
    Uhx6QaNdL6ZOfP+bAXqmHhvOUeGVnFH7f8eFTzx/QrA0iXLqy5SOHH/i3vi6St70n1tZ
    YaAFULPQBRTZdsEtt85CLfULkh1pSWJ1Caecvq93NcBv0RCxNQa1Y4XMpbfphjGMM8Bv
    LrDevtjYirdfnTudwcIrTO1IPXXnkStN8mq8682afHZDHPzNW0JN0y0Ti7mqJCl0sKmY
    VMafGSHsvFz9L5WRaVrfEKA3hS7u/AeG/xpiMEgy3fehp0i0uPmAhevdkzzF1+taPwxc
    +Hkg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680799568;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=c3bjQR2QOWVeZlS0UtDjxrHT/QD0mgGnFhhfaYFB3KA=;
    b=UpR178p1XlvNpnIXM9HGj7j6fkVRV1jRWloaKYVE0VNb1I3AsTbUVnwapBMbuIMPyG
    yeB/RZV9md6mxvW6fAVXXbObG3xO6GZ4nEbGr0n+NwW7ZoQ8NNbIrAj2J/npXI0l0SCD
    wUMxtDyY8paVWYD+IVP2BXwEfWEM5uRIZI9CoDLxj56P83ITT4lLZLVad6xiXlFNrpP+
    2G5opAURkweN2oDbKz9aEepCdVbfbh3UVYW0z6ShSWXOQ+rUPPkV1JXZ5rcUNP0mUg64
    xOz6MdOUo45eaRuUbStvYfgGJETxMwBBgc0TGHToViVMj6eg40JHd7xpuDcOIFILMQg2
    Gg2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1680799568;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=c3bjQR2QOWVeZlS0UtDjxrHT/QD0mgGnFhhfaYFB3KA=;
    b=H3Lis9TgkTguTOTZMQbZrpBnHObAcOXeuRveIB/t7c1MZc5CdsDPYGviDTszB+pof5
    t1tF/abwev/S3mSmdHAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA+pvh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az36Gk7D4R
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 6 Apr 2023 18:46:07 +0200 (CEST)
Date:   Thu, 6 Apr 2023 18:46:06 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: Re: [PATCH v8 2/5] arm64: dts: qcom: Add msm8939 SoC
Message-ID: <ZC73TlrYP9I4zvGP@gerhold.net>
References: <20230330153222.2875121-1-bryan.odonoghue@linaro.org>
 <20230330153222.2875121-3-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330153222.2875121-3-bryan.odonoghue@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 04:32:19PM +0100, Bryan O'Donoghue wrote:
> Add msm8939 a derivative SoC of msm8916. This SoC contains a number of key
> differences to msm8916.
> 
> - big.LITTLE Octa Core - quad 1.5GHz + quad 1.0GHz
> - DRAM 1x800 LPDDR3
> - Camera 4+4 lane CSI
> - Venus @ 1080p60 HEVC
> - DSI x 2
> - Adreno A405
> - WiFi wcn3660/wcn3680b 802.11ac
> [...]
> ---
>  arch/arm64/boot/dts/qcom/msm8939.dtsi | 2454 +++++++++++++++++++++++++
>  1 file changed, 2454 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8939.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> new file mode 100644
> index 0000000000000..96b25dfc4d3f1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> @@ -0,0 +1,2454 @@
> [...]
> +		tsens: thermal-sensor@4a9000 {
> +			compatible = "qcom,msm8939-tsens", "qcom,tsens-v0_1";
> +			reg = <0x004a9000 0x1000>, /* TM */
> +			      <0x004a8000 0x1000>; /* SROT */
> +			nvmem-cells = <&tsens_mode>,
> +				      <&tsens_base1>, <&tsens_base2>,
> +				      <&tsens_s0_p1>, <&tsens_s0_p2>,
> +				      <&tsens_s1_p1>, <&tsens_s1_p2>,
> +				      <&tsens_s2_p1>, <&tsens_s2_p2>,
> +				      <&tsens_s3_p1>, <&tsens_s3_p2>,
> +				      <&tsens_s4_p1>, <&tsens_s4_p2>,
> +				      <&tsens_s4_p1>, <&tsens_s4_p2>,
> +				      <&tsens_s5_p1>, <&tsens_s5_p2>,
> +				      <&tsens_s6_p1>, <&tsens_s6_p2>,
> +				      <&tsens_s7_p1>, <&tsens_s7_p2>,
> +				      <&tsens_s8_p1>, <&tsens_s8_p2>;
> +			nvmem-cell-names = "mode",
> +					   "base1", "base2",
> +					   "s0_p1", "s0_p2",
> +					   "s1_p1", "s1_p2",
> +					   "s2_p1", "s2_p2",
> +					   "s3_p1", "s3_p2",
> +					   "s4_p1", "s4_p2",
> +					   "s4_p1", "s4_p2",

I know you're working on this already so just for completeness:

We discussed in the chat that there should be no s4 here at all since
sensor hwid=4 is not used on MSM8939. I think all the definitions are
already correct so you just need to rename s4 -> s5, s5 -> s6, s6 -> s7,
s8 -> s9.

> +					   "s5_p1", "s5_p2",
> +					   "s6_p1", "s6_p2",
> +					   "s7_p1", "s7_p2",
> +					   "s8_p1", "s8_p2";
> +			#qcom,sensors = <9>;
> +			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "uplow";
> +			#thermal-sensor-cells = <1>;
> +		};
> [...]
> +		pronto: remoteproc@a204000 {
> +			compatible = "qcom,pronto-v2-pil", "qcom,pronto";
> +			interrupts-extended = <&intc GIC_SPI 149 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcnss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcnss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcnss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog",
> +					  "fatal",
> +					  "ready",
> +					  "handover",
> +					  "stop-ack";
> +			reg = <0x0a204000 0x2000>,
> +			      <0x0a202000 0x1000>,
> +			      <0x0a21b000 0x3000>;
> +			reg-names = "ccu", "dxe", "pmu";
> +
> +			memory-region = <&wcnss_mem>;
> +
> +			power-domains = <&rpmpd MSM8939_VDDCX>,
> +					<&rpmpd MSM8939_VDDMX>;
> +			power-domain-names = "cx", "mx";
> +
> +			qcom,smem-states = <&wcnss_smp2p_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&wcnss_pin_a>;
> +
> +			status = "disabled";
> +
> +			iris {
> +				compatible = "qcom,wcn3620";
> +				clocks = <&rpmcc RPM_SMD_RF_CLK2>;
> +				clock-names = "xo";
> +			};

Since it looks like another version is needed to fix the tsens problem,
I'd appreciate if you squash in the following diffs for consistency with
my WCNSS compatible change for 8916: Could also send it as follow-up
later though.

Thanks,
Stephan

diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
index 5f68925434c8..e75ee34cb014 100644
--- a/arch/arm64/boot/dts/qcom/apq8039-t2.dts
+++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
@@ -147,14 +147,6 @@ &pm8916_gpios {
 		"PM_GPIO4";
 };
 
-&pronto {
-	status = "okay";
-
-	iris {
-		compatible = "qcom,wcn3680";
-	};
-};
-
 &smd_rpm_regulators {
 	vdd_l1_l2_l3-supply = <&pm8916_s3>;
 	vdd_l4_l5_l6-supply = <&pm8916_s4>;
@@ -490,3 +482,11 @@ &wcd_codec {
 	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
 	status = "okay";
 };
+
+&wcnss {
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3680";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
index cb47bb2413a7..89cceb0c4960 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
@@ -51,14 +51,6 @@ usb_id_default: usb-id-default-state {
 	};
 };
 
-&pronto {
-	status = "okay";
-
-	iris {
-		compatible = "qcom,wcn3660";
-	};
-};
-
 &smd_rpm_regulators {
 	vdd_l1_l2_l3-supply = <&pm8916_s3>;
 	vdd_l4_l5_l6-supply = <&pm8916_s4>;
@@ -182,3 +174,11 @@ &usb {
 &usb_hs_phy {
 	extcon = <&usb_id>;
 };
+
+&wcnss {
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3660";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 96b25dfc4d3f..c15ff24abd30 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -1955,7 +1955,7 @@ usb_hs_phy: phy {
 			};
 		};
 
-		pronto: remoteproc@a204000 {
+		wcnss: remoteproc@a204000 {
 			compatible = "qcom,pronto-v2-pil", "qcom,pronto";
 			interrupts-extended = <&intc GIC_SPI 149 IRQ_TYPE_EDGE_RISING>,
 					      <&wcnss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
@@ -1986,8 +1986,8 @@ pronto: remoteproc@a204000 {
 
 			status = "disabled";
 
-			iris {
-				compatible = "qcom,wcn3620";
+			wcnss_iris: iris {
+				/* Separate chip, compatible is board-specific */
 				clocks = <&rpmcc RPM_SMD_RF_CLK2>;
 				clock-names = "xo";
 			};
@@ -2004,13 +2004,13 @@ wcnss {
 					compatible = "qcom,wcnss";
 					qcom,smd-channels = "WCNSS_CTRL";
 
-					qcom,mmio = <&pronto>;
+					qcom,mmio = <&wcnss>;
 
-					bluetooth {
+					wcnss_bt: bluetooth {
 						compatible = "qcom,wcnss-bt";
 					};
 
-					wifi {
+					wcnss_wifi: wifi {
 						compatible = "qcom,wcnss-wlan";
 
 						interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,

