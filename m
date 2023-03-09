Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F076B2897
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjCIPUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjCIPUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:20:44 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B1BE6831
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678375241; x=1709911241;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B//ffOIlaCZoqGWrl3k0tinZmKmcI4OPWjPvucgTJxY=;
  b=ZiCCnHZwyKQG5yjYKt2dgyy9r7kXcC7aPKHi+lsow46XA7MMdZtvZuJb
   49NiRtl4sikdWANaz3UwJJMKH/DaFTVO13zWv7qo/VcyDLbna5riVzCEB
   yRWaNtEM8dwLVoY0NVvaQqN8V2Yhg4sEzjHf++/C04lFeAKuYSNR40tZW
   M/i/kZs9YBLGC6uc/CPagRAk4rEcrJUAsq4IT+f3VPT35PHRxMbth7ilz
   /V82IGuC9l4h39+BP5PoTFKVjt1oQR7g/ABDJjTdSyJWDJdTjvpIYs2MV
   b2T5f3gIEJKBb5NOluhnl+RL8u4+4afE3RYBGCvUmJh5j0PR0BISZSJ2o
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="336478574"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="336478574"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 07:20:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="801217017"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="801217017"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Mar 2023 07:20:28 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paI4B-00032B-1q;
        Thu, 09 Mar 2023 15:20:27 +0000
Date:   Thu, 9 Mar 2023 23:20:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/soc/qcom/qdsp6/q6apm.c:30:14: sparse: sparse: symbol 'g_apm'
 was not declared. Should it be static?
Message-ID: <202303092330.kPhyOd01-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6a98c9cae232800c319ed69e1063480d31430887
commit: 47bc8cf60e926d1fb0c5d990bf6f5e01e9b3352e ASoC: qdsp6: audioreach: Add ADSP ready check
date:   6 weeks ago
config: riscv-randconfig-s043-20230309 (https://download.01.org/0day-ci/archive/20230309/202303092330.kPhyOd01-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=47bc8cf60e926d1fb0c5d990bf6f5e01e9b3352e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 47bc8cf60e926d1fb0c5d990bf6f5e01e9b3352e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash drivers/soc/fsl/qe/ sound/soc/qcom/qdsp6/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303092330.kPhyOd01-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zihintpause'
>> sound/soc/qcom/qdsp6/q6apm.c:30:14: sparse: sparse: symbol 'g_apm' was not declared. Should it be static?

vim +/g_apm +30 sound/soc/qcom/qdsp6/q6apm.c

    29	
  > 30	struct q6apm *g_apm;
    31	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
