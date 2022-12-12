Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4640D649F61
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiLLNHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiLLNGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:06:53 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33418E87
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:06:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c17so12686474edj.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOx8iA+bmXfrjV/Bt8Wtzti0V9mC1AI6Y+hSM1tffWY=;
        b=FCFliqY+U3S2zuZ2bSoJnZN0yzYd0e43NvewDMAJBf+O+MaI1KZ6J77Tfu3lZahPbU
         Pev08iOmIa6JbuMoMzpd7ZFXbq5z0YsIhBvr4+kuDFjZGMTTiJx/y9z9qT+avnBhxqHX
         MJzwK6CXXPWPvxzX1nw5JqZ4qOW4GkaDggs747rgGdexW7DIBm43pEGyv17h2MvZs4vD
         f3h4EhH2UzDEmQUKu+RncxDhpwMIbbC5M1bkEbBatp800zvqpRy/4PIIdEbOcaude+Yr
         gEKTzCpmf3tQMeeQdLqUY/kS8welBeczs9Wbf++MyKMLVdYoZc/aIhT2xxDz2ayzmGds
         TYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOx8iA+bmXfrjV/Bt8Wtzti0V9mC1AI6Y+hSM1tffWY=;
        b=6Dt0DU99lZrAUbkM1f1dION1J8bq1/BQbaZ8d3SFxMz8oSPqVVVswkNY0rHtjO5vc7
         klUOBhm5DYFTX6po97bqLPQPQYJX+WzPG0dXbA4IhX2elRmWByALmwzHX3/HoLY6GjxG
         0SZIv10JhDIyPMd7TXHgfOISqqHGQGomYyDT+bEPAcmLRkWdLD34JVyit54sVIvfaROZ
         WEjuHnHp4VpWbzSZnCv+THVGl12AHRiwTqFp+fkDBn80wo5rkVe62aG8Hd6jGFkYuVJU
         LbQ9YheKv8uXqMPcb7RnXOKdeM/NjxfGWfl80om6XKT8g1lbLSaUDzLrOYg36qQwrP66
         NXCw==
X-Gm-Message-State: ANoB5pnhO4SeRFwO9qF1cQuSCFEZu9ERMjpXf8KmBcWL1VpNqE1muQqp
        strC/73vmy99tq0u+fxthrs6MmlbwAlLFNWsIys=
X-Google-Smtp-Source: AA0mqf5HkPiAFGEyW9xIZasKxtjd++dA2Uuj5wT9IMdBn8xOmfwAjuYlgNvFczqEql7ixmD6yw6bWZifBVjx4JySwrE=
X-Received: by 2002:a05:6402:22ab:b0:46a:abc8:8018 with SMTP id
 cx11-20020a05640222ab00b0046aabc88018mr54564763edb.369.1670850407507; Mon, 12
 Dec 2022 05:06:47 -0800 (PST)
MIME-Version: 1.0
References: <CALHCpMgSZOZdOGpLwTYf0sFD5EMNL7CuqHuFJV_6w5VPSWZnUw@mail.gmail.com>
 <CALHCpMgEZjnR39upkR6iozSk-b5A_GHRo9rcDSPXzzQi6x_qCw@mail.gmail.com>
 <b1b7935d-0785-2e57-bad9-ab2476f0acf2@leemhuis.info> <CALHCpMhsM2j=bSXEDC9BWYpOAyvCccgJpJmqXfiRTHvp6=y3tA@mail.gmail.com>
 <20221212101449.4e465181@xps-13>
In-Reply-To: <20221212101449.4e465181@xps-13>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Mon, 12 Dec 2022 16:06:35 +0300
Message-ID: <CALHCpMimCqZB0bnHaOdCzucey+92NcRRZXCHXYYH5c9vj0nZaQ@mail.gmail.com>
Subject: Re: nvmem-cells regression after adding 'call of_platform_populate()
 for MTD partitions'
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> At a first glance I don't get why the compatible would matter so much
> here, can you point to some core DT logic that would have an effect? I
> mean besides leading to the creation of a cell. IOW, what would be done
> differently if the compatible was different?

After adding a call of_platform_populate() for MTD partitions (bcdf0315)
we got a call of 'device_add' for each mtd partition which have
a 'compatible' property in its DT node. As a result any other devices
which have a DT reference to 'nvmem-cell' compatible mtd partition
got dependence from it (see attached log below). Now they will be waiting u=
ntil
a 'nvmem-cell' device will be probed. But this will never happen because th=
ere
is no 'nvmem-cell' driver.


Here is part of kernel log after bcdf0315 commit:
  device: 'spi0.0': device_add
  spi-nor spi0.0: mx66l51235f (65536 Kbytes)
  7 fixed-partitions partitions found on MTD device spi0.0
  device: 'f1010600.spi:m25p80@0:partitions:partition@1': device_add
  device: 'platform:f1010600.spi:m25p80@0:partitions:partition@1--platform:=
