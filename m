Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD25F5F8C24
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 17:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiJIPwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 11:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiJIPwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 11:52:10 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DA324957
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 08:52:09 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a18so2628762qko.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 08:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RQfrxf1xyv3OAwcUSRttuLU5XS0IqfbFO1TojWKCk8o=;
        b=rJqR5cVcssLs8ufBcr6Vrod46OtirTstddc/UL7IKmUHJPMBabNMGmR1iXFZkDuCGJ
         x82P4PTLWly/7f6J1L6qve6YEfEuskpzYm+icdKQAP4YfrrBy7qCLhyzseKhc6L63xGs
         Jom7ZCchcp1JNONBmAmdjL/KNPbrjjwSOe1A7SNzqKBYnueB/SRBsMZtFthgi6a/ATrn
         SnZA+odmsjPus1IaXGxk7knAdtSWbLaYbW3lHcefXQ3RHPRfaGt4iuQd7DwuV54L/jcJ
         w58qa41TIdECxe3HO7vSxfNIFG7AX/4GgYljZbwWbyMWoCDfBoWoXiME/QAVncMj7AmA
         ApVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQfrxf1xyv3OAwcUSRttuLU5XS0IqfbFO1TojWKCk8o=;
        b=VpIy5l3FVDrZywUvRWyYIA70WWjcXZWXgzpsOViTX/QJRunMEDDb0htPMyNiHwCliK
         sfos6vQZLOuIRFftUjVy3uYBeMOJ4P3NQz0fjFhWBBhFt3dd/8YbFCTUzBEdbIB+OfhG
         y37xa5NoA9SdwzgvNMEsRgoz7l382ak4mhhkz1LRx9lEFqlhbRkfKpot848PcTB1Tr2S
         jHtCkHd4Kg/QO4UYo/0EIvb8vCh8Y3VQp/3pmsmYZL4YcyK10Jz1C93OReKEmT5hw0DL
         j4aQtlExOSY58jt30ilQzAFtKLe4aAWPGx6WPi2asBfCmBakOzwjXN+k02VWtTSvrfpl
         Xmlg==
X-Gm-Message-State: ACrzQf1HpPFUJk8MvAG1Vxrezw+SuRvxPFn/ORMqC5305fVzgmWyzH4O
        r3pj4c0CkpzLmmRTW3fsvM8RBw==
X-Google-Smtp-Source: AMsMyM5VJHMeMkf3OUo1b9X4c0yMNVIL1M3kRKjfc/PjC0s/RF42BpLvD2phIxU5mJEtyFszAmLLyQ==
X-Received: by 2002:a05:620a:4809:b0:6ce:496c:7e78 with SMTP id eb9-20020a05620a480900b006ce496c7e78mr9984841qkb.470.1665330728688;
        Sun, 09 Oct 2022 08:52:08 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id u2-20020a05620a454200b006af0ce13499sm8142801qkp.115.2022.10.09.08.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 08:52:07 -0700 (PDT)
Message-ID: <ff2f70c4-7af0-d568-34ab-224672c5b96b@linaro.org>
Date:   Sun, 9 Oct 2022 17:52:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC v4 net-next 14/17] dt-bindings: mfd: ocelot: add
 ethernet-switch hardware support
Content-Language: en-US
To:     Colin Foster <colin.foster@in-advantage.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>, UNGLinuxDriver@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>
References: <20221008185152.2411007-1-colin.foster@in-advantage.com>
 <20221008185152.2411007-15-colin.foster@in-advantage.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221008185152.2411007-15-colin.foster@in-advantage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2022 20:51, Colin Foster wrote:
> The main purpose of the Ocelot chips are the Ethernet switching
> functionalities. Document the support for these features.
> 
> Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> ---
> 
> v4
>     * New patch
> 
> ---
>  Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml b/Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml
> index c6da91211a18..9ad42721418c 100644
> --- a/Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml
> @@ -56,6 +56,14 @@ patternProperties:
>          enum:
>            - mscc,ocelot-miim
>  
> +  "^ethernet-switch@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/net/dsa/mscc,ocelot.yaml

    unevaluatedProperties: false
(to be explicit even though they are not required)

> +    properties:
> +      compatible:
> +        enum:
> +          - mscc,vsc7512-switch
> +
>  required:
>    - compatible
>    - reg

Best regards,
Krzysztof

