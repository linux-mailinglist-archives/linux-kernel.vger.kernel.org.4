Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD2E6F3389
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 18:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjEAQ2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 12:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEAQ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 12:27:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6590E124
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 09:27:57 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bc070c557so3437717a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682958476; x=1685550476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e9lVh64jM33d4LMooLPUuuzQksiW+TZToGUMu7K+YSM=;
        b=z60/MVK8/HkZ6esdpAiuI19sPObutnIBlyvBt+m5+iuPmWk9mlIC++CgwqIZdaigC5
         6BKc+LyK/i7ghAuutlJRhCGJFv4Q4mU4fRjUkRFzgXxRV3GbR+gjGvLP1JT3pR4V73ys
         62vsVXsgvpkpjK/m142eRyIF0+dTY8D1GaqhHa2ua6M9Gxz1A2S4eRtlUbthhQGvcdqG
         90Wi9/8223Hhd0oZGA8du2yZ45jbggQggiYuVXgywDaGuQJlqzZPHbunE9pWXClmRu2O
         ERaXQhlJSXyML4lPv3JFs9rOU1Nvm55/Gf74VdBGS0sNq23uaIIicYCDmzehjt7Sz+jg
         N/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682958476; x=1685550476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9lVh64jM33d4LMooLPUuuzQksiW+TZToGUMu7K+YSM=;
        b=ShXhHNLq53uyCb2xg2ItHOaAeXTpLsxev5l7Hhh7WxVFYPS81+83DLc9cC67+TzcXd
         Qml5PiKPchzBE1QcPZhEnlcE8KjDfJJ0QxodYdX44JKW50lAsQJIkbd0NhufBck1F7NQ
         uot3G9S/nBXdMeRmD/8IyFBaM/kCCfQL9U68lyqa6yInsk8NAtY6lYs5DVnaVFChJDBK
         ++TApdpcJJtvS7Oy2m+LWriXf6IO38cIp3lTjHjqw+88Yh+L9T0VL5zoGuheMg+7SzOl
         enD4y3wc8BTGQmPcspevzSR9pj4BC8FGUpUvSeU8r54S0l9+C86IeNcr19K/omWIu3Xh
         x3DA==
X-Gm-Message-State: AC+VfDwv2dRLtMJF5dkUvJbhYxCK6JhaeNBkdb4IQZ3JD5gZHI0Py8lB
        8zn9IrKPomSHa/y/0aVHxRgtSw==
X-Google-Smtp-Source: ACHHUZ4ma15X5csw2YRjprlWpBcI6VCQfb3mwFdFMhAU6NHbk6o87oQi1mJMQKSX3tzrxrxRsud46Q==
X-Received: by 2002:aa7:d9da:0:b0:50a:1d85:319e with SMTP id v26-20020aa7d9da000000b0050a1d85319emr5577899eds.27.1682958475815;
        Mon, 01 May 2023 09:27:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:637a:fd0c:58fd:9f00? ([2a02:810d:15c0:828:637a:fd0c:58fd:9f00])
        by smtp.gmail.com with ESMTPSA id q9-20020aa7da89000000b005069175dcb7sm12523060eds.58.2023.05.01.09.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 09:27:54 -0700 (PDT)
Message-ID: <deaca10c-46ac-df19-5540-f1ae4c6fe9f7@linaro.org>
Date:   Mon, 1 May 2023 18:27:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] imx8mn-var-som: dts: add SOM EEPROM
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230427195639.2718734-1-hugo@hugovil.com>
 <88a7cf9e-89a5-7860-2219-337aee04e75e@linaro.org>
 <20230501094514.38acbacc7f596226f04dc504@hugovil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230501094514.38acbacc7f596226f04dc504@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2023 15:45, Hugo Villeneuve wrote:
> On Fri, 28 Apr 2023 15:06:22 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 27/04/2023 21:56, Hugo Villeneuve wrote:
>>> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>>
>>> The 4Kbit EEPROM located on the SOM contains hardware configuration
>>> options, manufacturing infos and ethernet MAC address.
>>
>> Use subject prefixes matching the subsystem (which you can get for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching).
>>
>>>
>>> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>> ---
>>>  arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
>>> index 9052b0d4b5b4..3ed396f41e46 100644
>>> --- a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
>>> @@ -30,6 +30,10 @@ reg_eth_phy: regulator-eth-phy {
>>>  		gpio = <&gpio2 9 GPIO_ACTIVE_HIGH>;
>>>  		enable-active-high;
>>>  	};
>>> +
>>> +	aliases {
>>
>> Keep nodes ordered.
>>
>>> +		eeprom_som = &eeprom_som;
>>
>> That's no valid alias. Which upstream kernel driver makes use of this?
> 
> Is "eeprom-som" ok?
> 
> No driver uses it for now..

None of them are valid if nothing uses them. There is also no clear
meaning of this alias to me. Why "som" should denote any alias in
upstream kernel?

Anyway, drop it as there are no users.

Best regards,
Krzysztof

