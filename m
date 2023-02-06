Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7192968B3E3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBFBds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBFBdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:33:41 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B48A16AFF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 17:33:35 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id n2so7332451pfo.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 17:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kR2veBWbyNFgGYItTwFdh8lQbfIA4xIECeB4pO18LrU=;
        b=PFwbPgvDzQZdf/HQcszjkJRBI+TWwVFkCgQ1pTZtuRTIo/wlIT3BHJKZePYl3rA+JP
         95hFB5vyzqBz1Jc54SILNs4ShJ7POM1/z2u66WJgYrGohpZnBl1sBMdI0mKh7YShxBiz
         2w1gVgSrKCBfhH4ANXDeYDIYzg7AsUBAinEloUsjVb7gYNAHQoWVKnGUFh6d4pnFpoQb
         1Q95oO5u5QznQa0IK6GWq/1414ezGBU9VQsaDUenD0Pmd8P7aAztAaPsq9YWbsbIqMc2
         poo5WlAJbhJjVL7wJeGcis+SKQ5KrWaWg/FwaNXAFve7SvEGnI7TLg35saERb0k96x+I
         luxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kR2veBWbyNFgGYItTwFdh8lQbfIA4xIECeB4pO18LrU=;
        b=am/wk6TEU+jMFjT9I+a+JBGQLnpznu8VrGGDhFRXbyJOxrg9lPNzmG1GIlWToE2YYt
         r6tiadyvFLqg9yCMDBrs/hWk2MDOFs6r1xyLs2Z1knbDmxBL9aRmxio24FoJmdj9uj4J
         m0fRatt16Tx6DUdKCifLPyUFiJ8yRfkD1bF90fSC71AB1wtOWrKzOo+xlZO7VFz9UXTn
         GlL/4tf8EBAAhipKXew0Wk40E53YmxHKwqB3QtQDFBcKuskENzJE9CuhUI7wOKcvnN6J
         jG0k8yJbUWM38k4r46fNR4NLJGjtfHyyI0n5zY0GxpYW4HGPR+eOidbjttkfmm/pjRVX
         Lr6g==
X-Gm-Message-State: AO0yUKUMouwO4RjusRLeaNxYhsYkOuipEt3vdB+yp9bXQp8Z0sMBEn91
        2UKiwWFhhABcipozrEJOnorqz9/Zx7VCGgCxB/jnkA==
X-Google-Smtp-Source: AK7set8u1D8Yx0Ns1ik9250I6OIYVxsmLToiLi2hjLdTsjiKPoILrZB8aX+YQXBoINv9ErwXZE6Ko7BYs7yfuVc+TPE=
X-Received: by 2002:a62:1a57:0:b0:593:bac2:b49 with SMTP id
 a84-20020a621a57000000b00593bac20b49mr4285651pfa.44.1675647214386; Sun, 05
 Feb 2023 17:33:34 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230130085542.38546-1-naresh.kamboju@linaro.org>
 <CAGETcx_411fVxsM-ZMK7j2Bvkmi2TKPbzSuD+03M3cb7WKHfJw@mail.gmail.com>
 <20230131101813.goaoy32qvrowvyyb@bogus> <CALHCpMijXAgQx2qq8g8zdq=6AHwP+g5WVBjjry=v+dKEq9KDLw@mail.gmail.com>
 <CAGETcx_UvW819m1Y-QU_ySB1nG_RegKKT06=YjkK=C_qjbAySw@mail.gmail.com> <CALHCpMha_1nXt4rUe+A184XSWpyNk0_PkYjWZ+tUN7BJWqENLA@mail.gmail.com>
In-Reply-To: <CALHCpMha_1nXt4rUe+A184XSWpyNk0_PkYjWZ+tUN7BJWqENLA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sun, 5 Feb 2023 17:32:57 -0800
Message-ID: <CAGETcx_uri6exkv1Jkzmc4PyEam9yjuH2H1zrq4LYNtJ+XDMWw@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] fw_devlink improvements
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
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
        miquel.raynal@bootlin.com, rafael@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, sakari.ailus@linux.intel.com,
        shawnguo@kernel.org, tglx@linutronix.de, tony@atomide.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 3, 2023 at 1:39 AM Maxim Kiselev <bigunclemax@gmail.com> wrote:
