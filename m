Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD2C5EFCF2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbiI2SWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiI2SWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:22:01 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592FE142E25;
        Thu, 29 Sep 2022 11:21:59 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-127dca21a7dso2757789fac.12;
        Thu, 29 Sep 2022 11:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=E1E+aVkZps6nOEgD+k57dmty/5orHNqHkP5Ys8i20lo=;
        b=CQT3EtS0HUYwJbX7+yFjdAUI7cLNVpTOjQuYGDMu6B25m/qulkf5oR3j2w0kxf23nc
         /WXvEF7qRQkdhgywv1ks79YQTjPXNwgwNIetv5iwUvyeUNDO/mN5e+3QcFgCGJfavvjd
         YsM7mXTQRVGmd2VN0ZTH6Qj+bE0MAALzsJjBPJGn2oa/ngxH42RKKZdZHl16NkQjIK/5
         t9S38kQyETISqRKpP8uSbVo8uZph970qSPm7IoFAcVyWg0U2BklymdVB9UuKViIvsk6+
         UxFpw06WS4cSrT+kTaXuGt3HweNwiSO+TXUdAQksEI+RBviH5atrtqzHQUDQ+Bih9tpT
         MHzA==
X-Gm-Message-State: ACrzQf2peakMSaXvcAvWDDPCsF0fXOzeHIRvDOT3rA2DmThfNKpxj8tF
        u5WC4AVZI1UTfo/ZhrkRvw==
X-Google-Smtp-Source: AMsMyM4PK1n2ewUg+rNJ24uv50FuD1odSQ6JC0CCIugoQsg1BgUKiJGYVAauz0ozKB3EAsP9iiimfg==
X-Received: by 2002:a05:6870:d0c1:b0:131:8c96:a1d with SMTP id k1-20020a056870d0c100b001318c960a1dmr8382943oaa.117.1664475718330;
        Thu, 29 Sep 2022 11:21:58 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h8-20020acab708000000b003511cab9cb1sm21121oif.19.2022.09.29.11.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 11:21:57 -0700 (PDT)
Received: (nullmailer pid 2518000 invoked by uid 1000);
        Thu, 29 Sep 2022 18:21:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hal Feng <hal.feng@linux.starfivetech.com>
Cc:     devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
In-Reply-To: <20220929175147.19749-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com> <20220929175147.19749-1-hal.feng@linux.starfivetech.com>
Message-Id: <166447556924.2514425.231552070734010562.robh@kernel.org>
Subject: Re: [PATCH v1 12/30] dt-bindings: reset: Add starfive,jh7110-reset bindings
Date:   Thu, 29 Sep 2022 13:21:56 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 01:51:47 +0800, Hal Feng wrote:
> Add bindings for the reset controller on the JH7110 RISC-V
> SoC by StarFive Technology Ltd.
> 
> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> ---
>  .../bindings/reset/starfive,jh7110-reset.yaml | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/starfive,jh7110-reset.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/reset/starfive,jh7110-reset.example.dts:18:18: fatal error: dt-bindings/reset/starfive-jh7110.h: No such file or directory
   18 |         #include <dt-bindings/reset/starfive-jh7110.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:384: Documentation/devicetree/bindings/reset/starfive,jh7110-reset.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1420: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

