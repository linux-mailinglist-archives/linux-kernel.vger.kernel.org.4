Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5746EFFC7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 05:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242942AbjD0DUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 23:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242668AbjD0DUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 23:20:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A803C2684;
        Wed, 26 Apr 2023 20:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682565633; x=1714101633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OyXNcul4Z1z505giNdrRSXjTIM440X0mC1Ilj99V4kQ=;
  b=ZybGiqEZKm67wNABmHCOuDuG+7CF0r+d3NOSqa1m6KxCzZZb5CcPDziL
   +4ab6SpVr3bKLHu66bkmDgmd0rWgMJX2GWmOY3nbWsd7EuLLG2E6Xrc1Z
   bT93aiRc+aAV0DOLOJjfHeHju8ON3FnrgpmbUKQIUGJ8wOIUMUhH5y3gO
   8zlYhL6uOB8hvoGPSBamCF6C7URkK2Q3WAICHjeLfFL9J48kHcDDj7zqa
   sdwwTKFIHBlJCIu/AWnEzt5Bbdz1G339xcMCKNWjuxgG/PjscoWzYp6nJ
   Sjk6l5luuDf15DxVM4LXndo72jDXwfZ2DpqoryVQnqQs3nZU/xsb1mvlR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="433594182"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="433594182"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 20:20:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="838192114"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="838192114"
Received: from lkp-server01.sh.intel.com (HELO 848ce1e85e7c) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 26 Apr 2023 20:20:26 -0700
Received: from kbuild by 848ce1e85e7c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prsBF-000015-2g;
        Thu, 27 Apr 2023 03:20:25 +0000
Date:   Thu, 27 Apr 2023 11:20:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     sean.wang@mediatek.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        sean.wang@mediatek.com, chris.lu@mediatek.com,
        Soul.Huang@mediatek.com, Leon.Yen@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, jenhao.yang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        abhishekpandit@google.com, michaelfsun@google.com,
        abhishekpandit@chromium.org, mcchou@chromium.org,
        shawnku@google.com, linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jing Cai <jing.cai@mediatek.com>
Subject: Re: [PATCH v4 3/3] Bluetooth: btusb: mediatek: add MediaTek
 devcoredump support
Message-ID: <202304271131.HetsXcxM-lkp@intel.com>
References: <01d3fe06d3a1e333b193e7d9fbc9cbfb4ee5d02b.1682549719.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01d3fe06d3a1e333b193e7d9fbc9cbfb4ee5d02b.1682549719.git.objelf@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master linus/master v6.3 next-20230426]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/sean-wang-mediatek-com/Bluetooth-btmtk-introduce-btmtk-reset-work/20230427-071054
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/01d3fe06d3a1e333b193e7d9fbc9cbfb4ee5d02b.1682549719.git.objelf%40gmail.com
patch subject: [PATCH v4 3/3] Bluetooth: btusb: mediatek: add MediaTek devcoredump support
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20230427/202304271131.HetsXcxM-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d253c927e94cb7e88bfcd0182449d29e477ca011
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review sean-wang-mediatek-com/Bluetooth-btmtk-introduce-btmtk-reset-work/20230427-071054
        git checkout d253c927e94cb7e88bfcd0182449d29e477ca011
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/bluetooth/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304271131.HetsXcxM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/bluetooth/btmtk.c:104:7: error: use of undeclared identifier 'HCI_DEVCOREDUMP_IDLE'
           case HCI_DEVCOREDUMP_IDLE:
                ^
>> drivers/bluetooth/btmtk.c:107:7: error: use of undeclared identifier 'HCI_DEVCOREDUMP_ACTIVE'; did you mean 'BTMTK_COREDUMP_ACTIVE'?
           case HCI_DEVCOREDUMP_ACTIVE:
                ^~~~~~~~~~~~~~~~~~~~~~
                BTMTK_COREDUMP_ACTIVE
   drivers/bluetooth/btmtk.c:28:2: note: 'BTMTK_COREDUMP_ACTIVE' declared here
           BTMTK_COREDUMP_ACTIVE,
           ^
>> drivers/bluetooth/btmtk.c:110:7: error: use of undeclared identifier 'HCI_DEVCOREDUMP_TIMEOUT'
           case HCI_DEVCOREDUMP_TIMEOUT:
                ^
>> drivers/bluetooth/btmtk.c:111:7: error: use of undeclared identifier 'HCI_DEVCOREDUMP_ABORT'
           case HCI_DEVCOREDUMP_ABORT:
                ^
>> drivers/bluetooth/btmtk.c:112:7: error: use of undeclared identifier 'HCI_DEVCOREDUMP_DONE'
           case HCI_DEVCOREDUMP_DONE:
                ^
>> drivers/bluetooth/btmtk.c:372:2: error: implicit declaration of function 'hci_devcd_register' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           hci_devcd_register(hdev, btmtk_coredump, btmtk_coredump_hdr,
           ^
>> drivers/bluetooth/btmtk.c:389:9: error: implicit declaration of function 'hci_devcd_init' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   err = hci_devcd_init(hdev, MTK_COREDUMP_SIZE);
                         ^
   drivers/bluetooth/btmtk.c:389:9: note: did you mean 'hci_sock_init'?
   include/net/bluetooth/bluetooth.h:577:5: note: 'hci_sock_init' declared here
   int hci_sock_init(void);
       ^
>> drivers/bluetooth/btmtk.c:393:32: error: no member named 'dump' in 'struct hci_dev'
                   schedule_delayed_work(&hdev->dump.dump_timeout,
                                          ~~~~  ^
>> drivers/bluetooth/btmtk.c:398:9: error: implicit declaration of function 'hci_devcd_append' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   err = hci_devcd_append(hdev, skb);
                         ^
   drivers/bluetooth/btmtk.c:398:9: note: did you mean 'hci_dev_open'?
   include/net/bluetooth/hci_core.h:1500:5: note: 'hci_dev_open' declared here
   int hci_dev_open(__u16 dev);
       ^
>> drivers/bluetooth/btmtk.c:405:4: error: implicit declaration of function 'hci_devcd_complete' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           hci_devcd_complete(hdev);
                           ^
   drivers/bluetooth/btmtk.c:405:4: note: did you mean 'hci_devcd_append'?
   drivers/bluetooth/btmtk.c:398:9: note: 'hci_devcd_append' declared here
                   err = hci_devcd_append(hdev, skb);
                         ^
   10 errors generated.


vim +/HCI_DEVCOREDUMP_IDLE +104 drivers/bluetooth/btmtk.c

   100	
   101	static void btmtk_coredump_notify(struct hci_dev *hdev, int state)
   102	{
   103		switch (state) {
 > 104		case HCI_DEVCOREDUMP_IDLE:
   105			coredump_info.state = BTMTK_COREDUMP_INIT;
   106			break;
 > 107		case HCI_DEVCOREDUMP_ACTIVE:
   108			coredump_info.state = BTMTK_COREDUMP_ACTIVE;
   109			break;
 > 110		case HCI_DEVCOREDUMP_TIMEOUT:
 > 111		case HCI_DEVCOREDUMP_ABORT:
 > 112		case HCI_DEVCOREDUMP_DONE:
   113			coredump_info.state = BTMTK_COREDUMP_INIT;
   114			btmtk_reset_sync(coredump_info.hdev);
   115			break;
   116		}
   117	}
   118	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
