Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE173649ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiLLJPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiLLJOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:14:55 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD371098
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:14:52 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2307E20003;
        Mon, 12 Dec 2022 09:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670836491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l/KIO8AZ5P9rd21zP9byqgmNU+hUX6QgS9f04NPvsro=;
        b=lKSxi4Og4ag1ISGuWDmUlXQ+7E3im/TokevFK3fvaXGyXzV1JOislM+aRoy6H5Sey9D8fs
        SBKQpVC/miyxJzZ3f+0TnzDk6cdgD2u/2/ijhARU+FTgC1kM8LsAHSq1yEgDnS0GYeh0X7
        /iLNO2z8/kyREcn9DiedytsQwjP04R//qm79m+VS9Ax5vl+unGtWSulMWZybnHUEA406hN
        wMkj2m80KMO7MohNIu59vwklyE7S++GmuKuS1V9OBb5C8jQuKfJmPS3fTAncCQpVTF8MWY
        0ZhMKXlIcZQ+0kKTyIFjRj0c8YvphMGouk8YTibmJwJggMPWM1WewCFKGfbsag==
Date:   Mon, 12 Dec 2022 10:14:49 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: nvmem-cells regression after adding 'call
 of_platform_populate() for MTD partitions'
Message-ID: <20221212101449.4e465181@xps-13>
In-Reply-To: <CALHCpMhsM2j=bSXEDC9BWYpOAyvCccgJpJmqXfiRTHvp6=y3tA@mail.gmail.com>
References: <CALHCpMgSZOZdOGpLwTYf0sFD5EMNL7CuqHuFJV_6w5VPSWZnUw@mail.gmail.com>
        <CALHCpMgEZjnR39upkR6iozSk-b5A_GHRo9rcDSPXzzQi6x_qCw@mail.gmail.com>
        <b1b7935d-0785-2e57-bad9-ab2476f0acf2@leemhuis.info>
        <CALHCpMhsM2j=bSXEDC9BWYpOAyvCccgJpJmqXfiRTHvp6=y3tA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxim,

bigunclemax@gmail.com wrote on Sun, 11 Dec 2022 11:26:29 +0300:

> >On 10.12.22 10:52, Maxim Kiselev wrote: =20
> >>
> >> After applying =20
> >
> >This makes me wonder: "applying" as in "applying it to some version that
> >doesn't contain this change normally" or as it "after it was applied to
> >mainline I have the following problem with vanilla kernel version <???>"=
? =20
>=20
> Sorry for confusing you, I mean "after it was applied to mainline".
> I have this problem with vanilla kernel version 6.0.
>=20
> >>> I faced with a problem that my ethernet device can't be probed becaus=
e it
> >>> wait when 'nvmem-cells' device will be probed first. =20
> >>
> >>FWIW, there is a discussion about a problems that at least to my
> >>untrained eyes looks similar:
> >>https://lore.kernel.org/all/Yyj7wJlqJkCwObRn@lx2k/ =20
>=20
> Yes it looks like the same issue.
>=20
>=20
> I think the root of the problem was the choice of 'compatible'
> device tree property to mark the mtd partition node as a nvmem provider.
>=20
> I'm talking about this part in 'mtd_nvmem_add' function.
> > config.no_of_node =3D !of_device_is_compatible(node, "nvmem-cells"); =20
>=20
> Maybe we should change the 'compatible' property to something else?

At a first glance I don't get why the compatible would matter so much
here, can you point to some core DT logic that would have an effect? I
mean besides leading to the creation of a cell. IOW, what would be done
differently if the compatible was different?

Can you also dump the device links (if you can reach a prompt) from
sysfs?

In theory there should be a link between ethernet and spi-nor which is
fulfilled when the spi-nor device probes and leads to the creation of
device links. Maybe there is "something else" that the mtd core should
do, because this just works with eeproms (non-mtd cells), so let's find
out.

