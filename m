Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA105B8A42
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiINOXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiINOXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:23:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033B54F39B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663165390; x=1694701390;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0NUMeSnZcrH2RLjXRHKd+H5cCfslIuvsLHQV1aQYYbs=;
  b=MrgFL2gP62sy4j3hGt2rFovMCCuI5IU8TQdgNhfW2n5AY7q5cy7WYzED
   6d7N9B0hTeJlx1eYBfA0iKKcE2OocrD26OpVX0VKIRJfw8DP20OY2nwLo
   pGZz36aqqF1HklsvTxyl7CeMOEZPb9aCAT4CeMyCN/5aq4k6IfwiZEfgJ
   Dt6pr6HmDBS2V2APvpLGtjWwOFSxmnYkUXppY+na+IJaYbR2zk5TxBus+
   eKzGExVbTRKXev+TzjEj4tcF9bK088xV/jb77GKpMavu5NtE6kpiuY8ot
   fP4zSRhuo6p9TGK70luDjCrPwnbRc2D3wb2PuFCBOfXX0SbwkP+t3u7uc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="360181027"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="360181027"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 07:23:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="594401920"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Sep 2022 07:23:08 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYTIB-0000Hg-2k;
        Wed, 14 Sep 2022 14:23:07 +0000
Date:   Wed, 14 Sep 2022 22:23:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org
Subject: [cilium:pr/bpf-tc-links 1/10] ld.lld: error: undefined symbol:
 dev_sch_uninstall
Message-ID: <202209142212.Rm27TU3m-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/cilium/linux.git pr/bpf-tc-links
head:   f9ab02443a6bd720c616b575437a851435c80c49
commit: f182834c964343d39688f653f16bfee1f3ff39c2 [1/10] bpf: Add initial fd-based API to attach tc BPF programs
config: x86_64-randconfig-a015-20220912 (https://download.01.org/0day-ci/archive/20220914/202209142212.Rm27TU3m-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/cilium/linux/commit/f182834c964343d39688f653f16bfee1f3ff39c2
        git remote add cilium https://github.com/cilium/linux.git
        git fetch --no-tags cilium pr/bpf-tc-links
        git checkout f182834c964343d39688f653f16bfee1f3ff39c2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: dev_sch_uninstall
   >>> referenced by dev.c
   >>>               core/dev.o:(unregister_netdevice_many) in archive net/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
