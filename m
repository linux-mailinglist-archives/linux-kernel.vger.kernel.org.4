Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D466FB24A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbjEHOLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbjEHOLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:11:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307191993E
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683555050; x=1715091050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b8j3eFyAlZ8EKElWhfj8TA1uCtcQR5fj4nfzKx3WRQU=;
  b=IAhVmsFAaftlaBKSucWLTvCDYeyrzMXIHAlA50pEOaHSulQubPjRoV/B
   vr/UauIF3ACmwmm51dN5zC0YxYwlJjdxF+TBODEkPXgKBJJ59B25BffPn
   Wdr10uT41TqM2ECwp8lYeHe/lbdKCklqrWr0kPE3c4uwrQNfMkrHswU5B
   U6axjc33vc/g0r/CYDPoB8UQCEyMWYI63v/Yn1ch2k/sDJ5zVxn5G/2oL
   kJbN8JLCp4u7Kn8pYkDZQ1/yKEsj89BTsfSNcrk97sjkru7NXtvk8F/RN
   91LNxKXl6QU7a2VrXLW/NOQWa5T41bmw196nILTWXe4qzQi/MGvE0Wo0d
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="435976120"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="435976120"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 07:07:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="676073948"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="676073948"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 May 2023 07:07:34 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pw1WX-0001G1-1f;
        Mon, 08 May 2023 14:07:33 +0000
Date:   Mon, 8 May 2023 22:06:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     oe-kbuild-all@lists.linux.dev, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] soc: imx: support i.MX93 soc device
Message-ID: <202305082103.ihPSWO6i-lkp@intel.com>
References: <20230508120514.1534445-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508120514.1534445-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

kernel test robot noticed the following build errors:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on linus/master v6.4-rc1 next-20230508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/soc-imx-support-i-MX93-soc-device/20230508-200452
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20230508120514.1534445-1-peng.fan%40oss.nxp.com
patch subject: [PATCH] soc: imx: support i.MX93 soc device
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230508/202305082103.ihPSWO6i-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d4fb96ce70f039deaf626914f91ca5ce8b74790a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peng-Fan-OSS/soc-imx-support-i-MX93-soc-device/20230508-200452
        git checkout d4fb96ce70f039deaf626914f91ca5ce8b74790a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/soc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305082103.ihPSWO6i-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/soc/imx/soc-imx8m.c:199:23: error: 'SZ_8' undeclared here (not in a function)
     199 |         .uid_length = SZ_8,
         |                       ^~~~
>> drivers/soc/imx/soc-imx8m.c:223:23: error: 'SZ_16' undeclared here (not in a function)
     223 |         .uid_length = SZ_16,
         |                       ^~~~~


vim +/SZ_8 +199 drivers/soc/imx/soc-imx8m.c

   195	
   196	static const struct imx8_soc_data imx8mq_soc_data = {
   197		.name = "i.MX8MQ",
   198		.soc_revision = imx8mq_soc_revision,
 > 199		.uid_length = SZ_8,
   200	};
   201	
   202	static const struct imx8_soc_data imx8mm_soc_data = {
   203		.name = "i.MX8MM",
   204		.soc_revision = imx8mm_soc_revision,
   205		.uid_length = SZ_8,
   206	};
   207	
   208	static const struct imx8_soc_data imx8mn_soc_data = {
   209		.name = "i.MX8MN",
   210		.soc_revision = imx8mm_soc_revision,
   211		.uid_length = SZ_8,
   212	};
   213	
   214	static const struct imx8_soc_data imx8mp_soc_data = {
   215		.name = "i.MX8MP",
   216		.soc_revision = imx8mm_soc_revision,
   217		.uid_length = SZ_8,
   218	};
   219	
   220	static const struct imx8_soc_data imx93_soc_data = {
   221		.name = "i.MX93",
   222		.soc_revision = imx93_soc_revision,
 > 223		.uid_length = SZ_16,
   224	};
   225	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
