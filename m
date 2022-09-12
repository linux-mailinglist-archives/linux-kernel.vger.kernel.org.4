Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298E95B5D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 17:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiILPio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 11:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiILPi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:38:26 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F12B3A480;
        Mon, 12 Sep 2022 08:38:19 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-127d10b4f19so24355989fac.9;
        Mon, 12 Sep 2022 08:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ue5+8/4Z71n3Nrmg6TnLNQBJaXC6YNsHlRdeTE9cIOw=;
        b=BvIED5P0M7pRnCjtkp4BCIMmQEQgGBhX7LMqzTibN96F3ozt8MEfbvAMchjeHL94Hf
         mup4e7K2BcdIxQKygziC96fLCeTfy4eQW3fuztVaPI4lNHcbkDpSZPhFAwrT4kn5nYkY
         lDSfz6oBgqJffmLSftybVpmqEGrHo/bmn1N9uvvVN7za3mzVKugIOfwFHORqnBdhPqLG
         F/foeai3lO6zM5R/pt0Yxoq+LiTcIbn6QBFn1u/3BzMCOm4ytu9HkYQ+63voMr+JibAe
         01YwMtConOWSjYAC70hiOLRp2ipCKLLO4kjNapwQTycATSP3vr0kDQ18lWZqpJaAlo3v
         RbGw==
X-Gm-Message-State: ACgBeo1s7Nd0rw+Vh/CgPtCyImnMyAZ+AiXZh1SG1YnwmbPArSqQMzjM
        zl6Zu/QbKNzBRy4DNHQ9pUbKfEdrfw==
X-Google-Smtp-Source: AA6agR6n3DSb9xUgLRcRbKhwivurhynUDDVjmTeX6O7CHqyg1n89IULhSIOrP+7F/hsB9IU57kf5uw==
X-Received: by 2002:a05:6870:5804:b0:12a:f192:27de with SMTP id r4-20020a056870580400b0012af19227demr10946429oap.224.1662997097718;
        Mon, 12 Sep 2022 08:38:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 5-20020a9d0d85000000b0063975d170a8sm4736517ots.7.2022.09.12.08.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 08:38:17 -0700 (PDT)
Received: (nullmailer pid 1345588 invoked by uid 1000);
        Mon, 12 Sep 2022 15:38:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Martyn Welch <martyn.welch@collabora.co.uk>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20220912102223.1050418-2-martyn.welch@collabora.co.uk>
References: <20220912102223.1050418-1-martyn.welch@collabora.co.uk> <20220912102223.1050418-2-martyn.welch@collabora.co.uk>
Subject: Re: [PATCH v3 2/5] dt-bindings: gpio: pca95xx: add entry for pcal6534 and PI4IOE5V6534Q
Date:   Mon, 12 Sep 2022 10:38:15 -0500
Message-Id: <1662997095.488928.1345587.nullmailer@robh.at.kernel.org>
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

On Mon, 12 Sep 2022 11:22:19 +0100, Martyn Welch wrote:
> From: Martyn Welch <martyn.welch@collabora.com>
> 
> The NXP PCAL6534 is a 34-bit I2C I/O expander similar to the PCAL6524. The
> Diodes PI4IOE5V6534Q is a functionally identical chip provided by Diodes
> Inc.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> 
> Changes in v2:
>  - Enumerate pi4ioe5v6534q as requiring pcal6534 fallback
> 
> Changes in v3:
>  - Corrected indentation
> 
>  .../bindings/gpio/gpio-pca95xx.yaml           | 98 ++++++++++---------
>  1 file changed, 52 insertions(+), 46 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml:24:13: [warning] wrong indentation: expected 14 but found 12 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

