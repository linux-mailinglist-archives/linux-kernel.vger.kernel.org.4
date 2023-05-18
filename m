Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC3D707ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjERLG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjERLGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:06:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0765D3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:06:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9661a1ff1e9so278994666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684408012; x=1687000012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yeJXFRF7sbuSmGTwl5/y2NHZf03i5D97leo/Mm1jmPA=;
        b=MjfqNjnPpIzx92qYzyVccFfBlsVJ8+9ROZDV6w+QVISVgL4MVL3AdF3Mh8FrK8cnOm
         wHW6IB6uWI3uRraA3KtEA5TtALuzerEdegGTu0l7Vl/8dN76rFSPm7KcFkPCBs9YO1Md
         thRZobFoifwp8/WHXagA42ih2WHxzXczGWkEXITjkYC0PdXzIRqkPSNXaNxFZURmxNva
         SUqZROTPUozLgNYTgx6yiHS8MLuGLETlulPv9WLkJxcCtcffY3PG+xxVsIJgX+Khv+1F
         Tm/u5v1fRrrsCylilQDaaBR0QLZV4+ryfeqdOu5Un4DFcaPrICGHy5rGXSYwjbyFWTZ6
         8Gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684408012; x=1687000012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yeJXFRF7sbuSmGTwl5/y2NHZf03i5D97leo/Mm1jmPA=;
        b=T4T39cylceAkbK7NHC3h8gkqafjvqEcQT+1iTwSmVhfBtEqIXIiV+hfuGOdYCSQ7BZ
         hNZp69gwQuR6zvHwBvJ2NMD//dn6u/SOxOUuAGgjy0OeVDFTkK/a1Gv8iotfMmAfHgBn
         aaEci609rMIhgHj12c+gI1tfZAu0HQrB1/JfBGtWFWpAVe+9gL9hJrxMl3vClLKBF19L
         ClAg3Po1wO1uNtTPaCGkkGQEaj0kVg/0+Ga0tvO43gAPIosSUa+F1m7faOiMIH1+U1n0
         S9/sMPcO3OkspkrNxXese5r6ojjiW2eOrX7qYgLFJcD9AdsnXcZS3UpOoBvFnG20YlCa
         nZMg==
X-Gm-Message-State: AC+VfDxZbXaOUwOEyTHOUmCE0MKRE/H5+gThf4NdDsoy+OtVtUwBpuNS
        8zbqdBqzn6DCY+D3d/YYpqVxBA==
X-Google-Smtp-Source: ACHHUZ77B3+5K0JTlWbBlEvuo7J0nvSd9qNSA6L2iF+zlVo6gn+LFWwwVl6YZjX6L8F1UPtYxDep4w==
X-Received: by 2002:a17:907:31ca:b0:960:d28d:3368 with SMTP id xf10-20020a17090731ca00b00960d28d3368mr38722660ejb.60.1684408012085;
        Thu, 18 May 2023 04:06:52 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a2b:c408:5834:f48e? ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id pv27-20020a170907209b00b00882f9130eafsm824286ejb.26.2023.05.18.04.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 04:06:51 -0700 (PDT)
Message-ID: <24b60ca3-b6b9-662f-03c8-df1536b52bc9@linaro.org>
Date:   Thu, 18 May 2023 13:06:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/4] dt-bindings: thermal: tsens: Add ipq9574
 compatible
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Praveenkumar I <quic_ipkumar@quicinc.com>
References: <cover.1684140883.git.quic_varada@quicinc.com>
 <37adcf5d8d545a076e8ed971a4fb6c6c2833ef3c.1684140883.git.quic_varada@quicinc.com>
 <b7e749ff-f4f0-0e61-9aae-876db4278fbc@linaro.org>
 <20230516120426.GA1679@varda-linux.qualcomm.com>
 <1999753b-ceee-d66c-9a48-cbcbb8e6236e@linaro.org>
 <20230517055726.GA3165@varda-linux.qualcomm.com>
 <cfba78d7-e563-4544-00f3-0991b91eb1f3@linaro.org>
 <20230518054054.GA998@varda-linux.qualcomm.com>
 <fe1d81d2-52e6-7d2d-8d6c-ffdcbb8ccc89@linaro.org>
 <20230518090503.GA9173@varda-linux.qualcomm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230518090503.GA9173@varda-linux.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2023 11:05, Varadarajan Narayanan wrote:
