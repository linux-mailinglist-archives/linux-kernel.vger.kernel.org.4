Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DD85E7218
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 04:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiIWCsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 22:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiIWCsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 22:48:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAA611ADCB;
        Thu, 22 Sep 2022 19:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663901312; x=1695437312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mm73VADdXudNH6khsnK+7I6Kj3wxgXnc+uPIkxAy91E=;
  b=eUYtRXh5nTq6oaiYKz1rK4yG4t4Un1Tk2a0ZbeIfzwrgebjIgcMVLv1U
   ndJmn8Lk1fPDEHetuQ3JfQev34LHQp+4tM/UxTxGof94mDg9gXpIV8Lxb
   yvCXRjLXNK9SXLkrOfd44jweSbGG/j3bvzwlLBoyqfOHKrmpwYP5KO807
   fl9Q22wxnhRiBkXINV411T1W8nhc/TKYEzfQ/HR9/IyyStf4fyXY2skEg
   +GFctIAYDU0bopFoehXZqm6hi77UNszRg6aloMGic/OD+/101PLYciGU8
   27wdm6tg6k7njuQUmolYhoQBt0lJUhiCE7TPNXrAdn05orlyxC5A1n83X
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="364506690"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="364506690"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 19:48:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="615462147"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 22 Sep 2022 19:48:28 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obYjr-0005F1-1y;
        Fri, 23 Sep 2022 02:48:27 +0000
Date:   Fri, 23 Sep 2022 10:48:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     hildawu@realtek.com, marcel@holtmann.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        mmandlik@google.com, max.chou@realtek.com, alex_lu@realsil.com.cn,
        kidman@realtek.com
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek devcoredump support
Message-ID: <202209231041.TfIbIGWJ-lkp@intel.com>
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
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20220923/202209231041.TfIbIGWJ-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b896c161a197fbcb019f6e4f890b667bb9d6f15e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review hildawu-realtek-com/Bluetooth-btusb-Add-Realtek-devcoredump-support/20220922-183533
        git checkout b896c161a197fbcb019f6e4f890b667bb9d6f15e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/bluetooth/btusb.c:731:7: error: implicit declaration of function 'hci_devcoredump_init' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (!hci_devcoredump_init(hdev, skb->len)) {
                ^
>> drivers/bluetooth/btusb.c:732:3: error: implicit declaration of function 'hci_devcoredump_append' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   hci_devcoredump_append(hdev, skb);
                   ^
   drivers/bluetooth/btusb.c:732:3: note: did you mean 'hci_devcoredump_init'?
   drivers/bluetooth/btusb.c:731:7: note: 'hci_devcoredump_init' declared here
           if (!hci_devcoredump_init(hdev, skb->len)) {
                ^
>> drivers/bluetooth/btusb.c:733:3: error: implicit declaration of function 'hci_devcoredump_complete' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   hci_devcoredump_complete(hdev);
                   ^
   drivers/bluetooth/btusb.c:733:3: note: did you mean 'hci_devcoredump_append'?
   drivers/bluetooth/btusb.c:732:3: note: 'hci_devcoredump_append' declared here
                   hci_devcoredump_append(hdev, skb);
                   ^
   drivers/bluetooth/btusb.c:776:7: error: implicit declaration of function 'hci_devcoredump_init' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (!hci_devcoredump_init(hdev, skb->len)) {
                ^
   drivers/bluetooth/btusb.c:777:3: error: implicit declaration of function 'hci_devcoredump_append' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   hci_devcoredump_append(hdev, skb);
                   ^
   drivers/bluetooth/btusb.c:778:3: error: implicit declaration of function 'hci_devcoredump_complete' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   hci_devcoredump_complete(hdev);
                   ^
   drivers/bluetooth/btusb.c:2361:8: error: implicit declaration of function 'hci_devcoredump_init' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   if (!hci_devcoredump_init(hdev, nskb->len)) {
                        ^
   drivers/bluetooth/btusb.c:2362:4: error: implicit declaration of function 'hci_devcoredump_append' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           hci_devcoredump_append(hdev, nskb);
                           ^
   drivers/bluetooth/btusb.c:2363:4: error: implicit declaration of function 'hci_devcoredump_complete' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           hci_devcoredump_complete(hdev);
                           ^
   9 errors generated.
--
>> drivers/bluetooth/btrtl.c:657:8: error: implicit declaration of function 'hci_devcoredump_register' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           err = hci_devcoredump_register(hdev, btrtl_coredump, btrtl_dmp_hdr,
                 ^
   1 error generated.


vim +/hci_devcoredump_init +731 drivers/bluetooth/btusb.c

   719	
   720	static void btusb_rtl_cmd_timeout(struct hci_dev *hdev)
   721	{
   722		struct btusb_data *data = hci_get_drvdata(hdev);
   723		struct gpio_desc *reset_gpio = data->reset_gpio;
   724		struct sk_buff *skb;
   725		u8 code[4] = { DEVCOREDUMP_CODE_CMD_TIMEOUT, 0, 0, 0 };
   726	
   727		skb = alloc_skb(sizeof(code), GFP_ATOMIC);
   728		if (!skb)
   729			goto timeout_check;
   730		skb_put_data(skb, code, sizeof(code));
 > 731		if (!hci_devcoredump_init(hdev, skb->len)) {
 > 732			hci_devcoredump_append(hdev, skb);
 > 733			hci_devcoredump_complete(hdev);
   734		} else {
   735			bt_dev_err(hdev, "RTL: cmd timeout, failed to devcoredump");
   736			kfree_skb(skb);
   737		}
   738	
   739	timeout_check:
   740		if (++data->cmd_timeout_cnt < 5)
   741			return;
   742	
   743		if (!reset_gpio) {
   744			bt_dev_err(hdev, "No gpio to reset Realtek device, ignoring");
   745			return;
   746		}
   747	
   748		/* Toggle the hard reset line. The Realtek device is going to
   749		 * yank itself off the USB and then replug. The cleanup is handled
   750		 * correctly on the way out (standard USB disconnect), and the new
   751		 * device is detected cleanly and bound to the driver again like
   752		 * it should be.
   753		 */
   754		if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
   755			bt_dev_err(hdev, "last reset failed? Not resetting again");
   756			return;
   757		}
   758	
   759		bt_dev_err(hdev, "Reset Realtek device via gpio");
   760		gpiod_set_value_cansleep(reset_gpio, 1);
   761		msleep(200);
   762		gpiod_set_value_cansleep(reset_gpio, 0);
   763	}
   764	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
