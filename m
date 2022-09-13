Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4E55B6C12
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiIMK5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiIMK5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:57:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0355F104;
        Tue, 13 Sep 2022 03:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663066628; x=1694602628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=11l4HL2ZNwzx83esXqcj5RkTzUWCjv48wB1HSJzPoHY=;
  b=GW0UjShIQ2AMIW24MNI2aHLFJqN543fiz/OZYTpQp3D0gku6YpKilBk7
   M8GoaHskPjD7oK/eOVrXM2XG40T/2AVg4VWOFVWYlxPbKgXV8eHdCYrO/
   u6Gahay9Nn4ANB4ZoCqxjPRgHiPyds+5JmEBJZvmcVsGdzTdL8CTpuKbh
   GrQrKBrlyZzUG/6OX5EyinQIkin6JwrXkoUfAvci4x7694duMzLKLnouF
   yxT1MR12oApXvmw3zjK1y+eaDZspwP+lbag6wE1xNgJ6953o41MB4jyUr
   pCc6RS1J46ri7q+Quz+fzacfB6wMVmK8PJoJ3fTHq2I1YxjvDH0rMdQoa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="277839559"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="277839559"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 03:57:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="861511474"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Sep 2022 03:57:01 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oY3bB-0003WI-0V;
        Tue, 13 Sep 2022 10:57:01 +0000
Date:   Tue, 13 Sep 2022 18:56:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     sean.wang@mediatek.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        sean.wang@mediatek.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        abhishekpandit@google.com, michaelfsun@google.com,
        abhishekpandit@chromium.org, mcchou@chromium.org,
        shawnku@google.com, linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jing Cai <jing.cai@mediatek.com>
Subject: Re: [PATCH 4/4] Bluetooth: btusb: mediatek: add MediaTek devcoredump
 support
Message-ID: <202209131807.OuwXBmKi-lkp@intel.com>
References: <540fc6d93481e72e18b51f82f022ab34d57d5caa.1663020936.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <540fc6d93481e72e18b51f82f022ab34d57d5caa.1663020936.git.objelf@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
config: i386-randconfig-a016-20220912 (https://download.01.org/0day-ci/archive/20220913/202209131807.OuwXBmKi-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d478461e2fd5fdd8d505c00c7864a421170a54bb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review sean-wang-mediatek-com/Bluetooth-btusb-mediatek-use-readx_poll_timeout-instead-of-open-coding/20220913-062200
        git checkout d478461e2fd5fdd8d505c00c7864a421170a54bb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/bluetooth/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/bluetooth/btmtk.c:111:7: error: use of undeclared identifier 'HCI_DEVCOREDUMP_ACTIVE'; did you mean 'BTMTK_COREDUMP_ACTIVE'?
           case HCI_DEVCOREDUMP_ACTIVE:
                ^~~~~~~~~~~~~~~~~~~~~~
                BTMTK_COREDUMP_ACTIVE
   drivers/bluetooth/btmtk.c:27:2: note: 'BTMTK_COREDUMP_ACTIVE' declared here
           BTMTK_COREDUMP_ACTIVE,
           ^
>> drivers/bluetooth/btmtk.c:114:7: error: use of undeclared identifier 'HCI_DEVCOREDUMP_TIMEOUT'
           case HCI_DEVCOREDUMP_TIMEOUT:
                ^
>> drivers/bluetooth/btmtk.c:115:7: error: use of undeclared identifier 'HCI_DEVCOREDUMP_ABORT'
           case HCI_DEVCOREDUMP_ABORT:
                ^
>> drivers/bluetooth/btmtk.c:116:7: error: use of undeclared identifier 'HCI_DEVCOREDUMP_DONE'
           case HCI_DEVCOREDUMP_DONE:
                ^
>> drivers/bluetooth/btmtk.c:376:2: error: implicit declaration of function 'hci_devcoredump_register' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           hci_devcoredump_register(hdev, btmtk_coredump, btmtk_coredump_hdr,
           ^
>> drivers/bluetooth/btmtk.c:393:9: error: implicit declaration of function 'hci_devcoredump_init' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   err = hci_devcoredump_init(hdev, 1024000);
                         ^
>> drivers/bluetooth/btmtk.c:397:32: error: no member named 'dump' in 'struct hci_dev'
                   schedule_delayed_work(&hdev->dump.dump_timeout,
                                          ~~~~  ^
>> drivers/bluetooth/btmtk.c:402:9: error: implicit declaration of function 'hci_devcoredump_append' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   err = hci_devcoredump_append(hdev, skb);
                         ^
   drivers/bluetooth/btmtk.c:402:9: note: did you mean 'hci_devcoredump_init'?
   drivers/bluetooth/btmtk.c:393:9: note: 'hci_devcoredump_init' declared here
                   err = hci_devcoredump_init(hdev, 1024000);
                         ^
>> drivers/bluetooth/btmtk.c:409:4: error: implicit declaration of function 'hci_devcoredump_complete' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           hci_devcoredump_complete(hdev);
                           ^
   drivers/bluetooth/btmtk.c:409:4: note: did you mean 'hci_devcoredump_append'?
   drivers/bluetooth/btmtk.c:402:9: note: 'hci_devcoredump_append' declared here
                   err = hci_devcoredump_append(hdev, skb);
                         ^
   9 errors generated.


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
