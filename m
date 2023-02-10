Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58EA69205A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjBJN6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjBJN6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:58:36 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DB85A9F3;
        Fri, 10 Feb 2023 05:58:34 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id dt8so4529697oib.0;
        Fri, 10 Feb 2023 05:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V67vbxDGURX5KGGQ/Srk/dGD7P3nYDL3amFEdBy6F/A=;
        b=xjNf2DJd8kLb1jrcMDhte7+XpkRe6w9A4NeXJXwpO8tmJAW1lL0K4iaFMy9S8NDQZL
         YVvqeKWp1MyGEWEOVJo0qNENS4Lt2Uc3IGoVMhfE9f8UWwMK6yApglORiAXtROYeUhfr
         YgL07kYKBi5H56WbmHWMVC+TDjmIZOQ/tmo18hsFQ06vyzAf5O9zDl3W3/xG6zVZo5vI
         d4cDDtglkGC/4l2aEawNp6FuF1PhtVhoczzsgLx+6oOg3oZkb8Q8FZ0fP2QSL6URMZa+
         dVsDHCqnANlcltqKLTND9t5xs0Ia2dRstjRYI8eIDwmyMU76gBZeiQ3ALAGQrYHF1jKF
         f6aw==
X-Gm-Message-State: AO0yUKWvXxge/flIaa6vaehQoVbSzpc7mempacaRlj3ZNZOXlZFjkrex
        av8es/bSFXpJCtuhki09DZ/TFKUO0w==
X-Google-Smtp-Source: AK7set9kP+KFFdagPIoY6xzg8MXMWQcujLvsOIf8+nHijEYW9EWe/cQ/e8tvAQEVWkwPsBVvTlNhJA==
X-Received: by 2002:a54:4492:0:b0:36b:d923:abe8 with SMTP id v18-20020a544492000000b0036bd923abe8mr6380904oiv.54.1676037512765;
        Fri, 10 Feb 2023 05:58:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n12-20020a9d740c000000b0068bc476d777sm1973488otk.13.2023.02.10.05.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 05:58:32 -0800 (PST)
Received: (nullmailer pid 2493632 invoked by uid 1000);
        Fri, 10 Feb 2023 13:58:31 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-riscv@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, linux-phy@lists.infradead.org
In-Reply-To: <20230210061713.6449-3-changhuang.liang@starfivetech.com>
References: <20230210061713.6449-1-changhuang.liang@starfivetech.com>
 <20230210061713.6449-3-changhuang.liang@starfivetech.com>
Message-Id: <167603709304.2486157.3430490619494105631.robh@kernel.org>
Subject: Re: [PATCH v1 2/4] dt-bindings: phy: Add starfive,jh7110-dphy-rx
Date:   Fri, 10 Feb 2023 07:58:31 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 09 Feb 2023 22:17:11 -0800, Changhuang Liang wrote:
> Starfive SoC like the jh7110 use a MIPI D-PHY RX controller based on
> a M31 IP. Add a binding for it.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../bindings/phy/starfive,jh7110-dphy-rx.yaml | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.example.dts:18:18: fatal error: dt-bindings/clock/starfive,jh7110-crg.h: No such file or directory
   18 |         #include <dt-bindings/clock/starfive,jh7110-crg.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230210061713.6449-3-changhuang.liang@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

