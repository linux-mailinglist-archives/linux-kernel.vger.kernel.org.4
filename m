Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE6364D1FF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 22:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLNVyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 16:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiLNVyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 16:54:32 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A08542F57
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:54:31 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d82so5415739pfd.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMrsHGbncWvcvky0W6fDrcXQMvYyJN1VLgz7RGTGBvY=;
        b=PPRl6dvH4rAct3htjZO49pHAiRYlC8H61FTQo3T2+Yhqk7SPQXhwmZUsasD2JO71wX
         ZuAyTk5mMTTjSNJL8Oyl1B84GJuvOwFG/mjCGKCg8A9d5FEY277kYRN4JR2Dlt3YEhJZ
         wuD0JL2L0zYBGzzxFGGzpw7R5rLFjelktl9YvMmrtW0c6s4N4T42gydqlP2PZjVSjTvx
         vsYfBj/UTHjTIKnf4LS9XOToPyjYaV85r9KNDrx+aoSeGnMNU6jwXvCQ10+MbhcxfPAi
         TvjVwr7UNGqWXxJjJge2OKaAavBawtRqmMc45jdrC1YI1EUT8eLSfCfmgaLgSm90YQRe
         SPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMrsHGbncWvcvky0W6fDrcXQMvYyJN1VLgz7RGTGBvY=;
        b=k4mFDK2Ixbl74MhIr95KaKMoUtlzh15QLW1u+O98qEBygc7NQst4oyWRprOm8MfnEz
         GeeiiwCZ8sGlGIDTyB7XOSNbJDBiSrgPLfrQUmllwOKluskJcYa0nke4CYJ6BeXZJxOW
         cbRnGEfHqyLujHYE83SFznPlWzafZtUdXq4LYYb6EdRIs3nHO8MJ9C2ioAXulixPl0YJ
         D2wcU4I743ffd+0PGKuv4yoEpTroJdpnqGnuBxcUai0uxrrNacX44vFFppRy4N1uSzEb
         f65V0bDPpNdDgOgiCBNQeIeH1FXgnBYJQ5dTjX5h+y3f2xfcDtRV8TscFBYTkGErHD3a
         BtmQ==
X-Gm-Message-State: ANoB5plHZbhKtoqfr/1mFgmbkKgppXhMLAz0Gb6zEBF7Qct4/cEXltnv
        9nSlz39tSV6VRCRvbhsrEoOsrqUffifAfeWRTk7e1w==
X-Google-Smtp-Source: AA0mqf6geNaq+Is9rdFqOZOexpPNOtcqGF+8xgJ/FFFDlfUVgsIXnBPUssQ9kn+veRkAA5ORYfR+T7Ok7uX4JzuMZBI=
X-Received: by 2002:a05:6a00:290f:b0:56b:e15a:7215 with SMTP id
 cg15-20020a056a00290f00b0056be15a7215mr78413380pfb.27.1671054870586; Wed, 14
 Dec 2022 13:54:30 -0800 (PST)
MIME-Version: 1.0
References: <CALHCpMgSZOZdOGpLwTYf0sFD5EMNL7CuqHuFJV_6w5VPSWZnUw@mail.gmail.com>
 <CALHCpMgEZjnR39upkR6iozSk-b5A_GHRo9rcDSPXzzQi6x_qCw@mail.gmail.com>
 <b1b7935d-0785-2e57-bad9-ab2476f0acf2@leemhuis.info> <CALHCpMhsM2j=bSXEDC9BWYpOAyvCccgJpJmqXfiRTHvp6=y3tA@mail.gmail.com>
 <20221212101449.4e465181@xps-13> <CALHCpMimCqZB0bnHaOdCzucey+92NcRRZXCHXYYH5c9vj0nZaQ@mail.gmail.com>
 <20221212173730.64224599@xps-13> <b75a8769-0cc8-beb3-931a-6755aede3af0@inbox.ru>
 <20221213104643.052d4a06@xps-13> <CALHCpMhOku2b+1y5Z=N5RJ6SvCvNakD2rSyRAqp6Gz3JWVvXGg@mail.gmail.com>
 <20221213175424.79895b63@xps-13>
In-Reply-To: <20221213175424.79895b63@xps-13>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 14 Dec 2022 13:53:54 -0800
Message-ID: <CAGETcx8YvD5JABuJhah_6oOAUe=QgnOG5gWNL7Hcfxbvq0C2YQ@mail.gmail.com>
Subject: Re: nvmem-cells regression after adding 'call of_platform_populate()
 for MTD partitions'
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 8:54 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi Maxim,
>
> bigunclemax@gmail.com wrote on Tue, 13 Dec 2022 14:02:34 +0300:
>
> > I looked closer at commit 658c4448bbbf and bcdf0315a61a, 5db1c2dbc04c16=
 commits.
