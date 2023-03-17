Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6594C6BE7D9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCQLTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCQLTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:19:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D94174A50;
        Fri, 17 Mar 2023 04:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679051953; x=1710587953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BogjoccFnwVrv9FtmKAxV8trPOCdTbXwTwMNUPfBhuY=;
  b=J0IgE0UmPDYIdmO4RHingUIQKrs7E7rjo6V0xBR38AzBarQUIIPcFA1N
   JaIuTYdU/tT/dXZA5T7zHfWwgzWaw6ezynm/vS1gH8aGle0yXmBTYN44a
   7GpHUzTQ82JXlHNxNVnn454VcYzu9bsT7AKDzTFI8UBfLIZsY2XN0MMIk
   DZ09a74RgImFYrlDtDzkPr2VKV1jVG2foasllOA5fBsfIzjD7oaTgwcqM
   pLgs0HhP3PM21K97SEZFC7rmIS+7X3fCvqlfg2ZsZ/W5OlWzczEFumv4G
   yxeE+MDor5QALjMSyRZ2WaHa5veTFZ9CbwRCqWYjT05QsS5GtYlW14+b3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="326599044"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="326599044"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 04:19:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="630258038"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="630258038"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2023 04:19:06 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pd86z-0009Jm-28;
        Fri, 17 Mar 2023 11:19:05 +0000
Date:   Fri, 17 Mar 2023 19:18:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_c_skakit@quicinc.com,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: Re: [PATCH 2/3] leds: rgb: leds-qcom-lpg: Add support for high
 resolution PWM
Message-ID: <202303171848.oTjlkAvF-lkp@intel.com>
References: <20230316192134.26436-3-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316192134.26436-3-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anjelique,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on lee-leds/for-leds-next]
[also build test ERROR on robh/for-next pavel-leds/for-next linus/master v6.3-rc2 next-20230317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anjelique-Melendez/dt-bindings-leds-qcom-lpg-Add-qcom-pmk8550-pwm-compatible-string/20230317-032340
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
patch link:    https://lore.kernel.org/r/20230316192134.26436-3-quic_amelende%40quicinc.com
patch subject: [PATCH 2/3] leds: rgb: leds-qcom-lpg: Add support for high resolution PWM
config: parisc-randconfig-r014-20230312 (https://download.01.org/0day-ci/archive/20230317/202303171848.oTjlkAvF-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/916dd0b271b3f035efd07efdaa696e7c815f7e6c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anjelique-Melendez/dt-bindings-leds-qcom-lpg-Add-qcom-pmk8550-pwm-compatible-string/20230317-032340
        git checkout 916dd0b271b3f035efd07efdaa696e7c815f7e6c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303171848.oTjlkAvF-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__udivdi3" [drivers/leds/rgb/leds-qcom-lpg.ko] undefined!
>> ERROR: modpost: "__divdi3" [drivers/leds/rgb/leds-qcom-lpg.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
