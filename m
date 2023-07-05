Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C0C749206
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjGEXoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjGEXoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:44:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925BBE63
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 16:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688600651; x=1720136651;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9QFqjTkkq/7TmgGgCIlV8R9kH9+HhvtiN4wzuxIy2uQ=;
  b=eraCPp+fnLkHhOwdzrBxRuNtcDE71UjQYaokGgbLossGoqSOFVKz6BqZ
   YA0cobN/YEajnh+ZIsupOseD/Xj0JhXo6jfwh5SrNCmRBSAsymk5QTaiT
   E9CHfTxoO9KUuXpd8+HI9DPb9Rn+61frT5lBGD26X9uKTGkchWHZObpaq
   YN5qTwD6jkNSgLSvwQeUhAKUvr8qGmoWC8O+DAWOjcD/3SmCSdzGF93sr
   Tm+TWs7+OcUiSvVePSOgA497be3aFZ1N4RSqLXNub8mGcs0yOsuNQxhjs
   BL9skpxC/LmvgCb24jVks9EHh0gfctIZL9KF9hJLsDBROHVFJ3hFhAldj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="366039230"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="366039230"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 16:44:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="719397600"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="719397600"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 Jul 2023 16:44:08 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHCAJ-0000t8-2q;
        Wed, 05 Jul 2023 23:44:07 +0000
Date:   Thu, 6 Jul 2023 07:43:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: ld.lld: error: undefined symbol: firmware_upload_register
Message-ID: <202307060742.vdkvv1Z3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   73a3fcdaa73200e38e38f7e8a32c9b901c5b95b5
commit: 9521875bbe0055805557fff0b08fd9a29d02b7bc cxl: add a firmware update mechanism using the sysfs firmware loader
date:   10 days ago
config: x86_64-randconfig-x016-20230706 (https://download.01.org/0day-ci/archive/20230706/202307060742.vdkvv1Z3-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230706/202307060742.vdkvv1Z3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307060742.vdkvv1Z3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: firmware_upload_register
   >>> referenced by memdev.c:836 (drivers/cxl/core/memdev.c:836)
   >>>               drivers/cxl/core/memdev.o:(cxl_memdev_setup_fw_upload) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: firmware_upload_unregister
   >>> referenced by memdev.c:824 (drivers/cxl/core/memdev.c:824)
   >>>               drivers/cxl/core/memdev.o:(cxl_memdev_setup_fw_upload) in archive vmlinux.a
   >>> referenced by memdev.c:824 (drivers/cxl/core/memdev.c:824)
   >>>               drivers/cxl/core/memdev.o:(devm_cxl_remove_fw_upload) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
