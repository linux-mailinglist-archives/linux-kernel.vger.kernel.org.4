Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E267626229
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 20:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiKKTkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 14:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiKKTkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 14:40:05 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2FD7BE68;
        Fri, 11 Nov 2022 11:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668195604; x=1699731604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GLdMSB5CsEKL3506k4a4m+VfHEqPk8gt4vgr9ECm460=;
  b=RN3Y/Ld5ZqXQkdaVkwf4k6a6F7CtGCYf27M9f0YLMHoZmTHeLW+qcOyX
   IezvlhZCArgsdRGJK8FischrgGiFnLknXzHydXqj8qj/bk4W3MxMxsRbu
   xxBMh/UmficwDAFuQ6y6oVb/F+YFgCeSU2lGoidUPAAGqUVuoaYBp05/p
   PbeB4faUW9qEruQ8oiP4itSv9BcHtnYMgK5SuTiJkyIZ8OuUnKQKJykpJ
   /0GQIOLhVDnE3ZyxEQu0+Adv675pE4hoiQBrJtACiCkeJ28vXPKiCKuKP
   51xstpk0Nru1+Q4ieiDak4jIO6t+tOMzIkL2eQ1V2fFBCwGRjcHK8uWje
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="311660271"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="311660271"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 11:40:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="637674932"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="637674932"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 11 Nov 2022 11:39:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1otZsb-00AsUm-0A;
        Fri, 11 Nov 2022 21:39:57 +0200
Date:   Fri, 11 Nov 2022 21:39:56 +0200
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
Message-ID: <Y26lDEtiG4KFzc91@smile.fi.intel.com>
References: <20221024173434.32518-1-afd@ti.com>
 <CAL_JsqJxgVwsjKnkCEkZeoSsDgaRD+DVPkHRBc2SrcSq69PBNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJxgVwsjKnkCEkZeoSsDgaRD+DVPkHRBc2SrcSq69PBNw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 09:11:21AM -0500, Rob Herring wrote:
> On Mon, Oct 24, 2022 at 12:34 PM Andrew Davis <afd@ti.com> wrote:
> >
> > Hello all,
> >
> > This is a series based on my patch here[0]. As suggested by Rob
> > I've resurrected Frank's patch and appended it to mine as a series.
> >
> > First patch here is my original patch, 3rd is Frank's patch but with
> > the unittest changes pulled out into the 2nd patch. That was re-worked
> > moving the source building macro into scripts/Makefile.lib.
> >
> > Patches 4, 5, and 6 are an attempt at renaming all the existing DTB
> > overlays. Split out by platform so they could be taken by platform
> > maintainers or if easier ACK'd here and taken all together.
> >
> > This should cover all the DTB overlays so we can remove the old .dts
> > rule for overlays and make .dtso the only supported way, let me know
> > if we want that this cycle and I can post that too.
> >
> > Thanks,
> > Andrew
> >
> > Changes from v1[1]:
> >  - Added patch to rename pi433 overlay.
> >  - Cleaned wording on patch 4-6.
> >  - Collected some ACKs
> >
> > [0] https://www.spinics.net/lists/kernel/msg4548509.html
> > [1] https://www.spinics.net/lists/arm-kernel/msg1020165.html
> >
> > Andrew Davis (6):
> >   kbuild: Allow DTB overlays to built from .dtso named source files
> >   kbuild: Allow DTB overlays to built into .dtso.S files
> >   arm64: dts: freescale: Rename DTB overlay source files from .dts to
> >     .dtso
> >   arm64: dts: renesas: Rename DTB overlay source files from .dts to
> >     .dtso
> >   arm64: dts: xilinx: Rename DTB overlay source files from .dts to .dtso
> >   staging: pi433: overlay: Rename overlay source file from .dts to .dtso
> >
> > Frank Rowand (1):
> >   of: overlay: rename overlay source files from .dts to .dtso
> 
> I've applied patches 1-3 and 7. I'll send a PR for the branch to the
> platform maintainers after a few days in linux-next.

The patch

commit 941214a512d8c80d47e720c17ec17e8539175e93
Author: Andrew Davis <afd@ti.com>
Date:   Mon Oct 24 12:34:29 2022 -0500

    kbuild: Allow DTB overlays to built into .dtbo.S files

broke the build reproducibility / no-op builds.

Before:
  2+ execution of `make` on non-changed tree did nothing

Now:
  Each run of `make` (even without a single bit changed) restarts vmlinux
  rebuild.

Please, revert or fix.

-- 
With Best Regards,
Andy Shevchenko


