Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E294623DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiKJIsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKJIss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:48:48 -0500
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C1C64C5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:48:47 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso5372908pjn.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:48:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nj08uoQ5xO490n/iqA+9r1f6MFaSsf/Keu+IuBN/mxc=;
        b=XpWP41kpmjmKSXKjFlnut5G83rx7+c/MCBMXktRV4IH/ufCROPotCD24wgCsTI4RSV
         xqUWCzSixmsCdU1BkrPhveGZN1QWzaz84G4AkbQ1wrvtFPxCC+KPn3nJ+E8ugRLcdJPp
         6ijjpOx838o86OGpfmxKFecwSQyjsuqCDTfDFHySES7MlGc6pgbMAihOckZJa14N3+yL
         h9VDRPvvgYpptXNDI1Qoyo5DMJTnSpX3LHd/Mew31R1UpV9MTPPT0FTg3/PSfcL+Xv6G
         HcVqWSTpC0VQTa62nGuL+Y2lNvSqGol/gd6qILqEDo+F7myPTDLnEPeMQzf9J2jGERi4
         UjgA==
X-Gm-Message-State: ACrzQf2doMGauvkhmJMo6tQg9sdKx07rtCBtpbXiHig3NXOCQ0qCsqSk
        vXrz0bVCM60ON2puT+QC1mIlmoZZdBmyvCJ2ms0=
X-Google-Smtp-Source: AMsMyM4/rxvFp8pqfGwJZsdJimYqWfkYUSxbisV3VoouRxT16X9f1iy+9n4YEmJzxdp6jMr+BSNbJGOtj09Hk7fZsyc=
X-Received: by 2002:a17:90a:c917:b0:20a:a1a8:3719 with SMTP id
 v23-20020a17090ac91700b0020aa1a83719mr1301526pjt.225.1668070126727; Thu, 10
 Nov 2022 00:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20221109212219.1598355-1-conor@kernel.org> <20221109212219.1598355-4-conor@kernel.org>
In-Reply-To: <20221109212219.1598355-4-conor@kernel.org>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Thu, 10 Nov 2022 09:48:35 +0100
Message-ID: <CANBLGcx6HM=G+PCth8Pg75zuHrQpF5M2HUNdr849ac4ZsbXu0A@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] MAINTAINERS: add an entry for StarFive devicetrees
To:     Conor Dooley <conor@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nicolas Ferre <nicolas.ferre@microchip.com>, soc@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2022 at 22:23, Conor Dooley <conor@kernel.org> wrote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Emil looks after the downstream StarFive stuff, and agreed to look after
> the upstream ones too.
>
> CC: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Thanks!

Acked-by: Emil Renner Berthing <kernel@esmil.dk>

> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a57c90be001f..040d49af9bdb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19622,6 +19622,11 @@ M:     Ion Badulescu <ionut@badula.org>
>  S:     Odd Fixes
>  F:     drivers/net/ethernet/adaptec/starfire*
>
> +STARFIVE DEVICETREES
> +M:     Emil Renner Berthing <kernel@esmil.dk>
> +S:     Maintained
> +F:     arch/riscv/boot/dts/starfive/
> +
>  STARFIVE JH7100 CLOCK DRIVERS
>  M:     Emil Renner Berthing <kernel@esmil.dk>
>  S:     Maintained
> --
> 2.37.2
>
