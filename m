Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F287B61229B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 13:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJ2Lwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 07:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiJ2Lw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 07:52:29 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035936D565;
        Sat, 29 Oct 2022 04:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1667044342; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u2k3MpzKY6CN5hfzTzAYDzW0+oUGTIkTmQN3JyuhJx4=;
        b=wqg9CNFaxCs0PQaegb5ISTlV5Rr/z2Nj1rkRxftnfk++Nw3Pshnefzq3SFxFuLABbEUywp
        YQTAvBUxYyl0am9wYYV/CRvkUTbM/8wWhAyTFQtMBGoBu812XamdKlzMaiQYgq4B50+3K7
        MOkrJch0tDem5xC8KoSy0EqzP3ohofM=
Date:   Sat, 29 Oct 2022 12:52:11 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 4/4] rtc: jz4740: Support for fine-tuning the RTC clock
To:     kernel test robot <lkp@intel.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        oe-kbuild-all@lists.linux.dev, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, od@opendingux.net
Message-Id: <ZMJIKR.M45DG9N62IHH1@crapouillou.net>
In-Reply-To: <202210291633.edaeueJF-lkp@intel.com>
References: <20221028225519.89210-5-paul@crapouillou.net>
        <202210291633.edaeueJF-lkp@intel.com>
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

Hi Bot,

Well this report is on my RFC patch so I consider the patchset to still=20
be valid.

If I can actually test my RFC patch I'll send it again with this bug=20
fixed.

Cheers,
-Paul


Le sam. 29 oct. 2022 =E0 16:51:53 +0800, kernel test robot=20
<lkp@intel.com> a =E9crit :
> Hi Paul,
>=20
> I love your patch! Yet something to improve:
>=20
> [auto build test ERROR on abelloni/rtc-next]
> [also build test ERROR on robh/for-next linus/master v6.1-rc2=20
> next-20221028]
> [If your patch is applied to the wrong git tree, kindly drop us a=20
> note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:   =20
> https://github.com/intel-lab-lkp/linux/commits/Paul-Cercueil/rtc-ingenic-=
various-updates/20221029-065805
> base:  =20
> https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git=20
> rtc-next
> patch link:   =20
> https://lore.kernel.org/r/20221028225519.89210-5-paul%40crapouillou.net
> patch subject: [PATCH v2 4/4] rtc: jz4740: Support for fine-tuning=20
> the RTC clock
> config: sparc64-randconfig-c043-20221028
> compiler: sparc64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>         wget=20
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross=20
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         #=20
> https://github.com/intel-lab-lkp/linux/commit/b73614c39710acaff7977b8d3ec=
935105cf59757
>         git remote add linux-review=20
> https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review=20
> Paul-Cercueil/rtc-ingenic-various-updates/20221029-065805
>         git checkout b73614c39710acaff7977b8d3ec935105cf59757
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0=20
> make.cross W=3D1 O=3Dbuild_dir ARCH=3Dsparc64 SHELL=3D/bin/bash drivers/r=
tc/
>=20
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    In file included from <command-line>:
>    drivers/rtc/rtc-jz4740.c: In function 'jz4740_rtc_set_offset':
>>>  include/linux/compiler_types.h:357:45: error: call to=20
>>> '__compiletime_assert_248' declared with attribute error:=20
>>> FIELD_PREP: value too large for the field
>      357 |         _compiletime_assert(condition, msg,=20
> __compiletime_assert_, __COUNTER__)
>          |                                             ^
>    include/linux/compiler_types.h:338:25: note: in definition of=20
> macro '__compiletime_assert'
>      338 |                         prefix ## suffix();               =20
>              \
>          |                         ^~~~~~
>    include/linux/compiler_types.h:357:9: note: in expansion of macro=20
> '_compiletime_assert'
>      357 |         _compiletime_assert(condition, msg,=20
> __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro=20
> 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg)=20
> compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/bitfield.h:68:17: note: in expansion of macro=20
> 'BUILD_BUG_ON_MSG'
>       68 |                =20
> BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
>          |                 ^~~~~~~~~~~~~~~~
>    include/linux/bitfield.h:114:17: note: in expansion of macro=20
> '__BF_FIELD_CHECK'
>      114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val,=20
> "FIELD_PREP: ");    \
>          |                 ^~~~~~~~~~~~~~~~
>    drivers/rtc/rtc-jz4740.c:256:17: note: in expansion of macro=20
> 'FIELD_PREP'
>      256 |         nc1hz =3D FIELD_PREP(JZ_RTC_REGULATOR_NC1HZ_MASK,=20
> nc1hz);
>          |                 ^~~~~~~~~~
>=20
>=20
> vim +/__compiletime_assert_248 +357 include/linux/compiler_types.h
>=20
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  343
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  344  #define=20
> _compiletime_assert(condition, msg, prefix, suffix) \
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  345 =20
> 	__compiletime_assert(condition, msg, prefix, suffix)
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  346
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  347  /**
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  348   * compiletime_assert -=20
> break build and emit msg if condition is false
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  349   * @condition: a=20
> compile-time constant condition to check
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  350   * @msg:       a message=20
> to emit if condition is false
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  351   *
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  352   * In tradition of POSIX=20
> assert, this macro will break the build if the
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  353   * supplied condition is=20
> *false*, emitting the supplied error message if the
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  354   * compiler has support=20
> to do so.
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  355   */
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  356  #define=20
> compiletime_assert(condition, msg) \
> eb5c2d4b45e3d2 Will Deacon 2020-07-21 @357 =20
> 	_compiletime_assert(condition, msg, __compiletime_assert_,=20
> __COUNTER__)
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  358
>=20
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp


