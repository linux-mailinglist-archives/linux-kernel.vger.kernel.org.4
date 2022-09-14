Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2043A5B8F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 21:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiINTKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 15:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiINTK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 15:10:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A13356C8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 12:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663182627; x=1694718627;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5Av9Qy1mmdaLVS1Y5UFAEwpgyvHuwEjAoSVdJaW3fMU=;
  b=Ug66DrUKn+BdWaS8Fkx/6fL8/HNr0G521Sn9UPiNdYFXPzHbAVNAdPAg
   4Kwqb7q4l4Vcx8CL8swCxDOItGBaymwq1z6SYdKgWOlJUIh0LMClOL5s0
   Uh6H4uCR3KPKQRd7Ev5kOlLCjDG18k66j3U0vr479PNioDMyQRjq6gDho
   fn4wC8GMVEcj3AVxsuJpoH5YkEvrH/RHgqi35rLhSypZa73sotGm/rp1A
   7A8H6XjEB3zjSrGtidVXyooB/fxDFe83wSBve38Vup3YxDUmpT+vGiwA1
   T1Mi0SroIpxdZHMBqboN+Y7dx59Nf9rfZYxRBsLdkKTjhQr3ZNS8ZhjsL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="285561258"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="285561258"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 12:10:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="568129165"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 14 Sep 2022 12:10:25 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYXmD-0000Ui-0E;
        Wed, 14 Sep 2022 19:10:25 +0000
Date:   Thu, 15 Sep 2022 03:10:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [spandruvada:idle-inject 10/13]
 drivers/thermal/intel/intel_powerclamp.c:449:6: warning: no previous
 prototype for function 'idle_inject_end'
Message-ID: <202209150259.dx4CzR7v-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/spandruvada/linux-kernel idle-inject
head:   adb26b2a9269625eac48c04d39443e741894a569
commit: 85a53ba91f9b1a7511239c5bb33a44d78fa5e4a5 [10/13] thermal/drivers/intel_powerclamp: Use powercap idle-inject framework
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220915/202209150259.dx4CzR7v-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/spandruvada/linux-kernel/commit/85a53ba91f9b1a7511239c5bb33a44d78fa5e4a5
        git remote add spandruvada https://github.com/spandruvada/linux-kernel
        git fetch --no-tags spandruvada idle-inject
        git checkout 85a53ba91f9b1a7511239c5bb33a44d78fa5e4a5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/thermal/intel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/thermal/intel/intel_powerclamp.c:449:6: warning: no previous prototype for function 'idle_inject_end' [-Wmissing-prototypes]
   void idle_inject_end(unsigned int cpu, unsigned int idle_duration, unsigned int run_duration)
        ^
   drivers/thermal/intel/intel_powerclamp.c:449:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void idle_inject_end(unsigned int cpu, unsigned int idle_duration, unsigned int run_duration)
   ^
   static 
   1 warning generated.


vim +/idle_inject_end +449 drivers/thermal/intel/intel_powerclamp.c

   448	
 > 449	void idle_inject_end(unsigned int cpu, unsigned int idle_duration, unsigned int run_duration)
   450	{
   451		unsigned int runtime;
   452	
   453		runtime = get_run_time(&powerclamp_data);
   454		idle_inject_set_duration(ii_dev, runtime, idle_duration);
   455	}
   456	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
