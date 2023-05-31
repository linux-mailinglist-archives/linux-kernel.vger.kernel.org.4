Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6618F718A8F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjEaTwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjEaTwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:52:15 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF33B2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:52:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96f588bc322so905036966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685562732; x=1688154732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1AXHWk/YSqwK5iuVg7Rf8ARA1b5WwwgiDBHo0HeuQqQ=;
        b=p8/n15zzHjN++mxQVxOYxsLaTTeMFbKAtQZ7k0+9QuxuUbH0yc4GOBCFIaU+2+6eGJ
         rS5oHrBRziDN+ZS10vKPpsgEDAhzpBwM5Xffy5B5x2iMdx4dpIC2ofF1SVZRwRuW+Jv6
         jGaBYQW0H+zmTjK41PLIdwpQwPtZ9CO1sEmWZFGIF/vFBnYU7eSskCTbfUa5ukvI7iYC
         RweQsKNhkkOsV4idt/GYUPwMrwUf6kUyT6edw5+/6SZ6O+5fdP0QPaXD/e2uso02hxQF
         kw7cdpTJf4ZiNapFvMjRavqvZPj8e0GdcA8UtI70gEA/nPtNHKvm8hTKGTL05kIW9qaT
         9dVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685562732; x=1688154732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1AXHWk/YSqwK5iuVg7Rf8ARA1b5WwwgiDBHo0HeuQqQ=;
        b=JmVB9VcHR/kR73EpDJ1GGglmxcgpLM9EzfDyw3ohkCJ2XfOxQmpfxDExjYMlK+u5zJ
         sbCR8RxWbeGcYERWLbGfmbX3xqa6aUNow30TJ8VNiOVeCm9mhpu5BGvEqLuGCZ4ty9QC
         Lltg81dbNGkrfhltWKrmX4ysqiRVsE1w0zqKHuiOztb/I5HmC0n/8K9yktJQJQp9ukXv
         OC20dk+hlJfNk0PTnOzfiiRgUJLNiwjhphtAnvLlVJdlprN8jJdiBPEsHT+W/NDS5o5N
         F5EzcsiHwNtOJtTWnSK4Uif09nRCBAE84ynV/FPwZDWQR2L8wUFJSR8QS133F2+wI/fL
         4dTw==
X-Gm-Message-State: AC+VfDy22XqL7hOSpVuK6Pjm/RPJD2OquJfHguLnm7QHXU2oO6v79CJW
        Wz13dsdP608kfUsae+JA1N7bkA==
X-Google-Smtp-Source: ACHHUZ4ahSA+4qLQB16wjjioqUa9jdnNEl6+anvoGz1oPk/vIJtdE6uXygdBD5ehV6Fn/E2wPfzApQ==
X-Received: by 2002:a17:907:980c:b0:974:419d:7837 with SMTP id ji12-20020a170907980c00b00974419d7837mr413298ejc.34.1685562731836;
        Wed, 31 May 2023 12:52:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id va15-20020a17090711cf00b0094ee99eeb01sm9475328ejb.150.2023.05.31.12.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 12:52:11 -0700 (PDT)
Message-ID: <ce89ecb8-3505-6aff-7aec-f7f1cf133656@linaro.org>
Date:   Wed, 31 May 2023 21:52:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: power: supply: Fix rt9467 charger enable
 gpio active level
Content-Language: en-US
To:     ChiYuan Huang <cy_huang@richtek.com>
Cc:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        chiaen_wu@richtek.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1685522813-14481-1-git-send-email-cy_huang@richtek.com>
 <1f966e93-50c3-142e-620c-8fbb16e9b1a7@linaro.org>
 <20230531093618.GA17005@linuxcarl2.richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531093618.GA17005@linuxcarl2.richtek.com>
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

On 31/05/2023 11:36, ChiYuan Huang wrote:
> On Wed, May 31, 2023 at 11:17:37AM +0200, Krzysztof Kozlowski wrote:
>> On 31/05/2023 10:46, cy_huang@richtek.com wrote:
>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>
>>> The RT9467 charger enable pin is an external signal that used to enable
>>> battery charging. From the datasheet, the active level is low. Although
>>> it's already configured to logic low at driver probe function, but the
>>
>> NAK.
>>
>> You mix two different things. Driver behavior and DTS. Driver can
>> operate either on real level - matching hardware - or on logical level
>> (high as enable, low as disable). First choice is usually wrong, because
>> it does not allow inverted signals.
>>
>> 'Correcting' bindings to wrong approach is wrong. If the signal is
>> active low, then the flag is active low. Simple as that.
>>
> If my understanding is right, so the correct way is to fix the driver code,
> not binding exmaple.

Yes, that's my opinion. The DTS should describe the hardware and in the
hardware the pin is active low.

Now the driver should operate on logical state, so it want to enable
(value of 1) or disable something (value of 0).

Best regards,
Krzysztof

