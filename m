Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D1661E1AB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 11:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiKFKif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 05:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiKFKib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 05:38:31 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B6BB1FC
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 02:38:30 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bp15so13086252lfb.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 02:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3CTC+S72ReqNXTQYMAegPNOzjNTLFGMiaRDIQZ2VQPI=;
        b=XkLVNCyGWSdG3QlVJE9vwgeevQ/pa4PlpBm+YzoLf2DPbPYdX790c0IJN2kZ0/kRQ9
         lVabZrJSmf2eOopcl7poCfoIaepawG0YOwVhTix2+FcLQ8aUNsxHkppNgBgyVOqRrgca
         AqcmVmC5VRoANTQfEjY67q+PlvYWiHaH8fKF6vxC3OHaoh18ARLVtvm2YyN/pO/r3FGk
         YyuYG5uNxnrOOx+gQbynXTnxkWgbN5x49M1ePTYJhxOXi5qBgICbuhEMQrYKOVHI9BDD
         4Zo7+97ql4OktBwoWnho756NYhB4fg+9NnZvQCg0YNykqw4Mq+9MzQSdXCYHtz8Yo6yN
         eGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CTC+S72ReqNXTQYMAegPNOzjNTLFGMiaRDIQZ2VQPI=;
        b=I+7ezDeO6LlWrkCnlzKhJUHAJY66Kh1Xw8jZF56NeLPp60kaGF5NvRJVPiLT/WtPut
         OSUCRG21jv4az7KiM8n681DDy+Zf4Fjed3r8VBtn8jgG6qnOj8ybgB6L8x7VOKhnD7qk
         XmxVVbzUYNOPgPCDs4IljtSJ5gjK9bqNjs84gc911NHVx96Xf3w5KMX4I8m6PGI6z+La
         6gGulLPDDhqqoNB63nZtIRQDTo0Fn4CZg4lL7D+xjP4lLTAP32Vp4EeVLyGN9ShLuvUb
         aQK6ZZDp2k9wW9u9MgMtNm9pb70B7BrN/AwJObIUCDaBpmnzPHf7lYXbwtv9Ih22u8iX
         KZrw==
X-Gm-Message-State: ANoB5pmFcGQD7dbqhaLoeuzGWDBBmrhwaa62YVM1Z2FmNXD3YKcoqqVP
        IXeq4QMTvFBghhncFjawpzJ04w==
X-Google-Smtp-Source: AA0mqf4slr0rnkvM60jAJJdLzKEh6OMKSW7h1AoeIaP8tswj+6hmnpERidN0jf9+iRWcW5DoeZmdaQ==
X-Received: by 2002:a19:ad49:0:b0:4b3:b755:789b with SMTP id s9-20020a19ad49000000b004b3b755789bmr313874lfd.415.1667731109131;
        Sun, 06 Nov 2022 02:38:29 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id c10-20020a056512324a00b004afc1607130sm644717lfr.8.2022.11.06.02.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 02:38:28 -0800 (PST)
Message-ID: <1b90f86c-9c0f-225b-38b5-6f37a4eded69@linaro.org>
Date:   Sun, 6 Nov 2022 11:38:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 3/6] dt-bindings: hwmon: Add hpe,gxp-fan-ctrl
Content-Language: en-US
To:     nick.hawkins@hpe.com, jdelvare@suse.com, linux@roeck-us.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        verdun@hpe.com, corbet@lwn.net, linux@armlinux.org.uk,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221104193657.105130-1-nick.hawkins@hpe.com>
 <20221104193657.105130-4-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104193657.105130-4-nick.hawkins@hpe.com>
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

On 04/11/2022 20:36, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> This provides the base registers address, programmable logic registers
> address, and the function 2 registers to allow control access of the HPE
> fans on the GXP SoC.

What is "This"? If "This patch", then drop it.
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

If "This hardware" then please instead describe the hardware, not it
components. What are its features? If it controls the fan, then why
there are no PWM-related cells? How do you set the speed?

> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  .../bindings/hwmon/hpe,gxp-fan-ctrl.yaml      | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml b/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
> new file mode 100644
> index 000000000000..40a5d9cd0a30
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/hpe,gxp-fan-ctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GXP Fan Controller
> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +
> +properties:
> +  compatible:
> +    const: hpe,gxp-fan-ctrl
> +
> +  reg:
> +    items:
> +      - description: Fan controller base register
> +      - description: Programmable logic registers base
> +      - description: Function 2 registers base

Drop "register" and "base" from all descriptions

> +
> +  reg-names:
> +    items:
> +      - const: base
> +      - const: plreg

Drop reg suffix

> +      - const: fn2reg

Drop reg suffix

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    fanctrl@1000c00 {

fan-controller

> +      compatible = "hpe,gxp-fan-ctrl";
> +      reg = <0x1000c00 0x200>, <0xd1000000 0xff>, <0x80200000 0x100000>;
> +      reg-names = "base", "plreg", "fn2reg";
> +    };

Best regards,
Krzysztof

