Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE5D5BADDA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiIPNKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiIPNK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:10:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BF0E79
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663333826; x=1694869826;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p5+7xUeblF975PSH7aYhnG445lSRqwmthP0tT+D0hxY=;
  b=PNMyM2nlWEAlkAL9HJ3KHN5IdJtU3dMQWI1iyU9r4fh6FCm01GjDBRLK
   5qmxqkzxfekX3waCEefirLgBL7auvC86LoiNGX4NLSBHf6qmh7EoufMjb
   bcyI2r8Z9JaMZElSr1YQFuAHVkLTrf+63jz81E6cRSC88DnFOVahxfX9y
   xTtEEhd5yOMMZFRvZy+oSne1738OUTkokD5xwqNRJBxEiV3B4y3jwGALH
   HO+3/SXtXn4JdNtK26OFFlzXY5EC8b6vvvL3K9KOleoydofGOgLx2LPMn
   QySxQEYkCSOoXpszg+EcJWcgrHe7yhTjIbTmPfTZPDzp1/HD/dO0AVSM9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="362949769"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="362949769"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 06:10:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="946368442"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Sep 2022 06:09:59 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZB6Q-0001n0-06;
        Fri, 16 Sep 2022 13:09:54 +0000
Date:   Fri, 16 Sep 2022 21:09:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Farzad Farshchi <farzadfr@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [esmil:visionfive 38/42] drivers/nvdla/engine.c:86:9: sparse:
 sparse: symbol 'bdma_grp_sts' was not declared. Should it be static?
Message-ID: <202209162028.i6FOASKl-lkp@intel.com>
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

tree:   https://github.com/esmil/linux visionfive
head:   6ddc6d1b0947a4433b734808f228d1ff253dc46a
commit: 42c828888fd79d43a7eda2ed2d92aad848b98591 [38/42] nvdla: add NVDLA driver
config: arm64-randconfig-s041-20220916 (https://download.01.org/0day-ci/archive/20220916/202209162028.i6FOASKl-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/esmil/linux/commit/42c828888fd79d43a7eda2ed2d92aad848b98591
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 42c828888fd79d43a7eda2ed2d92aad848b98591
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/nvdla/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/nvdla/engine.c:86:9: sparse: sparse: symbol 'bdma_grp_sts' was not declared. Should it be static?
>> drivers/nvdla/engine.c:91:21: sparse: sparse: symbol 'roi_desc' was not declared. Should it be static?

vim +/bdma_grp_sts +86 drivers/nvdla/engine.c

    85	
  > 86	uint8_t bdma_grp_sts[2] = {
    87		FIELD_ENUM(BDMA_STATUS_0, IDLE, YES),
    88		FIELD_ENUM(BDMA_STATUS_0, IDLE, YES)
    89	};
    90	
  > 91	struct dla_roi_desc roi_desc;
    92	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
