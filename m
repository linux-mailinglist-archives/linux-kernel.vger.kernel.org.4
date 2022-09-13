Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1455B67ED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiIMGaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiIMG36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:29:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C637F101D1;
        Mon, 12 Sep 2022 23:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663050596; x=1694586596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ikP/DswIzxgBJQ51v92pm0x/nKKPwvvC69In5vmplKA=;
  b=Jco+LU9TFnbsFXQdO9zPu2TTF9I7vwEtrEq1tCcjsff5Y3SyAtFZhWF1
   kbPqpbGMMT2/6XnFcAx/buxpipJbIzPKxRSJMjrOY/J/EuA5OHrb58iH5
   OllXNd02FCEUX/jH0kGhecLOUkz2e1EWpsPND4AxDlbFZS22HBgDIyNGQ
   uLNUxxVFEMUdCg8EkHtFt954umYyhtA/2Wgjp6lNSTUq+Bur1cIyx5P+t
   Dc65KoSi+ttqBJiAoBeUbL84EZIKv0yhsXttesBMSuTl+tShcKIRaUoSo
   oCVwVCkS4mUGOHZLj6t8RVfBkc5zoLiya/LAOyyLI7ulUWTYp1eg794PB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="296786595"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="296786595"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 23:29:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="684733613"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 12 Sep 2022 23:29:49 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXzQa-0003JY-2i;
        Tue, 13 Sep 2022 06:29:48 +0000
Date:   Tue, 13 Sep 2022 14:29:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     sean.wang@mediatek.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     kbuild-all@lists.01.org, sean.wang@mediatek.com,
        Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        abhishekpandit@google.com, michaelfsun@google.com,
        abhishekpandit@chromium.org, mcchou@chromium.org,
        shawnku@google.com, linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jing Cai <jing.cai@mediatek.com>
Subject: Re: [PATCH 4/4] Bluetooth: btusb: mediatek: add MediaTek devcoredump
 support
Message-ID: <202209131404.9rjV6blJ-lkp@intel.com>
References: <540fc6d93481e72e18b51f82f022ab34d57d5caa.1663020936.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <540fc6d93481e72e18b51f82f022ab34d57d5caa.1663020936.git.objelf@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master linus/master v6.0-rc5 next-20220912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/sean-wang-mediatek-com/Bluetooth-btusb-mediatek-use-readx_poll_timeout-instead-of-open-coding/20220913-062200
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
config: arc-randconfig-r043-20220912 (https://download.01.org/0day-ci/archive/20220913/202209131404.9rjV6blJ-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d478461e2fd5fdd8d505c00c7864a421170a54bb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review sean-wang-mediatek-com/Bluetooth-btusb-mediatek-use-readx_poll_timeout-instead-of-open-coding/20220913-062200
        git checkout d478461e2fd5fdd8d505c00c7864a421170a54bb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/bluetooth/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/bluetooth/btmtk.c: In function 'btmtk_coredump_notify':
>> drivers/bluetooth/btmtk.c:111:14: error: 'HCI_DEVCOREDUMP_ACTIVE' undeclared (first use in this function); did you mean 'BTMTK_COREDUMP_ACTIVE'?
     111 |         case HCI_DEVCOREDUMP_ACTIVE:
         |              ^~~~~~~~~~~~~~~~~~~~~~
         |              BTMTK_COREDUMP_ACTIVE
   drivers/bluetooth/btmtk.c:111:14: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/bluetooth/btmtk.c:114:14: error: 'HCI_DEVCOREDUMP_TIMEOUT' undeclared (first use in this function); did you mean 'HCI_LE_CONN_TIMEOUT'?
     114 |         case HCI_DEVCOREDUMP_TIMEOUT:
         |              ^~~~~~~~~~~~~~~~~~~~~~~
         |              HCI_LE_CONN_TIMEOUT
>> drivers/bluetooth/btmtk.c:115:14: error: 'HCI_DEVCOREDUMP_ABORT' undeclared (first use in this function)
     115 |         case HCI_DEVCOREDUMP_ABORT:
         |              ^~~~~~~~~~~~~~~~~~~~~
>> drivers/bluetooth/btmtk.c:116:14: error: 'HCI_DEVCOREDUMP_DONE' undeclared (first use in this function)
     116 |         case HCI_DEVCOREDUMP_DONE:
         |              ^~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btmtk.c: In function 'btmtk_register_coredump':
>> drivers/bluetooth/btmtk.c:376:9: error: implicit declaration of function 'hci_devcoredump_register' [-Werror=implicit-function-declaration]
     376 |         hci_devcoredump_register(hdev, btmtk_coredump, btmtk_coredump_hdr,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btmtk.c: In function 'btmtk_process_coredump':
>> drivers/bluetooth/btmtk.c:393:23: error: implicit declaration of function 'hci_devcoredump_init' [-Werror=implicit-function-declaration]
     393 |                 err = hci_devcoredump_init(hdev, 1024000);
         |                       ^~~~~~~~~~~~~~~~~~~~
>> drivers/bluetooth/btmtk.c:397:44: error: 'struct hci_dev' has no member named 'dump'
     397 |                 schedule_delayed_work(&hdev->dump.dump_timeout,
         |                                            ^~
>> drivers/bluetooth/btmtk.c:402:23: error: implicit declaration of function 'hci_devcoredump_append' [-Werror=implicit-function-declaration]
     402 |                 err = hci_devcoredump_append(hdev, skb);
         |                       ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/bluetooth/btmtk.c:409:25: error: implicit declaration of function 'hci_devcoredump_complete' [-Werror=implicit-function-declaration]
     409 |                         hci_devcoredump_complete(hdev);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +111 drivers/bluetooth/btmtk.c

   107	
   108	static void btmtk_coredump_notify(struct hci_dev *hdev, int state)
   109	{
   110		switch (state) {
 > 111		case HCI_DEVCOREDUMP_ACTIVE:
   112			coredump_info.state = BTMTK_COREDUMP_ACTIVE;
   113			break;
 > 114		case HCI_DEVCOREDUMP_TIMEOUT:
 > 115		case HCI_DEVCOREDUMP_ABORT:
 > 116		case HCI_DEVCOREDUMP_DONE:
   117			coredump_info.state = BTMTK_COREDUMP_INIT;
   118			btmtk_reset_sync(coredump_info.hdev);
   119			break;
   120		}
   121	}
   122	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
