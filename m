Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3BA6899F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjBCNnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjBCNnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:43:21 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634387C72E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 05:43:18 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso6063779wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 05:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Ugc/Mf7gmptS4sxRo47lha6Z1ILO8fTg7LLtEjNneFs=;
        b=SoaciP0tiX4p1fUCbCA4vQIOtc0ihsGJTT654jpN5I372gNWZquSKEnF2CuI6cRwhq
         O1ng6H23VGd9bpb+EHMYvbITmdN/tTM32EOPdec5fCgN5jtTTGjpZFEQwX5h1+CpnPV/
         dH/zwHOilwFzcJ+JZ+O0QkfFZkzLjMZmLiku2NEaVcAZwLmi+t78q1ywLpRcWvSSIfQT
         fhOFCLQAqThE+0Ob/clHdDUTd5ObPn6UvMapgCuMk0zReCXPUZ38yqAk8eyd7/KMks42
         8b2elC8bGFWgi4aPZJVNNUIR5zzCDNVS4pSlCJDRhgqQgWG/akslxJEgDm0lRX2x99DN
         NF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ugc/Mf7gmptS4sxRo47lha6Z1ILO8fTg7LLtEjNneFs=;
        b=NkR+1QH4kE+GTkKebFgOatzLspe7kSqhMJxPihWV9px5O/B76MjurqWhQEt5jRUdVd
         vj6DuPEN4AaPOzzkZGd4Qvbdtr+6sLk2VY3eHsEyPjCqQl/50HCc4ssuQl5PY2HijG1e
         ldNWrvc09L0hH+WKMnA/jw2qRH1p9c6nqU9AMRuBtyrNuZq2GCCI+WIQvLBOdBA2+sTx
         UPlUCGYqjzkfcnuTqaX4SdR7ZWksWN5fHpseQNHlltwVX969IfhTWeb9BNRWbZGNJp1N
         ZS1hO7u8t0edMCEUz3BhmMXXCHRaouEkczNF09+ZXRSdpbRED3QaeZsGLScCmN+70+v2
         kRoQ==
X-Gm-Message-State: AO0yUKVbH199S63YxCqNws0n2EI3GvgWjT2FB4zFWhAacvwqVlKNG/Lb
        HgyB9fDS45q7LJPZnSpj86Fobw==
X-Google-Smtp-Source: AK7set9drg9MA5H07h22uzZUlBFGRMcQpErN2uGMh/pn7M4dkwP/6Oix641g7LbENbXJC+E4TYujVw==
X-Received: by 2002:a05:600c:cca:b0:3db:bc5:b2ae with SMTP id fk10-20020a05600c0cca00b003db0bc5b2aemr8940843wmb.41.1675431796833;
        Fri, 03 Feb 2023 05:43:16 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v16-20020a05600c471000b003dd1bd66e0dsm3127550wmo.3.2023.02.03.05.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 05:43:16 -0800 (PST)
References: <20230202183653.486216-1-jbrunet@baylibre.com>
 <20230202183653.486216-7-jbrunet@baylibre.com>
 <6e6ed493-4748-46ca-7a26-fe9cf6e2377a@linaro.org>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] ASoC: dt-bindings: meson: convert axg fifo to schema