> On Thu, May 18, 2023 at 09:09:12AM +0200, Krzysztof Kozlowski wrote:
>> On 18/05/2023 07:40, Varadarajan Narayanan wrote:
>>> On Wed, May 17, 2023 at 09:00:49AM +0200, Krzysztof Kozlowski wrote:
>>>> On 17/05/2023 07:57, Varadarajan Narayanan wrote:
>>>>> Part-1 is adding the 'const' entries at the beginning i.e.
>>>>>
>>>>> 	+      - const: qcom,tsens-v0_1
>>>>> 	+      - const: qcom,tsens-v1
>>>>> 	+      - const: qcom,tsens-v2
>>>>> 	+      - const: qcom,ipq8074-tsens
>>>>>
>>>>> Part-2 is changing from one valid syntax to another i.e.
>>>>>
>>>>> 	+        items:
>>>>> 	+          - enum:
>>>>> 	+              - qcom,ipq9574-tsens
>>>>> 	+          - const: qcom,ipq8074-tsens
>>>>>
>>>>> Without both of the above changes, either or both of dtbs_check
>>>>> & dt_binding_check fails. So, it is not possible to just add the
>>>>> "valid hunk" (part-2) alone.
>>>>
>>>> Of course it is. All schema files work like that...
>>>>>
>>>>> If having both part-1 and part-2 in the same patch is not
>>>>> acceptable, shall I split them into two patches? Please let me know.
>>>>
>>>> No, hunk one is not justified.
>>>
>>> For the other compatibles, the enum entries and const/fallback
>>> entries are different. For the 9574 & 8074 case, we want to have
>>> qcom,ipq8074-tsens as both enum and const/fallback entry. Hence,
>>> if we don't have the first hunk, dtbs_check fails for 8074
>>> related dtbs
>>>
>>> 	ipq8074-hk01.dtb: thermal-sensor@4a9000: compatible: 'oneOf' condition
>>> 		['qcom,ipq8074-tsens'] is too short
>>
>> Why? It is already there. Open the file and you will see that this is
>> already covered.
> 
> I guess dtbs_check doesn't like the same value being a const and
> a oneof entry.

I don't understand.

>  Have attached the file, please see if something is
> not in order.

I don't know what changed there. Please work on patches.

> 
>> If you remove it, then yes, you will see errors and the answer is: do
>> not remove it.
> 
> I haven't removed it. 

You did. Look:

       - description: v2 of TSENS with combined interrupt
-        enum:
-          - qcom,ipq8074-tsens

The first character in the diff (-) means removal.

> For this patch, ipq8074-tsens changed from
> being an oneof enum entry to a const entry. Probably, that is why
> dtbs_check is giving these errors.

You removed the entry which you should not have touched.

> 
>>> 	ipq8074-hk10-c2.dtb: thermal-sensor@4a9000: compatible: 'oneOf' condition
>>> 		['qcom,ipq8074-tsens'] is too short
>>>
>>> 	ipq8074-hk10-c1.dtb: thermal-sensor@4a9000: compatible: 'oneOf' condition
>>> 		['qcom,ipq8074-tsens'] is too short
>>>
>>> I'm not sure of the correct solution. Having the first hunk
>>> solves the above dtbs_check errors, so went with it. I'm able to
>>> avoid dtbs_check errors with just one entry in the first hunk.
>>
>> You made multiple changes in one patch which is not correct. Your goal
>> is to add only one change - ipq9574 followed by ipq8074. Add this one.
>> Don't touch others.
> 
> But that breaks dtbs_check.

All other cases, hundreds of other binding files, do not have problem.
Only this one "breaks dtbs_check". No, it does not.

Whatever is broken is result of your removal of unrelated pieces.

> 
>>>  	+      - const: qcom,ipq8074-tsens
>>>
>>> Please let me know if there is a better way to resolve this or we
>>> can have just the 8074 entry in the first hunk.
>>
>> You only need to add new item on the oneOf list:
>>  - enum
>>      - ipq9574
>>  - const: ipq8074
> 
> The "['qcom,ipq8074-tsens'] is too short" errors were generated
> with the above snippet only. Please see the attachment

It's not true. The error you see is result because you removed something
you should not. I did not ask you to remove anything. So repeating -
"add new item". Adding is not "removal and adding". Adding is just "adding".

Best regards,
Krzysztof

