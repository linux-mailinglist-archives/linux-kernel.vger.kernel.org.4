Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C55645C4D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiLGOUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiLGOT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:19:57 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FDE5C779;
        Wed,  7 Dec 2022 06:19:57 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id z14-20020a9d65ce000000b0067059c25facso3225828oth.6;
        Wed, 07 Dec 2022 06:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t0xsqqRAAwkCH90xN5tDo0UY2Z+9ZzZVHejNWkAJfeY=;
        b=0r3rbxKIpw3HkjKrPB3MxmniMNtX8C4aaEnufzDuDs3NyIK2r8XNk2GrqPi4dNrFXy
         P9wdpLMaDHk1pDkQjRb9KXXLm8zRlvzsQCIgy2UwdwIumpIuLdfKbxjd3wHnq9xB+rWB
         aNhp/aAvlmidg0f7mPGIUN8fEonvB6Z9BstrFYKxuUqv58N+PDSzxHwt0ty2XG7HlVIk
         hFilYBNAtsQPmJSUk7zXxD98udxLgte+EvaIiDszkcp9YwwmhZSBoMgBksUJZqNiFfDG
         mu05ytH5w76stbnCoZxeRAVM24KucTxdnDOSLF5WiriS6wiJLU1eJhSpzfdnneh6Y6s6
         oxsA==
X-Gm-Message-State: ANoB5pnikM4R55PNFwUfILjtilP0fqYDp5c8KOtA+1uJWH5Md9flTmf9
        g6NDoaBQ/gicWo0r9M0SkQ==
X-Google-Smtp-Source: AA0mqf5uSaAugZRJi+A+E/uxyhpPDRKenpx8oRR0Qkl8Aa2el1QUalmTuXET2L/0ToRRdW9ZonSPSg==
X-Received: by 2002:a9d:84b:0:b0:66e:f6cb:99ec with SMTP id 69-20020a9d084b000000b0066ef6cb99ecmr6303505oty.330.1670422796137;
        Wed, 07 Dec 2022 06:19:56 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m22-20020a056870059600b0013c8ae74a14sm12204892oap.42.2022.12.07.06.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:19:55 -0800 (PST)
Received: (nullmailer pid 2124811 invoked by uid 1000);
        Wed, 07 Dec 2022 14:19:49 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org
In-Reply-To: <20221207131731.1291517-2-william.qiu@starfivetech.com>
References: <20221207131731.1291517-1-william.qiu@starfivetech.com>
 <20221207131731.1291517-2-william.qiu@starfivetech.com>
Message-Id: <167042222472.2111911.2050446708831690640.robh@kernel.org>
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: Add bindings for StarFive
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


On Wed, 07 Dec 2022 21:17:29 +0800, William Qiu wrote:
> Add documentation to describe StarFive
> designware mobile storage host controller driver.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../bindings/mmc/starfive,jh7110-sdio.yaml    | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-sdio.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mmc/starfive,jh7110-sdio.example.dts:21:18: fatal error: dt-bindings/clock/starfive-jh7110.h: No such file or directory
   21 |         #include <dt-bindings/clock/starfive-jh7110.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/mmc/starfive,jh7110-sdio.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221207131731.1291517-2-william.qiu@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

