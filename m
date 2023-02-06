Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A450668C748
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjBFUJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBFUJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:09:07 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDF41D911
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:09:05 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so16303981pjd.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 12:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8zQ21lgm/+hysyLZDWkcJECUGjBC4CaZ4mgsX1s5q0=;
        b=O9Ya8X/CYW79qvsDBwCU4QasH/GJVsFJdbauSxy3ALcMP6Td/e++Sr2/Kk6Y/0Bi8A
         HExajCOknNGEaSGBqbSIS45SYN+jvrVOYSflvwXC3/9Qjgfb0vkmu/mC3BtSnmYO9Azo
         YPq/Mke+7pPZKPUQgwb8ALjXPF1KrfIvJzJ39kARqaWQOILz2ekiU1kAmdv7kLwwoYFq
         Swvoy0nXykBQyGQaOv/e5ca1b3v6nwtm5i0x5rsR/qHbJEI7HvDPoGHOVfAIrnCwXGAV
         Ve4YLBD8wxoPxTg47Ch0cATZ7vPGTBikjD33kVkmh+AQic7pGD32UqcBXm345/EvJKI8
         8QpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8zQ21lgm/+hysyLZDWkcJECUGjBC4CaZ4mgsX1s5q0=;
        b=cLrVOfnTIrn9cCY/fHMBRX1VcYdnLbjM4HGLqb1iWAOX3ULCNnFLqYTL57GlHeJa62
         s3Hq83+SNF/Ff6UP7umY4QwAvUFHVV/CzWUYngFty6thOdXo2h+Q6eoPeG1nQlZamUHS
         +9S1vKZ1Y8+sWU8ZYa7AaUIKqGrfKux1i1tyGE6CZXPwsRuRNKGfd3hW6gwOoK+NWVst
         bwh/K4xOOaCVsIpXEMz+0vxAneEHmHNuwZ+2ANewMi8s6whWGhBNT4khWtvhSE6+GEu2
         zhRx/86xGeKg7/LJYBBMmTdArVeX5duJkmaXo5pHXx/Tx4PP5xw/Bxo/ZiyoP8DiVjcr
         M5/g==
X-Gm-Message-State: AO0yUKWG1vqfEBxAGmyTuwgssE/NJJeCKoqWWGVR9ooSw4ArA6oYSYCD
        6EuuilcveXPdMxFAH5Mjk1KdEeITn6brQ4TCeOR45w==
X-Google-Smtp-Source: AK7set/KBPOtO+P54MX/LciN9urMG1z25fzyBFed50xf4hc+H6GtlXs0JkU2MZxc6mAROsbMMvV71vF/eDS3vFQiFbE=
X-Received: by 2002:a17:90a:187:b0:22c:ad5e:e1e3 with SMTP id
 7-20020a17090a018700b0022cad5ee1e3mr3608581pjc.141.1675714144798; Mon, 06 Feb
 2023 12:09:04 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230130085542.38546-1-naresh.kamboju@linaro.org>
 <CAGETcx_411fVxsM-ZMK7j2Bvkmi2TKPbzSuD+03M3cb7WKHfJw@mail.gmail.com>
 <20230131101813.goaoy32qvrowvyyb@bogus> <CALHCpMijXAgQx2qq8g8zdq=6AHwP+g5WVBjjry=v+dKEq9KDLw@mail.gmail.com>
 <CAGETcx_UvW819m1Y-QU_ySB1nG_RegKKT06=YjkK=C_qjbAySw@mail.gmail.com>
 <CALHCpMha_1nXt4rUe+A184XSWpyNk0_PkYjWZ+tUN7BJWqENLA@mail.gmail.com>
 <CAGETcx_uri6exkv1Jkzmc4PyEam9yjuH2H1zrq4LYNtJ+XDMWw@mail.gmail.com> <20230206103912.7db5ed72@xps-13>
In-Reply-To: <20230206103912.7db5ed72@xps-13>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 6 Feb 2023 12:08:28 -0800
Message-ID: <CAGETcx-0VboaAeoa+_AqDtrDj6v6ZytFj6pU-FVyAu-pk-hG6A@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] fw_devlink improvements
To:     Miquel Raynal <miquel.raynal@bootlin.com>
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

