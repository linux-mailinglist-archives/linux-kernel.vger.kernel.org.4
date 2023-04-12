Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D335C6DEF64
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjDLIuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjDLIuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:50:13 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017188A58
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:49:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gb34so27085828ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681289358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXiGiAF3mJm/6hgfCTKaagk5zrHngr0ItbqxTgvmii8=;
        b=mW1D1jvAyFqiJnuxqmBE40PQsB6E/ciQ8crs7TWk7I/CpaKLyL39C9gdbRfEVYV9KA
         YkzveDSmYZ1Kq/h64/Mv5KKyJQQsSfX+gfnL2i/vE1oINpM2UaUUUXWbT4MPXSYRdCE3
         RzcOKHAH6sAW+Yv9groUVbJrBuY2B6Ng6R4s1Z8vt8wK6cTAcYIMvMVKkZ1ICrFJTYCk
         1o7008mDj68dnGDQPz5NM30c/ZVhvMHtVq5mmsJgDw6Tb8+DOy/DVEKoJcWZE4Zz/ZTI
         jQwL4Ulp1eji1lwhBtlqyb8qieeOtu71r7hPJJMc7EaxvoO119oLrkEa8CijdhVROq6C
         qibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681289358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXiGiAF3mJm/6hgfCTKaagk5zrHngr0ItbqxTgvmii8=;
        b=S/zVYyFTaP3ECUQyoRG702dbV2MWybJQur7kBJkRp7t+kNnfQomD5eH8zNGdf1O95D
         WLWxRgisSQVo9QWMW/AW8tnly2suOJIZ5oSqwRDyg4QdNuYLaJTpNmZonipvEud26KjN
         w7Jwxw6TVj0dHW3HNkUWoTO2oB91+l3JnYcXZnopIpxeNUOARMVZY+9oCpAu/8LT/EMb
         t1BROPhxVRtHNPvEVhX7qyYuy+U/xVN3I4piDxrSuqE5lbUCxXvoLl9QQSMpIvniaGO6
         /5MyT4EtK37c0bSrFL4K/L7gG10cBxa22C/uaF12VnI45ZA+Cou6eKCSBZ/Ng8zAPPKk
         /WnA==
X-Gm-Message-State: AAQBX9e6hhKZRCCCP0xudEoEuCRGgycW7CbFV4m8yF17e8OYrFCFih2F
        vUKPLTC86T1IgXc4wJJcgn35yBCbtIulrTNAE0U=
X-Google-Smtp-Source: AKy350aonQuINRVoZBdNIRp5k/+iTxbe085iISMQDF1/o+RSzs78iZn4aQ4I9E5uICTAMMyjmj6qNw==
X-Received: by 2002:a17:906:c78a:b0:947:eafc:a738 with SMTP id cw10-20020a170906c78a00b00947eafca738mr5025769ejb.60.1681288366167;
        Wed, 12 Apr 2023 01:32:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8fa0:9989:3f72:b14f? ([2a02:810d:15c0:828:8fa0:9989:3f72:b14f])
        by smtp.gmail.com with ESMTPSA id rv12-20020a1709068d0c00b0094e5fd589f9sm427786ejc.19.2023.04.12.01.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 01:32:45 -0700 (PDT)
Message-ID: <a22dff0a-56e6-be1b-10b2-ce3b31f420c5@linaro.org>
Date:   Wed, 12 Apr 2023 10:32:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 5/7] dt-bindings: usb: Add StarFive JH7110 USB Bindings
 YAML schemas
Content-Language: en-US
To:     Minda Chen <minda.chen@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>
References: <20230406015216.27034-1-minda.chen@starfivetech.com>
 <20230406015216.27034-6-minda.chen@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406015216.27034-6-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 03:52, Minda Chen wrote:
> StarFive JH7110 platforms USB have a wrapper module around
> the Cadence USBSS-DRD controller. Add binding information doc
> for that.

That's one of the most redundant subjects I saw. You basically used four
words for one meaning. These are not exactly synonyms, but they all are
either imprecise or meaning the same.

Subject: drop second/last, redundant "Bindings YAML schemas". The
"dt-bindings" prefix is already stating that these are bindings.



> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Peter Chen <peter.chen@kernel.org>
> ---
>  .../bindings/usb/starfive,jh7110-usb.yaml     | 136 ++++++++++++++++++
>  1 file changed, 136 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml b/Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
> new file mode 100644
> index 000000000000..c8b30b583854
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
> @@ -0,0 +1,136 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/starfive,jh7110-usb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 wrapper module for the Cadence USBSS-DRD controller

What do you wrap here? Are you sure this is a wrapper? I think this is
just USB controller?

> +
> +maintainers:
> +  - Minda Chen <minda.chen@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-usb
> +
> +  reg:
> +    items:
> +      - description: OTG controller registers
> +      - description: XHCI Host controller registers
> +      - description: DEVICE controller registers
> +
> +  reg-names:
> +    items:
> +      - const: otg
> +      - const: xhci
> +      - const: dev
> +
> +  interrupts:
> +    items:
> +      - description: XHCI host controller interrupt
> +      - description: Device controller interrupt
> +      - description: OTG/DRD controller interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: host
> +      - const: peripheral
> +      - const: otg
> +
> +  clocks:
> +    items:
> +      - description: lpm clock
> +      - description: stb clock
> +      - description: apb clock
> +      - description: axi clock
> +      - description: utmi apb clock
> +
> +  clock-names:
> +    items:
> +      - const: lpm
> +      - const: stb
> +      - const: apb
> +      - const: axi
> +      - const: utmi_apb
> +
> +  resets:
> +    items:
> +      - description: PWRUP reset
> +      - description: APB clock reset
> +      - description: AXI clock reset
> +      - description: UTMI_APB clock reset
> +
> +  reset-names:
> +    items:
> +      - const: pwrup
> +      - const: apb
> +      - const: axi
> +      - const: utmi
> +
> +  starfive,stg-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:

Same problem as for other patches.

> +        - description: phandle to System Register Controller stg_syscon node.
> +        - description: register offset of STG_SYSCONSAIF__SYSCFG register for USB.
> +    description:
> +      The phandle to System Register Controller syscon node and the offset
> +      of STG_SYSCONSAIF__SYSCFG register for USB.
> +


Best regards,
Krzysztof

