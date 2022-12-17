Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575DC64F6CB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 02:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiLQBqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 20:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiLQBqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 20:46:00 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38111A445
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 17:45:58 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so4032707pjj.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 17:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SPbBEgrOaHNV8xOhHSUjf1emrGY+ICMgqRk2n8nWrI=;
        b=kB1udAvZT6xXPrHig116jEAzPsUx7zkg9OrgLbxxwwUvTSW0mU9HOfNtzC1qYSIudI
         J+Ctp9oMo0iNzzrzhLpESvR8V336gTlu+FW4FSMJrVj/PCMN+Oh73+Y+s9YSwZzZyxhC
         Ve05HraaxAXhI7iqk0nuts+VzGGGCKxzMtSg9Cd0VTiNAhRg+RiqlfdPIfYtqiTpxjKa
         I4A2iBnz7KmI9hjlvmDAAINi6EqGhgPpdm0KAdOo287a3mdoPhEz3d5camsxpFDTZYRB
         pcPYkTfJUzPLV4unMqIrxmrQFZB1K6bqRuovkWHaQCTSN7wXHYCYEx1KVDIwEXI8ECFO
         O6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SPbBEgrOaHNV8xOhHSUjf1emrGY+ICMgqRk2n8nWrI=;
        b=BpP9X29fcdDAjhcDlHMWLC1+Akx+/oDrta7Tv4BeihUAZjWVLEo+rpGYXMmLHau0HZ
         U/ENKHdY4HN4I1iuRm7GVa7wX8P3hXYl0oTQZB5kEWCOpNwEz8qeaI3OekYILmIBzbQM
         3bDfHjJMYNio7Eeo6OWvdVnt/t+etW61eeQgS8HANqJA4MH56DOvBmUPiEyhxtSDuVp/
         uZP18SRVpx+gJ3jNh8GW7Iy217ghfLppfJIlpYpJJ9QlHrjdUx5YvE6g/68hD5RoG/pK
         3UVDMkCSoH/amhPpJScOY6xlcHmWGk8zAVfOq+Cfdq/GaJD/qupQQUJyArLuoqGBrJKy
         9Afw==
X-Gm-Message-State: AFqh2kr5y8jfxGapd/UbTwb9gbCTby0SQpF9cxjJlwZv2CG9foUhJi4L
        i5zY0cHtZNADAZUWJcU8RY438MJ5iD1B0NZ8qG5a5w==
X-Google-Smtp-Source: AMrXdXuD0JNDkYJxldHADHFUTjZ45s8XXqk6J1PG4bpmd3+lReDrwwy/2Hn+lscVVYWRbqQdHt11YDt61guDvu1LQKY=
X-Received: by 2002:a17:90a:3e4f:b0:219:aa90:3198 with SMTP id
 t15-20020a17090a3e4f00b00219aa903198mr1464527pjm.112.1671241557408; Fri, 16
 Dec 2022 17:45:57 -0800 (PST)
MIME-Version: 1.0
References: <CALHCpMgSZOZdOGpLwTYf0sFD5EMNL7CuqHuFJV_6w5VPSWZnUw@mail.gmail.com>
 <CALHCpMgEZjnR39upkR6iozSk-b5A_GHRo9rcDSPXzzQi6x_qCw@mail.gmail.com>
 <b1b7935d-0785-2e57-bad9-ab2476f0acf2@leemhuis.info> <CALHCpMhsM2j=bSXEDC9BWYpOAyvCccgJpJmqXfiRTHvp6=y3tA@mail.gmail.com>
 <20221212101449.4e465181@xps-13> <CALHCpMimCqZB0bnHaOdCzucey+92NcRRZXCHXYYH5c9vj0nZaQ@mail.gmail.com>
 <20221212173730.64224599@xps-13> <b75a8769-0cc8-beb3-931a-6755aede3af0@inbox.ru>
 <20221213104643.052d4a06@xps-13> <CALHCpMhOku2b+1y5Z=N5RJ6SvCvNakD2rSyRAqp6Gz3JWVvXGg@mail.gmail.com>
 <20221213175424.79895b63@xps-13> <CAGETcx8YvD5JABuJhah_6oOAUe=QgnOG5gWNL7Hcfxbvq0C2YQ@mail.gmail.com>
 <20221216120456.52072f9f@xps-13>
