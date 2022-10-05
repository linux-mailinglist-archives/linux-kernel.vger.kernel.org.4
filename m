Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5AE5F5840
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJEQ0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJEQ0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:26:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D8575FDB;
        Wed,  5 Oct 2022 09:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664987160; x=1696523160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G0QJA+L7g7MsXFOFjec34vb6SoO7o1ppQXbhc16bfV0=;
  b=graDsFIkzagy7/d6qsxSnr/P0nmSF95aL4WyxEck2z1PTCC55GIILJgi
   xLCmUiVaeDJ+9NzS/lLJTyqKoUDAfQa276p3yA/Pg54hbvOZg/CtlexKR
   FJbklup2CPkpgrld/YfZOWNYS/W8wRQ0ccJLNuShz5FwJ+8cpO8M8epav
   QiseNIb/Xx8nj0FE16YimMmyxZxkGWDPh4ykiEWIMV5fexbXBDeaJkPmM
   7BzYe+0zrcnuBWJ191tqIxtLCYwHzrDE+JSob8X49QPRlBbUyFOLKFvpa
   9KgVo7t2LOCMiGjKQqpcvTP6XRNpcg0vWDNdsQOvgFau+XjROM6IHxcYv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="282917193"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="282917193"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 09:25:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="728715252"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="728715252"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 05 Oct 2022 09:25:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1og7DW-002jhc-2z;
        Wed, 05 Oct 2022 19:25:54 +0300
Date:   Wed, 5 Oct 2022 19:25:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, kbuild-all@lists.01.org,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 1/2] device property: Introduce
 fwnode_device_is_compatible() helper
Message-ID: <Yz2wEiOdAs3Xyz3H@smile.fi.intel.com>
References: <20221005143812.33503-1-andriy.shevchenko@linux.intel.com>
 <202210052318.prrotB47-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210052318.prrotB47-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 12:05:43AM +0800, kernel test robot wrote:
> Hi Andy,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on soc/for-next]
> [also build test ERROR on linus/master v6.0 next-20221005]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/device-property-Introduce-fwnode_device_is_compatible-helper/20221005-223919
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
> config: powerpc-allnoconfig
> compiler: powerpc-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/b930d58084d15cbf92f0cd490ad05e843991bd8e
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Andy-Shevchenko/device-property-Introduce-fwnode_device_is_compatible-helper/20221005-223919
>         git checkout b930d58084d15cbf92f0cd490ad05e843991bd8e
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>

Thanks, v2, which already had been sent, should fix all these.

-- 
With Best Regards,
Andy Shevchenko


