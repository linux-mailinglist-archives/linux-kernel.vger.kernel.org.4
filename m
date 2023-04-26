Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AC46EF108
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbjDZJYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239853AbjDZJYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:24:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C7A4EF2;
        Wed, 26 Apr 2023 02:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682501031; x=1714037031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wCxv9UpBjUg+nIFCxpugJDt198ixgLIiNE9cs8ZnPjI=;
  b=gbo8BJzUOiGtcxcpZfxUCn8122q8i5IrCEm9sANMHeAVHldTiG8f74QB
   cuhGLFI/aIWlvrjGn1J7eRUyLDRgKf9OBu1SpGUzfn2soUc1ZuFvijpua
   35sV/ZC7CricK9MDnHa7dskzwI1/rWjqsPL+drc1i4os4kitidNrmMHcM
   EA+kL5ra3GltC0ahCKNn/tWvdPKRcM/Ym/YzyTNe9sXCOnqu53ICfj7mF
   2MVbRPzoON09iogyDYObFCvahH8jyW/IL9XdIz67guvgIqV79+SMO7aa7
   0dQGuSDSBW3WaUO9hqrj5VWHX8WY/qLG/Nw5hDOsyLXvHJwedpX+abvSs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="433337103"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="433337103"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 02:22:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="818044970"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="818044970"
Received: from lkp-server01.sh.intel.com (HELO 98ee5a99fc83) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Apr 2023 02:22:48 -0700
Received: from kbuild by 98ee5a99fc83 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prbMI-0000Ki-1T;
        Wed, 26 Apr 2023 09:22:42 +0000
Date:   Wed, 26 Apr 2023 17:21:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yunhui Cui <cuiyunhui@bytedance.com>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, cujomalainey@chromium.org,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] firmware: added a firmware information passing method FFI
Message-ID: <202304261756.84GsEW3V-lkp@intel.com>
References: <20230426034001.16-1-cuiyunhui@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426034001.16-1-cuiyunhui@bytedance.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunhui,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master jdelvare-staging/dmi-for-next v6.3 next-20230425]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yunhui-Cui/firmware-added-a-firmware-information-passing-method-FFI/20230426-114131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230426034001.16-1-cuiyunhui%40bytedance.com
patch subject: [PATCH] firmware: added a firmware information passing method FFI
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230426/202304261756.84GsEW3V-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7d1fe633611738698520294d2a598575a765cfbf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yunhui-Cui/firmware-added-a-firmware-information-passing-method-FFI/20230426-114131
        git checkout 7d1fe633611738698520294d2a598575a765cfbf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304261756.84GsEW3V-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/ffi.c:18:13: warning: no previous prototype for 'of_fdt_fwtbl' [-Wmissing-prototypes]
      18 | void __init of_fdt_fwtbl(void)
         |             ^~~~~~~~~~~~
>> drivers/firmware/ffi.c:53:13: warning: no previous prototype for 'fdt_fwtbl_init' [-Wmissing-prototypes]
      53 | void __init fdt_fwtbl_init(void)
         |             ^~~~~~~~~~~~~~


vim +/of_fdt_fwtbl +18 drivers/firmware/ffi.c

    17	
  > 18	void __init of_fdt_fwtbl(void)
    19	{
    20		int cfgtbl, len;
    21		fdt64_t *prop;
    22	
    23		cfgtbl = fdt_path_offset(initial_boot_params, "/cfgtables");
    24		if (cfgtbl < 0) {
    25			pr_info("cfgtables not found.\n");
    26			return;
    27		}
    28		prop = fdt_getprop_w(initial_boot_params, cfgtbl, "smbios_phy_ptr", &len);
    29		if (!prop || len != sizeof(u64))
    30			pr_info("smbios_phy_ptr not found.\n");
    31		else
    32			fdt_fwtbl.smbios = fdt64_to_cpu(*prop);
    33	
    34		prop = fdt_getprop_w(initial_boot_params, cfgtbl, "smbios3_phy_ptr", &len);
    35		if (!prop || len != sizeof(u64))
    36			pr_info("smbios3_phy_ptr not found.\n");
    37		else
    38			fdt_fwtbl.smbios3 = fdt64_to_cpu(*prop);
    39	
    40		prop = fdt_getprop_w(initial_boot_params, cfgtbl, "acpi_phy_ptr", &len);
    41		if (!prop || len != sizeof(u64))
    42			pr_info("acpi_phy_ptr not found.\n");
    43		else
    44			fdt_fwtbl.acpi = fdt64_to_cpu(*prop);
    45	
    46		prop = fdt_getprop_w(initial_boot_params, cfgtbl, "acpi20_phy_ptr", &len);
    47		if (!prop || len != sizeof(u64))
    48			pr_info("acpi20_phy_ptr not found.\n");
    49		else
    50			fdt_fwtbl.acpi20 = fdt64_to_cpu(*prop);
    51	}
    52	
  > 53	void __init fdt_fwtbl_init(void)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
