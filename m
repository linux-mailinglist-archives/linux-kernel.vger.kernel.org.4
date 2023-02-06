Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4A168C72D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBFT7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjBFT7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:59:53 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E332A16D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:59:42 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id z1so13345463plg.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 11:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiqZzp1m6352u9cE1eTVGIt8ZCSyeo/MwstDjspPGas=;
        b=X27CqPSsZHQj8wN4Zy+tCNfMySdafRcmUSE8JzjGIH+rCnqM91u56FQY9n4Y9tOoiC
         1badUOr4gvDkC9HegyTNqkS7PXVXlX0sIr7kWdyUFtsNji1ndIebzZaVswFJtJR3bUNN
         9sDvxqWHi+h5dfFzV9bdCPzgAKA6NCi88rrWMu5KGixVf59j16rf5PyPISLFZxb2VNJM
         a9PDMPA2A17USw3ZNEujFVGfsZp5hlr4m8EUbi4QT8blftjOvcC6oqn5P/Ch4sAe/3wi
         qy7dqYpEnvArK2PK38Sw4pAM7NRN0UW/tAknCTL2B7xpLDydxFD3PZVrQcpuMeAxg6Aj
         wnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiqZzp1m6352u9cE1eTVGIt8ZCSyeo/MwstDjspPGas=;
        b=MkTJp5UwispZlj7K7h/XI3dQdcf6ACNOwaH30yKBj4lFjCnCJcigBpKkPxp6f9zjU3
         j8FStnn/duQE82qaGgpx7MtDcmiRkZBnd6Su3szyBs1iS5f9TZGDjGmVQXjld4BpHO/c
         uBRsh8ByrfsVV0jFQlDON+QnqzS2lCee54mbaGFWI9wlyYhD9IDXsvFQYbAISyLbl0X4
         C5Mqj0Ssp74hVAyjfNP3zSvP2jwwk/QjWIooPM4CbWzBla5zectKL9cnvnw3q5I18Jc7
         z/5otr40hVRx28ymlyeAAO7beALSyE0lc8jMe386SpxGqUkemH8ATBD30/7yIzbbxY/O
         lntA==
X-Gm-Message-State: AO0yUKXajz/6qtLFMRXpZjtkXnZx5n50VJyZ8Epxt62UwojbLe545LFh
        ljBMikdsst7FcPGXAAPG4ukG8/TKgu4Yy6AyaVHIQw==
X-Google-Smtp-Source: AK7set+JyeT7jLCGiKnvTEWqHa2pc44cY6ErYmbe7Od9zICdWyAargVkqjl6Av0+DBNxVvLuGTkSjpMxdGScNPiv2V8=
X-Received: by 2002:a17:902:ed52:b0:199:62c:15f1 with SMTP id
 y18-20020a170902ed5200b00199062c15f1mr23982plb.12.1675713581212; Mon, 06 Feb
 2023 11:59:41 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230130085542.38546-1-naresh.kamboju@linaro.org>
 <CAGETcx_411fVxsM-ZMK7j2Bvkmi2TKPbzSuD+03M3cb7WKHfJw@mail.gmail.com>
 <20230131101813.goaoy32qvrowvyyb@bogus> <CALHCpMijXAgQx2qq8g8zdq=6AHwP+g5WVBjjry=v+dKEq9KDLw@mail.gmail.com>
 <CAGETcx_UvW819m1Y-QU_ySB1nG_RegKKT06=YjkK=C_qjbAySw@mail.gmail.com>
 <CALHCpMha_1nXt4rUe+A184XSWpyNk0_PkYjWZ+tUN7BJWqENLA@mail.gmail.com>
 <CAGETcx_uri6exkv1Jkzmc4PyEam9yjuH2H1zrq4LYNtJ+XDMWw@mail.gmail.com> <CAL_Jsq+rLZuQYn-90C1gy_uGEXiGeDNZ3OfumTFcx4pP97sXsg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+rLZuQYn-90C1gy_uGEXiGeDNZ3OfumTFcx4pP97sXsg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 6 Feb 2023 11:59:04 -0800
Message-ID: <CAGETcx96eBBSfHhPvLBxPwUqwF88cv72KxKQ7tJ=3dYDt8JjGQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] fw_devlink improvements
To:     Rob Herring <robh+dt@kernel.org>
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
        miquel.raynal@bootlin.com, rafael@kernel.org,
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

On Mon, Feb 6, 2023 at 7:19 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Sun, Feb 5, 2023 at 7:33 PM Saravana Kannan <saravanak@google.com> wro=
te:
> >
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
> > interaction is kind of a mess. mtd core creates "partition" platform
> > devices (including for nvmem-cells) that are probed by drivers in
> > drivers/nvmem. However, there's no driver for "nvmem-cells" partition
> > platform device. However, the nvmem core creates nvmem_device when
> > nvmem_register() is called by MTD or these partition platform devices
> > created by MTD. But these nvmem_devices are added to a nvmem_bus but
> > the bus has no means to even register a driver (it should really be a
> > nvmem_class and not nvmem_bus). And the nvmem_device sometimes points
> > to the DT node of the MTD device or sometimes the partition platform
> > devices or maybe no DT node at all.
> >
> > So it's a mess of multiple devices pointing to the same DT node with
> > no clear way to identify which ones will point to a DT node and which
> > ones will probe and which ones won't. In the future, we shouldn't
> > allow adding new compatible strings for partitions for which we don't
> > plan on adding nvmem drivers.
>
> That won't work. Having a compatible string cannot mean there must be a d=
river.

Right, I know what you mean Rob and I know where you are coming from
(DT isn't just about Linux or even driver core). But what I'm saying
is that this seems to already be the case for MTD partitions after
commit:
bcdf0315a61a mtd: call of_platform_populate() for MTD partitions

So, if we are adding compatible properties only for some of them, then
I'm saying we should make sure people write drivers for them going
forward.

I don't know enough about MTD partitions to know why only some of them
have compatible properties.

-Saravana
