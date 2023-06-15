Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531E273215F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjFOVLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjFOVLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:11:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2759270B;
        Thu, 15 Jun 2023 14:11:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A481615E1;
        Thu, 15 Jun 2023 21:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F257BC433C8;
        Thu, 15 Jun 2023 21:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686863481;
        bh=f6BYmxI2Iwx1LZlCng+4zSURb7GTNwhasqaqeXVlWf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GHTCVJEIu6LhXPV9s0x+KkfdfV98v69zWe5KEpbttJysjY6GWvAWAF6/BtMXiVhfX
         U44FXJOqjdYxW5iV2Ro3IQ7wF/+OHqPnzl0fi/WDkGXm1ZikWx8p8nmc1VpFnXsCDN
         HHvu74jqHLEWuzsm1xpFfw/5OcRXiDGqnagBJ4jcPf/g7STSaRON70Plib3Ky+r9qh
         G3+M04ZMHqR3zBFWlkOsDNoiwmY9RPWOWr/N4XjL+d/4Nbp/jYwzwWrgIIRPwKg2VZ
         RCDbGs5TxMRGfEf1KMJhJmvFfOwcygPwl9al+o2/08G+MOF3fLRG+ggqec77CdnyG4
         X3wajSCxleQ3g==
Date:   Thu, 15 Jun 2023 22:11:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v4 08/10] irqchip: Add RISC-V advanced PLIC driver
Message-ID: <20230615-contempt-crave-00d80f3cb369@spud>
References: <20230613153415.350528-1-apatel@ventanamicro.com>
 <20230613153415.350528-9-apatel@ventanamicro.com>
 <CAGETcx-hoPNanAwe4++6roqBXwSdc7z6Ei=-r9z6qFG1U7xVXg@mail.gmail.com>
 <20230615-thyself-doornail-f0545ada9176@spud>
 <CAGETcx__Qt868abh-F_fu7ijMSWXciLjdjWiWf60e4_p78xb8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5MO7euHf3MkXTMTS"
Content-Disposition: inline
In-Reply-To: <CAGETcx__Qt868abh-F_fu7ijMSWXciLjdjWiWf60e4_p78xb8w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5MO7euHf3MkXTMTS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 01:45:55PM -0700, Saravana Kannan wrote:
> On Thu, Jun 15, 2023 at 12:31=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> > On Thu, Jun 15, 2023 at 12:17:08PM -0700, Saravana Kannan wrote:
> > > On Tue, Jun 13, 2023 at 8:35=E2=80=AFAM Anup Patel <apatel@ventanamic=
ro.com> wrote:
> >
> > btw, please try to delete the 100s of lines of unrelated context when
> > replying
>=20
> I always feel like some people like me to do this and others don't.
> Also, at times, people might want to reference the other lines of code
> when replying to my point. That's why I generally leave them in.

Yah, perhaps I cull too aggressively but there's a middle ground ;)

> > > > +static int __init aplic_dt_init(struct device_node *node,
> > > > +                               struct device_node *parent)
> > > > +{
> > > > +       /*
> > > > +        * The APLIC platform driver needs to be probed early
> > > > +        * so for device tree:
> > > > +        *
> > > > +        * 1) Set the FWNODE_FLAG_BEST_EFFORT flag in fwnode which
> > > > +        *    provides a hint to the device driver core to probe the
> > > > +        *    platform driver early.
> > > > +        * 2) Clear the OF_POPULATED flag in device_node because
> > > > +        *    of_irq_init() sets it which prevents creation of
> > > > +        *    platform device.
> > > > +        */
> > > > +       node->fwnode.flags |=3D FWNODE_FLAG_BEST_EFFORT;
> > >
> > > NACK. You are blindly plastering flags without trying to understand
> > > the real issue and fixing this correctly.
> > >
> > > > +       of_node_clear_flag(node, OF_POPULATED);
>=20
> Also, this part is not needed if the macros I mentioned below are used.
>=20
> > > > +       return 0;
> > > > +}
> > > > +IRQCHIP_DECLARE(riscv_aplic, "riscv,aplic", aplic_dt_init);
> > >
> > > This macro pretty much skips the entire driver core framework to probe
> > > and calls init and you are supposed to initialize the device when the
> > > init function is called.
> > >
> > > If you want your device/driver to follow the proper platform driver
> > > path (which is recommended), then you need to use the
> > > IRQCHIP_PLATFORM_DRIVER_BEGIN() and related macros. Grep for plenty o=
f examples.
> > >
> > > I offered to help you debug this issue and I asked for a dts file that
> > > corresponds to a board you are testing this on and seeing an issue.
> >
> > There isn't a dts file for this because there's no publicly available
> > hardware that actually has an APLIC. Maybe Ventana have pre-production
> > silicon that has it, but otherwise it's a QEMU job.
>=20
> 1. QEMU example is fine too if it can be reproduced. I just asked for
> a dts file because I need the full global view of the dependencies. At
> a minimum, I'd at least expect to see some example DT and explanation
> of what dependency is causing the IRQ device to not be initialized on
> time, etc. Instead I just see random uses of flags with no description
> of the actual issue.

It's Anup's responsibility to provide you with that information, I have
not reproduced this issue, so I won't mislead you with QEMU invocations
that may not be what's required to reproduce.

> 2. If it's not a dts available upstream, why should these drivers be
> accepted? I thought the norm was to only accept drivers that can
> actually be used.

I think it's not unusual (and desirable?) to start the upstreaming
process for stuff before hardware is publicly available, so that once it
is, support is already upstream, or close to. I do know that people have
tested this series in FPGA based hardware emulation platforms etc.
Posting patches for it also helps avoid duplication of effort between
the various vendors in RISC-V land, who would otherwise have to write
their own drivers. Also, the documented RISC-V policy for accepting
support for ISA stuff says:
	We'll only accept patches for new modules or extensions if the
	specifications for those modules or extensions are listed as being
	unlikely to be incompatibly changed in the future.  For
	specifications from the RISC-V foundation this means "Frozen"
	(Documentation/riscv/patch-acceptance.rst)
AIA (the spec behind the APLIC/IMSIC) is frozen, and qualifies from a
RISC-V point of view. What Marc is willing to accept, in terms of
pre-production hardware support, is up to him obviously!

Cheers,
Conor.

> > > But you haven't answered my question [1] and are pointing to some
> > > random commit and blaming it. That commit has no impact on any
> > > existing devices/drivers.
> > >
> > > Hi Marc,
> > >
> > > Please consider this patch Nacked as long as FWNODE_FLAG_BEST_EFFORT
> > > is used or until Anup actually works with us to debug the real issue.
> > >
> > > -Saravana
> > > [1] - https://lore.kernel.org/lkml/CAAhSdy2p6K70fc2yZLPdVGqEq61Y8F7WV=
T2J8st5mQrzBi4WHg@mail.gmail.com/

--5MO7euHf3MkXTMTS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIt+cwAKCRB4tDGHoIJi
0nnEAQDxEIRFIDNPXvGHgVa6uRz9xO4r9whJObzgPApSdQr3JQEAiDafcQs0Dg4D
mLy/wkW8n6yrfsnZXbQAnV2HcunXtQQ=
=/2YI
-----END PGP SIGNATURE-----

--5MO7euHf3MkXTMTS--
