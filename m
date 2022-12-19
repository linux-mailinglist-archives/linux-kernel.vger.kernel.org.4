Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A6C6514BE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 22:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiLSVWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 16:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiLSVWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 16:22:12 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D1613E22;
        Mon, 19 Dec 2022 13:22:11 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1447c7aa004so13150685fac.11;
        Mon, 19 Dec 2022 13:22:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mWZmLhv4tQqRJ/5IIdUzdyuJRsJ9N97/ffK3QG3ROhE=;
        b=YkUYfcSMKPhdAb1I45Mg9DCAF5jJvER5IyRt9rcpN2P0js3lv9WyLSoShxngHLtJ6S
         07Tx3pc3tdynvW2NSLRBLYfQAxp3g7PvEc1EyWKij+ykQuL5RXM+IsHkcESZMcn42dFe
         iKJGcrjv7PCbmvzNuucsmh4KAdYTtIh61PnJzTcisR/CFm8vPb7FajwiPM0mDyu8dKoh
         EpIn+So5+a5fTy+kC3gxwjsWhwL9YusiiN1butWzuor5pO0nKUK4h3D3wvJ7XY1XcOUI
         17GAP6t+JTMYoGP16XjD233WkXhPwQR7ycRfzLt78SV4uSgdKW17kTDjckj4FjPPFnBG
         4RvA==
X-Gm-Message-State: AFqh2kqxg5GW6R56g8Ka6ZFag7hqb9/ftNffqKBw8LN+YzqxT2cJ9UoI
        k2B3Es2QsY3xJ9N2Z5gULg==
X-Google-Smtp-Source: AMrXdXvblcyvfksVkdMDmGQbTDb0F0OxjJ0/LA2SmlJcfOIDgs8zGzq2O65SptMl7iqmYzbMH6kgLQ==
X-Received: by 2002:a05:6870:da09:b0:14b:f696:3ee9 with SMTP id go9-20020a056870da0900b0014bf6963ee9mr4554263oab.13.1671484931150;
        Mon, 19 Dec 2022 13:22:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k48-20020a4a94b3000000b004a0918698f9sm4364886ooi.17.2022.12.19.13.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 13:22:10 -0800 (PST)
Received: (nullmailer pid 2350835 invoked by uid 1000);
        Mon, 19 Dec 2022 21:22:08 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20221219191125.1974879-1-robh@kernel.org>
References: <20221219191125.1974879-1-robh@kernel.org>
Message-Id: <167148427205.2336021.7936012930229650977.robh@kernel.org>
Subject: Re: [PATCH] regulator: dt-bindings: Convert Fairchild FAN53555 to DT schema
Date:   Mon, 19 Dec 2022 15:22:08 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Dec 2022 13:11:25 -0600, Rob Herring wrote:
> Convert the Fairchild FAN53555 and compatible variants binding to DT
> schema format.
> 
> The example was missing 'reg', so add it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/regulator/fan53555.txt           | 24 --------
>  .../bindings/regulator/fcs,fan53555.yaml      | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/fan53555.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221219191125.1974879-1-robh@kernel.org


regulator@40: Unevaluated properties are not allowed ('regulator-compatible', 'vsel-gpios' were unexpected)
	arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb

regulator@40: Unevaluated properties are not allowed ('regulator-init-microvolt' was unexpected)
	arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg353p.dtb
	arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg503.dtb

regulator@41: Unevaluated properties are not allowed ('regulator-compatible', 'vsel-gpios' were unexpected)
	arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb

regulator@60: Unevaluated properties are not allowed ('vsel-gpios' was unexpected)
	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb

syr827@40: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dtb

syr828@41: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dtb

