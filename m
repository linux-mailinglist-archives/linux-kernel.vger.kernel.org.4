Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AA15F36A8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJCTrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiJCTrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:47:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D0449B69;
        Mon,  3 Oct 2022 12:47:12 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293IKIYM010984;
        Mon, 3 Oct 2022 19:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GIzO6al2Hn9rAgCsXHHnu+t7siBW0HyD/dZ2WSMAiN4=;
 b=k7yQmYxPkm7snKTo+WnSR8OPUn6HniAsodIpXKENVDWHfmDWmeDfB0w5FQTbXOt+X3Ma
 cXHSjJ5gV9EYQsLquCw+5fskVQ4HCinolW6YTda7ZLgK/phYAcgxNPlHy+aUAZl9yINV
 PT7c/JKiWtF81kcLbEQ/dRYCVpq0p3oP1sx/OuMds+5xTZDaxf71b8vaNPKSVndM8niK
 7255pxl/JzeSOQb/LNftDs1XZvdKNfqE8CrRfGTXhmkew+1hrcZQ2iwQn/3PqC5qdBt3
 yiFYV/gS1lTVbPnXyV4ztsKVueAqF+yQDkfFlF6oi64JwVmKqBiXWP1A61Z46v8ADvZg Ww== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxeqtvy33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 19:47:07 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 293Jl6HW009840
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Oct 2022 19:47:06 GMT
Received: from [10.110.93.213] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 3 Oct 2022
 12:47:05 -0700
Message-ID: <55d28ebc-e061-7b5e-99f9-f34f2b0e9af8@quicinc.com>
Date:   Mon, 3 Oct 2022 14:47:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5/5] dt-bindings: clock: Introduce pdc bindings for
 QDU1000 and QRU1000
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221001030403.27659-1-quic_molvera@quicinc.com>
 <20221001030403.27659-6-quic_molvera@quicinc.com>
 <114fb5a01a422c15997a9a4daebce584@kernel.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <114fb5a01a422c15997a9a4daebce584@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gfLpfxwFtei-0YrZ2ypWrPHnRMXpaLfe
X-Proofpoint-GUID: gfLpfxwFtei-0YrZ2ypWrPHnRMXpaLfe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=944
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210030119
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/1/2022 4:22 AM, Marc Zyngier wrote:
> On 2022-10-01 04:04, Melody Olvera wrote:
>> Add compatible fields for QDU1000 and QRU1000 pdcs.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml      | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
>> b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
>> index b6f56cf5fbe3..5c7b790db7e0 100644
>> --- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
>> @@ -33,6 +33,8 @@ properties:
>>            - qcom,sm8150-pdc
>>            - qcom,sm8250-pdc
>>            - qcom,sm8350-pdc
>> +          - qcom,qdu1000-pdc
>> +          - qcom,qru1000-pdc
>>        - const: qcom,pdc
>>
>>    reg:
>
> Please fix the title of the commit, as this has little to do with clocks.

Will do.

>
>         M.

Thanks,

Melody

