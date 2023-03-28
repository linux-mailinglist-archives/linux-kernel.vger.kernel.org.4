Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA7C6CB36E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjC1Bxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjC1Bxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:53:33 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756AB2101;
        Mon, 27 Mar 2023 18:53:32 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id r14so2209929oiw.12;
        Mon, 27 Mar 2023 18:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679968412;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MYTrnhZDgTTeegxUWGeV8K3c6cyl+HkrWWPDkDux9pU=;
        b=K6abqVO3pc63TZeJay23pCJaJMI44qISEj/hs0nUEGQ+9Dx6Z8CtbHMJlzFfYLzZrJ
         qDoaxU8E5NKwl+AEAQ+w0KlqL9hoxcWY12p/dpVKOyGmNpWsK1C3wAZXeLItSeJ3FSOy
         gKS0yfm9WqIAC3JyLgGCQBj5DMhsXeJzI6SXxIuQQzEwsY5fLAUBN6v4dX5Pdj1henQ7
         yk51U3C/fz78vwurWrKrXmaEJ/hoX9HQyA0hu0+Mbf9nRDIxUXYDciu2/Rsvt1tiPIog
         IPta6w6RQsX84UWlOvdUtOUSm0y/XpGDTJKr1URMMRDzraLVZlGLZUIV0G1n8YLi2LgV
         TeTw==
X-Gm-Message-State: AAQBX9eSMNp8AvYGiveej2lAf1McE+uNQN7xrchiadC8LcloK7HrvA4b
        Ojm86o/KSmZocU+gYy7aug==
X-Google-Smtp-Source: AKy350bkl4fqTt6QpZi7WIWnPrZc4ldPQfRH8qICoYIokHV33sGARNUQ+fGNzFRukXVsK+zOdQwpgA==
X-Received: by 2002:aca:d9d4:0:b0:389:14bd:8246 with SMTP id q203-20020acad9d4000000b0038914bd8246mr3887280oig.13.1679968411696;
        Mon, 27 Mar 2023 18:53:31 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l20-20020a544114000000b0038413a012dasm7270451oic.4.2023.03.27.18.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 18:53:31 -0700 (PDT)
Received: (nullmailer pid 1306392 invoked by uid 1000);
        Tue, 28 Mar 2023 01:53:28 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20230327211351.686831-2-mmkurbanov@sberdevices.ru>
References: <20230327211351.686831-1-mmkurbanov@sberdevices.ru>
 <20230327211351.686831-2-mmkurbanov@sberdevices.ru>
Message-Id: <167996718827.1276101.10705861652259578341.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: add Amlogic Meson A1 SPI
 controller
Date:   Mon, 27 Mar 2023 20:53:28 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Mar 2023 00:13:50 +0300, Martin Kurbanov wrote:
> Add YAML devicetree Amlogic Meson A113L (A1 family) SPIFC Driver.
> 
> This patch has dependencies on the A1 clock series which is still under
> review - https://lore.kernel.org/all/20230321193014.26349-1-ddrokosov@sberdevices.ru/
> 
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> ---
>  .../bindings/spi/amlogic,meson-a1-spifc.yaml  | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson-a1-spifc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/spi/amlogic,meson-a1-spifc.example.dts:18:18: fatal error: dt-bindings/clock/amlogic,a1-clkc.h: No such file or directory
   18 |         #include <dt-bindings/clock/amlogic,a1-clkc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/spi/amlogic,meson-a1-spifc.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230327211351.686831-2-mmkurbanov@sberdevices.ru

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

