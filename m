Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCDD6FB530
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbjEHQfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjEHQfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:35:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4445BA9
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 09:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683563752; x=1715099752;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9SyE4P+QDbRpFuKtyJj05TYVwS1756XOrjCcHThkRc4=;
  b=GoEkv4E+mY6Bg4gEmr3lfvgYsMaatT0zFEfrRDJzyZ8+o6VENddYeDet
   7Uia5DFIPBlKboN3+JMLCsAc5KJOLMuzqglmpGLm2p8GLaxTf2i0TZdXG
   LuW70ksyFr9E0LgA0/Xrd7wf1TUjw4/yG3dvuoPqIQOnIzwlmnOy6f9KV
   W2sioZd5WgbI4eN6h5pZJ7m0fwSYGpBAlFlMzw9+V4dD1eEVvOHRb/p1+
   97aJyv3gDHLKgVGzCD7AXtCTdUsdSeT+OWY+TAbfFqDqCTOtRSQ2owl/c
   20Sm6E5MBjLKM+5b6Uf8J8w6+ys4Bcf7RIOX3MYCTiJr2DW2izY++d/ct
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="415257281"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="415257281"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 09:35:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="788175585"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="788175585"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 09:35:50 -0700
Date:   Mon, 8 May 2023 09:40:14 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        jacob.jun.pan@linux.intel.com,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
Message-ID: <20230508094014.53913cf3@jacob-builder>
In-Reply-To: <CAHk-=wjmOAQnqJF-pW=fzMXb_Rk_J_Oi4ESBLmVPhxwBK4xfGg@mail.gmail.com>
References: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
        <CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com>
        <20230506150741.2e3d2dcc@jacob-builder>
        <CAHk-=wjmOAQnqJF-pW=fzMXb_Rk_J_Oi4ESBLmVPhxwBK4xfGg@mail.gmail.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sun, 7 May 2023 11:52:18 -0700, Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> On Sat, May 6, 2023 at 3:03=E2=80=AFPM Jacob Pan <jacob.jun.pan@linux.int=
el.com>
> wrote:
> >
> > Right, how about IOMMU_SHARING_CPU_PGTABLE? =20
>=20
> I think from a VM / process angle, I'd actually prefer calling the
> "pasid" part just that: IOMMU_PASID.
>=20
> The VM code certainly understands about address space IDs, even if
> people have called them different things: normal people called them
> ASID's long ago, then Intel at some pointed decided that "PCID" made
> sense as a name (narrator: "no it didn't"), and then you got that
> combined "PASID" thing.
>=20
> Now, it may be that this then goes hand-in-hand with other IOMMU code
> that isn't *about* PASID itself, but that depends on PASID's being
> present, and so I'd just expect IOMMU_PASID to be one of those options
> that are selected by other options.
>=20
> So maybe there is some part of IOMMU_SVA that is not about PASID
> itself, but I really think that the PASID code itself should just have
> that CONFIG_PASID around it.
Conversely, we could also have some part of PASID that is not about SVA.
e.g. Today, on PASID enabled IOMMUs, DMA request w/o PASID (legacy) uses a
special PASID 0. This has nothing to do with mm->pasid.

> End result: from a legibility standpoint, I think it could be as
> simple as having that
>=20
>     config IOMMU_SVA
>=20
> option have a "select IOMMU_PASID".
> Then make the VM/process PASID code depend on that. Maybe the "struct
> device *" stuff makes more sense under CONFIG_IOMMU_SVA, ie things
> like iopf_queue_add_device() and friends.
right, we don;t support non-PASID IOPF.

> How does that sound? Maybe those two options then always end up going
> together, but even if that is the case, I think from a VM/process
> standpoint it makes a lot more sense to simply have a "PASID enabled"
> option. It's much more understandable in that context, while something
> like "IOMMU_SVA" really is just a random jumble of letters to a VM
> person.
My only concern is the case above where DMA API uses a PASID for legacy DMA
requests w/o PASID. I am also trying to add non-zero PASID for
Intel's ENQCMDS.
https://lore.kernel.org/linux-iommu/20230427174937.471668-1-jacob.jun.pan@l=
inux.intel.com/
The PASIDs used in this case uses IOVA page tables, not shared with any
mm_struct.

=46rom this use case, we need to select IOMMU_PASID, but not necessarily for
mm->pasid which IMHO is only meaningful when IOMMU shares page tables with
the CPU.

> And while the individual words in IOMMU_SHARING_CPU_PGTABLE all make
> sense, it's not clear what the combination means, and why it should
> have anything to do with then having an address space identifier for
> it.
>=20
>                   Linus
>=20


Thanks,

Jacob
