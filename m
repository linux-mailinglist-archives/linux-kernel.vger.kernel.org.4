Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7969695386
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjBMV65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBMV64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:58:56 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321075B89;
        Mon, 13 Feb 2023 13:58:55 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DKJPcB026967;
        Mon, 13 Feb 2023 21:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=Mjk0/1iKPD0KOdoFhc789rALdju1bfj/uDkzDhz83Wc=;
 b=moptY7fZSKgUX5/Md/kBgvnhJkHHinAA9y0IQF/MnbXofxuk+CzM8Wwk6OBxxuje1xKM
 z4+1nsZtj7DjQFwNbp3C/avtzrSU35/5VLCMLy49JgVR3R2nn7Zs5PSULHfef7jJ+2Rh
 BcgsvXqsTdPLSCYJV2oSNDT6ikpIse6c8tj8JCCS0dvQhTeTcRTNNWZQdLF+WD/1YTTJ
 r53gQqYFI1Z97vblY6PYjRhOtWu8NEUA/abhcptqcCptA25M8N6l0T7zuLNkh7p3r5Vi
 dvjU6f4LgOvnLsqPf+ZbShuKJNhkLiCC6931cq0ZdM+BkU3M5Kyed4xugyFhrdKW+aAA aw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np389w40q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 21:58:47 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DLwlSb013322
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 21:58:47 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 13:58:46 -0800
Date:   Mon, 13 Feb 2023 13:58:45 -0800
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
Subject: Re: [PATCH v3 2/4] arm64: dts: qcom: sc8280xp-crd: Introduce
 pmic_glink
Message-ID: <20230213215845.GA1332049@hu-bjorande-lv.qualcomm.com>
References: <20230213162821.1253831-1-quic_bjorande@quicinc.com>
 <20230213162821.1253831-3-quic_bjorande@quicinc.com>
 <4a3964c8-8824-cb4e-9262-58b6a1cedc7c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4a3964c8-8824-cb4e-9262-58b6a1cedc7c@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tXxnFlNSE6coH12dz_A6Yk0EFsD7QW5I
X-Proofpoint-GUID: tXxnFlNSE6coH12dz_A6Yk0EFsD7QW5I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130190
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 09:44:14PM +0100, Konrad Dybcio wrote:
> 
> 
> On 13.02.2023 17:28, Bjorn Andersson wrote:
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
> > 
> [...]
> 
> > +&mdss0_dp0 {
> > +	data-lanes = <0 1>;
> > +	status = "okay";
> > +
> > +	ports {
> > +		port@1 {
> > +			reg = <1>;
> > +
> > +			mdss0_dp0_out: endpoint {
> > +				remote-endpoint = <&pmic_glink_con0_ss>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&mdss0_dp1 {
> > +	data-lanes = <0 1>;
> > +	status = "okay";
> > +
> > +	ports {
> > +		port@1 {
> > +			reg = <1>;
> This way you're redefining this node.. I suppose going with
> something like:
> 
> 8280:
> mdss0_dp1 {
> 	compatible
> 	blahblah
> 
> 	ports {
> 		[..]
> 
> 		port@1 {
> 		reg = <1>;
> 
> 			mdss0_dp1_out : endpoint {
> 			};
> 		};
> 	}
> }
> 
> crd:
> &mdss0_dp1_out {
> 	//btw data-lanes should be there and not in mdss_dp, I think
> 	remote-endpoint = <&pmic_glink_...>
> }
> 
> would be better, and that's what we're already doing for DSI..
> 

To summarize our private discussion about this; by aiming for not
repeating the structure from the dtsi we avoid a class of bugs caused by
typos between the two files. As such I agree that this is a good thing,
and have adjusted the structure accordingly in v4.

> I think I missed all this during the 8[34]50 review too..
> 
> With that addressed, for both crd and x13s (as the patch is essentially
> identical)
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 

Thanks,
Bjorn

> Konrad
> 
> > +
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
> > @@ -480,7 +628,6 @@ &usb_0 {
> >  };
> >  
> >  &usb_0_dwc3 {
> > -	/* TODO: Define USB-C connector properly */
> >  	dr_mode = "host";
> >  };
> >  
> > @@ -499,12 +646,15 @@ &usb_0_qmpphy {
> >  	status = "okay";
> >  };
> >  
> > +&usb_0_role_switch {
> > +	remote-endpoint = <&pmic_glink_con0_hs>;
> > +};
> > +
> >  &usb_1 {
> >  	status = "okay";
> >  };
> >  
> >  &usb_1_dwc3 {
> > -	/* TODO: Define USB-C connector properly */
> >  	dr_mode = "host";
> >  };
> >  
> > @@ -523,6 +673,10 @@ &usb_1_qmpphy {
> >  	status = "okay";
> >  };
> >  
> > +&usb_1_role_switch {
> > +	remote-endpoint = <&pmic_glink_con1_hs>;
> > +};
> > +
> >  &xo_board_clk {
> >  	clock-frequency = <38400000>;
> >  };
> > @@ -709,4 +863,54 @@ reset-n-pins {
> >  			drive-strength = <16>;
> >  		};
> >  	};
> > +
> > +	usb0_sbu_default: usb0-sbu-state {
> > +		oe-n-pins {
> > +			pins = "gpio101";
> > +			function = "gpio";
> > +			bias-disable;
> > +			drive-strengh = <16>;
> > +			output-high;
> > +		};
> > +
> > +		sel-pins {
> > +			pins = "gpio164";
> > +			function = "gpio";
> > +			bias-disable;
> > +			drive-strength = <16>;
> > +		};
> > +
> > +		mode-pins {
> > +			pins = "gpio167";
> > +			function = "gpio";
> > +			bias-disable;
> > +			drive-strength = <16>;
> > +			output-high;
> > +		};
> > +	};
> > +
> > +	usb1_sbu_default: usb1-sbu-state {
> > +		oe-n-pins {
> > +			pins = "gpio48";
> > +			function = "gpio";
> > +			bias-disable;
> > +			drive-strengh = <16>;
> > +			output-high;
> > +		};
> > +
> > +		sel-pins {
> > +			pins = "gpio47";
> > +			function = "gpio";
> > +			bias-disable;
> > +			drive-strength = <16>;
> > +		};
> > +
> > +		mode-pins {
> > +			pins = "gpio50";
> > +			function = "gpio";
> > +			bias-disable;
> > +			drive-strength = <16>;
> > +			output-high;
> > +		};
> > +	};
> >  };
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > index 92d5b5e21e50..7897d33f1416 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -3040,6 +3040,11 @@ usb_0_dwc3: usb@a600000 {
> >  				iommus = <&apps_smmu 0x820 0x0>;
> >  				phys = <&usb_0_hsphy>, <&usb_0_qmpphy QMP_USB43DP_USB3_PHY>;
> >  				phy-names = "usb2-phy", "usb3-phy";
> > +
> > +				port {
> > +					usb_0_role_switch: endpoint {
> > +					};
> > +				};
> >  			};
> >  		};
> >  
> > @@ -3095,6 +3100,11 @@ usb_1_dwc3: usb@a800000 {
> >  				iommus = <&apps_smmu 0x860 0x0>;
> >  				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
> >  				phy-names = "usb2-phy", "usb3-phy";
> > +
> > +				port {
> > +					usb_1_role_switch: endpoint {
> > +					};
> > +				};
> >  			};
> >  		};
> >  
