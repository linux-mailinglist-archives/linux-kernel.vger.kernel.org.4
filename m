Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D19A619A35
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiKDOiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiKDOiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:38:22 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9633123B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:36:09 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p21so5047580plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=loRh0+E+YP5IUjw67EiVC1xM3c3lURuZr1BkCmO2rb8=;
        b=bVWPA/TeXpWGRKLZjpuhAt3T4C5ravFtY4SJ9XlpF1RX67esrvxks5FkOyc7PiTEQP
         RDl1Vd/dlJcUaJ2s/eVsLfU//A5VlmDhUdkJmK/eYxmc9ZdAr1vTO8NEtYUicTZq7Vp1
         4UmSh+DoKX1AM0higcXwFZdmmi3oFupqQIQZqX9dl+otnoOQFBzxwx7hRJKUsP3j2g8Z
         PIjYj+iX57gd4+uwdypPSxnw2cq2vHzCTeKc6mquKs/86Xdjv4zS9FfKYKMjlid4ruYJ
         yWRdh69yvnrwR7M+qI1E3KGIiOJCEgT3SphsAgoD3kd9/u6bauBLvZa8YUvA5+CQeGFL
         AVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=loRh0+E+YP5IUjw67EiVC1xM3c3lURuZr1BkCmO2rb8=;
        b=Q2vYFbJ7mwe0+6abO2l3nUJaMokFXc8lxVTW8H9yNkwel7wNhnnqMtS/SjCMLcFvj7
         LE6x/ZDb3vjkkJCRsDT6Y8RVEdW5bePDkqKs/g4GMM/7qhqYyLU1NTEjD3EoaI4TLwyk
         SSn8k2FenXAy4fz8bF0LXXYd1ioMh4wE7c/zzV0DlVbOp7jRdE015FMe5CuJBo5rhwdt
         0Md7h2kGFx660EDTXOYcVZJbtsZXhJOdv3wKw3ytONuwUBPXwugvlVWtz7q+7UEWZLrX
         RjKoTby/pLX0YuEXMjF0IDKhQNP/FV4q/gcjV/TteZvYN71wltmKvcxiEkGOKY21hi0P
         fk5w==
X-Gm-Message-State: ACrzQf3fBjfhSss/WvAuWTJJ62SVnBvDgrhPdfNeSa9Ivs+h6rIM5Qgz
        nFZrkhM/63lq3htW8fJUsS5WnI86shYguIl0e1trCQ==
X-Google-Smtp-Source: AMsMyM7DtVj7G81QDwOoVnio3+A1j+s1IUj+g76gkNfyV4Aa/khvPFrX9iC0qYux39/eQOgKPSpEb2B9t0xwz19uVBU=
X-Received: by 2002:a17:903:100c:b0:186:63a1:3b5d with SMTP id
 a12-20020a170903100c00b0018663a13b5dmr36667384plb.148.1667572568803; Fri, 04
 Nov 2022 07:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDyKFqJdiCDkAfrONfnBVKw1v8=jZ+hEJiKGK70EQ4o7BSxaQ@mail.gmail.com>
 <20221103043852.24718-1-pshete@nvidia.com> <6be39bae-f325-12e0-374b-a27c9ee2ef2b@arm.com>
 <Y2PJq27wkVwPg6rp@orome> <CAPDyKFq8szzryFBNkw20wFoPTbAa8YDy0wJnb57yckZ-HFTAMw@mail.gmail.com>
 <4cae5c8d-d6e9-79dc-670d-22ec9fda10a2@arm.com>
In-Reply-To: <4cae5c8d-d6e9-79dc-670d-22ec9fda10a2@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Nov 2022 15:35:32 +0100
Message-ID: <CAPDyKFqte70isq=x4afFO6Ys9=wXLkLwVRG6dhfOCunQeQ_DjQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] iommu: Always define struct iommu_fwspec
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Prathamesh Shete <pshete@nvidia.com>, joro@8bytes.org,
        adrian.hunter@intel.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        will@kernel.org, iommu@lists.linux.dev, anrao@nvidia.com,
        smangipudi@nvidia.com, kyarlagadda@nvidia.com,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2022 at 18:35, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-11-03 14:55, Ulf Hansson wrote:
