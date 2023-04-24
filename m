Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9D66EC81D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjDXIwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjDXIw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:52:27 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E28B115
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:52:25 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f182d745deso41299245e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1682326344; x=1684918344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=deVVhPb2N3DmdmKHs5nt2Ad8ZkEvs9U6ZZ+ZaoatAdM=;
        b=SFPVYK2WVJc/ClTB+cAUWM4TDCYe2emz7Z6SW/oJqgdpzLrclrTa5lXupSJam/HfxL
         hMk8VDjPu19k1xGPPOsf/RtVieN3kmS1hSsEE0iNvue44L/YSQPFue6lT0UD9fWkjN+R
         /IVAOqrmc7PsGbtWeqAL6qoS8ShFJNhm2vOePTGHiybfXPGVE3vubGV0E9tC9wPkW6cR
         8crPr8O/YtrTz3oZc9UWds247wWf3BiCCmOlZ1DsMFnpA3WOtIBxGL8e8KltPDfq/6Xs
         VrxNXwfWPkKheZssLczIQg2Fgy5oiAX/yEUkL0UtuhfOQXzZ8lJmujjFyk1nh38c82Bu
         XxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682326344; x=1684918344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=deVVhPb2N3DmdmKHs5nt2Ad8ZkEvs9U6ZZ+ZaoatAdM=;
        b=bve68HjJl93XA9RR8FVubNeevOMJ7L6+Yvf12+tuzklnjEUPO25fkYjqsS4u7Dm7oR
         xgd+yzf9nnUN/MXjzm5OR3264mHNG5Si/ypcK3qLP1QEYxU/Qi7AuXtYymYlWDTiwcjz
         d6eeVx74PUUUrzqx+5+dDFCvR35nI/fOxFSH0RLS2ucqrZJxETXgOwr2qkoVk3IGqK+I
         DbQnsEWd2OMCmxDo4jhLyPf6J0yZlwVjPN1fmr7i/ptd89ADe9YVtzRUuug33D+lvXUx
         8KKpftXslg/n+yVzj4eHvITPFSWY5Rb8bLwyE19zblb8Evlms4IgC5Jv8slXePe2dtUU
         x46A==
X-Gm-Message-State: AAQBX9f+8ub5TWrvBRtf3p5qbLQ5FkgNFpmlfTRtjTUH6WyPGsYryAhJ
        k5HA4VBNM3V3kt8uI6NNuKQUgg==
X-Google-Smtp-Source: AKy350ZCWbzGmnFbEoPKwhbt8WKAgauSrM5KFPLAWBXyAEUOJWF6fn29tsFZUf+3jxexBoNeYqS/tg==
X-Received: by 2002:a7b:c441:0:b0:3f0:7e56:82a4 with SMTP id l1-20020a7bc441000000b003f07e5682a4mr7557927wmi.18.1682326344016;
        Mon, 24 Apr 2023 01:52:24 -0700 (PDT)
Received: from [192.168.29.232] ([49.37.170.173])
        by smtp.gmail.com with ESMTPSA id s1-20020adff801000000b00300aee6c9cesm10327196wrp.20.2023.04.24.01.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 01:52:23 -0700 (PDT)
Message-ID: <fa096963-c173-dacc-647f-21a367c772b0@9elements.com>
Date:   Mon, 24 Apr 2023 14:22:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: Add support for multiple
 supplies
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230420192402.3695265-1-Naresh.Solanki@9elements.com>
 <20230421213659.GA1786000-robh@kernel.org>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20230421213659.GA1786000-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 22-04-2023 03:06 am, Rob Herring wrote:
> On Thu, Apr 20, 2023 at 09:24:01PM +0200, Naresh Solanki wrote:
>> Add optional DT property 'regulator-supplies' to handle connectors with
>> multiple supplies.
>> If this property is present, it will determine all regulator supplies.
>> Otherwise, the 'vout' supply will be used as a fallback.
>>
>> This change improves support for connector like PCIe connectors on
>> mainboards that can be powered by 12V and 3.3V supplies.
>>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ...
>> Change in V2:
>> - Added example
>> - Update property type & description.
>> - Improve commit message
>> ---
>>   .../bindings/regulator/regulator-output.yaml  | 21 ++++++++++++++++---
>>   1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/regulator-output.yaml b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>> index 078b37a1a71a..a9dce26991ff 100644
>> --- a/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>> +++ b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>> @@ -21,13 +21,22 @@ properties:
>>     compatible:
>>       const: regulator-output
>>   
>> -  vout-supply:
>> +  regulator-supplies:
>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>       description:
>> -      Phandle of the regulator supplying the output.
>> +      Optional property that specifies supply names provided by
>> +      the regulator. Defaults to "vout" if not specified. The
>> +      array contains a list of supply names.
>> +      Each supply name corresponds to a phandle in the
>> +      patternProperties.
>> +
>> +patternProperties:
>> +  ".*-supply":
>> +    description:
>> +      Specifies the phandle for various supplies
> 
> While you say use 'vout-supply' for a single supply, nothing enforces
> that anymore.
> 
>>   
>>   required:
>>     - compatible
>> -  - vout-supply
>>   
>>   additionalProperties: false
>>   
>> @@ -37,3 +46,9 @@ examples:
>>             compatible = "regulator-output";
>>             vout-supply = <&output_reg>;
>>         };
>> +      out2 {
>> +          compatible = "regulator-output";
>> +          regulator-supplies = "sw0", "sw1";
>> +          sw0-supply = <&out2_sw0>;
>> +          sw1-supply = <&out2_sw1>;
> 
> Names in the consumer are relative to the consumer. You appear to be
> naming these by the supplier. Just add vout[0-9]-supply and iterate over
> that name in the driver. Then you don't need "regulator-supplies".
> Really, you never did. You could just find all properties ending in
> "-supply".
Please correct me if I have misunderstood anything
What I understood is:
1. Use 'for_each_property_of_node' & iterate each property,
2. String compare each property name ending with '-supply',
3. If there is match then initialize accordingly.
This way all *-supply property are also included including vout-supply.
This way, regulator-supplies isn't needed.
Shall I go ahead in this way ?

> 
> Rob
Regards,
Naresh
