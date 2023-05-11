Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FA16FEEA7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbjEKJXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbjEKJXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:23:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D69A5CC
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:23:38 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9659f452148so1480518066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683797016; x=1686389016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vl4pq/TFO3VQR0kVuaJWgJWglK6FzIisqhV2TGEMWBo=;
        b=c6XFMFoSN2wtB3zRfDgTwLYZGqARzAVdIAmpazUc5hYAkqsYPWyD6HdnmX3hwBi4UN
         aFamlAThX8tqDyddf+n1l/FysCUP6KFVtX5M8QcPcsnyYf7OPwog+BE7iNJKd1svhhaj
         mwpK2EobCyCIRRc002JrhmKpJ9b/sHv/MQiE448LvsQjCbBMAjk/a85ChmEH5mBnn801
         jfBuYm64YTOsJLlUdhHWOvsHosuZ+RDYWT9Si3+7S/M7xeJ4w9ACQpEJQrDa27XcnSVn
         c3D4yto3dWyOAtWkfhrdJSVpDpwZQIIJqhaRcPl+27Xcad0ihtQFfrVzvRgxsrTLe+ur
         M/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683797016; x=1686389016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vl4pq/TFO3VQR0kVuaJWgJWglK6FzIisqhV2TGEMWBo=;
        b=ZlXOIaj3C5v/z/OQm65qgbRY/4ngRK18swDgL0QRPDzVODy6cNRyK+B7VXjwDnNTCw
         rhT36j58OMxXucZ/urpInilKP/yEN2hK/Va2WK5L7jv6Bw2IHqRdg84QHYBej55tqZp7
         ZtpRnMOpGSgoEnMplzDQWUms0x197go07I9JXCm4XMF1CJgmpwcs9rckJc7Ry63W5YTA
         kxdDGDQOp1OcEdCXSTtNyqo4gfFECNULOn4Y7tdzz0b30EWoz0WvVZjqyZCha6T/MEnG
         MPjiAdyzgpERfmHHyRa2mjK5MSptz2uwts6cRtFXSx2f/R6AXPfuPbwSoFmei81FJVez
         w4og==
X-Gm-Message-State: AC+VfDxgk9C6QfyZhj8VyWAcFNnRI4BNeO7ykdwtWSy4xupG6XFzzdg1
        ucDzXRxs4OpfZRad+VR0X1lcBg==
X-Google-Smtp-Source: ACHHUZ5hH0nv0/reQLP7DrNigh3PbGejsk3yC0vC8eazBflipY9G2qypAnsLVsJZ4JmXFYmGDAkn+A==
X-Received: by 2002:a17:907:a408:b0:94e:5780:23f9 with SMTP id sg8-20020a170907a40800b0094e578023f9mr20712928ejc.48.1683797016340;
        Thu, 11 May 2023 02:23:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7e61:f14a:c3a4:809e? ([2a02:810d:15c0:828:7e61:f14a:c3a4:809e])
        by smtp.gmail.com with ESMTPSA id e17-20020a170906845100b0095844605bb8sm3801632ejy.10.2023.05.11.02.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 02:23:35 -0700 (PDT)
Message-ID: <634ae7fc-7f63-da83-9889-b08d728a21a4@linaro.org>
Date:   Thu, 11 May 2023 11:23:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] dt-bindings: usb: Add support for Microchip usb5744
 hub controller
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com,
        ilias.apalodimas@linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Piyush Mehta <piyush.mehta@amd.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <f99d284dc70ca897d3908b1e4c92a9910f350584.1683729282.git.michal.simek@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f99d284dc70ca897d3908b1e4c92a9910f350584.1683729282.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 16:34, Michal Simek wrote:
> The Microchip usb5744 is a SS/HS USB 3.0 hub controller with 4 ports.
> Add description for USB related aspects of the USB5744 hub, it as
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
> Changes in v3:
> - add maxItems to reg property
> - remove select and define properties not used for i2c node and required
>   for usb
> - s/binding/support/ in subject
> - reword descripion to remove binding word from commit message
> - wire usb-device.yaml for usb hub properties
> 
> Changes in v2:
> - fix i2c-bus property
> - swap usb2.0/3.0 compatible strings
> - fix indentation in example (4 spaces)
> - add new i2c node with microchip,usb5744 compatible property
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
> 
> Driver will follow based on final dt-binding.
> 
> $ref: usb-device.yaml# should be also added but have no idea how to wire it
> up to be applied only on usb node not i2c one.
> 
> ---
>  .../bindings/usb/microchip,usb5744.yaml       | 107 ++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> new file mode 100644
> index 000000000000..408c5bf00cc2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> @@ -0,0 +1,107 @@
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
> +properties:
> +  compatible:
> +    enum:
> +      - usb424,2744
> +      - usb424,5744
> +      - microchip,usb5744
> +
> +  reg:
> +    maxItems: 1
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
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle of an usb hub connected via i2c bus.
> +
> +allOf:

Put allOf: block after required:. Just like in example schema.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: microchip,usb5744
> +    then:
> +      properties:
> +        reset-gpios: false
> +        vdd-supply: false
> +        peer-hub: false
> +        i2c-bus: false
> +    else:
> +      $ref: /schemas/usb/usb-device.yaml
> +      required:
> +        - peer-hub
> +
> +required:
> +  - compatible
> +  - reg
> +


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

