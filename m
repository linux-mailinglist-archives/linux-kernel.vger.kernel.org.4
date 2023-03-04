Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE2B6AA993
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 13:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCDMlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 07:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCDMk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 07:40:58 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F71011174;
        Sat,  4 Mar 2023 04:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677933657; x=1709469657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Q4E9z2WW/wNytshCGe+UYgFaKXWgPKBLi18rp/fOzc=;
  b=kDAxZNiFFw0o2Kdi9r4IYF/6LOaYl0fDk3Z8+YWP0emsktLEAEHu8Q8l
   II/ovKENR1Fnu+y5F04q4OlUDK6rRUJkHjpCvgX/Rnnov+7knyjagyAxW
   ZivmQ73FRWWXP0+6vO5epLad3R2r3sKFvVMppLg6dE+75D5yA4Va8dcnw
   JZlCw7oxLdqK01g8laZSXibSVlsyqEJZhrH7vzjwErsFTexeOVoMJONwU
   SRpr6G8zhFQlgntsMYLewrMyw3WJtNnVNZyD0Oe8y+b/hFpn75K9C7k0w
   9tTLQV7IazJhvCBS8+/iCv2vDA71og4APHM9colcCxEe1F+mgIuDHdiYj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="333977019"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="333977019"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2023 04:40:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="739804762"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="739804762"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Mar 2023 04:40:53 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYRC0-0002A2-3C;
        Sat, 04 Mar 2023 12:40:52 +0000
Date:   Sat, 4 Mar 2023 20:40:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eddie James <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc:     oe-kbuild-all@lists.linux.dev, rostedt@goodmis.org,
        linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        alistair@popple.id.au, joel@jms.id.au, jk@ozlabs.org,
        andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: Re: [PATCH v7 4/7] fsi: Add I2C Responder SCOM driver
Message-ID: <202303042033.kC3KNCW2-lkp@intel.com>
References: <20230303170416.1347530-5-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303170416.1347530-5-eajames@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eddie,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.2 next-20230303]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eddie-James/fsi-Move-fsi_slave-structure-definition-to-header/20230304-011530
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230303170416.1347530-5-eajames%40linux.ibm.com
patch subject: [PATCH v7 4/7] fsi: Add I2C Responder SCOM driver
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230304/202303042033.kC3KNCW2-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/36d0c348a48344d2ffef15d5abefe139fc511684
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eddie-James/fsi-Move-fsi_slave-structure-definition-to-header/20230304-011530
        git checkout 36d0c348a48344d2ffef15d5abefe139fc511684
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303042033.kC3KNCW2-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "fsi_master_i2cr_read" [drivers/fsi/i2cr-scom.ko] undefined!
>> ERROR: modpost: "fsi_master_i2cr_write" [drivers/fsi/i2cr-scom.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
