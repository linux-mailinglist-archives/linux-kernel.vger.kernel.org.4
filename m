Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A75A7268B0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjFGS1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjFGS1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:27:15 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99732694
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:26:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5149c51fd5bso2016703a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686162401; x=1688754401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZRj+mE8jCuZmOYVQqkftbO+ddM2GLO7xQ0oXcx+IVPg=;
        b=pzkOcuk2QH5o8cSqzHedtXSDBcDhlF3m1WDSJvl7OVrVSK0Q3W5DgsoqMvf5fE6X1O
         JiAdA/oH10Y2IzEdmhHsNm8PNLmX60mlHAlZAIOXaP2bSe8a+0mEOri7GwAahN3I5w+f
         1OL1nbq2JFg8rTKxc6LBUiNSYG4iuckRDEIeTaOeihJgbOKV0yrHA8pB6c9bi1DrhM94
         tqerLRwLfB06wLXl+kKoTWrJ4q7Zr+C2dRU4lQUXsjOcOb6mq4R8VySKoRElUYe2vN6X
         DevUHmBVJ+Pq2mmfVm3H5BZBlHQLtIch9DGumt1Ttpem2iJLme0pspfd6gIMqNQYVqXF
         8bqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686162401; x=1688754401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRj+mE8jCuZmOYVQqkftbO+ddM2GLO7xQ0oXcx+IVPg=;
        b=EPorcdcN1DJ2I6OKZYoQk5PgyWiyT1tZRuaAEvlEdGWZp1loYw2RIjyMMnFxOaVU5c
         MkDji8ArEMG04+cITMK0nYpC3wYJW8IGY96OsHQgavQx01oYWffvfYnCmDfK10dQI7yi
         +Sbk7FJ/WOCLualJPi6B6JP2t9KgEesUfssqiyUcD6Nk7tK+QKh9qdzPnY0SweI9Kh9E
         Ny3sEtSNjJzQ+K9STAmVzCaX+fmWIJEwh94SUXimSp0I++LWHltbkqkI3KiXUcvc9KbE
         n+Tm9uLo2eZm87FzME6kd/M/kM8cPVkMI57aDbNIyykiiGBUKa19cfU7xW2jGYyLXj5k
         j9Ww==
X-Gm-Message-State: AC+VfDz+to94p41psH+oX8fJvf1GXnwYHra05RXRBwHlctoXjXpa5UtG
        IO38mKajYs4G9RsuGMyvNnxTbw==
X-Google-Smtp-Source: ACHHUZ5YUulZzqwNfYTpRRDDYzgUjLAdgZeSBYf9eA5aKTpF9KWdikk8pq/Ts0lAJ7VXnuCh4iWv0Q==
X-Received: by 2002:a17:907:3e1e:b0:96f:b58e:7e21 with SMTP id hp30-20020a1709073e1e00b0096fb58e7e21mr7507816ejc.52.1686162401374;
        Wed, 07 Jun 2023 11:26:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id bv2-20020a170906b1c200b009659ad1072fsm7215357ejb.113.2023.06.07.11.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 11:26:40 -0700 (PDT)
Message-ID: <fdb342c0-393b-dc34-bbc4-f23f1d59492a@linaro.org>
Date:   Wed, 7 Jun 2023 20:26:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [v5 3/5] dt-bindings: mfd: Add aspeed pwm-tach binding
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>,
        Patrick Williams <patrick@stwcx.xyz>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee@kernel.org" <lee@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20230606094535.5388-1-billy_tsai@aspeedtech.com>
 <20230606094535.5388-4-billy_tsai@aspeedtech.com>
 <35bf0a69-bcf6-ae35-eb3c-e74cfcf9c571@linaro.org>
 <ZH89fXknZlhGmM_H@heinlein.vulture-banana.ts.net>
 <c28f963e-d13c-6b5c-c389-996e986f81d5@linaro.org>
 <SG2PR06MB33652E18980E9CF8E4F0894D8B53A@SG2PR06MB3365.apcprd06.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SG2PR06MB33652E18980E9CF8E4F0894D8B53A@SG2PR06MB3365.apcprd06.prod.outlook.com>
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

On 07/06/2023 08:26, Billy Tsai wrote:
>> Missing description. But more important - why do you have such child
>> nodes? Your example does not have them. What's the point? Do you expect
>> different number of fans per one device (one compatible)?
> 
> In this patch series, I have included examples and descriptions to provide additional information.
> The child node is used to enable the channel of this tach controller.


Children are not for this. Look for cells examples (e.g. gpio-cells,
pwm-cells). It seems this is the same as Nuvoton NCT7362Y, so no. Don't
use reg for that purpose.

Best regards,
Krzysztof