On Mon, Feb 6, 2023 at 1:39 AM Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:
>
> Hi Saravana,
>
> + Srinivas, nvmem maintainer
>
> saravanak@google.com wrote on Sun, 5 Feb 2023 17:32:57 -0800:
>
> > On Fri, Feb 3, 2023 at 1:39 AM Maxim Kiselev <bigunclemax@gmail.com> wr=
ote:
> > >
> > > =D0=BF=D1=82, 3 =D1=84=D0=B5=D0=B2=D1=80. 2023 =D0=B3. =D0=B2 09:07, =
Saravana Kannan <saravanak@google.com>:
> > > >
> > > > On Thu, Feb 2, 2023 at 9:36 AM Maxim Kiselev <bigunclemax@gmail.com=
> wrote:
> > > > >
> > > > > Hi Saravana,
> > > > >
> > > > > > Can you try the patch at the end of this email under these
> > > > > > configurations and tell me which ones fail vs pass? I don't nee=
d logs
> > > > >
> > > > > I did these tests and here is the results:
> > > >
> > > > Did you hand edit the In-Reply-To: in the header? Because in the
> > > > thread you are reply to the wrong email, but the context in your em=
ail
> > > > seems to be from the right email.
> > > >
> > > > For example, see how your reply isn't under the email you are reply=
ing
> > > > to in this thread overview:
> > > > https://lore.kernel.org/lkml/20230127001141.407071-1-saravanak@goog=
le.com/#r
> > > >
> > > > > 1. On top of this series - Not works
> > > > > 2. Without this series    - Works
> > > > > 3. On top of the series with the fwnode_dev_initialized() deleted=
 - Not works
> > > > > 4. Without this series, with the fwnode_dev_initialized() deleted=
  - Works
> > > > >
> > > > > So your nvmem/core.c patch helps only when it is applied without =
the series.
> > > > > But despite the fact that this helps to avoid getting stuck at pr=
obing
> > > > > my ethernet device, there is still regression.
> > > > >
> > > > > When the ethernet module is loaded it takes a lot of time to drop=
 dependency
> > > > > from the nvmem-cell with mac address.
> > > > >
> > > > > Please look at the kernel logs below.
> > > >
> > > > The kernel logs below really aren't that useful for me in their
> > > > current state. See more below.
> > > >
> > > > ---8<---- <snip> --->8----
> > > >
> > > > > P.S. Your nvmem patch definitely helps to avoid a device probe st=
uck
> > > > > but look like it is not best way to solve a problem which we disc=
ussed
> > > > > in the MTD thread.
> > > > >
> > > > > P.P.S. Also I don't know why your nvmem-cell patch doesn't help w=
hen it was
> > > > > applied on top of this series. Maybe I missed something.
> > > >
> > > > Yeah, I'm not too sure if the test was done correctly. You also did=
n't
> > > > answer my question about the dts from my earlier email.
> > > > https://lore.kernel.org/lkml/CAGETcx8FpmbaRm2CCwqt3BRBpgbogwP5gNB+i=
A5OEtuxWVTNLA@mail.gmail.com/#t
> > > >
> > > > So, can you please retest config 1 with all pr_debug and dev_dbg in
> > > > drivers/core/base.c changed to the _info variants? And then share t=
he
> > > > kernel log from the beginning of boot? Maybe attach it to the email=
 so
> > > > it doesn't get word wrapped by your email client. And please point =
me
> > > > to the .dts that corresponds to your board. Without that, I can't
> > > > debug much.
> > > >
> > > > Thanks,
> > > > Saravana
> > >
> > > > Did you hand edit the In-Reply-To: in the header? Because in the
> > > > thread you are reply to the wrong email, but the context in your em=
ail
> > > > seems to be from the right email.
> > >
> > > Sorry for that, it seems like I accidently deleted it.
> > >
> > > > So, can you please retest config 1 with all pr_debug and dev_dbg in
> > > > drivers/core/base.c changed to the _info variants? And then share t=
he
> > > > kernel log from the beginning of boot? Maybe attach it to the email=
 so
> > > > it doesn't get word wrapped by your email client. And please point =
me
> > > > to the .dts that corresponds to your board. Without that, I can't
> > > > debug much.
> > >
> > > Ok, I retested config 1 with all _debug logs changed to the _info. I
> > > added the kernel log and the dts file to the attachment of this email=
.
> >
> > Ah, so your device is not supported/present upstream? Even though it's
> > not upstream, I'll help fix this because it should fix what I believe
> > are unreported issues in upstream.
> >
> > Ok I know why configs 1 - 4 behaved the way they did and why my test
> > patch didn't help.
> >
> > After staring at mtd/nvmem code for a few hours I think mtd/nvmem
> > interaction is kind of a mess.
>
> nvmem is a recent subsystem but mtd carries a lot of legacy stuff we
> cannot really re-wire without breaking users, so nvmem on top of mtd
> of course inherit from the fragile designs in place.

