Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA48674F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjATIX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjATIX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:23:58 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E057C78ABD
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:23:56 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so5306640wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FgloWXFLaFs9lmJG0fPOaTpoYd54+C3xSVgrFaunkT0=;
        b=MHCGfgilU6ydlCFAZY5JatZkaD2pp/zBsnjj10yE611kJslbTuldF2Ay27aBDL9Wyx
         A0alK4w+msJgKduZqXDeuSLDUFetGDQIsrJ9KC49tzY9DyJJpGPytDhxbQ4vSZPsN+Lb
         EGle3WyRPf4lG39x9nGSf9yjOlEJeQXAnZvXApuMwdEurDEIPtpb66uqcajWVfWErmWl
         0wzy4li7yElaB6e08Loqd/Hle7PBAU4htngF4xusf3TKT8NByPEvLB3NNGds5+kiHu45
         kG5wx9e1oJhcCOEbjSDBxX+JE/joyng7hUmGriz6Q1LEE+BGC8YCQriTXmu9zvbKYX9a
         CRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgloWXFLaFs9lmJG0fPOaTpoYd54+C3xSVgrFaunkT0=;
        b=TnbDAiDzpCugW+hWhGKoz0umcyOUG7tS0FC7vAARa6DoQeMdmWUWi/4Yhi5gF7KQx8
         Iwi3YIUMxEABd8E2OGHe2/EuhMAT9AcXLcU9v0fPyusVR9cg23hzTSwR/IkqnlwxXZp0
         3naY+w+o+Il1dfFFHlDXDPf8BeSwcX+9aUyUb5nBQMicTu1yUd0zBjc5ATjGHrMKD8lL
         cLZAnLVVY7gmM71Nui3J6djDuRA0pnPxGV950eYZpj2xG5xVtB1hSaqKXSuHa199J0hv
         ySaOW5GX9jWAaB3tssxT7lpBsBM3UFss73rqOlmnM8d6/WljDNPkKK/Ptf+fd8phxsnT
         Cvfw==
X-Gm-Message-State: AFqh2kq2qaHVAYJeAMJWhP3P/BIrqO4yx4RqgZSriBEPxGTIa8O0qitD
        cosmtB2oCZa4sOQD5HIBmZMiMg==
X-Google-Smtp-Source: AMrXdXtzKTRjLx4Z1Jr2/H8s3PWQANcY3pEfPSsg7PLeLmP7E+lFoP4RTADLwa6KxNEDcah3ADdPoQ==
X-Received: by 2002:a05:600c:3b82:b0:3d2:392b:3165 with SMTP id n2-20020a05600c3b8200b003d2392b3165mr13346564wms.12.1674203035433;
        Fri, 20 Jan 2023 00:23:55 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o28-20020a05600c511c00b003dab40f9eafsm1608605wms.35.2023.01.20.00.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 00:23:55 -0800 (PST)
Message-ID: <a6fda8b6-c714-e66d-af74-0ce773e6cfe9@linaro.org>
Date:   Fri, 20 Jan 2023 09:23:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 2/2] spi: spidev: add new mediatek support
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org
References: <20230118-mt8365-spi-support-v2-0-be3ac97a28c6@baylibre.com>
 <20230118-mt8365-spi-support-v2-2-be3ac97a28c6@baylibre.com>
 <Y8l/mQjjgKJiE1/F@sirena.org.uk>
 <CAFGrd9pZ0Lso6LMKkN=ErujGgRi6t5_C3FvbMYHaV5V_DD0BnA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAFGrd9pZ0Lso6LMKkN=ErujGgRi6t5_C3FvbMYHaV5V_DD0BnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 20:30, Alexandre Mergnat wrote:
> Le jeu. 19 janv. 2023 à 18:36, Mark Brown <broonie@kernel.org> a écrit :
>>
>> On Thu, Jan 19, 2023 at 06:28:20PM +0100, Alexandre Mergnat wrote:
>>> Add the "mediatek,genio" compatible string to support Mediatek
>>> SPI controller on the genio boards.
>>
>> All my previous review comments stand, please don't ignore review
>> feedback.
> 
> Hi Mark,
> 
> Yes sorry about that, I wasn't aware that I've some feedback when I
> sent V2 for a quickfix.
> 
> I will take care about your comment:
> 
>> We need a matching update to the binding document.
>>
>> This does also seem like a terribly generic name - Google
>> suggests that this is actually a series of numbered products (eg,
>> Genio 700), perhaps we should be using the specific numbers here?
>> I guess users would care which they're talking to.  It really
>> parses as being "generic I/O" which would be an end run around
>> describing the actual product though it's not actually that.
> 
> Is there a binding documentation for spidev ? I didn't find it.
> 
> My understanding is to have something more specific like:
> compatible = "mediatek,genio350"
> Or maybe use the SoC name, to be aligned with the DTS ?
> compatible = "mediatek,spi-mt8365"

This should be specific compatible for your device attached over SPI. If
you have there "Genio 350", then the first.

Compatible can be documented in its own binding or in trivial-devices (I
sent a patch for existing ones).

Best regards,
Krzysztof

