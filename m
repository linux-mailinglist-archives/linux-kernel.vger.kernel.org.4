Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC69F68F2A0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjBHP6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjBHP5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:57:34 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6177849550;
        Wed,  8 Feb 2023 07:57:33 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318B1psh013972;
        Wed, 8 Feb 2023 15:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=WvEYyYHrSEfqBPCDABOTYilBuhKZZTT/0HAS0zk+d2w=;
 b=kTFuQxNGNrh80GzITqkVPuNRbBDaq9nGihF3/3h02+nOrj5BAOW1lqgXAI3zrJPJYf07
 oI8mjIxnug3mNeK9u9cqjxhHK0OaDFViTkQVmgzAhfeYrwhRxZ7EKRBt/HSez53aGIq9
 ZuOsLSPH2fUsMMDOejUNgBwmj4/pAEmd4uqky4a4+VUHqIz3zjdV7K4GlFf4Zj5rJUeY
 0WhMhiUTXeepvXI+prl7TwC/sy7dBQ8TMTjgnA1bYXg/QLfI0maoYkhyJOXyemiYh374
 ASrkGyd+KSl8eJUjC9liZIoLTO5/ORGf2f6K0a5QCIeCmKQWW3+aTYp+kg9Y7tAzdabB lg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkgafmmy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 15:57:23 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 318FvMxS026158
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 15:57:22 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 8 Feb 2023 07:57:21 -0800
Date:   Wed, 8 Feb 2023 07:57:20 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sc8280xp-crd: Introduce pmic_glink
Message-ID: <20230208155720.GA2397622@hu-bjorande-lv.qualcomm.com>
References: <20230208034620.2048744-1-quic_bjorande@quicinc.com>
 <20230208034620.2048744-3-quic_bjorande@quicinc.com>
 <229edfec-736f-d94d-23ba-2a0649639556@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <229edfec-736f-d94d-23ba-2a0649639556@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -LsD8rgZKXBCgeAPkSP5f1eTxTNQmrJ-
