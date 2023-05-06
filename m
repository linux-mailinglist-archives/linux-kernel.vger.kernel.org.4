Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1646F94B3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 00:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjEFWDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 18:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEFWDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 18:03:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F007EF8
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 15:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683410598; x=1714946598;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=85db/Q4ojopDoG5xswhFXtX+yoZa0a8Q5iJRo2143F0=;
  b=IVG+hcuCw+egRdlIfzfC+TL3F8eY/wcCPbq6ldE4YuVDU4nAKPvxL+Qk
   gm1m4c7XB6BC0d7kk9AGbR4dFhHokdqvcBBvNXTKjUODJ95HTMbFh5m6d
   J3KCBg3GuGz2LEY3NncfsqUKfRyohbINyH+bMkxQ1X8TDGIX0dcU0xpJx
   CVFoLkAoETiA9lFBGHrh/tJQra4ydJIR+WUXV7paOT4B+9g3+0ELOJIxT
   YskKvAjrquyOfEm6NFqCgsphUtHz/BHiX0C560bg9c7JjqI2izExsZiLY
   yVz/bMBrhSOt5onUlVJI+OHqb7LO1pxbveFFeKGlmWeOcTz/0Yk7Bp5gb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="377506826"
X-IronPort-AV: E=Sophos;i="5.99,255,1677571200"; 
   d="scan'208";a="377506826"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 15:03:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="698019248"
X-IronPort-AV: E=Sophos;i="5.99,255,1677571200"; 
   d="scan'208";a="698019248"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 15:03:17 -0700
Date:   Sat, 6 May 2023 15:07:41 -0700
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
        "Yu, Fenghua" <fenghua.yu@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
Message-ID: <20230506150741.2e3d2dcc@jacob-builder>
In-Reply-To: <CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com>
References: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
        <CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sat, 6 May 2023 08:43:08 -0700, Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> On Sat, May 6, 2023 at 6:27=E2=80=AFAM Jacob Pan <jacob.jun.pan@linux.int=
el.com>
> wrote:
> >
> > Shared Virtual Addressing (SVA) is not immediately intuitive to people
> > who work outside IOMMU subsystem, add some explanation to make it less
> > opaque. =20
>=20
> So the patch has at least two problems.
>=20
> The first is that you corrupted the SPDX line.
>=20
Sorry, my mistake. Will not try sending patches before fully waking up.

> But the second is that the change from
>=20
> -       bool
> +       bool "Shared Virtual Addressing"
>=20
> means that now Kconfig *asks* about this thing, which was never the
> intent. The other Kconfig options that need it all do a
>=20
>         select IOMMU_SVA
>=20
> to get it picked.
>=20
> I suspect that's why it then causes errors - because now the test
> robot can enable the option even in situations where it makes no sense
> and doesn't work.
>=20
> So no, it's not that the option needs a help entry that can be queried
> at Kconfig time. It's that the option needs a name that makes sense
> and isn't some random jumble of letters that is only understandable to
> people who already know exactly what it is.
Right, how about IOMMU_SHARING_CPU_PGTABLE?

Since this is more of a one-sided relationship where IOMMU walks CPU page
tables.


Thanks,

Jacob
