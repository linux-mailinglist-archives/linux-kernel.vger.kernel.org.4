Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58295B8FCB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 22:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiINUxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 16:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiINUxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 16:53:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADF77E30A;
        Wed, 14 Sep 2022 13:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663188797; x=1694724797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2ZBy574VPvpNgyR6nSsCWGAosoLWJlJ1Eve+1ru/t+Y=;
  b=Cj4MZTxgNDVYCiNtI1D/z2UzEjhw+BI4O4xndh2LQaOY+4LOza6KRXCh
   RAbEdG4rJ8gGqFV7SxCOBVr60F2gMQmCrN/LIkbH0mTu71gmsNUsx/7VQ
   KCPdiGuAzBJYPeMeMe1kIJcQU+ZoFv4Vr/am3PenxT2RKMQHw+pHY3yXJ
   qdSm/8/bjM/IG7LAFXJ6lrpGPeJ9Y/e27/Ac4mTL6rh6zv7V3vSQu3jQr
   TdT+Re+ucbPi7uRQTJQKb3aQxDjv83jlH/Vyorwkwn0zoRMK1YEf0G+D6
   F6xom0qB+GHzRR5TFTILTTOzlCCb75U2fmfyL4bxIdWN7Uw1eYR9gHbtL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="298536608"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="298536608"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 13:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="685450350"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 14 Sep 2022 13:53:02 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYZNV-0000ZE-2b;
        Wed, 14 Sep 2022 20:53:01 +0000
Date:   Thu, 15 Sep 2022 04:52:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     wen.ping.teh@intel.com, Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Teh Wen Ping <wen.ping.teh@intel.com>
Subject: Re: [PATCH 1/2] crypto: intel-fcs: crypto service driver for Intel
 SoCFPGA family
Message-ID: <202209150451.PQ7ojJzq-lkp@intel.com>
References: <20220914144320.605421-1-wen.ping.teh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914144320.605421-1-wen.ping.teh@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on herbert-cryptodev-2.6/master]
[also build test ERROR on herbert-crypto-2.6/master arm64/for-next/core linus/master v6.0-rc5 next-20220914]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/wen-ping-teh-intel-com/crypto-intel-fcs-Add-crypto-service-driver-for-Intel-SoCFPGA/20220914-224700
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220915/202209150451.PQ7ojJzq-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4cdd20e357a4c52a9479852d5464147100813280
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review wen-ping-teh-intel-com/crypto-intel-fcs-Add-crypto-service-driver-for-Intel-SoCFPGA/20220914-224700
        git checkout 4cdd20e357a4c52a9479852d5464147100813280
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/intel_fcs-ioctl.h:40:2: error: unknown type name 'uint32_t'
           uint32_t test_bit:1;
           ^
   ./usr/include/linux/intel_fcs-ioctl.h:41:2: error: unknown type name 'uint32_t'
           uint32_t rsvd:31;
           ^
   ./usr/include/linux/intel_fcs-ioctl.h:56:2: error: unknown type name 'uint32_t'
           uint32_t size;
           ^
   ./usr/include/linux/intel_fcs-ioctl.h:66:2: error: unknown type name 'uint32_t'
           uint32_t size;
           ^
   ./usr/include/linux/intel_fcs-ioctl.h:79:2: error: unknown type name 'uint32_t'
           uint32_t size;
           ^
   ./usr/include/linux/intel_fcs-ioctl.h:80:2: error: unknown type name 'uint32_t'
           uint32_t c_status;
           ^
   ./usr/include/linux/intel_fcs-ioctl.h:92:2: error: unknown type name 'uint32_t'
           uint32_t src_size;
           ^
   ./usr/include/linux/intel_fcs-ioctl.h:94:2: error: unknown type name 'uint32_t'
           uint32_t dst_size;
           ^
   ./usr/include/linux/intel_fcs-ioctl.h:106:2: error: unknown type name 'uint32_t'
           uint32_t src_size;
           ^
   ./usr/include/linux/intel_fcs-ioctl.h:108:2: error: unknown type name 'uint32_t'
           uint32_t dst_size;
           ^
   ./usr/include/linux/intel_fcs-ioctl.h:116:2: error: unknown type name 'uint32_t'
           uint32_t rndm[8];
           ^
   11 errors generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
