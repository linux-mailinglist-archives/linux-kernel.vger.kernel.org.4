Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E8168B41A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 03:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjBFCRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 21:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBFCRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 21:17:42 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70109144A4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 18:17:40 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id pj3so10289079pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 18:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSCcBfpFx27k5jo73WqKC+GBby05AcR0pwPtUdl1A78=;
        b=IDldv4T93/suoqaYrQKEpYs3Shk6Y7pMmWyNV6gbNcmg0H5/Z7ncZDkATuEQvIFJ5U
         SzI6R53ESC2ljqT203Fhg3cnDSSBeHmPkjKwQ1L5TYD3I2F83ME8IGnrA6uBH1i7ugQT
         mVvvm/BiJtTGjPq6pb5o/7jf1xGH6MZH0NJ6IqSlmFyKjc/s/0P4W6iIrDMk9Y11wskY
         +Vl/+OOZl2J+nZ39NLtCs8VQg80O+CQo/slgUdjqd5VJ0U458HpJQJn44I0jqgfR/ScC
         uJOTDzd9ug2k8rMSShxLOcW9hHfgPCnHpwNcd1sTELat7+nfNpEFUP+BLOj482fRY+B+
         dxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSCcBfpFx27k5jo73WqKC+GBby05AcR0pwPtUdl1A78=;
        b=PpAYwEFJREIfOSxfzlrBKJ4OIL56w1ZO67LB/1sjzFPcxJtiR5LML44TNadNww5Da5
         cE9KhKRRq9/GV8LqK3a3p13vjs6cTLjYM2n4JzFq23L33YfjZaVn7bZjU7DF/5nUJB0Y
         REDy83sw54K/4/XyAHizF1DC/o51SGv1GXiEw04ym4cAEqLRQ4Pw056M6hnQUVxhN8GI
         ZKeM6TxmWgwfJ7zIKf3dVb3/4olIN1mRHADB3Lmmvye5L4K9UIt0yDVofBdrQ5yyPlfM
         sfDo1QnWW2mnhCg7NTOlLYNUYJ2qvV+C9CqEw0fkHkWqgiukUVWc8YpAV2I9nORFFQ+F
         oPHQ==
X-Gm-Message-State: AO0yUKVprtdY+JC1gMwTVYFXglWfJvTTrAEI9qb/zJx+zhajzhQoUFc5
        XCYXfrhWoVPtedqsx0Gg7AIBLQUepUlQnLV9B9OmuA==
X-Google-Smtp-Source: AK7set+tOTHApHonHnBpeI6ZdKUgknUlBl3MOGuRo05rSkn/czViDIZrFElGEtlIrThIyT6ZaWv3ixomXgyAd71eq1g=
X-Received: by 2002:a17:90a:187:b0:22c:ad5e:e1e3 with SMTP id
 7-20020a17090a018700b0022cad5ee1e3mr2933993pjc.141.1675649858903; Sun, 05 Feb
 2023 18:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230130085542.38546-1-naresh.kamboju@linaro.org>
 <CAGETcx_411fVxsM-ZMK7j2Bvkmi2TKPbzSuD+03M3cb7WKHfJw@mail.gmail.com>
 <20230131101813.goaoy32qvrowvyyb@bogus> <CALHCpMijXAgQx2qq8g8zdq=6AHwP+g5WVBjjry=v+dKEq9KDLw@mail.gmail.com>
 <CAGETcx_UvW819m1Y-QU_ySB1nG_RegKKT06=YjkK=C_qjbAySw@mail.gmail.com>
 <CALHCpMha_1nXt4rUe+A184XSWpyNk0_PkYjWZ+tUN7BJWqENLA@mail.gmail.com> <CAGETcx_uri6exkv1Jkzmc4PyEam9yjuH2H1zrq4LYNtJ+XDMWw@mail.gmail.com>
In-Reply-To: <CAGETcx_uri6exkv1Jkzmc4PyEam9yjuH2H1zrq4LYNtJ+XDMWw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sun, 5 Feb 2023 18:17:01 -0800
Message-ID: <CAGETcx8Hv+V4zn3q7fPf0bkddrk=8Ne4iVctO0hR+nkxxFX1Kw@mail.gmail.com>
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

