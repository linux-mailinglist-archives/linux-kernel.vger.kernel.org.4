Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B404618047
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiKCO40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiKCOzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:55:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD51C1A061
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:55:46 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c2so2145945plz.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t/NrioDw2KFq6mJ3bVbRI+ixY4f+9g6gFasJn7MZM6M=;
        b=rJkZmYWpfntVKVk7RpeWnoFkGl5MYV9fqkQy+uhqSUZd8I5rQ9KEWF727GdBwyv3sk
         Kgd8e3AX1tMsFIKugXIghb1NH07wTnvI/HIKMzZp0H5a0ElIZvT57CZWWxM8oYQCTzxl
         tSVJ4uulQExyKTjJMY7Ch4mHvoDVilhLCKN/+eDjJo+ctTykGIrmowWIUCebVGeYUlP7
         4qfNXDjfBN4AUK7ExEjXXSKGb9VyabyfwXsRpywXBpkT50Qiq4tUgSCkZQTT2eDYkPIK
         xnynjuCDwE9FvQVKz8ZyGxaNAXZoAxOyvNS3pTdPtufKE0aUR/lFQmpC005iuIUkADAs
         /Z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/NrioDw2KFq6mJ3bVbRI+ixY4f+9g6gFasJn7MZM6M=;
        b=kdfUAa55FYrT165fj4V/W1Sb1thLoZ1MhazgYB322No0d62YiFbyLI0qV9yIV+6NTk
         fgmcEwKw1gYKG50+ulAZGpW0crsl20r36wd/Phz/KenerSJhcTeFMAhiKCed8jcMgvfV
         EZwrvqmACtTDf73DfkQRCVbA9YdlKH1B/i62yNZEv2Rq/ZzzhjAoXxwOG5IewT/uyU0i
         JLp59RyNeloOgSjDHGZmEw0NAYuH7pIuiOnPj5nPuN+S10QHUtjmZleXZhH3fnjmGnX1
         4MuJRaXhDbK8cl4oODAwb5CcgWw86dGqOhJiqOAjTv4+x9+IwrGxfNEgviPpW2UX+39i
         kZGg==
X-Gm-Message-State: ACrzQf3jvBbZSVhaIvySpLSiY20doRf59FtZzBZy9wf5IFZBa6YuYt8G
        Bj8DdO8ZycjTmBnPB/WA1MVBVkY+g8WXfHgP9pWQ5Q==
X-Google-Smtp-Source: AMsMyM4MUJeInSpCoBN6Nw7WgpaIGWe+Q/h4WSomAyuSBcWfpyVw2c5LyrS7bLPmw/14e0Rhj1R+GF4rkXdJxIeX0xI=
X-Received: by 2002:a17:90b:1d90:b0:213:c798:86f6 with SMTP id
 pf16-20020a17090b1d9000b00213c79886f6mr26575996pjb.84.1667487346285; Thu, 03
 Nov 2022 07:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDyKFqJdiCDkAfrONfnBVKw1v8=jZ+hEJiKGK70EQ4o7BSxaQ@mail.gmail.com>
 <20221103043852.24718-1-pshete@nvidia.com> <6be39bae-f325-12e0-374b-a27c9ee2ef2b@arm.com>
 <Y2PJq27wkVwPg6rp@orome>
In-Reply-To: <Y2PJq27wkVwPg6rp@orome>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Nov 2022 15:55:09 +0100
Message-ID: <CAPDyKFq8szzryFBNkw20wFoPTbAa8YDy0wJnb57yckZ-HFTAMw@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] iommu: Always define struct iommu_fwspec
To:     Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Prathamesh Shete <pshete@nvidia.com>, joro@8bytes.org,
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

On Thu, 3 Nov 2022 at 15:01, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Thu, Nov 03, 2022 at 12:23:20PM +0000, Robin Murphy wrote:
> > On 2022-11-03 04:38, Prathamesh Shete wrote:
> > > In order to fully make use of the !IOMMU_API stub functions, make the
> > > struct iommu_fwspec always available so that users of the stubs can keep
> > > using the structure's internals without causing compile failures.
> >
> > I'm really in two minds about this... fwspecs are an internal detail of the
> > IOMMU API that are meant to be private between individual drivers and
> > firmware code, so anything poking at them arguably does and should depend on
> > CONFIG_IOMMU_API. It looks like the stub for dev_iommu_fwspec_get() was only
> > added for the sake of one driver that was misusing it where it really wanted
> > device_iommu_mapped(), and has since been fixed, so if anything my
> > preference would be to remove that stub :/
>
> Tegra has been using this type of weak dependency on IOMMU_API mainly in
> order to allow building without the IOMMU support on some old platforms
> where people may actually care about the kernel size (Tegra20 systems
> were sometimes severely constrained and don't have anything that we'd
> call an IOMMU today).
>
> We have similar stubs in place for most other major subsystems in order
> to allow code to simply compile out if the subsystem is disabled, which
> is quite convenient for sharing code between platforms that may want a
> given feature and other platforms that may not want it, without causing
> too much of a hassle with compile-testing.

I agree with the above.

Moreover, the stubs make the code more portable/scalable and so it
becomes easier to maintain.

>
> > I don't technically have much objection to this patch in isolation, but what
> > I don't like is the direction of travel it implies. I see the anti-pattern
> > is only spread across Tegra drivers, making Tegra-specific assumptions, so
> > in my view the best answer would be to abstract that fwpsec dependency into
> > a single Tegra-specific helper, which would better represent the nature of
> > what's really going on here.
>
> I don't see how this is an anti-pattern. It might not be common for
> drivers to need to reach into iommu_fwspec, so that might indeed be
> specific to Tegra (for whatever reason our IP seems to want extra
> flexibility), but the general pattern of using stubs is wide-spread,
> so I don't see why IOMMU_API would need to be special.

Again, I agree.

Moreover, a "git grep CONFIG_IOMMU_API" indicates that the problem
isn't specific to Tegra. The "#ifdef CONFIG_IOMMU_API" seems to be
sprinkled across the kernel. I think it would be nice if we could
improve the situation. So far, using stubs along with what the
$subject patch proposes, seems to me to be the best approach.

[...]

Kind regards
Uffe
