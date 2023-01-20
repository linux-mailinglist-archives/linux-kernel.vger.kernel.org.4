Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ACC67619F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 00:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjATXek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 18:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjATXei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 18:34:38 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01957ED56;
        Fri, 20 Jan 2023 15:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674257676; x=1705793676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ekt4X4xR1TAIasVRR9OHuNebiCvC80dSkNaTSp9S32E=;
  b=IoU/V4IstOBvaGOyFLypl4QDQQFUbP40evXobSfbwhpZtLHaZ2nWy3So
   nJu7KgVJkf9wxsta14ilICcns+YHwYFFjVaziSrgBaRokqB+T0nUIYTEY
   moNh8AFYTrn1zNngLL5/ZW7Lb52OJj5Kae28KqI8VQaWuzSfHm4RS9FRN
   KNToyq6NduMoRw7YBNkujDuFoIb0akTjUJ46/2yLOSyIMzs8cmd5cPxHS
   2ZiO2K5e2t+9g/Vm2Sj3NnTZz+Shd581tjeGqNCc+uLB5NAVN/Im13FyV
   AbM5Q16d731eihZHP/gVymqAoJr1UU5SYUDy/7K7YbFslSpxbnLiUz2pd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="313613673"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="313613673"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 15:34:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="749525893"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="749525893"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jan 2023 15:34:32 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJ0tz-00036K-2C;
        Fri, 20 Jan 2023 23:34:31 +0000
Date:   Sat, 21 Jan 2023 07:34:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eddie James <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH 2/2] fsi: Add IBM I2C Responder virtual FSI master
Message-ID: <202301210758.mY8JSNOf-lkp@intel.com>
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
config: arm-randconfig-c002-20230120 (https://download.01.org/0day-ci/archive/20230121/202301210758.mY8JSNOf-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/1312ba80b81ef02457d213ee6bc6ee80739c3e01
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eddie-James/dt-bindings-fsi-Document-the-IBM-I2C-Responder-virtual-FSI-master/20230120-014831
        git checkout 1312ba80b81ef02457d213ee6bc6ee80739c3e01
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/fsi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/fsi/fsi-master-i2cr.c:214:12: error: incompatible function pointer types initializing 'void (*)(struct i2c_client *)' with an expression of type 'int (struct i2c_client *)' [-Wincompatible-function-pointer-types]
           .remove = i2cr_remove,
                     ^~~~~~~~~~~
   1 error generated.


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