On Sun, Feb 5, 2023 at 5:32 PM Saravana Kannan <saravanak@google.com> wrote=
:
>
> On Fri, Feb 3, 2023 at 1:39 AM Maxim Kiselev <bigunclemax@gmail.com> wrot=
e:
> >
> > =D0=BF=D1=82, 3 =D1=84=D0=B5=D0=B2=D1=80. 2023 =D0=B3. =D0=B2 09:07, Sa=
ravana Kannan <saravanak@google.com>:
> > >
> > > On Thu, Feb 2, 2023 at 9:36 AM Maxim Kiselev <bigunclemax@gmail.com> =
wrote:
> > > >
> > > > Hi Saravana,
> > > >
> > > > > Can you try the patch at the end of this email under these
> > > > > configurations and tell me which ones fail vs pass? I don't need =
logs
> > > >
> > > > I did these tests and here is the results:
> > >
> > > Did you hand edit the In-Reply-To: in the header? Because in the
> > > thread you are reply to the wrong email, but the context in your emai=
l
> > > seems to be from the right email.
> > >
> > > For example, see how your reply isn't under the email you are replyin=
g
> > > to in this thread overview:
> > > https://lore.kernel.org/lkml/20230127001141.407071-1-saravanak@google=
.com/#r
> > >
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
> > > > Please look at the kernel logs below.
> > >
> > > The kernel logs below really aren't that useful for me in their
> > > current state. See more below.
> > >
> > > ---8<---- <snip> --->8----
> > >
> > > > P.S. Your nvmem patch definitely helps to avoid a device probe stuc=
k
> > > > but look like it is not best way to solve a problem which we discus=
sed
> > > > in the MTD thread.
> > > >
> > > > P.P.S. Also I don't know why your nvmem-cell patch doesn't help whe=
n it was
> > > > applied on top of this series. Maybe I missed something.
> > >
> > > Yeah, I'm not too sure if the test was done correctly. You also didn'=
t
> > > answer my question about the dts from my earlier email.
> > > https://lore.kernel.org/lkml/CAGETcx8FpmbaRm2CCwqt3BRBpgbogwP5gNB+iA5=
OEtuxWVTNLA@mail.gmail.com/#t
> > >
> > > So, can you please retest config 1 with all pr_debug and dev_dbg in
> > > drivers/core/base.c changed to the _info variants? And then share the
> > > kernel log from the beginning of boot? Maybe attach it to the email s=
o
> > > it doesn't get word wrapped by your email client. And please point me
> > > to the .dts that corresponds to your board. Without that, I can't
> > > debug much.
> > >
> > > Thanks,
> > > Saravana
> >
> > > Did you hand edit the In-Reply-To: in the header? Because in the
> > > thread you are reply to the wrong email, but the context in your emai=
l
> > > seems to be from the right email.
> >
> > Sorry for that, it seems like I accidently deleted it.
> >
> > > So, can you please retest config 1 with all pr_debug and dev_dbg in
> > > drivers/core/base.c changed to the _info variants? And then share the
> > > kernel log from the beginning of boot? Maybe attach it to the email s=
o
> > > it doesn't get word wrapped by your email client. And please point me
> > > to the .dts that corresponds to your board. Without that, I can't
> > > debug much.
> >
> > Ok, I retested config 1 with all _debug logs changed to the _info. I
> > added the kernel log and the dts file to the attachment of this email.
>
> Ah, so your device is not supported/present upstream? Even though it's
> not upstream, I'll help fix this because it should fix what I believe
> are unreported issues in upstream.
>
> Ok I know why configs 1 - 4 behaved the way they did and why my test
> patch didn't help.
>
> After staring at mtd/nvmem code for a few hours I think mtd/nvmem
> interaction is kind of a mess. mtd core creates "partition" platform
> devices (including for nvmem-cells) that are probed by drivers in
> drivers/nvmem. However, there's no driver for "nvmem-cells" partition
> platform device. However, the nvmem core creates nvmem_device when
> nvmem_register() is called by MTD or these partition platform devices
> created by MTD. But these nvmem_devices are added to a nvmem_bus but
> the bus has no means to even register a driver (it should really be a
> nvmem_class and not nvmem_bus). And the nvmem_device sometimes points
> to the DT node of the MTD device or sometimes the partition platform
> devices or maybe no DT node at all.
>
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

Actually, without this series, the patch below will need an additional
line of code inside the if block:
fwnode_dev_initialized(of_fwnode_handle(child), true);

-Saravana

>
> Thanks,
> Saravana
>
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
> @@ -594,6 +595,10 @@ static int mtd_part_of_parse(struct mtd_info *master=
,
>         else
>                 np =3D of_get_child_by_name(np, "partitions");
>
> +       for_each_child_of_node(np, child)
> +               if (of_device_is_compatible(child, "nvmem-cells"))
> +                       of_node_set_flag(child, OF_POPULATED);
> +
>         of_property_for_each_string(np, "compatible", prop, compat) {
>                 parser =3D mtd_part_get_compatible_parser(compat);
>                 if (!parser)
