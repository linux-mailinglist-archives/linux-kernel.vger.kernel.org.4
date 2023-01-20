Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF626752B0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 11:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjATKmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 05:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjATKmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:42:05 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529FC9F066;
        Fri, 20 Jan 2023 02:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674211324; x=1705747324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KjAJNdB4r0BTPWLTiUzL9NiPfK6hXrT8oe/9QKTK4+E=;
  b=kDE2I1xdqY9Q7G7Xz3Xss1HwCZd/+FmL6ubMbnBCrJsYlbZO6lHdaTqD
   mEw43QuMBphh7IGUtcjas4zxBYmcegLISnBqm06uiMGrKWhXmthyKa29h
   AXQiKfPLdjT1kHZblNVjZZjO/c8jtJAkeSVzvVLIkRs1/jw6Caxr4a73q
   hnVbpqf3Dt503bVpXa778tesfCzKPzIvym7F2jjECmMWkD2CsClp8s0+p
   tyGVLbyTGHR1py9G25OkWwUhiF66FIXc/B8Vv25BSnwqRkH8YbSNz61ux
   087cFYC7MMsW3w0sD8HgXh4C6uTDcsufDAjxcEg4EPimtpXHQ7KlNTWPE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="352805960"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="352805960"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 02:42:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="638120108"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="638120108"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Jan 2023 02:42:01 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIoqJ-0002Tk-1o;
        Fri, 20 Jan 2023 10:41:55 +0000
Date:   Fri, 20 Jan 2023 18:41:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eddie James <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH 2/2] fsi: Add IBM I2C Responder virtual FSI master
Message-ID: <202301201849.I88UJen6-lkp@intel.com>
References: <20230119174714.1486042-3-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119174714.1486042-3-eajames@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eddie,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.2-rc4 next-20230120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eddie-James/dt-bindings-fsi-Document-the-IBM-I2C-Responder-virtual-FSI-master/20230120-014831
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230119174714.1486042-3-eajames%40linux.ibm.com
patch subject: [PATCH 2/2] fsi: Add IBM I2C Responder virtual FSI master
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230120/202301201849.I88UJen6-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1312ba80b81ef02457d213ee6bc6ee80739c3e01
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eddie-James/dt-bindings-fsi-Document-the-IBM-I2C-Responder-virtual-FSI-master/20230120-014831
        git checkout 1312ba80b81ef02457d213ee6bc6ee80739c3e01
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/fsi/fsi-master-i2cr.c:214:19: error: initialization of 'void (*)(struct i2c_client *)' from incompatible pointer type 'int (*)(struct i2c_client *)' [-Werror=incompatible-pointer-types]
     214 |         .remove = i2cr_remove,
         |                   ^~~~~~~~~~~
   drivers/fsi/fsi-master-i2cr.c:214:19: note: (near initialization for 'i2cr_driver.remove')
   cc1: some warnings being treated as errors


vim +214 drivers/fsi/fsi-master-i2cr.c

   211	
   212	static struct i2c_driver i2cr_driver = {
   213		.probe_new = i2cr_probe,
 > 214		.remove = i2cr_remove,
   215		.driver = {
   216			.name = "i2cr",
   217			.of_match_table = i2cr_i2c_ids,
   218		},
   219	};
   220	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
