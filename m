Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED4F71FCC3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbjFBIyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbjFBIyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:54:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C308E47;
        Fri,  2 Jun 2023 01:53:21 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3527steb018334;
        Fri, 2 Jun 2023 08:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=m32xqfafdcX/VXStuKyJNVLtJJE3KbtHvb0uXWbIgns=;
 b=P8Es0wXqt3wovE/DUiuS3HbtntnGugtIXfRl7r9bTjvV5FCDCg+DrXAKmiXqNYNIemN1
 8+3x8/oSOdewbb4Prwl6kLBga7lAZ6odMGy0b0jxVctVt/l0mci534SedkOkn4/UFxTw
 TSqZUi+C2tNd4D9t22Qcv226obViNgwlsu2WX61JUlbvD+JQ9laaL59RaFbeZPFhwzra
 nqmc3Vq/mWhiunU5Ld0L2gnGlj5QvYft30/ffc+WzvAUrv4mwkWqqYoVEmVAAddW8obh
 cYmP5GdZLTKgXJb3Peg+qhKmSDRBTAsYV/Tmta5GYA7M2oQVBwEvoJJ3taBh2ncTC+qJ eQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qybnbr66q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 08:53:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3528rHIJ003441
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 08:53:17 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 2 Jun 2023
 01:53:12 -0700
Message-ID: <c3b05763-0153-e422-9874-bfaab461003b@quicinc.com>
Date:   Fri, 2 Jun 2023 14:23:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] arm64: dts: qcom: ipq9574: add few more reserved memory
 region
To:     Anusha Rao <quic_anusha@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230602084431.19134-1-quic_anusha@quicinc.com>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230602084431.19134-1-quic_anusha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EDAXQl5IkftLbLZj9-UROBvnqmu3rpiW
X-Proofpoint-ORIG-GUID: EDAXQl5IkftLbLZj9-UROBvnqmu3rpiW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_06,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=574 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 spamscore=0 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306020066
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/2/2023 2:14 PM, Anusha Rao wrote:
> In IPQ SoCs, bootloader will collect the system RAM contents upon crash
> for post-morterm analysis. If we don't reserve the memory region used
> by bootloader, obviously linux will consume it and upon next boot on
> crash, bootloader will be loaded in the same region, which will lead to
> loss of some data, sometimes we may miss out critical information.
> So lets reserve the region used by the bootloader.
>
> Similarly SBL copies some data into the reserved region and it will be
> used in the crash scenario. So reserve 1MB for SBL as well.
>
> While at it, drop the size padding in the reserved memory region,
> wherever applicable


LGTM.

Reviewed-by: Kathiravan T <quic_kathirav@quicinc.com>


>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 0baeb10bbdae..7d21ec0909fb 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -156,6 +156,16 @@
>   		#size-cells = <2>;
>   		ranges;
>   
> +		bootloader@4a100000 {
> +			reg = <0x0 0x4a100000 0x0 0x400000>;
> +			no-map;
> +		};
> +
> +		sbl@4a500000 {
> +			reg = <0x0 0x4a500000 0x0 0x100000>;
> +			no-map;
> +		};
> +
>   		tz_region: tz@4a600000 {
>   			reg = <0x0 0x4a600000 0x0 0x400000>;
>   			no-map;
> @@ -163,7 +173,7 @@
>   
>   		smem@4aa00000 {
>   			compatible = "qcom,smem";
> -			reg = <0x0 0x4aa00000 0x0 0x00100000>;
> +			reg = <0x0 0x4aa00000 0x0 0x100000>;
>   			hwlocks = <&tcsr_mutex 0>;
>   			no-map;
>   		};
