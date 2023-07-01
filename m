Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEC9744811
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 10:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjGAIeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 04:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjGAIeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 04:34:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB70FF
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 01:34:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-98934f000a5so309453066b.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 01:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688200442; x=1690792442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ln71CslK+wNkG4luuwS7YiYZydBZMEVnpr27Fg4FgP0=;
        b=Q2NkimT1scuu/IiVNGHS7pfdg2HjllvWeMMG8MZCygBWNeAyBQ4YZlE8VlWTun+qm+
         qAbWN2xzkTCjjrRMRq4i/pkcFfBg+mP6KaYVMrm+rGQW/5BLU29xi6PRhNSTh4G5aqrd
         3+OuNyObya/Nb6RQWikgKOie/dcsMauAim2cQxxYHcBAjUokVadSDDKl3HnHHeOfUaCX
         OQgjXn6Hu5AgIDFGXiBgTt4h1H26pwj4DbfK4eeTE9f52jY3HuljAk97JnPocjfJpSRA
         cUJ68KOn2nq3XIGz6rhz/YEBKQaS8xAi9gUoebuRWndad1Mrh8JEs5PQ8Qtq37iI3FmB
         IFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688200442; x=1690792442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ln71CslK+wNkG4luuwS7YiYZydBZMEVnpr27Fg4FgP0=;
        b=f+OHaV1lEJQzTXm/awYHiLncUjMhLVsrHmsac56ObhW3iJ+9lxNX9Or3+unWFUPFzk
         Y+Ct2iGe3rgL2t8ii8lyOfgNKKPscwVGrufbb4AR531VRQOPuFkd9uX3YXDdxEdKqRlK
         dw2eVMgpQTVfRHE1YS1UdzyiVrljd0MxFs2+htUqpfSrfdWpOdzMbmiTS9p+pwQgSv9O
         w+P9H0r28Tm2yVXJKkxjZVcHEwSUTpkxDoaHkNL22PL+8lN68LeZUaFHz3ME19CgbQQ3
         OvVFF51PocR97pdac68MQS98xMMxFQpiC2gLVkAIG8PBY84PezDzW/Wh/sjVH08OY4rW
         3FeA==
X-Gm-Message-State: ABy/qLYI0BOsWTFxLSOHKWtdQNsXXxerIeyIGDj7PS23nCsH0E6mz9Be
        8TH+TDWeXBfgIYFS/yAlejOZOg==
X-Google-Smtp-Source: APBJJlHxmuqetckhUv6v1CC+aVS7a9zdw4R4oa+2xmoDW0Qz3S/5/qPZdv0AD3U+alxjTqLMoko7jw==
X-Received: by 2002:a17:906:854c:b0:98c:cc3c:194e with SMTP id h12-20020a170906854c00b0098ccc3c194emr3250372ejy.52.1688200442264;
        Sat, 01 Jul 2023 01:34:02 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id w6-20020a17090633c600b0098748422178sm8908124eja.56.2023.07.01.01.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 01:34:01 -0700 (PDT)
Message-ID: <e5bd4f01-0b00-4d70-c642-4fdfc0a139fc@linaro.org>
Date:   Sat, 1 Jul 2023 10:34:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 5/6] can: tcan4x5x: Add support for tcan4552/4553
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
References: <20230621093103.3134655-1-msp@baylibre.com>
 <20230621093103.3134655-6-msp@baylibre.com>
 <32557326-650c-192d-9a82-ca5451b01f70@linaro.org>
 <20230621123158.fd3pd6i7aefawobf@blmsp>
 <21f12495-ffa9-a0bf-190a-11b6ae30ca45@linaro.org>
 <20230622122339.6tkajdcenj5r3vdm@blmsp>
 <e2cc150b-49e3-7f2f-ce7f-a5982d129346@linaro.org>
 <20230627142300.heju4qccian5hsjk@blmsp>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230627142300.heju4qccian5hsjk@blmsp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2023 16:23, Markus Schneider-Pargmann wrote:

>>> The version information is always readable for that chip, regardless of
>>> state and wake GPIOs as far as I know. So yes it is possible to setup
>>> the GPIOs based on the content of the ID register.
>>>
>>> I personally would prefer separate compatibles. The binding
>>> documentation needs to address that wake and state GPIOs are not
>>> available for tcan4552/4553. I think having compatibles that are for
>>> these chips would make sense then. However this is my opinion, you are
>>> the maintainer.
>>
>> We do not talk about compatibles in the bindings here. This is
>> discussion about your driver. The entire logic of validating DTB is
>> flawed and not needed. Detect the variant and act based on this.
> 
> I thought it was about the bindings, sorry.
> 
> So to summarize the compatibles ti,tcan4552 and ti,tcan4553 are fine.
> But the driver should use the ID register for detection and not compare
> the detected variant with the given compatible?
> 
> In my opinion it is useful to have an error messages that says there is
> something wrong with the devicetree as this can be very helpful for the
> developers who bringup new devices. This helps to quickly find issues
> with the devicetree.

That's not a current policy for other drivers, so this shouldn't be
really special. Kernel is poor in validating DTS. It's not its job. It's
the job of the DT schema.

Best regards,
Krzysztof

