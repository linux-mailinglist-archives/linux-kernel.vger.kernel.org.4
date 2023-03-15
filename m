Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A596BB6EB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjCOPHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjCOPHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:07:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED68A1CF75
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:07:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2292EB81E38
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 15:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538D8C433D2;
        Wed, 15 Mar 2023 15:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678892818;
        bh=0VS5z/SY5YVlGp0lkvjYy6YqqlFxJB1nhyXt2ZMbAkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AW2Am2bMDkdmPg6x/Wm+JnnpZf0shSfU7wefaEC9rvn8uQyhaaq9yvENrA9dKAdc/
         CkP6xgtIGdDz2cS7E/yU+kZJokopFchEWbBZbJJIzsoL9VocFt7qY0K7fJ5uuvQGTh
         wx3qpXVvqZ3LTuKgxwKP1rtZOoL1UvATBZK9CHLvmCtm0ykdWl2J4/MW1HSfnsFgAJ
         ywUm2w1KVGuBnF9gCJbIioxBkdNON17LrRhzfdJoOpqj1twTsifS/YED6Jo4/CjcFG
         IyjPOLrjvs/ZciCuMK/uetiDh4Q2jvhQm5VCEREX7/zwA/b1tA6GBJG6vmDsjaoS14
         RW/nMYJzNZiAw==
Date:   Wed, 15 Mar 2023 08:06:56 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <20230315150656.GA2938956@dev-arch.thelio-3990X>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine>
 <ZBEJ+8DbhADSBTLr@aschofie-mobl2>
 <ZBG699SriXWy1I2K@khadija-virtual-machine>
 <16148020.1MiD057Pog@suse>
 <ZBHUr7bANuhnOnIV@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBHUr7bANuhnOnIV@khadija-virtual-machine>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Khadija,

On Wed, Mar 15, 2023 at 07:22:39PM +0500, Khadija Kamran wrote:
> On Wed, Mar 15, 2023 at 02:34:31PM +0100, Fabio M. De Francesco wrote:
> > Aside from what I said and asked for with the other message of this same 
> > thread, please take note that you can build a specific module if you prefer 
> > not to re-build the whole kernel and other modules at the same time. 
> > 
> > I'm pretty sure that the instructions to do so are in the OutreachyFirstPatch 
> > tutorial.
> > 
> > If they are not there, please let us know.
> > 
> > Fabio
> 
> Hey Fabio!
> 
> In the Outreachy FirstPatchTutorial under the 'Compiling only part of
> the kernel' section there are ways to compile only some part of the
> kernel.
> 
> I have tried using "make W=1 drivers/staging/axis-fifo/" and it says
> 'nothing to be done for'. 

Is CONFIG_XIL_AXIS_FIFO enabled in your configuration?

> Should I start with the steps to reproduce? :'(

I did see a report of this same warning occurring with GCC but the
report I commented on cane from clang/LLVM; using that toolchain may
make it easier for you to reproduce this issue. The robot's reproduction
instructions are fine but I think doing it manually is actually simpler.

Ubuntu 22.04 should have a pretty modern version of clang/LLVM, which
you can install via 'sudo apt install clang lld llvm'.
https://apt.llvm.org is another resource.

First, we will grab the configuration that was provided in the report:

$ wget -O .config https://download.01.org/0day-ci/archive/20230314/202303141159.6wN9HNP9-lkp@intel.com/config

Next, we want to make sure the configuration is synced, since we are
technically changing compilers:

$ make -j"$(nproc)" ARCH=arm64 LLVM=1 olddefconfig

Finally, you should be able to build that object file and see the
warning:

$ make -j"$(nproc)" ARCH=arm64 LLVM=1 drivers/staging/axis-fifo/
...
drivers/staging/axis-fifo/axis-fifo.c:817:18: warning: implicit conversion from 'long' to 'int' changes value from 9223372036854775807 to -1 [-Wconstant-conversion]
                read_timeout = MAX_SCHEDULE_TIMEOUT;
                             ~ ^~~~~~~~~~~~~~~~~~~~
./include/linux/sched.h:296:31: note: expanded from macro 'MAX_SCHEDULE_TIMEOUT'
#define MAX_SCHEDULE_TIMEOUT            LONG_MAX
                                        ^~~~~~~~
./include/vdso/limits.h:11:19: note: expanded from macro 'LONG_MAX'
#define LONG_MAX        ((long)(~0UL >> 1))
                         ^~~~~~~~~~~~~~~~~
drivers/staging/axis-fifo/axis-fifo.c:822:19: warning: implicit conversion from 'long' to 'int' changes value from 9223372036854775807 to -1 [-Wconstant-conversion]
                write_timeout = MAX_SCHEDULE_TIMEOUT;
                              ~ ^~~~~~~~~~~~~~~~~~~~
./include/linux/sched.h:296:31: note: expanded from macro 'MAX_SCHEDULE_TIMEOUT'
#define MAX_SCHEDULE_TIMEOUT            LONG_MAX
                                        ^~~~~~~~
./include/vdso/limits.h:11:19: note: expanded from macro 'LONG_MAX'
#define LONG_MAX        ((long)(~0UL >> 1))
                         ^~~~~~~~~~~~~~~~~
2 warnings generated.

Just repeat the last step as you investigate. If you have any further
issues or questions, please let me know. For the record, I am not
associated with Outreachy (I am one of the maintainers of clang/LLVM
support in the kernel), so if I have messed something up or overstepped
some boundary, I do apologize.

Cheers,
Nathan
