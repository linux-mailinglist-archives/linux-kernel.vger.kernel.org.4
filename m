Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DDF7092EA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjESJXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjESJXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:23:05 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC38192;
        Fri, 19 May 2023 02:23:05 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3944816b579so1674572b6e.1;
        Fri, 19 May 2023 02:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684488184; x=1687080184;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3UraE6X1bGQBbaM/niZUO5TV7tVH+NhZ8DOXB03Zfqk=;
        b=TvweDTsrVCLbEdiehhd0t/5+03yyUL3NCPKkhype+YywgpHavEBR0hg8qX1mK61kLI
         Ga2OijuXQefKNjVmFaya/08IoNcJUDZNFmW1HELlWW253ixubJ/1K+Ra8ygryE0rp53V
         5fCGYDotLX3t0UFzrSGSBXdewmu2MBtPrgFV7G3+5L4vW5VmcWWBwcGUXrYZFahk8ndC
         odQOuJtHSKaVV2MWYb3YvP+EXbYhqUjW/dPnNYEweghqgHBSNXxbJQRll0W+VwK7MWyk
         kFgZ91lSje173PmblZa2ApVjIvSLLWFnbUcP+knO2nZR/RTD3AnnCTbnWqOjvHYoUYI2
         U7fA==
X-Gm-Message-State: AC+VfDzi3O9FUq4sPamsdBC0/YDjQ6Qq0moCk0+PDxEF+WVczydocArA
        uRQNh9iak/tR+HpljNBX1w==
X-Google-Smtp-Source: ACHHUZ7mE/rmaqPh2pkd3JAot4Zv0jCYiATZb5CADq/aILvohgmA9artxd1r9SoE5HpO3+ucAQ8JAw==
X-Received: by 2002:a54:408a:0:b0:38e:8d7f:c07e with SMTP id i10-20020a54408a000000b0038e8d7fc07emr676449oii.52.1684488184181;
        Fri, 19 May 2023 02:23:04 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c24-20020aca1c18000000b00397c03854edsm837927oic.17.2023.05.19.02.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 02:23:03 -0700 (PDT)
Received: (nullmailer pid 3014363 invoked by uid 1000);
        Fri, 19 May 2023 09:23:02 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Shenghao Ding <13916275206@139.com>
Cc:     x1077012@ti.com, Ryan_Chu@wistron.com, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, peeyush@ti.com,
        devicetree@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        Sam_Wu@wistron.com, linux-kernel@vger.kernel.org,
        shenghao-ding@ti.com, robh+dt@kernel.org, navada@ti.com,
        kevin-lu@ti.com, gentuser@gmail.com, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz
In-Reply-To: <20230519080245.20243-1-13916275206@139.com>
References: <20230519080245.20243-1-13916275206@139.com>
Message-Id: <168448818168.3014319.8544192762874121053.robh@kernel.org>
Subject: Re: [PATCH v3 5/5] ASoC: dt-bindings: Add tas2781 amplifier
Date:   Fri, 19 May 2023 04:23:02 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 May 2023 16:02:45 +0800, Shenghao Ding wrote:
> Create tas2781.yaml for tas2781 driver.
> 
> Signed-off-by: Shenghao Ding <13916275206@139.com>
> 
> ---
> Changes in v3:
>  - Add allOf with ref to saound-dai-common
>  - remove audio-slots, put all the i2c address into <reg>
>  - Add more description on broadcast-addr item
>  Changes to be committed:
> 	new file:   Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> ---
>  .../devicetree/bindings/sound/ti,tas2781.yaml | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/ti,tas2781.yaml:71:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/sound/ti,tas2781.example.dts'
Documentation/devicetree/bindings/sound/ti,tas2781.yaml:71:1: found character '\t' that cannot start any token
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/sound/ti,tas2781.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/sound/ti,tas2781.yaml:71:1: found character '\t' that cannot start any token
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,tas2781.yaml: ignoring, error parsing file
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230519080245.20243-1-13916275206@139.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

