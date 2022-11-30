Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FE263D711
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 14:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiK3Nrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 08:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiK3Nrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:47:37 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43AEF1C;
        Wed, 30 Nov 2022 05:47:36 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id w26-20020a056830061a00b0066c320f5b49so11213922oti.5;
        Wed, 30 Nov 2022 05:47:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pwsp0BCLF4G1JEdG9NKeOCGZGdSktiRv5CDdT5GJHns=;
        b=fz+VpeeTY3xMaD9ucvIdEKcZlmoTMWDzsH5k6+nUXPpXKt+B/Tq83cL3SCcP6MF8lR
         YdbRBra23IqNUHmSm+OeMv9hMZK50Aw+isqZnszeIFWZJLMBQ45A507MYM1VbJJclk13
         9ph+fWnxn+H0kSgPuBTpZpBLdCvQOqDYVl4wmDi75f0MHxjm4B3YdSZUy+NoUXLtAehc
         POtbeNGjivq9jRPpYEln66G0Bluow3ufxsfogvJEI/d1poHE39BtAXX8ML1fIQlYUyZq
         8B0jQ4aslE6eMrRioWUp2JbG2bDnNc+HjkKdrimb0gNgz2YF3NGGiFkUF/7TjgGmrWOJ
         NLjg==
X-Gm-Message-State: ANoB5plNKwW4K/uQhhH6bGHAelcor2WF5FAjdDP053T/MV6VbXgjv+M0
        khqPqHakqEUEdQQvuMdXt37/f/5dJQ==
X-Google-Smtp-Source: AA0mqf4Iea2320DugkNny8LrmH5N7sAE+JXLN+W1/nvbJiY+HXtFU/iorCneJYuX2wvnDbjwB21NAA==
X-Received: by 2002:a05:6830:1048:b0:661:b7d1:e4dc with SMTP id b8-20020a056830104800b00661b7d1e4dcmr24091673otp.80.1669816055951;
        Wed, 30 Nov 2022 05:47:35 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b19-20020a056870391300b00142fa439ee5sm1164346oap.39.2022.11.30.05.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 05:47:35 -0800 (PST)
Received: (nullmailer pid 1848608 invoked by uid 1000);
        Wed, 30 Nov 2022 13:47:34 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     linux-crypto@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
In-Reply-To: <20221130055214.2416888-6-jiajie.ho@starfivetech.com>
References: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
 <20221130055214.2416888-6-jiajie.ho@starfivetech.com>
Message-Id: <166981596611.1846501.537832446745968339.robh@kernel.org>
Subject: Re: [PATCH 5/6] dt-bindings: crypto: Add bindings for Starfive crypto driver
Date:   Wed, 30 Nov 2022 07:47:34 -0600
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


On Wed, 30 Nov 2022 13:52:13 +0800, Jia Jie Ho wrote:
> Add documentation to describe Starfive crypto
> driver bindings.
> 
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
> ---
>  .../bindings/crypto/starfive-crypto.yaml      | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/starfive-crypto.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/crypto/starfive-crypto.example.dts:21:18: fatal error: dt-bindings/clock/starfive-jh7110.h: No such file or directory
   21 |         #include <dt-bindings/clock/starfive-jh7110.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/crypto/starfive-crypto.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221130055214.2416888-6-jiajie.ho@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

