Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E8C734F74
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjFSJQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjFSJQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:16:42 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329401A3;
        Mon, 19 Jun 2023 02:16:39 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3424372d22fso7785645ab.1;
        Mon, 19 Jun 2023 02:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687166198; x=1689758198;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=za65m95xf70IuUPWVqHELJbJ+80G8bzYVUTAvtx8c1Q=;
        b=Kl18WajTJ3X7A9j+mScJC5rMDh0Xr4zgBQKrND+caCp5tBolIzz4iL7dwe8ehG5BOs
         LT1bMn9Wvq2+Vjpu461Ky5aFLLza0wlDOuk2MPjOVLjSfkmF3xehCG5Ywbf/arnflO95
         JJ+KZQxwCMxbst840/jOgnTOQyyMl6bOE/nQPdvCg1qaOtCiMNznOf0/mmiLaMgupfx/
         UaYILx5WpwLJXhdH2tohHeoB9VDtaA3/LZDhDrMOea1wHvqJ5QpMfjRWG3+WYh8qXNvW
         NPQBO3qAq16qrZVC8L5nUwkJ11vgaqlaGsq6LFIkyOTmkemBCH/zTIQOzQvmh7C3krqs
         B69A==
X-Gm-Message-State: AC+VfDzTvptCDr3gAlGJjnSol30KzmDWptIS5UyHnZmvclvh6kIS17fl
        gkvzGWBGASq9EYlfKhRGIw==
X-Google-Smtp-Source: ACHHUZ5+0qQjdkxM1+PZiQ17yggh0SpYAW17VbtorAscrXLA/VL31u4kjPfTxcJ4dTW+T253XUrb7A==
X-Received: by 2002:a92:4b02:0:b0:340:6c4f:d311 with SMTP id m2-20020a924b02000000b003406c4fd311mr5077397ilg.28.1687166198076;
        Mon, 19 Jun 2023 02:16:38 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s5-20020a02cf25000000b0041f62ba9a37sm8089692jar.104.2023.06.19.02.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 02:16:37 -0700 (PDT)
Received: (nullmailer pid 242871 invoked by uid 1000);
        Mon, 19 Jun 2023 09:16:35 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
In-Reply-To: <20230619083517.415597-2-william.qiu@starfivetech.com>
References: <20230619083517.415597-1-william.qiu@starfivetech.com>
 <20230619083517.415597-2-william.qiu@starfivetech.com>
Message-Id: <168716619573.242780.12121020614995223090.robh@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: qspi: cdns,qspi-nor: Add clocks
 for StarFive JH7110 SoC
Date:   Mon, 19 Jun 2023 03:16:35 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Jun 2023 16:35:15 +0800, William Qiu wrote:
> The QSPI controller needs three clock items to work properly on StarFive
> JH7110 SoC, so there is need to change the maxItems's value to 3. Other
> platforms do not have this constraint.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/spi/cdns,qspi-nor.yaml           | 20 ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dtb: spi@ff705000: clocks: [[4294967295]] is too short
	from schema $id: http://devicetree.org/schemas/spi/cdns,qspi-nor.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230619083517.415597-2-william.qiu@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

