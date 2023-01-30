Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CEE680772
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbjA3Ibn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbjA3Ibk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:31:40 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CAE2413A;
        Mon, 30 Jan 2023 00:31:39 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U6KNbW020276;
        Mon, 30 Jan 2023 08:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=y9H0J9H/Gb1KHD/YVlxfGW9S3sdNySUo8pNooxrjeQU=;
 b=es/Wa5M+OOGPSU0uxT9JQRz67ib3PxdThN27wIXqslKD9p3QMsITu1LkIW1HqNekSjJo
 Cc6ZR+4JiDGf05V037mejcKb11DOwjS2LLfnXWrhKIrkvc+ym1/ekr9jQuF4aBAai049
 VQ+/flWdJZpF8kLNs+yuTplsSMPWAsKYgMGh1VmDYMsP60evV7RFIfd3tyw1bXqWszr7
 JQ015NL6Bt08ttehguRMIIdJI+imu0uluThXk5szzTyI4L3FS0zNKea8GH7L2/YsOHOg
 FXFLUBH7+WizJdvEhb6nzogfY0v6J7FQBKxjQBYChoWhYg5ylCswa0VAyHjHRCgCOdw/ fw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncsdpu7hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 08:13:18 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30U8DHhY016285
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 08:13:17 GMT
Received: from [10.216.24.235] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 00:13:14 -0800
Message-ID: <8a4d1e88-56d0-fb71-7172-75b3ecf6e4b6@quicinc.com>
Date:   Mon, 30 Jan 2023 13:43:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 1/2] dt-bindings: ramoops: Inherit reserve memory
 property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-hardening@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <1674835252-31954-1-git-send-email-quic_mojha@quicinc.com>
 <637fe4cd-f9e9-ae22-0085-30ea3f1dd5af@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <637fe4cd-f9e9-ae22-0085-30ea3f1dd5af@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S7lAdF-VgBep3I70Ri1Hu2FK_FbHE5qi
X-Proofpoint-ORIG-GUID: S7lAdF-VgBep3I70Ri1Hu2FK_FbHE5qi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_06,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300077
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/28/2023 1:33 AM, Krzysztof Kozlowski wrote:
> On 27/01/2023 17:00, Mukesh Ojha wrote:
>> The reserved memory region for ramoops is assumed to be at a
>> fixed and known location when read from the devicetree. This
>> is not desirable in an environment where it is preferred the
>> region to be dynamically allocated at runtime, as opposed to
>> being fixed at compile time.
>>
>> So, update the ramoops binding by inheriting some reserve memory
>> property to allocate the ramoops region dynamically.
> 
> Where is the update which adds "inheriting"?

By inheriting, i meant using reserve memory properties..

Probably rephrase above as.

"dt-bindings: ramoops: Support dynamic ramoops region allocation

The reserved memory region for ramoops is assumed to be at a
fixed and known location when read from the devicetree. This
is not desirable in an environment where it is preferred the
region to be dynamically allocated at runtime, as opposed to
being fixed at compile time. This can be done with minor update
in ramoops binding as it inherit reserve memory property
(.yaml) in the binding.

Dynamic region could be used by providing size(region size) and
alloc-ranges(allowed ddr region to allocate the size from) instead
of mentioning regs"

Does it sound reasonable ?

-Mukesh
> 
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
> 
> This is okay, but:
> 
>> +
>> +oneOf:
>> +  - required:
>> +      - reg
>> +
>> +  - required:
>> +      - size
> 
> I now keep wondering - why do you need this?

This should be same as..
Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml

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
> 
> This example does not bring anything new for the ramoops. It's an
> example for reserved-memory to show usage with alloc-ranges. There is
> nothing useful here in terms of ramoops, so I think it should be dropped.
> 

will drop this..

> Best regards,
> Krzysztof
> 
