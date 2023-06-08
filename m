Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32E7727B32
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbjFHJ0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjFHJ0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:26:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF2C2680
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:26:07 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-516a0546230so524404a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 02:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686216366; x=1688808366;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=03BJWd8kwUz/PX6fs8czwd8z71E5lrJAOIWmRROBv7A=;
        b=BCIwoqj1/HqVJuDuxVAPMqTyjB7V+UwDfa6WmqI61Vv2CH/q907TPnwZe8lDCpshaP
         U4i7ixKUvm1351RYVjsAhT9Zv6VELRHMbQjnxeUjQkRXh35mJFHGoA+MV5Yk60gI/iQW
         CGABrPWuL+d7yOjaOTTOJAde32O0Noo0O2ksbE/w5wnMEL3923L0wk54rPaWnlGJ75k5
         Jx4cQ4OjixStgbtr7fVmI0Upx0Hy79un2WUtUW2hW7eFYwepScbBNpuP4zD6/RbrxUN0
         w9Tp8YFaarb6Zw632o/8V87KKfbZPJ7WoP1MzWj0Xku9FYsCdmx0rEO7iN4j8zy+ODNd
         ZviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686216366; x=1688808366;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03BJWd8kwUz/PX6fs8czwd8z71E5lrJAOIWmRROBv7A=;
        b=IcX+TxD5eG5nXTcAyoLG9biA0lJzmswrM3XCudB7S2zkBFAIBfSgfip2GVOwYK4Wpq
         6pjqWo6K9J1GwrVh+dXye0ZJCsNw4a055/Rm8f67/x/ZoTIAi1OHA4VYxYl3t5yNYZnq
         ej0UA15DE0RmWABlmR/U8rfNUWdTP/Svf2AVDKdfcVGInyQvu6azHs9pNF8cZRZ0JkfY
         GLO9yqa/BdrVS627JJLk+wRy/gWOspDaPh8ASlzGSfNIlbZox+sQMVViQe8+E/PnOU3Z
         fElPq6FZ9nCzYqDWZjT7+gc5lZrp7H1Z0ZOp8JVrH5ZsoCnixkLOy7YLfBvFwzjTwiPG
         QbnQ==
X-Gm-Message-State: AC+VfDz3qDRWdPSEykLGNw9DDJ/3zDfilzi5SFqq6adYAhKBWaXI9e4w
        zlODSSuZux6A3TuiNUKsaiPiYQ==
X-Google-Smtp-Source: ACHHUZ7OEP3vwBVFqBeczcFqR9O9YzQQuofZmkKRaPneB03HPeNiGD9Xju5/x1O66AFVuWpIlRBApA==
X-Received: by 2002:aa7:dc04:0:b0:514:9c80:e3ff with SMTP id b4-20020aa7dc04000000b005149c80e3ffmr6237809edu.2.1686216366279;
        Thu, 08 Jun 2023 02:26:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g16-20020aa7c590000000b0051056dc47e0sm326588edq.8.2023.06.08.02.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 02:26:05 -0700 (PDT)
Message-ID: <05038be8-f59d-5b2b-9b51-36094941f731@linaro.org>
Date:   Thu, 8 Jun 2023 11:26:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [v6 1/4] dt-bindings: pwm: Add ASPEED PWM Control documentation
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
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
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>
References: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
 <20230608021839.12769-2-billy_tsai@aspeedtech.com>
 <4dffd320-8e30-fb30-6ded-79519afddc21@linaro.org>
 <SG2PR06MB3365DD80EA2FD026D400C4A78B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
 <61278e12-ba39-4503-ca74-a7118b0f6e99@linaro.org>
 <SG2PR06MB336528007D2685F8D95DF4078B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
 <9f8a9208-62d4-0c96-7d1c-a452d3d7e799@linaro.org>
 <SG2PR06MB3365FCF5BEA6555EC503EFEC8B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SG2PR06MB3365FCF5BEA6555EC503EFEC8B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
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

On 08/06/2023 10:57, Billy Tsai wrote:
> On 08/06/2023 10:21, Billy Tsai wrote:
>         >>         On 08/06/2023 09:47, Billy Tsai wrote:
>         >>         >>
>         >>         >>   >> +
>         >>         >>   >> +allOf:
>         >>         >>   >> +  - $ref: pwm.yaml#
>         >>         >>   >> +
>         >>         >>   >> +properties:
>         >>         >>   >> +  compatible:
>         >>         >>   >> +    enum:
>         >>         >>   >> +      - aspeed,ast2600-pwm
>         >>         >>   >> +
>         >>         >>   >> +  "#pwm-cells":
>         >>         >>   >> +    const: 3
>         >>         >>
>         >>         >>   > 3 cells? For one PWM? What are they?
>         >>         >>
>         >>         >> channel, period and polarity.
>         >>
>         >>         > Don't cut my responses. You wrote you have one PWM output, so only one
>         >>         > channel. What do you put then in the channel?
>         >>
>         >> You need to put 0 in the cell of the channel, the example of the dts usage will like following:
> 
>         > If you always put 0 isn't this a proof that it's wrong?
> 
> No, if your PWM controller only has one pwm output, then it should only be configured as 0.
> This is the usage of the pwm-cells property.
> https://github.com/torvalds/linux/blob/master/drivers/pwm/core.c#L129-L158

This is only when you use generic of_xlate. You do not have to use
generic of_xlate if it does not suite you. Again you speak about the
drivers, but we talk about bindings:

https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/pwm/pwm.txt#L13

"controller specific"

> https://github.com/torvalds/linux/blob/master/include/linux/pwm.h#LL299C20-L299C20
> All of the pwm driver with npwm = 1 will has the same usage.

So it seems many simplified their drivers...

Best regards,
Krzysztof

