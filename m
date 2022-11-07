Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C726061FDA8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiKGSfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiKGSfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:35:42 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832CA20BEC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:35:41 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j16so17921227lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZto2aI8Bptli2OzTKbCF8aaAGorStB0N8MSB1xDDtE=;
        b=vo5nLgHJwfnXEhjUBrU1bPOwdaFEjM909+M2qoa53AjbBjcM3hNZqMa4pZzsuCQRn0
         lpPDAJnxdGAijHfUaO4MdbZe4RjB65J7KstdKxwI6d0f8BLN822lpu8f8Wc8TuJClkKN
         ZM9eJuggIQbYxLVe77V7d3dGfkJih4Yo4HoeUA5JtntxU5R0KyJbIJnhQ5nOBYCh0Mnr
         eQcH3mcm+IGiCba6xHn9au9243J9KLjzFhg9TBAUT76iv1KbLNYW+yMMrjdHST1AD7NQ
         LSJFvlneJpLNT3t2mc0UA85cSd1YTHdFuOg2ZYtRlHQ/kkiQOWjtN+E6UePW9qbg/ZXZ
         RCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZto2aI8Bptli2OzTKbCF8aaAGorStB0N8MSB1xDDtE=;
        b=wk9Mk6xqTTTDdFOt8lsmf9AGNxujFu0JqtYx89tEjceByNLMNNJJUlLq565YHbD5Ym
         NKGWQ+SAIPS2ReM2Mu9PFLXu1o/dDZ7B1z2vqv7vnLlSyHK0LOhs1sZ8gNbDU0pMCFXA
         Ffw//5OjuYQZOpcoF9+fN+GOAKqNWKNdT3Z5JRdf2RVIRl29KzVlxWdYrZD/PaNyjPCL
         sWsn042pCepC9HkUaLEb7XkBtSBiAT4VFmlDxz/NcyOaJ6ozr/nYXsidSWsnlBRZYb25
         pKU54l5Tm6pRQF49gfitf7KJBit8+QSH5vUps/F74CNqQE+LiIkoln9J4YAqwXSx1uPV
         k4tg==
X-Gm-Message-State: ACrzQf3yopQfkiMbqEp5CKxqz90RlO/Se5N4sjtnP209c9qfIQv6QOlv
        X5iGNM5tJdUSS5Hk8PyvbgflbmKh61cwqQ==
X-Google-Smtp-Source: AMsMyM6ioglBiZGtDLKRsAr68YwkWzhXxrEcAKOa49F6LtuCSk/ZFcxVyr3OS6Jtu4/aUqvZZJBsLQ==
X-Received: by 2002:ac2:5221:0:b0:4a4:5af7:8ad5 with SMTP id i1-20020ac25221000000b004a45af78ad5mr17457353lfl.388.1667846139899;
        Mon, 07 Nov 2022 10:35:39 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id j23-20020a056512345700b00492d064e8f8sm1371621lfr.263.2022.11.07.10.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 10:35:39 -0800 (PST)
Message-ID: <c8ad788b-5934-8dee-e122-3450a19dd08f@linaro.org>
Date:   Mon, 7 Nov 2022 19:35:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: examples: add a list of templates and
 solutions
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221028233701.572280-1-krzysztof.kozlowski@linaro.org>
 <20221101130720.GA963805-robh@kernel.org>
 <34f40c1c-f933-cee6-f022-14c37650dc3a@linaro.org>
 <20221104214744.GA2878314-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104214744.GA2878314-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2022 22:47, Rob Herring wrote:
>>>> +7. Phandle to syscon with offset:
>>>> +   Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
>>>> +   Line: 42
>>>> +
>>>> +8. Variable length of array (e.g. clocks and clock-names) but narrowed to
>>>> +   specific variant:
>>>> +   Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
>>>> +   Lines: 33 and 71
>>>
>>> It seems like some of these that are just a single property we could add 
>>> to example-schema.yaml.
>>
>> I am afraid the example-schema will grow too big for folks to look into.
>> It's already quite complicated, with explanations of the dtschema
>> behavior itself.
> 
> How about splitting up the top-level descriptions and property examples?

You mean splitting up to separate YAML files? I guess this could work
and still be concise - few examples showing different concepts.

> 
>> How about then RST file with small code snippets?
> 
> Then they don't validate.
> 
>>
>>> Also, perhaps a reference to this from writing-schema.rst.
>>
>> I can do this as well.
>>
>> The problem with my approach above (and adding these to writing-schema)
>> is that examples above can change, lines can be inadequate.
> 
> I just meant a link in writing-schema.rst to this doc. We already have 
> that for example-schema.yaml.


Best regards,
Krzysztof

