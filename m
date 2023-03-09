Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0966B1F1B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjCII6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjCII55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:57:57 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F2A4ECCF;
        Thu,  9 Mar 2023 00:56:42 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0DF70C000C;
        Thu,  9 Mar 2023 08:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678352200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OsU9P3Ur2VchpA2JUh4YcUF6jVWgdCHPblwwuyxuAmM=;
        b=EW5TlrV4CQ9Mmh3SXctNaJ3E6vLQDFLpT6USUszQ40PiT/G/H4kAE2HOo8ELaXuTkQPE/7
        PtSBDFGEz5+owBxACqFApT/rEhZ1UxHqNQ0JeqAu7Y49D+uyNiZTkb/3qaS0KlqJ0+rphE
        qIHERnL/qjJdmjUuJZSbLAMEw5XPfRTXbqn2KpThaanjWeSO5BLuTHqBXNc78c2T3tDPoq
        gxPCqP0Lav/+NoCIm4vbutUJeL5h6HwWDWnvPFToYQgPMhmyieIQfmBLWAYQ3xf2jWpDDV
        cBud8//oMxWBO+HUTDJcrxne728LVfY0Y7zyx0qQ98HvdR1wEinFBBmNGtj0Cg==
Date:   Thu, 9 Mar 2023 09:56:31 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org
Subject: Re: [PATCH V2] nvmem: add explicit config option to read OF fixed
 cells
Message-ID: <20230309095631.7b4f610e@xps-13>
In-Reply-To: <af5dfd4701666d4ea50ec1015b1d2e5c@milecki.pl>
References: <20230224072903.20945-1-zajec5@gmail.com>
        <20230308173256.3837b87b@xps-13>
        <91ff425b4c901648b1faf34c784f20ad@milecki.pl>
        <20230308190636.7fabab9c@xps-13>
        <5974d28426057975e701c4a8454b5a13@milecki.pl>
        <20230308193121.7f5b3d02@xps-13>
        <930f3549-440d-adac-ae9d-1aa6ef07c44b@gmail.com>
        <20230309093415.2b1088c8@xps-13>
        <af5dfd4701666d4ea50ec1015b1d2e5c@milecki.pl>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafa=C5=82,

rafal@milecki.pl wrote on Thu, 09 Mar 2023 09:39:54 +0100:

> On 2023-03-09 09:34, Miquel Raynal wrote:
> > Hi Rafa=C5=82,
> >=20
> > zajec5@gmail.com wrote on Thu, 9 Mar 2023 07:56:05 +0100:
> >  =20
> >> On 8.03.2023 19:31, Miquel Raynal wrote: =20
> >> > Hi Rafa=C5=82,
> >> >
> >> > rafal@milecki.pl wrote on Wed, 08 Mar 2023 19:12:32 +0100:
> >> > =20
> >> >> On 2023-03-08 19:06, Miquel Raynal wrote: =20
> >> >>> Hi Rafa=C5=82,
> >> >>>
> >> >>> rafal@milecki.pl wrote on Wed, 08 Mar 2023 17:55:46 +0100: =20
> >> >>>    >>>> On 2023-03-08 17:34, Miquel Raynal wrote: =20
> >> >>>>> Hi Rafa=C5=82,
> >> >>>>>
> >> >>>>> zajec5@gmail.com wrote on Fri, 24 Feb 2023 08:29:03 +0100: =20
> >> >>>>>   >>>>>> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl> =20
> >> >>>>>>>> NVMEM subsystem looks for fixed NVMEM cells (specified in DT)=
 by =20
> >> >>>>>> default. This behaviour made sense in early days before adding =
support
> >> >>>>>> for dynamic cells. =20
> >> >>>>>>>> With every new supported NVMEM device with dynamic cells curr=
ent =20
> >> >>>>>> behaviour becomes non-optimal. It results in unneeded iterating=
 over >> DT
> >> >>>>>> nodes and may result in false discovery of cells (depending on =
used DT
> >> >>>>>> properties). =20
> >> >>>>>>>> This behaviour has actually caused a problem already with the=
 MTD =20
