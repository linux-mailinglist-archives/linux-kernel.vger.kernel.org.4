Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C426B0A84
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjCHOIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjCHOHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:07:49 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECA430B25;
        Wed,  8 Mar 2023 06:06:24 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id 32-20020a9d0323000000b0069426a71d79so9005640otv.10;
        Wed, 08 Mar 2023 06:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678284384;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qsP4LH+jP/I53IC0MPmff0Hsl8QZENzWh0+pWXfTco4=;
        b=EJX8z89ngMLKnLjLrr+O38I9MG7mbYVlghmDgUOFNcyNcBFCwmAjYFU1/+aO5BZYIn
         kKDD3NA9IucEgi8km3cQn0orBSuA+YpWMNe9zMqx2yQ1dlYZ2S508t/9JW1BiQ8MiKtm
         ySPLMAN13zAypL25QlsngBXl1nO5r9JeKkTa14+dd8IQdAG9N3ipCpUJkPtA/vm+QmxF
         KRfV2OVRp4DmLq32hrKW2GdGg0sElpRbiqthj6EdUZLfh3yS9p3/NCy5CxNBtBlSqq3I
         4k+Xj4TvJTTCFHtj2aTWfLe71gAyU3zZs9eUUpIY47rgdbf2Y1yz3p9kUaRa6aU/RDgN
         VI0g==
X-Gm-Message-State: AO0yUKWXG/YfFGpk0ubmYtGQRXJH5Rxyh70YzdO72sX615mV18FYy6yK
        RchTjvOQ+ClSwd44ryDwcA==
X-Google-Smtp-Source: AK7set+Zbw7EyeuNPMCkpj6IQPnLXaNQIQOMlGUW7lXZ4HwtW5PLAJ2eBzxT4rkdpmbwwGgjfgVofQ==
X-Received: by 2002:a05:6830:24b6:b0:68b:dcbe:d0af with SMTP id v22-20020a05683024b600b0068bdcbed0afmr8794679ots.2.1678284383790;
        Wed, 08 Mar 2023 06:06:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y22-20020a056830071600b0068d4dda3d61sm6434007ots.39.2023.03.08.06.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 06:06:22 -0800 (PST)
Received: (nullmailer pid 2666443 invoked by uid 1000);
        Wed, 08 Mar 2023 14:06:21 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liu Peibao <liupeibao@loongson.cn>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, Mark Brown <broonie@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Rob Herring <robh+dt@kernel.org>, wanghongliang@loongson.cn
In-Reply-To: <20230308025908.21491-2-zhuyinbo@loongson.cn>
References: <20230308025908.21491-1-zhuyinbo@loongson.cn>
 <20230308025908.21491-2-zhuyinbo@loongson.cn>
Message-Id: <167828359942.2612999.3798783623764270312.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: spi: add loongson spi
Date:   Wed, 08 Mar 2023 08:06:21 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Mar 2023 10:59:07 +0800, Yinbo Zhu wrote:
> Add the Loongson platform spi binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  .../bindings/spi/loongson,ls-spi.yaml         | 47 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 53 insertions(+)
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230308025908.21491-2-zhuyinbo@loongson.cn

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

