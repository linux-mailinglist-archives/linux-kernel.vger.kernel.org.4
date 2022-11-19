Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F83631120
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 22:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbiKSVhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 16:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiKSVg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 16:36:56 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4DFC762;
        Sat, 19 Nov 2022 13:36:55 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-142306beb9aso9823514fac.11;
        Sat, 19 Nov 2022 13:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RRq8v0X3p2aZwGAcJtCVZBHI71mA/UO0IQVawSCBv34=;
        b=cG7nkPPr9mFTXcbT4a/CT3JbcQQMCZyhKGZjeovDd3wNKJBgtLwjYtEIqu2224ZigD
         NG5CmtVJ8lpcmJGKQDAkNwQRiA53REukfj8XGcIqM2DP7rBFsoARYM8N9XElICZq/H0J
         sHSVR/YCc5JFU8fFgqiiFWQ4t6EYi3S1QlCzCqPPdD2s9MVpovuyKT6XPzZq2M4Hottz
         e5/qAEfEzsNpf9FLpU2PG4/oravNzT6RjBkbbSSYDBeF2jORLy8J2LL/hYg3QevOwzID
         MsBJziP2ggLrNQumR/e1sNbnKbb1Abb49gXjVuW29VM/c4vym38SR/y3d1DdzTSSYYkz
         YgAQ==
X-Gm-Message-State: ANoB5plccWALqh2ewQFxBsE810/EDN6MPt4DfZzJTOw8YoQffrUokhh9
        kSH5qpK3lVdfzgRvkYPjSQ==
X-Google-Smtp-Source: AA0mqf6Qq1z9a/mzRxMv2BFvCXiMTKDB6BCsV/LVkYxS3D+Q8JDWh9D/bIjXsO5eeOK7FCVAJ273Qw==
X-Received: by 2002:a05:6870:4b98:b0:13b:8097:79aa with SMTP id lx24-20020a0568704b9800b0013b809779aamr10072700oab.118.1668893814432;
        Sat, 19 Nov 2022 13:36:54 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cd15-20020a056830620f00b006619f38a686sm3124148otb.56.2022.11.19.13.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 13:36:53 -0800 (PST)
Received: (nullmailer pid 1829799 invoked by uid 1000);
        Sat, 19 Nov 2022 21:36:55 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Ash Logan <ash@heyquark.com>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org,
        segher@kernel.crashing.org, linkmauve@linkmauve.fr,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org, j.ne@posteo.net,
        christophe.leroy@csgroup.eu, rw-r-r-0644@protonmail.com,
        linuxppc-dev@lists.ozlabs.org, pali@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        joel@jms.id.au, paulus@samba.org
In-Reply-To: <20221119113041.284419-2-ash@heyquark.com>
References: <20220628133144.142185-1-ash@heyquark.com>
 <20221119113041.284419-1-ash@heyquark.com>
 <20221119113041.284419-2-ash@heyquark.com>
Message-Id: <166889377396.1828488.10770101082867021611.robh@kernel.org>
Subject: Re: [PATCH v4 01/11] dt-bindings: wiiu: Document the Nintendo Wii U
 devicetree
Date:   Sat, 19 Nov 2022 15:36:55 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 19 Nov 2022 22:30:31 +1100, Ash Logan wrote:
> Adds schema for the various Wii U devicetree nodes used.
> 
> Signed-off-by: Ash Logan <ash@heyquark.com>
> ---
> v3->v4: Rework to match expected style and conciceness.
> 
>  .../bindings/powerpc/nintendo/wiiu.yaml       | 25 +++++++++
>  .../powerpc/nintendo/wiiu/espresso-pic.yaml   | 48 ++++++++++++++++
>  .../bindings/powerpc/nintendo/wiiu/gpu7.yaml  | 42 ++++++++++++++
>  .../powerpc/nintendo/wiiu/latte-ahci.yaml     | 50 +++++++++++++++++
>  .../powerpc/nintendo/wiiu/latte-dsp.yaml      | 35 ++++++++++++
>  .../powerpc/nintendo/wiiu/latte-pic.yaml      | 55 +++++++++++++++++++
>  .../powerpc/nintendo/wiiu/latte-sdhci.yaml    | 46 ++++++++++++++++
>  .../bindings/powerpc/nintendo/wiiu/latte.yaml | 31 +++++++++++
>  .../devicetree/bindings/usb/generic-ehci.yaml |  1 +
>  9 files changed, 333 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu.yaml
>  create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/espresso-pic.yaml
>  create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/gpu7.yaml
>  create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-ahci.yaml
>  create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-dsp.yaml
>  create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-pic.yaml
>  create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-sdhci.yaml
>  create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dtb: spba-bus@30000000: compatible:0: 'nintendo,latte' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dtb: bus@c0000000: compatible:0: 'nintendo,latte' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dtb: bus@c0000000: compatible: ['simple-bus'] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/baikal,bt1-apb.example.dtb: bus@1f059000: compatible:0: 'nintendo,latte' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/baikal,bt1-axi.example.dtb: bus@1f05a000: compatible:0: 'nintendo,latte' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.example.dtb: bus@100000: compatible:0: 'nintendo,latte' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.example.dtb: bus@100000: compatible: ['simple-bus'] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.example.dtb: bus@100000: compatible:0: 'nintendo,latte' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.example.dtb: bus@100000: compatible: ['simple-bus'] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.example.dtb: bus@28380000: compatible:0: 'nintendo,latte' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.example.dtb: bus@28380000: compatible: ['simple-bus'] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/fsl,vf610-dac.example.dtb: bus@40000000: compatible:0: 'nintendo,latte' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/stm32/st,mlahb.example.dtb: ahb@38000000: compatible:0: 'nintendo,latte' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/imx/fsl,aips-bus.example.dtb: bus@30000000: compatible:0: 'nintendo,latte' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/imx/imx8m-soc.example.dtb: soc@0: compatible:0: 'nintendo,latte' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.example.dtb: bus@80000000: compatible:0: 'nintendo,latte' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.example.dtb: bus@80000000: compatible: ['simple-bus'] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221119113041.284419-2-ash@heyquark.com

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