Date:   Fri, 03 Feb 2023 14:27:50 +0100
In-reply-to: <6e6ed493-4748-46ca-7a26-fe9cf6e2377a@linaro.org>
Message-ID: <1jmt5un9u4.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 03 Feb 2023 at 09:02, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 02/02/2023 19:36, Jerome Brunet wrote:
>> Convert the DT binding documentation for the Amlogic axg audio FIFOs to
>> schema.
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  .../bindings/sound/amlogic,axg-fifo.txt       |  34 -----
>>  .../bindings/sound/amlogic,axg-fifo.yaml      | 116 ++++++++++++++++++
>>  2 files changed, 116 insertions(+), 34 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
>>  create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
>> deleted file mode 100644
>> index fa4545ed81ca..000000000000
>> --- a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
>> +++ /dev/null
>> @@ -1,34 +0,0 @@
>> -* Amlogic Audio FIFO controllers
>> -
>> -Required properties:
>> -- compatible: 'amlogic,axg-toddr' or
>> -	      'amlogic,axg-toddr' or
>> -	      'amlogic,g12a-frddr' or
>> -	      'amlogic,g12a-toddr' or
>> -	      'amlogic,sm1-frddr' or
>> -	      'amlogic,sm1-toddr'
>> -- reg: physical base address of the controller and length of memory
>> -       mapped region.
>> -- interrupts: interrupt specifier for the fifo.
>> -- clocks: phandle to the fifo peripheral clock provided by the audio
>> -	  clock controller.
>> -- resets: list of reset phandle, one for each entry reset-names.
>> -- reset-names: should contain the following:
>> -  * "arb" : memory ARB line (required)
>> -  * "rst" : dedicated device reset line (optional)
>> -- #sound-dai-cells: must be 0.
>> -- amlogic,fifo-depth: The size of the controller's fifo in bytes. This
>> -  		      is useful for determining certain configuration such
>> -		      as the flush threshold of the fifo
>> -
>> -Example of FRDDR A on the A113 SoC:
>> -
>> -frddr_a: audio-controller@1c0 {
>> -	compatible = "amlogic,axg-frddr";
>> -	reg = <0x0 0x1c0 0x0 0x1c>;
>> -	#sound-dai-cells = <0>;
>> -	interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
>> -	clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
>> -	resets = <&arb AXG_ARB_FRDDR_A>;
>> -	fifo-depth = <512>;
>> -};
>> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
>> new file mode 100644
>> index 000000000000..f6222ad08880
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
>> @@ -0,0 +1,116 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/amlogic,axg-fifo.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic AXG Audio FIFO controllers
>> +
>> +maintainers:
>> +  - Jerome Brunet <jbrunet@baylibre.com>
>> +
>> +allOf:
>> +  - $ref: dai-common.yaml#
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^audio-controller@.*"
>> +
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - amlogic,axg-toddr
>> +              - amlogic,axg-frddr
>> +      - items:
>> +          - enum:
>> +              - amlogic,g12a-toddr
>> +              - amlogic,sm1-toddr
>> +          - const:
>> +              amlogic,axg-toddr
>> +      - items:
>> +          - enum:
>> +              - amlogic,g12a-frddr
>> +              - amlogic,sm1-frddr
>> +          - const:
>> +              amlogic,axg-frddr
>> +
>
> All usual comments apply.
>
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#sound-dai-cells":
>> +    const: 0
>> +
>> +  clocks:
>> +    items:
>> +      - description: Peripheral clock
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    items:
>> +      - description: Memory ARB line
>> +      - description: Dedicated device reset line
>
> This won't work without minItems and you should see errors on your DTS
> or in dt_binding_check
>

The example provided here worked but there is indeed a warning with the
axg-frddr variant.

I'm adding a 2nd example so it does not happen again.

>> +
>> +  reset-names: true
>
> minItems
> maxItems

Adding this causes troubles with the reset-names definitions in the 'if'
clause. If I put min: 1, max: 2 and min: 2 in the 'then' clause I get:

> Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml: allOf:1:then:properties:reset-names: 'oneOf' conditional failed, one must be fixed:
>        [{'const': 'arb'}, {'const': 'rst'}] is too long
>        [{'const': 'arb'}, {'const': 'rst'}] is too short
>        False schema does not allow 2
>        1 was expected
>        hint: "minItems" is only needed if less than the "items" list length
>        from schema $id: http://devicetree.org/meta-schemas/items.yaml#

The older devices just have the 'arb' reset.
Newer devices have a 2nd reset line (called rst here)

If I just restrict the min and max, it would be valid for the older
devices to have 'rst' only - but it is not valid.

With just 'true', it works as expected (throw errors if an incorrect
name or number of names is passed). Min and Max comes from the items list.

Any suggestions ?

>
>> +
>> +  amlogic,fifo-depth:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: Size of the controller's fifo in bytes
>> +
>> +required:
>
> Best regards,
> Krzysztof

