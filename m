Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A540603417
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJRUlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiJRUlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:41:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74836B678
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666125626; x=1697661626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C0sUKBXgguGTTWpN7pUCACEAcwe/KLBvTJOQpneDMgA=;
  b=AwN+wNtnoRPWtkD8AN/afQdVygL5Ww/kZ/8iaQfVucgNW6KY/8KzogwC
   G+Du2SeGv8aslHnx/aE9Lt1TaKtaiH8oDOOTvVSKS5xe4MGVQyr9ufr4P
   W1l1RQx7Cva1Gj+e56XTf1ZXmmhuXcftlGAGdFvXR1Ea8cQ+GPv0Sf54K
   RHm4bYLxXfNrge2OLhu6deaml4eAd4ZwvPKKPLK/nChUPN657LfWhPGab
   KkDPo5jAdHUB0XhYxr4fa0Pm4pIemrLAce8t/dV2VA0QUm753FRDS5KGU
   6fduSyKVzqJ4a1t/kMsGDG09VK2NmQoaehDa57loQ+GjNIdjBVMMEpioN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="289550641"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="289550641"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 13:40:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="733839978"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="733839978"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 18 Oct 2022 13:40:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oktNl-009Y0b-2X;
        Tue, 18 Oct 2022 23:40:13 +0300
Date:   Tue, 18 Oct 2022 23:40:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     "Jason A. Donenfeld" <zx2c4@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [akpm-mm:mm-nonmm-unstable 36/41]
 include/linux/build_bug.h:16:51: error: negative width in bit-field
 '<anonymous>'
Message-ID: <Y08PLW4gmTV0GeUf@smile.fi.intel.com>
References: <202210190108.ESC3pc3D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210190108.ESC3pc3D-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 01:27:05AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
> head:   c05e49b87cb71437bbc18a6c16dd8113623d7778
> commit: 20b6f49e6024be96a0a729839f7a127600d08740 [36/41] minmax: sanity check constant bounds when clamping
> config: arm-defconfig
> compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=20b6f49e6024be96a0a729839f7a127600d08740
>         git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
>         git fetch --no-tags akpm-mm mm-nonmm-unstable
>         git checkout 20b6f49e6024be96a0a729839f7a127600d08740
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/net/wireless/ralink/rt2x00/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/container_of.h:5,
>                     from include/linux/kernel.h:21,
>                     from drivers/net/wireless/ralink/rt2x00/rt2800lib.c:25:
>    drivers/net/wireless/ralink/rt2x00/rt2800lib.c: In function 'rt2800_txpower_to_dev':
> >> include/linux/build_bug.h:16:51: error: negative width in bit-field '<anonymous>'
>       16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>          |                                                   ^
>    include/linux/minmax.h:50:10: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
>       50 |         (BUILD_BUG_ON_ZERO(__builtin_choose_expr(                               \
>          |          ^~~~~~~~~~~~~~~~~
>    include/linux/minmax.h:54:9: note: in expansion of macro '__clamp_input_check'
>       54 |         __clamp_input_check(lo, hi) +                                           \
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/minmax.h:146:36: note: in expansion of macro '__careful_clamp'
>      146 | #define clamp_t(type, val, lo, hi) __careful_clamp((type)(val), (type)(lo), (type)(hi))
>          |                                    ^~~~~~~~~~~~~~~
>    drivers/net/wireless/ralink/rt2x00/rt2800lib.c:4054:24: note: in expansion of macro 'clamp_t'
>     4054 |                 return clamp_t(char, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
>          |                        ^~~~~~~

Because char is heck broken in C standard, it may be signed or unsigned
depending on the compiler (IIRC), so perhaps fixing it to signed char will fix
it?

From 6b711ba6b1086795d2407db447ed817aaa791063 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 18 Oct 2022 23:35:06 +0300
Subject: [PATCH 1/1] rt2x00: Avoid using 'char' for signed operations

The default Tx power is defined as 'short' in the data structure.
There is nothing prevents us to use 'short' in the
rt2800_txpower_to_dev(). With 'char' it's implementation defined
signedess and sometimes it may be tricky.

  drivers/net/wireless/ralink/rt2x00/rt2800lib.c: In function 'rt2800_txpower_to_dev':
  include/linux/build_bug.h:16:51: error: negative width in bit-field '<anonymous>'
  ...
  drivers/net/wireless/ralink/rt2x00/rt2800lib.c:4054:24: note: in expansion of macro 'clamp_t'
  4054 |  return clamp_t(char, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index cbbb1a4849cf..d7dffea6df82 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -4035,23 +4035,22 @@ static void rt2800_iq_calibrate(struct rt2x00_dev *rt2x00dev, int channel)
 	rt2800_bbp_write(rt2x00dev, 159, cal != 0xff ? cal : 0);
 }
 
-static char rt2800_txpower_to_dev(struct rt2x00_dev *rt2x00dev,
-				  unsigned int channel,
-				  char txpower)
+static short rt2800_txpower_to_dev(struct rt2x00_dev *rt2x00dev,
+				   unsigned int channel, short txpower)
 {
 	if (rt2x00_rt(rt2x00dev, RT3593) ||
 	    rt2x00_rt(rt2x00dev, RT3883))
 		txpower = rt2x00_get_field8(txpower, EEPROM_TXPOWER_ALC);
 
 	if (channel <= 14)
-		return clamp_t(char, txpower, MIN_G_TXPOWER, MAX_G_TXPOWER);
+		return clamp_t(short, txpower, MIN_G_TXPOWER, MAX_G_TXPOWER);
 
 	if (rt2x00_rt(rt2x00dev, RT3593) ||
 	    rt2x00_rt(rt2x00dev, RT3883))
-		return clamp_t(char, txpower, MIN_A_TXPOWER_3593,
+		return clamp_t(short, txpower, MIN_A_TXPOWER_3593,
 			       MAX_A_TXPOWER_3593);
 	else
-		return clamp_t(char, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
+		return clamp_t(short, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
 }
 
 static void rt3883_bbp_adjust(struct rt2x00_dev *rt2x00dev,
-- 
2.35.1


-- 
With Best Regards,
Andy Shevchenko


