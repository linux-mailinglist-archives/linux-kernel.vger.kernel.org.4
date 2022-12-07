Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40411645C4B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiLGOUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiLGOTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:19:55 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F4A55AB9;
        Wed,  7 Dec 2022 06:19:54 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-14455716674so15289289fac.7;
        Wed, 07 Dec 2022 06:19:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HTehYsriDDl7V467dTgnDAxqHEvPBAXHN4uItfl3fKw=;
        b=dleXyH1C6geNtblPXCyq3GuVAaVATt992K7NX3JbRbXF+Mq2Tb/wczF6681HYkQzma
         4oKqKfIBDI5c0wZd+8Yj6EnKT0RTJ7EartyLfkwx4cc1FlnUbRw5QJHBdpzmHdmtwMUk
         EUKap8E7dwS96M/xGgCnP0Hu5lrZmFEL1AkuyJva4kdX9cdTCF3SIx8M2PtBb1FlEZro
         PjJNK5ebyIiy4ISuDi3T5jHybjfDeK2UtUnfZfcvSF4yrgZjsQ2Qk70dZ2JJD+dqMoIn
         ky5mLVoO/soF0Q3Nn+8BdW20s10FzEFt1qiQrSTQWaXOOn0B4l3seXwP3JVNWPj9QjLd
         sDIw==
X-Gm-Message-State: ANoB5pkHRjz/1VhiEURfUUxnaqMwhSa8apmGFlIer7EsjUqAumqaWyxy
        jJG7RQfADCTSNGKfx3KlEg==
X-Google-Smtp-Source: AA0mqf4rOV/EDdt5p9sQZ/GHgs3Ml6XKQ8HBqfQyHmM/+68QgAcBEh4d9xGKwPeJLsd6bU8g4AVE3w==
X-Received: by 2002:a05:6870:f613:b0:142:7fc7:7f3f with SMTP id ek19-20020a056870f61300b001427fc77f3fmr44081935oab.43.1670422793849;
        Wed, 07 Dec 2022 06:19:53 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q20-20020a4ad554000000b004a09df5a1dbsm6018957oos.8.2022.12.07.06.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:19:53 -0800 (PST)
Received: (nullmailer pid 2124815 invoked by uid 1000);
        Wed, 07 Dec 2022 14:19:49 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20221207055405.30940-12-hayashi.kunihiko@socionext.com>
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-12-hayashi.kunihiko@socionext.com>
Message-Id: <167042225871.2113101.2091351382124271584.robh@kernel.org>
Subject: Re: [PATCH v2 11/16] dt-bindings: soc: socionext: Add UniPhier
 peripheral block
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


On Wed, 07 Dec 2022 14:54:00 +0900, Kunihiko Hayashi wrote:
> Add devicetree binding schema for the peripheral block implemented on
> Socionext Uniphier SoCs.
> 
> Peripheral block implemented on Socionext UniPhier SoCs is an integrated
> component of the peripherals including UART, I2C/FI2C, and SCSSI.
> 
> Peripheral block has some function logics to control the component.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext,uniphier-perictrl.yaml          | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221207055405.30940-12-hayashi.kunihiko@socionext.com


perictrl@59820000: 'clock', 'reset' do not match any of the regexes: '^clock-controller(@[0-9a-f]+)?$', '^reset-controller(@[0-9a-f]+)?$', 'pinctrl-[0-9]+'
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

