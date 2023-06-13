Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEE172DA24
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbjFMGtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbjFMGtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:49:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CDD10F7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 23:49:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so9125937a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 23:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686638939; x=1689230939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JByW78XRxwt99QO8bpQ4dJ/f+SnJIwQTPeLVoUbaf6E=;
        b=CUH5io/2NXK9bJPrQ4CKLbyiev/+CzqQvIpxpYkdcdhl8VKlJAtIAR3zbZeeDJhwUo
         PmPCw4FMiDLSLeHE8jfh8vP0EJlCropcNp61+eZu8GixJ/X8b24NFSe0xwlge9s9ZmPV
         iWDfhWMG+TROBBgM+luWc8nFxaUlrI4uhLqNL5pQ7LGr55lHcq2xrI0rLO/xCpqGEVDi
         IQA4F+G5QfiB1peiDeR9gVwkO/ZhOsd24gsGjdHZdcOhBKmxXVgCK39J/kNwqcXHpcSY
         g6pTwqiHmIi9nGLeNJniSOH2UiJ5QKC29S1YYNqGPQUNeZweulAQIazq6K1aNmMPXIIt
         Qy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686638939; x=1689230939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JByW78XRxwt99QO8bpQ4dJ/f+SnJIwQTPeLVoUbaf6E=;
        b=akPGg5P15F6IcugqPotavPde7RmeeBR6lcvHHVkO5kkYt9tnuGhtb1YaHmDvuM31wC
         zNZOSaB3Rw5LqpVB9dQPOpuZ1jCyU0HkC0nVK/zpU63KxBf7Dl+a30zFqLWcB+GyIToD
         9y7dU4HOYQi/ZJJhQYU5HkaIq+TWtTiaMXIQ1w5VdL/7CJJXP37QVcnUKFJlzhTDT6t0
         GHb4NKha3ptBb5NkfPkNkXsXEdixi5nwsUGylRdrIejsq3QPwagdNfW43qsMFJjsnKJp
         nZ0wPifJvoz0hy+uqamG8EIbBlP8iiea5C6tuOrXVkb9NjYGlf+53GTisftdiQqlYjKf
         GWBQ==
X-Gm-Message-State: AC+VfDwoWOzKpZJ5ktKyXLcmh+Np2FkWFaiMS8VwhSgf7y90K0xZouzf
        0/uA7w3n05I6iMuj4r2AAAZaeg==
X-Google-Smtp-Source: ACHHUZ5/M9JVbjysecegMnbOiZeUTZSN0jbLGBBwN5EOdmZ+O/uJf1KT064tupN6w0UPiJ5xdqKdyw==
X-Received: by 2002:a17:906:dc90:b0:969:faf3:7dba with SMTP id cs16-20020a170906dc9000b00969faf37dbamr12740249ejc.52.1686638939343;
        Mon, 12 Jun 2023 23:48:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906960f00b009783791b1a1sm6211872ejx.121.2023.06.12.23.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 23:48:58 -0700 (PDT)
Message-ID: <5064f8aa-7aff-bf51-212c-e4d7e465b36a@linaro.org>
Date:   Tue, 13 Jun 2023 08:48:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,pmic-mpp: Fix schema for
 "qcom,paired"
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230418150606.1528107-1-robh@kernel.org>
 <9543f619-88fa-8e54-6e9a-4334750e51b4@linaro.org>
 <CAL_Jsq+ZVAZc1nYJVLPQt=KM1qOZrZCrRC4q_o8XQjDdo_NuKA@mail.gmail.com>
 <CAL_JsqJMpjW6a4Q6xUX6TEZ+vyLJJn5bDtwEdf_-E=BeA-Z_tA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAL_JsqJMpjW6a4Q6xUX6TEZ+vyLJJn5bDtwEdf_-E=BeA-Z_tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2023 23:34, Rob Herring wrote:
> On Fri, Apr 21, 2023 at 1:48 PM Rob Herring <robh@kernel.org> wrote:
>>
>> On Wed, Apr 19, 2023 at 2:56 PM Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 18/04/2023 17:06, Rob Herring wrote:
>>>> The "qcom,paired" schema is all wrong. First, it's a list rather than an
>>>> object(dictionary). Second, it is missing a required type. The meta-schema
>>>> normally catches this, but schemas under "$defs" was not getting checked.
>>>> A fix for that is pending.
>>>>
>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml | 5 +++--
>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
>>>> index 9412b9362328..4c3e9ff82105 100644
>>>> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
>>>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
>>>> @@ -144,8 +144,9 @@ $defs:
>>>>          enum: [0, 1, 2, 3, 4, 5, 6, 7]
>>>>
>>>>        qcom,paired:
>>>> -        - description:
>>>> -            Indicates that the pin should be operating in paired mode.
>>>> +        type: boolean
>>>> +        description:
>>>> +          Indicates that the pin should be operating in paired mode.
>>>
>>> Current Linux implementation uses it as a generic pinconf param
>>> pinconf_generic_params which is parsed by:
>>>
>>> pinconf_generic_parse_dt_config() -> parse_dt_cfg() ->
>>> of_property_read_u32()
>>>
>>>
>>> The pinctrl-spmi-mpp.c driver, using this schema, treat it as a bool,
>>> but I still wonder how the code will parse bool with
>>> of_property_read_u32(). Maybe it should be uint32 with value of 0 and 1?
>>
>> That should be an error because the length is too short so it should
>> go with some default from the code.
>>
>> Looks like there is no user, though no property could mean keep the
>> default/bootloader setting. Can you sort out which type is really
>> desired here and hopefully we can get rid of the other type. It's not
>> the first case of pinctrl properties with multiple types, but we don't
>> really need more.
> 
> Still an issue here. Please sort out what functionality QCom wants here.
> 
> dtschema (main br) will now throw a warning on it.

I think we can go with your patch, after double checking my previous
concerns are not relevant here - driver reads it as bool just like other
bool properties.

Best regards,
Krzysztof