> > Looks like we have two different features binded to one property - "com=
patible".
> >
> > From one side it is the ability to forward the subnode of the mtd
> > partition to the nvmem subsystem (658c4448bbbf and ac42c46f983e).
> > And from another side is the ability to use custom initialization of
> > the mtd partition (bcdf0315a61a and 5db1c2dbc04c16).
> >
> > What I mean:
> > According to ac42c46f983e I can create DT like this:
> >  - |
> >     partitions {
> >         compatible =3D "fixed-partitions";
> >         #address-cells =3D <1>;
> >         #size-cells =3D <1>;
> >
> >         partition@0 {
> >             compatible =3D "nvmem-cells";
> >             reg =3D <0x40000 0x10000>;
> >             #address-cells =3D <1>;
> >             #size-cells =3D <1>;
> >             macaddr_gmac1: macaddr_gmac1@0 {
> >                 reg =3D <0x0 0x6>;
> >             };
> >         };
> >     };
> >
> >
> > And according to 5db1c2dbc04c16 I can create DT like this:
> >  - |
> >     partitions {
> >         compatible =3D "fixed-partitions";
> >         #address-cells =3D <1>;
> >         #size-cells =3D <1>;
> >
> >         partition@0 {
> >             compatible =3D "u-boot,env";
> >             reg =3D <0x40000 0x10000>;
> >         };
> >     };
> >
> > But I can not use them both, because only one "compatible" property all=
owed.
> > This will be incorrect:
> >  - |
> >     partitions {
> >         compatible =3D "fixed-partitions";
> >         #address-cells =3D <1>;
> >         #size-cells =3D <1>;
> >
> >         partition@0 {
> >             compatible =3D "u-boot,env";  # from ac42c46f983e
> >             compatible =3D "nvmem-cells"; # from 5db1c2dbc04c
>
> What about:
>
>               compatible =3D "u-boot,env", "nvmem-cells";
>
> instead? that should actually work.
>
> >             reg =3D <0x40000 0x10000>;
> >             #address-cells =3D <1>;
> >             #size-cells =3D <1>;
> >             macaddr_gmac1: macaddr_gmac1@0 {
> >                 reg =3D <0x0 0x6>;
> >             };
> >         };
> >     };
> >
> > > compatible: Duplicate property name
> >
> > =D0=B2=D1=82, 13 =D0=B4=D0=B5=D0=BA. 2022 =D0=B3. =D0=B2 12:46, Miquel =
Raynal <miquel.raynal@bootlin.com>:
> > >
> > > Hi Maxim,
> > >
> > > fido_max@inbox.ru wrote on Mon, 12 Dec 2022 20:57:49 +0300:
> > >
> > > > Hi, Miquel!
> > > >
> > > > On 12.12.2022 19:37, Miquel Raynal wrote:
> > > >
> > > > > Let me try to recap the situation for all the people I just invol=
ved:
> > > > >
> > > > > * An Ethernet driver gets its mac address from an nvmem cell. The
> > > > >    Ethernet controller DT node then has an "nvmem-cells" property
> > > > >    pointing towards an nvmem cell.
> > > > > * The nvmem cell comes from an mtd partition.
> > > > > * The mtd partition is flagged with a particular compatible
> > > > >    (which is also named "nvmem-cells") to tell the kernel that th=
e node
> > > > >    produces nvmem cells.
> > > > > * The mtd partition itself has no driver, but is the child node o=
f a
> > > > >    "partitions" container which has one (in this case,
> > > > >    "fixed-partitions", see the snippet below).
> > > > >
> > > > > Because the "nvmem-cells" property of the Ethernet node points at=
 the
> > > > > nvmem-cell node, the core create a device link between the Ethern=
et
> > > > > controller (consumer) and the mtd partition (producer).
> > > > >
> > > > > The device link in this case will never be satisfied because no d=
river
> > > > > matches the "nvmem-cells" compatible of the partition node.
> > > > >
> > > > > Reverting commit bcdf0315a61a ("mtd: call of_platform_populate() =
for MTD
> > > > > partitions") would IMHO not make much sense, the problem comes fr=
om the
> > > > > device link side and even there, there is nothing really "wrong",
> > > > > because I really expect the mtd device to be ready before the
> > > > > Ethernet controller probe, the device link is legitimate.
> > > > >
> > > > > So I would like to explore other alternatives. Here are a bunch o=
f
> > > > > ideas, but I'm open:
> > > >
> > > > How about to create simple driver with compatible=3D"nvmem-cell" an=
d to move all the suff from main mtd driver which serves nvmem-cell to the =
probe function?
> > >
> > > This is probably worth the try but I doubt you can make it work witho=
ut
> > > regressions because IIRC the nvmem registration happens no matter the
> > > compatible (not mentioning the user-otp and factory-otp cases). You c=
an
> > > definitely try this out if you think you can come up with something
> > > though.
> > >
> > > But I would like to hear from the device-link gurus :) because even i=
f
> > > we fix mtd with a "trick" like above, I guess we'll very likely find
> > > other corner cases like that and I am interested in understanding the
> > > rationale of what could be a proper fix.
> > >

Responding to the whole thread.

I'm going by Miquel's first email in which he cc'ed me and haven't
actually looked at the mtd code. Couple of comments:

Independent of mtd/nvmem-cell, I generally frown on having a
compatible string for a child node that you don't treat as a device.
Even more so if you actually create a struct device for it and then
don't do anything else with it. That's just a waste of memory. So, in
general try to avoid that in the future if you can.

Also, there are flags the parent device's driver can set that'll tell
fw_devlink not to treat a specific DT node as a real device. So, if we
really need that I'll dig up and suggest a fix.

Lastly and more importantly, I've a series[1] that stops depending on
the compatible property for fw_devlink to work. So it should be
smarter than it is today. But that series has known bugs for which I
gave test fixes in that thread. I plan to make a v2 of that series
with that fix and I'm expecting it'll fix a bunch of fw_devlink
issues.

Feel free to give v1 + squashing the fixes a shot if you are excited
to try it. Otherwise, I'll try my best to get around to it this week
(kinda swamped though + holidays coming up, so no promises).

[1] - https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@google=
.com/

Thanks,
Saravana
