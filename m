Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7026CA42F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjC0MeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjC0MeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:34:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85704E8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679920453; x=1711456453;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FbwRB3qJWlx/dHMGpPlpGBzy4Qej8TsHrGccuaPGQ2w=;
  b=LE9JCwxGvIXK38VekBuAPuMQbHq9URrEAtoqUGMPYDs2o6qE2NtRHcR6
   jOkD2d2XGWGW2NhRwqBg8VRwQZVwMVXbf8YTD3B8ZIMQ0efX1Edimjojt
   GcQMtw8o3kowYLBPzpZfN/mc78edQ1Kz9eqMFg6iRBUuZSC/aW/FI/NMs
   NO7U1z4trOGBWesGvvEogZFZykJeQEqPR7WJEa8R/mfSfcp9PM7Cf2hJA
   ZkuarDsw1XoflK2rer2NLtBVAUyYMhz6Y2lP54v5R0Tggiie8RJQlKetA
   e92y9vRYDTn/tg1QM3QKI3MkoV0CGClMDhVm+Fa5KY1qpd7WLUCFcd2kW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="341825067"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="341825067"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 05:34:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="685953877"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="685953877"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Mar 2023 05:34:11 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pgm39-000HiZ-0Q;
        Mon, 27 Mar 2023 12:34:11 +0000
Date:   Mon, 27 Mar 2023 20:33:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: fs/btrfs/btrfs.o: warning: objtool: btrfs_unfreeze+0x4b3:
 unreachable instruction
Message-ID: <202303272002.GzGlsDY1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   197b6b60ae7bc51dd0814953c562833143b292aa
commit: c27cd083cfb9d392f304657ed00fcde1136704e7 Compiler attributes: GCC cold function alignment workarounds
date:   9 weeks ago
config: x86_64-randconfig-m001-20230327 (https://download.01.org/0day-ci/archive/20230327/202303272002.GzGlsDY1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c27cd083cfb9d392f304657ed00fcde1136704e7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c27cd083cfb9d392f304657ed00fcde1136704e7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303272002.GzGlsDY1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/btrfs/btrfs.o: warning: objtool: btrfs_unfreeze+0x4b3: unreachable instruction


objdump-func vmlinux.o btrfs_unfreeze:

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
