Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494B1613A70
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiJaPn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiJaPnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:43:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E9611A1E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:43:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE8EB612DC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567A3C43470;
        Mon, 31 Oct 2022 15:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667231029;
        bh=+8csB7ag0jGlYs1AESF3sQEoFCh1R5SZlOAfb9oSHKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qc3rXQmYGQ1s3hJTSyCFA8RAug4b7gnWwyMNvqxbGjrrcKe9iqRvbYsit98s+JN2A
         X6JNHTSRthaBjlHZudy8nkR16XxNymX+cN51i/NAsHVHLrvOagXDE6s08TLg4S8UDG
         LZubA8o3x9Vkep3wi6hP4MarlnJiqKn6XyqFzPJ4S0uWLQX0UDAgszquvUYU42Sd6G
         /Pl3LpGRiTgeWeMEV7fwNzxWs6Tx+1KNrrZcGJFuIk94OqtKt1OoleqrfSiVeOYCiF
         pqYLJtUcBntRDDWtYzsdpARHr+RvG6rq4rL57gF+jyw2dw8A5dmUk5Ep1hqECQOpz4
         f4ufTOMt6TO/w==
Date:   Mon, 31 Oct 2022 15:43:44 +0000
From:   Lee Jones <lee@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 28/28] mfd: intel-lpss: Remove #ifdef guards for PM
 related functions
Message-ID: <Y1/tMMEVA5inNyw/@google.com>
References: <20221023094852.8035-29-paul@crapouillou.net>
 <202210232035.D9ecuZtH-lkp@intel.com>
 <Y1/i2TTy1CzJhPLA@google.com>
 <Y1/jvTbEpONmQzW6@dev-arch.thelio-3990X>
 <J6IMKR.EVFG2BDFUG8Q1@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <J6IMKR.EVFG2BDFUG8Q1@crapouillou.net>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022, Paul Cercueil wrote:

> Hi,
> 
> Le lun. 31 oct. 2022 à 08:03:25 -0700, Nathan Chancellor <nathan@kernel.org>
> a écrit :
> > On Mon, Oct 31, 2022 at 02:59:37PM +0000, Lee Jones wrote:
> > >  On Sun, 23 Oct 2022, kernel test robot wrote:
> > > 
> > >  > Hi Paul,
> > >  >
> > >  > I love your patch! Yet something to improve:
> > >  >
> > >  > [auto build test ERROR on lee-mfd/for-mfd-next]
> > >  > [also build test ERROR on linus/master v6.1-rc1 next-20221021]
> > >  > [If your patch is applied to the wrong git tree, kindly drop us a
> > > note.
> > >  > And when submitting patch, we suggest to use '--base' as
> > > documented in
> > >  > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > >  >
> > >  > url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Cercueil/mfd-Remove-ifdef-guards-for-PM-functions/20221023-175612
> > >  > base:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
> > > for-mfd-next
> > >  > patch link:
> > > https://lore.kernel.org/r/20221023094852.8035-29-paul%40crapouillou.net
> > >  > patch subject: [PATCH v3 28/28] mfd: intel-lpss: Remove #ifdef
> > > guards for PM related functions
> > >  > config: i386-randconfig-a013
> > >  > compiler: clang version 14.0.6
> > > (https://github.com/llvm/llvm-project
> > > f28c006a5895fc0e329fe15fead81e37457cb1d1)
> > >  > reproduce (this is a W=1 build):
> > >  >         wget
> > > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > > -O ~/bin/make.cross
> > >  >         chmod +x ~/bin/make.cross
> > >  >         # https://github.com/intel-lab-lkp/linux/commit/873891d1ee1634da028bb74d0e7cfa5d77b2f157
> > >  >         git remote add linux-review
> > > https://github.com/intel-lab-lkp/linux
> > >  >         git fetch --no-tags linux-review
> > > Paul-Cercueil/mfd-Remove-ifdef-guards-for-PM-functions/20221023-175612
> > >  >         git checkout 873891d1ee1634da028bb74d0e7cfa5d77b2f157
> > >  >         # save the config file
> > >  >         mkdir build_dir && cp config build_dir/.config
> > >  >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang
> > > make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/mfd/
> > >  >
> > >  > If you fix the issue, kindly add following tag where applicable
> > >  > | Reported-by: kernel test robot <lkp@intel.com>
> > >  >
> > >  > All errors (new ones prefixed by >>):
> > >  >
> > >  > >> drivers/mfd/intel-lpss-pci.c:75:8: error: type specifier
> > > missing, defaults to 'int' [-Werror,-Wimplicit-int]
> > >  >    static INTEL_LPSS_PM_OPS(intel_lpss_pci_pm_ops);
> > >  >    ~~~~~~ ^
> > >  > >> drivers/mfd/intel-lpss-pci.c:75:26: error: a parameter list
> > > without types is only allowed in a function definition
> > >  >    static INTEL_LPSS_PM_OPS(intel_lpss_pci_pm_ops);
> > >  >                             ^
> > >  >    2 errors generated.
> > > 
> > >  Is this a valid error?
> > 
> > Yes, because this change removes the definition of INTEL_LPSS_PM_OPS in
> > intel-lpss.h.
> 
> The "static INTEL_LPSS_PM_OPS(intel_lpss_pci_pm_ops)" is dead code; just
> removing this line should be enough to make it work.
> 
> I'll V2 when I find some time.

Thanks.

I'll put this set on hold for v2.

-- 
Lee Jones [李琼斯]
