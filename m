Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340EC6527D1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiLTUWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbiLTUVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:21:53 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07142387;
        Tue, 20 Dec 2022 12:21:53 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id m7-20020a9d6447000000b0066da0504b5eso7836241otl.13;
        Tue, 20 Dec 2022 12:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFQDaUujF8byQHWpFPWAzFnhuOpD56AeF/7WeQ42tZA=;
        b=Yk4n80h0aO0gJICs7+9OGWLkoSHbPaIIBHNdHUluwiq5/a5BOK/3m3ipTnpZcyzMiC
         mTtoStzIvlLQ4Ib7J6VWAGHecroc38G9qLR9Qh7bBu++i5NIt93uk6nqknD437IO/ocp
         xaitc1fp9JGW+atfvRYmze9p73FUiQO8G0HW8SkLN8O2lhPhDqoIpw0sq77wd0ALPv/e
         amed426I4lC3Jihk2vs4kjLtNacaEDfB+idfHSDCKZA4gYR0AWk8blNTqfSlQHW+nYYC
         qUFtNWLx4At8ulUo84VWX/laW1AWmIJlsYpKsTqNIChTBTmE65v/OagE/kD8NaVwNAvt
         cT/A==
X-Gm-Message-State: ANoB5pk7VQnNAODGgQBD9ckLygriLXwDt95+blSHjIvDTgJC3uV7LsXU
        YOIRkQyMHqPnRKo4pza+Bw==
X-Google-Smtp-Source: AA0mqf5jx4tKuMagJILHfkxT2AHgBM3GhosMHdWv0BYBkjW7e8PhYsE/EvELVZ7dufZDoev+gAd9FA==
X-Received: by 2002:a05:6830:564:b0:670:4588:f8c4 with SMTP id f4-20020a056830056400b006704588f8c4mr23705639otc.18.1671567712297;
        Tue, 20 Dec 2022 12:21:52 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j7-20020a9d7387000000b0066c3ca7b12csm6048869otk.61.2022.12.20.12.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 12:21:51 -0800 (PST)
Received: (nullmailer pid 1022017 invoked by uid 1000);
        Tue, 20 Dec 2022 20:21:50 -0000
Date:   Tue, 20 Dec 2022 14:21:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ben Dooks <ben.dooks@sifive.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v3 4/7] dt-bindings: sifive,ccache0: Support StarFive
 JH7110 SoC
Message-ID: <167156771008.1021954.965078236008496413.robh@kernel.org>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-5-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220011247.35560-5-hal.feng@starfivetech.com>
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


On Tue, 20 Dec 2022 09:12:44 +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> This cache controller is also used on the StarFive JH7110 SoC.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../devicetree/bindings/riscv/sifive,ccache0.yaml        | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
