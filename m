Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0016072793D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjFHHyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjFHHyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:54:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474FD10F8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:54:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51458187be1so508804a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 00:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686210847; x=1688802847;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E2Twlaiedobdlie44+yvfCt28qgI5GSJ8RzJigOLjck=;
        b=ZRSQm2SbKPvteuLLgPLe7nCK0DjGUrekqwVBx0rP+syuDvylnzfmb9qt24XNGZ6ulz
         na0MmTT2NJye+PzluJ6LcW3DhyGErcL2K9VGlFTfTw4FUZYh5x82Dg4HdlD8f8c9eAdK
         20FmAs+cjr+D0BAnTZeCULB9MfbUQI0aWqS9fK/2XrJ6CdTDXppj4kl8ief1NvuE9kvM
         YTX6BLXI/s9weYeS30cj8tfGn8Ib6uTXNqvKs7eSNgBq87jQ9lhpPelGD/cXeUU9G5kS
         mPtnmnk2vwG7uuLODA3vMWi+tzqEhTzBevkTldS6+gIxMEci+LsUfozVz4OAG1C1Hcee
         7peQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686210847; x=1688802847;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2Twlaiedobdlie44+yvfCt28qgI5GSJ8RzJigOLjck=;
        b=FDUvU1KZNge7pxM4D0JN49JJgCWbwB9nRQjIJZIh9eKctUWIsk/1fKB61yd5wrCH0G
         12ofHoNDjSq94Mvhi0YZm+aTrsz2XVp6sxmEdAz8xLdn4wi284wYmMqECLc+DvoJII1i
         9MWgJLV1boOg93mCszKFF7dtOrpeBGOj8UANCRFWaRpcxEsEVl0OUT7GRCvrNr71/zip
         Qp1kKSiJys2gJrXA+Xt/EAJZY5hz5BDtx4kCPz4VPpIMO39zUku63un4BctA9Gce6B0Y
         dmjN8eEpqJEqczwtnvFlQ6MiADoGbuzLI9s2kc5aozLJVtDdzH+ihfB7VTO3UFStHAGH
         ICtw==
X-Gm-Message-State: AC+VfDxxehVXtL5/AiVTB3sDBqLXcblAtWdQy3VjnT+C4WxMrcp7bops
        ks5oG8E73fKLBlbcEZ//+jWWdg==
X-Google-Smtp-Source: ACHHUZ4fomm2ljY9Wjm1oqS8KoBZmj6ojHu+GGsGRunrLXkGdjHgEpVBmbct0AHYw4BdzlGEQgP2SQ==
X-Received: by 2002:a17:907:86ac:b0:977:d48f:97ad with SMTP id qa44-20020a17090786ac00b00977d48f97admr7723485ejc.75.1686210846735;
        Thu, 08 Jun 2023 00:54:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n27-20020a056402515b00b00502689a06b2sm235647edd.91.2023.06.08.00.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 00:54:06 -0700 (PDT)
Message-ID: <61278e12-ba39-4503-ca74-a7118b0f6e99@linaro.org>
Date:   Thu, 8 Jun 2023 09:54:01 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SG2PR06MB3365DD80EA2FD026D400C4A78B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
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

On 08/06/2023 09:47, Billy Tsai wrote:
> 
>   >> +
>   >> +allOf:
>   >> +  - $ref: pwm.yaml#
>   >> +
>   >> +properties:
>   >> +  compatible:
>   >> +    enum:
>   >> +      - aspeed,ast2600-pwm
>   >> +
>   >> +  "#pwm-cells":
>   >> +    const: 3
> 
>   > 3 cells? For one PWM? What are they?
> 
> channel, period and polarity.

Don't cut my responses. You wrote you have one PWM output, so only one
channel. What do you put then in the channel?

I will start NAKing such patches without DTS user. It's like reviewing
fake code for some unknown solution and trying to get from you piece of
answers one by one, because you do not want to share entire part.

Best regards,
Krzysztof