> > On Thu, 3 Nov 2022 at 15:01, Thierry Reding <thierry.reding@gmail.com> wrote:
> >>
> >> On Thu, Nov 03, 2022 at 12:23:20PM +0000, Robin Murphy wrote:
> >>> On 2022-11-03 04:38, Prathamesh Shete wrote:
> >>>> In order to fully make use of the !IOMMU_API stub functions, make the
> >>>> struct iommu_fwspec always available so that users of the stubs can keep
> >>>> using the structure's internals without causing compile failures.
> >>>
> >>> I'm really in two minds about this... fwspecs are an internal detail of the
> >>> IOMMU API that are meant to be private between individual drivers and
> >>> firmware code, so anything poking at them arguably does and should depend on
> >>> CONFIG_IOMMU_API. It looks like the stub for dev_iommu_fwspec_get() was only
> >>> added for the sake of one driver that was misusing it where it really wanted
> >>> device_iommu_mapped(), and has since been fixed, so if anything my
> >>> preference would be to remove that stub :/
> >>
> >> Tegra has been using this type of weak dependency on IOMMU_API mainly in
> >> order to allow building without the IOMMU support on some old platforms
> >> where people may actually care about the kernel size (Tegra20 systems
> >> were sometimes severely constrained and don't have anything that we'd
> >> call an IOMMU today).
> >>
> >> We have similar stubs in place for most other major subsystems in order
> >> to allow code to simply compile out if the subsystem is disabled, which
> >> is quite convenient for sharing code between platforms that may want a
> >> given feature and other platforms that may not want it, without causing
> >> too much of a hassle with compile-testing.
> >
> > I agree with the above.
> >
> > Moreover, the stubs make the code more portable/scalable and so it
> > becomes easier to maintain.
>
> Are you suggesting that having the same thing open-coded slightly
> differently (with bugs) in 8 different places is somehow more
> maintainable than abstracting it into a single centralised implementation?
>
> Is it "easier to maintain" when already seemingly every thing I try to
> clean up or refactor in the IOMMU API at the moment is stymied by
> finding Tegra drivers doing unexpected (and often questionable) things?
> Is it "more scalable" to make it even easier for people to copy
> questionable code without a second thought, leaving API maintainers to
> play an ever-expanding game of whack-a-mole to clean it up? No. No it
> chuffing well isn't :(

Ohh, I wasn't aware of these kinds of issues for the IOMMU interface.

Abusing interfaces is an orthogonal problem to what I was suggesting
to solve here. The main problem I was trying to address was to prevent
sprinkling subsystems/drivers with "#ifdefs" all over the place, as
that doesn't scale.

>
> >>> I don't technically have much objection to this patch in isolation, but what
> >>> I don't like is the direction of travel it implies. I see the anti-pattern
> >>> is only spread across Tegra drivers, making Tegra-specific assumptions, so
> >>> in my view the best answer would be to abstract that fwpsec dependency into
> >>> a single Tegra-specific helper, which would better represent the nature of
> >>> what's really going on here.
> >>
> >> I don't see how this is an anti-pattern. It might not be common for
> >> drivers to need to reach into iommu_fwspec, so that might indeed be
> >> specific to Tegra (for whatever reason our IP seems to want extra
> >> flexibility), but the general pattern of using stubs is wide-spread,
> >> so I don't see why IOMMU_API would need to be special.
> >
> > Again, I agree.
>
> The anti-pattern is reaching into some other driver's private data
> assuming a particular format, with zero indication of the huge degree of
> assumption involved, and half the time not even checking that what's
> being dereferenced is valid.

I see.

>
> > Moreover, a "git grep CONFIG_IOMMU_API" indicates that the problem
> > isn't specific to Tegra. The "#ifdef CONFIG_IOMMU_API" seems to be
> > sprinkled across the kernel. I think it would be nice if we could
> > improve the situation. So far, using stubs along with what the
> > $subject patch proposes, seems to me to be the best approach.
>
> Yes, there is plenty of code through the tree that is only relevant to
> the IOMMU API and would be a complete waste of space without it, that is
> not the point in question here. Grep for dev_iommu_fwspec_get; outside
> drivers/iommu, the only users are IOMMU-API-specific parts of ACPI code,
> as intended, plus 8 random Tegra drivers.
>
> Now, there does happen to be a tacit contract between the ACPI IORT code
> and the Arm SMMU drivers for how SMMU StreamIDs are encoded in their
> respective fwspecs, but it was never intended for wider consumption. If
> Tegra drivers want to have a special relationship with arm-smmu then
> fair enough, but they can do the same as MSM and formalise it somewhere
> that the SMMU driver maintainers are at least aware of, rather than
> holding the whole generic IOMMU API hostage.

Thanks for clarifying this. I certainly understand your concern better now.

>
> Since apparently it wasn't clear, what I was proposing is a driver
> helper at least something like this:
>
> int tegra_arm_smmu_streamid(struct device *dev)
> {
> #ifdef CONFIG_IOMMU_API
>         struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev)
>
>         if (fwspec && fwspec->num_ids == 1)
>                 return fwspec->ids[0] & 0xffff;
> #endif
>         return -EINVAL;
> }
>
> Now THAT is scalable and maintainable; any number of random drivers can
> call it without any preconditions, it's a lot clearer what's going on,
> and I won't have to swear profusely while herding patches through half a
> dozen different trees if, when my ops rework gets to the point of
> refactoring iommu_fwspec with dev_iommu, it ends up changing anything
> significant.

It sure sounds like we need another level of abstraction for iommus,
to avoid the interface from being abused. Perhaps something along the
lines of what we have for clocks (providers and consumers use
different interfaces).

Anyway, to simplify future potential rework in this direction, I can
agree and understand your points.

What you propose above, with one or a few Tegra specific helper
functions, seems like the best we can do for now.

Kind regards
Uffe
