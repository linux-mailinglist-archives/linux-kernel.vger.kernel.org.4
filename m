Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A49173D510
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 00:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjFYWiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 18:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFYWh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 18:37:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3521BB
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 15:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687732677; x=1719268677;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1TGvSGW6gAmVqvWegpKnz2OsceukRvXs9Eiof0F8/6Q=;
  b=evvZGNKY0I9vHI7/syW14Zs52aRlAtcwS/4vCwNgrfudH616TYhv2Ezi
   7VIKWQ5g8ikeCYWrir4LTEt8qiyXWJEmbp3ptwetB0lQFVB1KRC5Lmzhq
   Quz0zawKrJuMA7Q9FHfzwH/I+bLh3ACv0VJrkZ4LGUnrwMwLmzlVUecGG
   RoUbhXiuw7XmTAsuJc+QIflyOvusEkpkeMEdRLVr9hTA4gvR+m+/1aT5Q
   CmmLn/Y0cuffEe8Cp1iKa6IPOrMUlo5L6RmPFtzSebBW3Whm4J8BqlTJ1
   ri3yclCG58Had7KadycXBAA6YSV9yGIlDZHBjOz7ioNTmibDCJN6Bh0gm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="363675905"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="363675905"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 15:37:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="785938829"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="785938829"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jun 2023 15:37:54 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDYMk-000AKf-0V;
        Sun, 25 Jun 2023 22:37:54 +0000
Date:   Mon, 26 Jun 2023 06:37:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/scsi/pm8001/pm80xx_hwi.h:639:2: warning: field  within
 'struct smp_req' is less aligned than 'union smp_req::(anonymous at
 drivers/scsi/pm8001/pm80xx_hwi.h:639:2)' and is usually due to 'struct
 smp_req' being packed, which can lead to unaligned ac...
