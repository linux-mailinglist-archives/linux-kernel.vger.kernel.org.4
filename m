Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B065F6292
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiJFI0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiJFIZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:25:55 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502CB8D0D9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:25:07 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j4so1723568lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 01:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=PcvER4yAsFUdAEzHIf6hQx39Ovt47uWTRtliBIkzepk=;
        b=Md9CTRJQC8q3giHdXRve2gJcREhkEicUTSP1EUy/gtqHEHKI7lPADVzObOeU9VCZAi
         TSSnf1sDgtRAFHL8plNZyOfPVhEALrV1ErPUDdylQPdbE6AEL50tXy7JB1E6kBLVxVE4
         MuenMI0oo3UdVLW3hNYrY/vC6MZAJ+FtWLhJknc7vGySlcFb1yf09miJjw0jWUfGVKWf
         UmEo8xp83Fdsnbw3Ysl4uZjyORNs7pzBmqHOKte+86bVLLUWixV0+PgssMy/dTu29k0u
         rtPR3Q/laL42jUGWEGJdYvX0egHUsqhP4CS75klXV1qN2gEWm14cPJRlTgw3O0scRdT2
         NVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PcvER4yAsFUdAEzHIf6hQx39Ovt47uWTRtliBIkzepk=;
        b=5GWU2mPmwZgIlvVvfW2IKnbgQmoJY8QJuQhM9ArlXrbVKzACZImLXRscR/BsMWsE+R
         60m/o6sG6dxcZPwf7ARhtR/xAG6f4sCr3k4MPnLwmp1bt6l6aP7D5DvO57XgGIdQXGcc
         etyZr+J3j34N3U74DYJMYtBXpindgwx9hOqcTgd6ZLcto6zfFe/ysfG4osjf3t5d1gLq
         ybp+M/M29/A/Zex6bnXrHMqNibVwQ7fEuTQVLCNx7/WXuHS6nATcGgg21GbbgGqSLP/I
         6C06LsTxpTucUldwLUw/Lp0vANUW94t7uEgC3QxGz3SUyGkpE81601PEWqge8f+IhMM8
         REeQ==
X-Gm-Message-State: ACrzQf1k5wHeOh4TxSPJdkz9tgqq9b0VgctvJe2qcNucftWeE/wQjk/H
        L/H8T4FgYW0c25SXd8v523yGLA==
X-Google-Smtp-Source: AMsMyM5tizCcWIlU8bqKz2j0VdNlYGoj3R81DvoyEDYmoUKqUknz9eH7dJzUWyIJ1BB3zqHKgFDx7g==
X-Received: by 2002:a19:5044:0:b0:4a2:2b74:faa8 with SMTP id z4-20020a195044000000b004a22b74faa8mr1293171lfj.622.1665044705325;
        Thu, 06 Oct 2022 01:25:05 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bi9-20020a0565120e8900b004974da17c2bsm2629581lfb.0.2022.10.06.01.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 01:25:04 -0700 (PDT)
Message-ID: <5059f3db-7224-e8b9-74ad-5f3646925b4d@linaro.org>
Date:   Thu, 6 Oct 2022 10:25:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFCv2 PATCH 1/4] dt-bindings: bus: add Wiegand bus dt
 documentation
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Za=c5=a5ovi=c4=8d?= <m.zatovic1@gmail.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        gregkh@linuxfoundation.org, jeffrey.l.hugo@gmail.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, saravanak@google.com,
        mani@kernel.org, hemantk@codeaurora.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20221005145746.172138-1-m.zatovic1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221005145746.172138-1-m.zatovic1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2022 16:57, Martin Zaťovič wrote:
> This patch documents the devicetree entry for enabling Wiegand
> bus driver. The drivers that will use Wiegand bus driver shall
> create a sub-node of the documented node.
> 
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> ---
> Hello again,
> 
> this is the second round of RFC patches in an attempt to add Wiegand
> driver to linux kernel. Thank you for all the issues you have pointed
> out in the first round. I have tried to fix all of them and I have
> also implemented a Wiegand bus driver, that is now used by the GPIO
> driver itself - as suggested by Linus.
> 
> Any advice you have for me regarding the patches will be appreciated!
> 
> With regards,
> Martin Zaťovič
> ---
>  .../devicetree/bindings/bus/wiegand.yaml      | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/wiegand.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/wiegand.yaml b/Documentation/devicetree/bindings/bus/wiegand.yaml
> new file mode 100644
> index 000000000000..1ed863ab925c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/wiegand.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/wiegand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Wiegand Bus
> +
> +maintainers:
> +  - Martin Zaťovič <m.zatovic1@gmail.com>
> +
> +description: |
> +  Wiegand interface is a wiring standard popularized in the 1980s. To this day
> +  many card readers, fingerprint readers, sensors, etc. use Wiegand interface
> +  particularly for access control applications. It utilizes two wires to
> +  transmit the data - D0 and D1.
> +
> +  Both data lines are initially pulled up. To send a bit of value 1, the D1
> +  line is set low. Similarly to send a bit of value 0, the D0 line is set low.
> +
> +properties:
> +  $nodename:
> +    pattern: "^wiegand(@[0-9a-f]+)?$"
> +
> +  compatible:
> +    contains:
> +      const: wiegand
> +

If the bus uses two wires, shouldn't you describe them here? Otherwise
what wires are you using?

> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    wiegand {
> +        compatible = "wiegand";
> +
> +        wiegand-gpio {
> +            compatible = "wiegand,wiegand-gpio";
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pinctrl_uart2_wiegand>;
> +            data-hi-gpios = <&gpio 7 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +            data-lo-gpios = <&gpio 6 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +        };
> +    };
> +
> +...

Best regards,
Krzysztof

