Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93AB6C8A8C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 04:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjCYDBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 23:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCYDBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 23:01:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CA014200
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 20:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679713307; x=1711249307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iQJGa7yfXG9hUk26kSizEa/MoGGxWJ3Cee01d8SSU+8=;
  b=WzYCWfiFoYZY6gxeVmSNt74cQHTHSnXo3cNv0JoJQsrBIy5y3MXYCdJB
   4CyGNLJLxzsPk+5k6CsIWRPVcv3iNy/sWJmNbu2VNsv0u09Q+niOhm4Oq
   O6IiJxEwJRz/eQwrFiHrVTnThcjryPCw0E0nZS/G1jcl2zrRTKW+ufpem
   bUOJ/eSfkZoDEHo65AjrQzRaanj1vqBSOXDIzQQW6gaJm+ocFh8Ng9AFK
   C7s+376AZlOlNUqBsFIRZUdK+JsiEhyBl037nibssNbnXrrH6mB6Ujkdb
   p/+QYO/P205dcR7uppqr2jlOrltkys95DxXRCh+y+aWXPdA4WbPz0UMPD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="319580304"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="319580304"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 20:01:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="826460917"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="826460917"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Mar 2023 20:01:44 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfuA4-000FtT-0T;
        Sat, 25 Mar 2023 03:01:44 +0000
Date:   Sat, 25 Mar 2023 11:01:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cs_dsp: Add a debugfs entry containing control
 details
Message-ID: <202303251059.g8YEWRGa-lkp@intel.com>
References: <20230324161010.938599-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324161010.938599-1-rf@opensource.cirrus.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3-rc3 next-20230324]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Fitzgerald/firmware-cs_dsp-Add-a-debugfs-entry-containing-control-details/20230325-001218
patch link:    https://lore.kernel.org/r/20230324161010.938599-1-rf%40opensource.cirrus.com
patch subject: [PATCH] firmware: cs_dsp: Add a debugfs entry containing control details
config: mips-randconfig-r005-20230322 (https://download.01.org/0day-ci/archive/20230325/202303251059.g8YEWRGa-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/62afac6e0c35c0d7e44e0bd1e4b2af8380413164
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Richard-Fitzgerald/firmware-cs_dsp-Add-a-debugfs-entry-containing-control-details/20230325-001218
        git checkout 62afac6e0c35c0d7e44e0bd1e4b2af8380413164
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/firmware/cirrus/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303251059.g8YEWRGa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/cirrus/cs_dsp.c: In function 'cs_dsp_debugfs_read_controls_show':
>> drivers/firmware/cirrus/cs_dsp.c:471:44: warning: format '%lx' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     471 |                 seq_printf(s, "%22.*s: %#8lx %s:%08x %#8x %s %#8x %#4x %c%c%c%c %s %s\n",
         |                                        ~~~~^
         |                                            |
         |                                            long unsigned int
         |                                        %#8x
     472 |                            ctl->subname_len, ctl->subname, ctl->len,
         |                                                            ~~~~~~~~
         |                                                               |
         |                                                               size_t {aka unsigned int}


vim +471 drivers/firmware/cirrus/cs_dsp.c

   459	
   460	static int cs_dsp_coeff_base_reg(struct cs_dsp_coeff_ctl *ctl, unsigned int *reg,
   461					 unsigned int off);
   462	
   463	static int cs_dsp_debugfs_read_controls_show(struct seq_file *s, void *ignored)
   464	{
   465		struct cs_dsp *dsp = s->private;
   466		struct cs_dsp_coeff_ctl *ctl;
   467		unsigned int reg;
   468	
   469		list_for_each_entry(ctl, &dsp->ctl_list, list) {
   470			cs_dsp_coeff_base_reg(ctl, &reg, 0);
 > 471			seq_printf(s, "%22.*s: %#8lx %s:%08x %#8x %s %#8x %#4x %c%c%c%c %s %s\n",
   472				   ctl->subname_len, ctl->subname, ctl->len,
   473				   cs_dsp_mem_region_name(ctl->alg_region.type),
   474				   ctl->offset, reg, ctl->fw_name, ctl->alg_region.alg, ctl->type,
   475				   ctl->flags & WMFW_CTL_FLAG_VOLATILE ? 'V' : '-',
   476				   ctl->flags & WMFW_CTL_FLAG_SYS ? 'S' : '-',
   477				   ctl->flags & WMFW_CTL_FLAG_READABLE ? 'R' : '-',
   478				   ctl->flags & WMFW_CTL_FLAG_WRITEABLE ? 'W' : '-',
   479				   ctl->enabled ? "enabled" : "disabled",
   480				   ctl->set ? "dirty" : "clean");
   481		}
   482	
   483		return 0;
   484	}
   485	DEFINE_SHOW_ATTRIBUTE(cs_dsp_debugfs_read_controls);
   486	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