X-Proofpoint-ORIG-GUID: -LsD8rgZKXBCgeAPkSP5f1eTxTNQmrJ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_06,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302080141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 09:14:46AM +0100, Konrad Dybcio wrote:
> 
> 
> On 8.02.2023 04:46, Bjorn Andersson wrote:
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > The SC8280XP CRD control over battery management and its two USB Type-C
> > port using pmic_glink and two GPIO-based SBU muxes.
> > 
> > Enable the two DisplayPort instances, GPIO SBU mux instance and
> > pmic_glink with the two connectors on the CRD.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 191 +++++++++++++++++++++-
> >  1 file changed, 189 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > index 3f116a879e22..35b63c3962f0 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > @@ -36,6 +36,77 @@ chosen {
> >  		stdout-path = "serial0:115200n8";
> >  	};
> >  
> > +	pmic-glink {
> > +		compatible = "qcom,sc8280xp-pmic-glink", "qcom,pmic-glink";
> > +
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		connector@0 {
> > +			compatible = "usb-c-connector";
> > +			reg = <0>;
> > +			power-role = "dual";
> > +			data-role = "dual";
> > +
> > +			ports {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> Add a newline between the last propreties and first subnodes, please.
> 
> > +				port@0 {
> > +					reg = <0>;
> > +					pmic_glink_con0_hs: endpoint {
> > +						remote-endpoint = <&usb_0_role_switch>;
> > +					};
> > +				};
> > +
> > +				port@1 {
> > +					reg = <1>;
> > +					pmic_glink_con0_ss: endpoint {
> > +						remote-endpoint = <&mdss0_dp0_out>;
> > +					};
> > +				};
> > +
> > +				port@2 {
> > +					reg = <2>;
> > +					pmic_glink_con0_sbu: endpoint {
> > +						remote-endpoint = <&usb0_sbu_mux>;
> > +					};
> > +				};
> > +			};
> > +		};
> > +
> > +		connector@1 {
> > +			compatible = "usb-c-connector";
> > +			reg = <1>;
> > +			power-role = "dual";
> > +			data-role = "dual";
> > +
> > +			ports {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				port@0 {
> > +					reg = <0>;
> > +					pmic_glink_con1_hs: endpoint {
> > +						remote-endpoint = <&usb_1_role_switch>;
> > +					};
> > +				};
> > +
> > +				port@1 {
> > +					reg = <1>;
> > +					pmic_glink_con1_ss: endpoint {
> > +						remote-endpoint = <&mdss0_dp1_out>;
> > +					};
> > +				};
> > +
> > +				port@2 {
> > +					reg = <2>;
> > +					pmic_glink_con1_sbu: endpoint {
> > +						remote-endpoint = <&usb1_sbu_mux>;
> > +					};
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> >  	vreg_edp_3p3: regulator-edp-3p3 {
> >  		compatible = "regulator-fixed";
> >  
> > @@ -139,6 +210,46 @@ linux,cma {
> >  			linux,cma-default;
> >  		};
> >  	};
> > +
> > +	usb0-sbu-mux {
> > +		compatible = "pericom,pi3usb102", "gpio-sbu-mux";
> > +
> > +		enable-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
> > +		select-gpios = <&tlmm 164 GPIO_ACTIVE_HIGH>;
> > +
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&usb0_sbu_default>;
> > +
> > +		mode-switch;
> > +		orientation-switch;
> > +		svid = /bits/ 16 <0xff01>;
> > +
> > +		port {
> > +			usb0_sbu_mux: endpoint {
> > +				remote-endpoint = <&pmic_glink_con0_sbu>;
> > +			};
> > +		};
> > +	};
> > +
> > +	usb1-sbu-mux {
> > +		compatible = "pericom,pi3usb102", "gpio-sbu-mux";
> > +
> > +		enable-gpios = <&tlmm 48 GPIO_ACTIVE_LOW>;
> > +		select-gpios = <&tlmm 47 GPIO_ACTIVE_HIGH>;
> > +
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&usb1_sbu_default>;
> > +
> > +		mode-switch;
> > +		orientation-switch;
> > +		svid = /bits/ 16 <0xff01>;
> > +
> > +		port {
> > +			usb1_sbu_mux: endpoint {
> > +				remote-endpoint = <&pmic_glink_con1_sbu>;
> > +			};
> > +		};
> > +	};
> >  };
> >  
> >  &apps_rsc {
> > @@ -262,6 +373,36 @@ &mdss0 {
> >  	status = "okay";
> >  };
> >  
> > +&mdss0_dp0 {
> > +	status = "okay";
> > +
> > +	data-lanes = <0 1>;
> Status last; is this really only 2 lanes?
> 
> > +
> > +	ports {
> > +		port@1 {
> > +			reg = <1>;
> > +			mdss0_dp0_out: endpoint {
> > +				remote-endpoint = <&pmic_glink_con0_ss>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&mdss0_dp1 {
> > +	status = "okay";
> > +
> > +	data-lanes = <0 1>;
> Ditto
> 
> > +
> > +	ports {
> > +		port@1 {
> > +			reg = <1>;
> > +			mdss0_dp1_out: endpoint {
> > +				remote-endpoint = <&pmic_glink_con1_ss>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> >  &mdss0_dp3 {
> >  	compatible = "qcom,sc8280xp-edp";
> >  	/delete-property/ #sound-dai-cells;
> > @@ -480,8 +621,13 @@ &usb_0 {
> >  };
> >  
> >  &usb_0_dwc3 {
> > -	/* TODO: Define USB-C connector properly */
> >  	dr_mode = "host";
> > +
> > +	port {
> > +		usb_0_role_switch: endpoint {
> > +			remote-endpoint = <&pmic_glink_con0_hs>;
> > +		};
> This should be defined in the SoC DTSI, it's a standard dwc3 binding
> with usb HS / SS / SBU ports. Especially since we can feed the endpoint
> from any device now, as pmic-glink should work everywhere.
> 

The sa8295p/sa8540p boards, derived from sc8280xp does not implement
pmic_glink, so it seems moving this to the soc.dtsi would be messy.

> Or /omit-if-no-ref/, I suppose.
> 

Or you're saying I should put the skeleton of the port definition in the
soc.dtsi and then fill it out the remote-endpoint here; and mark it
omit-if-no-ref to avoid binding warnings?

> > +	};
> >  };
> >  
> >  &usb_0_hsphy {
> > @@ -504,8 +650,13 @@ &usb_1 {
> >  };
> >  
> >  &usb_1_dwc3 {
> > -	/* TODO: Define USB-C connector properly */
> >  	dr_mode = "host";
> > +
> > +	port {
> > +		usb_1_role_switch: endpoint {
> > +			remote-endpoint = <&pmic_glink_con1_hs>;
> > +		};
> > +	};
> >  };
> >  
> >  &usb_1_hsphy {
> > @@ -709,4 +860,40 @@ reset-n-pins {
> >  			drive-strength = <16>;
> >  		};
> >  	};
> > +
> > +	usb0_sbu_default: usb0-sbu-state {
> > +		oe-n-pins {
> > +			pins = "gpio101";
> > +			function = "gpio";
> No drive-strength/bias/i/o?
> 

Seems like a reasonable ask...

Thanks,
Bjorn

> Konrad
> > +		};
> > +
> > +		sel-pins {
> > +			pins = "gpio164";
> > +			function = "gpio";
> > +		};
> > +
> > +		mode-pins {
> > +			pins = "gpio167";
> > +			function = "gpio";
> > +			output-high;
> > +		};
> > +	};
> > +
> > +	usb1_sbu_default: usb1-sbu-state {
> > +		oe-n-pins {
> > +			pins = "gpio48";
> > +			function = "gpio";
> > +		};
> > +
> > +		sel-pins {
> > +			pins = "gpio47";
> > +			function = "gpio";
> > +		};
> > +
> > +		mode-pins {
> > +			pins = "gpio50";
> > +			function = "gpio";
> > +			output-high;
> > +		};
> > +	};
> >  };
