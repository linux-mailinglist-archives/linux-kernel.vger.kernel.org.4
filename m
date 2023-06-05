Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE424721FA5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjFEHen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFEHek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:34:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A25CB7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:34:38 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9768fd99c0cso480727366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 00:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685950477; x=1688542477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8g/uCudoNru8NUO2fRncIkM8apZtWaRSA3Sr+dRP0vE=;
        b=EZqnx3qFRzHckRGwu64NGFgrgksidmNU1uyIQBt8oEIuivVfPmQQm2nf+4hU2lw/iP
         1RnUU91boWEi92AIWXrVDRMKsf80YofR1suYBsd/Fh7jgN3vq3oi+e0GOve1rJlCOnYD
         ikUKL7snfLrifOPTbfuyEMtcWzU4tpJqOpLlIuxSzwxo7gDnZjAy4tgm1ZhSXoEoJhfi
         O/L42N6w2VrH4KG42Ck/GUYtS3ru2VgfcC0u37bz9U2vS0y2zCHEyOSH+zkOWwMTMO3C
         pgDe8kPdWaMNjqVxVX4vD5cDv3zKdgiTnURbLu7hBWruQBn1ChoKt4prNtdvXB33umNT
         0ORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685950477; x=1688542477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8g/uCudoNru8NUO2fRncIkM8apZtWaRSA3Sr+dRP0vE=;
        b=iAOu9/4IZdXsWr8ddsEMv+WJUX+oupi7JacabohTA3jx5MFbOiuDprCnEYrjyUqxrY
         QSu2xQ3r2ye1QLdFlfC++YFPv+9leMzCAnqo/6uXPUOh4+HtJllnpszTLu1A+56RKjnS
         kDJq2lhGLlagArBFOpfKmFmzdfK3r5RDkIANnzderREV9/iYhEHjV8y8wl3umx6L+oRl
         Q+GRlx4ycrmfkl+rNqHqeqx+U/GIc8HcDmXqRp1Q4t0W8AM8+hkHfy0uJ7MuNzPG/ewY
         dlso7EMGMIug9UUe82a8+CjLJ66typWzHV7ALESFfQqh8IAi6+AqNEbvHLZPrBSZYssQ
         wUEg==
X-Gm-Message-State: AC+VfDx1LDut1u4qd2Vx71rfxWiniDq7hRs2VyC/lSI5Rh2que1mCcKw
        L6Egpxyl+fjr/nzmyjOtGccANA==
X-Google-Smtp-Source: ACHHUZ6O0Ax8DYnAnWLCNsurzFRYdg0Bla791PJzJB/LCSFqUBdwOYwfakFHXzUGj5RgB1RVZModzA==
X-Received: by 2002:a17:907:16a6:b0:977:c405:6c76 with SMTP id hc38-20020a17090716a600b00977c4056c76mr5497706ejc.14.1685950476974;
        Mon, 05 Jun 2023 00:34:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id j21-20020a170906431500b00966265be7adsm3910219ejm.22.2023.06.05.00.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 00:34:36 -0700 (PDT)
Message-ID: <d4509ee4-3eb7-0499-36f8-7d7848ab4928@linaro.org>
Date:   Mon, 5 Jun 2023 09:34:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 01/21] dt-bindings: microchip: atmel,at91rm9200-tcb: add
 sam9x60 compatible
To:     Arnd Bergmann <arnd@arndb.de>,
        Varshini Rajendran <varshini.rajendran@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>,
        "Mihai.Sain" <mihai.sain@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Netdev <netdev@vger.kernel.org>, linux-usb@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Hari.PrasathGE@microchip.com, cristian.birsan@microchip.com,
        durai.manickamkr@microchip.com, manikandan.m@microchip.com,
        dharma.b@microchip.com, nayabbasha.sayed@microchip.com,
        balakrishnan.s@microchip.com
References: <20230603200243.243878-1-varshini.rajendran@microchip.com>
 <20230603200243.243878-2-varshini.rajendran@microchip.com>
 <c72f45ec-c185-8676-b31c-ec48cd46278c@linaro.org>
 <d95d37f5-5bef-43a9-b319-0bbe0ac366b4@app.fastmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d95d37f5-5bef-43a9-b319-0bbe0ac366b4@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2023 09:04, Arnd Bergmann wrote:
> On Mon, Jun 5, 2023, at 08:35, Krzysztof Kozlowski wrote:
>> On 03/06/2023 22:02, Varshini Rajendran wrote:
>>> Add sam9x60 compatible string support in the schema file
>>>
>>> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
>>> ---
>>>  .../devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml  | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
>>> index a46411149571..c70c77a5e8e5 100644
>>> --- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
>>> +++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
>>> @@ -20,6 +20,7 @@ properties:
>>>            - atmel,at91rm9200-tcb
>>>            - atmel,at91sam9x5-tcb
>>>            - atmel,sama5d2-tcb
>>> +          - microchip,sam9x60-tcb
>>
>> No wildcards.
> 
> sam9x60 is the actual name of the chip, it's no wildcard. For sam9x70,
> sam9x72 and sam9x75, I think using sam9x7 as the compatible string
> is probably fine, as long as they are actually the same chip. Again,
> the 'x' in there is not a wildcard but part of the name.

OK, if that's the case.

Best regards,
Krzysztof

