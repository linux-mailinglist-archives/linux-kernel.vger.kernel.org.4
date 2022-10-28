Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5006611A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJ1TEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJ1TEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:04:42 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5516FDFAD;
        Fri, 28 Oct 2022 12:04:40 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-13c2cfd1126so7288953fac.10;
        Fri, 28 Oct 2022 12:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtfpI9rlbOhsKpmZm1h0Bvu9a77/MRnLOJ2Qclf1R/g=;
        b=bAU8WkXgJzbLqj/s1xMIlYjC73u64Y+eF+FDViEqGXlUM2RfJgmn5VnkJACM0eoqS2
         g5tYy4gmWyPIFi52SiglNeC3T+gSVOkPY7SClSC270eH3JJHzkgFlPVfavATEtJV2pgS
         5wFZ7A+I1rrQdUlQQVCcaD5li+8Ocy+aqEwP9YsiKZD9iGWrrbmspR+aAZBIFIEfnqad
         GyXN/ZDSu4LW8xw2fwPB+iscyHumlzav8jA46n4BZzUvMzMPI3FF7nDE2/lB7ow5mp7L
         L70WhUYPoj9NRsgsncZgXZl4p72sh/c/JsOV0IR95RqTWmAR+JxOwNqxQrSFnAECADa2
         uXqw==
X-Gm-Message-State: ACrzQf323+lU11+L+G/SBCOUu2CRc1pdCaRxe5S1XlFnS6rrc2L15jra
        oOOy0t4sdMJue3NeycyIAQ==
X-Google-Smtp-Source: AMsMyM6tezh5o2b4dNkYK5v+E6BduBVm+8wB6EMOaQdLqRIYQoPr5GfMlgIq26LTdQ2B28Jfk4dbpw==
X-Received: by 2002:a05:6870:b414:b0:130:ea11:761c with SMTP id x20-20020a056870b41400b00130ea11761cmr393921oap.62.1666983879570;
        Fri, 28 Oct 2022 12:04:39 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g91-20020a9d12e4000000b00661b019accbsm2022445otg.3.2022.10.28.12.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 12:04:39 -0700 (PDT)
Received: (nullmailer pid 2098127 invoked by uid 1000);
        Fri, 28 Oct 2022 19:04:38 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, sven@svenpeter.dev,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        asahi@lists.linux.dev, marcan@marcan.st, alyssa@rosenzweig.io
In-Reply-To: <20221028165215.43662-2-fnkl.kernel@gmail.com>
References: <20221028165215.43662-1-fnkl.kernel@gmail.com> <20221028165215.43662-2-fnkl.kernel@gmail.com>
Message-Id: <166698381253.2093680.6251640066817102720.robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: pwm: Add Apple PWM controller
Date:   Fri, 28 Oct 2022 14:04:38 -0500
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

On Fri, 28 Oct 2022 19:52:13 +0300, Sasha Finkelstein wrote:
> Apple SoCs such as the M1 contain a PWM controller used
> among other things to control the keyboard backlight.
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  .../devicetree/bindings/pwm/pwm-apple.yaml    | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-apple.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/pwm-apple.example.dtb: fpwm@235044000: compatible:0: 'apple,s5l-fpwm' is not one of ['apple,t8103-fpwm', 'apple,t6000-fpwm', 'apple,t8112-fpwm']
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/pwm-apple.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/pwm-apple.example.dtb: fpwm@235044000: compatible: ['apple,s5l-fpwm'] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/pwm-apple.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/pwm-apple.example.dtb: fpwm@235044000: reg: [[2, 889470976], [0, 16384]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/pwm-apple.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

