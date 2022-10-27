Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DF860F6CB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbiJ0MIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiJ0MIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:08:31 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05ACB03E8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:08:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so6100106pji.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IRokpQrD/Xpoqhga6/IEwT5hyf0pX7PAPi9ZKJUnr7Q=;
        b=JMScpzWl6emAup2u57Oz+x3Eu9xexeIgrXPigRBphDYLS17++q/iVRPSo68AKI+7HU
         EfgGCjwU2Ux3cCL9UySpAo/NxqVFWjixbOmUZjZRvpAG8PUsbi26QqIcLHUvm3Dc+7Mu
         tokABmH2890D/GOamLjXSHM6MQEKCFUb9JrhYTFPoO508RlLtXbGQkazNjCbw+V1FAaz
         jm7qwXWgp9XoEvQ1BhPMwaBoBCc0GoDPc/Y4bzrIJIjKIRBFDj1aODTZM6Wohggdbqva
         fsDS+dbhf8nPvt9M108QYnZr1E89+0CPxGqxOM6YJu8w8tq4K30L3TMD36h5vh2ysifk
         ET6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IRokpQrD/Xpoqhga6/IEwT5hyf0pX7PAPi9ZKJUnr7Q=;
        b=CL0Pv8EUcVfZHht+l3Ww7nEvpfyHdXgBxDMyQ+z5Q/zZtYUOs0KSZkTKjSp+u59KwD
         8downQLmo0wlFehzRY/b1CyLdMXyjwJ5xe5aM6Ui0jE+7u5vwd8ah5xp4IL1CzXfN++l
         qx9R2jYMqyKlZyw9XtzkZGyRb4eJp5abibNeP1eZTeLQvnoxUpkV0M90Ed5o+G49SpUd
         vsBId7/RKWHogInRKAYOikR6Xn0Sm/TFOl3E6gAHHOfhidZWxwQonBXdzydkbbcklB0p
         7RTgDKYtIAMT2ydUNjqJDuPsFcPQWv6OpbSyl5V4Viy0qyM/3zyLHQyLS/7YnSwXfnwg
         uVAw==
X-Gm-Message-State: ACrzQf3xnTEEbTxTsVXPeYPZfeMe4uJUIJuCATSkSlzbrXMI6ucefwMB
        bg75tgmFU5qMkNpolqozgkRRA8oeVvp1XUkxyZd4IxTyyD39+Q==
X-Google-Smtp-Source: AMsMyM4mFDjwKvJtTg/Yzz8RozT/UYy+3pElSAq7TFuq1ZEqDR1s26iqwELHXdK9Q2XTTM+wOKNPMi+xbxQi+xSTdnA=
X-Received: by 2002:a17:902:70c7:b0:183:3e66:fe48 with SMTP id
 l7-20020a17090270c700b001833e66fe48mr47299112plt.165.1666872508418; Thu, 27
 Oct 2022 05:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221018105149.820062-1-thierry.reding@gmail.com>
 <CAPDyKFopppohLJ7ptnQxpBHzMLh2SZObarQRC0bJyTwE=nky4w@mail.gmail.com> <Y1pLPHER+Pq+cRvc@orome>
In-Reply-To: <Y1pLPHER+Pq+cRvc@orome>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 27 Oct 2022 14:07:51 +0200
Message-ID: <CAPDyKFpG9ZjVTiK3HEqioDN8ksGpRYiXL_SLSmOfm9fjJfcrsw@mail.gmail.com>
Subject: Re: [PATCH] iommu: Always define struct iommu_fwspec
To:     Thierry Reding <thierry.reding@gmail.com>,
        Prathamesh Shete <pshete@nvidia.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, 27 Oct 2022 at 11:11, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Thu, Oct 20, 2022 at 01:32:41PM +0200, Ulf Hansson wrote:
