Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD3668B8D1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjBFJjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjBFJju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:39:50 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F012E11674;
        Mon,  6 Feb 2023 01:39:47 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 68028240002;
        Mon,  6 Feb 2023 09:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675676386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AubTcWOYqSxJt7Wh6bP1/DqkOsNeNYXj8kBwWyYv++A=;
        b=lkoOheG4wX9oGM+5NpVS2+5pvUbY5At5ACfEIBMm6y+lcmVVBjbgHKvJC6NqPSpWErCPyf
        QKY83Q/7p9AN5K3I8dR98yGB+RNuCJYrkGDO4HA+kfcRiewe9KrdZdiHIiwyezVQwSQygI
        Lwnb3WRZiEu0xfftHuFvd2dAHEsKBAuAjoTpgvABwVnCQ89X0CnhAaER2B8p7ZUCt6ITHk
        yV7Cmtt9Dy1iQ41jZjEcYEqGt1BWaljAAD+ThVmw3RRjYvCFVC6Fs5apc/Yd5RDIwz5W0f
        UPQ/UQJG8jYoPZPZm9CyGMxcIl3GrqLg8XuO4bEQzSUmcSGIvr+bIs6TVeReYQ==
Date:   Mon, 6 Feb 2023 10:39:12 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Maxim Kiselev <bigunclemax@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        abel.vesa@linaro.org, alexander.stein@ew.tq-group.com,
        andriy.shevchenko@linux.intel.com, brgl@bgdev.pl,
        colin.foster@in-advantage.com, cristian.marussi@arm.com,
        devicetree@vger.kernel.org, dianders@chromium.org,
        djrscally@gmail.com, dmitry.baryshkov@linaro.org,
        festevam@gmail.com, fido_max@inbox.ru, frowand.list@gmail.com,
        geert+renesas@glider.be, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        jpb@kernel.org, jstultz@google.com, kernel-team@android.com,
        kernel@pengutronix.de, lenb@kernel.org, linus.walleij@linaro.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux@roeck-us.net, lkft@linaro.org, luca.weiss@fairphone.com,
        magnus.damm@gmail.com, martin.kepplinger@puri.sm, maz@kernel.org,
        rafael@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        sakari.ailus@linux.intel.com, shawnguo@kernel.org,
        tglx@linutronix.de, tony@atomide.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 00/11] fw_devlink improvements
Message-ID: <20230206103912.7db5ed72@xps-13>
In-Reply-To: <CAGETcx_uri6exkv1Jkzmc4PyEam9yjuH2H1zrq4LYNtJ+XDMWw@mail.gmail.com>
References: <20230127001141.407071-1-saravanak@google.com>
        <20230130085542.38546-1-naresh.kamboju@linaro.org>
        <CAGETcx_411fVxsM-ZMK7j2Bvkmi2TKPbzSuD+03M3cb7WKHfJw@mail.gmail.com>
        <20230131101813.goaoy32qvrowvyyb@bogus>
        <CALHCpMijXAgQx2qq8g8zdq=6AHwP+g5WVBjjry=v+dKEq9KDLw@mail.gmail.com>
        <CAGETcx_UvW819m1Y-QU_ySB1nG_RegKKT06=YjkK=C_qjbAySw@mail.gmail.com>
        <CALHCpMha_1nXt4rUe+A184XSWpyNk0_PkYjWZ+tUN7BJWqENLA@mail.gmail.com>
        <CAGETcx_uri6exkv1Jkzmc4PyEam9yjuH2H1zrq4LYNtJ+XDMWw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

+ Srinivas, nvmem maintainer

saravanak@google.com wrote on Sun, 5 Feb 2023 17:32:57 -0800:

> On Fri, Feb 3, 2023 at 1:39 AM Maxim Kiselev <bigunclemax@gmail.com> wrot=
e:
> >
> > =D0=BF=D1=82, 3 =D1=84=D0=B5=D0=B2=D1=80. 2023 =D0=B3. =D0=B2 09:07, Sa=
ravana Kannan <saravanak@google.com>: =20
> > >
> > > On Thu, Feb 2, 2023 at 9:36 AM Maxim Kiselev <bigunclemax@gmail.com> =
wrote: =20
> > > >
> > > > Hi Saravana,
> > > > =20
> > > > > Can you try the patch at the end of this email under these
> > > > > configurations and tell me which ones fail vs pass? I don't need =
logs =20
> > > >
> > > > I did these tests and here is the results: =20
> > >
> > > Did you hand edit the In-Reply-To: in the header? Because in the
> > > thread you are reply to the wrong email, but the context in your email
> > > seems to be from the right email.
> > >
> > > For example, see how your reply isn't under the email you are replying
> > > to in this thread overview:
> > > https://lore.kernel.org/lkml/20230127001141.407071-1-saravanak@google=
.com/#r
> > > =20
> > > > 1. On top of this series - Not works
> > > > 2. Without this series    - Works
> > > > 3. On top of the series with the fwnode_dev_initialized() deleted -=
 Not works
