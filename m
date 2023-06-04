Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F9C7215A4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 10:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjFDImY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 04:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjFDImX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 04:42:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA5DDA;
        Sun,  4 Jun 2023 01:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685868141; x=1717404141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ol4jthsEZQ6jVMwcAd4LFYahEFGdZmy7s4uUbJjAyYM=;
  b=iFwUW/O38/0/sNRYzQNPHCuX3DJ6WhhA1ACYqMpb5x6VrfUATyKPqRJM
   SZGehlJSE7QoMIzVOydhoLfTRioh+0zRiAG4XJxg/fMAcf7qrbiV2c1By
   rJHWbGV0mCDWDs65JT+fFjeV3f4Bal2V8s8+qPf00JqECeXa1k8OjdiJY
   EUv0wAFvqgZFMOae37qFAqvQzF/GeZPf+VUs34AWJMF+/6Ol+liNzcTlz
   2/TjNxNKrsBAYaYV69jb3z0OGrQ+rqq0TOvHrUJQIUOdc8nelTtFtVxFx
   fXSI62loJW3sGD/V2CWeOGwXCBIXy7iNOU7dN6qNWy7y81bhAa3HZAT3m
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="356179024"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="356179024"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 01:42:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="708313688"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="708313688"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 04 Jun 2023 01:42:19 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q5jJb-0002Uw-0n;
        Sun, 04 Jun 2023 08:42:19 +0000
Date:   Sun, 4 Jun 2023 16:42:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] cdx: Drop useless LIST_HEAD
Message-ID: <202306041613.FCYOdhUW-lkp@intel.com>
References: <cee692c7babd754c1c36186af116c4bb4dad0a17.1685853842.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cee692c7babd754c1c36186af116c4bb4dad0a17.1685853842.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.4-rc4 next-20230602]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-JAILLET/cdx-Drop-useless-LIST_HEAD/20230604-124432
base:   linus/master
patch link:    https://lore.kernel.org/r/cee692c7babd754c1c36186af116c4bb4dad0a17.1685853842.git.christophe.jaillet%40wanadoo.fr
patch subject: [PATCH] cdx: Drop useless LIST_HEAD
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230604/202306041613.FCYOdhUW-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0836d9a86cf6d803585f7d9810ec8622ec81b2f7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christophe-JAILLET/cdx-Drop-useless-LIST_HEAD/20230604-124432
        git checkout 0836d9a86cf6d803585f7d9810ec8622ec81b2f7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306041613.FCYOdhUW-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/cdx/controller/mcdi.c: In function 'cdx_mcdi_process_cmd':
>> drivers/cdx/controller/mcdi.c:637:64: error: 'cleanup_list' undeclared (first use in this function)
     637 |                 cdx_mcdi_complete_cmd(mcdi, cmd, outbuf, len, &cleanup_list);
         |                                                                ^~~~~~~~~~~~
   drivers/cdx/controller/mcdi.c:637:64: note: each undeclared identifier is reported only once for each function it appears in


vim +/cleanup_list +637 drivers/cdx/controller/mcdi.c

eb96b740192b2a0 Nipun Gupta 2023-03-13  609  
eb96b740192b2a0 Nipun Gupta 2023-03-13  610  void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword *outbuf, int len)
eb96b740192b2a0 Nipun Gupta 2023-03-13  611  {
eb96b740192b2a0 Nipun Gupta 2023-03-13  612  	struct cdx_mcdi_iface *mcdi;
eb96b740192b2a0 Nipun Gupta 2023-03-13  613  	struct cdx_mcdi_cmd *cmd;
eb96b740192b2a0 Nipun Gupta 2023-03-13  614  	unsigned int respseq;
eb96b740192b2a0 Nipun Gupta 2023-03-13  615  
eb96b740192b2a0 Nipun Gupta 2023-03-13  616  	if (!len || !outbuf) {
eb96b740192b2a0 Nipun Gupta 2023-03-13  617  		pr_err("Got empty MC response\n");
eb96b740192b2a0 Nipun Gupta 2023-03-13  618  		return;
eb96b740192b2a0 Nipun Gupta 2023-03-13  619  	}
eb96b740192b2a0 Nipun Gupta 2023-03-13  620  
eb96b740192b2a0 Nipun Gupta 2023-03-13  621  	mcdi = cdx_mcdi_if(cdx);
eb96b740192b2a0 Nipun Gupta 2023-03-13  622  	if (!mcdi)
eb96b740192b2a0 Nipun Gupta 2023-03-13  623  		return;
eb96b740192b2a0 Nipun Gupta 2023-03-13  624  
eb96b740192b2a0 Nipun Gupta 2023-03-13  625  	respseq = CDX_DWORD_FIELD(outbuf[0], MCDI_HEADER_SEQ);
eb96b740192b2a0 Nipun Gupta 2023-03-13  626  
eb96b740192b2a0 Nipun Gupta 2023-03-13  627  	mutex_lock(&mcdi->iface_lock);
eb96b740192b2a0 Nipun Gupta 2023-03-13  628  	cmd = mcdi->seq_held_by[respseq];
eb96b740192b2a0 Nipun Gupta 2023-03-13  629  
eb96b740192b2a0 Nipun Gupta 2023-03-13  630  	if (cmd) {
eb96b740192b2a0 Nipun Gupta 2023-03-13  631  		if (cmd->state == MCDI_STATE_FINISHED) {
eb96b740192b2a0 Nipun Gupta 2023-03-13  632  			mutex_unlock(&mcdi->iface_lock);
eb96b740192b2a0 Nipun Gupta 2023-03-13  633  			kref_put(&cmd->ref, cdx_mcdi_cmd_release);
eb96b740192b2a0 Nipun Gupta 2023-03-13  634  			return;
eb96b740192b2a0 Nipun Gupta 2023-03-13  635  		}
eb96b740192b2a0 Nipun Gupta 2023-03-13  636  
eb96b740192b2a0 Nipun Gupta 2023-03-13 @637  		cdx_mcdi_complete_cmd(mcdi, cmd, outbuf, len, &cleanup_list);
eb96b740192b2a0 Nipun Gupta 2023-03-13  638  	} else {
eb96b740192b2a0 Nipun Gupta 2023-03-13  639  		pr_err("MC response unexpected for seq : %0X\n", respseq);
eb96b740192b2a0 Nipun Gupta 2023-03-13  640  	}
eb96b740192b2a0 Nipun Gupta 2023-03-13  641  
eb96b740192b2a0 Nipun Gupta 2023-03-13  642  	mutex_unlock(&mcdi->iface_lock);
eb96b740192b2a0 Nipun Gupta 2023-03-13  643  
eb96b740192b2a0 Nipun Gupta 2023-03-13  644  	cdx_mcdi_process_cleanup_list(mcdi->cdx, &cleanup_list);
eb96b740192b2a0 Nipun Gupta 2023-03-13  645  }
eb96b740192b2a0 Nipun Gupta 2023-03-13  646  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
