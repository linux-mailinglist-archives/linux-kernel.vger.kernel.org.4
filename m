Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE3364DC33
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiLONYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLONYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:24:41 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90E39FD8;
        Thu, 15 Dec 2022 05:24:40 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id k189so5252606oif.7;
        Thu, 15 Dec 2022 05:24:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fLeOe2K/YN9RjRUtZcg/drKhPf5cFdW7mguDPxEIWPA=;
        b=eI34k+jA+juUN0uyPYSSHXuZqR+E98Mp2zog5KVlJ0tL6W7B98pS1jYFiUXmPqsp1E
         +qfW/cZ5wsRLu6ETL94W/7WxbJdF8HsRrrqCe8pfiHAGJoYF+RL2WvSGQUUrbjbK5Sl3
         rndRHXbzIWGHncuXP3w2cIAcdXxolB9Sx31UOHENAy4n+SfAhBOX3W2vMrP+NKpJ8eF2
         HzAfAQBjoCGmRUfRJsVtQ4XelS0oYxgBshShYB+TDtiufltDio2ZvAVSk12sVven+C14
         bQLOVVAOD2PaaHA6CNN05mw8AReyI3rqMl+eoorn9ZwsPToaXrQQtPxo3ir3/WD4ITpR
         5VuQ==
X-Gm-Message-State: ANoB5pm7McEnFZeenOhQgBJp2zgu6jhCqTzo82bwXdtxQA4DD1Sl+Ffk
        EHZjrUjSjMtapuChRl6SlA==
X-Google-Smtp-Source: AA0mqf6kjJ4LETUKvqU3gTYQ9EImomN8A6T5Ha5fVcxnOBne/uUX6Rwfwp4vLhVj2CksQeIRlJqI2A==
X-Received: by 2002:aca:bfd7:0:b0:355:91e3:52e3 with SMTP id p206-20020acabfd7000000b0035591e352e3mr11955895oif.22.1671110680162;
        Thu, 15 Dec 2022 05:24:40 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f13-20020a056870d14d00b00140d421445bsm4060492oac.11.2022.12.15.05.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 05:24:39 -0800 (PST)
Received: (nullmailer pid 3142465 invoked by uid 1000);
        Thu, 15 Dec 2022 13:24:38 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org
In-Reply-To: <20221214222024.951984-1-alexander.sverdlin@gmail.com>
References: <20221214222024.951984-1-alexander.sverdlin@gmail.com>
Message-Id: <167111060894.3140769.6100399745035758019.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ep93xx: Add cirrus,ep9301-adc
 description
Date:   Thu, 15 Dec 2022 07:24:38 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Dec 2022 23:20:23 +0100, Alexander Sverdlin wrote:
> Add device tree bindings for Cirrus Logic EP9301/EP9302 internal SoCs' ADC
> block.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
>  .../bindings/iio/adc/cirrus,ep9301-adc.yaml   | 58 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.example.dts:21:18: fatal error: dt-bindings/clock/cirrus,ep93xx-clock.h: No such file or directory
   21 |         #include <dt-bindings/clock/cirrus,ep93xx-clock.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221214222024.951984-1-alexander.sverdlin@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

