Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEC07263DB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239756AbjFGPM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbjFGPMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:12:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A5D1734
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686150771; x=1717686771;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rM69SIuayS4owQ+pFyr4d+/+66I4yOv1mDrJk4ytElo=;
  b=P2I+JXKEWplzMeU0SfAd2GyazRtAQO8Guf5knIXUWquRvPRHqYutX938
   IjvTdHcTAzAYJs1QAkRaJcs7SGfek9dExNylufngxwPy3NV2Sm7Cdntey
   4p24vzGTY+khYKchjHUIvXGDoNcgHZRjC4ypWQDXv7VASTLyLkc7PB4vF
   dUdAL/LCknu3WYp6TBtU/YtP1qZnZkozBWMYDztTlr2QWBNhSDglogueF
   LkbzSBOAUEM4oz3yPd17ZcMPSh9rZ5bXx84TF96A27yq/bwKhROexfDi5
   03hAHMYbQ4AG58KcOXAgONr1xMF5HY/VvPhenl+yxVPNF3P4RK/567OjW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="337377681"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="337377681"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 08:12:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="687033189"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="687033189"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Jun 2023 08:12:18 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6upe-0006gc-0a;
        Wed, 07 Jun 2023 15:12:18 +0000
Date:   Wed, 7 Jun 2023 23:11:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yogesh Lal <quic_ylal@quicinc.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: drivers/remoteproc/qcom_q6v5_pas.c:108:6: warning: no previous
 prototype for function 'adsp_segment_dump'
Message-ID: <202306072353.uUeUzI6M-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4d7d701121981e3c3fe69ade376fe9f26324161
commit: a376c10d45a8e6ee5ea55791193f90625b35e156 remoteproc: qcom: pas: Adjust the phys addr wrt the mem region
date:   4 months ago
config: arm64-buildonly-randconfig-r005-20230607 (https://download.01.org/0day-ci/archive/20230607/202306072353.uUeUzI6M-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a376c10d45a8e6ee5ea55791193f90625b35e156
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a376c10d45a8e6ee5ea55791193f90625b35e156
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/remoteproc/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306072353.uUeUzI6M-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/remoteproc/qcom_q6v5_pas.c:108:6: warning: no previous prototype for function 'adsp_segment_dump' [-Wmissing-prototypes]
     108 | void adsp_segment_dump(struct rproc *rproc, struct rproc_dump_segment *segment,
         |      ^
   drivers/remoteproc/qcom_q6v5_pas.c:108:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     108 | void adsp_segment_dump(struct rproc *rproc, struct rproc_dump_segment *segment,
         | ^
         | static 
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
https://github.com/intel/lkp-tests/wiki
