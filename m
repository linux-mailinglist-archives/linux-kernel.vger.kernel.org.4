Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5246A5D62
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjB1Qpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjB1Qpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:45:53 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00F33403F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677602744; x=1709138744;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iduEXGZ2o7+EtBwbbNzm9i+5lVrMxR3oCXKBeB73i8k=;
  b=Z815UpImcznj9vYaZK7blwN0Nn9plKX99Hl7x48HYFO/3HJgi4VeyvHy
   a6n9YoTuQLn6lohQSut8o/nSz9Ac0dY5mBe8ELIR4ir84PQq4jeNWOm0Q
   SL36xRrlpG2XViIsnwsxC6B+L69gIJGlow7jLt/sT8jQTNZjqFKDA82/V
   AVjiUn6M6n/rb5HCUAU0cdPcHtfBKdfMV0FGwvvcy7rkGomF2oVeiSjlX
   ok5uUKvGzY9YHCeXs90oqNcNxY60hARupEeasOfPaf8DdRJx3LB1m3+U6
   lRJbUHl7DRfSc9w+C8m9K3nOzmBoP86mJbVvPdSc3552pPlGiM0t17Pdo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="313857944"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="313857944"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 08:45:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="817138302"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="817138302"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2023 08:45:42 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pX36j-0005X1-0t;
        Tue, 28 Feb 2023 16:45:41 +0000
Date:   Wed, 1 Mar 2023 00:45:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi.c:3078:38-40: WARNING !A || A && B is equivalent to
 !A || B
Message-ID: <202303010051.HrHWSr9y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ae3419fbac845b4d3f3a9fae4cc80c68d82cdf6e
commit: 76a85704cb917e3b25e00f02d5fd46e4e0a9077d spi: spi-mem: Allow controller supporting mem_ops without exec_op
date:   3 weeks ago
config: nios2-randconfig-c031-20230226 (https://download.01.org/0day-ci/archive/20230301/202303010051.HrHWSr9y-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303010051.HrHWSr9y-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/spi/spi.c:3078:38-40: WARNING !A || A && B is equivalent to !A || B

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
