Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF0574BBCF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 06:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjGHEj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 00:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHEjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 00:39:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A621FD7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 21:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688791163; x=1720327163;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7yxrCMfTZgyQNWSYH1ul3Sfe+6KBhiz9TRFur5LYsMU=;
  b=DcUDzqS+FasmtSFuAS3OyMtvO4zwhuo5MUOD0lIbZU4tTbIS0haGpRlE
   4jQMPpdlL/4r0jAV0FDYr177jyTDz04nz8C+ysY8OQCw0nyrtMlkEntzH
   vctFCx1QzaZzvxQugySTipqpuW1vOHd63FJjlOfYgEybRG1LpcKwdmTZl
   wy+YKl7kER5FjOQBMRtMAYI8Vbb/O8Rl2Rd5HQHQwndsgtme2MI6wruru
   XJHK8ZNnA7Faf6zp15XNR4ffaV6urmyXJntWfiJHYmolFaP4WrgGiVNhQ
   s1prWAiC/DBnyXyPr0TqnT45oTdyGIWZd7MvplVh0+2pJa1pwJSwBOWXJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="427720694"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="427720694"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 21:39:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="720137554"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="720137554"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 07 Jul 2023 21:39:20 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHzj6-0002YW-03;
        Sat, 08 Jul 2023 04:39:20 +0000
Date:   Sat, 8 Jul 2023 12:39:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: csky-linux-ld: drivers/cxl/core/memdev.c:690: undefined reference to
 `firmware_upload_unregister'
Message-ID: <202307081257.e3AeEspV-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8689f4f2ea561dd080118eeb05c0255ac9542905
commit: 9521875bbe0055805557fff0b08fd9a29d02b7bc cxl: add a firmware update mechanism using the sysfs firmware loader
date:   12 days ago
config: csky-randconfig-r016-20230708 (https://download.01.org/0day-ci/archive/20230708/202307081257.e3AeEspV-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230708/202307081257.e3AeEspV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307081257.e3AeEspV-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/cxl/core/memdev.o: in function `devm_cxl_remove_fw_upload':
   drivers/cxl/core/memdev.c:824: undefined reference to `firmware_upload_unregister'
   csky-linux-ld: drivers/cxl/core/memdev.o: in function `detach_memdev':
   drivers/cxl/core/memdev.c:457: undefined reference to `firmware_upload_unregister'
   csky-linux-ld: drivers/cxl/core/memdev.o: in function `cxl_memdev_setup_fw_upload':
   drivers/cxl/core/memdev.c:836: undefined reference to `firmware_upload_register'
   csky-linux-ld: drivers/cxl/core/memdev.o: in function `devm_cxl_remove_fw_upload':
   drivers/cxl/core/memdev.c:824: undefined reference to `firmware_upload_unregister'
   csky-linux-ld: drivers/cxl/core/memdev.o: in function `cxl_fw_prepare':
   drivers/cxl/core/memdev.c:690: undefined reference to `firmware_upload_register'
>> csky-linux-ld: drivers/cxl/core/memdev.c:690: undefined reference to `firmware_upload_unregister'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
