Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976A3616192
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiKBLRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKBLQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:16:58 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DC294;
        Wed,  2 Nov 2022 04:16:56 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id d26-20020a05683018fa00b0066ab705617aso10084932otf.13;
        Wed, 02 Nov 2022 04:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=orpHrRTbVw/dGaa046vQReJIHPyuv9RpyZ+5X6G72DM=;
        b=ng8cTLVnmJDDFX1gHy5tHG7yUU9/RZCmsLrUcHVvVtf+eKr1dGo4wVSIAeP0zVkrPo
         f7cGLos3lsDdX8qtvAf+lTxxOv9EqX+oQP2Buj99KoXgeCzAcEFqHPkUImguxeD1dosH
         Cvtk5YNwTMvGRdtTbKg0oXWvxPpkG5VgoEZWmPZ5n+yX1Uk7J0K2P0adNAwFetXE6Etm
         3aVYjm6d5xci/SvPPam7oo/HJX5ZRKmxRNd0Nn0+QeCZGPT0T2pS3pCXIePD7w2HECoY
         B+OFjsMJiA/WWxS63X+zNvNWQEr+euCI3opONiVZO0trt4zbnLe0jtgmOYs0c8AN2niW
         60LQ==
X-Gm-Message-State: ACrzQf0nZSR0U9YfxWiCOX88XqYQ704PfEx8sKegn/oOIrPiSKJWUqsG
        MaDXdj0hi1/6XTe9EqZY/g==
X-Google-Smtp-Source: AMsMyM7xDZoNRCemMfQdlospwTAEf3+HsTWmLlfvQlwUWt5V81JVu6cuI4UnMXB9s9AzP0H3ziIBcQ==
X-Received: by 2002:a9d:4c05:0:b0:66c:49e3:8df with SMTP id l5-20020a9d4c05000000b0066c49e308dfmr9078964otf.24.1667387815336;
        Wed, 02 Nov 2022 04:16:55 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r84-20020a4a3757000000b00475d676d2d4sm4416699oor.16.2022.11.02.04.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 04:16:54 -0700 (PDT)
Received: (nullmailer pid 3462412 invoked by uid 1000);
        Wed, 02 Nov 2022 11:16:56 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Yun Liu <liuyun@loongson.cn>, linux-kernel@vger.kernel.org,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, loongarch@lists.linux.dev,
        Huacai Chen <chenhuacai@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20221102035249.19776-2-zhuyinbo@loongson.cn>
References: <20221102035249.19776-1-zhuyinbo@loongson.cn>
 <20221102035249.19776-2-zhuyinbo@loongson.cn>
Message-Id: <166738767754.3460253.533656720238446457.robh@kernel.org>
Subject: Re: [PATCH v7 2/2] dt-bindings: hpet: add loongson-2 hpet
Date:   Wed, 02 Nov 2022 06:16:56 -0500
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 02 Nov 2022 11:52:49 +0800, Yinbo Zhu wrote:
> Add the Loongson-2 High Precision Event Timer (HPET) binding
> with DT schema format using json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/timer/loongson,ls2k-hpet.yaml    | 50 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.example.dts:21:18: fatal error: dt-bindings/clock/loongson,ls2k-clk.h: No such file or directory
   21 |         #include <dt-bindings/clock/loongson,ls2k-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

