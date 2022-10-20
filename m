Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EDF6056C1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJTF0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJTF0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:26:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDE91911D8;
        Wed, 19 Oct 2022 22:26:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC76CB82671;
        Thu, 20 Oct 2022 05:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D077FC433C1;
        Thu, 20 Oct 2022 05:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666243607;
        bh=vAZmXggjSCZpIcGU5wkrL2Ub6Nof/q/Qn9/o5p8l1ZA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=acXmbVM7o1Fp6FBk33RSXnCufre5ha3eZfjfq9gJOhnuGQF6qB9oWHBgvT1HZZZcq
         byGruFKcw4Sx7fe2rhjxmuBhB0Ejy7L4aB2d0LtarcwWWIhiPA6dBcv7lB31Mq6G/u
         tozJjODOQ0RK1pdsnTn/EtV1DLJMd4/iovNgv4eDR4MQJ2JJlo7B61/lyno7xoWdgL
         upC5qjiUJ4PQCOpI/GWCgpY9mqk3o1jAUfeKcAUY4TmoRrI0ox1OpHzsiLBxqmpmuw
         PPzoiJG+IAvPVLVNqnzSxEQp+hzjolIJPM9ASHK4I9WvJM/yrwOXTsySLA9f7J4IMY
         VnGZLLULxjrlA==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     kernel test robot <lkp@intel.com>,
        Tomislav =?utf-8?Q?Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
        linux-wireless@vger.kernel.org
Subject: Re: drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9439:15: warning: result of comparison of constant -7 with expression of type 'char' is always false
References: <202210191553.vO9rtKe5-lkp@intel.com> <87pmeol020.fsf@kernel.org>
        <CAHmME9qFKMLJiZa=pg9bnBWHSfbgP-+yimteL_t4sxuepQ6bAg@mail.gmail.com>
        <CAHmME9ocXJMTmCQfi1NY+zOw-r5VCe_Z48q5VJCZxR4Hj=1oZA@mail.gmail.com>
        <CAHmME9oeHMPjg5aCdv4d5pY_ue9ufgaS4FQkYRRWAX_E0zFtfw@mail.gmail.com>
Date:   Thu, 20 Oct 2022 08:26:40 +0300
In-Reply-To: <CAHmME9oeHMPjg5aCdv4d5pY_ue9ufgaS4FQkYRRWAX_E0zFtfw@mail.gmail.com>
        (Jason A. Donenfeld's message of "Wed, 19 Oct 2022 02:15:33 -0600")
Message-ID: <87lepb2hgv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

> On Wed, Oct 19, 2022 at 2:02 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>>
>> On Wed, Oct 19, 2022 at 1:59 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> >
>> > On Wed, Oct 19, 2022 at 1:55 AM Kalle Valo <kvalo@kernel.org> wrote:
>> > >
>> > > + jason, linux-wireless
>> > >
>> > > kernel test robot <lkp@intel.com> writes:
>> > >
>> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> > > > head:   aae703b02f92bde9264366c545e87cec451de471
>> > > > commit: dab902fe1d29dc0fa1dccc8d13dc89ffbf633881 wifi: rt2x00: add TX
>> > > > LOFT calibration for MT7620
>> > > > date:   4 weeks ago
>> > > > config: arm64-allmodconfig
>> > > > compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project
>> > > > 791a7ae1ba3efd6bca96338e10ffde557ba83920)
>> > > > reproduce (this is a W=1 build):
>> > > >         wget
>> > > > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>> > > > -O ~/bin/make.cross
>> > > >         chmod +x ~/bin/make.cross
>> > > >         # install arm64 cross compiling tool for clang build
>> > > >         # apt-get install binutils-aarch64-linux-gnu
>> > > >         #
>> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dab902fe1d29dc0fa1dccc8d13dc89ffbf633881
>> > > >         git remote add linus
>> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> > > >         git fetch --no-tags linus master
>> > > >         git checkout dab902fe1d29dc0fa1dccc8d13dc89ffbf633881
>> > > >         # save the config file
>> > > >         mkdir build_dir && cp config build_dir/.config
>> > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1
>> > > > O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/
>> > > > drivers/net/wireless/ralink/rt2x00/ drivers/staging/media/
>> > > >
>> > > > If you fix the issue, kindly add following tag where applicable
>> > > > | Reported-by: kernel test robot <lkp@intel.com>
>> > > >
>> > > > All warnings (new ones prefixed by >>):
>> > > >
>> > > >>> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9439:15: warning:
>> > > >> result of comparison of constant -7 with expression of type 'char'
>> > > >> is always false [-Wtautological-constant-out-of-range-compare]
>> > > >            gerr = (gerr < -0x07) ? -0x07 : (gerr > 0x05) ? 0x05 : gerr;
>> > > >                    ~~~~ ^ ~~~~~
>> > > >    drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9443:15: warning: result of comparison of constant -31 with expression of type 'char' is always false [-Wtautological-constant-out-of-range-compare]
>> > > >            perr = (perr < -0x1f) ? -0x1f : (perr > 0x1d) ? 0x1d : perr;
>> > > >                    ~~~~ ^ ~~~~~
>> > > >    2 warnings generated.
>> > >
>> > > I believe this patch should fix it:
>> > >
>> > > https://patchwork.kernel.org/project/linux-wireless/patch/20221018202734.140489-1-Jason@zx2c4.com/
>> > >
>> > > Jason, is my understanding correct?
>> >
>> > That's a different bug caused by the same pitfall: assuming char is
>> > signed. I'll send a patch for that function too.
>>
>>
>> Actually, maybe I should fix the whole file? Patch incoming.
>
> Okay here's a v2 that handles it driver-wide:
> https://lore.kernel.org/linux-wireless/20221019081417.3402284-1-Jason@zx2c4.com/
> (Might take a few minutes to hit lore.)

Great, thanks Jason.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
