Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437C95BF636
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiIUGWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiIUGWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:22:14 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D90C7FFA9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:22:10 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b6so5700608ljr.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zhbji4Tk5WgVjJes/0kJR9R4EHcIP/DlEhuECb0MLiw=;
        b=U/lGPjq45+f+pnGj85u3/K4MSbowoXW2vz165u8utJHyE4IzAQ2qMLirrddp3tGAnr
         N2Hlw2qJ+VsDZCHNnY8b3zi9G/riJKnCnJkPr0KChrOG3Gahbzklv+h6nYE2oqYEREeP
         l9ROfJDLEtw6tyUm1AlYdnXslm6tHRq6wearprJuq12huaqkQWu26f/QxidtNBT3uyW7
         7EtGoIz5ll7codDIZbr6ttmoxa6w8JrxwUtGE4NXy0UL+w26TMmpcOq69XA0U0bNd55c
         HEu9oKX1dL5ChCRhO1QUzmBrWXWrY2H4Kahz35rIIKG+4jljJFxxu5jJsHMHAdYl3p01
         tIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zhbji4Tk5WgVjJes/0kJR9R4EHcIP/DlEhuECb0MLiw=;
        b=8Cxw33x/qYlczl6d2Mc4CbpkUmri4ytsLtDLby833V4FOaxvSypoxx5Gz/R4b6V9Us
         BYROcDPV0gpCqT7Odia5Fuz/TxfD92BJlwHxym02v6hGeJy0+7St949RpJuBRhEFbjbC
         gzYppyKeGOOmdNsSeeLL+LfJoClNJOch2cCIKKXoYq6RwsbngoNyuC7Bs6OqTN40PN4j
         woybFbIvurBQ40ZW6jz/8NBJdRwo6A8d6znUvtAH1ooV+SOYzn6kyl3Ip57toYrOQixs
         oeni6+tjSyeL9TvDjft9Np+QsJREN464zmChc6f0lty0vEmHweC1PA0MtJXotw3YTIE8
         wqkg==
X-Gm-Message-State: ACrzQf3c3aW8sg59LzvfkgVF7qzQuOIgRlm8dALdrFR42CoNLtiijLLW
        sWpFrGlPNEoqnTss30bDEvK4Vw==
X-Google-Smtp-Source: AMsMyM4KDygZsCooVsICpXJbWHSpyCrr/E4Y0qSWrXdfaJi52JVI1jr/vzt5chRv+/jSZgC9/karqQ==
X-Received: by 2002:a2e:a791:0:b0:26c:4fad:957 with SMTP id c17-20020a2ea791000000b0026c4fad0957mr4375664ljf.263.1663741328708;
        Tue, 20 Sep 2022 23:22:08 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b3-20020a056512070300b00498f51af149sm284354lfs.308.2022.09.20.23.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 23:22:08 -0700 (PDT)
Message-ID: <2073b6bd-a4bd-4ab5-300d-2ce989e25d5f@linaro.org>
Date:   Wed, 21 Sep 2022 08:22:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v9,2/7] dt-bindings: thermal: Add dt-binding document for
 LVTS thermal controllers
Content-Language: en-US
To:     Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
References: <20220817080757.352021-1-bchihi@baylibre.com>
 <20220817080757.352021-3-bchihi@baylibre.com>
 <716d6471-f0e2-489e-5f9e-9e38e9e7953a@collabora.com>
 <CAGuA+orxfcycwcUMpLe+dkjnXPQkELQsz0vBggGKTQ04XRGc+g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAGuA+orxfcycwcUMpLe+dkjnXPQkELQsz0vBggGKTQ04XRGc+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2022 16:01, Balsam CHIHI wrote:
> Hi Angelo,
> 
> I've got the following errors after implementing these changes :
> [...]
>   nvmem-cells:
>     minItems: 1
>     description: Calibration eFuse data for LVTS
> 
>   nvmem-cell-names:
>     minItems: 1
>     items:
>       pattern: 'lvts-calib-data[0-9]+$'
> 
>   "#thermal-sensor-cells":
>     const: 1
> 
> allOf:
>   - $ref: thermal-sensor.yaml#
> 
>   - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - mediatek,mt8192-lvts-ap
>               - mediatek,mt8192-lvts-mcu
>     then:
>       properties:
>         nvmem-cells:
>           maxItems: 1
> 
>         nvmem-cell-names:
>           maxItems: 1
> 
>   - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - mediatek,mt8195-lvts-ap
>               - mediatek,mt8195-lvts-mcu
>     then:
>       properties:
>         nvmem-cells:
>           maxItems: 2
> 
>         nvmem-cell-names:
>           maxItems: 2
> [...]
> 
> $ make DT_CHECKER_FLAGS=-m dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> /home/balsam/src/linux-mtk-lvts-newThermalOF/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml:
> properties:nvmem-cell-names:items: {'pattern':
> 'lvts-calib-data[0-9]+$'} is not of type 'array'
> from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> /home/balsam/src/linux-mtk-lvts-newThermalOF/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml:
> ignoring, error in schema: properties: nvmem-cell-names: items
>   DTEX    Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.example.dts
>   DTC     Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.example.dtb
>   CHECK   Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.example.dtb
> Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.example.dtb:0:0:
> /example-0/soc/thermal-sensor@1100b000: failed to match any schema
> with compatible: ['mediatek,mt8192-lvts-ap']
> 
> am I missing something?

Maybe maxItems: 2 in top-level property?


Best regards,
Krzysztof
