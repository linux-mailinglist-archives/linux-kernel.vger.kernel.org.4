Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16CA645C58
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiLGOUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiLGOUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:20:05 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04305D687;
        Wed,  7 Dec 2022 06:20:00 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-14455716674so15289667fac.7;
        Wed, 07 Dec 2022 06:20:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xHlSsP9sT9bwwrLq6ZJT+hIh/CUBnM40ZAbK04sWFGY=;
        b=yqp3ijtGaPAON3xXj6aR5UXjXceXUsywjbqvIHtHy0qRraZzNCtjOyx8dsbtiChCTa
         I6wbh8pTRcup1eAIC5zPf3WXFcDMqs1f2X++YJ1/rka/OL5onSfqQd25agNuiiXZdoP3
         ydCKXVLTrfXyjvK2pktp/TTNGV7gog8d4UKSfXS5Tc9DKHHnIWhP+ksQPoaeS1Tpwvb8
         YB950v45+SSb7blxnHiuwRO57i1DfZbJtO3PdURBBiqn59weJRu5rs09z+nXguOIf2Qe
         Y/U4RAZ5526yLwv8dYb6TszJ7cKioSOYxeP5HPDTBDuAbDngf0Hee/m3EY+8ehtyOxku
         FZwQ==
X-Gm-Message-State: ANoB5plSJEdj1XcnJT5ykKm2cNx/CJNssFgldXUxlPSVDXKlRT0CRkVU
        o3whA7taM9kSGytjvDsDCg==
X-Google-Smtp-Source: AA0mqf4BtNhu9QLCjBcEml69+DI0B+nsdDVqbYpMr5RsFckk1YgdMrCN9Ns8Sx0dIAUaQFO7oQQ9tA==
X-Received: by 2002:a05:6870:9f86:b0:144:c3d9:61e7 with SMTP id xm6-20020a0568709f8600b00144c3d961e7mr4205266oab.259.1670422800430;
        Wed, 07 Dec 2022 06:20:00 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d7-20020a9d5e07000000b0066c3ca7b12csm10152781oti.61.2022.12.07.06.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:20:00 -0800 (PST)
Received: (nullmailer pid 2124813 invoked by uid 1000);
        Wed, 07 Dec 2022 14:19:49 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <mhiramat@kernel.org>
In-Reply-To: <20221207055405.30940-11-hayashi.kunihiko@socionext.com>
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-11-hayashi.kunihiko@socionext.com>
Message-Id: <167042225783.2112928.12858605163990081059.robh@kernel.org>
Subject: Re: [PATCH v2 10/16] dt-bindings: soc: socionext: Add UniPhier
 SoC-glue logic debug part
Date:   Wed, 07 Dec 2022 08:19:49 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 07 Dec 2022 14:53:59 +0900, Kunihiko Hayashi wrote:
> Add devicetree binding schema for the SoC-glue logic debug part
> implemented on Socionext Uniphier SoCs.
> 
> This SoC-glue logic debug part is a set of miscellaneous function
> registers handling signals for specific devices outside system
> components, and also has multiple functions such as efuse, debug unit,
> several monitors for specific SoC, and so on.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext,uniphier-soc-glue-debug.yaml    | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue-debug.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221207055405.30940-11-hayashi.kunihiko@socionext.com


soc-glue@5f900000: compatible: ['socionext,uniphier-ld11-soc-glue-debug', 'simple-mfd'] is too short
	arch/arm64/boot/dts/socionext/uniphier-ld11-global.dtb
	arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dtb

soc-glue@5f900000: compatible: ['socionext,uniphier-ld20-soc-glue-debug', 'simple-mfd'] is too short
	arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dtb
	arch/arm64/boot/dts/socionext/uniphier-ld20-global.dtb
	arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dtb

soc-glue@5f900000: compatible: ['socionext,uniphier-ld4-soc-glue-debug', 'simple-mfd'] is too short
	arch/arm/boot/dts/uniphier-ld4-ref.dtb

soc-glue@5f900000: compatible: ['socionext,uniphier-pro4-soc-glue-debug', 'simple-mfd'] is too short
	arch/arm/boot/dts/uniphier-pro4-ace.dtb
	arch/arm/boot/dts/uniphier-pro4-ref.dtb
	arch/arm/boot/dts/uniphier-pro4-sanji.dtb

soc-glue@5f900000: compatible: ['socionext,uniphier-pxs2-soc-glue-debug', 'simple-mfd'] is too short
	arch/arm/boot/dts/uniphier-ld6b-ref.dtb
	arch/arm/boot/dts/uniphier-pxs2-gentil.dtb
	arch/arm/boot/dts/uniphier-pxs2-vodka.dtb

soc-glue@5f900000: compatible: ['socionext,uniphier-pxs3-soc-glue-debug', 'simple-mfd'] is too short
	arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dtb
	arch/arm64/boot/dts/socionext/uniphier-pxs3-ref-gadget0.dtb
	arch/arm64/boot/dts/socionext/uniphier-pxs3-ref-gadget1.dtb

soc-glue@5f900000: compatible: ['socionext,uniphier-sld8-soc-glue-debug', 'simple-mfd'] is too short
	arch/arm/boot/dts/uniphier-sld8-ref.dtb

soc-glue@5f900000: 'reg' is a required property
	arch/arm64/boot/dts/socionext/uniphier-ld11-global.dtb
	arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dtb
	arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dtb
	arch/arm64/boot/dts/socionext/uniphier-ld20-global.dtb
	arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dtb
	arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dtb
	arch/arm64/boot/dts/socionext/uniphier-pxs3-ref-gadget0.dtb
	arch/arm64/boot/dts/socionext/uniphier-pxs3-ref-gadget1.dtb
	arch/arm/boot/dts/uniphier-ld4-ref.dtb
	arch/arm/boot/dts/uniphier-ld6b-ref.dtb
	arch/arm/boot/dts/uniphier-pro4-ace.dtb
	arch/arm/boot/dts/uniphier-pro4-ref.dtb
	arch/arm/boot/dts/uniphier-pro4-sanji.dtb
	arch/arm/boot/dts/uniphier-pxs2-gentil.dtb
	arch/arm/boot/dts/uniphier-pxs2-vodka.dtb
	arch/arm/boot/dts/uniphier-sld8-ref.dtb

