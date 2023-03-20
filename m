Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728FD6C21DC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjCTTqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCTTqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:46:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A6C59C3;
        Mon, 20 Mar 2023 12:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679341439; x=1710877439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dip+6PljFbundS7RPhSnG8yoBMGZR6fzHvXGxG0Cl2U=;
  b=AGzl7P4LDBbX5prZxsvPlmn7IG56eTSbe43RG+VXt2yt7qw9LmypXbRh
   QI9+gsIQededz4nJgrk0VxSbVcEnWjSv4RQaWr0a5nK2xwdlWZqYX2gfK
   Z61fwhDD1MqqVekyF+oI7JJk+jpgsdBBuvx4TDW5NcBlbmjmm1Gncy5RG
   4/AMceA0N76movCnull+LWw9g534GE+EjbB+UlFSOshO5St9pR1iCaSgx
   h11zwsKiacKw/vo5yun2Ki//7hwRdr0ULE9GgajFpf9FEkKi5ERfEUJ0c
   hXMXUd21+CVAPSAedneNMfsckLurl8nDoAkkK/PqU6AhNTYBu0ATUZBj3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="341123464"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="341123464"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 12:43:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="770317731"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="770317731"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Mar 2023 12:43:56 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peLQB-000BGs-0J;
        Mon, 20 Mar 2023 19:43:55 +0000
Date:   Tue, 21 Mar 2023 03:42:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>, robh+dt@kernel.org,
        linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: Re: [PATCH v2 3/5] hwmon: (pmbus/acbel-crps) Add Acbel CRPS power
 supply driver
Message-ID: <202303210322.ZZ2VlGIE-lkp@intel.com>
References: <20230320154019.1943770-4-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320154019.1943770-4-lakshmiy@us.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lakshmi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on robh/for-next linus/master v6.3-rc3 next-20230320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lakshmi-Yadlapati/dt-bindings-vendor-prefixes-Add-prefix-for-acbel/20230320-235222
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230320154019.1943770-4-lakshmiy%40us.ibm.com
patch subject: [PATCH v2 3/5] hwmon: (pmbus/acbel-crps) Add Acbel CRPS power supply driver
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230321/202303210322.ZZ2VlGIE-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/d873cbdc9f171b066c3f6f6c2a39736e168ad19f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lakshmi-Yadlapati/dt-bindings-vendor-prefixes-Add-prefix-for-acbel/20230320-235222
        git checkout d873cbdc9f171b066c3f6f6c2a39736e168ad19f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hwmon/pmbus/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303210322.ZZ2VlGIE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwmon/pmbus/acbel-crps.c:24:37: warning: 'acbel_crps_fops' defined but not used [-Wunused-const-variable=]
      24 | static const struct file_operations acbel_crps_fops = {
         |                                     ^~~~~~~~~~~~~~~


vim +/acbel_crps_fops +24 drivers/hwmon/pmbus/acbel-crps.c

    23	
  > 24	static const struct file_operations acbel_crps_fops = {
    25		.llseek = noop_llseek,
    26		.open = simple_open,
    27	};
    28	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
