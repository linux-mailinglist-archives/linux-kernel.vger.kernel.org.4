Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9EE63D0C1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbiK3IfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbiK3Ie7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:34:59 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8664127FC0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:33:11 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id r8so20062738ljn.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3xyoqBbnWI1VD4qfERQYhc2TYfB9goHU//f2T1eH4sA=;
        b=NE4OZEyIBve2A4/6L97Ksr74YB99GYQP8ru+raeK0Efi/HOro1oQuMn43AcPfLSRqq
         xpzfn9Ul25PRJjsQtnHhnrS/Q1e2UFtzhJJhSAnOvyA5aWlwum1zbF9LeA1NT1LLqzXg
         M8TqgKj83qP4NKxA2ySdQDQABTQR9HyRcEB1dBdx3aJPB9Qw/MapLnQ+euq7nIIclleR
         ZHw2shYKo9vfvMAxFa4WlXNhSPbROPUm7QmlM6AIVYNTaWKNCxuYqWKbbqPAOT6710HJ
         XngZEjEqcfkzwYdUUtgkqnP7DkvMvukg3abPMlmC86m/y0dc6ZMQDjxUsDdQCdXKO8Mh
         UWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xyoqBbnWI1VD4qfERQYhc2TYfB9goHU//f2T1eH4sA=;
        b=lyW04aRSJPyYT5Vst46acj57NxlxT6XS93RA5BkFavpvfFgamzbDcj/QcdDp6P+fn+
         qHTtJ4mZA53Mgz0zsSzcwEcT8nAc3LVnNU4MOYSX00AfV1GHPVLCc7NbaLnRfUQ0Ns2m
         KMbcyg3xOerCYnm1/YTOdNPbGfitMHynGQ3D/85sYokMu7QYQ9oslwcWQ1eyIC0tOnCv
         0/1jga7medFeHD/FUq/NEH28S+H3UY1dJVghb+i/NueZxvxFtoIduUPT+G76UppYkD2I
         VujafUkkC6U2K06LdICwwYPME6yLxMFbaB3GNwXdttCW6aGl04dRVw2vaEL/VyEZiCfU
         nZFg==
X-Gm-Message-State: ANoB5plXcqybP6K/VZU5sh0FRpFARH+aqAybRks6gv3PAgVO9UZ30e67
        0bGokS+virbFA2hZuQtehBQrWw==
X-Google-Smtp-Source: AA0mqf6E1YVyQ7wWFtFozRvgmCREjNx3M/WigYathuheXoU28TQTHO2oG62fRfkoLQZHx4tnNrIxQw==
X-Received: by 2002:a05:651c:1586:b0:277:38f:ffad with SMTP id h6-20020a05651c158600b00277038fffadmr12718875ljq.439.1669797189767;
        Wed, 30 Nov 2022 00:33:09 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d10-20020a056512368a00b0049e9122bd0esm166301lfs.114.2022.11.30.00.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 00:33:09 -0800 (PST)
Message-ID: <08bd485b-51f6-8249-63a7-a6864a431276@linaro.org>
Date:   Wed, 30 Nov 2022 09:33:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/3] dt-bindings: leds: add dt schema for
 worldsemi,ws2812b-spi
Content-Language: en-US
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Chuanhong Guo <gch981213@gmail.com>, linux-leds@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221129140955.137361-1-gch981213@gmail.com>
 <20221129140955.137361-3-gch981213@gmail.com>
 <98b72494-3188-76d5-2e24-9dc127a8b31a@linaro.org>
 <20221130001459.3wyxnwpjaxvla6oj@mercury.elektranox.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221130001459.3wyxnwpjaxvla6oj@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2022 01:14, Sebastian Reichel wrote:
>>> +      default-intensity:
>>> +        description: |
>>> +          An array of 3 integer specifying the default intensity of each color
>>> +          components in this LED. <255 255 255> if unspecified.
>>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +        minItems: 3
>>
>> Drop minItems.... but:
>>
>>> +        maxItems: 3
>>> +        items:
>>> +          minimum: 0
>>> +          maximum: 255
>>
>> default: 255
> 
> I would argue, that the default should be 0 (off) instead of 255
> (full power).

Yes.

> 
>> What controls the intensity? Don't you have PWM there?
> 
> WS2812 is a RGB led, which contains a small Microcontroller. The µC
> takes 24 byte intensity data from a serial input and then passes on
> any following bits to the next LED. SPI clk and chip-select are
> ignored (chip-select support can be trivially added though).
> 
> You can find them everywhere nowadays, since they are quite cheap
> (a few cents per LED) and need only one MOSI pin to control hundreds
> of LEDs.

OK. This should be anyway existing property, so default-brightness.

Best regards,
Krzysztof

