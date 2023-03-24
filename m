Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696706C7E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjCXNHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCXNHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:07:22 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515FE22A1B;
        Fri, 24 Mar 2023 06:07:21 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id m6-20020a4ae846000000b0053b9059edd5so269448oom.3;
        Fri, 24 Mar 2023 06:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679663240;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=13e4PzhHJoCEe/Nz2dMvzceKnl5ytY6lvF9QO/11MtQ=;
        b=Ad6Wq0TYUVC8nZzxb2ThpC4XM6GkWN7hzmU0qtBg56LNdZDaqn/2hW+W+SnQvhFvwt
         xTrl/p+tQzqrkw0yofXkpkEhqQ6KUPiZy9kxpftMjlJhf/nH3YvNEYK3JZHQdBHW/1QJ
         jqduLACyGbTwUw8gzqA6sL9FtnTl+ftRcSpxmRhW4hF9fDvKSIlujYlrsHIcTQnHsvZn
         EHImerXIzbRHZd81o/0EIrq6DGeo9Y8Fl5r60VoIN5JOzwa63pqAdkAc0dzFpBfwEqZ8
         1Is+BchT0fUsdB+FxaMNZxj2gQ6d0Pmi646MC9rfhoUsbXkX2HcoG34GFbbyLofO4l8u
         hQMw==
X-Gm-Message-State: AO0yUKXKnrBBm+FOXmw6kJR6ilGkm07L+O3LFHsJADRDU+WNsSz3RGfD
        716U1keB5ovy+UvhZBN8QPjh8H+acw==
X-Google-Smtp-Source: AK7set9vyNqMBluunX573FfIh/MRKX7/vAM1A4OlmZZRECqbJeynbz0zyY2w2+1XsUJUR4DsbD+S0w==
X-Received: by 2002:a4a:3707:0:b0:525:7096:972f with SMTP id r7-20020a4a3707000000b005257096972fmr1836149oor.9.1679663240388;
        Fri, 24 Mar 2023 06:07:20 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s2-20020a4aad42000000b00525398a1144sm8191345oon.32.2023.03.24.06.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 06:07:19 -0700 (PDT)
Received: (nullmailer pid 1693727 invoked by uid 1000);
        Fri, 24 Mar 2023 13:07:19 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>, loongson-kernel@lists.loongnix.cn,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20230324063317.14664-2-zhuyinbo@loongson.cn>
References: <20230324063317.14664-1-zhuyinbo@loongson.cn>
 <20230324063317.14664-2-zhuyinbo@loongson.cn>
Message-Id: <167966252219.1675112.1668738117284963309.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: add loongson spi
Date:   Fri, 24 Mar 2023 08:07:19 -0500
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 24 Mar 2023 14:33:16 +0800, Yinbo Zhu wrote:
> Add the Loongson platform spi binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  .../bindings/spi/loongson,ls-spi.yaml         | 43 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/spi/loongson,ls-spi.example.dts:22.28-29 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/spi/loongson,ls-spi.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230324063317.14664-2-zhuyinbo@loongson.cn

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

