Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9426ED4D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjDXSvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjDXSvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:51:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A73AD10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:50:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 104DF61D84
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 18:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15378C433D2;
        Mon, 24 Apr 2023 18:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682362185;
        bh=zjlYhHxKHeqUF6RB2iDS2/naizCqGReUTue1BVeagn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lG/OMVmrJgvTuySKWuEx4fhXGQ2goaB8I/oNVDY7qd7r1J6ha0H3csE+jgvHcanlr
         4Hj82o7HiZVzVItnSY64ao3SSotIt0a8Xnn8wE+umpAKFy1jM4RW20XGu6XP/bRN1g
         nq8xhUS6QbxLtcRvbbEDIcwUkJ76dP7vDLMnYJ37jC/jwu3OY4Lil9eou7MLTvMCFx
         SfM6xwa2wWRAOrVcpWplTD3ykegFNzy99jLp0j4HynaEqCU8mHMMEdsvLtMNdhbfuQ
         +MvqmUlgIKWGubgdq3mrIfIGgQnLSTrKSF7Jl1TyMth0nm6pq5a69E0rUa9UG8KnBm
         ivG5/enn3fBJw==
Received: by pali.im (Postfix)
        id EB778816; Mon, 24 Apr 2023 20:49:41 +0200 (CEST)
Date:   Mon, 24 Apr 2023 20:49:41 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: {standard input}:924: Error: unrecognized opcode: `eieio'
Message-ID: <20230424184941.44no7rkxjadnyojm@pali>
References: <202304222120.WcBMaHXo-lkp@intel.com>
 <20230422135838.3rn67ky2p7jmdk3n@pali>
 <CAMuHMdX8PP3gH_ctgZgXfV6Psu95eTuCh0MBsEQsRVG_6rEUVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdX8PP3gH_ctgZgXfV6Psu95eTuCh0MBsEQsRVG_6rEUVg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 April 2023 09:49:07 Geert Uytterhoeven wrote:
> Hi Pali,
> 
> On Sat, Apr 22, 2023 at 4:03 PM Pali Rohár <pali@kernel.org> wrote:
> > On Saturday 22 April 2023 21:53:23 kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   8e41e0a575664d26bb87e012c39435c4c3914ed9
> > > commit: ff7c76f66d8bad4e694c264c789249e1d3a8205d powerpc/boot: Don't always pass -mcpu=powerpc when building 32-bit uImage
> > > date:   3 months ago
> > > config: powerpc-buildonly-randconfig-r006-20230422 (https://download.01.org/0day-ci/archive/20230422/202304222120.WcBMaHXo-lkp@intel.com/config)
> > > compiler: powerpc-linux-gcc (GCC) 12.1.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ff7c76f66d8bad4e694c264c789249e1d3a8205d
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout ff7c76f66d8bad4e694c264c789249e1d3a8205d
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
> > >
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Link: https://lore.kernel.org/oe-kbuild-all/202304222120.WcBMaHXo-lkp@intel.com/
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >    {standard input}: Assembler messages:
> > > >> {standard input}:924: Error: unrecognized opcode: `eieio'
> > >    {standard input}:1094: Error: unrecognized opcode: `eieio'
> > >
> > > --
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests
> >
> > Hello! What is that? In this error report there is no compile log, nor
> > any file / line. And "Link:" line from above error report does not work.
> >
> > Intel, can you look at your robot? This looks some bug in error reporting.
> 
> Looks fine to me: this is not a compile problem, but an assembler problem.
> Presumably this is when building a kernel for a PPC platform that does
> not support the eieio instruction?

What is fine on this report? There is completely missing command which
generated this error; whole error message; input files which caused them
and also change or commit.

And what presumably happened? I'm really not going to spend more time on
guessing what reporter could probably might wanted to write into the
report and start looking into crystal ball what could be an issue.

I can say that this issue presumably happened when email operator of
this robot pushed incorrect button and instead of the real report, it
sent test report with content of some random error line from the random
log file.

Are we on the technical discussion about exactness? Or are going to
discuss what who think that what could happened?

> The Link: works fine for me, sometimes you just have to be a little bit
> patient for the archiver to catch up...

Sorry, I do not have time to wait undefined amount of time to access
additional resources which are based on reported details required for
debugging.

Intel, could you please react on this issue? If not, I'm going to add
your robot to my black list. It is not first time when I received such
useless report from you and nobody reacted on it.

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
