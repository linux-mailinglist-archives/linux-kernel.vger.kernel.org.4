Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27C464F6CC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 02:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiLQBpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 20:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLQBpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 20:45:30 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043AF6310
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 17:45:29 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id w37so2908752pga.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 17:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AEqmLzluogB6qkPMPi7E/oHuV6NfkJN47xW3/CF99k=;
        b=Q/N21QD+0kmeg8opa5tbzsVXkY9C7QLsO+OeJQfMlbYNlT3I4oqVLTCihMVHuGCegU
         TbKDbcMbyDZ7WSlLEUDQSymdGmbs5xwwNiWgBrBZyMVtSZpsQgyoKHQfaos9DWYBBdS9
         KLF5eKe93hoFDkyfs2SkM6x8Gv8Rd9R0CyetpesLpgUwbdqE7e9vPzmYP5KaiOSvuKl6
         +kKByI00YXb9jAoh1APD5D3Q4ENrrwf0t1jWbAec+Hc7CJEHgT7M0AYAC/iq6b+uvCPE
         OLQ7X+30WrVRQWVkjnRK3ok1yRXnDwQRA13YT5IUN4GaLlf0TKZeLgCatbTsacHDlQep
         /HMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AEqmLzluogB6qkPMPi7E/oHuV6NfkJN47xW3/CF99k=;
        b=Zslbo8JOOw7Ui32eXFB1tIN3rUGoyi2qL4udZ8y8xl+fqaI3L7GdFCji/mjLGAhTFe
         cM7Q2a+ffhIYEId9QPj/Vee8SwqlnEhpOUblCapt1JA7LrdP3cl5kV71GIfkDl7uCatu
         oHcM+LWEc6xa579xV4iuhe3XQdAQXK4S31e6YWyvfP/NruKjXM4U1B0455KueEVjAKKX
         LElww4S4naGYK10w0+tzrrp2pawNBIlXL8+XrmA+ScmqAJEJyAa6wENE8fnhxWdOvm6Z
         +Ef8sF0kX3mwIdqUGoX8AtFW6ju8O/vJScMqmU8btvAbKBChZiB8/BLcm4yQdY35q0aH
         WSOA==
X-Gm-Message-State: ANoB5plgibf/gMFHXmJnP4hdHBiG9yomqRWAFQ3NISVYUrhj8BKt7sjF
        t1asbcW6lTsL07YzTtJbmfoSP7w+ThJessB2WUl/Qw==
X-Google-Smtp-Source: AA0mqf4ePZcQV5up/Xu5VO9aErWugiSCsg3siXXJX58Bc8VYvxLhA1SCs7ZbJtvoBIbp/dToXXX2sBSsBiiVEiEyUVo=
X-Received: by 2002:a63:2f02:0:b0:479:2109:43e with SMTP id
 v2-20020a632f02000000b004792109043emr1540604pgv.495.1671241528068; Fri, 16
 Dec 2022 17:45:28 -0800 (PST)
MIME-Version: 1.0
References: <CALHCpMgSZOZdOGpLwTYf0sFD5EMNL7CuqHuFJV_6w5VPSWZnUw@mail.gmail.com>
 <CALHCpMgEZjnR39upkR6iozSk-b5A_GHRo9rcDSPXzzQi6x_qCw@mail.gmail.com>
 <b1b7935d-0785-2e57-bad9-ab2476f0acf2@leemhuis.info> <CALHCpMhsM2j=bSXEDC9BWYpOAyvCccgJpJmqXfiRTHvp6=y3tA@mail.gmail.com>
 <20221212101449.4e465181@xps-13> <CALHCpMimCqZB0bnHaOdCzucey+92NcRRZXCHXYYH5c9vj0nZaQ@mail.gmail.com>
 <20221212173730.64224599@xps-13> <b75a8769-0cc8-beb3-931a-6755aede3af0@inbox.ru>
 <20221213104643.052d4a06@xps-13> <CALHCpMhOku2b+1y5Z=N5RJ6SvCvNakD2rSyRAqp6Gz3JWVvXGg@mail.gmail.com>
 <20221213175424.79895b63@xps-13> <CAGETcx8YvD5JABuJhah_6oOAUe=QgnOG5gWNL7Hcfxbvq0C2YQ@mail.gmail.com>
 <20221216120456.52072f9f@xps-13> <CALHCpMhEdq=Zxsj10cUNoi7Z56bqPORf1dztRKXgOL3O9C7bBQ@mail.gmail.com>
 <CALHCpMidP8L98mM3WOkqk82V0BC5g0Awu0EB62eHKZEpzEL7Vg@mail.gmail.com>
