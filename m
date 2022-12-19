Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059CC650EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiLSPkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiLSPkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:40:40 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD841144C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:40:38 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b13so14252168lfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dr8GvJaUU0STZax+c0mj5MPZF8of0PjiTPxlj3vYQSU=;
        b=yAISmKjU+Ld+moI+LTCelr86cpzWi6b5hOAlcNuilkw320KewZAL6lKvOC0cGRSTqf
         ZisFJ7JkPT3RwpoasAvB870jeN9uL4j6UTZbEvL5dyisTzSlWZ/LOZDKjgQRjWEQG/nc
         Mz30NVYZuRdn9dJctLj5P8UsHSdeCLlUiMfPei8UVBvjYOQUwDmsBCZy6yuU7S2SRf7N
         bvpuxfFDlhn9qtPCU4RTszw/2GWSdAaW58EiotDIyfGqPeIABujmxPQpT1+Kfn+JnXhv
         eOefo3tLU/i7BZqPL7KnLYxpdKRUqRVUx2m7moEKDr0661IgwOZO0zch8cyAFpuT80e4
         HGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dr8GvJaUU0STZax+c0mj5MPZF8of0PjiTPxlj3vYQSU=;
        b=up4LXQSoLzXbCDw0WW5BSqSTYFRVVV3qxWrvyC9m5ecg75dYWXHFVFeaDq5jg1/jBV
         hPsUqQlN9PHkSC7SJ++ZRaP2OnBaQYd363NKrElnLVYyAIoriXlntByoBtheRPuoy9JT
         VjbH68CIXFQqUATjF6zZo9gJ9jXiAknxp3OZ6WbFhGVZF38i9FnNZI536tpzeIkm2TS+
         lQFdNwVNkpmWY9onDUPe4H4CbB2McIYZ+SBqXp9V9ElxeWkFDxgf+991KMmWNzLZy0+c
         Ryft18UyAuBVEy/cbqs/oezKTl5ePHmpKAalAmS7of0hSTv+Qd4g33qKYHLuerJ5nFMh
         n7/A==
X-Gm-Message-State: ANoB5pk1Fp9+P0+BOP8SI/wuGwXBh0rCtInTs5uZ95ra7M9vO5RiLMo3
        0qdNvb5EeYZhOo/XdZTVuImg2w==
X-Google-Smtp-Source: AA0mqf7j7A82NmhWgQhPoWndLVceW4a+6WTS99f8B2Pbp14hoUEvShZP6IARYSv+akQCeEH9QvKytA==
X-Received: by 2002:a05:6512:4029:b0:4b5:5da1:44c1 with SMTP id br41-20020a056512402900b004b55da144c1mr13683726lfb.11.1671464436943;
        Mon, 19 Dec 2022 07:40:36 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q15-20020ac25a0f000000b004b53eb60e3dsm1126339lfn.109.2022.12.19.07.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 07:40:36 -0800 (PST)
Message-ID: <5fc29d3c-e3da-3dc4-bce5-2158b81daa43@linaro.org>
Date:   Mon, 19 Dec 2022 16:40:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/5] dt-bindings: mmc: sdhci-cadence: SD6 support
Content-Language: en-US
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com
References: <20221219142418.27949-1-pmalgujar@marvell.com>
 <20221219142418.27949-4-pmalgujar@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221219142418.27949-4-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2022 15:24, Piyush Malgujar wrote:
> From: Jayanthi Annadurai <jannadurai@marvell.com>
> 

Subject: use final prefix matching the file, so "cdns,sdhci:"

> Add support for SD6 controller support

Full stop.

> 
> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 33 +++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 8b1a0fdcb5e3e2e8b87d8d7678e37f3dad447fc1..2043e78ccd5f708a01e87fd96ec410418fcd539f 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/mmc/cdns,sdhci.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
> +title: Cadence SD/SDIO/eMMC Host Controller (SD4HC, SD6HC)
>  
>  maintainers:
>    - Masahiro Yamada <yamada.masahiro@socionext.com>
> @@ -19,6 +19,7 @@ properties:
>            - microchip,mpfs-sd4hc
>            - socionext,uniphier-sd4hc
>        - const: cdns,sd4hc
> +      - const: cdns,sd6hc

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

... because it does not really make sense. Why do you require SD6HC as
fallback? I think you meant enum.

>  
>    reg:
>      maxItems: 1
> @@ -111,6 +112,34 @@ properties:
>      minimum: 0
>      maximum: 0x7f
>  
> +  cdns,iocell_input_delay:

No underscores. Use proper units in name suffix:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml


> +    description: Delay in ps across the input IO cells
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Ditto... and so on - all of the fields.

> +
> +  cdns,iocell_output_delay:
> +    description: Delay in ps across the output IO cells
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +
> +  cdns,delay_element:
> +    description: Delay element in ps used for calculating phy timings
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +
> +  cdns,read_dqs_cmd_delay:
> +    description: Command delay used in HS200 tuning
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +
> +  cdns,tune_val_start:
> +    description: Staring value of data delay used in HS200 tuning
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +
> +  cdns,tune_val_step:
> +    description: Incremental value of data delay used in HS200 tuning
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +
> +  cdns,max_tune_iter:
> +    description: Maximum number of iterations to complete the HS200 tuning process
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Why these three are properties of DT?

> +
>  required:
>    - compatible
>    - reg
> @@ -122,7 +151,7 @@ unevaluatedProperties: false
>  examples:
>    - |
>      emmc: mmc@5a000000 {
> -        compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
> +        compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc", "cdns,sd6hc";

This is confusing. I don't understand it. It requires much more
explanation in your commit msg.

>          reg = <0x5a000000 0x400>;
>          interrupts = <0 78 4>;
>          clocks = <&clk 4>;

Best regards,
Krzysztof

