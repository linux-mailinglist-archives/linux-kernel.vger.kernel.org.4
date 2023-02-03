Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323F468918D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjBCIEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjBCIDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:03:45 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB82D1BEF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 00:02:49 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n13so3206893wmr.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 00:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j/BqAshhUQwOb3XRj7imW0y64r6HrCHnAtk8R5uEluo=;
        b=rq7Eu0AMSJYRKJazkb10W8riHm1cFWqvmIxseSjsriU+YZ5WzlIwiVcSb+yMDtoMQc
         QlVwfaT5Xep7ONtrUjmbXYzlVppvCON28e/aFwCduAtLMDMN2WijfK105l4ccfbHj37t
         6OPt7OK58i56G7Bg/cOaZyXUvtHN21w5Zl0b8Hf9EqGfzJa6WG3eLWNEjaFcHdyUXoIU
         f96np5sFywJx3Ioo7OGmN3x+9S6/BXbGI06lxlKVSb8ouzQfNR8QiDI9Ef43YlajuS+k
         noVi5OcH39f3cOBa0lEK6iDEFs3op3kFMNGDq5v2o/+GyOG4JYpUTJlxn0zzKtdGjYMj
         S7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/BqAshhUQwOb3XRj7imW0y64r6HrCHnAtk8R5uEluo=;
        b=iBc22GwCIaUMmmMszOenPhNsGtYDNh8hz7IexxbY+YYlBE4Le3Wmp/Otvtif9S3F4n
         Ey9I/SdM9LTnU5oEIhVCtdniEcNa7qt1sMnzvmMX4Tg6PvANC1mlFUkROpvIBpOoQ2hQ
         7J2oERxZwQwzODvXEc071TuceLxOxIWdcc2xj+4dZju2sBZa2RCH4Cgr1d//18sqBk5g
         VDzv7Dxjy613GRh7tlY9NHi2ll/KNBcuotBARwINwa1QuGfHjBRzdqQyVC7uUnQuRkoN
         o4d7O1uaRZga8YRjQtwJAcnsOamaZTmLR/eoDbjLe49+5ITly2kqZ92fNctwHBVyxHQK
         AIQQ==
X-Gm-Message-State: AO0yUKWJhbKEt0JwyR6sXWilXassQb2klulkyM+5BfHI34fJm0jPX6/w
        3xxRjnrcURc8AMR5TsGPFECgkg==
X-Google-Smtp-Source: AK7set/Vb7i53/SV+BeFDBTbUdIAfdaPM5HH1OgiUxRcY1vKNvD0ss4XksA9GmnEstT0xSJMQn7pKA==
X-Received: by 2002:a05:600c:1e87:b0:3dc:353c:8b44 with SMTP id be7-20020a05600c1e8700b003dc353c8b44mr8608293wmb.5.1675411368292;
        Fri, 03 Feb 2023 00:02:48 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y6-20020a7bcd86000000b003dc4480df80sm7031839wmj.34.2023.02.03.00.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 00:02:47 -0800 (PST)
Message-ID: <6e6ed493-4748-46ca-7a26-fe9cf6e2377a@linaro.org>
Date:   Fri, 3 Feb 2023 09:02:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6/9] ASoC: dt-bindings: meson: convert axg fifo to schema
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230202183653.486216-1-jbrunet@baylibre.com>
 <20230202183653.486216-7-jbrunet@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202183653.486216-7-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 19:36, Jerome Brunet wrote:
> Convert the DT binding documentation for the Amlogic axg audio FIFOs to
> schema.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../bindings/sound/amlogic,axg-fifo.txt       |  34 -----
>  .../bindings/sound/amlogic,axg-fifo.yaml      | 116 ++++++++++++++++++
>  2 files changed, 116 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
> deleted file mode 100644
> index fa4545ed81ca..000000000000
> --- a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -* Amlogic Audio FIFO controllers
> -
> -Required properties:
> -- compatible: 'amlogic,axg-toddr' or
> -	      'amlogic,axg-toddr' or
> -	      'amlogic,g12a-frddr' or
> -	      'amlogic,g12a-toddr' or
> -	      'amlogic,sm1-frddr' or
> -	      'amlogic,sm1-toddr'
> -- reg: physical base address of the controller and length of memory
> -       mapped region.
> -- interrupts: interrupt specifier for the fifo.
> -- clocks: phandle to the fifo peripheral clock provided by the audio
> -	  clock controller.
> -- resets: list of reset phandle, one for each entry reset-names.
> -- reset-names: should contain the following:
> -  * "arb" : memory ARB line (required)
> -  * "rst" : dedicated device reset line (optional)
> -- #sound-dai-cells: must be 0.
> -- amlogic,fifo-depth: The size of the controller's fifo in bytes. This
> -  		      is useful for determining certain configuration such
> -		      as the flush threshold of the fifo
> -
> -Example of FRDDR A on the A113 SoC:
> -
> -frddr_a: audio-controller@1c0 {
> -	compatible = "amlogic,axg-frddr";
> -	reg = <0x0 0x1c0 0x0 0x1c>;
> -	#sound-dai-cells = <0>;
> -	interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
> -	clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
> -	resets = <&arb AXG_ARB_FRDDR_A>;
> -	fifo-depth = <512>;
> -};
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
> new file mode 100644
> index 000000000000..f6222ad08880
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/amlogic,axg-fifo.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic AXG Audio FIFO controllers
> +
> +maintainers:
> +  - Jerome Brunet <jbrunet@baylibre.com>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  $nodename:
> +    pattern: "^audio-controller@.*"
> +
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - amlogic,axg-toddr
> +              - amlogic,axg-frddr
> +      - items:
> +          - enum:
> +              - amlogic,g12a-toddr
> +              - amlogic,sm1-toddr
> +          - const:
> +              amlogic,axg-toddr
> +      - items:
> +          - enum:
> +              - amlogic,g12a-frddr
> +              - amlogic,sm1-frddr
> +          - const:
> +              amlogic,axg-frddr
> +

All usual comments apply.

> +  reg:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  clocks:
> +    items:
> +      - description: Peripheral clock
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: Memory ARB line
> +      - description: Dedicated device reset line

This won't work without minItems and you should see errors on your DTS
or in dt_binding_check

> +
> +  reset-names: true

minItems
maxItems

> +
> +  amlogic,fifo-depth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Size of the controller's fifo in bytes
> +
> +required:

Best regards,
Krzysztof

