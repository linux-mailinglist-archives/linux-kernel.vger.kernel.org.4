Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F61868A648
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjBCWn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjBCWn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:43:27 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7901725BB6;
        Fri,  3 Feb 2023 14:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675464206; x=1707000206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uBWBIwLYGQ7ThsqQoIqSuUOO/Yc5dY/pPpXOJxipOMI=;
  b=C/6/haqY11IcWbYyfll4pBZ+1ScdoN2xxHSLKORbbYWfDGTnMnYfenZV
   PSlUw0HZc3Up4/j5K8E9kEMb3QNt/aukC2bkuH8306f08Nj58DLKI/LPe
   MAXqaHUhBBozDCp5lTzEsIGpHaO0PRH4DK2Ap1G3usQ7UPHc8Ciux97fN
   iv8frRZQpFJhbyup3+Qeg6nej+3agKkpg42NAVYH9nqmcyU/7T0yDVJUO
   sJOok75xoMR/VuUSwvg01gZFlfD8qqQsV0a0Wix61fPNk34++YxaWP66K
   zTNpwuDus3LgoXDoUz0TF0y7sw2UfbxmD7wn1U6/B0GjDnJSNfTN/cPAh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="391269832"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="391269832"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 14:43:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="696279972"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="696279972"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 Feb 2023 14:43:20 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pO4m7-0000or-1B;
        Fri, 03 Feb 2023 22:43:19 +0000
Date:   Sat, 4 Feb 2023 06:42:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        martin.petersen@oracle.com, beanhuo@micron.com, arnd@arndb.de,
        avri.altman@wdc.com, iwona.winiarska@intel.com,
        fmdefrancesco@gmail.com, dipenp@nvidia.com, ogabbay@kernel.org,
        bvanassche@acm.org, mathieu.poirier@linaro.org,
        yangyicong@hisilicon.com, dan.j.williams@intel.com,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Subject: Re: [PATCHv2 2/4] wiegand: add Wiegand bus driver
Message-ID: <202302040653.thgxkOi8-lkp@intel.com>
References: <20230202143305.21789-3-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202143305.21789-3-m.zatovic1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.2-rc6 next-20230203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Za-ovi/dt-bindings-wiegand-add-Wiegand-controller-common-properties/20230202-223510
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230202143305.21789-3-m.zatovic1%40gmail.com
patch subject: [PATCHv2 2/4] wiegand: add Wiegand bus driver
config: ia64-randconfig-s042-20230204 (https://download.01.org/0day-ci/archive/20230204/202302040653.thgxkOi8-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/5dc4c223e5bb967973f6fbcbea5d45ee1f95db97
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Martin-Za-ovi/dt-bindings-wiegand-add-Wiegand-controller-common-properties/20230202-223510
        git checkout 5dc4c223e5bb967973f6fbcbea5d45ee1f95db97
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/wiegand/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/wiegand/wiegand.c: In function 'of_register_wiegand_device':
>> drivers/wiegand/wiegand.c:106:14: error: implicit declaration of function 'of_modalias_node'; did you mean 'of_match_node'? [-Werror=implicit-function-declaration]
     106 |         rc = of_modalias_node(nc, wiegand->modalias, sizeof(wiegand->modalias));
         |              ^~~~~~~~~~~~~~~~
         |              of_match_node
   cc1: some warnings being treated as errors


vim +106 drivers/wiegand/wiegand.c

    91	
    92	static struct wiegand_device *of_register_wiegand_device(
    93							struct wiegand_controller *ctlr,
    94							struct device_node *nc)
    95	{
    96		struct wiegand_device *wiegand;
    97		int rc;
    98	
    99		wiegand = wiegand_alloc_device(ctlr);
   100		if (!wiegand) {
   101			dev_err(&ctlr->dev, "wiegad_device alloc error for %pOF\n", nc);
   102			rc = -ENOMEM;
   103			goto err_out;
   104		}
   105	
 > 106		rc = of_modalias_node(nc, wiegand->modalias, sizeof(wiegand->modalias));
   107		if (rc < 0) {
   108			dev_err(&ctlr->dev, "cannot find modalias for %pOF\n", nc);
   109			goto err_out;
   110		}
   111	
   112		of_node_get(nc);
   113		wiegand->dev.of_node = nc;
   114		wiegand->dev.fwnode = of_fwnode_handle(nc);
   115	
   116		rc = wiegand_add_device(wiegand);
   117		if (rc) {
   118			dev_err(&ctlr->dev, "wiegand_device register error %pOF\n", nc);
   119			goto err_of_node_put;
   120		}
   121	
   122		/* check if more devices are connected to the bus */
   123		if (ctlr->device_count > 1)
   124			dev_warn(&ctlr->dev, "Wiegand is a point-to-point bus, it is advised to only connect one device per Wiegand bus. The devices may not communicate using the same pulse length, format or else.\n");
   125	
   126		return wiegand;
   127	
   128	err_of_node_put:
   129		of_node_put(nc);
   130	err_out:
   131		wiegand_dev_put(wiegand);
   132		return ERR_PTR(rc);
   133	}
   134	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
