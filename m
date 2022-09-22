Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660615E7059
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 01:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiIVXy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 19:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIVXyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 19:54:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C77760C0;
        Thu, 22 Sep 2022 16:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663890892; x=1695426892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c2Fh1kRyIqO7dwRAaAYPKGtKnMyK0YH7bX5IoC7jEd0=;
  b=T/lPzpJEoEdxDGzfK1bp3cm3xMkBfqo+VAsTxSrmUbvhRbsubcjqGgYK
   Qht67PdbO9MaRZudDbQDouW7e8V27w1RfYwmXtJRByzC7p4z+BZvHjVhe
   UIR8hzB6rBx9tJ3MNMTp/ScxR4W5bg6ekBHtymawlVscjLm8GJLbfcu+e
   oCIR6k93c2O5BgFp8KlY3krlls77y9Z2gcdn8osH9UkP+bVHWeIbV5QVn
   ii9rfFRmB5L/o1XPIb1fTT4F8pIjdGYM2qZoCBWSWKtjuXxGUjMN5Wbrv
   xHsMdfQVOJheZHh+4fIiwiYUFCMrWObJLQMZ5D/GuaPlMCTw41a0d+TpR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="364477843"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="364477843"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 16:54:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="571180350"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Sep 2022 16:54:48 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obW1n-00056G-1I;
        Thu, 22 Sep 2022 23:54:47 +0000
Date:   Fri, 23 Sep 2022 07:54:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     hildawu@realtek.com, marcel@holtmann.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        mmandlik@google.com, max.chou@realtek.com, alex_lu@realsil.com.cn,
        kidman@realtek.com
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek devcoredump support
Message-ID: <202209230749.lLf1xA67-lkp@intel.com>
References: <20220922103337.26167-1-hildawu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922103337.26167-1-hildawu@realtek.com>
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

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master linus/master v6.0-rc6 next-20220921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/hildawu-realtek-com/Bluetooth-btusb-Add-Realtek-devcoredump-support/20220922-183533
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
config: hexagon-randconfig-r023-20220922 (https://download.01.org/0day-ci/archive/20220923/202209230749.lLf1xA67-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b896c161a197fbcb019f6e4f890b667bb9d6f15e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review hildawu-realtek-com/Bluetooth-btusb-Add-Realtek-devcoredump-support/20220922-183533
        git checkout b896c161a197fbcb019f6e4f890b667bb9d6f15e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/bluetooth/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/bluetooth/btrtl.c:657:8: error: call to undeclared function 'hci_devcoredump_register'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           err = hci_devcoredump_register(hdev, btrtl_coredump, btrtl_dmp_hdr,
                 ^
   1 error generated.


vim +/hci_devcoredump_register +657 drivers/bluetooth/btrtl.c

   652	
   653	static int btrtl_register_devcoredump_support(struct hci_dev *hdev)
   654	{
   655		int err;
   656	
 > 657		err = hci_devcoredump_register(hdev, btrtl_coredump, btrtl_dmp_hdr,
   658					       NULL);
   659	
   660		return err;
   661	}
   662	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
