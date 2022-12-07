Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8B5645C4C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiLGOUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiLGOT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:19:56 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12C755AB9;
        Wed,  7 Dec 2022 06:19:55 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1322d768ba7so21446212fac.5;
        Wed, 07 Dec 2022 06:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X0Ch5NeYgeiEv48PhfFqNGpu0Wc8FVjLqXc/+T4hF/s=;
        b=sLMIS24RFx+qMlSAN1AVU3/+5WZ+f+ESqnrWEy1kNTdIgGGUK8ZuQsImEvkllXGSdi
         IqRsJLQFEFdB4OdgSKT6jCNX7W4NnL6K4Gl04UZDge96UpJ46B9XL1O1SK+mxz/SJ4dg
         8aK3D5XA8s/jY0JAdKdzkLPxqnHVaXgp4yKj6OUSMRnLvJU+G0SI5OjxVU52crhh8XTq
         DB7vV/CN18sQVTe3Wb0J+y3ccqs9sxBr/aVx3RXn6skgtJss0s8Ft1h8iC6R0fbbu/t2
         usfwFrPo8gnZmQMyVhCeO6GjkL7jskK2kxeyfL1+iJpqossewB+U1jfireEVmW8goeXH
         kOGg==
X-Gm-Message-State: ANoB5pkr0f7qtUOWhSbcCbceVGLbhTaFI+Gc+aSp1R9sa0rH3grsLIcD
        re4C572S1e6l74izpYydTybkJj2fcw==
X-Google-Smtp-Source: AA0mqf4cB5kQdCQ0tOCXts6M9e2P3iOMdLYCbzYYLlRRrAzxDqamOUKJrmvD5odmHvAf05KsuYyc6w==
X-Received: by 2002:a05:6870:344d:b0:142:3bc5:a105 with SMTP id i13-20020a056870344d00b001423bc5a105mr41511241oah.15.1670422794974;
        Wed, 07 Dec 2022 06:19:54 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s34-20020a056870612200b0013d9bd4ad2esm12255429oae.12.2022.12.07.06.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:19:54 -0800 (PST)
Received: (nullmailer pid 2124817 invoked by uid 1000);
        Wed, 07 Dec 2022 14:19:49 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20221207055405.30940-13-hayashi.kunihiko@socionext.com>
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-13-hayashi.kunihiko@socionext.com>
Message-Id: <167042225949.2113190.6455765738181194157.robh@kernel.org>
Subject: Re: [PATCH v2 12/16] dt-bindings: soc: socionext: Add UniPhier media
 I/O block
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


On Wed, 07 Dec 2022 14:54:01 +0900, Kunihiko Hayashi wrote:
> Add devicetree binding schema for the media I/O block implemented on
> Socionext Uniphier SoCs. This block is implemented on LD4, sLD8, Pro4,
> and LD11 SoCs.
> 
> Media I/O block implemented on Socionext UniPhier SoCs is an integrated
> component of the stream type peripherals including SD, USB2.0, eMMC,
> and MIO-DMAC.
> 
> Media I/O block has a common logic to control the component.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext/socionext,uniphier-mioctrl.yaml | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-mioctrl.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221207055405.30940-13-hayashi.kunihiko@socionext.com


mioctrl@59810000: 'clock', 'reset' do not match any of the regexes: '^clock-controller(@[0-9a-f]+)?$', '^reset-controller(@[0-9a-f]+)?$', 'pinctrl-[0-9]+'
	arch/arm/boot/dts/uniphier-ld4-ref.dtb
	arch/arm/boot/dts/uniphier-pro4-ace.dtb
	arch/arm/boot/dts/uniphier-pro4-ref.dtb
	arch/arm/boot/dts/uniphier-pro4-sanji.dtb
	arch/arm/boot/dts/uniphier-sld8-ref.dtb

mioctrl@5b3e0000: 'clock', 'reset' do not match any of the regexes: '^clock-controller(@[0-9a-f]+)?$', '^reset-controller(@[0-9a-f]+)?$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/socionext/uniphier-ld11-global.dtb
	arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dtb

