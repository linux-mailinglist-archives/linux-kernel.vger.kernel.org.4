Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC0A6A020A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 05:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjBWEdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 23:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjBWEdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 23:33:18 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25D82310E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 20:33:16 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u14so7499680ple.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 20:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wG/6wi8FA7LC2E67A3OVEJ/iTQlZXTd9mLmf0AaucdY=;
        b=h/L9Lg3IsZ1aj36X6s/a1fkapT+vTbUin8UyP/ZvKZBKLjP7+Emtg1fhUTmaCo55Xb
         K1bg6Qtxn07LPbab2qvPTE7Zf7DL+2g8nwam0cRUx58+0nLFn1FHUQV+wVoK65Boq84L
         IT9w2+pD2UouMdXb8LJJIkXq6eI6S4cIOdSNVxF+DpgrHw9ppwSOU1oc8wYPYo/sw5Pl
         ycnJyTZHc0ZICLfgsiYc14TNmo8UxBJ8MqdmE9jJyBWK1Nhghb5Zk3W56nRGBzAjxAcb
         zmfp5BVdKAuYjHsVVw4tV8HkTedlUYpiFnrQ3B/ZJo3gmf69l2Vzh4QwEL8icXO1KlQw
         miaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wG/6wi8FA7LC2E67A3OVEJ/iTQlZXTd9mLmf0AaucdY=;
        b=cWNBPm2lBHqUuR/odgpZUjegYLd2760JyQEWnG1tMAnE8QrdaxuNU/cDcZ/EkxntKV
         b+FmDQTl+bnXaaWnUpVibWT5E0Q78sbehaYGWuJHYj+r0SPjUVqvfgFMv7bR6d2yrKUp
         ej08oxUK+maEqV3vRI56l/nS5g/BMuF/gam7cGCMIkcYPMsUnkxBaaVFS9CLoX0eJfS0
         yvIBEG7lfT1t1zJids3REL6vdCRfeF3lwKzoWBbcBGHm++KKIHKI7+/NafIRnB8aDX6S
         ufCVmDrHMN1B1MoyiA4sKnyEQhd6Leakjfskmh34GPnQSNa43m1Mx1iCARsDM6dbPbPU
         oX2Q==
X-Gm-Message-State: AO0yUKUJdZnYq//3VW5BrvwIHKtD11UMC8Bi/1UBoNzjaJjRfUa7hmAk
        byL1Te66aJVfuaGxnTtCaMDM0iztOMK0j1Ih5gIBQg==
X-Google-Smtp-Source: AK7set9Q1XGuOAuksQMQTUHoBleoXSQcBUcmi3gyIMaZGRBCN4TnDKJ2kRdHm6Gg8wKbRn7Zg9tIscJflmguP5aSZps=
X-Received: by 2002:a17:90b:4d0d:b0:233:e8b8:5d4e with SMTP id
 mw13-20020a17090b4d0d00b00233e8b85d4emr1752957pjb.73.1677126796191; Wed, 22
 Feb 2023 20:33:16 -0800 (PST)
MIME-Version: 1.0
References: <CGME20221103195201eucas1p2a6ec2df41ebac3d9ccbb0b252c2cad34@eucas1p2.samsung.com>
 <20221103195154.21495-1-semen.protsenko@linaro.org> <a7d9cd18-a328-209c-c89f-afdcb7db3eb0@samsung.com>
 <b7ad6444-e7d2-1150-6134-3dae8129dcdb@samsung.com> <CAPLW+4=Y6qZG2XjJR_BkX-ar4GWdETKO1tteJjfbxVc664e4Kg@mail.gmail.com>
 <CAGETcx9ApZFvKjEaxvvgsoHDzOq06ZiROZ5npYt+suNdE4KWDg@mail.gmail.com>
