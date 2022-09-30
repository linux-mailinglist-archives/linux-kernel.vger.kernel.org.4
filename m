Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5FC5F0B7E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiI3MQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiI3MQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:16:12 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA484FA5CD;
        Fri, 30 Sep 2022 05:16:11 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id s125so4558782oie.4;
        Fri, 30 Sep 2022 05:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/065kmeBBgsqY7mGeD3pqFv3I0PvMxNoHX9Ksgu7T30=;
        b=JyzJCVz73FgcN7dYX8jnpCBfyrhrvb2it2F7+L60CISc5XbpaC0clCDw0x/6k5DUKZ
         JqYt7JG9OpAe7JwdsYFP/V/iXzEhhAIjiiScAQ3kLR+Enw4N3y81gMjh/3woZOSA36f+
         3jt8RB9uep8MiZJt0T/qoxIFe7JnRIjU4UCKPqUEpCpRmqUqDPjJsw5qcro/ZQVkjvPd
         Nt9Gzo/97O7Oqzv731HBNc5P3RqDuLvPV/pSoeJNKJQ6r9iOsZFcq6VZt6DhYtVTwL1z
         S5GYKCUo0wCM2N5PC1Cy9vg0TCMkZw4Hbo/uhZLnZ40NDdJiijB+nNo6cXeIyAslQX+p
         YAAA==
X-Gm-Message-State: ACrzQf3rFirtq1oCZp5AYleTXGMiqzqNhiqbBnuwLY+V0cz7OYCnrCuO
        lTsA8PKmw2IA4Huo0exOVw==
X-Google-Smtp-Source: AMsMyM6b4kW54HB8pp5Pi4ELHpIa42H84Xw0SVjZrdV7SOwG2N+Q7jofwCOuam7R8btNT4qq0a1f4A==
X-Received: by 2002:a05:6808:1a87:b0:34f:67aa:5089 with SMTP id bm7-20020a0568081a8700b0034f67aa5089mr9184129oib.108.1664540170945;
        Fri, 30 Sep 2022 05:16:10 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m18-20020a056870889200b0012d939eb0bfsm580825oam.34.2022.09.30.05.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 05:16:10 -0700 (PDT)
Received: (nullmailer pid 58498 invoked by uid 1000);
        Fri, 30 Sep 2022 12:16:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hal Feng <hal.feng@linux.starfivetech.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-clk@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org
In-Reply-To: <20220930073845.6309-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com> <20220930073845.6309-1-hal.feng@linux.starfivetech.com>
Message-Id: <166453971800.15128.2899761905092626256.robh@kernel.org>
Subject: Re: [PATCH v1 25/30] dt-bindings: pinctrl: Add StarFive JH7110 pinctrl bindings
Date:   Fri, 30 Sep 2022 07:16:09 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 15:38:45 +0800, Hal Feng wrote:
> From: Jianlong Huang <jianlong.huang@starfivetech.com>
> 
> Add pinctrl bindings for StarFive JH7110 SoC.
> 
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> ---
>  .../pinctrl/starfive,jh7110-pinctrl.yaml      | 202 ++++++++++++++++++
>  1 file changed, 202 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh7110-pinctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pinctrl/starfive,jh7110-pinctrl.yaml:18:5: [warning] wrong indentation: expected 6 but found 4 (indentation)
./Documentation/devicetree/bindings/pinctrl/starfive,jh7110-pinctrl.yaml:49:5: [warning] wrong indentation: expected 6 but found 4 (indentation)

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/pinctrl/starfive,jh7110-pinctrl.yaml: error checking schema file
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-pinctrl.yaml: ignoring, error in schema: patternProperties: -[0-9]+$: patternProperties: -pins$: properties: starfive,pinmux
Documentation/devicetree/bindings/pinctrl/starfive,jh7110-pinctrl.example.dts:21:18: fatal error: dt-bindings/clock/starfive-jh7110-sys.h: No such file or directory
   21 |         #include <dt-bindings/clock/starfive-jh7110-sys.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:384: Documentation/devicetree/bindings/pinctrl/starfive,jh7110-pinctrl.example.dtb] Error 1
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

