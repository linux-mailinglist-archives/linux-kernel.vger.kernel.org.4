Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DBB5B988F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 12:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiIOKL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 06:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiIOKLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:11:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9373402D1;
        Thu, 15 Sep 2022 03:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663236714; x=1694772714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9pV9/hSeLiF6NvcT3SLriBKTjof61GiqelolE5VGU3c=;
  b=HSkgdbqs39zUb4c9c85hVSh/9SW5hjuYygwOnHtlPa9F5FOSpXZcR8q0
   73nF9ruz0RFe86//0E9TcqiMkdEkj03A5Y8PPCvlncczpwi6IgfkB511f
   E46kLOdKgd15WujQRNGerkr03EQQec3hbGAyeBYsAknh+PInhujFjfkIw
   SHUtxBSPf/xG3ezulyhNzpmeTHjciofX9ot31l9jIw2Rp66YbUXOSJMC4
   nyVugZdcvKovGUCxyMDIC1kiI3hJfC+NJwFvP3xkgi3eaevZ3W/VCYfB2
   rPnwzuBHLQT9d5mQMjqqd87AKv6QbvBKl6wOJHg2YOQz9qDhyjsZIG6ls
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="362632719"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="362632719"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 03:11:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="945892694"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 15 Sep 2022 03:11:51 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYlqZ-0000Lx-0n;
        Thu, 15 Sep 2022 10:11:51 +0000
Date:   Thu, 15 Sep 2022 18:11:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     wen.ping.teh@intel.com, Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     kbuild-all@lists.01.org, Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Teh Wen Ping <wen.ping.teh@intel.com>
Subject: Re: [PATCH 1/2] crypto: intel-fcs: crypto service driver for Intel
 SoCFPGA family
Message-ID: <202209151738.j2RLe6VA-lkp@intel.com>
References: <20220914144320.605421-1-wen.ping.teh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914144320.605421-1-wen.ping.teh@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220915/202209151738.j2RLe6VA-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/4cdd20e357a4c52a9479852d5464147100813280
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review wen-ping-teh-intel-com/crypto-intel-fcs-Add-crypto-service-driver-for-Intel-SoCFPGA/20220914-224700
        git checkout 4cdd20e357a4c52a9479852d5464147100813280
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/intel_fcs-ioctl.h:40:9: error: unknown type name 'uint32_t'
      40 |         uint32_t test_bit:1;
         |         ^~~~~~~~
   ./usr/include/linux/intel_fcs-ioctl.h:41:9: error: unknown type name 'uint32_t'
      41 |         uint32_t rsvd:31;
         |         ^~~~~~~~
   ./usr/include/linux/intel_fcs-ioctl.h:56:9: error: unknown type name 'uint32_t'
      56 |         uint32_t size;
         |         ^~~~~~~~
   ./usr/include/linux/intel_fcs-ioctl.h:66:9: error: unknown type name 'uint32_t'
      66 |         uint32_t size;
         |         ^~~~~~~~
   ./usr/include/linux/intel_fcs-ioctl.h:79:9: error: unknown type name 'uint32_t'
      79 |         uint32_t size;
         |         ^~~~~~~~
   ./usr/include/linux/intel_fcs-ioctl.h:80:9: error: unknown type name 'uint32_t'
      80 |         uint32_t c_status;
         |         ^~~~~~~~
   ./usr/include/linux/intel_fcs-ioctl.h:92:9: error: unknown type name 'uint32_t'
      92 |         uint32_t src_size;
         |         ^~~~~~~~
   ./usr/include/linux/intel_fcs-ioctl.h:94:9: error: unknown type name 'uint32_t'
      94 |         uint32_t dst_size;
         |         ^~~~~~~~
   ./usr/include/linux/intel_fcs-ioctl.h:106:9: error: unknown type name 'uint32_t'
     106 |         uint32_t src_size;
         |         ^~~~~~~~
   ./usr/include/linux/intel_fcs-ioctl.h:108:9: error: unknown type name 'uint32_t'
     108 |         uint32_t dst_size;
         |         ^~~~~~~~
   ./usr/include/linux/intel_fcs-ioctl.h:116:9: error: unknown type name 'uint32_t'
     116 |         uint32_t rndm[8];
         |         ^~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
