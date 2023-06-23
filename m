Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF03273B4B7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjFWKKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjFWKJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:09:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189A135BF;
        Fri, 23 Jun 2023 03:08:10 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N9U8oQ018099;
        Fri, 23 Jun 2023 10:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ygEbhuiI8pLfm7ETYtlsObwi1/BhXLuO5IFucVI7iyg=;
 b=joCOk+w0e8FO0d94MaqY1hxE6UtcLZ3AI+h8xV78CBh6uS5R09UMTjWaw8cfiZKkoBBl
 cL0k6akyst/GudPTQFjj0PG2mQgD+v3NSjK2ausRQjQypd2OUGJRWRgjfCO7bKCZBjIw
 /IB2o+GZmRLM7gzcqwXclK0Yy0tUdZ0plNgL1qqqgXkK1SY1lfTjEshsajX0HpToeydy
 mzZ9jsOPjHHuOst3aCvMguTp31ubnQxScLvgO0jU/bsv/OIaUENBIrtoO+6aPtsxu+Qw
 ykgvqgY2Y/mjIDX3hhyhNw0Ea9lZvP6JW79+83jbLYXO/mSljRgnmIGTrSxLkn0J1ez9 YA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rcurrhf0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 10:08:06 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NA85da000380
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 10:08:05 GMT
Received: from [10.218.48.111] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 23 Jun
 2023 03:08:00 -0700
Message-ID: <febf5078-2433-641d-52ec-0dea0e849c5b@quicinc.com>
Date:   Fri, 23 Jun 2023 15:37:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: clock: Update GCC clocks for QDU1000 and
 QRU1000 SoCs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Melody Olvera <quic_molvera@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230616104941.921555-1-quic_imrashai@quicinc.com>
 <20230616104941.921555-2-quic_imrashai@quicinc.com>
 <cee56c57-060a-2fce-a2af-25404b9afe48@linaro.org>
 <fe3b02e4-9f01-eb36-bf99-6bc3b15b28c2@linaro.org>
From:   Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <fe3b02e4-9f01-eb36-bf99-6bc3b15b28c2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yK5_66_puFCHPjnZmKpv7dnOx-vHOLMf
X-Proofpoint-ORIG-GUID: yK5_66_puFCHPjnZmKpv7dnOx-vHOLMf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_04,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230091
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/2023 7:15 PM, Krzysztof Kozlowski wrote:
> On 16/06/2023 13:33, Krzysztof Kozlowski wrote:
>> On 16/06/2023 12:49, Imran Shaik wrote:
>>> Update the qcom GCC clock bindings and add v2 compatible string for QDU1000
>>> and QRU1000 SoCs.
>>>
>>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
>>> ---
>>>   .../devicetree/bindings/clock/qcom,qdu1000-gcc.yaml         | 6 +++++-
>>>   include/dt-bindings/clock/qcom,qdu1000-gcc.h                | 4 +++-
>>>   2 files changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
>>> index 767a9d03aa32..030953d258c1 100644
>>> --- a/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
>>> +++ b/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
>>> @@ -8,6 +8,8 @@ title: Qualcomm Global Clock & Reset Controller for QDU1000 and QRU1000
>>>   
>>>   maintainers:
>>>     - Melody Olvera <quic_molvera@quicinc.com>
>>> +  - Taniya Das <quic_tdas@quicinc.com>
>>> +  - Imran Shaik <quic_imrashai@quicinc.com>
>>
>> I appreciate adding more maintainers, it is welcomed and needed.
>>
>> However many of Qualcomm folks, including some of you, did not care
>> enough to fix their old/incorrect email in existing entries, thus we
>> have hundreds of wrong addresses and email bounces.
>>
>> We already raised this internally and publicly, with just small effect,
>> so I am not sure what to do more. For me, allowing to have outdated
>> email in maintainers is an easiest proof that maintainer does not care.
>> Adding more maintainer entries, while maintainer does not care, would
>> not feel right. Maybe let's start with fixing existing entries?
> 
> +Cc Alex,
> 
> Let me emphasize more, because I did not see any follow up patches since
> my previous email - there are many, many stale maintainer entries from
> Qualcomm. Several of them have codeaurora.org email. Some have just old
> emails of folks who left.
> 
> Can we expect fixing these?

Sure, will post a separate clean up patch for fixing all the 
old/incorrect maintainers email addresses from all the binding files.

Thanks,
Imran

> 
> Best regards,
> Krzysztof
> 
