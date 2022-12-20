Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9357065279B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbiLTUMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLTUMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:12:47 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEB81ADBA;
        Tue, 20 Dec 2022 12:12:46 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id o66so10116672oia.6;
        Tue, 20 Dec 2022 12:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruopfQWSYHKaRdGSAx7Dg/pS9EkvkCSETDa10WdoTt4=;
        b=2bTW2RR8pAIrPTLi3Ba5VyPQnyhSjy7PVQPEYx7fTzPS7j/mg+ul4BkPdyOhlcR5cl
         nf2gH0l8fHB6bDrdW42khKfufp7Mnb2pmz0Ypx5poZ51vSX3BbeN48YXgdpeOC9p6qo0
         n/0OjC/Zx6eXqGHisRykAqc76WK3keprk0eMmxEGG7PF36+BSRBx4XdjMg8ehGKk0tZs
         qcs51LtSVxywBffFUgfn9yIFPN9EB/kcUqULOHt3jgd5ysubMVRKd8ReZGbfbw1heyPp
         98mDKCB5i6n3cHjR98OxwHKCZuBuH4b/7SXkFFONjYgqoabhqGN7xEUfa5XtdvZeqIKS
         r2aA==
X-Gm-Message-State: ANoB5plmC41HTsM6ugwi5Lh28cavP7sudB9ymV0s+uwBmQzWPyW6laKW
        QO8g+ifGrBqWyDpm/1tIJQ==
X-Google-Smtp-Source: AA0mqf4cugXCw45dIuigYdKqlbQQdxQ6XRRSh82vk1TcCXWrfOyDbAEW0xr/gJePiBZs+Vqyjbs6+A==
X-Received: by 2002:a05:6808:1719:b0:35b:e443:e5d0 with SMTP id bc25-20020a056808171900b0035be443e5d0mr25143898oib.17.1671567166187;
        Tue, 20 Dec 2022 12:12:46 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q124-20020aca5c82000000b003509cc4ad4esm5872301oib.39.2022.12.20.12.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 12:12:45 -0800 (PST)
Received: (nullmailer pid 1009718 invoked by uid 1000);
        Tue, 20 Dec 2022 20:12:44 -0000
Date:   Tue, 20 Dec 2022 14:12:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v3 07/11] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Message-ID: <167156716420.1009655.13780070128515127974.robh@kernel.org>
References: <20221220005054.34518-1-hal.feng@starfivetech.com>
 <20221220005054.34518-8-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220005054.34518-8-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Dec 2022 08:50:50 +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Add bindings for the system clock and reset generator (SYSCRG) on the
> JH7110 RISC-V SoC by StarFive Ltd.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../clock/starfive,jh7110-syscrg.yaml         |  80 +++++++
>  MAINTAINERS                                   |   8 +-
>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 207 ++++++++++++++++++
>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 142 ++++++++++++
>  4 files changed, 434 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
>  create mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
>  create mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
