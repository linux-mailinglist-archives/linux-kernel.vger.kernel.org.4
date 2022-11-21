Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB2C631941
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 05:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiKUEiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 23:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKUEiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 23:38:46 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD3421253;
        Sun, 20 Nov 2022 20:38:45 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL38161017525;
        Mon, 21 Nov 2022 04:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GQWFW8Ccmt6LTk1ByVTxtgOtaHpyw7lINb7XL8jo8H8=;
 b=E6ZWkljQSLLobml9kF5gDzg9ncEjU+B8nm0t1qG1wvWwjR1rHOpOCTNE3tNs2Q1gWOTD
 HyzSjzSvW+8d6iIs/3wM9FAD9lyz+Md6L815zm4Nbr8Pbj1ROM4lflrQ12F6Er7080NF
 pETKZKcmiRYCEF5N/d961x8cWLxrpPuEVYj/OpIPummGWA8oqxQyDzSU6c77A359RH0c
 aqCW6UqiwXw23+ZgnEbABd9u8g51sgKqZRBnvzC8IKQBXz8rOvReoYIEQFg1ugZp7uTS
 uoYzY/V0B/iimY7l43Au/pk9LxonHt9OXxT1Ygdn83wooBzsSmu3Y+e8UP6HXkgph0LZ ow== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrkv3egr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 04:38:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AL4ce2J022413
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 04:38:40 GMT
Received: from [10.216.39.145] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 20 Nov
 2022 20:38:37 -0800
Message-ID: <09e3f75f-3142-1ce9-1ff2-d618742a6eb4@quicinc.com>
Date:   Mon, 21 Nov 2022 10:08:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Document the sc7280 CRD Pro
 boards
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dianders@chromium.org>,
        <mka@chromium.org>
References: <20221118073017.26128-1-quic_rjendra@quicinc.com>
 <e93a61ce-4c7b-ecb2-7b82-1bde388ec6bb@linaro.org>
 <b818219f-ab28-5bed-e2a2-1884a6dbe061@linaro.org>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <b818219f-ab28-5bed-e2a2-1884a6dbe061@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C4X9M1IZwlljHu0aI8YT2kFgplR4V3E5
X-Proofpoint-ORIG-GUID: C4X9M1IZwlljHu0aI8YT2kFgplR4V3E5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_03,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/18/2022 7:45 PM, Krzysztof Kozlowski wrote:
> On 18/11/2022 15:13, Krzysztof Kozlowski wrote:
>> On 18/11/2022 08:30, Rajendra Nayak wrote:
>>> Add compatibles for the Pro SKU of the sc7280 CRD boards
>>>
>>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>>> ---
>>>   Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> index 463509f0f23a..2550ab251f7b 100644
>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> @@ -613,6 +613,11 @@ properties:
>>>             - const: google,hoglin
>>>             - const: qcom,sc7280
>>>   
>>> +      - description: Qualcomm Technologies, Inc. sc7280 CRD Pro platform (newest rev)
>>
>> Such entry is already documented. I think this is not based on recent
>> kernel.
> 
> My bad, I missed this is a Pro. Why it is not part of compatible? What
> is the difference between hoglin and CRD Pro?
> 
> You have plenty of space in commit msg to explain this.

Sent a v2 adding the details on the difference captured in the commit log.

> 
> Best regards,
> Krzysztof
> 
