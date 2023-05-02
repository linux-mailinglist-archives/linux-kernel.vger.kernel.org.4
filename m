Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471616F3DA0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjEBGjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjEBGjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:39:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F5D4497;
        Mon,  1 May 2023 23:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683009557; x=1714545557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JHmOyhknu72fwCyTp0J5ERbzi4vLQDGwzRbCdXl/ONg=;
  b=mqIIYCG2Rrcsw9qATlBfmxhAnFhugEsqSbr40FeMP0NXUTwe9NqKaKOv
   M24cZ/56ynw3QiVdLrOMn7n3CMM2e0VkzdKiaS8l8xJa4n4E/Sq7pvvbd
   IZYCT1sBcnoWn2BL+dCW6q9hvmeEsNklBhU3USYE5n+knGJjVgdDQY+j9
   lVQERCt6tjlK1Es0JBiFHj1IIg7z3TAGqaPneDWxXmZqEYBy8poa+oy+I
   dVH7Yj0qS33ce+UNZb2su4rxwlwOWm/w8vm/HTeFUAdb9IarWg1pbPd8j
   AXhUHoK9LyAfTHxtNRdiMS3Fez/NXj41gh+akCLCnUItprqDD8rMQpD/g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="345798439"
X-IronPort-AV: E=Sophos;i="5.99,243,1677571200"; 
   d="scan'208";a="345798439"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 23:39:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="942330850"
X-IronPort-AV: E=Sophos;i="5.99,243,1677571200"; 
   d="scan'208";a="942330850"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 May 2023 23:39:14 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ptjfO-0000tI-0f;
        Tue, 02 May 2023 06:39:14 +0000
Date:   Tue, 2 May 2023 14:38:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [PATCH 2/2 v3] Watchdog: Add marvell octeontx2 watchdog driver
Message-ID: <202305021447.bgPFpj8n-lkp@intel.com>
References: <20230425081926.9234-2-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425081926.9234-2-bbhushan2@marvell.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bharat,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on groeck-staging/hwmon-next linus/master v6.3 next-20230428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bharat-Bhushan/Watchdog-Add-marvell-octeontx2-watchdog-driver/20230425-162039
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230425081926.9234-2-bbhushan2%40marvell.com
patch subject: [PATCH 2/2 v3] Watchdog: Add marvell octeontx2 watchdog driver
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20230502/202305021447.bgPFpj8n-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/5b2d826a13c7553b51784a1fb56606bfda9f81d9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bharat-Bhushan/Watchdog-Add-marvell-octeontx2-watchdog-driver/20230425-162039
        git checkout 5b2d826a13c7553b51784a1fb56606bfda9f81d9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um olddefconfig
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305021447.bgPFpj8n-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/watchdog/octeontx2_wdt.c:13:10: fatal error: asm/arch_timer.h: No such file or directory
      13 | #include <asm/arch_timer.h>
         |          ^~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +13 drivers/watchdog/octeontx2_wdt.c

    12	
  > 13	#include <asm/arch_timer.h>
    14	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
