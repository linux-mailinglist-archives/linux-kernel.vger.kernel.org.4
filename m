Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746326B9521
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjCNNCC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Mar 2023 09:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjCNNBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:01:45 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F58AB899;
        Tue, 14 Mar 2023 05:57:22 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id m6so1649345qvq.0;
        Tue, 14 Mar 2023 05:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678798263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQ85EN/5uYFja9HAgTN7gmUCNqF9DS+mPJS2DQU6bkg=;
        b=3RjCdfCLtplSGObvITNXIWUDsN7rwJhe6e3YqgPz1AMZAZFCWdhJwuWiiasMSraTtd
         TcgPvVU9w1zaI+nYtlwPb1QiunDVCr0eApm4V/RpJATMr1g0Yg9KOj8GbsonsSkGptUO
         APDaUFb3Rm8153RnfbBf8KN3/xAf7XYHTQ5v18rfnDxjJtvTmGu/ZEICvwbfSuOULkdD
         5wUS8L+SH5WcsZBkYZcos0mtbp0D/ZR5Mn07rvwP4gtvbzx4e3YOtWWEjU5rzPKW8vh3
         9lbeNk87lAxI1BDLoNSmFLP0pYnpD5Gh8yoi7n5218Dmpz26n80Xo9ByJYiXv5OiGZZ0
         NSHw==
X-Gm-Message-State: AO0yUKVdc5dNusT8z3n6qWMymSspTWTMbtK32MmaYQ3dHzxWhOED3ETR
        3bTDgpHqTfVezdyPFpU9nzhgK/lwh8BFsg==
X-Google-Smtp-Source: AK7set85FitrPer+ZpX0qiWEdR+DJqYIycx0ftgM3AR8mRQ82v0E4Pr8g5ofXY4U6cZ9lLAKL0n5tg==
X-Received: by 2002:a05:6214:1c87:b0:537:7d76:ea7c with SMTP id ib7-20020a0562141c8700b005377d76ea7cmr18538152qvb.25.1678798262768;
        Tue, 14 Mar 2023 05:51:02 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id s15-20020ac85ccf000000b003b0b903720esm1765318qta.13.2023.03.14.05.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 05:51:02 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-541a05e4124so115149717b3.1;
        Tue, 14 Mar 2023 05:51:02 -0700 (PDT)
X-Received: by 2002:a81:af48:0:b0:541:9b14:949e with SMTP id
 x8-20020a81af48000000b005419b14949emr5132457ywj.4.1678798261703; Tue, 14 Mar
 2023 05:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <3b6733f683c13ac02093206e76a3e30c7d045366.1678279668.git.geert+renesas@glider.be>
 <76456032-cc76-aede-f760-65cb999a2163@opensource.wdc.com>
In-Reply-To: <76456032-cc76-aede-f760-65cb999a2163@opensource.wdc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Mar 2023 13:50:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUiSZqyTvxCbWzvWmkjC47MepuWmTNd=x_xYGDZH3SZMw@mail.gmail.com>
Message-ID: <CAMuHMdUiSZqyTvxCbWzvWmkjC47MepuWmTNd=x_xYGDZH3SZMw@mail.gmail.com>
Subject: Re: [PATCH v2 resend 3] ahci: qoriq: Add platform dependencies
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Li Yang <leoyang.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damien,

On Tue, Mar 14, 2023 at 1:12 PM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
> On 3/8/23 21:49, Geert Uytterhoeven wrote:
> > The Freescale QorIQ AHCI SATA controller is only present on Freescale
> > Layerscape SoCs.  Add platform dependencies to the AHCI_QORIQ config
> > symbol, to avoid asking the user about it when configuring a kernel
> > without Layerscape support.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Acked-by: Li Yang <leoyang.li@nxp.com>
> > ---
> > v2:
> >   - Add Acked-by.
> > ---
> >  drivers/ata/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> > index b56fba76b43f48f7..42b51c9812a0ebab 100644
> > --- a/drivers/ata/Kconfig
> > +++ b/drivers/ata/Kconfig
> > @@ -276,6 +276,7 @@ config AHCI_XGENE
> >  config AHCI_QORIQ
> >       tristate "Freescale QorIQ AHCI SATA support"
> >       depends on OF
> > +     depends on SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
> >       select SATA_HOST
> >       help
> >         This option enables support for the Freescale QorIQ AHCI SoC's
>
> Do you want this in fixes or queuing this for 6.4 is fine ?

I guess 6.4 is fine. We've been seeing this message while configuring
our kernels for years, so a few extra weeks won't hurt ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
