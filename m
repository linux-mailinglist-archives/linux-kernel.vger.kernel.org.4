Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F4D67EA8C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbjA0QPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbjA0QPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:15:05 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C8316AC5;
        Fri, 27 Jan 2023 08:15:04 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30REpBLx021624;
        Fri, 27 Jan 2023 16:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7FdMeJoiCf5NJt7z2ljqNwFCRXLeXuvJUHJNHepiiK8=;
 b=VUhJGxQNMifhl9D7Hbp9VVok2+cFPbw0YEXkSFkwE/fKL8sT61NnqoSTDa1SAo0Tx73r
 pDt3Uz07Qk+e2YrM1QKFUf5EMgwR78FO0dugrYuYLjtDiu4wJiamqEWwyGYGpKoFX4+r
 N3xAKzFOe9fh2Qv8j769n9dre3LJ/DiwMQEsZ0ympzm9VVvBTWa4I4WpB9xeCHor5vI6
 2Pi1/P73zdAqGccBkd2Y1PL5sUMQda2q/qP8G0a1NAHEiw8lrWR05wNhacyE5CTgKq0f
 eWUwXUH9T+bgT/0Ra+0hR6bDK7VthoK7HHo8J9eKYXoeZJAsPy8LuSqVzavK2M8aPCrQ ug== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nc95jrv49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 16:15:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30RGF0sX003953
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 16:15:00 GMT
Received: from [10.216.61.139] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 27 Jan
 2023 08:14:57 -0800
Message-ID: <99cf647c-39f2-9ea6-f481-2f84b6b4a5f9@quicinc.com>
Date:   Fri, 27 Jan 2023 21:44:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: Fix the aoss_qmp node name
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230127131441.1157679-1-abel.vesa@linaro.org>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20230127131441.1157679-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V53OuGwKka5R2NcisJGpmNvYSPfborDM
X-Proofpoint-ORIG-GUID: V53OuGwKka5R2NcisJGpmNvYSPfborDM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_10,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=592
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301270151
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/2023 6:44 PM, Abel Vesa wrote:
> The proper name for it is power-management. Currently, with the node
> name being power-controller, the bindings check fails due to the
> property #power-domain-cells missing.
> 
> Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>


>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 6ff135191ee0..57878ea64ee0 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2503,7 +2503,7 @@ tsens2: thermal-sensor@c273000 {
>   			#thermal-sensor-cells = <1>;
>   		};
>   
> -		aoss_qmp: power-controller@c300000 {
> +		aoss_qmp: power-management@c300000 {
>   			compatible = "qcom,sm8550-aoss-qmp", "qcom,aoss-qmp";
>   			reg = <0 0x0c300000 0 0x400>;
>   			interrupt-parent = <&ipcc>;

