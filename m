Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C76A5E7644
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiIWIxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiIWIxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:53:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF58EBD7D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 01:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663923223; x=1695459223;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MHV1si1UvkoL5WYSUETwZvlZ3zccaQ9cWTE8nYxCO/E=;
  b=MhMaUyl13BOi+xk2y+89oVMq6+6VdDt7mVgC2pYVvIrASDRijo09nLCW
   69KBPWPfNO7+TqJu4ssZad1RgcudBE8cb8V9rQ8XEO321XGtVjoWx8IE3
   XwaTQaouh6hUUnZfoOkn0z3ckHPDBOPQmG3JDjUthMI4wf9n+nVijPMp1
   aRdG7b4XQWbxdlcG60DemnkABGbjktPrOQj0fB4701WHgr+kQFFAdcOzL
   Iz8WhQ/97i3GHPjCbQ3bEW4v2P/jUxzR6roLZclELoHG27bMi603GJtFy
   uGTtxgV2y0vQBRm6fZN3dbIjLzSLYLQ3JJNyJm4tsxrCihgHDyZIFfMZq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="364564433"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="364564433"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 01:53:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="653331096"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Sep 2022 01:53:42 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obeRK-0005UG-0A;
        Fri, 23 Sep 2022 08:53:42 +0000
Date:   Fri, 23 Sep 2022 16:53:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/070-audio 6/33] sound/soc/codecs/tas2764.c:739:34:
 warning: array 'tas2764_of_match' assumed to have one element
Message-ID: <202209231658.cpB5WUql-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/070-audio
head:   5052d0fa99604a162270274e7a22a111862d824f
commit: 040ba7fbccbd82b839c15f7e80deb6dd58190be4 [6/33] ASoC: tas2764: Extend driver to SN012776
config: mips-randconfig-r013-20220922 (https://download.01.org/0day-ci/archive/20220923/202209231658.cpB5WUql-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/040ba7fbccbd82b839c15f7e80deb6dd58190be4
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/070-audio
        git checkout 040ba7fbccbd82b839c15f7e80deb6dd58190be4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/tas2764.c:739:34: warning: array 'tas2764_of_match' assumed to have one element
     739 | static const struct of_device_id tas2764_of_match[];
         |                                  ^~~~~~~~~~~~~~~~


vim +/tas2764_of_match +739 sound/soc/codecs/tas2764.c

   738	
 > 739	static const struct of_device_id tas2764_of_match[];
   740	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
