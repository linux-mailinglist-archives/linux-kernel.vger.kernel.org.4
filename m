Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1992737CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjFUHuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjFUHuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:50:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB80C11D;
        Wed, 21 Jun 2023 00:50:24 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L7hSs1014726;
        Wed, 21 Jun 2023 07:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=wv5CoZxQoqrZ84iHmXKjcGNtSsQ32uywpidEB510fuY=;
 b=HD7byKPhrGqThA06eFdC+AlZCcvRaSwroKZwAfQoNHb2wc2NxIUymrBSO8W5RKTW/p/E
 heg+OOaxK9T3Pnsp2j4tz4s2QXbDozXjZReBhuAjhaQJ3o1nWwLWWLpRXdZ7jwP6OmBs
 qgi0neXeV7NQcnluHFwVUVz5ZNnKXder5+QCso5w9qY+xgWy6gW3TSBK7LtELuGK1zst
 4KJDZQWocD0wvPq/3smgJmhS6gHx7JK0oboIcD9s+6PR4JDBs+vGKKXLA3UhcXklWP22
 18YKPC0BOZ22hZco9H7wA7c6Xpc/yfYl6yy+ZbjOfYqw9NbmxIKrdo4z35U5dj3XZwC0 +A== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rb8f6jr01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 07:50:19 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35L7oI54032195
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 07:50:18 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 21 Jun 2023 00:50:13 -0700
Date:   Wed, 21 Jun 2023 13:20:07 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v15 5/5] arm64: dts: qcom: ipq9574: Enable USB
Message-ID: <20230621075006.GA3533@varda-linux.qualcomm.com>
References: <cover.1686289721.git.quic_varada@quicinc.com>
 <5021dbf3a28ee073795e7580bfa019df465e16ed.1686289721.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5021dbf3a28ee073795e7580bfa019df465e16ed.1686289721.git.quic_varada@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nKKAnxE7QjMoak78u1hHtkY8aPJTDIwj
X-Proofpoint-ORIG-GUID: nKKAnxE7QjMoak78u1hHtkY8aPJTDIwj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_04,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=854 mlxscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 11:26:34AM +0530, Varadarajan Narayanan wrote:
> Add regulator defines
> Turn on USB related nodes
> Provide vdd info
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Changes in v15:
> 	- Move fixed regulator defines from 'arm64: dts: qcom: ipq9574: Add USB related nodes' to this patch
> 
>  Changes in v13:
> 	- s/fixed_/regulator_fixed_/
> 
>  Changes in v11:
> 	- Rename dwc_0 -> usb_0_dwc3
> 	- Maintain sorted order for the usb nodes
> 
>  Changes in v10:
> 	- Provide vdd info
> 
>  Changes in v5:
> 	- Move "host" mode specification to board dts
> 	- Due to dependency with earlier patches board dts
> 	  filename changed ipq9574-al02-c7.dts -> ipq9574-rdp433.dts
> 
>  Changes in v2:
> 	- Fix node placement and coding style
> 	- "ok" -> "okay"
> ---
>  arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 41 +++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> index 8c2451c..877026c 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> @@ -21,6 +21,24 @@
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	regulator_fixed_3p3: s3300 {
> +		compatible = "regulator-fixed";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		regulator-name = "fixed_3p3";
> +	};
> +
> +	regulator_fixed_0p925: s0925 {
> +		compatible = "regulator-fixed";
> +		regulator-min-microvolt = <925000>;
> +		regulator-max-microvolt = <925000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		regulator-name = "fixed_0p925";
> +	};
>  };
>  
>  &blsp1_uart2 {
> @@ -105,6 +123,29 @@
>  	};
>  };
>  
> +&usb_0_dwc3 {
> +	dr_mode = "host";
> +};
> +
> +&usb_0_qmpphy {
> +	vdda-pll-supply = <&mp5496_l2>;
> +	vdda-phy-supply = <&regulator_fixed_0p925>;
> +
> +	status = "okay";
> +};
> +
> +&usb_0_qusbphy {
> +	vdd-supply = <&regulator_fixed_0p925>;
> +	vdda-pll-supply = <&mp5496_l2>;
> +	vdda-phy-dpdm-supply = <&regulator_fixed_3p3>;
> +
> +	status = "okay";
> +};
> +
> +&usb3 {
> +	status = "okay";
> +};
> +
>  &xo_board_clk {
>  	clock-frequency = <24000000>;
>  };
> -- 
> 2.7.4
> 

Bjorn,

Can this be pulled for 6.5?

Thanks
Varada
