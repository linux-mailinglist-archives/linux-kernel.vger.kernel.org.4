Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A6E6BFD0E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 23:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjCRWnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 18:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRWnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 18:43:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAAE5FCB
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 15:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679179379; x=1710715379;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pf8DwnHvAzljRfTjeYwFoRL+mtrlcjnT/a49vtdNVN4=;
  b=fXtkTetflv9nk6T8HmiQld8hH79JQqfEallbQukz1tIbDjjnq6JiuwtO
   cRpK6Lw4LSGdo5sbdE5X193AdbEb/c7IUQPJPIr8+6cXJpXDNYtULeUXO
   j68/GHHs/e1C5F/7YkIXRHeUVJPkITWqOZkMvi+d8mcQia2xVS+fa1bH6
   gcEXHQaBttGrjZ1phUV4ZmkPfISDS2PjLkVU+7gxLbORTzI8e7als38YZ
   h9JQps0V3ORS/X1yRV3oi53GYM8eO0MU7+G2zmfU7SgcVa85zRHDIL+xd
   lAShJRfaVo/wS93XdGwnYsa0IWKTq78iT+BZjwBQ6tXeMum8LCAj83NhR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="326830907"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="326830907"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 15:42:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="713133086"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="713133086"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Mar 2023 15:42:57 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdfGK-000AIk-0q;
        Sat, 18 Mar 2023 22:42:56 +0000
Date:   Sun, 19 Mar 2023 06:42:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/rpmsg/qcom_glink_smem.c:93:17: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
Message-ID: <202303190635.gFHJrZo4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   534293368afa1a953c283310b82e4dc58309d51e
commit: 8318f7c231d5be09e47410c5ab387b9bef6fe19e csky: optimize memcpy_{from,to}io() and memset_io()
date:   11 months ago
config: csky-randconfig-s033-20230319 (https://download.01.org/0day-ci/archive/20230319/202303190635.gFHJrZo4-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8318f7c231d5be09e47410c5ab387b9bef6fe19e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8318f7c231d5be09e47410c5ab387b9bef6fe19e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash drivers/rpmsg/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303190635.gFHJrZo4-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/rpmsg/qcom_glink_smem.c:93:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got void * @@
   drivers/rpmsg/qcom_glink_smem.c:93:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/rpmsg/qcom_glink_smem.c:93:17: sparse:     got void *
>> drivers/rpmsg/qcom_glink_smem.c:96:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got void *fifo @@
   drivers/rpmsg/qcom_glink_smem.c:96:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/rpmsg/qcom_glink_smem.c:96:17: sparse:     got void *fifo

vim +93 drivers/rpmsg/qcom_glink_smem.c

caf989c350e8e0 Bjorn Andersson        2017-08-24  78  
caf989c350e8e0 Bjorn Andersson        2017-08-24  79  static void glink_smem_rx_peak(struct qcom_glink_pipe *np,
b88eee975a26b1 Bjorn Andersson        2017-08-24  80  			       void *data, unsigned int offset, size_t count)
caf989c350e8e0 Bjorn Andersson        2017-08-24  81  {
caf989c350e8e0 Bjorn Andersson        2017-08-24  82  	struct glink_smem_pipe *pipe = to_smem_pipe(np);
caf989c350e8e0 Bjorn Andersson        2017-08-24  83  	size_t len;
caf989c350e8e0 Bjorn Andersson        2017-08-24  84  	u32 tail;
caf989c350e8e0 Bjorn Andersson        2017-08-24  85  
caf989c350e8e0 Bjorn Andersson        2017-08-24  86  	tail = le32_to_cpu(*pipe->tail);
b88eee975a26b1 Bjorn Andersson        2017-08-24  87  	tail += offset;
b88eee975a26b1 Bjorn Andersson        2017-08-24  88  	if (tail >= pipe->native.length)
b88eee975a26b1 Bjorn Andersson        2017-08-24  89  		tail -= pipe->native.length;
caf989c350e8e0 Bjorn Andersson        2017-08-24  90  
caf989c350e8e0 Bjorn Andersson        2017-08-24  91  	len = min_t(size_t, count, pipe->native.length - tail);
928002a5e9dab2 Arun Kumar Neelakantam 2018-10-03  92  	if (len)
928002a5e9dab2 Arun Kumar Neelakantam 2018-10-03 @93  		memcpy_fromio(data, pipe->fifo + tail, len);
caf989c350e8e0 Bjorn Andersson        2017-08-24  94  
928002a5e9dab2 Arun Kumar Neelakantam 2018-10-03  95  	if (len != count)
928002a5e9dab2 Arun Kumar Neelakantam 2018-10-03 @96  		memcpy_fromio(data + len, pipe->fifo, (count - len));
caf989c350e8e0 Bjorn Andersson        2017-08-24  97  }
caf989c350e8e0 Bjorn Andersson        2017-08-24  98  

:::::: The code at line 93 was first introduced by commit
:::::: 928002a5e9dab2ddc1a0fe3e00739e89be30dc6b rpmsg: glink: smem: Support rx peak for size less than 4 bytes

:::::: TO: Arun Kumar Neelakantam <aneela@codeaurora.org>
:::::: CC: Bjorn Andersson <bjorn.andersson@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
