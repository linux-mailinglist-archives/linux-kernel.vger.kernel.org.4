Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23E66B6B28
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjCLUmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjCLUmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:42:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9326438B79
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:42:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id da10so41064005edb.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678653726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GHzPrArPSFPgfuYsr4ZXbMFqP1TEyOaJHA/l0zzPg/8=;
        b=cjvc4wVH7ZrX5wYR9DRZxPmOO6oYHmgDvnC5mUDmpO8aa0lgFRKnNvUy5C05OfziGt
         FFDmqIvGUCZ7IsbpJ38Z/TZI6c1YQ9WHVIElnI7CAzTgSJLQU44ktan84behiRp5UKzU
         JhTQNXNXDzqMyiKXwrF1o5c9KLWMe3vHcpTEMRk/qQP1MFkvSzUoqqPDLswqfFgR4fVg
         Xsv0Loaa8rIC52YQdOOHAZJVq9iJnQvfDujrSjeKothSE/mw7OZ1kgooRysWaYx94kkF
         oRvwCkPan51mthsF5JUIF3l5xzVYOwX3FuWjjFQy4upnManXY3HBpZoxmqGTOQyh1fZt
         qSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678653726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHzPrArPSFPgfuYsr4ZXbMFqP1TEyOaJHA/l0zzPg/8=;
        b=dflQkHqpqj9V7FX6inFqJwVkgqrxHRLywCXZASpgPH94sZ0eRaI3BMDr9nS79rM/WD
         mFcxRsrX8EKolkxUKrkArzI2+nlm83MDklXf9/HtFgtXJMFO7YrPau3nAT3gVsW72Ihd
         2KsyqFfutKckzUw1nWFwkJYw7Sc6qI8LIT/R6sxneJVf0ZumRjSjvU7db/VBCfjuD9HU
         9A2qO88KTxUlgcOec6xAfSkWRa/dqgnzWHSlmU5VvpVHQswUICUUvPKdxH/LWn2/RY+R
         IL05Iius/1Q9oGclTNSDX2KZJAGxOmZET5LZu0vQHh9M9uB9/bQHxZvHIr0hdNNszh2T
         H99Q==
X-Gm-Message-State: AO0yUKWGo+9bkh7pUTM5yD132GgfFBYwB+aNYXrpxNkM04uWOdFsAKjf
        aPe5j9nI3A7+15c33RVbas1Cvg==
X-Google-Smtp-Source: AK7set+AP24eEs9NMEKYN5np84zavaGOnu9MRs4zim3J9QYJ3olH6XQQaBiJaXBiF4hktiyIg2+D9A==
X-Received: by 2002:a17:906:304a:b0:8b1:4051:6d2c with SMTP id d10-20020a170906304a00b008b140516d2cmr30924138ejd.19.1678653726119;
        Sun, 12 Mar 2023 13:42:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id tp25-20020a170907c49900b008c16025b318sm2541302ejc.155.2023.03.12.13.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 13:42:05 -0700 (PDT)
Message-ID: <b5d636d7-2816-64c5-9e3f-cff5a56772db@linaro.org>
Date:   Sun, 12 Mar 2023 21:42:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: leds: Document rohm,bd65b60 bindings
Content-Language: en-US
To:     Bogdan Ionescu <bogdan.ionescu.work@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.or, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230308201451.11629-1-bogdan.ionescu.work@gmail.com>
 <c0ec5137-ed86-d695-7335-d1564d814862@linaro.org>
 <CALfPHoVT007ifyTepr_p-saDQtv5Sk7iYXM4qSMXyaCLL3iE2A@mail.gmail.com>
 <d993fc28-1bb5-0a05-c7d2-4891038328e6@linaro.org>
 <CALfPHoVR=kmHmbhNzQg-bW-bV6P8e_sE+vEebQXOfL-nEWg5TQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CALfPHoVR=kmHmbhNzQg-bW-bV6P8e_sE+vEebQXOfL-nEWg5TQ@mail.gmail.com>
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

On 12/03/2023 21:34, Bogdan Ionescu wrote:
>> I think yes, but what about LED on/off? Is it also shared or separate?
>> Because if it is shared, then basically it is just one LED...
> No, the outputs can be enabled independently, but I don't see any
> function in the led_classdev to do that.
> The led-sources property looks like the right thing to use for this.
> If I have effectively only one led per device, do I still need an led
> child node or is this sufficient:
> 
> +   #include <dt-bindings/leds/common.h>
> +   i2c {
> +     backlight@64 {

First of all, backlight is something a bit different/more specific - see
Documentation/devicetree/bindings/leds/backlight/

Anyway for led-sources and everything in one node, I think you do not
need any children. But this will allow you only one function and one
color...

> +       compatible = "rohm,bd65b60";
> +       reg = <0x64>;
> +
> +       led-sources = <1>, <2>;
> +       function = LED_FUNCTION_BACKLIGHT;
> +       color = <LED_COLOR_ID_WHITE>;
> +
> +       rohm,ovp = <30000000>;
> +     };
> +   };
> 
> Best regards,
> Bogdan Ionescu
> 

Best regards,
Krzysztof