In-Reply-To: <CALHCpMidP8L98mM3WOkqk82V0BC5g0Awu0EB62eHKZEpzEL7Vg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 16 Dec 2022 17:44:51 -0800
Message-ID: <CAGETcx-4cjfeW3TNguxjbDZn==jniUrU=5sk3i-yioW135pF_g@mail.gmail.com>
Subject: Re: nvmem-cells regression after adding 'call of_platform_populate()
 for MTD partitions'
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
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

On Fri, Dec 16, 2022 at 5:13 AM Maxim Kiselev <bigunclemax@gmail.com> wrote=
:
>
> > Maxim, any chance you give this a try?
> > [1] - https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@go=
ogle.com/
>
> OK, I tried it and it didn't seem to help me.

Did you include the fixes to the v1 series I gave as replies to some
of the emails in that thread?

-Saravana

> I'm still getting an unresolved dependence for 'f1070000.ethernet'
> from 'mac@6' nvmem-cell.
> Here is a related part of kernel log:
>
> [    0.035553] ethernet@70000 Linked as a fwnode consumer to
> main-interrupt-ctrl@20200
> [    0.035601] ethernet@70000 Linked as a fwnode consumer to
> clock-gating-control@1821c
> [    0.035713] ethernet@70000 Linked as a fwnode consumer to mac@6
>
> [    0.046423] device: 'f1070000.ethernet': device_add
> [    0.046689] platform f1070000.ethernet: Not linking
> /ocp@f1000000/clock-gating-control@1821c - dev might never probe
> [    0.046747] ethernet@70000 Dropping the fwnode link to
> clock-gating-control@1821c
> [    0.046788] platform f1070000.ethernet: Not linking
> /ocp@f1000000/main-interrupt-ctrl@20200 - might never become dev
> [    0.046835] ethernet@70000 Dropping the fwnode link to
> main-interrupt-ctrl@20200
>
> [    0.113759] device: 'spi0': device_add
> [    0.114523] device: 'spi0.0': device_add
> [    0.115349] spi-nor spi0.0: mx66l51235f (65536 Kbytes)
> [    0.116833] 7 fixed-partitions partitions found on MTD device spi0.0
> [    0.117026] device: 'f1010600.spi:m25p80@0:partitions:partition@1':
> device_add
> [    0.117416] Creating 7 MTD partitions on "spi0.0":
>
> [    3.537102] devices_kset: Moving f1070000.ethernet to end of list
> [    3.537391] platform f1070000.ethernet: error -EPROBE_DEFER: wait
> for supplier mac@6
>
> =D0=BF=D1=82, 16 =D0=B4=D0=B5=D0=BA. 2022 =D0=B3. =D0=B2 14:33, Maxim Kis=
elev <bigunclemax@gmail.com>:
> >
> > > Maxim, any chance you give this a try?
> > Ok, I'll try it as soon as possible.
> >
> > =D0=BF=D1=82, 16 =D0=B4=D0=B5=D0=BA. 2022 =D0=B3. =D0=B2 14:04, Miquel =
Raynal <miquel.raynal@bootlin.com>:
> > >
> > > Hi Saravana, Maxim, Maxim,
> > >
> > > saravanak@google.com wrote on Wed, 14 Dec 2022 13:53:54 -0800:
> > >
> > > > On Tue, Dec 13, 2022 at 8:54 AM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
> > > > >
> > > > > Hi Maxim,
> > > > >
> > > > > bigunclemax@gmail.com wrote on Tue, 13 Dec 2022 14:02:34 +0300:
> > > > >
> > > > > > I looked closer at commit 658c4448bbbf and bcdf0315a61a, 5db1c2=
dbc04c16 commits.
> > > > > > Looks like we have two different features binded to one propert=
y - "compatible".
> > > > > >
> > > > > > From one side it is the ability to forward the subnode of the m=
td
> > > > > > partition to the nvmem subsystem (658c4448bbbf and ac42c46f983e=
).
> > > > > > And from another side is the ability to use custom initializati=
on of
> > > > > > the mtd partition (bcdf0315a61a and 5db1c2dbc04c16).
> > > > > >
> > > > > > What I mean:
> > > > > > According to ac42c46f983e I can create DT like this:
> > > > > >  - |
> > > > > >     partitions {
> > > > > >         compatible =3D "fixed-partitions";
> > > > > >         #address-cells =3D <1>;
> > > > > >         #size-cells =3D <1>;
> > > > > >
> > > > > >         partition@0 {
> > > > > >             compatible =3D "nvmem-cells";
> > > > > >             reg =3D <0x40000 0x10000>;
> > > > > >             #address-cells =3D <1>;
> > > > > >             #size-cells =3D <1>;
> > > > > >             macaddr_gmac1: macaddr_gmac1@0 {
> > > > > >                 reg =3D <0x0 0x6>;
> > > > > >             };
> > > > > >         };
> > > > > >     };
> > > > > >
> > > > > >
> > > > > > And according to 5db1c2dbc04c16 I can create DT like this:
> > > > > >  - |
> > > > > >     partitions {
> > > > > >         compatible =3D "fixed-partitions";
> > > > > >         #address-cells =3D <1>;
> > > > > >         #size-cells =3D <1>;
> > > > > >
> > > > > >         partition@0 {
> > > > > >             compatible =3D "u-boot,env";
> > > > > >             reg =3D <0x40000 0x10000>;
> > > > > >         };
> > > > > >     };
> > > > > >
> > > > > > But I can not use them both, because only one "compatible" prop=
erty allowed.
> > > > > > This will be incorrect:
> > > > > >  - |
> > > > > >     partitions {
> > > > > >         compatible =3D "fixed-partitions";
> > > > > >         #address-cells =3D <1>;
> > > > > >         #size-cells =3D <1>;
> > > > > >
> > > > > >         partition@0 {
> > > > > >             compatible =3D "u-boot,env";  # from ac42c46f983e
> > > > > >             compatible =3D "nvmem-cells"; # from 5db1c2dbc04c
> > > > >
> > > > > What about:
> > > > >
> > > > >               compatible =3D "u-boot,env", "nvmem-cells";
> > > > >
> > > > > instead? that should actually work.
> > > > >
> > > > > >             reg =3D <0x40000 0x10000>;
> > > > > >             #address-cells =3D <1>;
> > > > > >             #size-cells =3D <1>;
> > > > > >             macaddr_gmac1: macaddr_gmac1@0 {
> > > > > >                 reg =3D <0x0 0x6>;
> > > > > >             };
> > > > > >         };
> > > > > >     };
> > > > > >
> > > > > > > compatible: Duplicate property name
> > > > > >
> > > > > > =D0=B2=D1=82, 13 =D0=B4=D0=B5=D0=BA. 2022 =D0=B3. =D0=B2 12:46,=
 Miquel Raynal <miquel.raynal@bootlin.com>:
