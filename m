Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F285F14D8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiI3V2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiI3V2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:28:41 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD62910B20C;
        Fri, 30 Sep 2022 14:28:40 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-13207a86076so2635473fac.3;
        Fri, 30 Sep 2022 14:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=S7CiI3WwjpNrhXvdHD1dIIAHLPRZYnaexnei+ztfM3I=;
        b=hsZOOLsH1HRuTe7gYB1pMBoe14QpOLsOu1uvy5ecUR8Wmen7qJ40sC0gbm4rE9CCzU
         QMdOzDPoFaJX2gcYPHUCECahulVSL1uJQTfo9R5fuH+rW0gZBJMxbHriWu6i4/C1JVaw
         owsF+aKmEoHpE+PAaxxTvtTyI+n4m2pQdMH4Tv0WM4cckxjvoMWpceUE79f+Oe4tvADn
         iouONup8tfmHDxd9fSXTSVde3E8T1+GuqkOuQTvlvHtcZe8A6ORis1rVvJBXmIjEXJsf
         ftZQNNAvmMdIBsRiMb6I/HyR80fxApLLjbp4l7uXOekCKTflS5iTN9BaKBMDdogn9w5r
         0d2w==
X-Gm-Message-State: ACrzQf26rSOAUodcqdQ58+RDdy/6Y6FdHld4KuXh/VzoBzl3SkFTwGcu
        JLfVih+JcBQf3vq7eQQfiw==
X-Google-Smtp-Source: AMsMyM5bcRhjaYikR+Xk6ykHgQ5zOQndbLZNNrB7CLNt2bq/KWaPcLT0xLBWvFaWjME3DkVdHURUeg==
X-Received: by 2002:a05:6871:689:b0:12c:52be:94f6 with SMTP id l9-20020a056871068900b0012c52be94f6mr93380oao.214.1664573319960;
        Fri, 30 Sep 2022 14:28:39 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u43-20020a056808152b00b0034f937c50fasm748202oiw.49.2022.09.30.14.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 14:28:39 -0700 (PDT)
Received: (nullmailer pid 1076968 invoked by uid 1000);
        Fri, 30 Sep 2022 21:28:37 -0000
Date:   Fri, 30 Sep 2022 16:28:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hal Feng <hal.feng@linux.starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v1 23/30] pinctrl: starfive: Rename "pinctrl-starfive" to
 "pinctrl-starfive-jh7100"
Message-ID: <166457324093.1075476.18009315584754055366.robh@kernel.org>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220930061404.5418-1-hal.feng@linux.starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930061404.5418-1-hal.feng@linux.starfivetech.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 14:14:04 +0800, Hal Feng wrote:
> From: Jianlong Huang <jianlong.huang@starfivetech.com>
> 
> Add the SoC name to make it more clear. Also the next generation StarFive
> SoCs will use "pinctrl-starfive" as the core of StarFive pinctrl driver.
> No functional change.
> 
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> ---
>  .../bindings/pinctrl/starfive,jh7100-pinctrl.yaml           | 2 +-
>  arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts   | 2 +-
>  drivers/pinctrl/starfive/Kconfig                            | 2 +-
>  drivers/pinctrl/starfive/Makefile                           | 2 +-
>  .../{pinctrl-starfive.c => pinctrl-starfive-jh7100.c}       | 2 +-
>  .../{pinctrl-starfive.h => pinctrl-starfive-jh7100.h}       | 6 +++---
>  6 files changed, 8 insertions(+), 8 deletions(-)
>  rename drivers/pinctrl/starfive/{pinctrl-starfive.c => pinctrl-starfive-jh7100.c} (99%)
>  rename include/dt-bindings/pinctrl/{pinctrl-starfive.h => pinctrl-starfive-jh7100.h} (98%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

Would be good to pull this out separately and apply for 6.1. It's kind 
of messy with cross tree dependencies.

