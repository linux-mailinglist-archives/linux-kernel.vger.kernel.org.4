Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5758B68E213
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 21:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBGUnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 15:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBGUng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 15:43:36 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8576E98;
        Tue,  7 Feb 2023 12:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675802615; x=1707338615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LGMTUCV6l/iT3A7JdzQEA4khN4yhKfcPeFoiLiMB1Xw=;
  b=SsJ+CdcAXC2Jx6GaSbXC9IMUWKKKCEMhW9gskKaedjl1EEPKY306uQvA
   Y7DaLWM40GaR/hLEPh+pBdwdJlSdDi3ssSiSYUbbqiPL8T1AHYUL4jqqJ
   WWJeJXLO2IyvWhUk44H/FTahhmu2a/2mrYXlsXcM7HDUo5NMBfF9oPS+/
   oUDtV5phisaOxmNascvwTAv7z7KqJPw2jEqJCHtfFLb3gXzqeRTaNtPgA
   86aH/pmlYS5toz3Zvzaf102P2lQfmLetTawYCLhx5HXx4JhPNuKjcwWEb
   h2LHoYb2j0USeAnOBKm2ldfeBeCQi3bZJJzHnxRhL/pcQyOZjk1i7W4FV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="330913843"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="330913843"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 12:43:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="644589173"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="644589173"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Feb 2023 12:43:32 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPUoN-0003sY-2I;
        Tue, 07 Feb 2023 20:43:31 +0000
Date:   Wed, 8 Feb 2023 04:42:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     tumic@gpxsee.org, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lizhi Hou <lizhi.hou@amd.com>,
        Martin =?utf-8?B?VMWvbWE=?= <martin.tuma@digiteqautomotive.com>
Subject: Re: [PATCH RESEND v5 1/1] Added Digiteq Automotive MGB4 driver
Message-ID: <202302080423.3mOPztPU-lkp@intel.com>
References: <20230207150119.5542-2-tumic@gpxsee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207150119.5542-2-tumic@gpxsee.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on sailus-media-tree/streams]
[also build test ERROR on linus/master v6.2-rc7]
[cannot apply to media-tree/master next-20230207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/tumic-gpxsee-org/Added-Digiteq-Automotive-MGB4-driver/20230207-210120
base:   git://linuxtv.org/sailus/media_tree.git streams
patch link:    https://lore.kernel.org/r/20230207150119.5542-2-tumic%40gpxsee.org
patch subject: [PATCH RESEND v5 1/1] Added Digiteq Automotive MGB4 driver
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20230208/202302080423.3mOPztPU-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ece664ba09047f289e8573fc17738d5eb29c265a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review tumic-gpxsee-org/Added-Digiteq-Automotive-MGB4-driver/20230207-210120
        git checkout ece664ba09047f289e8573fc17738d5eb29c265a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/media/pci/mgb4/mgb4_trigger.c:19:10: fatal error: linux/dma/amd_xdma.h: No such file or directory
      19 | #include <linux/dma/amd_xdma.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
>> drivers/media/pci/mgb4/mgb4_core.c:29:10: fatal error: linux/dma/amd_xdma.h: No such file or directory
      29 | #include <linux/dma/amd_xdma.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
>> drivers/media/pci/mgb4/mgb4_vin.c:24:10: fatal error: linux/dma/amd_xdma.h: No such file or directory
      24 | #include <linux/dma/amd_xdma.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
>> drivers/media/pci/mgb4/mgb4_vout.c:17:10: fatal error: linux/dma/amd_xdma.h: No such file or directory
      17 | #include <linux/dma/amd_xdma.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +19 drivers/media/pci/mgb4/mgb4_trigger.c

  > 19	#include <linux/dma/amd_xdma.h>
    20	#include "mgb4_core.h"
    21	#include "mgb4_trigger.h"
    22	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
