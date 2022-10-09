Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61325F8C29
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 17:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiJIP6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 11:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJIP6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 11:58:39 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E874229C8E
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 08:58:37 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id cj27so5366126qtb.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5orZ+DziI6W/f9HXFXiv87iJt/PGMb8hqSKXkaX84tc=;
        b=pDtyOlPFSEP4qgQu4T4B0J+N6vslW87IBxWwnSCJRaYWRvfrQl5xZPlP4qHbqI5jJp
         ++g8/YCyJypk9U66/2nV0jQB0MMElG/FkqptlK3x99XpNe8FW9Wrala+Ev0qYtfT29Ae
         pRzIs1KyCR/MJgtSbhTgIv5K0riCp3V3pMdrvy/vGk74qtvoHkA7Ke9rTMB1FpVRg4kW
         6FhAye5EgQ6RRP9+lOuzdIDSEq1AVJk5UB3xetdC4AJVOed9vNA93bDWzziliEMjYdB8
         szjXCvJDTVirSdRcOvDdqYa2KPepL3HWpcL5mvdf7JSunRyJuL/THL2rSC1U9kGQJW3i
         Pgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5orZ+DziI6W/f9HXFXiv87iJt/PGMb8hqSKXkaX84tc=;
        b=4ELjaENuMI79OXWm9HzzKhsFeKSMXfAPk9AbIiV9ZC9RKC3Q7rm/q85ohI0nk8CMov
         RL4uiN7GeW789mLIrtgxquLtkpXib1+44cQ53Tv1nGc89sZf4k/lmnE9zLqpQkfj1UcU
         oH6iQNs55grxY8CIM0OT0WNCxXoKtxCpY9LErQsS4MompnwfsF+mKK9VwPdi0nRjIbgu
         osjLaqg8fVcRAG9LThHTjthuaWlz6U8Hj6orksMWczXMtnotCJaGvy+SeAFurhW0YBhO
         K8abl0nAMRUsHW8aVKs3M2J29FdaIx8Pq0X6YjZISBwO8pV6bbhPaWPb+RBqVf0wWQpZ
         hMMw==
X-Gm-Message-State: ACrzQf1ig021/D7h3LsesCORc6dSEnE/V0/feX+r/g/XfBku5NxgS1Vn
        u7/E9eFStKeA43w/qgu0tK9nPw==
X-Google-Smtp-Source: AMsMyM61dS16RMHrOhhdFqzjMyzmt/ixs7MQZED+RHxiW4UwQ7zvJ3sbsnu7g9hRJd8ZSKgz/1GIeA==
X-Received: by 2002:ac8:5a16:0:b0:391:8800:a78e with SMTP id n22-20020ac85a16000000b003918800a78emr11937707qta.273.1665331117127;
        Sun, 09 Oct 2022 08:58:37 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b006b95b0a714esm8064135qki.17.2022.10.09.08.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 08:58:36 -0700 (PDT)
Message-ID: <97f77164-264b-68e3-3d77-1a5ed1d44d34@linaro.org>
Date:   Sun, 9 Oct 2022 17:58:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC v4 net-next 15/17] dt-bindings: net: dsa: ocelot: add
 ocelot-ext documentation
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
 <20221008185152.2411007-16-colin.foster@in-advantage.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221008185152.2411007-16-colin.foster@in-advantage.com>
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
> The ocelot-ext driver is another sub-device of the Ocelot / Felix driver
> system. It requires a register array similar to the VSC7514 and has
> different ports layout than existing devices.
> 

Thank you for your patch. There is something to discuss/improve.

> @@ -54,9 +54,24 @@ description: |
>        - phy-mode = "1000base-x": on ports 0, 1, 2, 3
>        - phy-mode = "2500base-x": on ports 0, 1, 2, 3
>  
> +  VSC7512 (Ocelot-Ext):
> +
> +    The Ocelot family consists of four devices, the VSC7511, VSC7512, VSC7513,
> +    and the VSC7514. The VSC7513 and VSC7514 both have an internal MIPS
> +    processor that natively support Linux. Additionally, all four devices
> +    support control over external interfaces, SPI and PCIe. The Ocelot-Ext
> +    driver is for the external control portion.
> +
> +    The following PHY interface types are supported:
> +
> +      - phy-mode = "internal": on ports 0, 1, 2, 3
> +      - phy-mode = "sgmii": on ports 4, 5, 7, 8, 9, 10
> +      - phy-mode = "qsgmii": on ports 4, 5, 6, 7, 8, 10
> +
>  properties:
>    compatible:
>      enum:
> +      - mscc,vsc7512-switch
>        - mscc,vsc9953-switch
>        - pci1957,eef0
>  
> @@ -258,3 +273,100 @@ examples:
>              };
>          };
>      };

Blank line

> +  # Ocelot-ext VSC7512
> +  - |
> +    #include <dt-bindings/phy/phy-ocelot-serdes.h>
> +
> +    soc@0 {
> +        compatible = "mscc,vsc7512";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        reg = <0 0>;
> +
> +        ethernet-switch@0 {

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

Best regards,
Krzysztof

