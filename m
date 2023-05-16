Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022CD705439
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjEPQmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjEPQmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:42:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BF1A5F1;
        Tue, 16 May 2023 09:41:58 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GEbKCS025457;
        Tue, 16 May 2023 15:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=7GmFsIyYLDO0Uzcku7fTuqy+8j8iq7zS8tmiHeE4lcc=;
 b=VzSFcI0YfkS4VIZbc1BI674coEvoMgqz7DzKjPMFkw/VZQ/rccifC0Moryt1gp5fWcsB
 YKTQSvytDItLpE1hcVDqdZmohgPk0geWqWtU69h2RWo73ubo8ay+DtyGV4JR9jjIhzLH
 s0yGqxhfT2E1pcZKpaGbuZMJIQRGy+LjRvQBWgByLrw0E9ZrK73mZZw72byQPLNNkvy+
 Gq3csGT7H5iNL4PdQnGsb1186Fj386fMDNSUcEB5v6+6GY/EFp0jthd2qkUBfCiQwxdO
 otdHvEMToBLZ1p8Ac1F5yNedwx5ycELPlY67fRtWmKAf70ULSxDI+fNGOWyBSRSQN9UU dA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qm6r3rxay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 15:49:18 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34GFnHZQ003434
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 15:49:17 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 16 May 2023 08:49:17 -0700
Date:   Tue, 16 May 2023 08:49:16 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc8280xp: Add SDC2 and enable on
 CRD
Message-ID: <20230516154916.GA606695@hu-bjorande-lv.qualcomm.com>
References: <20230509030136.1524860-1-quic_bjorande@quicinc.com>
 <20230509030136.1524860-2-quic_bjorande@quicinc.com>
 <0855c1ea-2104-c7ab-e775-1340dac21c58@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0855c1ea-2104-c7ab-e775-1340dac21c58@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: znyBCV67pOdHq29Cz0OLiUJUPV6Sp56j
