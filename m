Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249C95B5F01
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiILRQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiILRP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:15:58 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A725237190
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:15:54 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id u19-20020a4a9e93000000b004757198549cso558476ook.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qd0zc7fGhqBh9AbN0Tbs1DG34cl/lreYFTNXxxRPmTs=;
        b=hck1MJGckV938hOMLfxLlSjnhjEBraOtrc7lREdlBCM5HFTGV3OZmPEvv5+3Sl21Ap
         Yt8LYSgZqBQtdQ2k0zhHPsnBejGIGzLaSPovYIKxSDC1LaI5amhPapXUvT9FQi9phAAl
         APnbZ9b4NRtkMh/w6LSKndFaZ46/HAxjxPRS5bkrpByQmpqxoReePPBAfgOJ01jpMoU2
         /P8CeaHv3o42/byWvGXeghO9CiF8pNre8pq1RtmqAm3KGJONZr/z85bvCZQQJTntwITy
         45HragL26K0ZDJpXE9Lv78ZpVz7VbzsWHw7w0Jei8o7DQRc7L0mEJke1XLliz+XifV5C
         +LOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qd0zc7fGhqBh9AbN0Tbs1DG34cl/lreYFTNXxxRPmTs=;
        b=Io2deCaIJ8WTYdxwpbGhFQvhk9M0lG85O3VyVrloXCSSxhQxjgSpdmctQYn4jcleE2
         QWdBiBEMCHH5GxwdQDizxMU4aGPrkctpi6WMl8EHWDZ5KX2k6WQX6l1bxbHTApX7P4C3
         zd4wZ/m4MV1HtzhT0ENZwZgFZQz4JvNXblfqTI9ONkJu5Gasq1Fp6cF3omStmIC3S4SQ
         UVvMHf5CDTJ9kWOEs4/br9c4kc1967IlHp44rvk9O8rM2tJ/pilRVeVBJiKFdT60Tn8y
         +JccvvHdKPrOMAuRg60fYg8E4G0tkavXzIqg/qPJXciihjjsKl3OhrG4U6FyeMDZRgcq
         fA5Q==
X-Gm-Message-State: ACgBeo3frU0q4H1BqaVpT0fBhKdF0uMRLJBy5pZ7SYyk5h5E8zF7Kx57
        BmvnJx8UqC4Pf6Ke2MByVpxEjEwwwLxEAfnzZlY3fA==
X-Google-Smtp-Source: AA6agR43q0bMJeMBvFXtfEf6TWC5gpWwhhZExSPS8FjHBG1FMoG4Nf/q0qjSadXElNF6V3I0rO/tOqbOYvTr3ZQ8qHA=
X-Received: by 2002:a4a:1b03:0:b0:475:4a4c:e29d with SMTP id
 3-20020a4a1b03000000b004754a4ce29dmr5041258oop.79.1663002953138; Mon, 12 Sep
 2022 10:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU1Za2CPGVX3q4HKufsxbL5zRrk1B5CWFpKritetrTs4dA@mail.gmail.com>
 <59b6dd0a-7cbb-5dbd-8da0-57baeba3327e@gmail.com> <CAJ+vNU2FVQRwCa3DnOwkFjaZg-ntFLZmetwDbSggDXDdwOOGTg@mail.gmail.com>
 <2ab24cc4-4aa2-d364-9b29-55f5d6b23626@denx.de> <CAJ+vNU0voeMW06Je6nyrV1Ud3sT8Us+RACcQtsKUwKVaXF+dQw@mail.gmail.com>
 <ce0ffc43-bae7-a55b-ebea-985abc765c33@denx.de> <DU0PR04MB9417D8123D40FBC980E9C05388439@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <a03ce7a3-dfa5-6016-afbf-33193a5e2376@denx.de> <8736ba4e-1c61-995a-f090-ef322d84e5f6@gmail.com>
 <0c924574-d2b4-2a23-0cc2-63f32d521854@oss.nxp.com>
