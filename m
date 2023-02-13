Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D80694A70
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjBMPKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjBMPJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:09:48 -0500
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196751D931;
        Mon, 13 Feb 2023 07:09:48 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id c15so3681069ils.12;
        Mon, 13 Feb 2023 07:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nb3jt0wNeVIrLvYRA5KKUNf8Qt4b5JqZ1jqI/V5VbPc=;
        b=DCmy1FCHRgW1t2xuokSEucUjSsZSXtIj4yIgUWAFuZuUJOgHNG/6vnlmMMVjHoObib
         4MQUeX77jtqXVBCL9DJIpLY/ziAY998Du2t9XqdMzHID0if38vz+FJ4Og4Y2OYi1+R2U
         GHCnA4SzQtttkOUZ2JoF8yv6m7V5zMEG/DpwHs55RS+feDFm8P23z5WkfcoXNw/Ldl7j
         1lSqoQfvVMOCW7V26mT3cBubbRriNLZlSMIJAQkFTvlwB4yXXpwuhMAaI4y84PlesGHI
         VgZZRJH4W7385FGB9pI7cwGQjWjhpoPeiCBntyw+tGYlRB6HZhzDX5NoV2g+7fOHUoxf
         mhoQ==
X-Gm-Message-State: AO0yUKUdWhAp4V0XSYHb8p2rO8lhUR1jGBP/kpzFvYqkfJhkz3ZgLM6V
        Dprv8IZjXTr+DJiz5tEMeg==
X-Google-Smtp-Source: AK7set9Hz7MafJCa1RH+CHg6DjLoQLRunpfIwveQ8c0QzUboYm+YoFFYrcM7Wii96E0ZvXUBq6rB3Q==
X-Received: by 2002:a05:6e02:19cf:b0:315:2b7c:3bcd with SMTP id r15-20020a056e0219cf00b003152b7c3bcdmr11352271ill.23.1676300987324;
        Mon, 13 Feb 2023 07:09:47 -0800 (PST)
Received: from robh_at_kernel.org (c-73-14-99-67.hsd1.co.comcast.net. [73.14.99.67])
        by smtp.gmail.com with ESMTPSA id s14-20020a056e0210ce00b00313fc4834a4sm703477ilj.86.2023.02.13.07.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:09:46 -0800 (PST)
Received: (nullmailer pid 11613 invoked by uid 1000);
        Mon, 13 Feb 2023 15:09:41 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
In-Reply-To: <20230212190222.44977-3-krzysztof.kozlowski@linaro.org>
References: <20230212190222.44977-1-krzysztof.kozlowski@linaro.org>
 <20230212190222.44977-3-krzysztof.kozlowski@linaro.org>
Message-Id: <167630051330.6283.15554895477756313707.robh@kernel.org>
Subject: Re: [PATCH 3/4] media: dt-bindings: samsung,exynos4212-is: convert
 to dtschema
Date:   Mon, 13 Feb 2023 09:09:41 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 12 Feb 2023 20:02:21 +0100, Krzysztof Kozlowski wrote:
> Convert the Samsung Exynos4212/4412 SoC Imaging Subsystem (FIMC-IS)
> bindings to DT schema.  Changes during conversion - adjust to existing
> DTS and Linux driver: add iommus and power-domains.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/media/exynos4-fimc-is.txt        |  50 ----
>  .../media/samsung,exynos4212-fimc-is.yaml     | 221 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  3 files changed, 222 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/exynos4-fimc-is.txt
>  create mode 100644 Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.example.dtb: /example-0/fimc-is@12000000/i2c-isp@12140000/image-sensor@10: failed to match any schema with compatible: ['samsung,s5k6a3']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230212190222.44977-3-krzysztof.kozlowski@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

