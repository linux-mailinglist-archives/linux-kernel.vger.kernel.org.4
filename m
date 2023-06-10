Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66AE72AFA3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 01:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjFJXEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 19:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFJXEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 19:04:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E01535B8;
        Sat, 10 Jun 2023 16:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686438282; x=1717974282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uRt5yR5sb+AiORo00Ddd8AH4m3wS/RHVS4cBKEYsZCg=;
  b=agk/OYB0Ib6PN08S2KlW5wTV5B6d6SdP9z5bnRPny5fDgxC0HL4xKraA
   aGoOPIwWM0wTJy5Hs+lVk3k03w7FJScgAHAMMnn3LUshrzBlPfDE60i/8
   JPPY786SqpkNlfQo1kL0iMvIpCGpbbyvv5yLbotjGmDOKQLfypDNZEf8J
   oYi3FUu7FrTwXzLdbfkzbUARHqVN0d42/rG4zdn4Hn1Vda52LWrJwIsHH
   TIUOaUp6TJT1FLOZjhTvBQUrSBu2lMEPMpfNfjayW2Jp9E/PVHQG9d0sP
   EBl/7aqInnl7HymMFmFNGL2qgZpovvj4TB2NllhVB5BrIFpdvO+Ez/jOM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="338174691"
X-IronPort-AV: E=Sophos;i="6.00,233,1681196400"; 
   d="scan'208";a="338174691"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 16:04:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="775882403"
X-IronPort-AV: E=Sophos;i="6.00,233,1681196400"; 
   d="scan'208";a="775882403"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jun 2023 16:04:40 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q87dP-000ATw-1O;
        Sat, 10 Jun 2023 23:04:39 +0000
Date:   Sun, 11 Jun 2023 07:04:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>,
        linux@roeck-us.net
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>,
        derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (oxp-sensors) Add tt_toggle attribute on
 supported boards
Message-ID: <202306110659.msus3mCo-lkp@intel.com>
References: <20230610192400.80611-2-samsagax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230610192400.80611-2-samsagax@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joaquín,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on next-20230609]
[cannot apply to linus/master v6.4-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joaqu-n-Ignacio-Aramend-a/hwmon-oxp-sensors-Add-tt_toggle-attribute-on-supported-boards/20230611-032531
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230610192400.80611-2-samsagax%40gmail.com
patch subject: [PATCH v2] hwmon: (oxp-sensors) Add tt_toggle attribute on supported boards
config: x86_64-randconfig-a013-20230611 (https://download.01.org/0day-ci/archive/20230611/202306110659.msus3mCo-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add groeck-staging https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
        git fetch groeck-staging hwmon-next
        git checkout groeck-staging/hwmon-next
        b4 shazam https://lore.kernel.org/r/20230610192400.80611-2-samsagax@gmail.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306110659.msus3mCo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hwmon/oxp-sensors.c:445:10: error: label at end of compound statement: expected statement
           default:
                   ^
                    ;
   1 error generated.


vim +445 drivers/hwmon/oxp-sensors.c

   416	
   417	/* Initialization logic */
   418	static int oxp_platform_probe(struct platform_device *pdev)
   419	{
   420		const struct dmi_system_id *dmi_entry;
   421		struct device *dev = &pdev->dev;
   422		struct device *hwdev;
   423		int ret;
   424	
   425		/*
   426		 * Have to check for AMD processor here because DMI strings are the
   427		 * same between Intel and AMD boards, the only way to tell them apart
   428		 * is the CPU.
   429		 * Intel boards seem to have different EC registers and values to
   430		 * read/write.
   431		 */
   432		dmi_entry = dmi_first_match(dmi_table);
   433		if (!dmi_entry || boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
   434			return -ENODEV;
   435	
   436		board = (enum oxp_board)(unsigned long)dmi_entry->driver_data;
   437	
   438		switch (board) {
   439		case aok_zoe_a1:
   440		case oxp_mini_amd_a07:
   441		case oxp_mini_amd_pro:
   442			ret = devm_device_add_groups(dev, oxp_ec_groups);
   443			if (ret)
   444				return ret;
 > 445		default:
   446		}
   447	
   448		hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
   449							     &oxp_ec_chip_info, NULL);
   450	
   451		return PTR_ERR_OR_ZERO(hwdev);
   452	}
   453	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