> >> >>>>>> subsystem. MTD subpartitions were incorrectly treated as NVMEM =
cells. =20
> >> >>>>>
> >> >>>>> That's true, but I expect this to be really MTD specific.
> >> >>>>>
> >> >>>>> A concrete proposal below. =20
> >> >>>>>   >>>>>> Also with upcoming support for NVMEM layouts no new bin=
ding or driver =20
> >> >>>>>> should support fixed cells defined in device node. =20
> >> >>>>>
> >> >>>>> I'm not sure I agree with this statement. We are not preventing =
new
> >> >>>>> binding/driver to use fixed cells, or...? We offer a new way to =
expose
> >> >>>>> nvmem cells with another way than "fixed-offset" and "fixed-size=
" OF
> >> >>>>> nodes. =20
> >> >>>>>>   From what I understood all new NVMEM bindings should have cel=
ls >> defined =20
> >> >>>> in the nvmem-layout { } node. That's what I mean by saying they s=
hould
> >> >>>> not be defined in device node (but its "nvmem-layout" instead). =
=20
> >> >>>
> >> >>> Layouts are just another possibility, either you user the nvmem-ce=
lls
> >> >>> compatible and produce nvmem cells with fixed OF nodes, or you use=
 the
> >> >>> nvmem-layout container. I don't think all new bindings should have
> >> >>> cells in layouts. It depends if the content is static or not. =20
> >> >>>    >>>>>> Solve this by modifying drivers for bindings that suppor=
t specifying =20
> >> >>>>>> fixed NVMEM cells in DT. Make them explicitly tell NVMEM subsys=
tem to
> >> >>>>>> read cells from DT. =20
> >> >>>>>>>> It wasn't clear (to me) if rtc and w1 code actually uses fixe=
d cells. >> I =20
> >> >>>>>> enabled them to don't risk any breakage. =20
> >> >>>>>>>> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl> =20
> >> >>>>>> [for drivers/nvmem/meson-{efuse,mx-efuse}.c]
> >> >>>>>> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.c=
om>
> >> >>>>>> ---
> >> >>>>>> V2: Fix stm32-romem.c typo breaking its compilation
> >> >>>>>>      Pick Martin's Acked-by
> >> >>>>>>      Add paragraph about layouts deprecating use_fixed_of_cells
> >> >>>>>> ---
> >> >>>>>>   drivers/mtd/mtdcore.c          | 2 ++
> >> >>>>>>   drivers/nvmem/apple-efuses.c   | 1 +
> >> >>>>>>   drivers/nvmem/core.c           | 8 +++++---
> >> >>>>>>   drivers/nvmem/imx-ocotp-scu.c  | 1 +
> >> >>>>>>   drivers/nvmem/imx-ocotp.c      | 1 +
> >> >>>>>>   drivers/nvmem/meson-efuse.c    | 1 +
> >> >>>>>>   drivers/nvmem/meson-mx-efuse.c | 1 +
> >> >>>>>>   drivers/nvmem/microchip-otpc.c | 1 +
> >> >>>>>>   drivers/nvmem/mtk-efuse.c      | 1 +
> >> >>>>>>   drivers/nvmem/qcom-spmi-sdam.c | 1 +
> >> >>>>>>   drivers/nvmem/qfprom.c         | 1 +
> >> >>>>>>   drivers/nvmem/rave-sp-eeprom.c | 1 +
> >> >>>>>>   drivers/nvmem/rockchip-efuse.c | 1 +
> >> >>>>>>   drivers/nvmem/sc27xx-efuse.c   | 1 +
> >> >>>>>>   drivers/nvmem/sprd-efuse.c     | 1 +
> >> >>>>>>   drivers/nvmem/stm32-romem.c    | 1 +
> >> >>>>>>   drivers/nvmem/sunplus-ocotp.c  | 1 +
> >> >>>>>>   drivers/nvmem/sunxi_sid.c      | 1 +
> >> >>>>>>   drivers/nvmem/uniphier-efuse.c | 1 +
> >> >>>>>>   drivers/nvmem/zynqmp_nvmem.c   | 1 +
> >> >>>>>>   drivers/rtc/nvmem.c            | 1 +
> >> >>>>>>   drivers/w1/slaves/w1_ds250x.c  | 1 +
> >> >>>>>>   include/linux/nvmem-provider.h | 2 ++
> >> >>>>>>   23 files changed, 29 insertions(+), 3 deletions(-) =20
> >> >>>>>>>> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c =20
> >> >>>>>> index 0feacb9fbdac..1bb479c0f758 100644
> >> >>>>>> --- a/drivers/mtd/mtdcore.c
> >> >>>>>> +++ b/drivers/mtd/mtdcore.c
> >> >>>>>> @@ -523,6 +523,7 @@ static int mtd_nvmem_add(struct mtd_info *m=
td)
> >> >>>>>>   	config.dev =3D &mtd->dev;
> >> >>>>>>   	config.name =3D dev_name(&mtd->dev);
> >> >>>>>>   	config.owner =3D THIS_MODULE;
> >> >>>>>> +	config.use_fixed_of_cells =3D of_device_is_compatible(node, >=
> "nvmem-cells"); =20
> >> >>>>>
> >> >>>>> I am wondering how mtd specific this is? For me all OF nodes con=
taining
> >> >>>>> the nvmem-cells compatible should be treated as cells providers =
and
> >> >>>>> populate nvmem cells as for each children.
> >> >>>>>
> >> >>>>> Why don't we just check for this compatible to be present? in
> >> >>>>> nvmem_add_cells_from_of() ? And if not we just skip the operatio=
n.
> >> >>>>>
> >> >>>>> This way we still follow the bindings (even though using nvmem-c=
ells in
> >> >>>>> the compatible property to require cells population was a mistak=
e in
> >> >>>>> the first place, as discussed in the devlink thread recently) bu=
t there
> >> >>>>> is no need for a per-driver config option? =20
> >> >>>>>> This isn't mtd specific. Please check this patch for all occurr=
ences >> of =20
> >> >>>> the:
> >> >>>> use_fixed_of_cells =3D true =20
> >> >>>>>> The very first one: drivers/nvmem/apple-efuses.c driver for the=
 =20