f1070000.ethernet':
device_add
  devices_kset: Moving f1070000.ethernet to end of list
  platform f1070000.ethernet: Linked as a consumer to
f1010600.spi:m25p80@0:partitions:partition@1
  ethernet@70000 Dropping the fwnode link to partition@1
  Creating 7 MTD partitions on "spi0.0":
  platform f1070000.ethernet: error -EPROBE_DEFER: supplier
f1010600.spi:m25p80@0:partitions:partition@1 not ready
  devices_kset: Moving f1070000.ethernet to end of list
  platform f1070000.ethernet: error -EPROBE_DEFER: supplier
f1010600.spi:m25p80@0:partitions:partition@1 not ready

Here is part of kernel log with reverted bcdf0315 commit:
  device: 'spi0.0': device_add
  spi-nor spi0.0: mx66l51235f (65536 Kbytes)
  7 fixed-partitions partitions found on MTD device spi0.0
  Creating 7 MTD partitions on "spi0.0":
  ethernet@70000 Dropping the fwnode link to partition@1
  device: 'eth0': device_add
  mvneta f1070000.ethernet eth0: Using device tree mac address de:fa:ce:db:=
ab:e1

Look at strings below which exists only in the first log (with bcdf0315):
  device: 'f1010600.spi:m25p80@0:partitions:partition@1': device_add
  device: 'platform:f1010600.spi:m25p80@0:partitions:partition@1--platform:=
f1070000.ethernet':
device_add
  platform f1070000.ethernet: error -EPROBE_DEFER: supplier
f1010600.spi:m25p80@0:partitions:partition@1 not ready


> because this just works with eeproms (non-mtd cells), so let's find out.
This works for eeproms and even for whole mtd partitions because there
are compatible drivers and those devices
can be probed, ulike a mtd subnode which is compatible with
non-existent 'nvmem-cell' driver.

