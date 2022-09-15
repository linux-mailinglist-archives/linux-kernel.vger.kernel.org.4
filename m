Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389F15BA25D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 23:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiIOVfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 17:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiIOVex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 17:34:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3506E1EEFD;
        Thu, 15 Sep 2022 14:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663277691; x=1694813691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+xOQJjCjAfBBlD4eU1rtK/BvZIL6XiJTkIajamNFl0M=;
  b=LDB44zzAH5/9vP8D4uk6yGV1Uj+p28/H3OcVnYd1DvEuV/jpjWjR9Aym
   gNO6NzbU6nNSd1hKWgvc40dNFXTBv/F6c2Vf04ri4cBuWrgLKYUU4Zm9E
   Vql7GxHUvp0XgYHhXIa0SPh2JXNDjYCVtCtpowPThqNff7siVyhHtAaTC
   IW0brCyu6EX8YXROsOuM9/4IxvDyhhYJska7rXT+4OD0LktRqX/K0qTpn
   pBnSbS5vqW+izk2exht/vJQ/4iQNEb/K6fg/tMzd7NFkT+r+ezVdAvqKF
   UlQQjMyVmjWuDoSCSHsE6cVHi0D8d9qT5n8Ca5nzBcVK1sZFyAhD9+jwy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="279224780"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="279224780"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 14:34:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="594993849"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Sep 2022 14:34:47 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYwVS-00012t-1r;
        Thu, 15 Sep 2022 21:34:46 +0000
Date:   Fri, 16 Sep 2022 05:33:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>, appanad@amd.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, linux-arm-kernel@lists.infradead.org,
        git@amd.com
Subject: Re: [PATCH v4 2/4] drivers: misc: Add Support for TMR Manager
Message-ID: <202209160529.6bwqp0xx-lkp@intel.com>
References: <20220909061916.2935431-3-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909061916.2935431-3-appana.durga.kedareswara.rao@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Appana,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on soc/for-next linus/master v6.0-rc5]
[cannot apply to char-misc/char-misc-testing xilinx-xlnx/master next-20220915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Appana-Durga-Kedareswara-rao/drivers-misc-Add-support-for-TMR-Manager-and-Inject-IPs/20220909-142639
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/fc425525cf8bef991de7374dd46cb69ed6b67961
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Appana-Durga-Kedareswara-rao/drivers-misc-Add-support-for-TMR-Manager-and-Inject-IPs/20220909-142639
        git checkout fc425525cf8bef991de7374dd46cb69ed6b67961
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager:2: WARNING: Unexpected indentation.

vim +2 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager

   > 2	Date:		Sep 2022
     3	Contact:	appana.durga.kedareswara.rao@amd.com
     4	Description:	This control file provides the fault detection count.
     5			This file cannot be written.
     6			Example:
     7			# cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/errcnt
     8			  1
     9	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