> >> >>>> "apple,efuses" binding. That binding supports fixed OF cells, see:
> >> >>>> Documentation/devicetree/bindings/nvmem/apple,efuses.yaml =20
> >> >>>
> >> >>> I'm saying: based on what has been enforced so far, I would expect=
 all
> >> >>> fixed cell providers to come with nvmem-cells as compatible, no?
> >> >>>
> >> >>> If that's the case we could use that as a common denominator? =20
> >> >>
> >> >> Sorry, I don't get it. Have you checked
> >> >> Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
> >> >> ?
> >> >>
> >> >> It's a NVMEM provied binding with fixed cells that doesn't use
> >> >> nvmem-cells as compatible. There are many more. =20
> >> >
> >> > Oh yeah you're right, I'm mixing things. Well I guess you're right
> >> > then, it's such a mess, we have to tell the core the parsing method.
> >> >
> >> > So maybe another question: do we have other situations than mtd which
> >> > sometimes expect the nvmem core to parse the OF nodes to populate ce=
lls,
> >> > and sometimes not? =20
> >> >> I'm not aware of that. Please also check my patch. The only case I =
set =20
> >> "use_fixed_of_cells" conditionally is mtd code. In other cases it's
> >> hardcoded to "true". =20
> >> >> >> > Also, what about "of_children_are_cells" ? Because actually in=
 most =20
> >> > cases it's a "fixed of cell", so I don't find the current naming
> >> > descriptive enough for something so touchy. =20
> >> >> That would be just incorrect because this new config property =20
> >> ("use_fixed_of_cells") is only about FIXED cells. =20
> >> >> There are cases of OF children being cells but NOT being fixed cell=
s. =20
> >> They should NOT be parsed by the nvmem_add_cells_from_of(). =20
> >> >> Example: =20
> >> a607a850ba1f ("dt-bindings: nvmem: u-boot,env: add basic NVMEM cells")
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3Da607a850ba1fa966cbb035544c1588e24a6307df =20
> >=20
> > This is backwards. That's why layouts have been proposed: having
> > a clear framework were the nvmem core should or should not play with
> > the OF children nodes. If each binding is different, you end up with
> > the mess we have today, where nobody knows how to properly
> > populate the cells.
> >=20
> > Anyway, it's not a big deal either, if the cells are empty we can
> > easily check that and have *yet another* specific case in the core.
> >  =20
> >> So that would result in U-Boot env:
> >> 1. Having OF children nodes being cells
> >> 2. Setting "of_children_are_cells" to false (counter-intuitive) to >> =
avoid nvmem_add_cells_from_of() =20
> >=20
> > Agreed. So what about config.ignore_of_children?
> > - mtd sets this to !is_compatible(nvmem-cells)
> > - nobody else touches it (the core don't try to parse the cell if it's
> >   empty so U-Boot env driver works) =20
>=20
> "ignore_of_children" would have opposite (reversed) meaning to the
> "use_fixed_of_cells":
> 1. By default it would be 0 / false
> 2. By default NVMEM code would NOT ignore OF children nodes
>=20
> That is what I actually *don't* want.
>=20
> Having NVMEM core look for fixed cells in device node is undesirable.

Is it?

I think this is the standard case. Most of the time fixed cells are
the simplest and most direct approach. I don't get why we would like
to prevent it at some point? Only the more advanced stuff that does not
fit the purpose of fixed OF cells should go through layouts.

> I want that feature to be off by default. I want devices to have to
> enable it explicitly only when it's needed.

Well, that's exactly the opposite of what nvmem does right now, that's
maybe why reviewers don't get the interest of the current
implementation: it has many impacts on users which should not be
impacted just because we messed with mtd.

Thanks,
Miqu=C3=A8l
