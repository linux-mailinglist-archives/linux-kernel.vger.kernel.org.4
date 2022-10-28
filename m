Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5F8611117
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiJ1MUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiJ1MUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:20:13 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B191B30576;
        Fri, 28 Oct 2022 05:20:07 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id o64so5908943oib.12;
        Fri, 28 Oct 2022 05:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GS27YxTROfugF/wVZbzeCMhNKTwEI+7kiEMnQj/EQrE=;
        b=6LtMm9VZqab/4Sx8yDCG9T0L8O+S5msg3bgA/lVBREn956Fdf1x8Jtr6oyzes4B+b6
         n0jDMLoRqGYaNKc2u9H2BlLY5PLAsn6DqEeZEQhbYen99IejJMeziZwbg56nVt2aGb6Y
         8dqA751koCUmw5wRxX3a4bRHXoJyNq8DezXh/QI71LF4bnizUWM8bkhkAhTfM+6E+G/p
         Qo7vfKyW4WvCoFiqBf/sgS9h7uxaF8mFH1AUb8oKpEqPdezdUXEs1YvX9KG0VtVqV8hr
         ZTuq21z9VoA4Svh0Q0nFhbW2aswP2w8ECaFBA22YB+BIM1jOOnPiViWOE+yHtF42mReP
         kqQg==
X-Gm-Message-State: ACrzQf15+RzAiG9hUa7FT/BboYCQK02iyKfRDgBrZPZwiWLLQbw5I/Bv
        w09LwyQDuNQcQwZVPlTabQ==
X-Google-Smtp-Source: AMsMyM654wy/VermBsr6jXijH34jpCZlwSxa507GFx8XdZTumRNnQbRpMmh3u7vFH90EDhUf9AYZRg==
X-Received: by 2002:a05:6808:ec4:b0:354:475a:c101 with SMTP id q4-20020a0568080ec400b00354475ac101mr8080836oiv.56.1666959606450;
        Fri, 28 Oct 2022 05:20:06 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n15-20020a0568301e8f00b00661946468c6sm270107otr.31.2022.10.28.05.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 05:20:05 -0700 (PDT)
Received: (nullmailer pid 1079533 invoked by uid 1000);
        Fri, 28 Oct 2022 12:20:05 -0000
From:   Rob Herring <robh@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yun Liu <liuyun@loongson.cn>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, loongarch@lists.linux.dev,
        Huacai Chen <chenhuacai@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20221028073222.21609-2-zhuyinbo@loongson.cn>
References: <20221028073222.21609-1-zhuyinbo@loongson.cn> <20221028073222.21609-2-zhuyinbo@loongson.cn>
Message-Id: <166695949216.1076967.15883740834218408019.robh@kernel.org>
Subject: Re: [PATCH v5 2/2] dt-bindings: hpet: add loongson-2 hpet
Date:   Fri, 28 Oct 2022 07:20:05 -0500
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 15:32:22 +0800, Yinbo Zhu wrote:
> Add the Loongson-2 High Precision Event Timer (HPET) binding
> with DT schema format using json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Change in v5:
> 		1. Replace string loongson2/Loongson2 with Loongson-2/loongson-2.
> 		2. Add the patch review information.
> 
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

