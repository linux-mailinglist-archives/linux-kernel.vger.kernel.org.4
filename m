Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1DD63C11C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbiK2NdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiK2Ncv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:32:51 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DF0AE50;
        Tue, 29 Nov 2022 05:32:47 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1322d768ba7so16998545fac.5;
        Tue, 29 Nov 2022 05:32:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sy5HRpTcZoOaeJBd7K3gTzg2ESitXHjpSXZmoyKtq9k=;
        b=Pg4ePcSDj4YOxlMpOpRpdCKHA26sSC2Jei8AOacRWc/6kCdIqmXk8j3USgaRAsXsjx
         CpRKqiz5qlRuJNdkqaeH60XIEIS27C+OhOPCoV/fAWKIY2EQuwII5uggeY425NFDB1BU
         //9a+w/SM1FO/SwY5AL4l9X4p3s051945FzpqWIdZwpMzay9BZvaSsYRUBtPoQwSohUu
         MPjCGVSnwyOSw2Oepk4W0etV+peR3ymu+SPe2z+5Kd+8grCnxxhE3Xd/HdD+j6uYfv+B
         IoyQvAm3HoefoFQ7Wf0YU7Uc6fcHUMSJ2jsdmoQRZ4FcA5DYhbKhgduA3ci1fdah2lOY
         XXpQ==
X-Gm-Message-State: ANoB5pkjwM0SiHASKzctfq2g0RlU7mS277APKsKaRBYKf1wIb7ZeEVHg
        YfGn6c2ihW/J5U58fskFug==
X-Google-Smtp-Source: AA0mqf46xCccU3lX8ljDTP+fuaa7UPa07HLQ+iWamwHLSS+w/juD1/ccSsizuLLWIBKW4G8fkjQXMw==
X-Received: by 2002:a05:6870:4c1a:b0:132:8d60:3598 with SMTP id pk26-20020a0568704c1a00b001328d603598mr23338003oab.283.1669728766683;
        Tue, 29 Nov 2022 05:32:46 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x33-20020a056870b42100b00143ae7d4ccesm3133552oap.45.2022.11.29.05.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 05:32:46 -0800 (PST)
Received: (nullmailer pid 3502180 invoked by uid 1000);
        Tue, 29 Nov 2022 13:32:43 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
In-Reply-To: <20221129103509.9958-9-hayashi.kunihiko@socionext.com>
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
 <20221129103509.9958-9-hayashi.kunihiko@socionext.com>
Message-Id: <166972831970.3491813.14656948191964815698.robh@kernel.org>
Subject: Re: [PATCH 8/8] dt-bindings: soc: socionext: Add UniPhier AHCI glue layer
Date:   Tue, 29 Nov 2022 07:32:43 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Nov 2022 19:35:09 +0900, Kunihiko Hayashi wrote:
> Add DT binding schema for components belonging to the platform-specific
> AHCI glue layer implemented in UniPhier SoCs.
> 
> This AHCI glue layer works as a sideband logic for the host controller,
> including core reset, PHYs, and some signals to the controller.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext,uniphier-ahci-glue.yaml         | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-ahci-glue.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.example.dtb: ahci-glue@65700000: 'reg' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-ahci-glue.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221129103509.9958-9-hayashi.kunihiko@socionext.com

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

