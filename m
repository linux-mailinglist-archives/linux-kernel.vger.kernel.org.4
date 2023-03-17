Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72956BDD81
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 01:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCQAWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 20:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCQAWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 20:22:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B18E502B;
        Thu, 16 Mar 2023 17:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679012521; x=1710548521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OE8Dqyqz+vpOyK5wB/P3TD5L08Vj6aPhYlgE8XqlfJI=;
  b=D5lMRBNJVmG8jSFxRMED4zH+ywUG0834AQVXEc3vN0/NC+8CHjaPD36x
   dw2pQk476TOzfyfB1T3sNNrHJNajOjfm7Wt3/QA82TLJMGXktPBOroET+
   hA8/hjNX3BCkzaMCqqxQ5nLL4giWZroKwJv14sTFXa6iT40d01KDqvhPO
   0wzK9FAMYWeODs2laz4HjKr7I7alZJrwSpXUvWQIHy1oAr94HW6Rmh0hv
   K99OjhoIQeraeK0zbOp3+f8KopnEG15Dj7AZHY6ebIMn+KGp4Usp5Gc/k
   g2kZohF2tA4NQdgO5pq+BfVtCZNKBB1ulF3YwIP8Ug/Vl8vaAuxbuCbgP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="400727680"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="400727680"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 17:21:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="630095879"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="630095879"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 16 Mar 2023 17:21:48 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcxqt-0008ua-2B;
        Fri, 17 Mar 2023 00:21:47 +0000
Date:   Fri, 17 Mar 2023 08:20:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Hindborg <nmi@metaspace.dk>, linux-block@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] block: ublk: enable zoned storage support
Message-ID: <202303170805.9OMzCcn7-lkp@intel.com>
References: <20230316145539.300523-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316145539.300523-1-nmi@metaspace.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on eeac8ede17557680855031c6f305ece2378af326]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Hindborg/block-ublk-enable-zoned-storage-support/20230316-225725
base:   eeac8ede17557680855031c6f305ece2378af326
patch link:    https://lore.kernel.org/r/20230316145539.300523-1-nmi%40metaspace.dk
patch subject: [PATCH v3] block: ublk: enable zoned storage support
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230317/202303170805.9OMzCcn7-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/723d5c2508e09f127226d38c698d3e4e6cff83f1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andreas-Hindborg/block-ublk-enable-zoned-storage-support/20230316-225725
        git checkout 723d5c2508e09f127226d38c698d3e4e6cff83f1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/block/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303170805.9OMzCcn7-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/block/ublk_drv-zoned.c: In function 'ublk_alloc_report_buffer':
>> drivers/block/ublk_drv-zoned.c:50:23: error: implicit declaration of function '__vmalloc'; did you mean '__kmalloc'? [-Werror=implicit-function-declaration]
      50 |                 buf = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
         |                       ^~~~~~~~~
         |                       __kmalloc
>> drivers/block/ublk_drv-zoned.c:50:21: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      50 |                 buf = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
         |                     ^
   cc1: some warnings being treated as errors


vim +50 drivers/block/ublk_drv-zoned.c

    31	
    32	// Based on virtblk_alloc_report_buffer
    33	static void *ublk_alloc_report_buffer(struct ublk_device *ublk,
    34					      unsigned int nr_zones,
    35					      unsigned int zone_sectors, size_t *buflen)
    36	{
    37		struct request_queue *q = ublk->ub_disk->queue;
    38		size_t bufsize;
    39		void *buf;
    40	
    41		nr_zones = min_t(unsigned int, nr_zones,
    42				 get_capacity(ublk->ub_disk) >> ilog2(zone_sectors));
    43	
    44		bufsize = nr_zones * sizeof(struct blk_zone);
    45		bufsize =
    46			min_t(size_t, bufsize, queue_max_hw_sectors(q) << SECTOR_SHIFT);
    47		bufsize = min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT);
    48	
    49		while (bufsize >= sizeof(struct blk_zone)) {
  > 50			buf = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
    51			if (buf) {
    52				*buflen = bufsize;
    53				return buf;
    54			}
    55			bufsize >>= 1;
    56		}
    57	
    58		bufsize = 0;
    59		return NULL;
    60	}
    61	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
