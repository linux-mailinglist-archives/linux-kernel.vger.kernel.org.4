Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4AB669888
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbjAMNcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241441AbjAMNba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:31:30 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226527DE2A;
        Fri, 13 Jan 2023 05:22:55 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DCvs1M001459;
        Fri, 13 Jan 2023 13:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YJB1XbLUfXmcLJydDSML5w3qjlcd069IJbQFaXpHeig=;
 b=FhbSjLgGi473W2Cbigbzjvya3AyiM/C78fHGpIBDPsOHNtnWjY7pEiWPvAI1XGkfUqMd
 vtzFhtE3M3kHJknsSUHewU/4TgeaFWCSz3wRqUQ67EfAnT5pZNrsQBWXHg3loBQpkbHd
 CT0n2ySpz3PimVVGq5DhoTNxFggbEWpXnodZXzgTYSxhMkqZB62bFOU/Ywz4FM0bO7Cp
 yVuKWV3s+tY4HqiHCFHZUwOzuETB5KQsM5ty31e8jIIa5Zbzh6GbwlH1kkbWLlB9Xk/m
 z95+eOwXX3kqhJKVnFeY+4D27hEChqkm9f+tEiK1chQNBNItdRwfo3y1vUhJ9Ht+oMtU iQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n33h60wuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 13:22:39 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DDMcEt023450
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 13:22:38 GMT
Received: from [10.216.54.29] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 05:22:35 -0800
Message-ID: <fb4fafef-4aed-5333-4ed9-5335250541f3@quicinc.com>
Date:   Fri, 13 Jan 2023 18:52:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 1/3] dt-bindings: reserved-memory: ramoops: Update the
 binding
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <keescook@chromium.org>, <gpiccoli@igalia.com>, <corbet@lwn.net>,
        <tony.luck@intel.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-hardening@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1673611126-13803-1-git-send-email-quic_mojha@quicinc.com>
 <7cb96551-094c-1a68-cc3f-31e4e2e94518@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <7cb96551-094c-1a68-cc3f-31e4e2e94518@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -Ny5d09ubYZjIpMoMuonZtwtxPbfxy3w
X-Proofpoint-GUID: -Ny5d09ubYZjIpMoMuonZtwtxPbfxy3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_06,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301130088
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 1/13/2023 5:34 PM, Krzysztof Kozlowski wrote:
> Subject: drop second/last, redundant "binding". The "dt-bindings" prefix
> is already stating that these are bindings.
> 
> Your subject says nothing. Everything is "update".
> 

I will fix this.

> On 13/01/2023 12:58, Mukesh Ojha wrote:
>> Update the ramoops region binding document with details
>> like region can also be reserved dynamically apart from
>> reserving it statically.
>  > So what exactly can be here reserved dynamically? And what does it mean
> 'dynamically'? By whom? How is this property of hardware (not OS)?
> 
Normally, for ramoops, already known physical address range from DDR are 
mentioned in Device tree which gets reserved from reserved-memory kernel 
framework(example 1 in this file).

By being dynamic, I meant, with this we are letting the framework to get 
the size from a range of allowable address (<0x0 0x00000000 0xffffffff 
0xffffffff>).

Let me know, if you need more detail.

>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>> Change in v2:
>>    - Added this patch as per changes going to be done in patch 3/3
>>
>>   .../bindings/reserved-memory/ramoops.yaml          | 34 ++++++++++++++++++++--
>>   1 file changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
>> index 0391871..54e46e8 100644
>> --- a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
>> +++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
>> @@ -10,7 +10,8 @@ description: |
>>     ramoops provides persistent RAM storage for oops and panics, so they can be
>>     recovered after a reboot. This is a child-node of "/reserved-memory", and
>>     is named "ramoops" after the backend, rather than "pstore" which is the
>> -  subsystem.
>> +  subsystem. This region can be reserved both statically or dynamically by
>> +  using appropriate property in device tree.
>>   
>>     Parts of this storage may be set aside for other persistent log buffers, such
>>     as kernel log messages, or for optional ECC error-correction data.  The total
>> @@ -112,7 +113,13 @@ unevaluatedProperties: false
>>   
>>   required:
>>     - compatible
>> -  - reg
>> +
>> +oneOf:
>> +  - required:
>> +      - reg
>> +
>> +  - required:
>> +      - size
> 
> There is no such property. You cannot require it.

Forgot to mention this.

--- a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
@@ -37,6 +37,20 @@ properties:
    reg:
      description: region of memory that is preserved between reboots

+  size:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 2
+    description: >
+      Length based on parent's \#size-cells. Size in bytes of memory to
+      reserve.
+
+  alloc-ranges:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: >
+      Address and Length pairs. Specifies regions of memory that are
+      acceptable to allocate from.
+
    ecc-size:
      $ref: /schemas/types.yaml#/definitions/uint32
      description: enables ECC support and specifies ECC buffer size in 
bytes
@@ -119,6 +133,7 @@ oneOf:
        - reg

    - required:
+      - alloc-ranges
        - size
> 
>>   
>>   anyOf:
>>     - required: [record-size]
>> @@ -142,3 +149,26 @@ examples:
>>               };
>>           };
>>       };
>> +
>> +  - |
>> +    / {
>> +        compatible = "foo";
>> +        model = "foo";
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        reserved-memory {
>> +            #address-cells = <2>;
>> +            #size-cells = <2>;
>> +            ranges;
>> +
>> +            ramoops: ramoops_region {
> 
> Node names should be generic, no underscores in node names.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 

Thanks.

> Any reason in naming it differently then existing one? You have there
> example.

ramoops@bfdf0000 is not valid after dynamic allocation of memory.
Probably, will mention it as

ramoops_region: ramoops { ??

-Mukesh
> 
>> +                compatible = "ramoops";
>> +                alloc-ranges = <0x0 0x00000000 0xffffffff 0xffffffff>;
>> +                size = <0x0 0x10000>;       /* 64kB */
>> +                console-size = <0x8000>;    /* 32kB */
>> +                record-size = <0x400>;      /*  1kB */
>> +                ecc-size = <16>;
>> +            };
>> +        };
>> +    };
> 
> Best regards,
> Krzysztof
> 
