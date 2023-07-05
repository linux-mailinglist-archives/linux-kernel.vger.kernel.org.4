Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414E574810B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjGEJgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjGEJge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:36:34 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA501737;
        Wed,  5 Jul 2023 02:36:33 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3425eb6865eso1033695ab.1;
        Wed, 05 Jul 2023 02:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688549793; x=1691141793;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gCXnreO4f7zyeb3Oa/KsScusfsW3glrtOR4lvy1jYrQ=;
        b=frlbV+AN8LJWD/1dZTgYTQgsAfh+44b3v/d72vt2ciZrJctZRGg5c0+Kfe23SHfZZS
         WXPg/V5SkcBScKs/ecZPvEvQtOo7P/9RoKGSXl0Yp7Av0/xKTKx5ROSUcVm8M5CP5vRw
         KEkfaI6rboNLNcqK3ssN0763PVZ+pnG1rUbnngXwE0uA47LqRozBfSJc74Nw3Y/gpBpp
         Cbj/RY3WDCZq6YujZCzqv+aaQzC7KAPFDvtmeR4Cbvo9CsQdN2xRtkgBhsQ2dDrrG93X
         1mDHNoSHZf1mnmUWPl07vzzpOiLpWn2ktbnYkQvFGnFUyfFHdePS7K0nRGZrKWaX5JhO
         Uv6Q==
X-Gm-Message-State: ABy/qLZHNRkRdZ0z9AI+LL7S70HwXwvHOztja30E7/a77/0KVHRGnQmb
        cnn20t4bTUD2eXFyQR6dMpYdLgNEGw==
X-Google-Smtp-Source: APBJJlHWTyqQCw+iuSJ7h7w8uxUGlhKBrSZt8LDRV91VBoqZzGInjjA4nj9irPaKMnwrO+FmfSav/A==
X-Received: by 2002:a92:d241:0:b0:342:2b27:725c with SMTP id v1-20020a92d241000000b003422b27725cmr1288477ilg.6.1688549792767;
        Wed, 05 Jul 2023 02:36:32 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p2-20020a92d482000000b003460b456030sm2259430ilg.60.2023.07.05.02.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 02:36:32 -0700 (PDT)
Received: (nullmailer pid 4106983 invoked by uid 1000);
        Wed, 05 Jul 2023 09:36:30 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     like@awinic.com
Cc:     broonie@kernel.org, liweilei@awinic.com, yijiangtao@awinic.com,
        robh+dt@kernel.org, lgirdwood@gmail.com, liangdong@awinic.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20230705081942.2608531-2-like@awinic.com>
References: <20230705081942.2608531-1-like@awinic.com>
 <20230705081942.2608531-2-like@awinic.com>
Message-Id: <168854979046.4106954.2655397738396869606.robh@kernel.org>
Subject: Re: [PATCH V1 1/1] regulator: Add awinic,aw3750x.yaml
Date:   Wed, 05 Jul 2023 03:36:30 -0600
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


On Wed, 05 Jul 2023 08:19:41 +0000, like@awinic.com wrote:
> From: Ke Li <like@awinic.com>
> 
> Signed-off-by: Ke Li <like@awinic.com>
> ---
>  .../bindings/regulator/awinic,aw3750x.yaml    | 151 ++++++++++++++++++
>  1 file changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/awinic,aw3750x.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/regulator/awinic,aw3750x.example.dts:21.31-70.11: Warning (unit_address_vs_reg): /example-0/pinctrl@10005000: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/regulator/awinic,aw3750x.example.dts:94.24-124.15: Warning (gpios_property): /example-1/i2c/aw3750x@3e: Missing property '#gpio-cells' in node /example-0/pinctrl@10005000 or bad phandle (referred from enn-gpio[0])
Documentation/devicetree/bindings/regulator/awinic,aw3750x.example.dts:94.24-124.15: Warning (gpios_property): /example-1/i2c/aw3750x@3e: Missing property '#gpio-cells' in node /example-0/pinctrl@10005000 or bad phandle (referred from enp-gpio[0])
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/awinic,aw3750x.example.dtb: aw3750x@3e: enp: Unevaluated properties are not allowed ('label' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/awinic,aw3750x.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/awinic,aw3750x.example.dtb: aw3750x@3e: enn: Unevaluated properties are not allowed ('label' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/awinic,aw3750x.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/awinic,aw3750x.example.dtb: aw3750x@3e: 'aw3750x_gpio_ctrl', 'enn-gpio', 'enp-gpio', 'outn', 'outp', 'reg' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/regulator/awinic,aw3750x.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230705081942.2608531-2-like@awinic.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

