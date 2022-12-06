Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1F96449E7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbiLFRDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbiLFRDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:03:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3094F60C9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:03:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A84B2617DE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 17:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31E7C433D6;
        Tue,  6 Dec 2022 17:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670346209;
        bh=cfYW1byqkMwLKYDFGfM1WhEMyq4FB1S0nFAddEHLuYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sa6OFIzBio19cJzqDyx3HZ4wADsqG5dqXyVrg0MdpPVov+0QAtv1XQukIt+oo6YzV
         zcmS540xD1oEgbfONVIz3k8OJz//DJWUBx6qtX/yhZHHojpRo/NoPbgSUSCS647jsg
         eG6tLYyeF0gqn02oD0VA5Ha4ChCbMbNlE4VbObCExD4NtDt7mR+gprwpIxzVjvPBjZ
         c8KIgOU/VbcrUy9LciuNpKf2xb/rSqWx9r+LEHTFIwHPLmn2nWqPAYt9Wb+NXPmevS
         P96KqhPuGDwIZ2TtYFVxNnuRzuI20wvm65+6NOd03TrVhNZQSK+AulyActiBZ52y27
         z0Fa9j6nZOtog==
Date:   Tue, 6 Dec 2022 10:03:26 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Mikhail Zhilkin <csharper2005@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
Subject: Re: ld.lld: error: undefined symbol: __udivdi3
Message-ID: <Y4913gH2tvIED61P@dev-arch.thelio-3990X>
References: <202212010140.pIueEBNb-lkp@intel.com>
 <20221201091610.524f7786@xps-13>
 <Y4jPubD53yN32OUL@dev-arch.thelio-3990X>
 <20221201171331.42f05097@xps-13>
 <CAC2txAZpGooRGSxh4x9T7Y9b4OvfePx5=YuJoyaSwk1M_EvwtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC2txAZpGooRGSxh4x9T7Y9b4OvfePx5=YuJoyaSwk1M_EvwtQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

First and foremost, apologies for the delay in my response!

On Thu, Dec 01, 2022 at 09:39:22PM +0300, Mikhail Zhilkin wrote:
> Hi Miquèl, Nathan,
> 
> On 12/1/2022 7:13 PM, Miquel Raynal wrote:
> > Hi Nathan,
> >
> > nathan@kernel.org wrote on Thu, 1 Dec 2022 09:00:57 -0700:
> >
> >> On Thu, Dec 01, 2022 at 09:16:10AM +0100, Miquel Raynal wrote:
> >>> Hi Mikhail, Hiroshi,
> >>>
> >>> lkp@intel.com wrote on Thu, 1 Dec 2022 01:46:36 +0800:
> >>>
> >>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >>>> head:   01f856ae6d0ca5ad0505b79bf2d22d7ca439b2a1
> >>>> commit: 9b78ef0c7997052e9eaa0f7a4513d546fa17358c mtd: parsers: add support for Sercomm partitions
> >>>> date:   6 months ago
> >>>> config: mips-randconfig-r033-20221128
> >>>> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 6e4cea55f0d1104408b26ac574566a0e4de48036)
> >>>> reproduce (this is a W=1 build):
> >>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>>>         chmod +x ~/bin/make.cross
> >>>>         # install mips cross compiling tool for clang build
> >>>>         # apt-get install binutils-mipsel-linux-gnu
> >>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9b78ef0c7997052e9eaa0f7a4513d546fa17358c
> >>>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >>>>         git fetch --no-tags linus master
> >>>>         git checkout 9b78ef0c7997052e9eaa0f7a4513d546fa17358c
> >>>>         # save the config file
> >>>>         mkdir build_dir && cp config build_dir/.config
> >>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash
> >>>>
> >>>> If you fix the issue, kindly add following tag where applicable
> >>>> | Reported-by: kernel test robot <lkp@intel.com>
> >>>>
> >>>> All errors (new ones prefixed by >>):
> >>>>
> >>>>>> ld.lld: error: undefined symbol: __udivdi3
> >>>>    >>> referenced by scpart.c
> >>>>    >>>               mtd/parsers/scpart.o:(scpart_parse) in archive drivers/built-in.a
> >>>>
> >>> Can you please try to reproduce this with a mips toolchain as advised
> >>> and send a fix?
> >> For what it's worth, this is likely our bug:
> >>
> >> https://github.com/ClangBuiltLinux/linux/issues/1635
> >>
> >> It sounds like there are some merged LLVM patches that should help but I
> >> guess not based on this report...
> > Ah, yeah, thanks a lot for the share.
> >
> > Cheers, Miquèl
> 
> I could reproduce the issue and found that reference to __udivdi3
> appears in this function:
> 
> static uint32_t scpart_desc_is_valid(struct sc_part_desc *pdesc)
> {
>         return ((pdesc->part_id != 0xffffffffUL) &&
>                 (pdesc->part_offs != 0xffffffffUL) &&
>                 (pdesc->part_bytes != 0xffffffffUL));
> }
> 
> There is no LLVM compiler error if:
> 
> static uint32_t scpart_desc_is_valid(struct sc_part_desc *pdesc)
> {
>         return (0);
> }
> 
> Currently I have no ideas where does __udivdi3 come from, because
> there's no division here. Should I try to rewrite somehow the function
> to avoid the error?
> I would greatly appreciate any ideas.

I do not think it is that function that is causing the problem. Making
it return zero just causes the code generation to change enough to avoid
this issue.

Based on the previous analysis and reduction [1], LLVM is transforming
the for loop in scpart_scan_partmap() into division; you can verify this
by commenting it out some way then rebuilding and running 'readelf -s'
to look for __udivdi3.

Arnd suggested working around this problem by making offs a 32-bit type,
as it is already bounded by ->erasesize, which appears to be a 32-bit
value from what I can tell. Making a change like so appears to resolve
the issue for me but I am not sure if that has any other implications.

diff --git a/drivers/mtd/parsers/scpart.c b/drivers/mtd/parsers/scpart.c
index 02601bb33de4..6e5e11c37078 100644
--- a/drivers/mtd/parsers/scpart.c
+++ b/drivers/mtd/parsers/scpart.c
@@ -50,7 +50,7 @@ static int scpart_scan_partmap(struct mtd_info *master, loff_t partmap_offs,
 	int cnt = 0;
 	int res = 0;
 	int res2;
-	loff_t offs;
+	uint32_t offs;
 	size_t retlen;
 	struct sc_part_desc *pdesc = NULL;
 	struct sc_part_desc *tmpdesc;

[1]: https://github.com/ClangBuiltLinux/linux/issues/1635

Cheers,
Nathan
