Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4B267FDF7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjA2JsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjA2JsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:48:04 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F02CAD06;
        Sun, 29 Jan 2023 01:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674985683; x=1706521683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TP0zpb9R5uK7bNYIk1uNAfZNOdPTZzcFV0KLQLxMD44=;
  b=SWsROLd/u+9LNZVsf1OO9sEygiHLmaR8hgp2ZRd50izFm4ZV5ypSnA/d
   LRRQUCHSvHmvvrPgpgu6muakoCLrpjAfoVDQUBN8ZVtogDTknVoxYqcKl
   xUbUxWJchIOezgAhG7ItLvjA0nT1sd2Fqu9cNa2bO8+gUmI1mh4JgGjkK
   ngAi1tV7VgD9AgaQReBGugfCSqaa/ECPNQ1BO3/pwc0etJEUAXN3VZ3d8
   DNT580k5tXLiRfpDO2JJEEpF5oc5J4vr18XihNLHgZu4YZMtGTzPTVkXx
   W/hM9xBtSpTVTFUQ6WxpHAfYXbUnAXXqOmmvOysNILxGy5ZOe0sititv+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="315339544"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="315339544"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 01:48:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="641217818"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="641217818"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Jan 2023 01:47:59 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pM4I2-0002gE-2b;
        Sun, 29 Jan 2023 09:47:58 +0000
Date:   Sun, 29 Jan 2023 17:47:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, jdelvare@suse.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] platform/x86: dell-ddv: Add hwmon support
Message-ID: <202301291705.JVYNKBnd-lkp@intel.com>
References: <20230126194021.381092-6-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126194021.381092-6-W_Armin@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Armin,

I love your patch! Yet something to improve:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v6.2-rc5 next-20230127]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Armin-Wolf/platform-x86-dell-ddv-Add-support-for-interface-version-3/20230128-153324
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230126194021.381092-6-W_Armin%40gmx.de
patch subject: [PATCH 5/5] platform/x86: dell-ddv: Add hwmon support
config: i386-randconfig-c021 (https://download.01.org/0day-ci/archive/20230129/202301291705.JVYNKBnd-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/36be415c22eab400b1546b2c5a6737b28e847774
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Armin-Wolf/platform-x86-dell-ddv-Add-support-for-interface-version-3/20230128-153324
        git checkout 36be415c22eab400b1546b2c5a6737b28e847774
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__umoddi3" [drivers/platform/x86/dell/dell-wmi-ddv.ko] undefined!
>> ERROR: modpost: "__udivdi3" [drivers/platform/x86/dell/dell-wmi-ddv.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
