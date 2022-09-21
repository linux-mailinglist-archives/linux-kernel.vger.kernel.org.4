Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9D75BFA37
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiIUJHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiIUJHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:07:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B0F8E0C8;
        Wed, 21 Sep 2022 02:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663751238; x=1695287238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mdELA0CMy41Pc/8gwIulPOG1jrdcSRSWpH4OOmPRZm0=;
  b=QgMijv1a9X2M2cfTVovy7bAUt5hfgJNga1/azmhs2HdF3zFnYgTuvY7V
   7uKuoKd2FFkNswhwQFGF7nCzdwY9Axg1W5TA4gISjhOBhmWEUbvgyQ/LT
   7mPSDtFhWI7ex/l1SrQGNKwOYKYv2LS00CooioUEygNJ2m4HQZFLONS2y
   bo4rOzjw9gEk2KNNtsgW8cEhKgph90QhiXOxa14ACkda6Qo96osHbhDnl
   MrwiEnIeNA+H7NP8jgJfRXWGJpsFoORqKFGIfdiIF/WDt4L/SMQ3+83b5
   8TBPQSAAIcR4qJaaFTX05aZ5XXyyvXb9zZ6el1UAC3nKELm18pS52/E8s
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="386232910"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="386232910"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 02:07:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="619269056"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 21 Sep 2022 02:07:13 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oavhI-0003RV-2g;
        Wed, 21 Sep 2022 09:07:12 +0000
Date:   Wed, 21 Sep 2022 17:06:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jammy Huang <jammy_huang@aspeedtech.com>, eajames@linux.ibm.com,
        mchehab@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        linux-media@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        hverkuil-cisco@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        nicolas.dufresne@collabora.com, stanimir.varbanov@linaro.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        ribalda@chromium.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v9 3/4] media: aspeed: Support aspeed mode to reduce
 compressed data
Message-ID: <202209211617.SJ0Uagdf-lkp@intel.com>
References: <20220921025112.13150-4-jammy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921025112.13150-4-jammy_huang@aspeedtech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jammy,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on media-tree/master]
[also build test ERROR on next-20220920]
[cannot apply to linus/master v6.0-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jammy-Huang/add-aspeed-jpeg-support-for-aspeed-video/20220921-105350
base:   git://linuxtv.org/media_tree.git master
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220921/202209211617.SJ0Uagdf-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/99c2bf6f1dccc310cb9b2d9916292766f00ffb4f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jammy-Huang/add-aspeed-jpeg-support-for-aspeed-video/20220921-105350
        git checkout 99c2bf6f1dccc310cb9b2d9916292766f00ffb4f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> error: include/uapi/linux/aspeed-video.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier
   make[2]: *** [scripts/Makefile.headersinst:63: usr/include/linux/aspeed-video.h] Error 1
   make[2]: Target '__headers' not remade because of errors.
   make[1]: *** [Makefile:1293: headers] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:222: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
