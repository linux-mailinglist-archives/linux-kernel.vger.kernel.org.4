Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A65602925
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJRKL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiJRKLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:11:38 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5D7B40D9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:11:23 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cl1so13450785pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8WpYzOa826Iyeq0rj8VqK68EqVr20+z94AeHdF+Yt20=;
        b=Sja8RkHx4gQjSl0OjtjmUkise0ojhiB9wwHt8Kw6UirlICEBeZ5JI/n4i1oIsg/cSa
         y/R9LdyG6ogIoj+pnhS1ugG8/zJ5HmJAc+tJJj7rtZKnxmYqlIzhIAEDdTDdwozIDGld
         KoIy3XWiug83v6Pnz957hZldLZkTb5lGnw1PmItfO/mgNALGlIaXGYQSRihC0RAOpJzU
         A0vfkfIQlRNROgp0uWXa8j7CAgOn5am4jzGzyBwmrMDU5AVwnFcPaIkPTZciy+I/QROy
         Vc4Bt5IwawHNSHBzLsyfWzNrvo54Ni9BJO8KY3oIJVvZIwLVNrGLLoEgPtimeYz5i3fE
         K7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WpYzOa826Iyeq0rj8VqK68EqVr20+z94AeHdF+Yt20=;
        b=K4tR7EmV/AYL/Z8tLfsMz5838A5Ow/Jq4YFHHyiy+0g8KLAJkm1jdRg25rsx6CwOrs
         ZTXLwHicSKvWfhhQoLp9Bei+CIXCAmn6Agce+2CfD9vHF+9YCABG+7hmki3zyYkFQ3Bf
         WadoxhSE9S/q+QvGLxVvS6O4dxHmHNfL9fRU+ifiqVz1cCez2co80LNJwWp0W0Lgrge3
         ccrmUwPxL6VCBMi2NGHBZHlgpUGXtgSLOG6fb0xfjGAwadWQh1CY+Dtsrn4wG2vzdkTA
         +odgy2SlWZlwsHIyWr2VdsxI5JtNvVPi9Mp+5loxn2G9lBEw/Mu4l4vg0stTciBNYCUG
         B0uA==
X-Gm-Message-State: ACrzQf1JQqO+r4hOdwZeBrpzBQd45JSb93FYkOTfz6jtB0iVF/oLcHRT
        BKn3K/DksXwU9i6BHrqA7HSw8Lh4xcJAn4l2y8vjoQ==
X-Google-Smtp-Source: AMsMyM7EsMGthu8LAY5nazIGfe0IpnBLTNbV7nYgfFBT5wBP/EYa6YzTp8oTzkZ21fWchS16COEFkk2BgK2TDlrfAnI=
X-Received: by 2002:a17:90a:7b8c:b0:20b:1f3b:f6fd with SMTP id
 z12-20020a17090a7b8c00b0020b1f3bf6fdmr2713134pjc.202.1666087879190; Tue, 18
 Oct 2022 03:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <Yz6zfrVq9cP/wrJb@orome> <20221006130622.22900-1-pshete@nvidia.com>
 <20221006130622.22900-2-pshete@nvidia.com> <CAPDyKFr_Yi2EgrBUzsORnM4mOkf25WR8+7_dfF2h4XzRDPm9-w@mail.gmail.com>
 <DM5PR12MB2406610AB26183BACB19EED6B7239@DM5PR12MB2406.namprd12.prod.outlook.com>
 <CAPDyKFqn2jMVQ5BAOZPFx2OOyMRQvsQ1E7mGAQp82x5+v6aSGQ@mail.gmail.com>
 <DM5PR12MB2406405CE44A7606B5A28203B7259@DM5PR12MB2406.namprd12.prod.outlook.com>
 <CAPDyKFq5hNTdwT7CMvsxG=_5u+xvG2k3-PfbGhAbHfHbGqK81w@mail.gmail.com> <Y01iiqtNA9xek46S@orome>
In-Reply-To: <Y01iiqtNA9xek46S@orome>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 18 Oct 2022 12:10:42 +0200
Message-ID: <CAPDyKFqUy2MoBAqTPhOKoAY0tJYT_parXTFEq-JNLvAo7FQq1g@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] mmc: sdhci-tegra: Add support to program MC stream ID
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Prathamesh Shete <pshete@nvidia.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Suresh Mangipudi <smangipudi@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 at 16:11, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Thu, Oct 13, 2022 at 03:43:18PM +0200, Ulf Hansson wrote:
> > On Thu, 13 Oct 2022 at 08:33, Prathamesh Shete <pshete@nvidia.com> wrote:
> > >
> > > Hi Ulf,
> > >
> > > >> In that case, perhaps we can add a "depends on IOMMU_API" in the Kconfig
> > > >> instead? Or is the tegra driver used on platforms where IOMMU_API could be
> > > >> unset?
> > > Yes it can/will work with IOMMU disabled so its not recommended to add a "depends on" condition in Kconfig.
> >
> > Alright, in that case it looks to me that there are two other options
> > to move forward.
> >
> > 1) Add proper definitions of the struct iommu_fwspec in
> > include/linux/iommu.h even when CONFIG_IOMMU_API is unset. In a way it
> > seems a bit silly to me, to have the iommu stubs around, unless those
> > can be used for cases like this, right!?
>
> I recall that I had proposed a patch for this a long time ago:
>
>         https://lore.kernel.org/all/20191209120005.2254786-3-thierry.reding@gmail.com/

That looks exactly what we would need!

>
> Given that Joerg had acked it at the time, I think the only reason why
> it never ended up getting merged is because the rest of the series did
> not get enough traction. I wonder if I should peel it out of the series
> and propose it separately.

Yes, please.

>
> I agree it doesn't make any sense to have the stubs to allow compilation
> and then break compilation because users of the stubs will end up
> wanting to dereference the structure.

Thanks for sharing your thoughts around this!

If you submit a new version of the old patch, I would certainly give
it my blessing.

Kind regards
Uffe
