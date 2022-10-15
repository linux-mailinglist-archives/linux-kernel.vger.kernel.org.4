Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383F95FFAA3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 16:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJOO64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 10:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJOO6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 10:58:54 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A6D520AE
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 07:58:53 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id mg6so5004539qvb.10
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 07:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12sHb45PFDPMB554JjoKVtlsY6wkkvotvCzZ54WMtss=;
        b=pZuZOlYf9IqhChxN/EimNMvtbPOP6iS5fbtfFoQD6/EM06jkG0NyI7z6blVRNGk9Q2
         414/enrOZD8CcM1vHGUeXRKMKLGXEu8DkpFZcCI3vBTfbeUbT/Sk+vtoc0/+cOqV8/Hd
         HXx4DwFDEl86zOvx6q7MsBLfqz2aP9Pz5DuOeFm5lHCom64KJE7BWuqj4s6pGsuFmw8l
         C/UmiVBCKg0DWiuznTEmPs2UovuhN3uqXOi6yrE79gStkwJebQtLPAMbfJ9J2Iz1j5wu
         mcJUAg+yf+OUOT+r9Y6qGqxNnlejYsRLsQPeCFYzbYXH3W1wlxFMpg26oz/70/3OTFV+
         OPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12sHb45PFDPMB554JjoKVtlsY6wkkvotvCzZ54WMtss=;
        b=UjEFym/lKnQb89n+6vL8ySji/1KsHqEJJN+fQRsTIs6ou1A8PYSIYKOsML0M439+Ry
         4K0YbOmI5Yyh4R3i+MWftIthBq2OmCISEDabSjVrNnN62vbCjer1s3zHUcmnZReY3b73
         TGj9lzzpXfWkSO5Pl09zvWz5LE7VGMbw1B1/RRNb9pYv9H51xZGgkYt7MSNz8NoA8wXT
         Y8WjRxo2RfsLqpNm5hyk5jyIWzOaFk7/yj968VkMl+wBOkJUlbzPXYBG9sov65fkNiKV
         R8RkFz8KT1YWR0PEXYsfZdLYz3CE3janbNSCUdVa/Mln9HuEjhTanNcBQeMM4PslbBm7
         dF6A==
X-Gm-Message-State: ACrzQf1K+aPdByaYMsOUMGg9C9B+dIMNd1DOWJxLuHMI6rivF8yAeLbF
        +xzSmx/VBQjJsJ7coJtnQKQS5g==
X-Google-Smtp-Source: AMsMyM5I+tnt730qCojlCOHq9MNreYK60CXysj+3j54f2IxgW4S9LoHcFKhKC7JlZ+aFvJVUKV7r9A==
X-Received: by 2002:ad4:4ee1:0:b0:4b1:25f6:b9b8 with SMTP id dv1-20020ad44ee1000000b004b125f6b9b8mr2281792qvb.48.1665845932378;
        Sat, 15 Oct 2022 07:58:52 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:9477:c2f0:ddea:ea08? ([2601:42:0:3450:9477:c2f0:ddea:ea08])
        by smtp.gmail.com with ESMTPSA id fb15-20020a05622a480f00b0039442ee69c5sm4045008qtb.91.2022.10.15.07.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 07:58:51 -0700 (PDT)
Message-ID: <419bdedb-bcc0-e58c-d1f8-1d66cbc4edf9@linaro.org>
Date:   Sat, 15 Oct 2022 10:58:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V2 4/6] dt-bindings: usb: ci-hdrc-usb2: convert to DT
 schema format
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20221014095148.2063669-1-peng.fan@oss.nxp.com>
 <20221014095148.2063669-5-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221014095148.2063669-5-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 05:51, Peng Fan (OSS) wrote:


> +
> +  vbus-supply:
> +    description: reference to the VBUS regulator.
> +
> +  fsl,usbmisc:
> +    description:
> +      Phandler of non-core register device, with one argument that
> +      indicate usb controller index
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +  disable-over-current:
> +    description: disable over current detect
> +
> +  over-current-active-low:
> +    description: over current signal polarity is active low

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> +
> +  over-current-active-high:
> +    description: |
> +      Over current signal polarity is active high. It's recommended to
> +      specify the over current polarity.
> +
> +  power-active-high:
> +    description: power signal polarity is active high
> +
> +  external-vbus-divider:
> +    description: enables off-chip resistor divider for Vbus
> +
> +  samsung,picophy-pre-emp-curr-control:
> +    description: |
> +      HS Transmitter Pre-Emphasis Current Control. This signal controls
> +      the amount of current sourced to the USB_OTG*_DP and USB_OTG*_DN
> +      pins after a J-to-K or K-to-J transition. The range is from 0x0 to
> +      0x3, the default value is 0x1. Details can refer to TXPREEMPAMPTUNE0
> +      bits of USBNC_n_PHY_CFG1.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x0
> +    maximum: 0x3
> +
> +  samsung,picophy-dc-vol-level-adjust:
> +    description: |
> +      HS DC Voltage Level Adjustment. Adjust the high-speed transmitter DC
> +      level voltage. The range is from 0x0 to 0xf, the default value is
> +      0x3. Details can refer to TXVREFTUNE0 bits of USBNC_n_PHY_CFG1.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x0
> +    maximum: 0xf
> +
> +  usb-phy:
> +    description: phandle for the PHY device. Use "phys" instead.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    deprecated: true
> +
> +  fsl,usbphy:
> +    description: phandle of usb phy that connects to the port. Use "phys" instead.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    deprecated: true
> +
> +patternProperties:
> +  "ethernet@[0-9a-f]$":
> +    description: The hard wired USB devices
> +    type: object
> +    $ref: /schemas/net/microchip,lan95xx.yaml
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - $ref: usb-hcd.yaml#
> +  - $ref: usb-drd.yaml#
> +  - if:
> +      properties:
> +        mux-controls:
> +          true
> +    then:
> +      properties:
> +        mux-control-names:
> +          const: usb_switch

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.


Additionally: Blank line

> +  - if:
> +      properties:
> +        phy_type:
> +          const: hsic
> +
> +      required:
> +        - phy_type> +    then:
> +      properties:
> +        pinctrl-names:
> +          items:
> +            - const: idle
> +            - const: active
> +    else:
> +      properties:
> +        pinctrl-names:
> +          oneOf:
> +            - items:
> +                - const: default
> +                - enum:
> +                    - host
> +                    - device
> +            - items:
> +                - const: default

No, just minItems: 1

Additionally: blank line

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - chipidea,usb2
> +              - lsi,zevio-usb
> +              - nvidia,tegra20-udc
> +              - nvidia,tegra30-udc
> +              - nvidia,tegra114-udc
> +              - nvidia,tegra124-udc
> +              - qcom,ci-hdrc
> +              - xlnx,zynq-usb-2.20a
> +    then:
> +      properties:
> +        fsl,usbmisc: false
> +        disable-over-current: false
> +        over-current-active-low: false
> +        over-current-active-high: false
> +        power-active-high: false
> +        external-vbus-divider: false
> +        samsung,picophy-pre-emp-curr-control: false
> +        samsung,picophy-dc-vol-level-adjust: false
> +


Best regards,
Krzysztof