> =D1=81=D0=B1, 10 =D0=B4=D0=B5=D0=BA. 2022 =D0=B3. =D0=B2 15:35, Thorsten =
Leemhuis <regressions@leemhuis.info>:
> >
> > [CCing the regression mailing list, as it should be in the loop for all
> > regressions, as explained in
> > https://docs.kernel.org/admin-guide/reporting-regressions.html ]
> >
> > Hi, this is your Linux kernel regression tracker. Thx for the report.
> >
> > On 10.12.22 10:52, Maxim Kiselev wrote: =20
> > >
> > > After applying =20
> >
> > This makes me wonder: "applying" as in "applying it to some version that
> > doesn't contain this change normally" or as it "after it was applied to
> > mainline I have the following problem with vanilla kernel version <???>=
"?
> > =20
> > > this commit 'mtd: call of_platform_populate() for MTD
> > > partitions' (bcdf0315), =20
> >
> > CCing Rafa=C5=82, who authored bcdf0315.
> > =20
> > > I faced with a problem that my ethernet device can't be probed becaus=
e it
> > > wait when 'nvmem-cells' device will be probed first. =20
> >
> > FWIW, there is a discussion about a problems that at least to my
> > untrained eyes looks similar:
> > https://lore.kernel.org/all/Yyj7wJlqJkCwObRn@lx2k/
> >
> > Rafa=C5=82, has some progress been made to resolve this?
> >
> > To me it sounds like this might warrant a "revert, and reapply later
> > when the cause for the regression was addressed". Rafa=C5=82, it seems =
you
> > suggested something like that, but it doesn't look like that happened
> > for one reason or another. Or am I missing something?
> >
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> >
> > P.S.: As the Linux kernel's regression tracker I deal with a lot of
> > reports and sometimes miss something important when writing mails like
> > this. If that's the case here, don't hesitate to tell me in a public
> > reply, it's in everyone's interest to set the public record straight.
> > =20
> > > But there is no such driver which is compatible with 'nvmem-cells' be=
cause
> > > 'nvmem-cells' is just a mark used by the 'mtd_nvmem_add' function.
> > >
> > > So this leads to appeating of unresolved dependency for the ethernet =
device.
> > > And that's why the ethernet device can't be added and probed.
> > >
> > > Here is a part of kernel log when spi flash probe start:
> > > =20
> > >> device: 'spi0': device_add
> > >> device: 'spi0.0': device_add
> > >> spi-nor spi0.0: mx66l51235f (65536 Kbytes)
> > >> 7 fixed-partitions partitions found on MTD device spi0.0 =20
> > >
> > > After 'm25p80' probe 'f1070000.ethernet' linked to 'partition@1' :
> > > =20
> > >> device: 'f1010600.spi:m25p80@0: =20
> > > partitions:partition@1': device_add =20
> > >> device: 'platform:f1010600.spi:m25p80@0:partitions:partition@1--plat=
form:f1070000.ethernet': device_add
> > >> devices_kset: Moving f1070000.ethernet to end of list
> > >> platform f1070000.ethernet: Linked as a consumer to f1010600.spi:m25=
p80@0:partitions:partition@1
> > >> ethernet@70000 Dropping the fwnode link to partition@1 =20
> > >
> > > And as a result I got `-EPROBE_DEFER` for `f1070000.ethernet`
> > > =20
> > >> platform f1070000.ethernet: error -EPROBE_DEFER: supplier f1010600.s=
pi:m25p80@0:partitions:partition@1 not ready =20
> > >
> > > Here is a part of my device tree:
> > >
> > >     enet1: ethernet@70000 {
> > >         status =3D "okay";
> > >         nvmem-cells =3D <&macaddr>;
> > >         nvmem-cell-names =3D "mac-address";
> > >         phy-mode =3D "rgmii";
> > >         phy =3D <&phy0>;
> > >     };
> > >
> > >     spi@10600 {
> > >         status =3D "okay";
> > >
> > >         m25p80@0 {
> > >             compatible =3D "mx66l51235l";
> > >             reg =3D <0>;
> > >             #address-cells =3D <1>;
> > >             #size-cells =3D <1>;
> > >
> > >             partitions {
> > >                 compatible =3D "fixed-partitions";
> > >                 #address-cells =3D <1>;
> > >                 #size-cells =3D <1>;
> > >
> > >                 partition@0 {
> > >                     reg =3D <0x00000000 0x000080000>;
> > >                     label =3D "SPI.U_BOOT";
> > >                 };
> > >
> > >                 partition@1 {
> > >                     compatible =3D "nvmem-cells";
> > >                     reg =3D <0x000A0000 0x00020000>;
> > >                     label =3D "SPI.INV_INFO";
> > >                     #address-cells =3D <1>;
> > >                     #size-cells =3D <1>;
> > >                     ranges =3D <0 0x000A0000 0x00020000>;
> > >
> > >                     macaddr: mac@6 {
> > >                         reg =3D <0x6 0x6>;
> > >                     };
> > >                 };
> > >
> > >             };
> > >         };
> > >     };
> > >
> > > In the example above 'ethernet@70000' requires 'macaddr: mac@6' which=
 is
> > > located inside mtd 'partition@1' of 'm25p80@0' spi flash. =20
> >
> > P.P.S.: let me add this to the regression tracking:
> >
> > #regzbot ^introduced bcdf0315
> > #regzbot title mtd: ethernet device can't be probed anymore due to
> > broken nvmem-cells dep
> > #regzbot monitor: https://lore.kernel.org/all/Yyj7wJlqJkCwObRn@lx2k/
> > #regzbot ignore-activity =20


Thanks,
Miqu=C3=A8l
