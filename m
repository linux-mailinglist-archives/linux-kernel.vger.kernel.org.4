Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BC57044F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 08:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjEPGBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 02:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjEPGBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 02:01:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBA91AE
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 23:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684216875; x=1715752875;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8VEKYA38dKoRRJb0SgxehtThztANKSBzjhJe4qKwW7E=;
  b=AgFWG4vkdGtHX7cq/vmGIlL8phJidrRrC8m2MIZiQeGKNrJGdQptfrrN
   4BouVur8EpLzgmfZ4o9G24/ey6X4nHXWfV2PBQ9MFpevizB6+sPWMANsa
   xu26zjhv5lkg3fo7RLf3DKkesJz030AbFqKmB+u4dXOXWF7eAOMrejynJ
   jcKI2JbrlFFRJVnFDdKDCF7X0naH2h6QOp91Ane5l9UHsIZ0grPRDYz/T
   WwP3w781EFJXYqf0x911+39fwdreexKgukPj2Gfm/knWydNYJpRulfXQj
   9lXdKQLKDwC906lrnuW8tcGs+KSMgMUfglydhNJ2SXrVoboJYGypwgs73
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="340755933"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="340755933"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 23:01:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="947709819"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="947709819"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 15 May 2023 23:01:02 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pynk0-00073M-1U;
        Tue, 16 May 2023 06:00:56 +0000
Date:   Tue, 16 May 2023 14:00:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: drivers/bluetooth/btnxpuart.c:1277:34: warning:
 'nxpuart_of_match_table' defined but not used
Message-ID: <202305161345.eClvTYQ9-lkp@intel.com>
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
head:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
commit: 689ca16e523278470c38832a3010645a78c544d8 Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets
date:   3 weeks ago
config: i386-randconfig-i085 (https://download.01.org/0day-ci/archive/20230516/202305161345.eClvTYQ9-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=689ca16e523278470c38832a3010645a78c544d8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 689ca16e523278470c38832a3010645a78c544d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/bluetooth/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305161345.eClvTYQ9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/bluetooth/btnxpuart.c:1277:34: warning: 'nxpuart_of_match_table' defined but not used [-Wunused-const-variable=]
    1277 | static const struct of_device_id nxpuart_of_match_table[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~


vim +/nxpuart_of_match_table +1277 drivers/bluetooth/btnxpuart.c

  1276	
> 1277	static const struct of_device_id nxpuart_of_match_table[] = {
  1278		{ .compatible = "nxp,88w8987-bt", .data = &w8987_data },
  1279		{ .compatible = "nxp,88w8997-bt", .data = &w8997_data },
  1280		{ }
  1281	};
  1282	MODULE_DEVICE_TABLE(of, nxpuart_of_match_table);
  1283	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
