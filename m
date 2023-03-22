Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8E86C5181
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjCVRAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjCVQ7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:59:37 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D6828D33;
        Wed, 22 Mar 2023 09:59:27 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 103-20020a9d0870000000b0069f000acf40so8301375oty.1;
        Wed, 22 Mar 2023 09:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679504366;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NWqyrfUQQCISr39NkQZ5Ma1o6AYL1xyxzggPNypbXQk=;
        b=BVi+xQpifJKFndTzQl02cmq0ksKElOue2GKvfMGiRPqby9NeRNEDVM9Dj0ktA6ziRe
         HIkXz17ONqxZtNeHRvZI6HMiuqEeOnAt2iejnJd22GA05tN3gjAar18Qf6NFA3KOxxPJ
         sKQ7AIQYqKgpMpC+3IMJSLS97W6bUUBsqZsbHtEng3jDpCyM1xeW+x/q6XejARZseG+7
         Qdye8jZfsqgV0H79KPv6gDm5i6s0C1aisFwAIPCoHp+WLAWX/nNu3NqaKHY0fdiUHXd0
         baHGBUE1sYrSpiqQLqVySiTrC/+NvP6GEuvHNhocdgUcjdfClEUNwfYIwHm3dLt7YtnS
         PDFA==
X-Gm-Message-State: AO0yUKVLneZQb3cwHziJ205hV/3KTQVxCXJXijtw7r0poSIz+03xOM/I
        D9jmwA/v15cs7FxF+XhkqfVBI/W0aw==
X-Google-Smtp-Source: AK7set9pHTty/88AsdcNbe/96VYXZqDeFXpGdlF3m0B/sOmCD6PE7StmwAMdHsnvOsbVvW2GQIarqg==
X-Received: by 2002:a9d:7544:0:b0:699:896e:c9e1 with SMTP id b4-20020a9d7544000000b00699896ec9e1mr1605607otl.34.1679504365842;
        Wed, 22 Mar 2023 09:59:25 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a7-20020a056830008700b0069417e65acasm6669680oto.45.2023.03.22.09.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:59:25 -0700 (PDT)
Received: (nullmailer pid 3916336 invoked by uid 1000);
        Wed, 22 Mar 2023 16:59:24 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Mark Brown <broonie@kernel.org>, kernel@sberdevices.ru,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
In-Reply-To: <20230322150458.783901-2-mmkurbanov@sberdevices.ru>
References: <20230322150458.783901-1-mmkurbanov@sberdevices.ru>
 <20230322150458.783901-2-mmkurbanov@sberdevices.ru>
Message-Id: <167950430158.3915000.3991863797525882649.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: spi: add binding for
 meson-spifc-a1
Date:   Wed, 22 Mar 2023 11:59:24 -0500
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Mar 2023 18:04:57 +0300, Martin Kurbanov wrote:
> Add YAML devicetree binding for Amlogic Meson A113L (A1 family)
> SPIFC Driver.
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230322150458.783901-2-mmkurbanov@sberdevices.ru

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

