Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498086470CE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiLHNbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiLHNbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:31:44 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D228658F;
        Thu,  8 Dec 2022 05:31:42 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-144b21f5e5fso1793724fac.12;
        Thu, 08 Dec 2022 05:31:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wdryjHBfKth8/hD6fCw95fsa+h8Ry8TUfw1B23x19eA=;
        b=FQvAyw9Iq6FvlPV/b7Alx/rJ6Cb1yOvELgKUoQ7Xn4Ggr4hgH7GjIsbAjGfKj3xPr3
         Z6gTN7S44nA7fCDbickRFKO8bQNfffJGrhwGPAI+Ru3aJPrHiLOoRhuaKzk21glZzpBi
         2Xuz1vZeAzcLmSpEDjRG65C2WRjButPJRspLiAR94kL0YIEab6CoL8wlzpj00hAVzihB
         1LN8MsRMYThh5rdLdEfnqIAPWrUSkyrpfAVb8t1o62VnO9CsV2EWCBTj3nsCtFev3GIG
         jA7CO5L25lC98k48DyBmqAek/cyyNmbbQbD71IMhFwU/DjbnXq46zkdTCLqMNPQtj7mG
         e4IA==
X-Gm-Message-State: ANoB5plaYC6w25p5kzpF4BnoHT0NioGXsyw1qpu0xZynYAqbK5n0JvnG
        p2Vues9OP7yr0WunAX7OJRre4Z5Pww==
X-Google-Smtp-Source: AA0mqf5jYIx6OuCiREELp2iTWD6/DFP6YpGy19CgJhpulghI/ol7bDHOxjgZBOg0u/Ao9SYOXOztYA==
X-Received: by 2002:a05:6870:1696:b0:144:7a85:63ea with SMTP id j22-20020a056870169600b001447a8563eamr1404205oae.23.1670506301925;
        Thu, 08 Dec 2022 05:31:41 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g13-20020a056870c14d00b001375188dae9sm13560046oad.16.2022.12.08.05.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 05:31:41 -0800 (PST)
Received: (nullmailer pid 539976 invoked by uid 1000);
        Thu, 08 Dec 2022 13:31:40 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
In-Reply-To: <20221208084523.9733-2-walker.chen@starfivetech.com>
References: <20221208084523.9733-1-walker.chen@starfivetech.com>
 <20221208084523.9733-2-walker.chen@starfivetech.com>
Message-Id: <167050594063.531467.3185697679617153248.robh@kernel.org>
Subject: Re: [RESEND PATCH v2 1/3] dt-bindings: power: Add starfive,jh71xx-pmu
Date:   Thu, 08 Dec 2022 07:31:40 -0600
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


On Thu, 08 Dec 2022 16:45:21 +0800, Walker Chen wrote:
> Add bindings for Power Management Unit (PMU) on the StarFive JH71XX SoC.
> 
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
>  .../bindings/power/starfive,jh71xx-pmu.yaml   | 45 +++++++++++++++++++
>  .../dt-bindings/power/starfive,jh7110-pmu.h   | 17 +++++++
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/starfive,jh71xx-pmu.yaml
>  create mode 100644 include/dt-bindings/power/starfive,jh7110-pmu.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/power/starfive,jh71xx-pmu.yaml:18:7: [warning] wrong indentation: expected 4 but found 6 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/starfive,jh71xx-pmu.yaml: properties:compatible: [{'enum': ['starfive,jh7110-pmu']}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/starfive,jh71xx-pmu.yaml: ignoring, error in schema: properties: compatible
Documentation/devicetree/bindings/power/starfive,jh71xx-pmu.example.dtb:0:0: /example-0/power-controller@17030000: failed to match any schema with compatible: ['starfive,jh7110-pmu']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221208084523.9733-2-walker.chen@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

