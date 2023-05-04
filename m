Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8E36F6535
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjEDGqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjEDGqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:46:51 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2BB26A4
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:46:48 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bc4ba28cbso113239a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 23:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683182807; x=1685774807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M7vw8A+fPBvQQ7FZ7Zi1LK3WXKYiCvrkFtHK4YoEOPY=;
        b=NJB48wgq8GaIWJfLNyX9Xph8XZknqa3JZ+QwdR8JtY4eLr142KuLjIFZQEA1Avf62D
         rOwf/8NNDFoicTajh6DcOMjtMJPHSdPgsaCLb76kK8VJThqNsFKN5FnUvc0yhDNJkZ6g
         zLzpjRvEgDdzhluvdCJMKSX4OT5lXrtwUbdA78TatEHKf+qHc5jVJRCf54en6xuXpYPq
         WQLvOMtYnB1Le7URGZRQ+GrrjxnJVPuZ0p2oCQMk8YkBiJIVcLHpKm0AhgH3/tvWQkVz
         tgVc/mclRts18VaHlldJb+BEe6Zyz6+hdGuKTCz2kAg06gohn1iwOhPVQL+p42V5/IWR
         JHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683182807; x=1685774807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7vw8A+fPBvQQ7FZ7Zi1LK3WXKYiCvrkFtHK4YoEOPY=;
        b=Wq8TqOEXfYGzSfLtEZIjpFGfaaJzHaVmek2Ue4+nzz+VKP4khMCG+hi0p7A0X9/Y/s
         WBLIKImGcFIV7JI4LqolEiQuIL0JcIkZ/8w8d37XHxhaCJogbVG+TE3cZqao8Qv72ehG
         Jy8jE+3zdVAglYKnmxRKGL/ukGgDwvKe2YXX3qAIm2caI9IvbiOTnR3HSc64ipMnP2iU
         cdrmzvimhMdKEUZ+Ba47DteMYw9iynq952umMXtD93nQz1J8n+CvieV3CP883+becwB3
         WxbiBUw/N9latmTU8nLp8MjTiBRs6CnvrBiZqgEUd8SCM8Mt4SPwZpj1ld0jFJxi3Zl/
         iKCQ==
X-Gm-Message-State: AC+VfDwCrFJE+e3CJpa0fP5qAHh+ZxDFIOnSJXtRh3XBVAMCAPZlsdgV
        71T07vD1s7C1yXrtSeYYSaR12g==
X-Google-Smtp-Source: ACHHUZ6UY8A2CuWiZF7JTRIhZOxqHEYlLakXgHOXDn41+YXqXV2Z9n4jJZ+YqlYAwptXMo8AV6xSmg==
X-Received: by 2002:a17:907:3e22:b0:931:6921:bdb7 with SMTP id hp34-20020a1709073e2200b009316921bdb7mr5892628ejc.60.1683182807040;
        Wed, 03 May 2023 23:46:47 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906328a00b009599c3a019fsm14027418ejw.60.2023.05.03.23.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 23:46:46 -0700 (PDT)
Message-ID: <4aa7adbf-f89e-6819-64d2-5942a456528a@linaro.org>
Date:   Thu, 4 May 2023 08:46:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] dt-bindings: usb: Add binding for Microchip usb5744 hub
 controller
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com,
        ilias.apalodimas@linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Piyush Mehta <piyush.mehta@amd.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <cca068980ae0b902168a9a9b78cab4efb43157a8.1683121150.git.michal.simek@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cca068980ae0b902168a9a9b78cab4efb43157a8.1683121150.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 15:39, Michal Simek wrote:
> The Microchip usb5744 is a SS/HS USB 3.0 hub controller with 4 ports.
> The binding describes USB related aspects of the USB5744 hub, it as
> well cover the option of connecting the controller as an i2c slave.
> When i2c interface is connected hub needs to be initialized first.
> Hub itself has fixed i2c address 0x2D but hardcoding address is not good
> idea because address can be shifted by i2c address translator in the
> middle.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> It looks like that usb8041 has also an optional i2c interface which is not
> covered. But it is mentioned at commit 40e58a8a7ca6 ("dt-bindings: usb:
> Add binding for TI USB8041 hub controller").
> 
> i2c-bus name property was suggested by Rob at
> https://lore.kernel.org/all/CAL_JsqJedhX6typpUKbnzV7CLK6UZVjq3CyG9iY_j5DLPqvVdw@mail.gmail.com/
> and
> https://lore.kernel.org/all/CAL_JsqJZBbu+UXqUNdZwg-uv0PAsNg55026PTwhKr5wQtxCjVQ@mail.gmail.com/
> 
> the question is if adding address like this is acceptable.
> But it must be specified.

Why? phandle points it explicitly.

> 
> Driver will follow based on final dt-binding.
> 
> ---
>  .../bindings/usb/microchip,usb5744.yaml       | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> new file mode 100644
> index 000000000000..fafe275a35df
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/microchip,usb5744.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip USB5744 4-port Hub Controller
> +
> +description:
> +  Microchip's USB5744 SmartHubTM IC is a 4 port, SuperSpeed (SS)/Hi-Speed (HS),
> +  low power, low pin count configurable and fully compliant with the USB 3.1
> +  Gen 1 specification. The USB5744 also supports Full Speed (FS) and Low Speed
> +  (LS) USB signaling, offering complete coverage of all defined USB operating
> +  speeds. The new SuperSpeed hubs operate in parallel with the USB 2.0
> +  controller, so 5 Gbps SuperSpeed data transfers are not affected by slower
> +  USB 2.0 traffic.
> +
> +maintainers:
> +  - Piyush Mehta <piyush.mehta@amd.com>
> +  - Michal Simek <michal.simek@amd.com>
> +
> +allOf:
> +  - $ref: usb-device.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - usb424,5744
> +      - usb424,2744

Keep the list ordered, so 2744 before 5744.

> +
> +  reg: true
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO controlling the GRST# pin.
> +
> +  vdd-supply:
> +    description:
> +      VDD power supply to the hub
> +
> +  peer-hub:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to the peer hub on the controller.
> +
> +  i2c-bus:
> +    maxItems: 1
> +    description:
> +      phandle of an I2C controller to link usb-hub for usb attach and reset
> +      followed by i2c address.
> +
> +required:
> +  - compatible
> +  - reg
> +  - peer-hub
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    usb {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        /* 2.0 hub on port 1 */
> +        hub_2_0: hub@1 {
> +          compatible = "usb424,5744";

Mixed indentation, use four spaces here as well.

> +          reg = <1>;
> +          peer-hub = <&hub_3_0>;
> +          i2c-bus = <&i2c 0x2d>;
> +          reset-gpios = <&gpio 3 GPIO_ACTIVE_LOW>;
> +        };
Krzysztof

