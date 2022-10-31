Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40587613ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiJaPyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiJaPyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:54:11 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F3412618
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1667231649; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldhMYmKhVztkuDkGNXgRHq1YujHNrkH++0gGBcpX2+0=;
        b=uBDfVR1f6aoHH4LxnT9DgTvio9mg6pBqyaI+m0X6ZhBoLpdC4vobVyznEQ+zyyye6v6K+M
        0ODgI29Setbp9P9IH5AmIrkaDafvbIdLWCDUphRNeFtQndtVeVq5zkL89aJQ5/hOtc32Fz
        2SBTrE8t/KIKppURnEUyhsHFnqZW0VI=
Date:   Mon, 31 Oct 2022 15:53:58 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 28/28] mfd: intel-lpss: Remove #ifdef guards for PM
 related functions
To:     Lee Jones <lee@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Message-Id: <Y5KMKR.O7V1VJVC871X@crapouillou.net>
In-Reply-To: <Y1/tMMEVA5inNyw/@google.com>
References: <20221023094852.8035-29-paul@crapouillou.net>
        <202210232035.D9ecuZtH-lkp@intel.com> <Y1/i2TTy1CzJhPLA@google.com>
        <Y1/jvTbEpONmQzW6@dev-arch.thelio-3990X>
        <J6IMKR.EVFG2BDFUG8Q1@crapouillou.net> <Y1/tMMEVA5inNyw/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun. 31 oct. 2022 =E0 15:43:44 +0000, Lee Jones <lee@kernel.org> a=20
=E9crit :
> On Mon, 31 Oct 2022, Paul Cercueil wrote:
>=20
>>  Hi,
>>=20
>>  Le lun. 31 oct. 2022 =E0 08:03:25 -0700, Nathan Chancellor=20
>> <nathan@kernel.org>
>>  a =E9crit :
>>  > On Mon, Oct 31, 2022 at 02:59:37PM +0000, Lee Jones wrote:
>>  > >  On Sun, 23 Oct 2022, kernel test robot wrote:
>>  > >
>>  > >  > Hi Paul,
>>  > >  >
>>  > >  > I love your patch! Yet something to improve:
>>  > >  >
>>  > >  > [auto build test ERROR on lee-mfd/for-mfd-next]
>>  > >  > [also build test ERROR on linus/master v6.1-rc1=20
>> next-20221021]
>>  > >  > [If your patch is applied to the wrong git tree, kindly drop=20
>> us a
>>  > > note.
>>  > >  > And when submitting patch, we suggest to use '--base' as
>>  > > documented in
>>  > >  >=20
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>  > >  >
>>  > >  > url:   =20
>> https://github.com/intel-lab-lkp/linux/commits/Paul-Cercueil/mfd-Remove-=
ifdef-guards-for-PM-functions/20221023-175612
>>  > >  > base:
>>  > > https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
>>  > > for-mfd-next
>>  > >  > patch link:
>>  > >=20
>> https://lore.kernel.org/r/20221023094852.8035-29-paul%40crapouillou.net
>>  > >  > patch subject: [PATCH v3 28/28] mfd: intel-lpss: Remove=20
>> #ifdef
>>  > > guards for PM related functions
>>  > >  > config: i386-randconfig-a013
>>  > >  > compiler: clang version 14.0.6
>>  > > (https://github.com/llvm/llvm-project
>>  > > f28c006a5895fc0e329fe15fead81e37457cb1d1)
>>  > >  > reproduce (this is a W=3D1 build):
>>  > >  >         wget
>>  > >=20
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>>  > > -O ~/bin/make.cross
>>  > >  >         chmod +x ~/bin/make.cross
>>  > >  >         #=20
>> https://github.com/intel-lab-lkp/linux/commit/873891d1ee1634da028bb74d0e=
7cfa5d77b2f157
>>  > >  >         git remote add linux-review
>>  > > https://github.com/intel-lab-lkp/linux
>>  > >  >         git fetch --no-tags linux-review
>>  > >=20
>> Paul-Cercueil/mfd-Remove-ifdef-guards-for-PM-functions/20221023-175612
>>  > >  >         git checkout 873891d1ee1634da028bb74d0e7cfa5d77b2f157
>>  > >  >         # save the config file
>>  > >  >         mkdir build_dir && cp config build_dir/.config
>>  > >  >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang
>>  > > make.cross W=3D1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash=20
>> drivers/mfd/
>>  > >  >
>>  > >  > If you fix the issue, kindly add following tag where=20
>> applicable
>>  > >  > | Reported-by: kernel test robot <lkp@intel.com>
>>  > >  >
>>  > >  > All errors (new ones prefixed by >>):
>>  > >  >
>>  > >  > >> drivers/mfd/intel-lpss-pci.c:75:8: error: type specifier
>>  > > missing, defaults to 'int' [-Werror,-Wimplicit-int]
>>  > >  >    static INTEL_LPSS_PM_OPS(intel_lpss_pci_pm_ops);
>>  > >  >    ~~~~~~ ^
>>  > >  > >> drivers/mfd/intel-lpss-pci.c:75:26: error: a parameter=20
>> list
>>  > > without types is only allowed in a function definition
>>  > >  >    static INTEL_LPSS_PM_OPS(intel_lpss_pci_pm_ops);
>>  > >  >                             ^
>>  > >  >    2 errors generated.
>>  > >
>>  > >  Is this a valid error?
>>  >
>>  > Yes, because this change removes the definition of=20
>> INTEL_LPSS_PM_OPS in
>>  > intel-lpss.h.
>>=20
>>  The "static INTEL_LPSS_PM_OPS(intel_lpss_pci_pm_ops)" is dead code;=20
>> just
>>  removing this line should be enough to make it work.
>>=20
>>  I'll V2 when I find some time.
>=20
> Thanks.
>=20
> I'll put this set on hold for v2.

If you think the other patches are OK you can merge them, and I'll just=20
send a V2 with this one patch.

Cheers,
-Paul