X-Proofpoint-GUID: znyBCV67pOdHq29Cz0OLiUJUPV6Sp56j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_08,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160134
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 03:22:41AM +0200, Konrad Dybcio wrote:
> 
> 
> On 9.05.2023 05:01, Bjorn Andersson wrote:
> > The CRD has Micro SD slot, introduce the necessary DeviceTree nodes for
> > enabling this.
> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 80 +++++++++++++++++++++++
> >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi    | 39 +++++++++++
> >  2 files changed, 119 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > index 5b25d54b9591..f83411e0e7f8 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > @@ -308,6 +308,13 @@ vreg_l1c: ldo1 {
> >  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> >  		};
> >  
> > +		vreg_l6c: ldo6 {
> > +			regulator-name = "vreg_l6c";
> > +			regulator-min-microvolt = <1800000>;
> > +			regulator-max-microvolt = <2960000>;
> > +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> > +		};
> > +
> >  		vreg_l7c: ldo7 {
> >  			regulator-name = "vreg_l7c";
> >  			regulator-min-microvolt = <2504000>;
> > @@ -318,6 +325,13 @@ vreg_l7c: ldo7 {
> >  						   RPMH_REGULATOR_MODE_HPM>;
> >  		};
> >  
> > +		vreg_l9c: ldo9 {
> > +			regulator-name = "vreg_l9c";
> > +			regulator-min-microvolt = <2960000>;
> > +			regulator-max-microvolt = <2960000>;
> > +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> Generally I ask people to add the missing regulator-allow-set-load,
> but in case of the RPMh driver, should we also consider allowing LPM?
> 

I prefer to avoid LPM and dynamic load management, because I don't think
we're doing a good enough job across the kernel to ensure we get back to
HPM when needed.

At some point this needs to be re-evaluated though.

> > +		};
> > +
> >  		vreg_l13c: ldo13 {
> >  			regulator-name = "vreg_l13c";
> >  			regulator-min-microvolt = <3072000>;
> > @@ -600,6 +614,18 @@ &remoteproc_nsp0 {
> >  	status = "okay";
> >  };
> >  
> > +&sdc2 {
> > +	cd-gpios = <&tlmm 131 GPIO_ACTIVE_LOW>;
> > +	pinctrl-names = "default", "sleep";
> > +	pinctrl-0 = <&sdc2_default_state>;
> > +	pinctrl-1 = <&sdc2_sleep_state>;
> pinctrl-n
> pinctrl-names
> 
> please

That's ugly, but I see the symmetry to other -# vs -names

> > +	vmmc-supply = <&vreg_l9c>;
> > +	vqmmc-supply = <&vreg_l6c>;
> > +	no-sdio;
> > +	no-mmc;
> > +	status = "okay";
> > +};
> > +
> >  &uart17 {
> >  	compatible = "qcom,geni-debug-uart";
> >  
> > @@ -842,6 +868,60 @@ wake-n-pins {
> >  		};
> >  	};
> >  
> > +	sdc2_default_state: sdc2-default-state {
> > +		clk-pins {
> > +			pins = "sdc2_clk";
> > +			drive-strength = <16>;
> > +			bias-disable;
> > +		};
> > +
> > +		cmd-pins {
> > +			pins = "sdc2_cmd";
> > +			drive-strength = <16>;
> > +			bias-pull-up;
> > +		};
> > +
> > +		data-pins {
> > +			pins = "sdc2_data";
> > +			drive-strength = <16>;
> > +			bias-pull-up;
> > +		};
> > +
> > +		card-detect-pins {
> > +			pins = "gpio131";
> > +			function = "gpio";
> > +			drive-strength = <2>;
> > +			bias-disable;
> > +		};
> > +	};
> > +
> > +	sdc2_sleep_state: sdc2-sleep-state {
> > +		clk-pins {
> > +			pins = "sdc2_clk";
> > +			drive-strength = <2>;
> > +			bias-disable;
> > +		};
> > +
> > +		cmd-pins {
> > +			pins = "sdc2_cmd";
> > +			drive-strength = <2>;
> > +			bias-pull-up;
> > +		};
> > +
> > +		data-pins {
> > +			pins = "sdc2_data";
> > +			drive-strength = <2>;
> > +			bias-pull-up;
> > +		};
> > +
> > +		card-detect-pins {
> > +			pins = "gpio131";
> > +			function = "gpio";
> > +			drive-strength = <2>;
> > +			bias-disable;
> > +		};
> > +	};
> That's totally SoC-specific, modulo the CD pin which can have
> its own separate node and label
> 

The drive-strength and bias properties are board specific. Also, at this
time the CRD is the only board I'm aware of having the SD-card slot.

I suggest that we move it out of here once there's another user...

> > +
> >  	tpad_default: tpad-default-state {
> >  		int-n-pins {
> >  			pins = "gpio182";
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > index 8fa9fbfe5d00..21dfb48d923c 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -2815,6 +2815,45 @@ data-pins {
> >  			};
> >  		};
> >  
> > +		sdc2: mmc@8804000 {
> > +			compatible = "qcom,sc8280xp-sdhci", "qcom,sdhci-msm-v5";
> > +			reg = <0 0x08804000 0 0x1000>;
> > +
> > +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "hc_irq", "pwr_irq";
> > +
> > +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> > +				 <&gcc GCC_SDCC2_APPS_CLK>,
> > +				 <&rpmhcc RPMH_CXO_CLK>;
> > +			clock-names = "iface", "core", "xo";
> > +			resets = <&gcc GCC_SDCC4_BCR>;
> 4?
> 

That's a typo. Thanks.

> > +			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
> > +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
> > +			interconnect-names = "sdhc-ddr","cpu-sdhc";
> > +			iommus = <&apps_smmu 0x4e0 0x0>;
> > +			power-domains = <&rpmhpd SC8280XP_CX>;
> > +			operating-points-v2 = <&sdc2_opp_table>;
> > +			bus-width = <4>;
> > +			dma-coherent;
> > +
> > +			status = "disabled";
> > +
> > +			sdc2_opp_table: opp-table {
> > +				compatible = "operating-points-v2";
> > +
> > +				opp-100000000 {
> > +					opp-hz = /bits/ 64 <100000000>;
> > +					required-opps = <&rpmhpd_opp_low_svs>;
> You specified interconnects, but no bw values.. was that on purpose?
> 

Assumed the driver did something clever, when I didn't see anything for
the other boards I looked at either. Will reconsider.

> Other than these nits, lgtm
> (generally, my dt sources don't even have sdhci to compare)
> 

Thanks,
Bjorn

> Konrad
> > +				};
> > +
> > +				opp-202000000 {
> > +					opp-hz = /bits/ 64 <202000000>;
> > +					required-opps = <&rpmhpd_opp_svs_l1>;
> > +				};
> > +			};
> > +		};
> > +
> >  		usb_0_qmpphy: phy@88eb000 {
> >  			compatible = "qcom,sc8280xp-qmp-usb43dp-phy";
> >  			reg = <0 0x088eb000 0 0x4000>;
