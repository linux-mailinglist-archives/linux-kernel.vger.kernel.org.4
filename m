Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4956284A1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbiKNQHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbiKNQHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:07:01 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E57E21E27;
        Mon, 14 Nov 2022 08:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668442019; x=1699978019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kTFRt27GKYH3jdgFcHIV7XHhic+olXeSBwmXgyprWgo=;
  b=Q4tS7jIJY+YGswb6lNn1NMSRKaD/zYiRJ6/LYTj5dThJQgEE7podpZiP
   7NF9gjKZzIgjxo9kZH4i0LWdVT2H/WotRlO4YVOX9t23nLWjcO8rZo70h
   ZisBG1YW6Snor7Vr89brFyPywk8dueB3m23x5Jp+bJ439KoNLSbud7px2
   mKIHl+f43HCJGqjf853s05u99qK2E/UtxrHrZlfkJt5m+EDfs1tMTK4/F
   lcC1bkbliP5OWL8qqlYN3/CDKBh2u7wMDwe3EotvVyG2oTrwmldix4zdC
   Z/Bpgtf6wM2gpeSDQh+XVUB90yLT4r1ePEym9NpoWgUX/vvUIC0hxmjaZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="299526216"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="299526216"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:06:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="669709474"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="669709474"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 14 Nov 2022 08:06:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oubyX-00CEzk-2t;
        Mon, 14 Nov 2022 18:06:21 +0200
Date:   Mon, 14 Nov 2022 18:06:21 +0200
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
Message-ID: <Y3JnfSUpBfATkD69@smile.fi.intel.com>
References: <20221024173434.32518-1-afd@ti.com>
 <CAL_JsqJxgVwsjKnkCEkZeoSsDgaRD+DVPkHRBc2SrcSq69PBNw@mail.gmail.com>
 <Y26lDEtiG4KFzc91@smile.fi.intel.com>
 <e5ce57b2-4557-2dcb-fb3a-71e2acae4502@ti.com>
 <Y3DhIO7H9mfRpe3z@smile.fi.intel.com>
 <Y3Dk0HJAPuq64tKe@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Dk0HJAPuq64tKe@smile.fi.intel.com>
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

On Sun, Nov 13, 2022 at 02:36:33PM +0200, Andy Shevchenko wrote:
> On Sun, Nov 13, 2022 at 02:20:48PM +0200, Andy Shevchenko wrote:
> > On Fri, Nov 11, 2022 at 03:05:20PM -0600, Andrew Davis wrote:
> > > On 11/11/22 1:39 PM, Andy Shevchenko wrote:
> > > > On Wed, Oct 26, 2022 at 09:11:21AM -0500, Rob Herring wrote:
> > > > > On Mon, Oct 24, 2022 at 12:34 PM Andrew Davis <afd@ti.com> wrote:
> > > > > > 
> > > > > > Hello all,
> > > > > > 
> > > > > > This is a series based on my patch here[0]. As suggested by Rob
> > > > > > I've resurrected Frank's patch and appended it to mine as a series.
> > > > > > 
> > > > > > First patch here is my original patch, 3rd is Frank's patch but with
> > > > > > the unittest changes pulled out into the 2nd patch. That was re-worked
> > > > > > moving the source building macro into scripts/Makefile.lib.
> > > > > > 
> > > > > > Patches 4, 5, and 6 are an attempt at renaming all the existing DTB
> > > > > > overlays. Split out by platform so they could be taken by platform
> > > > > > maintainers or if easier ACK'd here and taken all together.
> > > > > > 
> > > > > > This should cover all the DTB overlays so we can remove the old .dts
> > > > > > rule for overlays and make .dtso the only supported way, let me know
> > > > > > if we want that this cycle and I can post that too.
> > > > > > 
> > > > > > Thanks,
> > > > > > Andrew
> > > > > > 
> > > > > > Changes from v1[1]:
> > > > > >   - Added patch to rename pi433 overlay.
> > > > > >   - Cleaned wording on patch 4-6.
> > > > > >   - Collected some ACKs
> > > > > > 
> > > > > > [0] https://www.spinics.net/lists/kernel/msg4548509.html
> > > > > > [1] https://www.spinics.net/lists/arm-kernel/msg1020165.html
> > > > > > 
> > > > > > Andrew Davis (6):
> > > > > >    kbuild: Allow DTB overlays to built from .dtso named source files
> > > > > >    kbuild: Allow DTB overlays to built into .dtso.S files
> > > > > >    arm64: dts: freescale: Rename DTB overlay source files from .dts to
> > > > > >      .dtso
> > > > > >    arm64: dts: renesas: Rename DTB overlay source files from .dts to
> > > > > >      .dtso
> > > > > >    arm64: dts: xilinx: Rename DTB overlay source files from .dts to .dtso
> > > > > >    staging: pi433: overlay: Rename overlay source file from .dts to .dtso
> > > > > > 
> > > > > > Frank Rowand (1):
> > > > > >    of: overlay: rename overlay source files from .dts to .dtso
> > > > > 
> > > > > I've applied patches 1-3 and 7. I'll send a PR for the branch to the
> > > > > platform maintainers after a few days in linux-next.
> > > > 
> > > > The patch
> > > > 
> > > > commit 941214a512d8c80d47e720c17ec17e8539175e93
> > > > Author: Andrew Davis <afd@ti.com>
> > > > Date:   Mon Oct 24 12:34:29 2022 -0500
> > > > 
> > > >      kbuild: Allow DTB overlays to built into .dtbo.S files
> > > > 
> > > > broke the build reproducibility / no-op builds.
> > > > 
> > > > Before:
> > > >    2+ execution of `make` on non-changed tree did nothing
> > > > 
> > > > Now:
> > > >    Each run of `make` (even without a single bit changed) restarts vmlinux
> > > >    rebuild.
> > > > 
> > > > Please, revert or fix.
> > > > 
> > > 
> > > I do not see this behavior. What config are you using?
> > > 
> > > Not sure how this patch could be the root cause, it only adds
> > > a build target/rule, but doesn't actually use it anywhere yet..
> > 
> > For your reference I started with this one [1].
> > 
> > When I bisected, I just answered with defaults on whatever `make` told me at
> > the configuration stage.
> > 
> > The actual `make` command I used:
> > 
> > 	make O=/path/to/the/result W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64
> > 
> > But there is nothing that can affect the described issue.
> 
> Actually, O= might affect which Makefile is used and how.
> The C=, CF= are sparse flags, W= is just warning level.

As far as I can tell right now it's the OF_UNITTEST on x86_64 that makes the
above mentioned patch to be a culprit. Not sure if on ARM / ARM64 you can
reproduce that. And it's really strange nobody reported this for a week+.

Whatever, I'm open for the suggestions and material to test.

> > [1]: https://p.defau.lt/?ZSOdGnNxF9v9AQtrfDo_KQ

-- 
With Best Regards,
Andy Shevchenko


