Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB47F680013
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 16:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjA2Psm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 10:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjA2Psf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 10:48:35 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF031A95A
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 07:48:33 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so6606092wmq.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 07:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/1SEXBl/drT6B50+MLoCmrJXk4pQjWe0OUv8/ULGY0=;
        b=bHbAg0NEPiDWyIAfDBCrE9YEnCjl9DimD46s0O9s+iGCLDRWKJDdoXkcdY8Ic/GYqk
         2VhvBr3441g2GYPzGBEuPhINkeJobRkV+fA9OyuJTnTwZZwhDbxZLKrM0WHOwAAj6lI2
         HFwwAC91xT02fgqj+3kiNoArc+FJiJusmsBxIiuKIY7nX5aykzq2ufFKxzYR0sx8dKW/
         czTO6hUOkmOg009ruXF33CHuFXw6olcv/mH7T70GQDJ4txGZSElVEECurqVSKEkvqa/O
         +kWyZBwG3obnXNN4d+fE51z2lLJTXOTyKFmyn2A6Fw8/+hytQ3G1P5MbyVqj8ryt8s1a
         ymUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/1SEXBl/drT6B50+MLoCmrJXk4pQjWe0OUv8/ULGY0=;
        b=A5de3Ol/LbyENT5aernw5wHB18IugdC996k2aDTc2p3LTROj3HpZpxMsliFaDWt2AH
         /OLrUbq1d4/Ji4KRaGERSA2N/HFUCFf12JqYBZdOJ1QyLloBbJGTUfEUyYD26fDZViKW
         Jyo7mfvP59uyKYlA7oI5KjtQGt8u5pgz871R7eAGy6f9su+C1pwQkflV2N9ohmU3Cpi4
         RCBqmH3LOlLikh9h8O3wvbmdY7I2JXkZR2FeRC6OP02oL4mwOV8cRfwbGYbG6wEROMbl
         XWoUIdJ3YIKef5zR0ly4TZja60H2a538U1ulGQ+AELsQb0fYJBzmVQCjRhp8AOdCfsXz
         uruA==
X-Gm-Message-State: AO0yUKUYy2lfIQ/g7/7JifXywbmeVBmv/lar1iT3T89GnAFzG5xu0lsm
        oqFuhgyHtMJFUYgwvITGx0ltAQ==
X-Google-Smtp-Source: AK7set+u31EI9YP+CMtlmZ0UQD0fuUfEjQ7CLKD/ky8YiQDj0Mgj7cggU1RQsvg6InTRJdV78D73sg==
X-Received: by 2002:a05:600c:1994:b0:3dc:43cf:7302 with SMTP id t20-20020a05600c199400b003dc43cf7302mr6523633wmq.3.1675007311772;
        Sun, 29 Jan 2023 07:48:31 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c42c600b003dc521f336esm2984835wme.14.2023.01.29.07.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 07:48:31 -0800 (PST)
Message-ID: <755d4a78-0b23-a381-c422-d12b0063f06f@linaro.org>
Date:   Sun, 29 Jan 2023 16:48:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/3] dt-bindings: serial: restrict possible child node
 names
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Vasut <marex@denx.de>, Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org
References: <20230127093217.60818-1-krzysztof.kozlowski@linaro.org>
 <20230127093217.60818-4-krzysztof.kozlowski@linaro.org>
 <CACRpkdbOZLhQ1DTNJowNXF=O-Nvpqcb_A+PwkPWFiUSQUbkR9A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACRpkdbOZLhQ1DTNJowNXF=O-Nvpqcb_A+PwkPWFiUSQUbkR9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 14:29, Linus Walleij wrote:
> On Fri, Jan 27, 2023 at 10:32 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> 
>> The re-usable serial.yaml schema matches every property with ".*"
>> pattern, thus any other schema referencing it will not report unknown
>> (unevaluated) properties.  This hides several wrong properties.  It is
>> a limitation of dtschema, thus provide a simple workaround: expect
>> children to be only of few names matching upstream usage (Bluetooth,
>> GNSS, GPS and MCU).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Fair enough,
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> However I think V.35 WAN devices (high speed serial network links)
> should actually be using this? They are just some fancy serial port
> after all. Cf
> Documentation/devicetree/bindings/net/intel,ixp4xx-hss.yaml
> 
> No big deal I guess since they are mostly an anarchronism and not
> on the table right now.

intel,ixp4xx-hss is not part of the expansion bus node.


Best regards,
Krzysztof