In-Reply-To: <20221216120456.52072f9f@xps-13>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 16 Dec 2022 17:45:20 -0800
Message-ID: <CAGETcx_=K42PE4cvX7+h2gbNHORUfPmoVAbamn5MRK2VHtk-Dg@mail.gmail.com>
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

On Fri, Dec 16, 2022 at 3:05 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi Saravana, Maxim, Maxim,
>
> saravanak@google.com wrote on Wed, 14 Dec 2022 13:53:54 -0800:
>
> > On Tue, Dec 13, 2022 at 8:54 AM Miquel Raynal <miquel.raynal@bootlin.co=
m> wrote:
> > >
> > > Hi Maxim,
> > >
> > > bigunclemax@gmail.com wrote on Tue, 13 Dec 2022 14:02:34 +0300:
> > >
> > > > I looked closer at commit 658c4448bbbf and bcdf0315a61a, 5db1c2dbc0=
4c16 commits.
> > > > Looks like we have two different features binded to one property - =
"compatible".
> > > >
> > > > From one side it is the ability to forward the subnode of the mtd
> > > > partition to the nvmem subsystem (658c4448bbbf and ac42c46f983e).
> > > > And from another side is the ability to use custom initialization o=
f
> > > > the mtd partition (bcdf0315a61a and 5db1c2dbc04c16).
> > > >
> > > > What I mean:
> > > > According to ac42c46f983e I can create DT like this:
> > > >  - |
> > > >     partitions {
> > > >         compatible =3D "fixed-partitions";
> > > >         #address-cells =3D <1>;
> > > >         #size-cells =3D <1>;
> > > >
> > > >         partition@0 {
> > > >             compatible =3D "nvmem-cells";
> > > >             reg =3D <0x40000 0x10000>;
> > > >             #address-cells =3D <1>;
> > > >             #size-cells =3D <1>;
> > > >             macaddr_gmac1: macaddr_gmac1@0 {
> > > >                 reg =3D <0x0 0x6>;
> > > >             };
> > > >         };
> > > >     };
> > > >
> > > >
> > > > And according to 5db1c2dbc04c16 I can create DT like this:
> > > >  - |
> > > >     partitions {
> > > >         compatible =3D "fixed-partitions";
> > > >         #address-cells =3D <1>;
> > > >         #size-cells =3D <1>;
> > > >
> > > >         partition@0 {
> > > >             compatible =3D "u-boot,env";
> > > >             reg =3D <0x40000 0x10000>;
> > > >         };
> > > >     };
> > > >
> > > > But I can not use them both, because only one "compatible" property=
 allowed.
> > > > This will be incorrect:
> > > >  - |
> > > >     partitions {
> > > >         compatible =3D "fixed-partitions";
> > > >         #address-cells =3D <1>;
> > > >         #size-cells =3D <1>;
> > > >
> > > >         partition@0 {
> > > >             compatible =3D "u-boot,env";  # from ac42c46f983e
> > > >             compatible =3D "nvmem-cells"; # from 5db1c2dbc04c
> > >
> > > What about:
> > >
> > >               compatible =3D "u-boot,env", "nvmem-cells";
> > >
> > > instead? that should actually work.
> > >
> > > >             reg =3D <0x40000 0x10000>;
> > > >             #address-cells =3D <1>;
> > > >             #size-cells =3D <1>;
> > > >             macaddr_gmac1: macaddr_gmac1@0 {
> > > >                 reg =3D <0x0 0x6>;
> > > >             };
> > > >         };
> > > >     };
> > > >
> > > > > compatible: Duplicate property name
> > > >
> > > > =D0=B2=D1=82, 13 =D0=B4=D0=B5=D0=BA. 2022 =D0=B3. =D0=B2 12:46, Miq=
uel Raynal <miquel.raynal@bootlin.com>:
> > > > >
> > > > > Hi Maxim,
> > > > >
> > > > > fido_max@inbox.ru wrote on Mon, 12 Dec 2022 20:57:49 +0300:
> > > > >
> > > > > > Hi, Miquel!
> > > > > >
> > > > > > On 12.12.2022 19:37, Miquel Raynal wrote:
> > > > > >
> > > > > > > Let me try to recap the situation for all the people I just i=
nvolved:
> > > > > > >
> > > > > > > * An Ethernet driver gets its mac address from an nvmem cell.=
 The
