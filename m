Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878785FC645
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJLNTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiJLNTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:19:42 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7495AF07;
        Wed, 12 Oct 2022 06:19:39 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1326637be6eso19386601fac.13;
        Wed, 12 Oct 2022 06:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7EAJFO7neLdf3WjMmm37zm/4YHZwmJFmdFV44FOsiFk=;
        b=7CJx76oCPoGg+j8jq0Qnlc6kw5MZZKrHdBIAO+BMzX0wE4NpJLgPrRXo7boI20CbKR
         7RJr+TjG+k+a8Uv11UFOT5QjIQ/Vc5FTRExSssSXC2l/Iw00wYxfSGT06bSvYWv18CqZ
         wd/TBATDjj9aMb3OZtrAffZ+7zARUF5a7eCVTSoUYdaI5hMU65ZFWAfwhQaDva8lLIPV
         b/fKEGFV/VnbguC25sYqIS6V7mqaLejUZXNxYdUZyfrgcIE7ldV0FOhd1CsqjwKIcimd
         gnqAa/yvuojmw1SDVgVQegjISqsj670fVLrxywXb9DRYx2/HxJHB2ZSdpgg9x5YqN+Ws
         0fHA==
X-Gm-Message-State: ACrzQf09ovdWav289/j1zT8soouKb14mLEoFBwIQ9AWzgtYCu2vk0BOF
        syMMI8eT9cDptPYByOcltg==
X-Google-Smtp-Source: AMsMyM7K5jb6v64ktWm+n2zTk2z7te9iFpUFOXpPsi2Kx8O72MAANdsaWdTy1AA7cGj9J993ook2Lg==
X-Received: by 2002:a05:6870:15d3:b0:122:5c72:f21f with SMTP id k19-20020a05687015d300b001225c72f21fmr2417883oad.178.1665580778204;
        Wed, 12 Oct 2022 06:19:38 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cg12-20020a056830630c00b006618b23df05sm6026187otb.21.2022.10.12.06.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 06:19:37 -0700 (PDT)
Received: (nullmailer pid 1941571 invoked by uid 1000);
        Wed, 12 Oct 2022 13:19:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bryan Brattlof <bb@ti.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Linux Device Tree <devicetree@vger.kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linux Thermal <linux-pm@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <20221011231727.8090-7-bb@ti.com>
References: <20221011231727.8090-1-bb@ti.com> <20221011231727.8090-7-bb@ti.com>
Message-Id: <166558062789.1936784.4988511846855638539.robh@kernel.org>
Subject: Re: [PATCH 06/11] dt-bindings: thermal: k3-j72xx: conditionally require efuse reg range
Date:   Wed, 12 Oct 2022 08:19:39 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Oct 2022 18:17:22 -0500, Bryan Brattlof wrote:
> Only some of TI's J721E SoCs will need a eFuse register range mapped to
> determine if they're affected by TI's i2128 erratum. All other SoC will
> not need this eFuse range to be mapped to function properly
> 
> Update the bindings for the k3_j72xx_bandgap thermal driver so other
> devices will only need to define two register ranges
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  .../bindings/thermal/ti,j72xx-thermal.yaml    | 34 +++++++++++++------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.example.dtb: thermal-sensor@42040000: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

