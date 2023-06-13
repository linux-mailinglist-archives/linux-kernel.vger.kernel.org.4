Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73FB72EE2B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbjFMVit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238663AbjFMVip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:38:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA31DDE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:38:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9786c67ec32so3063366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686692322; x=1689284322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IjC8sLTBfnrVHtu3dchJNU/FgXzyF+J0/8Jze1O1iI8=;
        b=AzPT/wZgr7P0DAlj9wX7buFMwigcsG5VkN5YC46JszhbWZpQOMBnCVL1CGFrzmZeOT
         Yz1QkEOXoaZQOMUJeGAAkC0LGXGETn0ux03RePC5Qq6T9BPXxd+Me4IWCkg5CSYYQcqH
         t/a1dpR4nmcP9MzGMtoqtVbQ3MVNa3tgU47r/gOXlvB97wW0TRSee4EnK6stQyxk7Ulm
         O+QubKI24lPmUcxuds3zWVjhhI28F3r2KGcuBMzkLhaV6goEd2zFsN9LadnDdl/ZPtZl
         bzyF3QsqXk1IOEzTY+E+MD2zpzq5B4h40GwOAAXqT2qsimPfVXek/cFCRCKca4fCKOqI
         JeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686692322; x=1689284322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjC8sLTBfnrVHtu3dchJNU/FgXzyF+J0/8Jze1O1iI8=;
        b=BMf3ATfaxZUetHLnkpgPHIB8CN+YD50/q0a83lPDqsO57IoKRcYSnFFQ8MucNlKHyg
         DF6ZG+jiYRqM1kyuHssRsxkCJbZKBH7tlrVeuiT6V4vcVWp6M/spTGXb+bLONRI3xyw/
         uWJLrIusrRdWtjB6XJOu7lajtseeEvNqzroyBSZjepBcVWdt2Xr0957bGUXCAa27lWm/
         nlz66yTUlW7Vz/LkBvkvFHVaVzwUXdityc4Inb3rCVXzFdAvuBiTTUoLTfVwty7WAe5I
         RwuKSwB1Taw4SIMN2V+L94iZhmAIZEAbjCP2wl+okPSyj8tZjyVY38ojKB8apTLLRuYQ
         jWtA==
X-Gm-Message-State: AC+VfDz3FzyTRCevX1rk444jVBNhQyr+d1S/IZA5v5qQGTCfmBcNOko7
        EhgPFc77lX6VWP6v2SiQH9RtYA==
X-Google-Smtp-Source: ACHHUZ65Rx8zx8S8O4fyQjWDJKbkfBSxlojJnhgAncSog4C1GQJK1oHej6a0lu74m26bO+xbiEsNPQ==
X-Received: by 2002:a17:906:eece:b0:959:6fb2:1c3b with SMTP id wu14-20020a170906eece00b009596fb21c3bmr13125627ejb.39.1686692322273;
        Tue, 13 Jun 2023 14:38:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id v6-20020a17090606c600b009745d484519sm7135381ejb.70.2023.06.13.14.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 14:38:41 -0700 (PDT)
Message-ID: <57082b2e-7f89-4e90-492e-54d7bebb427b@linaro.org>
Date:   Tue, 13 Jun 2023 23:38:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 7/8] dt-bindings: rtc: isl12022: add #clock-cells
 property
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-8-linux@rasmusvillemoes.dk>
 <208d06d1-58e3-748e-de28-075dc0cd28de@linaro.org>
 <13f61130-ca44-cacb-15f7-835a74dda26f@rasmusvillemoes.dk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <13f61130-ca44-cacb-15f7-835a74dda26f@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2023 22:25, Rasmus Villemoes wrote:
> On 13/06/2023 21.10, Krzysztof Kozlowski wrote:
>> On 13/06/2023 15:00, Rasmus Villemoes wrote:
> 
>>> diff --git a/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml b/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
>>> index d5d3a687a34d..a9ef68b5fdcd 100644
>>> --- a/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
>>> +++ b/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
>>> @@ -11,6 +11,13 @@ maintainers:
>>>  
>>>  allOf:
>>>    - $ref: rtc.yaml#
>>> +  # If #clock-cells is present, interrupts must not be present
>>> +  - if:
>>> +      required:
>>> +        - '#clock-cells'
>>> +    then:
>>> +      properties:
>>> +        interrupts: false
>>
>> Entire allOf block should be like in example-schema, so before
>> unevaluatedProperties. Please put it in correct place in your first
>> patch so here it does not have to be moved.
>>
> 
> OK. That first patch was basically a copy-paste of c690048ed59b, and
> e.g. ingenic,rtc.yaml has a similar non-trivial allOf block between
> maintainers and properties. Is there somehow I could have known it
> should be right before unevaluatedProperties?

The trivial - with a $ref - we keep often at the top. But once it starts
growing, should be at the bottom. Since you know it will grow, just put
it at the bottom (not total bottom, but like in example-schema, so after
required:).

Best regards,
Krzysztof

