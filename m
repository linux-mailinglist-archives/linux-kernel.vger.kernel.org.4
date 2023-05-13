Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E01701AD5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 01:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjEMXaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 19:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEMXaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 19:30:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28751FF6
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 16:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684020619; x=1715556619;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CtpOwTtpjdC7FU3FVZcCyvY90zJga/dcy7PXZtt+LTg=;
  b=MoH0LURcAvKjvapb/k480d6LwuZaAbghmmgRDwVp2gP8r7M4bu4eK2oF
   jwGmYLMFoUVEIPDblLZInhHcNW5MSifCT5nJR0rB8ijKjfBewNcZKioVU
   tKnDGcmI6WIMHqypET+LPDMQ2cXw3ic5PEDAJrxHweloYPjYTgAOlpRc9
   Lx9qLYIEnQjXAAHEGfj6PTE95cl/KhI57XiKsaLpgDdHyjbPO+w+J4MBQ
   j9J0uvFRUSvJTFfevr8I4Gxg1DaqXvbaPx6eKxwP0yn8rR/x7RtTB6unz
   c4YHuhbvl2fDGtHhjKa7rgtYDS6cJOxjlRw+8YOydIcs22cZTxD6L9v7u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="335519098"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="335519098"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 16:30:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="700541539"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="700541539"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 May 2023 16:30:18 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxygr-0005jW-27;
        Sat, 13 May 2023 23:30:17 +0000
Date:   Sun, 14 May 2023 07:29:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/soc/qcom/qdsp6/q6apm.c:30:14: sparse: sparse: symbol 'g_apm'
 was not declared. Should it be static?
Message-ID: <202305140734.9A83PDpw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d4d58949a6eac1c45ab022562c8494725e1ac094
commit: 47bc8cf60e926d1fb0c5d990bf6f5e01e9b3352e ASoC: qdsp6: audioreach: Add ADSP ready check
date:   4 months ago
config: nios2-randconfig-s032-20230514 (https://download.01.org/0day-ci/archive/20230514/202305140734.9A83PDpw-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305140734.9A83PDpw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/soc/qcom/qdsp6/q6apm.c:30:14: sparse: sparse: symbol 'g_apm' was not declared. Should it be static?

vim +/g_apm +30 sound/soc/qcom/qdsp6/q6apm.c

    29	
  > 30	struct q6apm *g_apm;
    31	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