In-Reply-To: <CAGETcx9ApZFvKjEaxvvgsoHDzOq06ZiROZ5npYt+suNdE4KWDg@mail.gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 22 Feb 2023 22:33:20 -0600
Message-ID: <CAPLW+4kbi3cDNu7wXTjeDskk40da5vhAVXG8Am-MHN+REuLDrw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] iommu/exynos: Convert to a module
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2023 at 21:33, Saravana Kannan <saravanak@google.com> wrote:
>
> On Fri, Nov 11, 2022 at 5:30 AM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> >
> > On Thu, 10 Nov 2022 at 15:36, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >
> > [snip]
>
> Hi Marek and Sam,
>
> I'm replying to both of your comments in this email.
>
> > > I've finally made Exynos IOMMU working as a module on Exynos5433 based
> > > TM2e board. It looks that this will be a bit longer journey that I've
> > > initially thought. I've posted a simple update of the fix for the driver
> > > initialization sequence, but the real problem is in the platform driver
> > > framework and OF helpers.
> > >
> > > Basically to get it working as a module I had to apply the following
> > > changes:
> > >
> > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > index 3dda62503102..f6921f5fcab6 100644
> > > --- a/drivers/base/dd.c
> > > +++ b/drivers/base/dd.c
> > > @@ -257,7 +257,7 @@ static int deferred_devs_show(struct seq_file *s,
> > > void *data)
> > >   DEFINE_SHOW_ATTRIBUTE(deferred_devs);
> > >
> > >   #ifdef CONFIG_MODULES
> > > -int driver_deferred_probe_timeout = 10;
> > > +int driver_deferred_probe_timeout = 30;
> > >   #else
> > >   int driver_deferred_probe_timeout;
> > >   #endif
> > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > index 967f79b59016..e5df6672fee6 100644
> > > --- a/drivers/of/property.c
> > > +++ b/drivers/of/property.c
> > > @@ -1384,7 +1384,7 @@ static struct device_node *parse_interrupts(struct
> > > device_node *np,
> > >   static const struct supplier_bindings of_supplier_bindings[] = {
> > >          { .parse_prop = parse_clocks, },
> > >          { .parse_prop = parse_interconnects, },
> > > -       { .parse_prop = parse_iommus, .optional = true, },
> > > +       { .parse_prop = parse_iommus, },
> > >          { .parse_prop = parse_iommu_maps, .optional = true, },
> > >          { .parse_prop = parse_mboxes, },
> > >          { .parse_prop = parse_io_channels, },
> > >
> > > Without that a really nasty things happened.
>
> I have a command line option to do this without code changes. Use
> fw_devlink.strict=1. That makes all optional properties into mandatory
> ones.
>
> I sent out a series[1] that tried to make fw_devlink.strict=1 the
> default and then use the timeout behavior (more details) to handle
> cases where iommu and dmas (or any other supplier) are optional on a
> specific board. The cover letter of [1] should give some more context.
>
> > > Initialization of the built-in drivers and loading modules takes time,
> > > so the default 10s deferred probe timeout is not enough to ensure that
> > > the built-in driver won't be probed before the Exynos IOMMU driver is
> > > loaded.
>
> The 10 second is the minimum delay from the time we hit late_initcall.
> If a driver is registered before the 10s expires, then the timer will
> be extended by another 10s. This behavior landed sometime around the
> end of May 2022. So it should have been in your tree when you tested
> this. I'm surprised this isn't sufficient for your case. Is there
> really a 10s gap in your boot sequence where no module is being loaded
> and then IOMMU modules get loaded later on? I'm kinda surprised by
> this. Is it this long because some serial UART is enabled and it's
> slowing down boot? Or something else?
>
> I'm not saying your case isn't valid or we shouldn't extend the
> timeout. I'm just trying to understand why the current timer behavior
> wasn't able to cover your case.
>
> > Yeah, the whole time-based sync looks nasty... I remember coming
> > across the slides by Andrzej Hajda called "Deferred Problem" [1], but
> > I guess the proposed solution was never applied. Just hope that
> > increasing the timeout is upstreamable solution.
> >
> > [1] https://events19.linuxfoundation.org/wp-content/uploads/2017/12/Deferred-Problem-Issues-With-Complex-Dependencies-Between-Devices-in-Linux-Kernel-Andrzej-Hajda-Samsung.pdf
>
> Sam, I kinda skimmed the slides right now. Looks like it talks about
> device links and why they aren't sufficient and makes an alternate
> proposal. fw_devlink is a solution that uses device links and I think
> addresses a lot of the issues that were raised about device links.
> There's still a bunch of TODOs left, but I think the end goal is the
> same. I'm hoping to keep chipping away at it. For now, I've tried to
> make the timer a bit more smart about detecting when modules are
> getting loaded and extending the timer. fw_devlink also enables
> something called sync_state() that's invaluable on a fully modular
> system (search lore for references to that to get some idea).
>
> The slides talk about a solution that will allow devices to probe with
> limited functionality with whatever suppliers are available and then
> reprobe as more suppliers are available. I'm not sure how well that'll
> work across the board. It's going to be a bit weird if your phone
> display goes off and then comes on again because an IOMMU driver got
> loaded (and it can now do DRM playback). For now, I'm not going to
> focus on that option because there are enough existing issues/TODOs to
> work on for fw_devlink.
>
> > > The second change fixes the problem that driver core probes Exynos IOMMU
> > > controllers in parallel to probing the master devices, what results in
> > > calling exynos_iommu_of_xlate() and exynos_iommu_probe_device() even on
> > > the partially initialized IOMMU controllers or initializing the dma_ops
> > > under the already probed and working master device. This was easy to
> > > observe especially on the master devices with multiple IOMMU
> > > controllers. I wasn't able to solve this concurrency/race issues inside
> > > the Exynos IOMMU driver.
> > >
> > > Frankly speaking I don't know what is the rationale for making the
> > > 'iommus' property optional, but this simply doesn't work well with IOMMU
> > > driver being a module. CCed Saravana and Rob for this.
> > >
> >
> > The patch which makes 'iommus' optional doesn't provide much of
> > insight on reasons in commit message either.
>
> This was the commit text:
>
>     Not all DT bindings are mandatory bindings. Add support for optional DT
>     bindings and mark iommus, iommu-map, dmas as optional DT bindings.
>
> I thought it was obvious enough, but I guess I could have done better.
> Geert convinced me that iommu's aren't always necessary and devices
> could work perfectly well without them or dmas. And he has a bunch of
> boards like that. So I went with adding optional and then introducing
> fw_devlink.strict.
>
> However, at this point in time, I believe none of them should be
> marked as optional because technically any property can be optional
> depending on what the firmware has set up and what the driver does. We
> should figure this out at runtime on a board level -- which is what
> [1] is trying to do. Yeah, not very pretty, but there hasn't been a
> better solution that's not "have userspace tell us it's done loading
> modules" (that's a "kernel depends on userspace to work correctly"
> thing that no one likes). I've fixed some of the issues raised in [1]
> in a fw_devlink improvement series[2] and I plan on continuing to work
> on this until hopefully [1] can land.
>
> > > Without fixing the above issues, I would add a warning that compiling
> > > the driver as a module leads to serious issues.
> > >
> >
> > Nice catch! It doesn't reproduce on my platform, alas. Can I expect
> > you to submit those patches? If so, I'll probably just wait for those
> > to be applied, and then re-send my modularization series on top of it.
> > Does that sounds reasonable?
>
> For now, maybe we could add a config to enable fw_devlink.strict=1 by
> default and then select it if you make specific iommu drivers into
> modules? And then Geert won't set it for his driver, but you can set
> it for your driver?
>

Marek, what is your take on this? I probably can't provide any useful
comments, as the issue is not even reproducible on my platform. Do you
think some easy solution exists to make modularized IOMMU driver work?
That series has been sitting for a while on ML now, so I wonder if we
can handle it somehow, w.r.t. Saravana's input.

> Thanks,
> Saravana
>
> [1] - https://lore.kernel.org/lkml/20220601070707.3946847-1-saravanak@google.com/
> [2] - https://lore.kernel.org/lkml/20230207014207.1678715-1-saravanak@google.com/
