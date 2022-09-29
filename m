Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457C05EFD2C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbiI2Skk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbiI2Skh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:40:37 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE629A4B00;
        Thu, 29 Sep 2022 11:40:36 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id u3-20020a4ab5c3000000b0044b125e5d9eso701311ooo.12;
        Thu, 29 Sep 2022 11:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JUknpPDEYJa9Cq2iz50zjd2tB2wnF+7kU0AIJz4j5e0=;
        b=Yytm68gdwfQobn5DR7aKeQcPNb38dEoNvrv3YQf5W0nJ7+AX1lrPB013woBZpYn7a+
         +yclmLcK7YavyJ+YGYUDnUmJKk8gA2q7hXCMs5/dY/bHaMpAYFLcZ2zfHItKxNDqFRgF
         ABoXLcjbE+UzZ5bmTRym9pZkyNCiMSCbgzwUbn3fTeJPIAyWBE6faDbwo42AYicyt0gz
         9CwNuw0y5dvpA4LgJtBAW5vePwDYAoa2NY2JxerFrcFjke1ivzU9UAndhxl6bq0u/2R3
         UQrwoHpF5wuDjD0gdKk7D0kN82uOdMLtPzL8nUxnFodesIScvSGOntaWlNu237Lbzz8C
         g87A==
X-Gm-Message-State: ACrzQf1O/JAGRKI8zmyU0muvvOwD6Psz/iM/WeYPrngQ3mgs+7GoGl+Z
        CHc7p90isQUebhWxbc+yJe2+I3ec8g==
X-Google-Smtp-Source: AMsMyM6Qwd/fCldskNnRa938IC4Gy8WNyKg9DAcQiW8XIA6ZypiOLor4C+h5FDq8rJOyuTG7W+BVJw==
X-Received: by 2002:a9d:6258:0:b0:655:f63e:8e6d with SMTP id i24-20020a9d6258000000b00655f63e8e6dmr2033084otk.166.1664476836064;
        Thu, 29 Sep 2022 11:40:36 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 188-20020aca06c5000000b0034d14c6ce3dsm31215oig.16.2022.09.29.11.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 11:40:35 -0700 (PDT)
Received: (nullmailer pid 2551224 invoked by uid 1000);
        Thu, 29 Sep 2022 18:40:33 -0000
Date:   Thu, 29 Sep 2022 13:40:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hal Feng <hal.feng@linux.starfivetech.com>
Cc:     devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: Re: [PATCH v1 12/30] dt-bindings: reset: Add starfive,jh7110-reset
 bindings
Message-ID: <20220929184033.GA2539242-robh@kernel.org>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220929175147.19749-1-hal.feng@linux.starfivetech.com>
 <166447556924.2514425.231552070734010562.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166447556924.2514425.231552070734010562.robh@kernel.org>
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

On Thu, Sep 29, 2022 at 01:21:56PM -0500, Rob Herring wrote:
> On Fri, 30 Sep 2022 01:51:47 +0800, Hal Feng wrote:
> > Add bindings for the reset controller on the JH7110 RISC-V
> > SoC by StarFive Technology Ltd.
> > 
> > Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> > ---
> >  .../bindings/reset/starfive,jh7110-reset.yaml | 54 +++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/reset/starfive,jh7110-reset.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/reset/starfive,jh7110-reset.example.dts:18:18: fatal error: dt-bindings/reset/starfive-jh7110.h: No such file or directory
>    18 |         #include <dt-bindings/reset/starfive-jh7110.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.lib:384: Documentation/devicetree/bindings/reset/starfive,jh7110-reset.example.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1420: dt_binding_check] Error 2

Looks to be because this series got moderated and came in waves. In any 
case, patches 11 and 12 can be combined. Same for any other bindings and 
binding headers.

Rob