=D0=BF=D0=BD, 12 =D0=B4=D0=B5=D0=BA. 2022 =D0=B3. =D0=B2 12:14, Miquel Rayn=
al <miquel.raynal@bootlin.com>:
>
> Hi Maxim,
>
> bigunclemax@gmail.com wrote on Sun, 11 Dec 2022 11:26:29 +0300:
>
> > >On 10.12.22 10:52, Maxim Kiselev wrote:
> > >>
> > >> After applying
> > >
> > >This makes me wonder: "applying" as in "applying it to some version th=
at
> > >doesn't contain this change normally" or as it "after it was applied t=
o
> > >mainline I have the following problem with vanilla kernel version <???=
>"?
> >
> > Sorry for confusing you, I mean "after it was applied to mainline".
> > I have this problem with vanilla kernel version 6.0.
> >
> > >>> I faced with a problem that my ethernet device can't be probed beca=
use it
> > >>> wait when 'nvmem-cells' device will be probed first.
> > >>
> > >>FWIW, there is a discussion about a problems that at least to my
> > >>untrained eyes looks similar:
> > >>https://lore.kernel.org/all/Yyj7wJlqJkCwObRn@lx2k/
> >
> > Yes it looks like the same issue.
> >
> >
> > I think the root of the problem was the choice of 'compatible'
> > device tree property to mark the mtd partition node as a nvmem provider=
.
> >
> > I'm talking about this part in 'mtd_nvmem_add' function.
> > > config.no_of_node =3D !of_device_is_compatible(node, "nvmem-cells");
> >
> > Maybe we should change the 'compatible' property to something else?
>
> At a first glance I don't get why the compatible would matter so much
> here, can you point to some core DT logic that would have an effect? I
> mean besides leading to the creation of a cell. IOW, what would be done
> differently if the compatible was different?
>
> Can you also dump the device links (if you can reach a prompt) from
> sysfs?
>
> In theory there should be a link between ethernet and spi-nor which is
> fulfilled when the spi-nor device probes and leads to the creation of
> device links. Maybe there is "something else" that the mtd core should
> do, because this just works with eeproms (non-mtd cells), so let's find
> out.
>
> > =D1=81=D0=B1, 10 =D0=B4=D0=B5=D0=BA. 2022 =D0=B3. =D0=B2 15:35, Thorste=
n Leemhuis <regressions@leemhuis.info>:
> > >
> > > [CCing the regression mailing list, as it should be in the loop for a=
ll
> > > regressions, as explained in
> > > https://docs.kernel.org/admin-guide/reporting-regressions.html ]
> > >
> > > Hi, this is your Linux kernel regression tracker. Thx for the report.
> > >
> > > On 10.12.22 10:52, Maxim Kiselev wrote:
> > > >
> > > > After applying
> > >
> > > This makes me wonder: "applying" as in "applying it to some version t=
hat
> > > doesn't contain this change normally" or as it "after it was applied =
to
> > > mainline I have the following problem with vanilla kernel version <??=
?>"?
> > >
> > > > this commit 'mtd: call of_platform_populate() for MTD
> > > > partitions' (bcdf0315),
> > >
> > > CCing Rafa=C5=82, who authored bcdf0315.
> > >
> > > > I faced with a problem that my ethernet device can't be probed beca=
use it
> > > > wait when 'nvmem-cells' device will be probed first.
> > >
> > > FWIW, there is a discussion about a problems that at least to my
> > > untrained eyes looks similar:
> > > https://lore.kernel.org/all/Yyj7wJlqJkCwObRn@lx2k/
> > >
> > > Rafa=C5=82, has some progress been made to resolve this?
> > >
> > > To me it sounds like this might warrant a "revert, and reapply later
> > > when the cause for the regression was addressed". Rafa=C5=82, it seem=
s you
> > > suggested something like that, but it doesn't look like that happened
> > > for one reason or another. Or am I missing something?
> > >
> > > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' h=
at)
> > >
> > > P.S.: As the Linux kernel's regression tracker I deal with a lot of
> > > reports and sometimes miss something important when writing mails lik=
e
> > > this. If that's the case here, don't hesitate to tell me in a public
> > > reply, it's in everyone's interest to set the public record straight.
> > >
> > > > But there is no such driver which is compatible with 'nvmem-cells' =
because
> > > > 'nvmem-cells' is just a mark used by the 'mtd_nvmem_add' function.
> > > >
> > > > So this leads to appeating of unresolved dependency for the etherne=
t device.
> > > > And that's why the ethernet device can't be added and probed.
> > > >
> > > > Here is a part of kernel log when spi flash probe start:
> > > >
> > > >> device: 'spi0': device_add
> > > >> device: 'spi0.0': device_add
> > > >> spi-nor spi0.0: mx66l51235f (65536 Kbytes)
> > > >> 7 fixed-partitions partitions found on MTD device spi0.0
> > > >
> > > > After 'm25p80' probe 'f1070000.ethernet' linked to 'partition@1' :
> > > >
> > > >> device: 'f1010600.spi:m25p80@0:
> > > > partitions:partition@1': device_add
> > > >> device: 'platform:f1010600.spi:m25p80@0:partitions:partition@1--pl=
atform:f1070000.ethernet': device_add
> > > >> devices_kset: Moving f1070000.ethernet to end of list
> > > >> platform f1070000.ethernet: Linked as a consumer to f1010600.spi:m=
25p80@0:partitions:partition@1
> > > >> ethernet@70000 Dropping the fwnode link to partition@1
> > > >
> > > > And as a result I got `-EPROBE_DEFER` for `f1070000.ethernet`
> > > >
> > > >> platform f1070000.ethernet: error -EPROBE_DEFER: supplier f1010600=
.spi:m25p80@0:partitions:partition@1 not ready
> > > >
> > > > Here is a part of my device tree:
> > > >
> > > >     enet1: ethernet@70000 {
> > > >         status =3D "okay";
> > > >         nvmem-cells =3D <&macaddr>;
> > > >         nvmem-cell-names =3D "mac-address";
> > > >         phy-mode =3D "rgmii";
> > > >         phy =3D <&phy0>;
> > > >     };
> > > >
> > > >     spi@10600 {
> > > >         status =3D "okay";
> > > >
> > > >         m25p80@0 {
> > > >             compatible =3D "mx66l51235l";
> > > >             reg =3D <0>;
> > > >             #address-cells =3D <1>;
> > > >             #size-cells =3D <1>;
> > > >
> > > >             partitions {
> > > >                 compatible =3D "fixed-partitions";
> > > >                 #address-cells =3D <1>;
> > > >                 #size-cells =3D <1>;
> > > >
> > > >                 partition@0 {
> > > >                     reg =3D <0x00000000 0x000080000>;
> > > >                     label =3D "SPI.U_BOOT";
> > > >                 };
> > > >
> > > >                 partition@1 {
> > > >                     compatible =3D "nvmem-cells";
> > > >                     reg =3D <0x000A0000 0x00020000>;
> > > >                     label =3D "SPI.INV_INFO";
> > > >                     #address-cells =3D <1>;
> > > >                     #size-cells =3D <1>;
> > > >                     ranges =3D <0 0x000A0000 0x00020000>;
> > > >
> > > >                     macaddr: mac@6 {
> > > >                         reg =3D <0x6 0x6>;
> > > >                     };
> > > >                 };
> > > >
> > > >             };
> > > >         };
> > > >     };
> > > >
> > > > In the example above 'ethernet@70000' requires 'macaddr: mac@6' whi=
ch is
> > > > located inside mtd 'partition@1' of 'm25p80@0' spi flash.
> > >
> > > P.P.S.: let me add this to the regression tracking:
> > >
> > > #regzbot ^introduced bcdf0315
> > > #regzbot title mtd: ethernet device can't be probed anymore due to
> > > broken nvmem-cells dep
> > > #regzbot monitor: https://lore.kernel.org/all/Yyj7wJlqJkCwObRn@lx2k/
> > > #regzbot ignore-activity
>
>
> Thanks,
> Miqu=C3=A8l