>
> =D0=BF=D1=82, 3 =D1=84=D0=B5=D0=B2=D1=80. 2023 =D0=B3. =D0=B2 09:07, Sara=
vana Kannan <saravanak@google.com>:
> >
> > On Thu, Feb 2, 2023 at 9:36 AM Maxim Kiselev <bigunclemax@gmail.com> wr=
ote:
> > >
> > > Hi Saravana,
> > >
> > > > Can you try the patch at the end of this email under these
> > > > configurations and tell me which ones fail vs pass? I don't need lo=
gs
> > >
> > > I did these tests and here is the results:
> >
> > Did you hand edit the In-Reply-To: in the header? Because in the
> > thread you are reply to the wrong email, but the context in your email
> > seems to be from the right email.
> >
> > For example, see how your reply isn't under the email you are replying
> > to in this thread overview:
> > https://lore.kernel.org/lkml/20230127001141.407071-1-saravanak@google.c=
om/#r
> >
> > > 1. On top of this series - Not works
> > > 2. Without this series    - Works
> > > 3. On top of the series with the fwnode_dev_initialized() deleted - N=
ot works
> > > 4. Without this series, with the fwnode_dev_initialized() deleted  - =
Works
> > >
> > > So your nvmem/core.c patch helps only when it is applied without the =
series.
> > > But despite the fact that this helps to avoid getting stuck at probin=
g
> > > my ethernet device, there is still regression.
> > >
> > > When the ethernet module is loaded it takes a lot of time to drop dep=
endency
> > > from the nvmem-cell with mac address.
> > >
> > > Please look at the kernel logs below.
> >
> > The kernel logs below really aren't that useful for me in their
> > current state. See more below.
> >
> > ---8<---- <snip> --->8----
> >
> > > P.S. Your nvmem patch definitely helps to avoid a device probe stuck
> > > but look like it is not best way to solve a problem which we discusse=
d
> > > in the MTD thread.
> > >
> > > P.P.S. Also I don't know why your nvmem-cell patch doesn't help when =
it was
> > > applied on top of this series. Maybe I missed something.
> >
> > Yeah, I'm not too sure if the test was done correctly. You also didn't
> > answer my question about the dts from my earlier email.
> > https://lore.kernel.org/lkml/CAGETcx8FpmbaRm2CCwqt3BRBpgbogwP5gNB+iA5OE=
tuxWVTNLA@mail.gmail.com/#t
> >
> > So, can you please retest config 1 with all pr_debug and dev_dbg in
> > drivers/core/base.c changed to the _info variants? And then share the
> > kernel log from the beginning of boot? Maybe attach it to the email so
> > it doesn't get word wrapped by your email client. And please point me
> > to the .dts that corresponds to your board. Without that, I can't
> > debug much.
> >
> > Thanks,
> > Saravana
>
> > Did you hand edit the In-Reply-To: in the header? Because in the
> > thread you are reply to the wrong email, but the context in your email
> > seems to be from the right email.
>
> Sorry for that, it seems like I accidently deleted it.
>
> > So, can you please retest config 1 with all pr_debug and dev_dbg in
> > drivers/core/base.c changed to the _info variants? And then share the
> > kernel log from the beginning of boot? Maybe attach it to the email so
> > it doesn't get word wrapped by your email client. And please point me
> > to the .dts that corresponds to your board. Without that, I can't
> > debug much.
>
> Ok, I retested config 1 with all _debug logs changed to the _info. I
> added the kernel log and the dts file to the attachment of this email.

Ah, so your device is not supported/present upstream? Even though it's
not upstream, I'll help fix this because it should fix what I believe
are unreported issues in upstream.

Ok I know why configs 1 - 4 behaved the way they did and why my test
patch didn't help.

After staring at mtd/nvmem code for a few hours I think mtd/nvmem
interaction is kind of a mess. mtd core creates "partition" platform
devices (including for nvmem-cells) that are probed by drivers in
drivers/nvmem. However, there's no driver for "nvmem-cells" partition
platform device. However, the nvmem core creates nvmem_device when
nvmem_register() is called by MTD or these partition platform devices
created by MTD. But these nvmem_devices are added to a nvmem_bus but
the bus has no means to even register a driver (it should really be a
nvmem_class and not nvmem_bus). And the nvmem_device sometimes points
to the DT node of the MTD device or sometimes the partition platform
devices or maybe no DT node at all.

So it's a mess of multiple devices pointing to the same DT node with
no clear way to identify which ones will point to a DT node and which
ones will probe and which ones won't. In the future, we shouldn't
allow adding new compatible strings for partitions for which we don't
plan on adding nvmem drivers.

Can you give the patch at the end of the email a shot? It should fix
the issue with this series and without this series. It just avoids
this whole mess by not creating useless platform device for
nvmem-cells compatible DT nodes.

Thanks,
Saravana

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index d442fa94c872..88a213f4d651 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -577,6 +577,7 @@ static int mtd_part_of_parse(struct mtd_info *master,
 {
        struct mtd_part_parser *parser;
        struct device_node *np;
+       struct device_node *child;
        struct property *prop;
        struct device *dev;
        const char *compat;
@@ -594,6 +595,10 @@ static int mtd_part_of_parse(struct mtd_info *master,
        else
                np =3D of_get_child_by_name(np, "partitions");

+       for_each_child_of_node(np, child)
+               if (of_device_is_compatible(child, "nvmem-cells"))
+                       of_node_set_flag(child, OF_POPULATED);
+
        of_property_for_each_string(np, "compatible", prop, compat) {
                parser =3D mtd_part_get_compatible_parser(compat);
                if (!parser)
