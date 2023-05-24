Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9D670F621
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjEXMVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjEXMVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:21:31 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF9B139;
        Wed, 24 May 2023 05:21:30 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-54fb0fce238so335182eaf.1;
        Wed, 24 May 2023 05:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684930890; x=1687522890;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yOUV3NHIV/iK6R+sZSedSwk/RX0eGbK5K3EGZstC8H0=;
        b=Fy6MKbiLWRBv19EuOTb4U7jU/2TFWgfzIbFoSdJWFwnWnM+rkomYDpuZr2gm/4IVyJ
         18FMjnB5nNaHKx8cro57r/of9+G5S2/+rrHTrOMmIHJDxZULXLIJ0ximNcJ3bWN2/Vct
         0wwQsdZo51LyvNc6KlBosNf5R016dPAdQbdvIxYzOavhXsKMvgThrsETuhqpqNZuWe4G
         IZvNBypyX0b/qu/aCnQiNCH83hmuHAgGmhDZ1ibOz6JxQQ/kWOlvbtOD5K/3DItLa5NP
         RWd0IS0G138y19IstYj7OP+AWsPdTna+c0ooCV7iWKHido/EFJRdvT7/hQ+ZyK1JZ6FV
         rJaw==
X-Gm-Message-State: AC+VfDw/M+IeCLzOw29a3PxE9cpW9YFm/BkOxLvBBdt9w2E3lX8TpEVP
        vO5jvlrzTwBIsS2n5C62lOqOL4fQ9g==
X-Google-Smtp-Source: ACHHUZ66O66EuFjQbNWR3pl96eJfkG4L7dl3KrN6aJ/WSlwBvmiYkyuqf+RUzqZi+hUYIdOmA6CD8Q==
X-Received: by 2002:a4a:3c4b:0:b0:555:53ce:4164 with SMTP id p11-20020a4a3c4b000000b0055553ce4164mr3183730oof.9.1684930889639;
        Wed, 24 May 2023 05:21:29 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s9-20020a9d7589000000b006abb3b660a9sm4460678otk.54.2023.05.24.05.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 05:21:28 -0700 (PDT)
Received: (nullmailer pid 3462753 invoked by uid 1000);
        Wed, 24 May 2023 12:21:27 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Vladimir Barinov <v.barinov@yadro.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
        linux@yadro.com, linux-leds@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20230524114056.196518-1-v.barinov@yadro.com>
References: <20230524113910.196321-1-v.barinov@yadro.com>
 <20230524114056.196518-1-v.barinov@yadro.com>
Message-Id: <168493088788.3462735.2834416618033227181.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: leds: Document Awinic AW2016 bindings
Date:   Wed, 24 May 2023 07:21:27 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 May 2023 14:40:56 +0300, Vladimir Barinov wrote:
> Add Awinic AW2026 binding documentation
> 
> Signed-off-by: Vladimir Barinov <v.barinov@yadro.com>
> ---
>  .../bindings/leds/awinic,aw2026.yaml          | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/awinic,aw2026.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/leds/awinic,aw2026.example.dts:52.3-53.1 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/leds/awinic,aw2026.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230524114056.196518-1-v.barinov@yadro.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

