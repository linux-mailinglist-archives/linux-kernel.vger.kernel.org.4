Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9300B5BE427
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiITLLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiITLKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:10:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F64FBC8E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663672241; x=1695208241;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6xRufgAOPeHl07DR4DHjGbYt8F/8YiY/XrFzHNzT8FQ=;
  b=R/S1kBm1xJ8BB82gu2At1SdIa4jwKwj/rI/1Sm+5BDP+XnSuZEdWees8
   QgzC+GKXY0s13RwHru9ceLpr91mijwfYZo7n4lIaml/L3cF6C7EJJwrtM
   UCenlq+x990ajSYWItrjPc/+2nM4QX1FJQsC7a9Mw2CqnPMN4Eq9yx62y
   ywpQ0ATB/W6BxAivV6VcHA46rxmA7IjAnBdEBPJHvZRaH7xUCL2aZaJrX
   V6XiLexEIbjx/f+6Jj7E4aG4r7NYlk5ZWaCYei+Oal+FzZHtBdIq1IPCs
   1RSjFYrQ2hsHQ3k/BiJDT+ndD7t7w3yPx8VidgeUCXlWVjbDuF1pZtECk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="300484621"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="300484621"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 04:10:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="618873529"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Sep 2022 04:10:36 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oab99-0002iB-0T;
        Tue, 20 Sep 2022 11:10:35 +0000
Date:   Tue, 20 Sep 2022 19:09:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/vdso 3/3]
 include/vdso/processor.h:10:10: fatal error: 'asm/vdso/processor.h' file not
 found
Message-ID: <202209201951.cz31hRjJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/vdso
head:   a7b31acb923dbd25e7bf030ca209f131c31f5288
commit: a7b31acb923dbd25e7bf030ca209f131c31f5288 [3/3] random: implement getrandom() in vDSO
config: hexagon-randconfig-r045-20220919 (https://download.01.org/0day-ci/archive/20220920/202209201951.cz31hRjJ-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/a7b31acb923dbd25e7bf030ca209f131c31f5288
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/vdso
        git checkout a7b31acb923dbd25e7bf030ca209f131c31f5288
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/char/ drivers/iommu/ mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/char/random.c:64:
   In file included from include/vdso/datapage.h:17:
>> include/vdso/processor.h:10:10: fatal error: 'asm/vdso/processor.h' file not found
   #include <asm/vdso/processor.h>
            ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +10 include/vdso/processor.h

d8bb6993d871f5 Vincenzo Frascino 2020-03-20   9  
d8bb6993d871f5 Vincenzo Frascino 2020-03-20 @10  #include <asm/vdso/processor.h>
d8bb6993d871f5 Vincenzo Frascino 2020-03-20  11  

:::::: The code at line 10 was first introduced by commit
:::::: d8bb6993d871f5d3cd6d65d3772e4b1f4ef17380 common: Introduce processor.h

:::::: TO: Vincenzo Frascino <vincenzo.frascino@arm.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
