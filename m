Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4E6680778
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbjA3Icb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjA3Ic3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:32:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E21A17CE8;
        Mon, 30 Jan 2023 00:32:28 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U7IIDP003187;
        Mon, 30 Jan 2023 08:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aklttRLYnOL4mEWNN06Pn8vhOUGDV3tAYkPqoDtLnK4=;
 b=EAiqnc+vZsNzc2t1mkKIM9bff8oDit3Wxx6fDs02n+TnPo/ZPmdDWegwrd6x0NPKo6mf
 ShmwWyElPwQyt1BjLHExbm3csxjhOqVe/BXN7XIk++Mh9QM6IZnXMB1rkDQkRgN21BA6
 SUgorBIc3G2elIhsEJDK6DZhSKkCVHDwqAqmDPweoWOXcWd/L5JUuWcXFxcfKksuy+YX
 9CJbHn9z7lEcbQaieE/FqLolRi6PFnj8qdN5oyfyucGINc72Heb/Rxup1+LDtiOa8JHl
 4XWtQj1qgkX+jegRwoLC5b4DdjgugUQyfCaWWZTvGHfVXMjs1YMeQqt144+2mIvgjoib WA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncs2x3kdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 08:32:13 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30U8WClR004211
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 08:32:12 GMT
Received: from [10.216.24.235] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 00:32:09 -0800
Message-ID: <7ef34bc2-f8ef-72e1-b97e-7c274b671550@quicinc.com>
Date:   Mon, 30 Jan 2023 14:02:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 1/2] dt-bindings: ramoops: Inherit reserve memory
 property
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
CC:     <linux-hardening@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <1674835252-31954-1-git-send-email-quic_mojha@quicinc.com>
 <CAL_JsqK_wuOwJS=dSkSdYs10kE1S3gmtHVU31wkxkP5wT39qqg@mail.gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <CAL_JsqK_wuOwJS=dSkSdYs10kE1S3gmtHVU31wkxkP5wT39qqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pOXZtEvFmXLIP-klEZnneORLnWzn-iZX
X-Proofpoint-GUID: pOXZtEvFmXLIP-klEZnneORLnWzn-iZX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_07,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300080
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/28/2023 1:35 AM, Rob Herring wrote:
> On Fri, Jan 27, 2023 at 10:01 AM Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>
>> The reserved memory region for ramoops is assumed to be at a
>> fixed and known location when read from the devicetree. This
>> is not desirable in an environment where it is preferred the
>> region to be dynamically allocated at runtime, as opposed to
>> being fixed at compile time.
> 
> I don't see how this can work. How do you find the region after
> rebooting? Or this is only used for the current boot? If so, provide a
> userspace interface to configure it (or the existing module params).
> 

Client can do of_reserved_mem_lookup() on this ramoops node to get 
region addresses and it is for regular boots and it is not for
current boot.

Basically, here we are trying to support system which does not 
completely support warm reset(content could be inconsistent across 
boots) and has their own mechanism to dump ramoops region on crash.

Also, If it is required, to override the existing ramoops region of 
current boot(from static to dynamic), would provide user space interface 
as well.

> The addition of 'size' type regions was primarily for large carveouts
> that needed to be allocated before anything else. ramoops is not that.
> It's 10s or 100s of KB at most.

I agree..

Is this the only issue ?

I thought if it is inheriting reserve-memory binding, it can be used if 
it is not breaking anything what ramoops already supports..
you can have a look at 2/2 patch.


-Mukesh

> 
> 
>> So, update the ramoops binding by inheriting some reserve memory
>> property to allocate the ramoops region dynamically.
>>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Tony Luck <tony.luck@intel.com>
>> Cc: Guilherme G. Piccoli <gpiccoli@igalia.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>> Changes in v4:
>>   - Addressed comment made by Krzysztof on ramoops node name.
>>
>> Changes in v3:
>>   - Fixed yaml error and updated commit text as per comment.
>>
>> Change in v2:
>>    - Added this patch as per changes going to be done in patch 3/3
>>
>>   .../bindings/reserved-memory/ramoops.yaml          | 34 ++++++++++++++++++++--
>>   1 file changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
>> index 0391871..8741626 100644
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
> 
> You can't have multiple root node examples. Check the example dts, the
> examples will be merged together.

Sure, will remove this..

> 
>> +        compatible = "foo";
>> +        model = "foo";
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +
>> +        reserved-memory {
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges;
>> +
>> +            ramoops_region: ramoops {
>> +                compatible = "ramoops";
>> +                alloc-ranges = <0x00000000 0xffffffff>;
>> +                size = <0x0 0x10000>;       /* 64kB */
>> +                console-size = <0x8000>;    /* 32kB */
>> +                record-size = <0x400>;      /*  1kB */
>> +                ecc-size = <16>;
>> +            };
>> +        };
>> +    };
>> --
>> 2.7.4
>>
