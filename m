Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431E77255B4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbjFGHa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbjFGH3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:29:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005F83596
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:26:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5169f614977so366224a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 00:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686122773; x=1688714773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AHNOb3Vak93SE79cjJtlUcImdmBQ6YeOYklhRG0qb4M=;
        b=YNNQbQZQPVdSzi20TxjAyRhsARcaBBpmpqvxoW15cjkG9qq/R+1RdWi++Z4I0q1RW/
         GuoElk2FOp7isnbZVtUv7gf67LAQQHodGe2aCu8Kb9Q2mAz8Mdl66eX4rNmA/CLg1R5i
         j2BbfjMBXFC2Ml4Q0crymEKqBcJZ5e/sEkyGBNXJZ8gG4Z08JvTthjsxyvZ6NIpkYlav
         tJ3ahH3JuWr+wBtmp6ze2+gBFCMFtUHgUSVpYqCClUlLgcxgZoccM7sTKlLeLK6rJy0w
         6cgHrK1GwuyfNvvHcDYBgGwEAPDzyBfb5a0msjkqQdEavjjho5b8SOI6I3OvXJIO/mV4
         dW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686122773; x=1688714773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHNOb3Vak93SE79cjJtlUcImdmBQ6YeOYklhRG0qb4M=;
        b=bvE1NxiOs61SecGwiA5cZzkd6iksFGEPKswMcoFjfjP/QB1yIP5gfs4fGT1v87vBEY
         7Dl199r1bSwDyZpqqDQeZJkbeTDgrDbg0Zjv2rPb+8I2GERkeg5yySPDYRG0NdYzG+LS
         j2syjGdu4kOzXeoYdRubzUi75m75b+PK5yxGXp1gHppLx5GTYkUUb2CyXeBZvrkoj/2t
         rtGCbfMUgYxKBUNCajJ3UDpvhD0GUWuP71LyQ/AfirR+w5yvpl7IdWj64WUp+ryZokyc
         6k+o6SuA4RPIIAewSSWdOWOIv/dMIX4qO1HGH8Ovs+FakEbiRLhWAxW3V7Jk9YtV0Vqt
         gvKw==
X-Gm-Message-State: AC+VfDw2ojMPBLxxL9n8vjTQx7xviKd0bu9R01Ed96DdT0x2R40K/xzQ
        FA2HwmjUwuXwvGcJtI7TWeMOHA==
X-Google-Smtp-Source: ACHHUZ7xto1maHENeeGyjFEyLu5CAnG9dDPtJTkn0FmqIdA0AISmTQj25UoPyUB1ADeQrSC57nno+A==
X-Received: by 2002:a05:6402:337:b0:514:a5fe:b304 with SMTP id q23-20020a056402033700b00514a5feb304mr4183702edw.38.1686122773327;
        Wed, 07 Jun 2023 00:26:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id z15-20020aa7d40f000000b00514b2a9ce60sm5814096edq.81.2023.06.07.00.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 00:26:12 -0700 (PDT)
Message-ID: <85713602-dfe1-c90b-174b-3678d91369aa@linaro.org>
Date:   Wed, 7 Jun 2023 09:26:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 1/6] dt-bindings: display/mediatek: mt8188: Add
 documentations for VDOSYS1
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Fei Shao <fshao@google.com>
References: <20230607061121.6732-1-shawn.sung@mediatek.com>
 <20230607061121.6732-2-shawn.sung@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607061121.6732-2-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 08:11, Hsiao Chien Sung wrote:
> Add device tree documentations for MT8188 VDOSYS1.

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
> new file mode 100644
> index 000000000000..8a9e74cbf6dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,padding.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek PADDING
> +
> +maintainers:
> +  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> +  - Philipp Zabel <p.zabel@pengutronix.de>
> +
> +description:
> +  MediaTek PADDING provides ability to VDOSYS1 to fill pixels to
> +  width and height of a layer with a specified color.
> +  Since MIXER in VDOSYS1 requires the width of a layer to be 2-pixel-align, or
> +  4-pixel-align when ETHDR is enabled, we need PADDING to deal with odd width.
> +  Please notice that even if the PADDING is in bypass mode,
> +  settings in the registers must be cleared to 0, otherwise
> +  undeinfed behaviors could happen.

Typo, undefined

> +



> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +  - clocks
> +  - mediatek,gce-client-reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt8188-clk.h>
> +    #include <dt-bindings/power/mt8188-power.h>
> +    #include <dt-bindings/gce/mt8188-gce.h>
> +    #include <dt-bindings/memory/mt8188-memory-port.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        vdo1_padding0: vdo1_padding0@1c11d000 {

No underscores in node names.

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +            compatible = "mediatek,mt8188-vdo1-padding";
> +            reg = <0 0x1c11d000 0 0x1000>;
> +            clocks = <&vdosys1 CLK_VDO1_PADDING0>;
> +            power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
> +            mediatek,gce-client-reg =
> +                <&gce0 SUBSYS_1c11XXXX 0xd000 0x1000>;

Wrong wrapping. It's one line. Properties should not be wrapped after '='.


Best regards,
Krzysztof

