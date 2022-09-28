Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB0E5ED6C4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiI1Hu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiI1Htv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:49:51 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1141610977B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:47:59 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z4so1319891lft.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3u2lwefLPXnmYQ6lmup0QT7+cqk+0mIC6fnyCD0Or/A=;
        b=FDSHUOiHB0E5Xq30bp5wadIDxjcFsODbay2U4npKAh8hpuqDXHOBKdrKS/aVSqxOig
         QqrWAAKqPq/mx0gtntQOOPjs5noDdeQVnA3E6QitgQZC4xflRqIADIlABwEcqLoUW1TW
         IwQn26g/mgojT9++IqMvpupNoM7XeQ7tKFdUdFhd5cyjb+2ByJ8VxNGqhz/dChGREuT6
         F7MX4Gfqv3nN78XqcM1UkXhPtCgVNj7ukydV4YkF2lNDhMUvdLgwZlsmoc10PUDy4Fon
         TxIMTJgQyxkpFg4J/nh/q/PoXXboTiomplxsC0Rm8NAabGzq6F7wurHKyjkwR/uOY+cB
         8VKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3u2lwefLPXnmYQ6lmup0QT7+cqk+0mIC6fnyCD0Or/A=;
        b=fRXt9dmavinGK5iIIOs7SNiaIO3kUPXieekr5742cmXVDCp//obE4IlIIO/viF9iR3
         jsYq+qNVXxZIMoJ6VMxFdlZZFmPxr55jefHGcNgLNftKb+AHWort4JxoFHDYaqApZyDv
         jP+EL8YlCJTa/68ZdnHD0ODBT6HNdlaUMtj1gj7HyaMk4kR4wx/ie3K5GY4xXoUaEby7
         +xFHVVUx59WEmiwtbCyebOEVkJ/4QIayI4RjLJloic5768gAs2GXKqsNalvEUWz0ECGp
         jKxKd0YtMitQcblYi9s2Hn18q0+kt6Av28HbnGZ5STNU1v/F6hvIBhQpQKjz7f/qKgWg
         Y79A==
X-Gm-Message-State: ACrzQf2CmPBcj60q0YIhL83T2FCMhVwcl7LzhZb7MDrY5gX1O6FP1qJm
        7ToXsUbqZCZiwJ5kzIyLfm2F1Q==
X-Google-Smtp-Source: AMsMyM5jFe8AXE9vKqxdB0+1hvio/vmanBrP0lg0x2ZB15OFwIviosmDyRIUvskqa+3GZxP87bqKIQ==
X-Received: by 2002:a05:6512:2806:b0:498:f7ae:75ba with SMTP id cf6-20020a056512280600b00498f7ae75bamr12357796lfb.15.1664351277244;
        Wed, 28 Sep 2022 00:47:57 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u10-20020a2e2e0a000000b0026bf04aafd2sm369148lju.9.2022.09.28.00.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 00:47:56 -0700 (PDT)
Message-ID: <db7055da-b01f-3ca6-20f8-e9bc7ed892bc@linaro.org>
Date:   Wed, 28 Sep 2022 09:47:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2] dt-bindings: net: marvell,pp2: convert to json-schema
Content-Language: en-US
To:     =?UTF-8?Q?Micha=c5=82_Grzelak?= <mig@semihalf.com>,
        devicetree@vger.kernel.org
Cc:     mw@semihalf.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
References: <20220926232136.38567-1-mig@semihalf.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220926232136.38567-1-mig@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2022 01:21, Michał Grzelak wrote:
> This converts the marvell,pp2 bindings from text to proper schema.
> 
> Move 'marvell,system-controller' and 'dma-coherent' properties from
> port up to the controller node, to match what is actually done in DT.
> 
> Signed-off-by: Michał Grzelak <mig@semihalf.com>
> ---
>  .../devicetree/bindings/net/marvell,pp2.yaml  | 241 ++++++++++++++++++
>  .../devicetree/bindings/net/marvell-pp2.txt   | 141 ----------

Thank you for your patch. There is something to discuss/improve.


> +properties:
> +  compatible:
> +    enum:
> +      - marvell,armada-375-pp2
> +      - marvell,armada-7k-pp22
> +
> +  reg:
> +    minItems: 3
> +    maxItems: 4
> +    description: |
> +      For "marvell,armada-375-pp2", must contain the following register sets:
> +        - common controller registers
> +        - LMS registers
> +        - one register area per Ethernet port
> +      For "marvell,armada-7k-pp22" used by 7K/8K and CN913X, must contain the following register sets:
> +        - packet processor registers
> +        - networking interfaces registers
> +        - CM3 address space used for TX Flow Control

Instead of this description, in define them for each variant in
allOf:if:then (just like for clocks below)

> +
> +  clocks:
> +    minItems: 2
> +    items:
> +      - description: main controller clock
> +      - description: GOP clock
> +      - description: MG clock
> +      - description: MG Core clock
> +      - description: AXI clock

This needs to be restricted per variant - minItems and maxItems in
allOf:if:then.

> +
> +  clock-names:
> +    minItems: 2
> +    items:
> +      - const: pp_clk
> +      - const: gop_clk
> +      - const: mg_clk
> +      - const: mg_core_clk
> +      - const: axi_clk

The same.

> +
> +  dma-coherent: true
> +  '#size-cells': true
> +  '#address-cells': true

You need const:X for both cells (unless they come from some other schema
but then you would not need to list them here).

> +
> +  marvell,system-controller:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: a phandle to the system controller.
> +
> +patternProperties:
> +  '^eth[0-9a-f]*(@.*)?$':

The name should be "(ethernet-)?port", unless anything depends on
particular naming?

> +    type: object

You need description here.

> +    properties:
> +      interrupts:
> +        minItems: 1
> +        maxItems: 10
> +        description: interrupt(s) for the port
> +
> +      interrupt-names:
> +        items:

minItems: 1

> +          - const: hif0
> +          - const: hif1
> +          - const: hif2
> +          - const: hif3
> +          - const: hif4
> +          - const: hif5
> +          - const: hif6
> +          - const: hif7
> +          - const: hif8
> +          - const: link
> +
> +        description: >
> +          if more than a single interrupt for is given, must be the
> +          name associated to the interrupts listed. Valid names are:
> +          "hifX", with X in [0..8], and "link". The names "tx-cpu0",
> +          "tx-cpu1", "tx-cpu2", "tx-cpu3" and "rx-shared" are supported
> +          for backward compatibility but shouldn't be used for new
> +          additions.
> +
> +      port-id:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: ID of the port from the MAC point of view.
> +
> +      phy:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description: >
> +          a phandle to a phy node defining the PHY address
> +          (as the reg property, a single integer).
> +
> +      phy-mode:
> +        $ref: "ethernet-controller.yaml#/properties/phy-mode"

You can skip quotes.

> +
> +      marvell,loopback:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description: port is loopback mode.
> +
> +      gop-port-id:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: >
> +          only for marvell,armada-7k-pp22, ID of the port from the
> +          GOP (Group Of Ports) point of view. This ID is used to index the
> +          per-port registers in the second register area.
> +
> +    required:
> +      - interrupts
> +      - port-id
> +      - phy-mode
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          const: marvell,armada-7k-pp22
> +    then:
> +      patternProperties:
> +        '^eth[0-9a-f]*(@.*)?$':
> +          required:
> +            - gop-port-id

else:
  patternProperties:
     ....
       gop-port-id: false

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |

Best regards,
Krzysztof

