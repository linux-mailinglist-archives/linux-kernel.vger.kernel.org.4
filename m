Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587A47469FE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjGDGtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjGDGt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:49:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187A210C2;
        Mon,  3 Jul 2023 23:49:14 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3646hIIT018711;
        Tue, 4 Jul 2023 06:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=npS0gEP1BqKsMVVy1e4vAu7MUCbB8ABqRkdWc/3DVmE=;
 b=iBS7d0zCKd5yNVHLAzkxbsFHsa5/AWEXZdspS3AdT2UkxEodYRxQ+0ZD/axHP4Yu7MG4
 n667Ihkk8TIGPEXchPKdxEMrypj+jyoeP5WuGqztTz8jZRb6JWhb1k2o23tSAN0x7//6
 CtNEc8s2iKMzhL57C3mNnD6IilRWiQ7ZSLQ+x0iXwd3x+GjCL3QMSPgTvLM3UVJgqOf8
 9nTA0ntll9DPrJMAN4OHmT9xQ4LihjOUZjAKjFUMP+PuYhwla/a24h/jZoJsitD9k7PF
 GtE6zffkMUXYZ+T8cWKU8/nxsOz95kQLwkefsLzRF9Unmk/71T6pNfnk0zdC+kBm2kp0 Nw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rky5mhk78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 06:49:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3646n6Ts018954
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jul 2023 06:49:06 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Mon, 3 Jul 2023
 23:48:44 -0700
Message-ID: <ed76063e-e663-189f-d7b7-fffb80991289@quicinc.com>
Date:   Tue, 4 Jul 2023 12:18:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 04/10] dt-bindings: pinctrl: qcom-pmic-gpio: Add pm7550ba
 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <sboyd@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
References: <1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688395346-3126-5-git-send-email-quic_rohiagar@quicinc.com>
 <e143a039-d71a-bfec-172c-120990bdc357@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <e143a039-d71a-bfec-172c-120990bdc357@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ToTyz0ejxVlge1zBGEwPn75LbIOl1xOz
X-Proofpoint-GUID: ToTyz0ejxVlge1zBGEwPn75LbIOl1xOz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=910 adultscore=0
 spamscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040056
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/4/2023 11:54 AM, Krzysztof Kozlowski wrote:
> On 03/07/2023 16:42, Rohit Agarwal wrote:
>> Add support for the pm7550ba GPIO support to the Qualcomm PMIC GPIO
>> binding.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
>> index eaadd5a..9470eb0 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
>> @@ -25,6 +25,7 @@ properties:
>>             - qcom,pm6150l-gpio
>>             - qcom,pm6350-gpio
>>             - qcom,pm7250b-gpio
>> +          - qcom,pm7550ba-gpio
>>             - qcom,pm7325-gpio
> Keep alphanumeric order.
It was in my mind but somehow made a mistake. Will update this immediately.

Thanks,
Rohit.
>
> Best regards,
> Krzysztof
>
