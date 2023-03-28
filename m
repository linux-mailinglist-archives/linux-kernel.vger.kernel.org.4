Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BD06CBFF1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjC1M5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjC1M5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:57:11 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA031BDD;
        Tue, 28 Mar 2023 05:57:09 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-17aceccdcf6so12547545fac.9;
        Tue, 28 Mar 2023 05:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680008228;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pfl8kj7s7apTQU6orQnyRp7gH+23K/F8LcW5+yhlLGQ=;
        b=tOv99/FJu/ARb6Z8qH4qxx36QrfzBksQIlQGbaqs4PJ9cnz8SJ+3+FC4q7chzmdkeo
         0qrEyfJrWq5MuvQpQx2xAibuJOQGyKUc/b99h3frAMR8XPKGz3PvDWHb3e9sEyzz5pd4
         /rUJEgHtq10U0DY/GOyg6ZclBY5NGmeCX1Ztkilr1gXM8ik/Z/3/I8vzgNhr56lPLB5H
         QerXMKbYvrj5bcGo6pFGvhHw+odQcZW3JNLsu4ewHTh+hohbgSvsDGQF/bUUZFq7AudF
         V80GF9p47JIp0BLH1kka5np1cWVGdCVdLkI2B9UIl+akuqp8/9iOYuUTSjHmJHX7xDPB
         dTJQ==
X-Gm-Message-State: AAQBX9cP6YH0xbTLT6pP7qGcnGW5DtAcPuCgiD6oetWw4PYJ3ovdAKCm
        TLHJciXdSr7IkivzlTi6sg==
X-Google-Smtp-Source: AK7set/3tBXTrmBUNn8CXl7BAo/4Z9br++DcW8SsJpa1gY6tJFANfBnZ/VmKke2susiUONU44glLjQ==
X-Received: by 2002:a05:6870:a454:b0:177:c8dc:501f with SMTP id n20-20020a056870a45400b00177c8dc501fmr11076779oal.29.1680008228470;
        Tue, 28 Mar 2023 05:57:08 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v23-20020a056870709700b0017280f7d653sm10729715oae.35.2023.03.28.05.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 05:57:08 -0700 (PDT)
Received: (nullmailer pid 3017887 invoked by uid 1000);
        Tue, 28 Mar 2023 12:57:07 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        Mark Brown <broonie@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20230328112210.23089-2-zhuyinbo@loongson.cn>
References: <20230328112210.23089-1-zhuyinbo@loongson.cn>
 <20230328112210.23089-2-zhuyinbo@loongson.cn>
Message-Id: <168000761529.3001360.2224316097077012976.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: spi: add loongson spi
Date:   Tue, 28 Mar 2023 07:57:07 -0500
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Mar 2023 19:22:09 +0800, Yinbo Zhu wrote:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230328112210.23089-2-zhuyinbo@loongson.cn

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

