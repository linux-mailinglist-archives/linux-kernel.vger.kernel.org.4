Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D4168047A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 04:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbjA3D4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 22:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjA3D4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 22:56:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F68199CF;
        Sun, 29 Jan 2023 19:56:48 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U2r6iE009267;
        Mon, 30 Jan 2023 03:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=nMUqpJfEqCaLt+5V9B7XI/hB5JtWBR3jIuDXcbrVmBc=;
 b=WR22Ej/ThoF4y0CrMOhNoLC9LkVG/s8Fmwmqx3vatsiIQ84GKQfKwZ3j1XmFZiHUQN/r
 6/onFM7RAIS2TznOPUzxkHaqyHLaybdBeD48Asbz9WQ9d1ypODo66mwb27JcL5M03JDG
 XBZASG2AFOAzb2Dr6G7O0fb9vrJ4m4MVf5kNObzyJVMXZRVTQK6AtmtNUtpu10F0DpPZ
 6MScXJik1OjwhzoYtijNk9TQsxxnxcOU6wzbJZouMYzdcU2zzqCtTc9nf04kqCVCDqGg
 2GhEMqBcmAIMG55IqkGEohzOy4EQ9muu66Ifbt/hbS4IrosGC/72+ClqCkWaByodRNaQ 1A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncut2jt85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 03:56:44 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30U3uhR2021338
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 03:56:43 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 29 Jan 2023 19:56:43 -0800
Date:   Sun, 29 Jan 2023 19:56:42 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sa8295p-adp: Add max20411 on
 i2c12
Message-ID: <20230130035642.GA464800@hu-bjorande-lv.qualcomm.com>
References: <20230124184440.1421074-1-quic_bjorande@quicinc.com>
 <20230124184440.1421074-4-quic_bjorande@quicinc.com>
 <Y9OfiTDwFHN0RR5G@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9OfiTDwFHN0RR5G@hovoldconsulting.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: N96XEMkiD1o2PZ4546e40tzJWqt2nMIx
X-Proofpoint-ORIG-GUID: N96XEMkiD1o2PZ4546e40tzJWqt2nMIx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_01,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300036
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 10:55:21AM +0100, Johan Hovold wrote:
> On Tue, Jan 24, 2023 at 10:44:40AM -0800, Bjorn Andersson wrote:
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > The SA8295P ADP has a Maxim max20411 step-down converter on i2c12.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> > 
> > Changes since v1:
> > - i2c node had changed name
> > 
> >  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 41 ++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > index bb4270e8f551..642000d95812 100644
> > --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > @@ -266,6 +266,27 @@ &dispcc1 {
> >  	status = "okay";
> >  };
> >  
> > +&i2c12 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c12_state>;
> > +
> > +	status = "okay";
> > +
> > +	vdd_gfx: regulator@39 {
> 
> Nit: Should the label be named 'vreg_gfx' (or 'vreg_vdd_gfx)') for
> consistency with rest of the file?
> 

I will investigate what the appropriate name is, consistency would be
nice though.

> > +		compatible = "maxim,max20411";
> > +		reg = <0x39>;
> > +
> > +		regulator-name = "vdd_gfx";
> > +		regulator-min-microvolt = <800000>;
> > +		regulator-max-microvolt = <968750>;
> > +
> > +		enable-gpios = <&pmm8540a_gpios 2 GPIO_ACTIVE_HIGH>;
> > +
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&vdd_gfx_enable_state>;
> > +	};
> > +};
> > +
> >  &mdss0 {
> >  	status = "okay";
> >  };
> > @@ -476,6 +497,10 @@ &pcie4_phy {
> >  	status = "okay";
> >  };
> >  
> > +&qup1 {
> > +	status = "okay";
> > +};
> > +
> >  &qup2 {
> >  	status = "okay";
> >  };
> > @@ -636,7 +661,23 @@ &xo_board_clk {
> >  
> >  /* PINCTRL */
> >  
> > +&pmm8540a_gpios {
> > +	vdd_gfx_enable_state: vdd-gfx-enable-state {
> 
> For consistency with the rest of sc8280xp, can you rename this
> 
> 	vdd_gfx_en: vdd-gfx-en-state {
> 
> (i.e. drop the 'state' from the label and shorten 'enable')?
> 

Will do.

> > +		pins = "gpio2";
> > +		function = "normal";
> > +		output-enable;
> > +	};
> > +};
> > +
> >  &tlmm {
> > +	i2c12_state: i2c12-state {
> 
> Similar here, this should be
> 
> 	i2c12_default: i2c12-default-state {
> 

Sounds reasonable.

> > +		pins = "gpio0", "gpio1";
> > +		function = "qup12";
> > +
> 
> And this newline can be removed.
> 

Sure

> > +		drive-strength = <2>;
> > +		bias-pull-up;
> > +	};
> > +
> >  	pcie2a_default: pcie2a-default-state {
> >  		clkreq-n-pins {
> >  			pins = "gpio142";
> 
> Johan

Thanks Johan,
Bjorn