> > > > > > >
> > > > > > > Hi Maxim,
> > > > > > >
> > > > > > > fido_max@inbox.ru wrote on Mon, 12 Dec 2022 20:57:49 +0300:
> > > > > > >
> > > > > > > > Hi, Miquel!
> > > > > > > >
> > > > > > > > On 12.12.2022 19:37, Miquel Raynal wrote:
> > > > > > > >
> > > > > > > > > Let me try to recap the situation for all the people I ju=
st involved:
> > > > > > > > >
> > > > > > > > > * An Ethernet driver gets its mac address from an nvmem c=
ell. The
> > > > > > > > >    Ethernet controller DT node then has an "nvmem-cells" =
property
> > > > > > > > >    pointing towards an nvmem cell.
> > > > > > > > > * The nvmem cell comes from an mtd partition.
> > > > > > > > > * The mtd partition is flagged with a particular compatib=
le
> > > > > > > > >    (which is also named "nvmem-cells") to tell the kernel=
 that the node
> > > > > > > > >    produces nvmem cells.
> > > > > > > > > * The mtd partition itself has no driver, but is the chil=
d node of a
> > > > > > > > >    "partitions" container which has one (in this case,
> > > > > > > > >    "fixed-partitions", see the snippet below).
> > > > > > > > >
> > > > > > > > > Because the "nvmem-cells" property of the Ethernet node p=
oints at the
> > > > > > > > > nvmem-cell node, the core create a device link between th=
e Ethernet
> > > > > > > > > controller (consumer) and the mtd partition (producer).
> > > > > > > > >
> > > > > > > > > The device link in this case will never be satisfied beca=
use no driver
> > > > > > > > > matches the "nvmem-cells" compatible of the partition nod=
e.
> > > > > > > > >
> > > > > > > > > Reverting commit bcdf0315a61a ("mtd: call of_platform_pop=
ulate() for MTD
> > > > > > > > > partitions") would IMHO not make much sense, the problem =
comes from the
> > > > > > > > > device link side and even there, there is nothing really =
"wrong",
> > > > > > > > > because I really expect the mtd device to be ready before=
 the
> > > > > > > > > Ethernet controller probe, the device link is legitimate.
> > > > > > > > >
> > > > > > > > > So I would like to explore other alternatives. Here are a=
 bunch of
> > > > > > > > > ideas, but I'm open:
> > > > > > > >
> > > > > > > > How about to create simple driver with compatible=3D"nvmem-=
cell" and to move all the suff from main mtd driver which serves nvmem-cell=
 to the probe function?
> > > > > > >
> > > > > > > This is probably worth the try but I doubt you can make it wo=
rk without
> > > > > > > regressions because IIRC the nvmem registration happens no ma=
tter the
> > > > > > > compatible (not mentioning the user-otp and factory-otp cases=
). You can
> > > > > > > definitely try this out if you think you can come up with som=
ething
> > > > > > > though.
> > > > > > >
> > > > > > > But I would like to hear from the device-link gurus :) becaus=
e even if
> > > > > > > we fix mtd with a "trick" like above, I guess we'll very like=
ly find
> > > > > > > other corner cases like that and I am interested in understan=
ding the
> > > > > > > rationale of what could be a proper fix.
> > > > > > >
> > > >
> > > > Responding to the whole thread.
> > > >
> > > > I'm going by Miquel's first email in which he cc'ed me and haven't
> > > > actually looked at the mtd code. Couple of comments:
> > > >
> > > > Independent of mtd/nvmem-cell, I generally frown on having a
> > > > compatible string for a child node that you don't treat as a device=
.
> > > > Even more so if you actually create a struct device for it and then
> > > > don't do anything else with it. That's just a waste of memory. So, =
in
> > > > general try to avoid that in the future if you can.
> > >
> > > Agreed, it didn't triggered any warnings in my head in the first plac=
e,
> > > sorry about that.
> > >
> > > > Also, there are flags the parent device's driver can set that'll te=
ll
> > > > fw_devlink not to treat a specific DT node as a real device. So, if=
 we
> > > > really need that I'll dig up and suggest a fix.
> > >
> > > Interesting, that would indeed very likely fix it.
> > >
> > > > Lastly and more importantly, I've a series[1] that stops depending =
on
> > > > the compatible property for fw_devlink to work. So it should be
> > > > smarter than it is today. But that series has known bugs for which =
I
> > > > gave test fixes in that thread. I plan to make a v2 of that series
> > > > with that fix and I'm expecting it'll fix a bunch of fw_devlink
> > > > issues.
> > > >
> > > > Feel free to give v1 + squashing the fixes a shot if you are excite=
d
> > > > to try it. Otherwise, I'll try my best to get around to it this wee=
k
> > > > (kinda swamped though + holidays coming up, so no promises).
> > >
> > > Can you please include us in your next submission?
> > > * Maxim Kiselev <bigunclemax@gmail.com>
> > > * Maxim Kochetkov <fido_max@inbox.ru>
> > > * Miquel Raynal <miquel.raynal@bootlin.com>
> > >
> > > > [1] - https://lore.kernel.org/lkml/20220810060040.321697-1-saravana=
k@google.com/
> > >
> > > Maxim, any chance you give this a try?
> > >
> > > Thanks,
> > > Miqu=C3=A8l
