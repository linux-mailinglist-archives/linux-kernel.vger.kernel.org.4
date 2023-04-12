Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77D56DE9C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 05:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjDLDE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 23:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDLDEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 23:04:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DF810C3;
        Tue, 11 Apr 2023 20:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681268692; x=1712804692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b//hPJS1hC0YIPOTddaIA/snfSK/csSj0RmEjRTlyS8=;
  b=g5J6si4A/RyprAG0EI+AuGHGnTaYgdCpanhzAb35nBjTVmeTOQitoXCu
   hXO/uVn5yS8+CFmUKuS0ZhqOf8qCbrUQObaNbzF0UFH+KI/jfntE92QCJ
   wrQcxHlOYQ9Z0LkLGx0OeP8axT/MX8Ry3SEhAydvHLwuqCJJ8Fw0gpKKB
   xgeg1ztUEdfIOfFN2idwzSf9vOPA29IGjmOasvVN4IMoKXbgfWgm6n31I
   wJLrabYWKRclU+/KWPKE6vYFkzAvR2pDTpDcmpXSSJr6dGMhagu+vQ9d2
   fVClW8vSoAOVX2Sem+6/7pQUaM9dyhgIiTHcyZn+z88ljzabM4fltG/YP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="324148208"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="324148208"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 20:04:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="639046232"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="639046232"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Apr 2023 20:04:48 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmQmu-000X8t-0M;
        Wed, 12 Apr 2023 03:04:48 +0000
Date:   Wed, 12 Apr 2023 11:04:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, terry.bowman@amd.com,
        rrichter@amd.com, linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v3 4/6] cxl/pci: Add RCH downstream port error logging
Message-ID: <202304121055.UceD86D7-lkp@intel.com>
References: <20230411180302.2678736-5-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411180302.2678736-5-terry.bowman@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Terry,

kernel test robot noticed the following build errors:

[auto build test ERROR on ca712e47054678c5ce93a0e0f686353ad5561195]

url:    https://github.com/intel-lab-lkp/linux/commits/Terry-Bowman/cxl-pci-Add-RCH-downstream-port-AER-and-RAS-register-discovery/20230412-020957
base:   ca712e47054678c5ce93a0e0f686353ad5561195
patch link:    https://lore.kernel.org/r/20230411180302.2678736-5-terry.bowman%40amd.com
patch subject: [PATCH v3 4/6] cxl/pci: Add RCH downstream port error logging
config: riscv-randconfig-r014-20230410 (https://download.01.org/0day-ci/archive/20230412/202304121055.UceD86D7-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7f1c5cefb1e75bd709dc35c7f5e3e29dd5df65e1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Terry-Bowman/cxl-pci-Add-RCH-downstream-port-AER-and-RAS-register-discovery/20230412-020957
        git checkout 7f1c5cefb1e75bd709dc35c7f5e3e29dd5df65e1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304121055.UceD86D7-lkp@intel.com/

All errors (new ones prefixed by >>):

   riscv64-linux-ld: riscv64-linux-ld: DWARF error: could not find abbrev number 463040
   drivers/cxl/core/pci.o: in function `.L0 ':
   pci.c:(.text+0x1ae2): undefined reference to `cper_print_aer'
>> riscv64-linux-ld: pci.c:(.text+0x1afa): undefined reference to `cper_print_aer'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
