Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258196282E0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbiKNOkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237063AbiKNOjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:39:46 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DFC2099B;
        Mon, 14 Nov 2022 06:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668436777; x=1699972777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0p1aFZmokWFv/YvtG1Dxt87fVW/BDd9HRj23KFuYuZM=;
  b=Zgl87nJqPHFiRKMYL7XDtVT/ga/d3ioBs2gBkZLeqxZtGAhi23hkWyXT
   DmcfBCpHF7HKpdmGqMqeABeIabccUSfblgo1MgDlQnb4HBZoXZX5Azdj1
   QiLDrsnLsWVuW9/xsADLtkWofX3fuYx3HjyHyHdJNBuK/51wa1iKp4WSs
   Op7DcX0u7dN533eq8RtLgaAkmYV3a0Pii+aVGJamZle0K+zBXTZ4n4VXG
   0+sMsCjrPtXosO6e8/Ci/4T6DHWQgrD0orNEQvX1Hu5WHq2OliuOSQX7/
   akaXs7my9jT0mj/9oEyD94CBkhf4IUxWFKZgWu0tSpt+GKjdA0kw4Ms3j
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313127933"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="313127933"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 06:39:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="813275625"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="813275625"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 14 Nov 2022 06:39:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ouacT-00CCyz-1k;
        Mon, 14 Nov 2022 16:39:29 +0200
Date:   Mon, 14 Nov 2022 16:39:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Andrew Davis <afd@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
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
Message-ID: <Y3JTIbU7PkNUpU34@smile.fi.intel.com>
References: <20221024173434.32518-1-afd@ti.com>
 <CAL_JsqJxgVwsjKnkCEkZeoSsDgaRD+DVPkHRBc2SrcSq69PBNw@mail.gmail.com>
 <Y26lDEtiG4KFzc91@smile.fi.intel.com>
 <e5ce57b2-4557-2dcb-fb3a-71e2acae4502@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5ce57b2-4557-2dcb-fb3a-71e2acae4502@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 03:05:20PM -0600, Andrew Davis wrote:
> On 11/11/22 1:39 PM, Andy Shevchenko wrote:
> > On Wed, Oct 26, 2022 at 09:11:21AM -0500, Rob Herring wrote:
> > > On Mon, Oct 24, 2022 at 12:34 PM Andrew Davis <afd@ti.com> wrote:
> > > > 
> > > > Hello all,
> > > > 
> > > > This is a series based on my patch here[0]. As suggested by Rob
> > > > I've resurrected Frank's patch and appended it to mine as a series.
> > > > 
> > > > First patch here is my original patch, 3rd is Frank's patch but with
> > > > the unittest changes pulled out into the 2nd patch. That was re-worked
> > > > moving the source building macro into scripts/Makefile.lib.
> > > > 
> > > > Patches 4, 5, and 6 are an attempt at renaming all the existing DTB
> > > > overlays. Split out by platform so they could be taken by platform
> > > > maintainers or if easier ACK'd here and taken all together.
> > > > 
> > > > This should cover all the DTB overlays so we can remove the old .dts
> > > > rule for overlays and make .dtso the only supported way, let me know
> > > > if we want that this cycle and I can post that too.
> > > > 
> > > > Thanks,
> > > > Andrew
> > > > 
> > > > Changes from v1[1]:
> > > >   - Added patch to rename pi433 overlay.
> > > >   - Cleaned wording on patch 4-6.
> > > >   - Collected some ACKs
> > > > 
> > > > [0] https://www.spinics.net/lists/kernel/msg4548509.html
> > > > [1] https://www.spinics.net/lists/arm-kernel/msg1020165.html
> > > > 
> > > > Andrew Davis (6):
> > > >    kbuild: Allow DTB overlays to built from .dtso named source files
> > > >    kbuild: Allow DTB overlays to built into .dtso.S files
> > > >    arm64: dts: freescale: Rename DTB overlay source files from .dts to
> > > >      .dtso
> > > >    arm64: dts: renesas: Rename DTB overlay source files from .dts to
> > > >      .dtso
> > > >    arm64: dts: xilinx: Rename DTB overlay source files from .dts to .dtso
> > > >    staging: pi433: overlay: Rename overlay source file from .dts to .dtso
> > > > 
> > > > Frank Rowand (1):
> > > >    of: overlay: rename overlay source files from .dts to .dtso
> > > 
> > > I've applied patches 1-3 and 7. I'll send a PR for the branch to the
> > > platform maintainers after a few days in linux-next.
> > 
> > The patch
> > 
> > commit 941214a512d8c80d47e720c17ec17e8539175e93
> > Author: Andrew Davis <afd@ti.com>
> > Date:   Mon Oct 24 12:34:29 2022 -0500
> > 
> >      kbuild: Allow DTB overlays to built into .dtbo.S files
> > 
> > broke the build reproducibility / no-op builds.
> > 
> > Before:
> >    2+ execution of `make` on non-changed tree did nothing
> > 
> > Now:
> >    Each run of `make` (even without a single bit changed) restarts vmlinux
> >    rebuild.
> > 
> > Please, revert or fix.
> > 
> 
> I do not see this behavior. What config are you using?
> 
> Not sure how this patch could be the root cause, it only adds
> a build target/rule, but doesn't actually use it anywhere yet..

Just to confirm, I reverted the patch and everything went fine again,
so simple revert helps!

(Tested on today's Linux Next)

-- 
With Best Regards,
Andy Shevchenko


