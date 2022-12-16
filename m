Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB9864E9F5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiLPLFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiLPLFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:05:49 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC6ED9D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:05:47 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id p36so2903215lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4XRGRHsiFCJ4ktT8TNwZgSlFysJO9ZB/tk8ZQbwb5zo=;
        b=VDIfWnJqJWOX/1OfsOQsHqNcGSxl/2H4LZLbiw5gWSix3Xqpq1mGZhd60FXn562FhN
         xZNO1k6mtkSw2tvlaGZFhgk/T48P+gr3mqhusbGfGtprxsEanoH6hMTSCZSEpH6EF2eU
         7Vr60xNbelZZlwuaLDbq6NLBH0EvIUHBhX2EnwqHOU+YqEYkxH/Pfx7qFW8Abv2kGqEh
         6iO1qplDtmoZBOc0fp6bxEzKR2xTe/LqypQZgpVfI4vcsHvpg9DI79AEihIGtPBWOi3g
         OL/DKWL6e9Es/wq8Fb0NKKf92p58PVFNMbEAn51Dva11PgtnBMUTmzcR2XVzpNO39ZmV
         CKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4XRGRHsiFCJ4ktT8TNwZgSlFysJO9ZB/tk8ZQbwb5zo=;
        b=K0dAY9JnU53BwGAplZFj8qur+CDEEfTA8Hdm09gONhuxXUhQBoAz0qREEMlKZORPoy
         NXIA8Cfz3Agp82P9IWsXOIdMSv35vBQ0JfUSi+MdNa5hKD7D8oviaX9FIVvFGv4rqumd
         YiIDkhLotxoEGStSRS9L/yY3PQ1sg1hvFbDjUfSnONbpcYNByCJU4nblEss0evWK+X8X
         iirqzqUHOZMsFRJzrTS0DdjtWoW6oc64riYVce3Boa1ZlQauBTYyb7x0weRY3Qf7l4N1
         domaDozc2bqSgyjiiK1wMb/Rswss+u6NDd3SK5BXbSGWhwM9tSjThLjf6PZ3S8T39+4O
         TvAw==
X-Gm-Message-State: ANoB5plm7dzLEARhGtwCGlDaP+V5O8FYQFmbSv62Bi/rdpqMs5BYRM9x
        q/PxDVrQafZr2xAqa6TSklHSbw==
X-Google-Smtp-Source: AA0mqf7RjdnDqkGDqcEvhbC2VLnr090341tf7ipweUOZhmZnoOna730rCzSEZXX7WXsJhDwR9sq2ww==
X-Received: by 2002:a05:6512:16a1:b0:4ad:5fbb:a594 with SMTP id bu33-20020a05651216a100b004ad5fbba594mr12469152lfb.58.1671188746251;
        Fri, 16 Dec 2022 03:05:46 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h18-20020a19ca52000000b004b55075f813sm189891lfj.227.2022.12.16.03.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:05:45 -0800 (PST)
Message-ID: <2da394a6-411a-ca2b-90d3-7e97f3637d9f@linaro.org>
Date:   Fri, 16 Dec 2022 12:05:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 4/9] dt-bindings: net: Add bindings for StarFive dwmac
Content-Language: en-US
To:     Yanhong Wang <yanhong.wang@starfivetech.com>,
        linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>
References: <20221216070632.11444-1-yanhong.wang@starfivetech.com>
 <20221216070632.11444-5-yanhong.wang@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221216070632.11444-5-yanhong.wang@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2022 08:06, Yanhong Wang wrote:
> Add documentation to describe StarFive dwmac driver(GMAC).
> 
> Signed-off-by: Yanhong Wang <yanhong.wang@starfivetech.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
>  .../bindings/net/starfive,jh71x0-dwmac.yaml   | 103 ++++++++++++++++++
>  MAINTAINERS                                   |   5 +
>  3 files changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/starfive,jh71x0-dwmac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 7870228b4cd3..cdb045d1c618 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -91,6 +91,7 @@ properties:
>          - snps,dwmac-5.20
>          - snps,dwxgmac
>          - snps,dwxgmac-2.10
> +        - starfive,jh7110-dwmac
>  
>    reg:
>      minItems: 1
> diff --git a/Documentation/devicetree/bindings/net/starfive,jh71x0-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh71x0-dwmac.yaml
> new file mode 100644
> index 000000000000..5cb1272fe959
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/starfive,jh71x0-dwmac.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 StarFive Technology Co., Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/starfive,jh71x0-dwmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH71x0 DWMAC glue layer
> +
> +maintainers:
> +  - Yanhong Wang <yanhong.wang@starfivetech.com>
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - starfive,jh7110-dwmac
> +  required:
> +    - compatible
> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - starfive,jh7110-dwmac

Is it going to grow with new models? If yes, when? If not, filename does
not match compatible.

> +      - const: snps,dwmac-5.20
> +
> +  clocks:
> +    items:
> +      - description: GMAC main clock
> +      - description: GMAC AHB clock
> +      - description: PTP clock
> +      - description: TX clock
> +      - description: GTXC clock
> +      - description: GTX clock
> +
> +  clock-names:
> +    items:
> +      - const: stmmaceth
> +      - const: pclk
> +      - const: ptp_ref
> +      - const: tx
> +      - const: gtxc
> +      - const: gtx

missing resets and reset-names.

> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +unevaluatedProperties: false
> +
Best regards,
Krzysztof

