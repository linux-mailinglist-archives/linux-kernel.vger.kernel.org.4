Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3915FC06F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 08:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiJLGJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 02:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJLGJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 02:09:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9BD77EB0;
        Tue, 11 Oct 2022 23:09:09 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29C5t8d8011501;
        Wed, 12 Oct 2022 06:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jQYrO476z41NopM/bcra25kVZpYW49EA2sUprgcs8ic=;
 b=o+yvO1xx/RixIYUGAHU4qkfR+n/AQS5AI3T/JwQkUH637BLfSkOYVr3K61YJ5+E8bN4L
 Pw9Az601SbMqwIDeulzV+ddGDnSLOo5K5AqBCRifAlw8Ef1LMVm8zAGphbTjtlUlBULD
 7v5XyG9j5rPn+sd4w4KGJq5LP75mhmmLL8d954/DkXnyZqc/cD0oFpFEfa9VOQ2rE546
 LnbA1m10/G37RDfxG9pcZ3Nd7lIPFejhG2vtnUq0nwb3Ys/aZuUYZa09VelN+3XsxuSv
 hXzNXoglRsLd/ATRzTxewEdH9UxOv6Y1uF233EpVcun+oXdd3PUaz0YC34dFJskjhOIM UQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k5kar0m56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 06:09:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29C6911J009180
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 06:09:01 GMT
Received: from [10.131.117.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 11 Oct
 2022 23:08:58 -0700
Message-ID: <ea0d7156-972b-8ce7-6169-c49dd7cd03d1@quicinc.com>
Date:   Wed, 12 Oct 2022 11:38:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: interconnect: qcom,msm8998-bwmon: Correct
 SC7280 CPU compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221011140744.29829-1-krzysztof.kozlowski@linaro.org>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <20221011140744.29829-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: u15rEIGE9huMAx7oLW2Sr8x_AlRq-uk3
X-Proofpoint-GUID: u15rEIGE9huMAx7oLW2Sr8x_AlRq-uk3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_03,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120040
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2022 7:37 PM, Krzysztof Kozlowski wrote:
> Two different compatibles for SC7280 CPU BWMON instance were used
> in DTS and bindings.  Correct the bindings to use the same one as in
> DTS, because it is more specific.
> 
> Fixes: b7c84ae757c2 ("dt-bindings: interconnect: qcom,msm8998-bwmon: Add support for sc7280 BWMONs")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

ah, thanks for the fixing this,
Reviewed-by: Rajendra Nayak <quic_rjendra@quicinc.com>

> ---
>   .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml    | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> index 2684562df4d9..be29e0b80995 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> @@ -24,7 +24,7 @@ properties:
>       oneOf:
>         - items:
>             - enum:
> -              - qcom,sc7280-bwmon
> +              - qcom,sc7280-cpu-bwmon
>                 - qcom,sdm845-bwmon
>             - const: qcom,msm8998-bwmon
>         - const: qcom,msm8998-bwmon       # BWMON v4
