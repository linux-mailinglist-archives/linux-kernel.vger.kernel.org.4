Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E036F5511
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjECJns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjECJnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:43:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8EA4C21;
        Wed,  3 May 2023 02:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683106996; x=1714642996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vhqFdTzhGexCAv6U0OS1J8ZaNH/S/YqaydBy/c8yYQo=;
  b=gElOxp3pwhVjCpuDLJIUHdBSKvOfrm+gdfM0uJOVfPJgIrMnh+nC4BeT
   IC1BIMhbmGSZDkwHIWNwLOcd2G8YQYnLvul6FrYOej1+ZO8/8xJ8YD9vg
   22+1jWNFC/FSaXVtulbI3P9B9omumlEuAHN62JWhx/RK+sRinQ/Rpj9tC
   85wGvoB6n1hQ1b1r2tXK5Lob12R4tSdKcCWGYICM2IoLv0cDGyz+oWOKS
   g6eckBI/no5ubVKhvdmUbgUh5ePF4/cW2XbAOodICTwkYEfdvB9TOp5Nv
   RvbNHg+mZzRC7RwCs6oweVxle+XAUPCcF+JX0hjEsYcZFhzVgKdaahNdi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="350688527"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="350688527"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 02:43:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="1026439652"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="1026439652"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 May 2023 02:43:09 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pu90u-0001ou-2c;
        Wed, 03 May 2023 09:43:08 +0000
Date:   Wed, 3 May 2023 17:42:09 +0800
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
Subject: Re: [PATCH v5 3/3] Bluetooth: btusb: mediatek: add MediaTek
 devcoredump support
Message-ID: <202305031708.UQZ6jRn6-lkp@intel.com>
References: <ddcbc509b5024882583d5c143ec5f4520bef860a.1683065391.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddcbc509b5024882583d5c143ec5f4520bef860a.1683065391.git.objelf@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master linus/master v6.3 next-20230428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/sean-wang-mediatek-com/Bluetooth-btmtk-introduce-btmtk-reset-work/20230503-070640
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/ddcbc509b5024882583d5c143ec5f4520bef860a.1683065391.git.objelf%40gmail.com
patch subject: [PATCH v5 3/3] Bluetooth: btusb: mediatek: add MediaTek devcoredump support
config: x86_64-randconfig-a016-20230501 (https://download.01.org/0day-ci/archive/20230503/202305031708.UQZ6jRn6-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/635545fc4095e7e6b159177a07b0359b7eafe482
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review sean-wang-mediatek-com/Bluetooth-btmtk-introduce-btmtk-reset-work/20230503-070640
        git checkout 635545fc4095e7e6b159177a07b0359b7eafe482
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/bluetooth/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305031708.UQZ6jRn6-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/bluetooth/btmtk.c:97:7: error: use of undeclared identifier 'HCI_DEVCOREDUMP_IDLE'
           case HCI_DEVCOREDUMP_IDLE:
                ^
   drivers/bluetooth/btmtk.c:100:7: error: use of undeclared identifier 'HCI_DEVCOREDUMP_ACTIVE'; did you mean 'BTMTK_COREDUMP_ACTIVE'?
           case HCI_DEVCOREDUMP_ACTIVE:
                ^~~~~~~~~~~~~~~~~~~~~~
                BTMTK_COREDUMP_ACTIVE
   drivers/bluetooth/btmtk.c:25:2: note: 'BTMTK_COREDUMP_ACTIVE' declared here
           BTMTK_COREDUMP_ACTIVE,
           ^
   drivers/bluetooth/btmtk.c:103:7: error: use of undeclared identifier 'HCI_DEVCOREDUMP_TIMEOUT'
           case HCI_DEVCOREDUMP_TIMEOUT:
                ^
   drivers/bluetooth/btmtk.c:104:7: error: use of undeclared identifier 'HCI_DEVCOREDUMP_ABORT'
           case HCI_DEVCOREDUMP_ABORT:
                ^
   drivers/bluetooth/btmtk.c:105:7: error: use of undeclared identifier 'HCI_DEVCOREDUMP_DONE'
           case HCI_DEVCOREDUMP_DONE:
                ^
   drivers/bluetooth/btmtk.c:367:9: error: implicit declaration of function 'hci_devcd_register' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return hci_devcd_register(hdev, btmtk_coredump, btmtk_coredump_hdr,
                  ^
   drivers/bluetooth/btmtk.c:385:9: error: implicit declaration of function 'hci_devcd_init' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   err = hci_devcd_init(hdev, MTK_COREDUMP_SIZE);
                         ^
   drivers/bluetooth/btmtk.c:385:9: note: did you mean 'hci_sock_init'?
   include/net/bluetooth/bluetooth.h:577:5: note: 'hci_sock_init' declared here
   int hci_sock_init(void);
       ^
>> drivers/bluetooth/btmtk.c:389:32: error: no member named 'dump' in 'struct hci_dev'
                   schedule_delayed_work(&hdev->dump.dump_timeout,
                                          ~~~~  ^
   drivers/bluetooth/btmtk.c:394:9: error: implicit declaration of function 'hci_devcd_append' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   err = hci_devcd_append(hdev, skb);
                         ^
   drivers/bluetooth/btmtk.c:394:9: note: did you mean 'hci_dev_open'?
   include/net/bluetooth/hci_core.h:1500:5: note: 'hci_dev_open' declared here
   int hci_dev_open(__u16 dev);
       ^
   drivers/bluetooth/btmtk.c:401:4: error: implicit declaration of function 'hci_devcd_complete' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           hci_devcd_complete(hdev);
                           ^
   drivers/bluetooth/btmtk.c:401:4: note: did you mean 'hci_devcd_append'?
   drivers/bluetooth/btmtk.c:394:9: note: 'hci_devcd_append' declared here
                   err = hci_devcd_append(hdev, skb);
                         ^
   10 errors generated.


vim +389 drivers/bluetooth/btmtk.c

   371	
   372	int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
   373	{
   374		struct btmtk_data *data = hci_get_priv(hdev);
   375		int err;
   376	
   377		if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
   378			return 0;
   379	
   380		switch (data->cd_info.state) {
   381		case BTMTK_COREDUMP_DISABLED:
   382			err = -EINVAL;
   383			break;
   384		case BTMTK_COREDUMP_INIT:
 > 385			err = hci_devcd_init(hdev, MTK_COREDUMP_SIZE);
   386			if (err < 0)
   387				break;
   388			/* It is supposed coredump can be done within 5 seconds */
 > 389			schedule_delayed_work(&hdev->dump.dump_timeout,
   390					      msecs_to_jiffies(5000));
   391			fallthrough;
   392		case BTMTK_COREDUMP_ACTIVE:
   393		default:
   394			err = hci_devcd_append(hdev, skb);
   395			if (err < 0)
   396				break;
   397	
   398			if (skb->len > 12 &&
   399			    !strncmp((char *)&skb->data[skb->len - 13],
   400				     MTK_COREDUMP_END, 12))
   401				hci_devcd_complete(hdev);
   402	
   403			break;
   404		}
   405	
   406		if (err < 0) {
   407			data->cd_info.state = BTMTK_COREDUMP_DISABLED;
   408			kfree_skb(skb);
   409		}
   410	
   411		return err;
   412	}
   413	EXPORT_SYMBOL_GPL(btmtk_process_coredump);
   414	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