> > > > 4. Without this series, with the fwnode_dev_initialized() deleted  =
- Works
> > > >
> > > > So your nvmem/core.c patch helps only when it is applied without th=
e series.
> > > > But despite the fact that this helps to avoid getting stuck at prob=
ing
> > > > my ethernet device, there is still regression.
> > > >
> > > > When the ethernet module is loaded it takes a lot of time to drop d=
ependency
> > > > from the nvmem-cell with mac address.
> > > >
> > > > Please look at the kernel logs below. =20
> > >
> > > The kernel logs below really aren't that useful for me in their
> > > current state. See more below.
> > >
> > > ---8<---- <snip> --->8----
> > > =20
> > > > P.S. Your nvmem patch definitely helps to avoid a device probe stuck
> > > > but look like it is not best way to solve a problem which we discus=
sed
> > > > in the MTD thread.
> > > >
> > > > P.P.S. Also I don't know why your nvmem-cell patch doesn't help whe=
n it was
> > > > applied on top of this series. Maybe I missed something. =20
> > >
> > > Yeah, I'm not too sure if the test was done correctly. You also didn't
> > > answer my question about the dts from my earlier email.
> > > https://lore.kernel.org/lkml/CAGETcx8FpmbaRm2CCwqt3BRBpgbogwP5gNB+iA5=
OEtuxWVTNLA@mail.gmail.com/#t
> > >
> > > So, can you please retest config 1 with all pr_debug and dev_dbg in
> > > drivers/core/base.c changed to the _info variants? And then share the
> > > kernel log from the beginning of boot? Maybe attach it to the email so
> > > it doesn't get word wrapped by your email client. And please point me
> > > to the .dts that corresponds to your board. Without that, I can't
> > > debug much.
> > >
> > > Thanks,
> > > Saravana =20
> > =20
> > > Did you hand edit the In-Reply-To: in the header? Because in the
> > > thread you are reply to the wrong email, but the context in your email
> > > seems to be from the right email. =20
> >
> > Sorry for that, it seems like I accidently deleted it.
> > =20
> > > So, can you please retest config 1 with all pr_debug and dev_dbg in
> > > drivers/core/base.c changed to the _info variants? And then share the
> > > kernel log from the beginning of boot? Maybe attach it to the email so
> > > it doesn't get word wrapped by your email client. And please point me
> > > to the .dts that corresponds to your board. Without that, I can't
> > > debug much. =20
> >
> > Ok, I retested config 1 with all _debug logs changed to the _info. I
> > added the kernel log and the dts file to the attachment of this email. =
=20
>=20
> Ah, so your device is not supported/present upstream? Even though it's
> not upstream, I'll help fix this because it should fix what I believe
> are unreported issues in upstream.
>=20
> Ok I know why configs 1 - 4 behaved the way they did and why my test
> patch didn't help.
>=20
> After staring at mtd/nvmem code for a few hours I think mtd/nvmem
> interaction is kind of a mess.

nvmem is a recent subsystem but mtd carries a lot of legacy stuff we
cannot really re-wire without breaking users, so nvmem on top of mtd
of course inherit from the fragile designs in place.

> mtd core creates "partition" platform
> devices (including for nvmem-cells) that are probed by drivers in
> drivers/nvmem. However, there's no driver for "nvmem-cells" partition
> platform device. However, the nvmem core creates nvmem_device when
> nvmem_register() is called by MTD or these partition platform devices
> created by MTD. But these nvmem_devices are added to a nvmem_bus but
> the bus has no means to even register a driver (it should really be a
> nvmem_class and not nvmem_bus).

Srinivas, do you think we could change this?

> And the nvmem_device sometimes points
> to the DT node of the MTD device or sometimes the partition platform
> devices or maybe no DT node at all.

I guess this comes from the fact that this is not strongly defined in
mtd and depends on the situation (not mentioning 20 years of history
there as well). "mtd" is a bit inconsistent on what it means. Older
designs mixed: controllers, ECC engines when relevant and memories;
while these three components are completely separated. Hence
sometimes the mtd device ends up being the top level controller,
sometimes it's just one partition...

But I'm surprised not all of them point to a DT node. Could you show us
an example? Because that might likely be unexpected (or perhaps I am
missing something).

> So it's a mess of multiple devices pointing to the same DT node with
> no clear way to identify which ones will point to a DT node and which
> ones will probe and which ones won't. In the future, we shouldn't
> allow adding new compatible strings for partitions for which we don't
> plan on adding nvmem drivers.
>
> Can you give the patch at the end of the email a shot? It should fix
> the issue with this series and without this series. It just avoids
> this whole mess by not creating useless platform device for
> nvmem-cells compatible DT nodes.

Thanks a lot for your help.

>=20
> Thanks,
> Saravana
>=20
> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> index d442fa94c872..88a213f4d651 100644
> --- a/drivers/mtd/mtdpart.c
> +++ b/drivers/mtd/mtdpart.c
> @@ -577,6 +577,7 @@ static int mtd_part_of_parse(struct mtd_info *master,
>  {
>         struct mtd_part_parser *parser;
>         struct device_node *np;
> +       struct device_node *child;
>         struct property *prop;
>         struct device *dev;
>         const char *compat;
> @@ -594,6 +595,10 @@ static int mtd_part_of_parse(struct mtd_info *master,
>         else
>                 np =3D of_get_child_by_name(np, "partitions");
>=20
> +       for_each_child_of_node(np, child)
> +               if (of_device_is_compatible(child, "nvmem-cells"))
> +                       of_node_set_flag(child, OF_POPULATED);

What about a comment explaining why we need that in the final patch
(with a comment)? Otherwise it's a little bit obscure.

> +
>         of_property_for_each_string(np, "compatible", prop, compat) {
>                 parser =3D mtd_part_get_compatible_parser(compat);
>                 if (!parser)


Thanks,
Miqu=C3=A8l
