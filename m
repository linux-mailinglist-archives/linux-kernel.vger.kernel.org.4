Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F356F529F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjECID6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjECIDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:03:19 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE7644B1
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 01:03:15 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b5c830d5eso3417621b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 01:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1683100995; x=1685692995;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IuHTDynqLGxxmuU6R7soQb+HpPsi95aRNfhv/UWyEoU=;
        b=Rdnmk0vMBR2RC1vLXadJgM8fodzer7Yx0bURvxnTjvM9DP90dd6BxlwMCzuNDW+Y90
         +b25jTQ8OxHJcv9vxT7gHQJkoLmXrnpbMoxmKDBV+tS37zmzKEBWGjTL+end1UUmWmeJ
         2PPMr8fcFXMU3bP/YWf93L3kB1pap6jwty6rLAT8TWibEgyVrqoM4RbaK3wDd8e8PyX/
         dpYWzlD9F9etRCqOGfC/AI8COwicFA4Wh4iy1qmjpG9RLgKX8/Lb/rPWUSO8bfJ8YRvq
         dxW9+KiyGNvrFHfPNjevanTHO30c1Zh5cNEcBwd3MNwofIAt1Vk15EeLTAM0IMfNFtKo
         TRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683100995; x=1685692995;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IuHTDynqLGxxmuU6R7soQb+HpPsi95aRNfhv/UWyEoU=;
        b=AEV/9XVnhINjEsXcvXFPR//jc9eSi5ukS1Nf8WKSt/X2w8CcaWGIytBTCAcpyodHjj
         3Htzrc6rcVtzg4UeYWNMhEmDfAC4cYxHPyN9M/8ps5/ObFb9df21iBd4zmB39cfLrU94
         4iaTs3DeDcmHqGHkmNGl4slExI4NE6TPXNrAJxq0tyBwiPbIyehnp8i7FXrmylKda49f
         ghQKRMvvOlHxs92shGvj1LxnmlajlF1fenNToG380clAqX8aSlQCJSjEFRX/WLf1LVKx
         iWl3oCfYmHZE6AflqHRFkNBZVcl5P6ULKpcHoGH7OhWk41ITLRpLwcTipoFWq30+HXfF
         96xA==
X-Gm-Message-State: AC+VfDzAT5JyBgmtU5loZnz8063f3qjbU06KxFi9wgcwdHpT3R+wnhKH
        3PnEpurd6OP7ASnnXKHMIGdopQ==
X-Google-Smtp-Source: ACHHUZ7VyC22IBkwxjzJKCko1UQWhzax+vegJjyCeInhiUfwECWGRVRc5Kf552leZ4srKUQyeP4EVw==
X-Received: by 2002:a05:6a00:15c4:b0:63f:1eb3:824b with SMTP id o4-20020a056a0015c400b0063f1eb3824bmr30128381pfu.17.1683100994871;
        Wed, 03 May 2023 01:03:14 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d855:461d:14be:2cce:b776? ([2405:201:d02f:d855:461d:14be:2cce:b776])
        by smtp.gmail.com with ESMTPSA id z63-20020a626542000000b00642ea56f06fsm4566702pfb.0.2023.05.03.01.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 01:03:14 -0700 (PDT)
Message-ID: <228e9d1d-47fc-e62b-b0dc-013b36ba2c9e@9elements.com>
Date:   Wed, 3 May 2023 13:33:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: Add support for multiple
 supplies
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     Rob Herring <robh@kernel.org>
Cc:     zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230420192402.3695265-1-Naresh.Solanki@9elements.com>
 <20230421213659.GA1786000-robh@kernel.org>
 <fa096963-c173-dacc-647f-21a367c772b0@9elements.com>
Content-Language: en-US
In-Reply-To: <fa096963-c173-dacc-647f-21a367c772b0@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 24-04-2023 02:22 pm, Naresh Solanki wrote:
> Hi Rob,
> 
> On 22-04-2023 03:06 am, Rob Herring wrote:
>> On Thu, Apr 20, 2023 at 09:24:01PM +0200, Naresh Solanki wrote:
>>> Add optional DT property 'regulator-supplies' to handle connectors with
>>> multiple supplies.
>>> If this property is present, it will determine all regulator supplies.
>>> Otherwise, the 'vout' supply will be used as a fallback.
>>>
>>> This change improves support for connector like PCIe connectors on
>>> mainboards that can be powered by 12V and 3.3V supplies.
>>>
>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>> ...
>>> Change in V2:
>>> - Added example
>>> - Update property type & description.
>>> - Improve commit message
>>> ---
>>>   .../bindings/regulator/regulator-output.yaml  | 21 ++++++++++++++++---
>>>   1 file changed, 18 insertions(+), 3 deletions(-)
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/regulator/regulator-output.yaml 
>>> b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>>> index 078b37a1a71a..a9dce26991ff 100644
>>> --- a/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>>> +++ b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>>> @@ -21,13 +21,22 @@ properties:
>>>     compatible:
>>>       const: regulator-output
>>> -  vout-supply:
>>> +  regulator-supplies:
>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>>       description:
>>> -      Phandle of the regulator supplying the output.
>>> +      Optional property that specifies supply names provided by
>>> +      the regulator. Defaults to "vout" if not specified. The
>>> +      array contains a list of supply names.
>>> +      Each supply name corresponds to a phandle in the
>>> +      patternProperties.
>>> +
>>> +patternProperties:
>>> +  ".*-supply":
>>> +    description:
>>> +      Specifies the phandle for various supplies
>>
>> While you say use 'vout-supply' for a single supply, nothing enforces
>> that anymore.
>>
>>>   required:
>>>     - compatible
>>> -  - vout-supply
>>>   additionalProperties: false
>>> @@ -37,3 +46,9 @@ examples:
>>>             compatible = "regulator-output";
>>>             vout-supply = <&output_reg>;
>>>         };
>>> +      out2 {
>>> +          compatible = "regulator-output";
>>> +          regulator-supplies = "sw0", "sw1";
>>> +          sw0-supply = <&out2_sw0>;
>>> +          sw1-supply = <&out2_sw1>;
>>
>> Names in the consumer are relative to the consumer. You appear to be
>> naming these by the supplier. Just add vout[0-9]-supply and iterate over
>> that name in the driver. Then you don't need "regulator-supplies".
>> Really, you never did. You could just find all properties ending in
>> "-supply".
> Please correct me if I have misunderstood anything
> What I understood is:
> 1. Use 'for_each_property_of_node' & iterate each property,
> 2. String compare each property name ending with '-supply',
> 3. If there is match then initialize accordingly.
> This way all *-supply property are also included including vout-supply.
> This way, regulator-supplies isn't needed.
> Shall I go ahead in this way ?
I wanted to follow up on our previous discussion regarding the naming of 
properties in the consumer. Based on your feedback, I believe that I 
should use 'for_each_property_of_node' to iterate over each property and 
then string compare each property name to find those that end with 
'-supply'. This way, all *-supply properties will be included, including 
vout-supply, and the 'regulator-supplies' won't be needed.
Can you please confirm if my understanding is correct?
Thank you.
> 
>>
>> Rob
> Regards,
> Naresh
