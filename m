Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED0B63D156
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiK3JCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiK3JCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:02:51 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C2315838
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:02:50 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id vp12so38441823ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bvCkSPWWXEisBKO+mE/xfJ0iMceCkypfEF6PFvX87bk=;
        b=LjLp7O13cRq+xDrs1MAO2ZcpkbECDNbMAGdmn1nST/EMEngSM+h+F7Iae4N0CyzhT3
         asYogNfUqIBeeN8Bxf7Fb9LYfuHCYzJMQA09Ydkei5tkdlJsKYWvPz9zcyr+Fe0Y6Jtn
         IGNVsq7PheOygDpPiAPN3kT/GVTyJ+Lvy1znjQP81zgEve2NFF8J16qwk1HKWU2m+BjW
         ZXmR7rZQUrFFk4ybAylMqu4qumJ1bqog4E7SLmHvDSTRMCw8DRC/8u3GKRvcJWsvgtXa
         zMFhcu6DVwm9JwN9SaZqEMMkiNsGeXea9pVSbqVeNaZpcu1xzniXMJq6RDcaiILC/3wh
         EPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvCkSPWWXEisBKO+mE/xfJ0iMceCkypfEF6PFvX87bk=;
        b=rgUAGo0uO/86EOuweUst70SIprPaKvAYWqmNk3NtlWUXIw+mB2BL526qb2JPZL0dnw
         G5glHoEmDf6UirLecqCqQnFeIJ348IGFDtiu1Eg6qiueZnLWeSw6g7lCU5mbQEYa36YX
         GJeDamGyK57rNbwnVVJhCBtow8SoYNcc9VSYHAG/dE5gf5/E91RGk9pSMzx9aPHQ7vLo
         DRLcffqKQyvXpULt2eGYUgcgqKuZxv1KmhqGWxs8H5dZI2OO2zxwmqOLxlbP60GQqVwN
         hFeCj2pPVakGBGGTpur0JPRyJjPX5aT/gztpRXDar6wWA5/leEHaGaggSPgDsQWOAoEU
         tM4w==
X-Gm-Message-State: ANoB5pl03h5u4TnZ60dnqZQ2K/x2aM3TKNrCCvE8kVzc0eOF3AwB/Yd3
        kRHkw142XVp+oFkwFtkWWTFPe5mFnrc+hOzqrTM=
X-Google-Smtp-Source: AA0mqf4/GBvpR8BDs7aXcNHCJIURnlX8+Q4URsljIZcfS/jf5Ko1DXgZkiwT07uqHCIh2Z7p4zHN0wKVOWUvDZPbXKA=
X-Received: by 2002:a17:906:9c8a:b0:7bf:6698:d444 with SMTP id
 fj10-20020a1709069c8a00b007bf6698d444mr12679921ejc.548.1669798968899; Wed, 30
 Nov 2022 01:02:48 -0800 (PST)
MIME-Version: 1.0
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-9-baolu.lu@linux.intel.com> <BL1PR11MB5271FF59EEAC72D3C4A04E538C129@BL1PR11MB5271.namprd11.prod.outlook.com>
In-Reply-To: <BL1PR11MB5271FF59EEAC72D3C4A04E538C129@BL1PR11MB5271.namprd11.prod.outlook.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 30 Nov 2022 17:02:11 +0800
Message-ID: <CAAfSe-vZEAVS05GUPQ0qf1hW20LyCGhgyHu+K5EueU=_FJRF=g@mail.gmail.com>
Subject: Re: [PATCH v3 08/20] iommu/sprd: Remove detach_dev callback
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2022 at 11:35, Tian, Kevin <kevin.tian@intel.com> wrote:
>
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Monday, November 28, 2022 2:47 PM
> >
> > The IOMMU driver supports default domain, so the detach_dev op will never
> > be called. Remove it to avoid dead code.
> >
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > ---
> >  drivers/iommu/sprd-iommu.c | 16 ----------------
> >  1 file changed, 16 deletions(-)
> >
> > diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
> > index 219bfa11f7f4..ae94d74b73f4 100644
> > --- a/drivers/iommu/sprd-iommu.c
> > +++ b/drivers/iommu/sprd-iommu.c
> > @@ -255,21 +255,6 @@ static int sprd_iommu_attach_device(struct
> > iommu_domain *domain,
> >       return 0;
> >  }
> >
> > -static void sprd_iommu_detach_device(struct iommu_domain *domain,
> > -                                          struct device *dev)
> > -{
> > -     struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> > -     struct sprd_iommu_device *sdev = dom->sdev;
> > -     size_t pgt_size = sprd_iommu_pgt_size(domain);
> > -
> > -     if (!sdev)
> > -             return;
> > -
> > -     dma_free_coherent(sdev->dev, pgt_size, dom->pgt_va, dom-
> > >pgt_pa);
> > -     sprd_iommu_hw_en(sdev, false);
> > -     dom->sdev = NULL;
> > -}
> > -
>
> Looks this reveals a bug in this driver (not caused by this removal).
>
> sprd_iommu_attach_device() doesn't check whether the device has
> been already attached to a domain and do auto detach.
>
> It's written in a way that .detach_dev() must be called to free the
> dma buffer but ignores the fact that it's not called when default
> domain support is claimed.
>
> Then the dma buffer allocated for the previous domain was left
> unhandled, causing memory leak.

I'll look into the issue, thanks for pointing this out.

Chunyan