> > On Tue, 18 Oct 2022 at 12:51, Thierry Reding <thierry.reding@gmail.com> wrote:
> > >
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > In order to fully make use of the !IOMMU_API stub functions, make the
> > > struct iommu_fwspec always available so that users of the stubs can keep
> > > using the structure's internals without causing compile failures.
> > >
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> >
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > > ---
> > > Hi Joerg,
> > >
> > > this is a rebased patch extracted from an ancient series that never
> > > ended up getting applied:
> > >
> > >         https://lore.kernel.org/all/20191209120005.2254786-3-thierry.reding@gmail.com/
> > >
> > > You had already acked this particular patch, so maybe you can pick this
> > > up. I've seen at least two discussions where this was brought up again,
> > > so I figured it'd be worth sending this out again because it can help
> > > remove a number of #ifdef blocks throughout the kernel.
> >
> > Yes, this would certainly help to improve the code. To me, it looks
> > like the current stub functions, like dev_iommu_fwspec_get() for
> > example, aren't really useful without $subject patch.
> >
> > Note that, I have a pending patch for mmc that would benefit from
> > this. To prevent me from delaying that, an easy way forward, assuming
> > there are no objections of course, would be to send this for 6.1-rc.
>
> Adding Prathamesh for visibility. Another alternative would be to
> prepend this to Prathamesh's series with an Acked-by from Joerg.

Good idea!

I will then be awaiting a new version from Prathamesh's series, that
includes $subject patch too.

>
> Joerg, any preference on how to move forward with this?
>
> Thierry
>

Kind regards
Uffe

> >
> > >
> > >  include/linux/iommu.h | 39 +++++++++++++++++++--------------------
> > >  1 file changed, 19 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > index a325532aeab5..e3295c45d18f 100644
> > > --- a/include/linux/iommu.h
> > > +++ b/include/linux/iommu.h
> > > @@ -173,6 +173,25 @@ enum iommu_dev_features {
> > >
> > >  #define IOMMU_PASID_INVALID    (-1U)
> > >
> > > +/**
> > > + * struct iommu_fwspec - per-device IOMMU instance data
> > > + * @ops: ops for this device's IOMMU
> > > + * @iommu_fwnode: firmware handle for this device's IOMMU
> > > + * @flags: IOMMU_FWSPEC_* flags
> > > + * @num_ids: number of associated device IDs
> > > + * @ids: IDs which this device may present to the IOMMU
> > > + */
> > > +struct iommu_fwspec {
> > > +       const struct iommu_ops  *ops;
> > > +       struct fwnode_handle    *iommu_fwnode;
> > > +       u32                     flags;
> > > +       unsigned int            num_ids;
> > > +       u32                     ids[];
> > > +};
> > > +
> > > +/* ATS is supported */
> > > +#define IOMMU_FWSPEC_PCI_RC_ATS                        (1 << 0)
> > > +
> > >  #ifdef CONFIG_IOMMU_API
> > >
> > >  /**
> > > @@ -598,25 +617,6 @@ extern struct iommu_group *generic_device_group(struct device *dev);
> > >  /* FSL-MC device grouping function */
> > >  struct iommu_group *fsl_mc_device_group(struct device *dev);
> > >
> > > -/**
> > > - * struct iommu_fwspec - per-device IOMMU instance data
> > > - * @ops: ops for this device's IOMMU
> > > - * @iommu_fwnode: firmware handle for this device's IOMMU
> > > - * @flags: IOMMU_FWSPEC_* flags
> > > - * @num_ids: number of associated device IDs
> > > - * @ids: IDs which this device may present to the IOMMU
> > > - */
> > > -struct iommu_fwspec {
> > > -       const struct iommu_ops  *ops;
> > > -       struct fwnode_handle    *iommu_fwnode;
> > > -       u32                     flags;
> > > -       unsigned int            num_ids;
> > > -       u32                     ids[];
> > > -};
> > > -
> > > -/* ATS is supported */
> > > -#define IOMMU_FWSPEC_PCI_RC_ATS                        (1 << 0)
> > > -
> > >  /**
> > >   * struct iommu_sva - handle to a device-mm bond
> > >   */
> > > @@ -680,7 +680,6 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group);
> > >
> > >  struct iommu_ops {};
> > >  struct iommu_group {};
> > > -struct iommu_fwspec {};
> > >  struct iommu_device {};
> > >  struct iommu_fault_param {};
> > >  struct iommu_iotlb_gather {};
> > > --
> > > 2.37.3
> > >
> >
> > Kind regards
> > Uffe
