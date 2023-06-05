Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D892D721E37
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjFEGgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjFEGgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:36:33 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F68DF
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 23:36:31 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96fdc081cb3so656662266b.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 23:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685946989; x=1688538989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2DzCC5nNj9v724sBHpzIo/I7iRoYP7iyXhmHfz9Pk7Y=;
        b=EfGxmQgBDHTK3j0dd8RNyLsGK1duhmTxBU8B3HBUvpPxlCuH5uWRWAxz7HvXZCq524
         jwQ2hCHnyKGWaP+VcXdHo8XVXue7aJTSH7pKErryvBtVqaVmXOgsjmA61C+/XMBvyXuI
         XpazGattWkNXMdKUK31h68OPYWLUhgNRVtpCNO6l8nTJzLZp/4Hz9cQdGYhRySi5fCh+
         iHwasAxQMWf4whFDhyfjmRyufJ+tObicaoV78hGCqWie2UEBKUngjNKqNycneMm2GZ+a
         esgYE7DDocfsBeYkJ/Ydl4NmbHxvGf0d08XzDVNqqdsVrXIxa4vi9P++2Uuryl2FP/lE
         2TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685946989; x=1688538989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DzCC5nNj9v724sBHpzIo/I7iRoYP7iyXhmHfz9Pk7Y=;
        b=lbtql8ljrLa6hB1YH0EiANtvUi6GbKaUro5szbuYlFrtZprF+U/fNYAW7IWbzATN1o
         nHw9+AkDVYbwKRbItyw2P2rVAeeP0dvFs11pAx6UGy6GVaqrz0ynT9XM288izKZ6/4gy
         VMjYewcykAfkZ+smdqIyNf/S8+Vt1zI2exug7q/HG/LNpVBoalQzFchkAMS34Rk8b/CG
         V+Vc5EEs2VrDwMqis9knidpO7EuI3PAFqyPuPjsCieB/RF8HMZNhdJwhkLpj19KhezAq
         50JAs/6LBzKjRPzc1PNaxnAb8u0X8TYD3kpczw40TzGk92kzIl8vbdw67o+XgObqdZL/
         7Psg==
X-Gm-Message-State: AC+VfDzJ/zx3uX1W/X4GnpCOTTtS2WqiTYgOd8r/N8Qfd5+5P+HNNdCq
        QQmnlYLDGxyh5IqMGrdhwrLjnCJyjzVWlE6cq5k=
X-Google-Smtp-Source: ACHHUZ6d00GdMTR6aAxeVElkl0mxPzjdle9Lbahv1I4pFtz6RO6KSMrZET+M4yBitY9jdcpIUHeAuA==
X-Received: by 2002:a17:906:5d09:b0:974:1c91:a752 with SMTP id g9-20020a1709065d0900b009741c91a752mr6371767ejt.5.1685946989561;
        Sun, 04 Jun 2023 23:36:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090668cb00b00977eb9957e9sm145894ejr.128.2023.06.04.23.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 23:36:29 -0700 (PDT)
Message-ID: <3b776a90-add5-f870-b20d-0b1bf9b05bc8@linaro.org>
Date:   Mon, 5 Jun 2023 08:36:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 03/21] dt-bindings: usb: generic-ehci: Document
 clock-names property
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        gregkh@linuxfoundation.org, linux@armlinux.org.uk,
        mturquette@baylibre.com, sboyd@kernel.org, sre@kernel.org,
        broonie@kernel.org, arnd@arndb.de, gregory.clement@bootlin.com,
        sudeep.holla@arm.com, balamanikandan.gunasundar@microchip.com,
        mihai.sain@microchip.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Hari.PrasathGE@microchip.com, cristian.birsan@microchip.com,
        durai.manickamkr@microchip.com, manikandan.m@microchip.com,
        dharma.b@microchip.com, nayabbasha.sayed@microchip.com,
        balakrishnan.s@microchip.com
References: <20230603200243.243878-1-varshini.rajendran@microchip.com>
 <20230603200243.243878-4-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230603200243.243878-4-varshini.rajendran@microchip.com>
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

On 03/06/2023 22:02, Varshini Rajendran wrote:
> Document the property clock-names in the schema.
> 
> It fixes the dtbs_warning,
> 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'

You cut too much from the warning. Which target/board?

> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/usb/generic-ehci.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> index 7e486cc6cfb8..542ac26960fc 100644
> --- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> +++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> @@ -102,6 +102,10 @@ properties:
>          - if a USB DRD channel: first clock should be host and second
>            one should be peripheral
>  
> +  clock-names:
> +    minItems: 1
> +    maxItems: 4

Not really, because we want them to be fixed, so you need to list the
items. But it seems this is not needed at all... which boards and
drivers use names?


Best regards,
Krzysztof

