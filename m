Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CE86C2C53
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCUI2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjCUI2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:28:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056F64491;
        Tue, 21 Mar 2023 01:28:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83DEA619BF;
        Tue, 21 Mar 2023 08:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EFEC4339B;
        Tue, 21 Mar 2023 08:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679387293;
        bh=CoOWB5m6DsId/z5WaBKhpXg+WFwSZORzhnSfYgGrajA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UsFCZnK+ldzABZuMk/PN22yEaiZnVYBIpPksijS5ZNIwZTCSgANuleuujci9lwHVZ
         M9Z0s8E0BmhEriEKc3YRxpebCE6GKKYoF6qr6pqQsCmhP18H52RR+/ot8tyuPRqJHu
         ns3IW9fRX79g7/efzc5I4gm2+5VZwRM5snanwdJfhrBELF7LWxPCPmf6CzHQ74gvX9
         nDfp2qZipUmdlhXmUfaH8RRzwAGoTndQ095sWbScw3iGZ9b5fXaLlAERd9KCorQtA+
         8mmViO4IslkvVQk7HR6njLKik+EpXHOeY33A3a1L5ugBk3jNuCPM5zaj+YX/OmK2O4
         7HOOxwTWsfd7Q==
Received: by mail-ot1-f50.google.com with SMTP id v17-20020a9d6051000000b0069a413e9cf6so8104360otj.3;
        Tue, 21 Mar 2023 01:28:13 -0700 (PDT)
X-Gm-Message-State: AO0yUKVzFOfsU+hYegOU9U3MNy/czqQNB2K9AUxXHCwhlIz47+cRdvea
        WkcKjKgK4X3C/Kgikyq3WVgFYZakTupb838+8OE=
X-Google-Smtp-Source: AK7set+xIFO1Ffs+pzsdRPHCvC6QdwrEOO/QPrSR2a/x52pa4JNUXT0IFNcgFvNQr9vzH8MBNGJJET7uyOeQUO+RE5Q=
X-Received: by 2002:a05:6830:3299:b0:688:d1a8:389e with SMTP id
 m25-20020a056830329900b00688d1a8389emr500571ott.1.1679387293218; Tue, 21 Mar
 2023 01:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-10-nick.alcock@oracle.com> <86y1onw02k.wl-maz@kernel.org>
 <Y/jyJFXqlj9DlX9z@bombadil.infradead.org> <86wn47vue1.wl-maz@kernel.org> <Y/kXDqW+7d71C4wz@bombadil.infradead.org>
In-Reply-To: <Y/kXDqW+7d71C4wz@bombadil.infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 21 Mar 2023 17:27:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAScmTeSXBXiFCOS+KU_LSgZjRD4GKRAcxVXHPtTxF7ewg@mail.gmail.com>
Message-ID: <CAK7LNAScmTeSXBXiFCOS+KU_LSgZjRD4GKRAcxVXHPtTxF7ewg@mail.gmail.com>
Subject: Re: [PATCH 09/27] irqchip: remove MODULE_LICENSE in non-modules
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Nick Alcock <nick.alcock@oracle.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 4:59=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> On Fri, Feb 24, 2023 at 05:35:34PM +0000, Marc Zyngier wrote:
> > On Fri, 24 Feb 2023 17:21:40 +0000,
> > Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Fri, Feb 24, 2023 at 03:32:51PM +0000, Marc Zyngier wrote:
> > > > On Fri, 24 Feb 2023 15:07:53 +0000,
> > > > Nick Alcock <nick.alcock@oracle.com> wrote:
> > > > >
> > > > > Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> > > > > Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declaratio=
ns
> > > > > are used to identify modules. As a consequence, uses of the macro
> > > > > in non-modules will cause modprobe to misidentify their containin=
g
> > > > > object file as a module when it is not (false positives), and mod=
probe
> > > > > might succeed rather than failing with a suitable error message.
> > > > >
> > > > > So remove it in the files in this commit, none of which can be bu=
ilt as
> > > > > modules.
> > > > >
> > > > > Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> > > > > Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> > > > > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > > > > Cc: linux-modules@vger.kernel.org
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > > > > ---
> > > > >  drivers/irqchip/irq-renesas-rzg2l.c | 1 -
> > > > >  1 file changed, 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchi=
p/irq-renesas-rzg2l.c
> > > > > index 25fd8ee66565..4bbfa2b0a4df 100644
> > > > > --- a/drivers/irqchip/irq-renesas-rzg2l.c
> > > > > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > > > > @@ -390,4 +390,3 @@ IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irq=
c_init)
> > > > >  IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)
> > > > >  MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesa=
s.com>");
> > > > >  MODULE_DESCRIPTION("Renesas RZ/G2L IRQC Driver");
> > > > > -MODULE_LICENSE("GPL");
> > > >
> > > > I'm probably missing some context here, but I find it odd to drop
> > > > something that is a important piece of information because of what
> > > > looks like a tooling regression.
> > > >
> > > > It also means that once a random driver gets enabled as a module, i=
t
> > > > won't load because it is now missing a MODULE_LICENSE() annotation.
> > > >
> > > > It feels like MODULE_LICENSE should instead degrade to an empty
> > > > statement when MODULE isn't defined. Why isn't this approach the
> > > > correct one?
> > > >
> > > > I expect the cover letter would have some pretty good information o=
n
> > > > this, but lore.kernel.org doesn't seem to have it at the time I wri=
te
> > > > this ("Message-ID <20230224150811.80316-1-nick.alcock@oracle.com> n=
ot
> > > > found").
> > >
> > > The right thing is to not even have this and have the module license
> > > inferred from the SPDX tag. But for now we want to remove the tag fro=
m
> > > things we know for sure are not modules.
> >
> > I understand that you want to remove it. I don't get why this is the
> > right solution. Can you please assume that, in this particular
> > instance, I am a complete idiot and spell it out for me?
> >
> > Why isn't that a problem for modules that are compiled-in?
>
> Modules that are compiled in should succeed with a modprobe call as its
> already loaded. The construct we're looking for is a way to detect
> things which are built-in but *could* be modules. The annotation today
> is done at build time for something built-in using a file path using
> modinfo.




Why is it important to make "modprobe irq-renesas-rza1" fail?

With CONFIG_RENESAS_RZA1_IRQC=3Dy, "modprobe irq-renesas-rza1"
exits with 0.
I do not think it is a big deal since irq-renesas-rza1
is available as built-in.









--=20
Best Regards
Masahiro Yamada