Thanks for the context. Yeah, I figured. That's why I explicitly
limited my comment to "interaction". Although, I'd love to see the MTD
parsers all be converted to proper drivers that probe. MTD is
essentially repeating the driver matching logic. I think it can be
cleaned up to move to proper drivers and still not break backward
compatibility. Not saying it'll be trivial, but it should be possible.
Ironically MTD uses mtd_class but has real drivers that work on the
device (compared to nvmem_bus below).

> > mtd core creates "partition" platform
> > devices (including for nvmem-cells) that are probed by drivers in
> > drivers/nvmem. However, there's no driver for "nvmem-cells" partition
> > platform device. However, the nvmem core creates nvmem_device when
> > nvmem_register() is called by MTD or these partition platform devices
> > created by MTD. But these nvmem_devices are added to a nvmem_bus but
> > the bus has no means to even register a driver (it should really be a
> > nvmem_class and not nvmem_bus).
>
> Srinivas, do you think we could change this?

Yeah, this part gets a bit tricky. It depends on whether the sysfs
files for nvmem devices is considered an ABI. Changing from bus to
class would change the sysfs path for nvmem devices from:
/sys/class/nvmem to /sys/bus/nvmem

> > And the nvmem_device sometimes points
> > to the DT node of the MTD device or sometimes the partition platform
> > devices or maybe no DT node at all.
>
> I guess this comes from the fact that this is not strongly defined in
> mtd and depends on the situation (not mentioning 20 years of history
> there as well). "mtd" is a bit inconsistent on what it means. Older
> designs mixed: controllers, ECC engines when relevant and memories;
> while these three components are completely separated. Hence
> sometimes the mtd device ends up being the top level controller,
> sometimes it's just one partition...
>
> But I'm surprised not all of them point to a DT node. Could you show us
> an example? Because that might likely be unexpected (or perhaps I am
> missing something).

Well, the logic that sets the DT node for nvmem_device is like so:

        if (config->of_node)
                nvmem->dev.of_node =3D config->of_node;
        else if (!config->no_of_node)
                nvmem->dev.of_node =3D config->dev->of_node;

So there's definitely a path (where both if's could be false) where
the DT node will not get set. I don't know if that path is possible
with the existing users of nvmem_register(), but it's definitely
possible.

> > So it's a mess of multiple devices pointing to the same DT node with
> > no clear way to identify which ones will point to a DT node and which
> > ones will probe and which ones won't. In the future, we shouldn't
> > allow adding new compatible strings for partitions for which we don't
> > plan on adding nvmem drivers.
> >
> > Can you give the patch at the end of the email a shot? It should fix
> > the issue with this series and without this series. It just avoids
> > this whole mess by not creating useless platform device for
> > nvmem-cells compatible DT nodes.
>
> Thanks a lot for your help.

No problem. I want fw_devlink to work for everyone.

> >
> > Thanks,
> > Saravana
> >
> > diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> > index d442fa94c872..88a213f4d651 100644
> > --- a/drivers/mtd/mtdpart.c
> > +++ b/drivers/mtd/mtdpart.c
> > @@ -577,6 +577,7 @@ static int mtd_part_of_parse(struct mtd_info *maste=
r,
> >  {
> >         struct mtd_part_parser *parser;
> >         struct device_node *np;
> > +       struct device_node *child;
> >         struct property *prop;
> >         struct device *dev;
> >         const char *compat;
> > @@ -594,6 +595,10 @@ static int mtd_part_of_parse(struct mtd_info *mast=
er,
> >         else
> >                 np =3D of_get_child_by_name(np, "partitions");
> >
> > +       for_each_child_of_node(np, child)
> > +               if (of_device_is_compatible(child, "nvmem-cells"))
> > +                       of_node_set_flag(child, OF_POPULATED);
>
> What about a comment explaining why we need that in the final patch
> (with a comment)? Otherwise it's a little bit obscure.

This wasn't meant to be reviewed :) Just a quick patch to make sure
I'm going down the right path. Once Maxim confirms I was going to roll
this into a proper patch.

But point noted. Will add a comment.

Thanks,
Saravana
