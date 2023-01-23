Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398686779B5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjAWK7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjAWK7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:59:11 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FB0DBC9;
        Mon, 23 Jan 2023 02:59:10 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NAN3u1009176;
        Mon, 23 Jan 2023 10:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vjeExIu8LeGHYy+uN4++WrlMD5UmaR0POrNg/IH3fxI=;
 b=RtouDTDMQi9KexnE51YxS0DpdKN9rflVFo7X97vikSfcad6T+AE6OaohkRY8TxBd+XZu
 Na+nnv+il5fRgs5jEAu09kdj+JWj9UmvVI/iqD5nFZEVph9R4yb824gKaG/XLFrrjS86
 RDYZ0FCLsml5ze/gyOm4WugaiPi2dmNX/inQ1TWq+GfAhC2ICPJY1vb6TvEAlvkGLNjF
 67TyQtwEqBwA0WVo94TOzbQ976fl2nWqEJzZgiJM+Vuv2zCQPHhZOFsMrUxjY/EiIi6S
 hRb3HFhF/8lILD76DdevBIdeclesauTX+0ySugMIcT5VvA3WFglMNBcwvrJtR69aVmQx pw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89frasf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 10:59:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30NAx51H004828
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 10:59:05 GMT
Received: from [10.50.40.120] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 02:59:01 -0800
Message-ID: <832b08b3-f3f1-d9c9-59a5-35fc1f74b25e@quicinc.com>
Date:   Mon, 23 Jan 2023 16:28:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: ipq8074: add QFPROM node
To:     Robert Marko <robimarko@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230123101631.475712-1-robimarko@gmail.com>
 <20230123101631.475712-2-robimarko@gmail.com>
Content-Language: en-US
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20230123101631.475712-2-robimarko@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LtkeLNeJkVJb1wzgszXXWG676w8o7MlA
X-Proofpoint-GUID: LtkeLNeJkVJb1wzgszXXWG676w8o7MlA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_07,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=732
 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230103
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/23/2023 3:46 PM, Robert Marko wrote:
> IPQ8074 has efuses like other Qualcomm SoC-s that are required for
> determining various HW quirks which will be required later for CPR etc,
> so lets add the QFPROM node for start.
>
> Individidual fuses will be added as they are required.
>
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Kathiravan T <quic_kathirav@quicinc.com>

> ---
> Changes in v2:
> * Enlarge the register space size due to info from Kathiravan T.
> ---
>   arch/arm64/boot/dts/qcom/ipq8074.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> index 8eba586065a3..ff59a2f38293 100644
> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> @@ -301,6 +301,13 @@ mdio: mdio@90000 {
>   			status = "disabled";
>   		};
>   
> +		qfprom: efuse@a4000 {
> +			compatible = "qcom,ipq8074-qfprom", "qcom,qfprom";
> +			reg = <0x000a4000 0x2000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +		};
> +
>   		prng: rng@e3000 {
>   			compatible = "qcom,prng-ee";
>   			reg = <0x000e3000 0x1000>;
