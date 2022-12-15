Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A69864DFD0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiLORie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLORib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:38:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC3D2B61F;
        Thu, 15 Dec 2022 09:38:30 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFGuQhA016359;
        Thu, 15 Dec 2022 17:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tNw5Hyxj8J79rGMMNIWQapZA1IiXn8AKoQqoIHNR2Ms=;
 b=OZYmcE3citoy/LLqkUveFoihNch7vC+cFPCtwWwfSn3WGx7oKmntSpLBGe6ork81WCuM
 kMxAkEbPkK9JZblXyjHy+wppVGrFgWzb2M0xg8RpMBlj5pnxjQBdyCmxx1hp7oirokXI
 KQSCC20EIxHINRA4j/JHnpp26+xEkG8MXbSOVKDYWUjJi6lH51vZmlWAHAqXPuLq7mTH
 FhzRipRc9HhOM27OQ38GMN3pOcdXqG3DvC9Qeq68DcwPO5YHxC83VHjM4+5i8U/yZG6n
 4DfaWMGsHpWn/o7wF0fORPVrvxroQICUKCki6Jd1MkvO+6EKFya8LGQtP0XYrjEINcWj Gg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6rfdfbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 17:38:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BFHcQq5025790
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 17:38:26 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 15 Dec
 2022 09:38:23 -0800
Message-ID: <a5ec259a-9f78-a54d-c15a-291f192ee220@quicinc.com>
Date:   Thu, 15 Dec 2022 23:08:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: enable IPA in
 sc7280-herobrine-lte-sku.dtsi
Content-Language: en-US
To:     Alex Elder <elder@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <agross@kernel.org>
CC:     <elder@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221208183837.505454-1-elder@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20221208183837.505454-1-elder@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hLp30XXGb6YIKLclscrdBVM40ntFcBss
X-Proofpoint-ORIG-GUID: hLp30XXGb6YIKLclscrdBVM40ntFcBss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_10,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212150146
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex,

Thanks for the patch.

On 12/9/22 00:08, Alex Elder wrote:
> IPA is only needed on a platform if it includes a modem, and not all
> SC7280 SoC variants do.  The file "sc7280-herobrine-lte-sku.dtsi" is
> used to encapsulate definitions related to Chrome OS SC7280 devices
> where a modem is present, and that's the proper place for the IPA
> node to be enabled.
> 
> Currently IPA is enabled in "sc7280-idp.dtsi", which is included by
> DTS files for Qualcomm reference platforms (all of which include the
> modem).  That also includes "sc7280-herobrine-lte-sku.dtsi", so
> enabling IPA there would make it unnecessary for "sc7280-idp.dtsi"
> to enable it.
> 
> The only other place IPA is enabled is "sc7280-qcard.dtsi".
> That file is included only by "sc7280-herobrine.dtsi", which
> is (eventually) included only by these top-level DTS files:
>    sc7280-herobrine-crd.dts
>    sc7280-herobrine-herobrine-r1.dts
>    sc7280-herobrine-evoker.dts
>    sc7280-herobrine-evoker-lte.dts
>    sc7280-herobrine-villager-r0.dts
>    sc7280-herobrine-villager-r1.dts
>    sc7280-herobrine-villager-r1-lte.dts
> All of but two of these include "sc7280-herobrine-lte-sku.dtsi", and
> for those cases, enabling IPA there means there is no need for it to
> be enabled in "sc7280-qcard.dtsi".
> 
> The two remaining cases will no longer enable IPA as a result of
> this change:
>    sc7280-herobrine-evoker.dts
>    sc7280-herobrine-villager-r1.dts
> Both of these have "lte" counterparts, and are meant to represent
> board variants that do *not* have a modem.
> 
> This is exactly the desired configuration.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi | 5 +++++
>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi               | 5 -----
>   arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi             | 5 -----
>   3 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
> index ad66e5e9db4ed..956708397f035 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
> @@ -34,3 +34,8 @@ &remoteproc_mpss {
>   &rmtfs_mem {
>   	reg = <0x0 0x9c900000 0x0 0x800000>;
>   };
> +
> +&ipa {
> +	status = "okay";
> +	modem-init;
> +};

nit; You'll probably want to move the ipa node above remoteproc node to
maintain sorting.

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
Tested-by: Sibi Sankar <quic_sibis@quicinc.com>

> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index f7efb9966afd1..0ddbe7f732bd9 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -376,11 +376,6 @@ &gpi_dma1 {
>   	status = "okay";
>   };
>   
> -&ipa {
> -	status = "okay";
> -	modem-init;
> -};
> -
>   &lpass_cpu {
>   	status = "okay";
>   
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> index df49564ae6dc1..cd6ee84b36fd4 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> @@ -336,11 +336,6 @@ vreg_bob: bob {
>   
>   /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
>   
> -&ipa {
> -	status = "okay";
> -	modem-init;
> -};
> -
>   &lpass_va_macro {
>   	vdd-micb-supply = <&vreg_bob>;
>   };
