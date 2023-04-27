Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1A96F0CB4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344037AbjD0TsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244531AbjD0TsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:48:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E1D1FE5;
        Thu, 27 Apr 2023 12:48:21 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RJk93R026674;
        Thu, 27 Apr 2023 19:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=uS57E0P/jYH51dce45zVkUhsqTQUFQmhzl0v2CZcm8Q=;
 b=Q1GV1rhj4tvJpFu4WZLKZtieQuqIJht6UF7v1sGcepkDlIQSjWXSVXdBRDEU728bi55W
 xbNUCfl2EiO0qCvcxEaWp6rhDuqay78ar7ZLnoeWI1N8IwpHterjXhgKOYdRX/hGYKqu
 kWTJjswojVadIddYW5b18dx8SapqIQ5cpWfrkdEvMO0RtYn95uW1WVuYB1rWx9qvxm47
 TNOHb4GO7FI6aOhAkRVVF7LZQPnZ5qoWBV+kwwIVjxf5dE0ywijAKtyY2Yb/9V1lb9cO
 s7gk1vUoVxE41qEIqkrFS+iF48BGrwTjGEytN/6Pz27aWQEj6bBEXDCqdpk4rNBlkR4c gA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q7yg4g060-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 19:48:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33RJmAxK000403
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 19:48:10 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Apr 2023 12:48:10 -0700
Date:   Thu, 27 Apr 2023 12:48:09 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sc8280xp-crd: Add QMP to
 SuperSpeed graph
Message-ID: <20230427194809.GA870858@hu-bjorande-lv.qualcomm.com>
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
 <20230425034010.3789376-7-quic_bjorande@quicinc.com>
 <aa94b488-cb6e-bd74-0711-b7c4c7589f7a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aa94b488-cb6e-bd74-0711-b7c4c7589f7a@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KLpkDm_TAjgLtD2s_1iOu_PmrdkCUUHH
X-Proofpoint-ORIG-GUID: KLpkDm_TAjgLtD2s_1iOu_PmrdkCUUHH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_09,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270173
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 12:33:44AM +0100, Konrad Dybcio wrote:
> 
> On 4/25/23 04:40, Bjorn Andersson wrote:
> > With support for the QMP combo phy to react to USB Type-C switch events,
> > introduce it as the next hop for the SuperSpeed lanes of the two USB
> > Type-C connectors, and connect the output of the DisplayPort controller
> > to the QMP combo phy.
> > 
> > This allows the TCPM to perform orientation switching of both USB and
> > DisplayPort signals.
> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >   arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 28 ++++++++++++++++---
> >   arch/arm64/boot/dts/qcom/sc8280xp.dtsi    | 34 +++++++++++++++++++++++
> >   2 files changed, 58 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > index 547277924ea3..33c973661fa5 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > @@ -64,7 +64,7 @@ port@1 {
> >   					reg = <1>;
> >   					pmic_glink_con0_ss: endpoint {
> > -						remote-endpoint = <&mdss0_dp0_out>;
> > +						remote-endpoint = <&usb_0_qmpphy_out>;
> >   					};
> >   				};
> > @@ -99,7 +99,7 @@ port@1 {
> >   					reg = <1>;
> >   					pmic_glink_con1_ss: endpoint {
> > -						remote-endpoint = <&mdss0_dp1_out>;
> > +						remote-endpoint = <&usb_1_qmpphy_out>;
> >   					};
> >   				};
> > @@ -412,7 +412,7 @@ &mdss0_dp0 {
> >   &mdss0_dp0_out {
> >   	data-lanes = <0 1>;
> > -	remote-endpoint = <&pmic_glink_con0_ss>;
> > +	remote-endpoint = <&usb_0_qmpphy_dp_in>;
> >   };
> >   &mdss0_dp1 {
> > @@ -421,7 +421,7 @@ &mdss0_dp1 {
> >   &mdss0_dp1_out {
> >   	data-lanes = <0 1>;
> > -	remote-endpoint = <&pmic_glink_con1_ss>;
> > +	remote-endpoint = <&usb_1_qmpphy_dp_in>;
> >   };
> >   &mdss0_dp3 {
> > @@ -670,9 +670,19 @@ &usb_0_qmpphy {
> >   	vdda-phy-supply = <&vreg_l9d>;
> >   	vdda-pll-supply = <&vreg_l4d>;
> > +	orientation-switch;
> 
> I believe this belongs in the SoC DTSI, as it's supported by
> the PHY block itself
> 

Sounds reasonable to me, will move it.

> 
> The rest seems to lgtm..
> 
> 
> On a note, why did we end up placing pmic_glink in device
> DTs? It's already assumed that we're using the full Qualcomm
> stack as we use PAS for remoteprocs so I *think* we can always
> assume pmic_glink would be there!
> 

In this particular case, sa8295p and sa8540p are derived from sc8280xp
dtsi, but those does not implement pmic_glink...
In most other cases I think your expectation would hold though.

Perhaps would be suitable to put the pmic_glink in sc8280xp.dtsi but
disable it, and then add connectors in the device.

Regards,
Bjorn

> Konrad
> 
> > +
> >   	status = "okay";
> >   };
> > +&usb_0_qmpphy_dp_in {
> > +	remote-endpoint = <&mdss0_dp0_out>;
> > +};
> > +
> > +&usb_0_qmpphy_out {
> > +	remote-endpoint = <&pmic_glink_con0_ss>;
> > +};
> > +
> >   &usb_0_role_switch {
> >   	remote-endpoint = <&pmic_glink_con0_hs>;
> >   };
> > @@ -697,9 +707,19 @@ &usb_1_qmpphy {
> >   	vdda-phy-supply = <&vreg_l4b>;
> >   	vdda-pll-supply = <&vreg_l3b>;
> > +	orientation-switch;
> > +
> >   	status = "okay";
> >   };
> > +&usb_1_qmpphy_dp_in {
> > +	remote-endpoint = <&mdss0_dp1_out>;
> > +};
> > +
> > +&usb_1_qmpphy_out {
> > +	remote-endpoint = <&pmic_glink_con1_ss>;
> > +};
> > +
> >   &usb_1_role_switch {
> >   	remote-endpoint = <&pmic_glink_con1_hs>;
> >   };
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > index 0e691bb0120c..1eb3a295e8fa 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -3006,6 +3006,23 @@ usb_0_qmpphy: phy@88eb000 {
> >   			#phy-cells = <1>;
> >   			status = "disabled";
> > +
> > +			ports {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				port@0 {
> > +					reg = <0>;
> > +
> > +					usb_0_qmpphy_out: endpoint {};
> > +				};
> > +
> > +				port@1 {
> > +					reg = <1>;
> > +
> > +					usb_0_qmpphy_dp_in: endpoint {};
> > +				};
> > +			};
> >   		};
> >   		usb_1_hsphy: phy@8902000 {
> > @@ -3042,6 +3059,23 @@ usb_1_qmpphy: phy@8903000 {
> >   			#phy-cells = <1>;
> >   			status = "disabled";
> > +
> > +			ports {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				port@0 {
> > +					reg = <0>;
> > +
> > +					usb_1_qmpphy_out: endpoint {};
> > +				};
> > +
> > +				port@1 {
> > +					reg = <1>;
> > +
> > +					usb_1_qmpphy_dp_in: endpoint {};
> > +				};
> > +			};
> >   		};
> >   		mdss1_dp0_phy: phy@8909a00 {
