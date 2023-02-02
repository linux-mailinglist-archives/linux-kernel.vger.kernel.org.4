Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736BF688AB3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjBBXXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjBBXXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:23:04 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B186A5BA8;
        Thu,  2 Feb 2023 15:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675380182; x=1706916182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bn6l3TxTIC/CqdrEgmBOI9ZWD5WN5Blzw4xC/dDljDU=;
  b=mo7SIiuZjuJ6avi+67Gm5EXkL1WImd98ih1TtOezlfLIdLpLvmC1E/5m
   1cyaXa6rgCYLdb3vqKxpm/1560Ngs4hKuSx85uPQ/Z46Z9orPmq6/cPdV
   mcb6R5lK7i6huRnJ7av76McbmFdkuXxUBe2Ajh7np+Qd0aqoptrOTbCGt
   49uiC/gUqoeZd8onMo9j34dYv0dlMkTG+GPEI4/jkOku/IxPRUEbzFv7f
   k0NvNLAV1a5/kVK5X3YBrh/I7XPcok+Ow1H5Ea/vje5nG3yLZTMbTxzwJ
   85PdZKdV40DLhJL6kY3hF8Y7ZI4RAjxQdM1CD7Mkl1Xr+r6MCQf7Vv5P8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="355939761"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="355939761"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 15:23:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="643076420"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="643076420"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Feb 2023 15:22:55 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNius-0006wa-2r;
        Thu, 02 Feb 2023 23:22:54 +0000
Date:   Fri, 3 Feb 2023 07:22:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frieder Schrempf <frieder@fris.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH 4/7] rtc: Move BSM defines to separate header for DT usage
Message-ID: <202302030706.gBkl14ay-lkp@intel.com>
References: <20230201143431.863784-5-frieder@fris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201143431.863784-5-frieder@fris.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on arm/for-next arm/fixes arm64/for-next/core kvmarm/next rockchip/for-next shawnguo/for-next soc/for-next xilinx-xlnx/master linus/master v6.2-rc6]
[cannot apply to abelloni/rtc-next next-20230202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frieder-Schrempf/dt-bindings-rtc-Move-RV3028-to-separate-binding-file/20230201-224450
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230201143431.863784-5-frieder%40fris.de
patch subject: [PATCH 4/7] rtc: Move BSM defines to separate header for DT usage
config: x86_64-randconfig-a004 (https://download.01.org/0day-ci/archive/20230203/202302030706.gBkl14ay-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/2dfe054992e73c8da87d242a35a30d969d87b1a0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Frieder-Schrempf/dt-bindings-rtc-Move-RV3028-to-separate-binding-file/20230201-224450
        git checkout 2dfe054992e73c8da87d242a35a30d969d87b1a0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/rtc.h:15:10: fatal error: dt-bindings/rtc/rtc.h: No such file or directory
      15 | #include <dt-bindings/rtc/rtc.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
