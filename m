Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857DC6770D4
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 17:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjAVQ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 11:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjAVQ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 11:58:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8424417CF7;
        Sun, 22 Jan 2023 08:58:02 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30MGvqqZ030738;
        Sun, 22 Jan 2023 16:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Y7aSpToOimi+qzcP+zvLl299nP0lgLH+azF1Y+cNlOw=;
 b=mImWISlaUv9v/HGpSCspJXmXoc85jrowbrAJrJPvfo9aG0+g/MB+SPIfgJaV1ncLgSIT
 JBwYpTwhlrC+0qd9kYIYx5yHru1x3N4c/yfz0uigue4vbIx8Zvvd3FlGCUnqjfRAhUuR
 /MABhFfoIcra6rlAmXLW+/2BQBRqhXSRLefgq4R5V4AQR7iYzslOH0KUG6iXhiWX8V+y
 IbcpNfqalFsmYmbGlZPv0S4GGWkFdFjREQ3QMYEJdGDSNcieh7BqrT4sD+cClsvmDKr/
 q6+ZMg92CXX1KZXUVJk74E4QBrXyM0XbBGwNL5ITZazW2Uc+6DfT9f5fsyDzns5kSNDX vA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89dr1qw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Jan 2023 16:57:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30MGvp2G004508
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Jan 2023 16:57:51 GMT
Received: from [10.50.40.120] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 22 Jan
 2023 08:57:48 -0800
Message-ID: <ebdd9932-e251-0cd7-6c98-3c735ecb74a6@quicinc.com>
Date:   Sun, 22 Jan 2023 22:27:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq8074: add QFPROM node
To:     Robert Marko <robimarko@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230121112358.52216-1-robimarko@gmail.com>
 <20230121112358.52216-2-robimarko@gmail.com>
Content-Language: en-US
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20230121112358.52216-2-robimarko@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UA29yu-0QGu7phHoyR2aDfvYJ8eDzPPT
X-Proofpoint-ORIG-GUID: UA29yu-0QGu7phHoyR2aDfvYJ8eDzPPT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-22_14,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=929 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301220163
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/21/2023 4:53 PM, Robert Marko wrote:
> IPQ8074 has efuses like other Qualcomm SoC-s that are required for
> determining various HW quirks which will be required later for CPR etc,
> so lets add the QFPROM node for start.
>
> Individidual fuses will be added as they are required.
>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>   arch/arm64/boot/dts/qcom/ipq8074.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> index 8eba586065a3..f29491f647fe 100644
> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> @@ -301,6 +301,13 @@ mdio: mdio@90000 {
>   			status = "disabled";
>   		};
>   
> +		qfprom: efuse@a4000 {
> +			compatible = "qcom,ipq8074-qfprom", "qcom,qfprom";
> +			reg = <0x000a4000 0x1000>;


 From the HW document, I see the overall size of this region is 0x2000, 
any reason to stick with 0x1000?

Thanks, Kathiravan T.


> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +		};
> +
>   		prng: rng@e3000 {
>   			compatible = "qcom,prng-ee";
>   			reg = <0x000e3000 0x1000>;
