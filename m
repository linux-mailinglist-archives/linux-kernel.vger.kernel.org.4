Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611E96A5736
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjB1KyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjB1Kxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:53:53 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF39F2FCC1;
        Tue, 28 Feb 2023 02:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677581551; x=1709117551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NFwLsfslShX+IFYT0uOjVxXfzC+4HOGVFcLPgpwbkeE=;
  b=H/lVnAHscnar92ZA1GZl4TtjU5wvYWC8LIHBYjvZJipCu3snSBpD+S4V
   YcKRVyAfsTYXrey2lLDI+jJuxNpxbC7bXrCQCdusJWfB5lijc+4BOX/Od
   7+j9oRSmLc7x3mnK5jPV1X/5z9v53Gf/hhpiOfww6C55mSYP1f8yy9RlC
   KXS/jMV0fgi5gnmHZaZtAmHubeNf9KCGttuxNYaIf6aSuIg85S898s67N
   OJvUKnaEx+mJfVwIdibZXjjxbbGh0L4lT0On2sOwqsc4tXHXtSz+v0Ok6
   GW1JImnnLAdL2KACoJ038b679uqgq27ARIzkqJsXMLHVKB8m9GXHX6K04
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="331586094"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="331586094"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 02:52:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="919736377"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="919736377"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 Feb 2023 02:52:29 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWxau-0005KR-1s;
        Tue, 28 Feb 2023 10:52:28 +0000
Date:   Tue, 28 Feb 2023 18:51:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "D. Starke" <daniel.starke@siemens.com>,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: Re: [PATCH 1/3] tty: n_gsm: add ioctl for DLC specific parameter
 configuration
Message-ID: <202302281856.S9Lz4gHB-lkp@intel.com>
References: <20230228062957.3150-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228062957.3150-1-daniel.starke@siemens.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Starke,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus]
[cannot apply to v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/D-Starke/tty-n_gsm-allow-window-size-configuration/20230228-143349
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20230228062957.3150-1-daniel.starke%40siemens.com
patch subject: [PATCH 1/3] tty: n_gsm: add ioctl for DLC specific parameter configuration
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230228/202302281856.S9Lz4gHB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/06d7556b46ca2395b18cb700f19ee5de37d8383b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review D-Starke/tty-n_gsm-allow-window-size-configuration/20230228-143349
        git checkout 06d7556b46ca2395b18cb700f19ee5de37d8383b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302281856.S9Lz4gHB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/tty/n_gsm.c: In function 'gsmld_ioctl':
>> drivers/tty/n_gsm.c:3720:26: warning: unused variable 'dlci' [-Wunused-variable]
    3720 |         struct gsm_dlci *dlci;
         |                          ^~~~


vim +/dlci +3720 drivers/tty/n_gsm.c

  3713	
  3714	static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
  3715			       unsigned long arg)
  3716	{
  3717		struct gsm_config c;
  3718		struct gsm_config_ext ce;
  3719		struct gsm_mux *gsm = tty->disc_data;
> 3720		struct gsm_dlci *dlci;
  3721		unsigned int base;
  3722	
  3723		switch (cmd) {
  3724		case GSMIOC_GETCONF:
  3725			gsm_copy_config_values(gsm, &c);
  3726			if (copy_to_user((void __user *)arg, &c, sizeof(c)))
  3727				return -EFAULT;
  3728			return 0;
  3729		case GSMIOC_SETCONF:
  3730			if (copy_from_user(&c, (void __user *)arg, sizeof(c)))
  3731				return -EFAULT;
  3732			return gsm_config(gsm, &c);
  3733		case GSMIOC_GETFIRST:
  3734			base = mux_num_to_base(gsm);
  3735			return put_user(base + 1, (__u32 __user *)arg);
  3736		case GSMIOC_GETCONF_EXT:
  3737			gsm_copy_config_ext_values(gsm, &ce);
  3738			if (copy_to_user((void __user *)arg, &ce, sizeof(ce)))
  3739				return -EFAULT;
  3740			return 0;
  3741		case GSMIOC_SETCONF_EXT:
  3742			if (copy_from_user(&ce, (void __user *)arg, sizeof(ce)))
  3743				return -EFAULT;
  3744			return gsm_config_ext(gsm, &ce);
  3745		default:
  3746			return n_tty_ioctl_helper(tty, cmd, arg);
  3747		}
  3748	}
  3749	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
