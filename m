Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F169E5B5EC0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiILRDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiILRDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:03:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CE22AE03
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663002179; x=1694538179;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6oU0DygDAbO34S5se4NPmjyYSwYVwfQrWPeER41vQzM=;
  b=W89c4BjodK1fJ9oDta8Q9N3RikpROblTOKBxGru32ppxl2chUaKU20q1
   gOQdAxvL80jYxU8JymmflT43Zo83D2qSI24bUWmz31iOHdbEvRBuifWRf
   PuYascobFLxTwnJHuYZD8NrDoYh5m/9dWJHl9gJTSkssOM9qg46cUsuZM
   ofZtZxVGjSF6Td3EOih2eGEXN6d14y6USJGUGJVvgT+/kAJMrKQ3xGW7q
   DCW/ENC3+PJP3YxloxNBoEF/QySc+/OFWWflD7C61U2xH/L6zC9jz1YCJ
   8+u01CjfGSzNBODER6dv+rKTiEWdF4Mp1kd0DB+9ETUT5ioEWMt0R8uv4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="359644963"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="359644963"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 10:02:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="791620822"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Sep 2022 10:02:55 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXmpj-0002g3-0A;
        Mon, 12 Sep 2022 17:02:55 +0000
Date:   Tue, 13 Sep 2022 01:02:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [intel-tdx:guest-attest 5/9] arch/x86/coco/mem.c:27:26: warning:
 function 'virt_to_dma' is not needed and will not be emitted
Message-ID: <202209130117.Ve8dGyqo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-attest
head:   ef90ba1bf9a2aada5e1f9f6c27b5e2bde91a6991
commit: df7603408ff53cb1344704a728ee152672567b94 [5/9] x86/coco: Add cc_decrypted_alloc/free() interfaces
config: x86_64-randconfig-r021-20220912 (https://download.01.org/0day-ci/archive/20220913/202209130117.Ve8dGyqo-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/df7603408ff53cb1344704a728ee152672567b94
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-attest
        git checkout df7603408ff53cb1344704a728ee152672567b94
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/ arch/x86/kernel/ lib/ net/mptcp/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/coco/mem.c:27:26: warning: function 'virt_to_dma' is not needed and will not be emitted [-Wunneeded-internal-declaration]
   static inline dma_addr_t virt_to_dma(void *vaddr)
                            ^
   1 warning generated.


vim +/virt_to_dma +27 arch/x86/coco/mem.c

    26	
  > 27	static inline dma_addr_t virt_to_dma(void *vaddr)
    28	{
    29		return phys_to_dma(&mem_pdev->dev, virt_to_phys(vaddr));
    30	}
    31	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
