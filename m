Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B49722829
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjFEOFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjFEOFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:05:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA679C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:05:39 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-97460240863so571569366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 07:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685973938; x=1688565938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4F51IRVrDIze+qjXHpDVAhkcOo31QSIv2AnwfuvPioc=;
        b=UUIJLOJ8DY8HMkMDSpoPFW3QMPsxaWKa9VTuxxxNJKt+RhlNq+i8GSi7ki/2a9KFCG
         waghnHUQZiCS05NgwvFAc/DcvjhNsfQZo1TcCUT5yw5j7tQKH6qOMrCE8oZEYJ1m2ixl
         rpI4N+YIk8OkvvOZSHKwLlDhlxe30D14L++k+m5Its/jsA6mCGuk7b0Hrq5KPi5gopnr
         SUcYtei/eHyHUnLr/8GxvRbKJF/0HvPFeiQ6iwf2Z+TJ3xSXBVjidy+qU9Xrm3ALmHN5
         gEhJhaA/+TfDQqCPraDfpzQcsaGASw2lc10l6fwTCdP/2JrWuODodnAaNcdYQ9BjepjT
         oWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685973938; x=1688565938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4F51IRVrDIze+qjXHpDVAhkcOo31QSIv2AnwfuvPioc=;
        b=LpJLqaavkTjKkNzFu/G1JA4TqjCJdlMlPirAI2ewJW2o80g4sK06aygxmZoFkBgJ8k
         N+STjxP699SlzlNmnWcL3yfN6lfOI3zE7F/O62JBWqzzfSSucFaP0ajaizqkv/B1JqzY
         ZkXFFn72huVCdKlGogftBazpPrIYOqN6MCVBVw7Lh0xaPfjCmI/fB0cZ+5L2dqLF2mJJ
         gvxK9udP8hQ96mvAjn2Qx9GGCkpDF4Y84JQe7Qw70iKQCOoaoHk5Xz37Rg2IuX4uzzHJ
         qcAiNihBYn7WqOXnR5+rvIZtxli66QNmPy/4pc1lNwaj2AALzm0qjYu6LW1WazOkmw8Y
         62ew==
X-Gm-Message-State: AC+VfDykfovsdrIloetHyRQ6DUpmpjt4pQV7SJPLeFOsq3gZiwxrHsuu
        9bE98H4busovSCpWC9iSCZKNhQ==
X-Google-Smtp-Source: ACHHUZ4RZZlQTw4Wm7pNOJHPxDHTYEQT2MsZQGjIzs1EFq3F/ubbPD4qykERqVVPH4r9OSPtJ0Fo+w==
X-Received: by 2002:a17:907:2d8f:b0:976:6863:a737 with SMTP id gt15-20020a1709072d8f00b009766863a737mr7462304ejc.50.1685973938147;
        Mon, 05 Jun 2023 07:05:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id c8-20020a170906924800b00977cc473b41sm2376896ejx.142.2023.06.05.07.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 07:05:37 -0700 (PDT)
Message-ID: <5e900bf1-2a5c-7152-7971-37bcadd80e3e@linaro.org>
Date:   Mon, 5 Jun 2023 16:05:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: fixed-clock: Add nvmem support
Content-Language: en-US
To:     Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.1d0217a8-661f-4359-b77b-02222c761b01@emailsignatures365.codetwo.com>
 <20230605133410.15076-1-mike.looijmans@topic.nl>
 <5d1f08f1-792b-255b-89f0-dd5fa2f0baa4@linaro.org>
 <96004048-0ba5-4cd6-406f-e1235c819c97@topic.nl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <96004048-0ba5-4cd6-406f-e1235c819c97@topic.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2023 16:00, Mike Looijmans wrote:
> On 05-06-2023 15:38, Krzysztof Kozlowski wrote:
>> On 05/06/2023 15:34, Mike Looijmans wrote:
>>> Add bindings for a fixed-rate clock that retrieves its rate from an
>>> NVMEM provider. This allows to store clock settings in EEPROM or EFUSE
>>> or similar device.
>>>
>>> Component shortages lead to boards being shipped with different clock
>>> crystals, based on what was available at the time. The clock frequency
>>> was written to EEPROM at production time. Systems can adapt to a wide
>>> range of input frequencies using the clock framework, but this required
>>> us to patch the devicetree at runtime or use some custom driver. This
>>> provides a more generic solution.
>>>
>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>>
>>> ---
>>>
>>> Changes in v3:
>>> Modify fixed-clock instead of introducing nvmem-clock
>>>
>>> Changes in v2:
>>> Changed "fixed-clock" into "nvmem-clock" in dts example
>>> Add minItems:1 to nvmem-cell-names
>>>
>>>   .../bindings/clock/fixed-clock.yaml           | 25 ++++++++++++++++++-
>>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/fixed-clock.yaml b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
>>> index b0a4fb8256e2..23e4df96d3b0 100644
>>> --- a/Documentation/devicetree/bindings/clock/fixed-clock.yaml
>>> +++ b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
>>> @@ -12,7 +12,9 @@ maintainers:
>>>   
>>>   properties:
>>>     compatible:
>>> -    const: fixed-clock
>>> +    enum:
>>> +      - fixed-clock
>>> +      - fixed-clock-nvmem
>> Do you even need new compatible? Isn't this the same clock from the
>> hardware point of view?
> 
> I need a new compatible because a "fixed-clock" only loads at init time. 
> It registers using CLK_OF_DECLARE, which requires the clock to register 
> early. NVMEM providers are typical devices like I2C EEPROMs that won't 
> be available at that point, hence I needed to create a clock that 
> registers as a regular clock driver and can handle deferral and similar.

Ah, ok.

> 
> 
>>
>>>     "#clock-cells":
>>>       const: 0
>>> @@ -33,6 +35,27 @@ required:
>>>   
>>>   additionalProperties: false
>>>   
>> Put it under allOf. Entire block should be before additionalProperties
>> (just like in example-schema).
>>
>>> +if:
>>> +  properties:
>>> +    compatible:
>>> +      contains:
>>> +        const: fixed-clock-nvmem
>>> +
>>> +then:
>>> +  properties:
>>> +    nvmem-cells:
>>> +      maxItems: 2
>> Anyway, I don't think you tested it. Provide a DTS user of this. I don't
>> think it works and such user would point to mistakes.
>>
>> Properties should be defined in top-level properties:, not in
>> allOf:if:then. In allOf:if:then you only narrow them.
> 
> Ah, got it. Added an example dts block to the document, this revealed 
> the issues, indeed didn't test the bindings.
> 
> Fixed it into an "allOf" to properly narrow the properties.

The real DTS user would be also welcomed.

Best regards,
Krzysztof

