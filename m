Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA295BA1C7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 22:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiIOUVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 16:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIOUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 16:21:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EBF4E86D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663273306; x=1694809306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zGB4O8y2Kn3B1oD7+r9Z0eZwgWbllku8Rol6jHyBNQE=;
  b=ZYwBM9M8JH98jhtLdcn98MyaFMdsizGgXK0NOzk2jOtzHMzUkJeipxuh
   nZZH/8w2kcpNxcx0ZpG5b2IhijGgScSd+z/a7S6ui/Pc85xu9UZOcmEt4
   AzwNpo+eB2kapVWT6yv6zT3VvN8vnALegOSc2AksSkDllpm+yDr6CWd5g
   bN0XXOj5bw0L0+rwjUTsdJ89fJOeaTjm7069fepT4uh+Rd9SU8pSd+Oy6
   gAsc05Em8BDIR53ww2YGiZ6GVNGeb3+AYCO+NVbIqPfTHz60BzqrmIKXx
   kBMQdqf1r2Po6I8O8w81TfMWO0l4UndAbuXmIb0hp4aFJgptXMs6Vgnni
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="360570408"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="360570408"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 13:21:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="650620907"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 15 Sep 2022 13:21:44 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYvMl-0000xh-1Z;
        Thu, 15 Sep 2022 20:21:43 +0000
Date:   Fri, 16 Sep 2022 04:21:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gianfranco <gianfranco.dutka@arista.com>,
        hirofumi@mail.parknet.co.jp
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        gianfranco.dutka@arista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]     fat: device-level-flush-after-sync
Message-ID: <202209160411.466veQ09-lkp@intel.com>
References: <20220914174015.7158-1-gianfranco.dutka@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914174015.7158-1-gianfranco.dutka@arista.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gianfranco,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.0-rc5 next-20220915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gianfranco/fat-device-level-flush-after-sync/20220915-014337
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3245cb65fd91cd514801bf91f5a3066d562f0ac4
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220916/202209160411.466veQ09-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b1130c74311f7b8c0713f373a8dc20b572883fca
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gianfranco/fat-device-level-flush-after-sync/20220915-014337
        git checkout b1130c74311f7b8c0713f373a8dc20b572883fca
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/fat/inode.c:829:41: error: too many arguments to function call, expected single argument 'bdev', have 3 arguments
                   return blkdev_issue_flush(sb->s_bdev, GFP_KERNEL, NULL);
                          ~~~~~~~~~~~~~~~~~~             ^~~~~~~~~~~~~~~~
   include/linux/gfp_types.h:333:20: note: expanded from macro 'GFP_KERNEL'
   #define GFP_KERNEL      (__GFP_RECLAIM | __GFP_IO | __GFP_FS)
                           ^
   include/linux/blkdev.h:1031:5: note: 'blkdev_issue_flush' declared here
   int blkdev_issue_flush(struct block_device *bdev);
       ^
   1 error generated.


vim +/bdev +829 fs/fat/inode.c

   825	
   826	static int fat_sync_fs(struct super_block *sb, int wait)
   827	{
   828		if (wait)
 > 829			return blkdev_issue_flush(sb->s_bdev, GFP_KERNEL, NULL);
   830		else
   831			return 0;
   832	}
   833	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
