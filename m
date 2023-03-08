Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0A26B0A87
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjCHOIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjCHOHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:07:50 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2020734002;
        Wed,  8 Mar 2023 06:06:26 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id e21so12247136oie.1;
        Wed, 08 Mar 2023 06:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678284385;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WpczFTCXijyH6v2uFsL0r+ne6zhQWpuAxK6dZ8HLc8w=;
        b=hhPn5vzzQnLsj55S5avkZt0cS4CDLTPUSDXszASAkbS21eMuAtebnHidYBRu1PsVAp
         VoYeDUu7wltur3k8eLOxienPgGPLxNCgB8/j7jBN9ZpsO6l1icSydI6BvXPWUlDqzJgl
         l5IHb0rNMbK4LxhNH7ow8haaLrKoQUzZ5MNzOhqBiukKnh/dTGK3U5ABf84GLvwDOPIq
         Yoi7pWkgtBen/X0t6hqTKs+GC5Sv4ZCQKp9nShfAMujNPRP+BHsBUFeKDSx3ku5ZJyoX
         BdEUh+GAYzQt//ThtZekS0R/U7xBCjFgEXCd+Y3/zZvaziZIOdOS/HdDSnd71PMCdIm1
         r6RQ==
X-Gm-Message-State: AO0yUKV3kzx1f53qUEmqEBULDGyx7mvPkgXPHjT/vbzIz2kizFdZhNGX
        m9gs3V6sex2rzDDlb7xS5A==
X-Google-Smtp-Source: AK7set9TY7ANnw+LvWD6zq/I9SejqdyfAIYH25nwUFoQ1NaWeLROsqghaWZaYYnPSagPS99RJ5mp5A==
X-Received: by 2002:a05:6808:c7:b0:384:3a4d:7f72 with SMTP id t7-20020a05680800c700b003843a4d7f72mr7023522oic.9.1678284385296;
        Wed, 08 Mar 2023 06:06:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s82-20020acadb55000000b00383ecd10ea6sm6354226oig.20.2023.03.08.06.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 06:06:24 -0800 (PST)
Received: (nullmailer pid 2666455 invoked by uid 1000);
        Wed, 08 Mar 2023 14:06:21 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230308090219.12710-2-clamor95@gmail.com>
References: <20230308090219.12710-1-clamor95@gmail.com>
 <20230308090219.12710-2-clamor95@gmail.com>
Message-Id: <167828360145.2613122.1172986827662465150.robh@kernel.org>
Subject: Re: [PATCH v1 1/4] dt-bindings: iio: light: add apds990x binding
Date:   Wed, 08 Mar 2023 08:06:21 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Mar 2023 11:02:16 +0200, Svyatoslav Ryhel wrote:
> Add dt-binding for apds990x ALS/proximity sensor.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/iio/light/avago,apds990x.yaml    | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds990x.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/light/avago,apds990x.example.dtb: light-sensor@39: 'interrupt' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/light/avago,apds990x.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230308090219.12710-2-clamor95@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