In-Reply-To: <0c924574-d2b4-2a23-0cc2-63f32d521854@oss.nxp.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 12 Sep 2022 10:15:41 -0700
Message-ID: <CAJ+vNU1NW9cDDB4sa+uLK3G1Z782pPe=E=GtYLTswR2Xa1YnoQ@mail.gmail.com>
Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
To:     Peng Fan <peng.fan@oss.nxp.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 12:40 AM Peng Fan <peng.fan@oss.nxp.com> wrote:
>
>
>
> On 9/9/2022 1:06 PM, Matti Vaittinen wrote:
> > Hi dee Ho peeps,
> >
> > On 9/9/22 05:35, Marek Vasut wrote:
> >> On 9/9/22 04:06, Peng Fan wrote:
> >>>> Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT
> >>>> failure
> >>>>
> >>>> On 9/8/22 21:25, Tim Harvey wrote:
> >>>>> On Thu, Sep 8, 2022 at 9:55 AM Marek Vasut <marex@denx.de> wrote:
> >>>>>>
> >>>>>> On 9/8/22 18:00, Tim Harvey wrote:
> >>>>>>> On Thu, Sep 1, 2022 at 9:14 PM Matti Vaittinen
> >>>> <mazziesaccount@gmail.com> wrote:
> >>>>>>>>
> >>>>>>>> Hi Tim,
> >>>>>>>>
> >>>>>>>> On 9/2/22 01:23, Tim Harvey wrote:
> >>>>>>>>> Greetings,
> >>>>>>>>>
> >>>>>>>>> I've found that the bd71847 clk driver
> >>>> (CONFIG_COMMON_CLK_BD718XX
> >>>>>>>>> drivers/clk/clk-bd718x7.c) disables clk-32k-out (the BD71847
> >>>>>>>>> C32K_OUT
> >>>>>>>>> pin) which is connected IMX8MM RTC_XTALI which ends up disabling
> >>>>>>>>> the IMX RTC as well as the IMX WDOG functionality.
> >>>>>>>>
> >>>>>>>> //snip
> >>>>>>>>
> >>>>>>>>> This happens via clk_unprepare_unused() as nothing is flagging the
> >>>>>>>>> clk-32k-out as being used. What should be added to the device-tree
> >>>>>>>>> to signify that this clk is indeed necessary and should not be
> >>>>>>>>> disabled?
> >>>>>>>>
> >>>>>>>> I have seen following proposal from Marek Vasut:
> >>>>>>>>
> >>>>>>>>
> >>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fl
> >>>>>>>> ore.kernel.org%2Fall%2F20220517235919.200375-1-
> >>>> marex%40denx.de%2FT%
> >>>>>>>>
> >>>> 2F%23m52d6d0831bf43d5f293e35cb27f3021f278d0564&amp;data=05%7C0
> >>>> 1%7Cp
> >>>>>>>>
> >>>> eng.fan%40nxp.com%7C07d48edcc47c4694e08208da91da2bf4%7C686ea1d
> >>>> 3bc2b
> >>>>>>>>
> >>>> 4c6fa92cd99c5c301635%7C0%7C0%7C637982664162868785%7CUnknown%
> >>>> 7CTWFpb
> >>>>>>>>
> >>>> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> >>>> 6
> >>>>>>>>
> >>>> Mn0%3D%7C3000%7C%7C%7C&amp;sdata=uF26u9g4onuqCWzPRAvD%2F%
> >>>> 2FLByaEhh5
> >>>>>>>> Dtah9K8CcAOAM%3D&amp;reserved=0
> >>>>>>>>
> >>>>>>>> I am not sure if the discussion is completed though. I guess it was
> >>>>>>>> agreed this was needed/usefull and maybe the remaining thing to
> >>>>>>>> decide was just the property naming.
> >>>>>>>>
> >>>>>>>> Best Regards
> >>>>>>>>            -- Matti
> >>>>>>>>
> >>>>>>>
> >>>>>>> Thanks Matti,
> >>>>>>>
> >>>>>>> Marek - has there been any progress on determining how best to keep
> >>>>>>> certain clocks from being disabled?
> >>>>>>
> >>>>>> No. You can read the discussion above.
> >>>>>
> >>>>> Marek,
> >>>>>
> >>>>> I wasn't on the linux-clk list at that time so can't respond to the
> >>>>> thread but the discussion seems to have died out a couple of months
> >>>>> ago with no agreement between you or Stephen on how to deal with it.
> >>>>>
> >>>>> So where do we take this from here? It looks like there are about 18
> >>>>> boards with dt's using "rohm,bd718*" which would all have non working
> >>>>> RTC/WDOG with CONFIG_COMMON_CLK_BD718XX enabled (which it is in
> >>>>> arch/arm64/configs/defconfig) right?
> >
> > Yeah. The ROHM BD71837 and BD71847 (and BD71850 - which is one of the
> > variants) are used quite a lot. I am pretty sure not fixing this in
> > upstream is increasing downstream solutions. I don't think that should
> > be preferred.
> >
> >>>
> >>> Is there any requirement that the bd718xx clk needs to be runtime
> >>> on/off?
> >>
> >> Yes, the 32kHz clock on BD71xxx should behave like any other clock,
> >> unless specified otherwise, see below.
> >>
> >>> I suppose the clk should always be never be off, if yes, why not have
> >>> something:
> >>
> >> What is needed in this specific case of BD718xx is I think clock
> >> consumer on the MX8M clock driver side which would claim the 32kHz
> >> input from the PMIC and up the clock enable count to keep the 32 kHz
> >> clock always on.
> >
> > This sounds like a solution that would describe the actual HW setup. I
> > don't know the CCF of the i.MX8 well enough to tell whether this can
> > ensure the clk is not disabled before the consumer is found or when the
> > consumer is going down though. Simplest thing to me would really be to
> > just mark the clk as "do-not-touch" one on the boards where it must not
> > be touched.
> >
> >   The PMIC is most likely supplying 32 kHz clock to the MX8M,
> >> which if the 32 kHz clock are turned off would hang (I observed that
> >> before too).
> >>
> >> What I tried to address in this thread is a generic problem which
> >> commonly appears on various embedded systems, except every time anyone
> >> tried to solve it in a generic manner, it was rejected or they gave up.
> >
> > I agree with Marek - generic solution would be nice. I don't think this
> > is something specific to this PMIC.
> >
> >> The problem is this -- you have an arbitrary clock, and you need to
> >> keep it running always otherwise the system fails, and you do not have
> >> a clock consumer in the DT for whatever reason e.g. because the SoC is
> >> only used as a clock source for some unrelated clock net. There must
> >> be a way to mark the clock as "never disable these", i.e.
> >> critical-clock. (I feel like I keep repeating this over and over in
> >> this thread, so please read the whole thread backlog)
> >
> > Thanks for the explanation and effor you did Marek.
> >
> > My take on this is that from a (generic) component vendor perspective it
> > is a bad idea to hard-code the clock status (enable/disable) in the PMIC
> > driver. A vendor wants to provide a driver which allows use of the
> > component in wide variety of systems/boards. When the PMIC contains a
> > clock gate, the PMIC driver should provide the means of controlling it.
> > Some setups may want it enabled, other disabled and some want runtime
> > control. This "use-policy" must not be hard coded in the driver - it
> > needs to come from HW description which explains how the clk line is
> > wired and potentially also from the consumer drivers. This enables the
> > same PMIC driver to support all different setups with their own needs,
> > right?
> >
> > I am not sure if some non email discussions have been ongoing around
> > this topic but just by reading the emails it seemed to me that Marek's
> > suggestion was acked by the DT folks - and I don't think that Stephen
> > was (at the end of the day) against that either(?). Maybe I missed
> > something.
>
> After a thought, maybe an easier way is to add a optional property
> xxx,32k-always-on to the pmic node/driver.
>
> Regards,
> Peng.

Is there simply a way to add the clk to the snvs_rtc and the wdog dt
nodes so they have a use count and don't get disabled?

Best Regards,

Tim
