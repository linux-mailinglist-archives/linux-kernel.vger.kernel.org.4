Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E19626233
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 20:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiKKTkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 14:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiKKTkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 14:40:52 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538287BE61;
        Fri, 11 Nov 2022 11:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668195651; x=1699731651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fFNGAopNsEUDaSLTEz0N2ksNPAD8Kjy6qte9wZeZ1Yc=;
  b=OA1fUlSNk9pBsUp4Jdi2R8sD+r9ai7txronDcfRDgrz5jEJbvNMQxptJ
   Xa9ELNVg8ztSz0vQOKzFcfKAYsMXdgsrEJCvrqRF19rc99n/xQkgtuIZr
   5gLDAqahrbRrq4dSK9hdMhirZWWGjgv9cokDpVySsVmcGTOgNgoSUZ62c
   wsTre2UjwGowkh31WoksluTydTgEE/tVfvek1+r9nMmJV6tlt09eBGpn1
   DJ6fNRLEgwPjNOU/BNuGF7rjtvrgZnfE6qv3VFZ2grksVQS5XwH7biXCg
   RFTNnLo+FkU02la/xGv//olE6taLYtozAk2Nyn0uVjabzFPgVcj1ATGRc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="292057668"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="292057668"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 11:40:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="706628599"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="706628599"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 11 Nov 2022 11:40:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1otZtM-00AsVs-1e;
        Fri, 11 Nov 2022 21:40:44 +0200
Date:   Fri, 11 Nov 2022 21:40:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Andrew Davis <afd@ti.com>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Rename DTB overlay source files
Message-ID: <Y26lPFQ5JnJ7NAp+@smile.fi.intel.com>
References: <20221024173434.32518-1-afd@ti.com>
 <CAL_JsqJxgVwsjKnkCEkZeoSsDgaRD+DVPkHRBc2SrcSq69PBNw@mail.gmail.com>
 <Y26lDEtiG4KFzc91@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y26lDEtiG4KFzc91@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 09:39:57PM +0200, Andy Shevchenko wrote:
> On Wed, Oct 26, 2022 at 09:11:21AM -0500, Rob Herring wrote:
> > On Mon, Oct 24, 2022 at 12:34 PM Andrew Davis <afd@ti.com> wrote:
> > >
> > > Hello all,
> > >
> > > This is a series based on my patch here[0]. As suggested by Rob
> > > I've resurrected Frank's patch and appended it to mine as a series.
> > >
> > > First patch here is my original patch, 3rd is Frank's patch but with
> > > the unittest changes pulled out into the 2nd patch. That was re-worked
> > > moving the source building macro into scripts/Makefile.lib.
> > >
> > > Patches 4, 5, and 6 are an attempt at renaming all the existing DTB
> > > overlays. Split out by platform so they could be taken by platform
> > > maintainers or if easier ACK'd here and taken all together.
> > >
> > > This should cover all the DTB overlays so we can remove the old .dts
> > > rule for overlays and make .dtso the only supported way, let me know
> > > if we want that this cycle and I can post that too.
> > >
> > > Thanks,
> > > Andrew
> > >
> > > Changes from v1[1]:
> > >  - Added patch to rename pi433 overlay.
> > >  - Cleaned wording on patch 4-6.
> > >  - Collected some ACKs
> > >
> > > [0] https://www.spinics.net/lists/kernel/msg4548509.html
> > > [1] https://www.spinics.net/lists/arm-kernel/msg1020165.html
> > >
> > > Andrew Davis (6):
> > >   kbuild: Allow DTB overlays to built from .dtso named source files
> > >   kbuild: Allow DTB overlays to built into .dtso.S files
> > >   arm64: dts: freescale: Rename DTB overlay source files from .dts to
> > >     .dtso
> > >   arm64: dts: renesas: Rename DTB overlay source files from .dts to
> > >     .dtso
> > >   arm64: dts: xilinx: Rename DTB overlay source files from .dts to .dtso
> > >   staging: pi433: overlay: Rename overlay source file from .dts to .dtso
> > >
> > > Frank Rowand (1):
> > >   of: overlay: rename overlay source files from .dts to .dtso
> > 
> > I've applied patches 1-3 and 7. I'll send a PR for the branch to the
> > platform maintainers after a few days in linux-next.
> 
> The patch
> 
> commit 941214a512d8c80d47e720c17ec17e8539175e93
> Author: Andrew Davis <afd@ti.com>
> Date:   Mon Oct 24 12:34:29 2022 -0500
> 
>     kbuild: Allow DTB overlays to built into .dtbo.S files
> 
> broke the build reproducibility / no-op builds.
> 
> Before:
>   2+ execution of `make` on non-changed tree did nothing
> 
> Now:
>   Each run of `make` (even without a single bit changed) restarts vmlinux
>   rebuild.
> 
> Please, revert or fix.