Message-ID: <202306260618.P3XlR5N7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   547cc9be86f4c51c51fd429ace6c2e1ef9050d15
commit: 7036440eab3e2d47a775d4616909f8235488d714 ARM: omap1: enable multiplatform
date:   1 year, 1 month ago
config: arm-randconfig-r026-20230626 (https://download.01.org/0day-ci/archive/20230626/202306260618.P3XlR5N7-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230626/202306260618.P3XlR5N7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306260618.P3XlR5N7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/scsi/pm8001/pm80xx_hwi.c:42:
>> drivers/scsi/pm8001/pm80xx_hwi.h:639:2: warning: field  within 'struct smp_req' is less aligned than 'union smp_req::(anonymous at drivers/scsi/pm8001/pm80xx_hwi.h:639:2)' and is usually due to 'struct smp_req' being packed, which can lead to unaligned accesses [-Wunaligned-access]
     639 |         union {
         |         ^
   1 warning generated.
--
   In file included from drivers/scsi/pm8001/pm8001_hwi.c:42:
>> drivers/scsi/pm8001/pm8001_hwi.h:402:2: warning: field  within 'struct smp_req' is less aligned than 'union smp_req::(anonymous at drivers/scsi/pm8001/pm8001_hwi.h:402:2)' and is usually due to 'struct smp_req' being packed, which can lead to unaligned accesses [-Wunaligned-access]
     402 |         union {
         |         ^
   1 warning generated.
--
>> arch/arm/mm/copypage-feroceon.c:65:6: warning: no previous prototype for function 'feroceon_copy_user_highpage' [-Wmissing-prototypes]
      65 | void feroceon_copy_user_highpage(struct page *to, struct page *from,
         |      ^
   arch/arm/mm/copypage-feroceon.c:65:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      65 | void feroceon_copy_user_highpage(struct page *to, struct page *from,
         | ^
         | static 
>> arch/arm/mm/copypage-feroceon.c:78:6: warning: no previous prototype for function 'feroceon_clear_user_highpage' [-Wmissing-prototypes]
      78 | void feroceon_clear_user_highpage(struct page *page, unsigned long vaddr)
         |      ^
   arch/arm/mm/copypage-feroceon.c:78:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      78 | void feroceon_clear_user_highpage(struct page *page, unsigned long vaddr)
         | ^
         | static 
   2 warnings generated.


vim +639 drivers/scsi/pm8001/pm80xx_hwi.h

f5860992db55c9 Sakthivel K 2013-04-17  624  
f5860992db55c9 Sakthivel K 2013-04-17  625  /*
f5860992db55c9 Sakthivel K 2013-04-17  626   * brief the data structure of SMP Request Command
f5860992db55c9 Sakthivel K 2013-04-17  627   * use to describe MPI SMP REQUEST Command (64 bytes)
f5860992db55c9 Sakthivel K 2013-04-17  628   */
f5860992db55c9 Sakthivel K 2013-04-17  629  struct smp_req {
f5860992db55c9 Sakthivel K 2013-04-17  630  	__le32	tag;
f5860992db55c9 Sakthivel K 2013-04-17  631  	__le32	device_id;
f5860992db55c9 Sakthivel K 2013-04-17  632  	__le32	len_ip_ir;
f5860992db55c9 Sakthivel K 2013-04-17  633  	/* Bits [0] - Indirect response */
f5860992db55c9 Sakthivel K 2013-04-17  634  	/* Bits [1] - Indirect Payload */
f5860992db55c9 Sakthivel K 2013-04-17  635  	/* Bits [15:2] - Reserved */
f5860992db55c9 Sakthivel K 2013-04-17  636  	/* Bits [23:16] - direct payload Len */
f5860992db55c9 Sakthivel K 2013-04-17  637  	/* Bits [31:24] - Reserved */
f5860992db55c9 Sakthivel K 2013-04-17  638  	u8	smp_req16[16];
f5860992db55c9 Sakthivel K 2013-04-17 @639  	union {
f5860992db55c9 Sakthivel K 2013-04-17  640  		u8	smp_req[32];
f5860992db55c9 Sakthivel K 2013-04-17  641  		struct {
f5860992db55c9 Sakthivel K 2013-04-17  642  			__le64 long_req_addr;/* sg dma address, LE */
f5860992db55c9 Sakthivel K 2013-04-17  643  			__le32 long_req_size;/* LE */
f5860992db55c9 Sakthivel K 2013-04-17  644  			u32	_r_a;
f5860992db55c9 Sakthivel K 2013-04-17  645  			__le64 long_resp_addr;/* sg dma address, LE */
f5860992db55c9 Sakthivel K 2013-04-17  646  			__le32 long_resp_size;/* LE */
f5860992db55c9 Sakthivel K 2013-04-17  647  			u32	_r_b;
f5860992db55c9 Sakthivel K 2013-04-17  648  			} long_smp_req;/* sequencer extension */
f5860992db55c9 Sakthivel K 2013-04-17  649  	};
f5860992db55c9 Sakthivel K 2013-04-17  650  	__le32	rsvd[16];
f5860992db55c9 Sakthivel K 2013-04-17  651  } __attribute__((packed, aligned(4)));
f5860992db55c9 Sakthivel K 2013-04-17  652  /*
f5860992db55c9 Sakthivel K 2013-04-17  653   * brief the data structure of SMP Completion Response
f5860992db55c9 Sakthivel K 2013-04-17  654   * use to describe MPI SMP Completion Response (64 bytes)
f5860992db55c9 Sakthivel K 2013-04-17  655   */
f5860992db55c9 Sakthivel K 2013-04-17  656  struct smp_completion_resp {
f5860992db55c9 Sakthivel K 2013-04-17  657  	__le32	tag;
f5860992db55c9 Sakthivel K 2013-04-17  658  	__le32	status;
f5860992db55c9 Sakthivel K 2013-04-17  659  	__le32	param;
f5860992db55c9 Sakthivel K 2013-04-17  660  	u8	_r_a[252];
f5860992db55c9 Sakthivel K 2013-04-17  661  } __attribute__((packed, aligned(4)));
f5860992db55c9 Sakthivel K 2013-04-17  662  

:::::: The code at line 639 was first introduced by commit
:::::: f5860992db55c9e36b0f120dff73f0c34abe510d [SCSI] pm80xx: Added SPCv/ve specific hardware functionalities and relevant changes in common files

:::::: TO: Sakthivel K <Sakthivel.SaravananKamalRaju@pmcs.com>
:::::: CC: James Bottomley <JBottomley@Parallels.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
