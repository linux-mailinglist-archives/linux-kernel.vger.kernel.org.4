Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4726DB802
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 03:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjDHBfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 21:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDHBfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 21:35:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A345E10253
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 18:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680917721; x=1712453721;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fkKv7QrgbrL1+nAO+XJmQtEgJNzzljQKbPjTlZu7Kls=;
  b=jZH08nCnxQsTmvMCejBSr30HUhIU6uFG2jLRkrQ4cvkEkJ1uzza0EfC7
   KGyP+8BKmCf2m4to90ewCh1Nv+BFSjC0oFJQhs811azKRC6HobaB/yG7e
   ca9sBCWOcHMBNovP3Yd9rI3HYcH5Q6M8YHz/P99isQ+6a73j6afu65an4
   6UBzeEUkf9IXkJbFk/IiUQvwkU2sXoSDBe1NGLAdTa1+ZnlH05JH2m72g
   gG2u7BczwCpjijteuOD1RAThbD55g/UUIqAcm2n0hEa6r5wlGNDWPfnHs
   i33PKcCHcsH3t3q4KT19HkPjk02WCD+FVnjwV/3ZM/SHzipspObpBNweM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="340584761"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="340584761"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 18:35:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="752190165"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="752190165"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Apr 2023 18:35:19 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkxU6-000T8L-2k;
        Sat, 08 Apr 2023 01:35:18 +0000
Date:   Sat, 8 Apr 2023 09:35:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yogesh Lal <quic_ylal@quicinc.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: drivers/remoteproc/qcom_q6v5_pas.c:108:6: warning: no previous
 prototype for function 'adsp_segment_dump'
Message-ID: <202304080914.Ps91Sn8x-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aa318c48808c0aa73216bd94c54c4553d3663add
commit: a376c10d45a8e6ee5ea55791193f90625b35e156 remoteproc: qcom: pas: Adjust the phys addr wrt the mem region
date:   7 weeks ago
config: arm-randconfig-r046-20230407 (https://download.01.org/0day-ci/archive/20230408/202304080914.Ps91Sn8x-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 2c57868e2e877f73c339796c3374ae660bb77f0d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a376c10d45a8e6ee5ea55791193f90625b35e156
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a376c10d45a8e6ee5ea55791193f90625b35e156
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304080914.Ps91Sn8x-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/remoteproc/qcom_q6v5_pas.c:108:6: warning: no previous prototype for function 'adsp_segment_dump' [-Wmissing-prototypes]
   void adsp_segment_dump(struct rproc *rproc, struct rproc_dump_segment *segment,
        ^
   drivers/remoteproc/qcom_q6v5_pas.c:108:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void adsp_segment_dump(struct rproc *rproc, struct rproc_dump_segment *segment,
   ^
   static 
   1 warning generated.


vim +/adsp_segment_dump +108 drivers/remoteproc/qcom_q6v5_pas.c

   107	
 > 108	void adsp_segment_dump(struct rproc *rproc, struct rproc_dump_segment *segment,
   109			       void *dest, size_t offset, size_t size)
   110	{
   111		struct qcom_adsp *adsp = rproc->priv;
   112		int total_offset;
   113	
   114		total_offset = segment->da + segment->offset + offset - adsp->mem_phys;
   115		if (total_offset < 0 || total_offset + size > adsp->mem_size) {
   116			dev_err(adsp->dev,
   117				"invalid copy request for segment %pad with offset %zu and size %zu)\n",
   118				&segment->da, offset, size);
   119			memset(dest, 0xff, size);
   120			return;
   121		}
   122	
   123		memcpy_fromio(dest, adsp->mem_region + total_offset, size);
   124	}
   125	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