> > > > > > >    Ethernet controller DT node then has an "nvmem-cells" prop=
erty
> > > > > > >    pointing towards an nvmem cell.
> > > > > > > * The nvmem cell comes from an mtd partition.
> > > > > > > * The mtd partition is flagged with a particular compatible
> > > > > > >    (which is also named "nvmem-cells") to tell the kernel tha=
t the node
> > > > > > >    produces nvmem cells.
> > > > > > > * The mtd partition itself has no driver, but is the child no=
de of a
> > > > > > >    "partitions" container which has one (in this case,
> > > > > > >    "fixed-partitions", see the snippet below).
> > > > > > >
> > > > > > > Because the "nvmem-cells" property of the Ethernet node point=
s at the
> > > > > > > nvmem-cell node, the core create a device link between the Et=
hernet
> > > > > > > controller (consumer) and the mtd partition (producer).
> > > > > > >
> > > > > > > The device link in this case will never be satisfied because =
no driver
> > > > > > > matches the "nvmem-cells" compatible of the partition node.
> > > > > > >
> > > > > > > Reverting commit bcdf0315a61a ("mtd: call of_platform_populat=
e() for MTD
> > > > > > > partitions") would IMHO not make much sense, the problem come=
s from the
> > > > > > > device link side and even there, there is nothing really "wro=
ng",
> > > > > > > because I really expect the mtd device to be ready before the
> > > > > > > Ethernet controller probe, the device link is legitimate.
> > > > > > >
> > > > > > > So I would like to explore other alternatives. Here are a bun=
ch of
> > > > > > > ideas, but I'm open:
> > > > > >
> > > > > > How about to create simple driver with compatible=3D"nvmem-cell=
" and to move all the suff from main mtd driver which serves nvmem-cell to =
the probe function?
> > > > >
> > > > > This is probably worth the try but I doubt you can make it work w=
ithout
> > > > > regressions because IIRC the nvmem registration happens no matter=
 the
> > > > > compatible (not mentioning the user-otp and factory-otp cases). Y=
ou can
> > > > > definitely try this out if you think you can come up with somethi=
ng
> > > > > though.
> > > > >
> > > > > But I would like to hear from the device-link gurus :) because ev=
en if
> > > > > we fix mtd with a "trick" like above, I guess we'll very likely f=
ind
> > > > > other corner cases like that and I am interested in understanding=
 the
> > > > > rationale of what could be a proper fix.
> > > > >
> >
> > Responding to the whole thread.
> >
> > I'm going by Miquel's first email in which he cc'ed me and haven't
> > actually looked at the mtd code. Couple of comments:
> >
> > Independent of mtd/nvmem-cell, I generally frown on having a
> > compatible string for a child node that you don't treat as a device.
> > Even more so if you actually create a struct device for it and then
> > don't do anything else with it. That's just a waste of memory. So, in
> > general try to avoid that in the future if you can.
>
> Agreed, it didn't triggered any warnings in my head in the first place,
> sorry about that.
>
> > Also, there are flags the parent device's driver can set that'll tell
> > fw_devlink not to treat a specific DT node as a real device. So, if we
> > really need that I'll dig up and suggest a fix.
>
> Interesting, that would indeed very likely fix it.
>
> > Lastly and more importantly, I've a series[1] that stops depending on
> > the compatible property for fw_devlink to work. So it should be
> > smarter than it is today. But that series has known bugs for which I
> > gave test fixes in that thread. I plan to make a v2 of that series
> > with that fix and I'm expecting it'll fix a bunch of fw_devlink
> > issues.
> >
> > Feel free to give v1 + squashing the fixes a shot if you are excited
> > to try it. Otherwise, I'll try my best to get around to it this week
> > (kinda swamped though + holidays coming up, so no promises).
>
> Can you please include us in your next submission?
> * Maxim Kiselev <bigunclemax@gmail.com>
> * Maxim Kochetkov <fido_max@inbox.ru>
> * Miquel Raynal <miquel.raynal@bootlin.com>

Will do.

-Saravana

>
> > [1] - https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@go=
ogle.com/
>
> Maxim, any chance you give this a try?
>
> Thanks,
> Miqu=C3=A8l