git bisect start
# good: [f0c4d9fc9cc9462659728d168387191387e903cc] Linux 6.1-rc4
git bisect good f0c4d9fc9cc9462659728d168387191387e903cc
# bad: [f8f60f322f0640c8edda2942ca5f84b7a27c417a] Add linux-next specific files for 20221111
git bisect bad f8f60f322f0640c8edda2942ca5f84b7a27c417a
# good: [66500d0e2e5c9b64fc5d3f4879e2140572e1b386] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good 66500d0e2e5c9b64fc5d3f4879e2140572e1b386
# bad: [080c1179d77ad36d6e51469b68801ef341ec292a] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
git bisect bad 080c1179d77ad36d6e51469b68801ef341ec292a
# good: [7f5ff6593cc1b1ec2442be30eaf043cf09fa9282] Merge branch 'for-next' of https://gitlab.freedesktop.org/drm/tegra.git
git bisect good 7f5ff6593cc1b1ec2442be30eaf043cf09fa9282
# good: [c16d93a496889347965a860dc4fe493b642f8aff] Merge branch 'for-next' of git://git.kernel.dk/linux-block.git
git bisect good c16d93a496889347965a860dc4fe493b642f8aff
# good: [c9ef15a7221d84edcf03b422ef0a4e43affda226] Merge branch 'next-integrity' of git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity
git bisect good c9ef15a7221d84edcf03b422ef0a4e43affda226
# good: [736894df52110a9e2e106708d848ab08516e5910] Merge branch 'next/dt' into for-next
git bisect good 736894df52110a9e2e106708d848ab08516e5910
# good: [d19d44e32c93cfa815b22ee2254cd1f541a20116] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
git bisect good d19d44e32c93cfa815b22ee2254cd1f541a20116
# good: [93cc2559d3fdcd28b1a7972ab519a6cd8ba20f9d] spi: Remove the obsolte u64_stats_fetch_*_irq() users.
git bisect good 93cc2559d3fdcd28b1a7972ab519a6cd8ba20f9d
# bad: [26c9134a370ace32cda7a3f9efaf4ca85e57ca8d] Merge branch 'dt/dtbo-rename' into dt/next
git bisect bad 26c9134a370ace32cda7a3f9efaf4ca85e57ca8d
# good: [c9adc3bd1180d2911d2b1b886dbec916805be998] dt-bindings: Remove "status" from schema examples, again
git bisect good c9adc3bd1180d2911d2b1b886dbec916805be998
# bad: [fa9665ef77f5d8e861e2ed7563ebdbddddc6f82b] staging: pi433: overlay: Rename overlay source file from .dts to .dtso
git bisect bad fa9665ef77f5d8e861e2ed7563ebdbddddc6f82b
# bad: [941214a512d8c80d47e720c17ec17e8539175e93] kbuild: Allow DTB overlays to built into .dtbo.S files
git bisect bad 941214a512d8c80d47e720c17ec17e8539175e93
# good: [363547d2191cbc32ca954ba75d72908712398ff2] kbuild: Allow DTB overlays to built from .dtso named source files
git bisect good 363547d2191cbc32ca954ba75d72908712398ff2
# first bad commit: [941214a512d8c80d47e720c17ec17e8539175e93] kbuild: Allow DTB overlays to built into .dtbo.S files


-- 
With Best Regards,
Andy Shevchenko


