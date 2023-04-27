Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30F56F0ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244261AbjD0RXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243737AbjD0RXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:23:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F2726A6;
        Thu, 27 Apr 2023 10:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682616191; x=1714152191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e7t003heJi1XAtLbnW5RQXVk9/BjNHIn2f+EIk07P0Y=;
  b=HNpXP0QQBpMgHUBN+gvyiR8ASfNwfTn8Sno4y4XDQ3kwQoqKKOop2rTE
   ZBp9RWzWhUTTa8P7N6mu9aKPpCbLWYFHKtgLllafriOB4wZedJ1IJdX8H
   QIRX5rn/Q0HAci2/Y6XogE5X7PCBdvXQhrS1LKZJi1eR0b5hiqXEO4BvF
   0qYVOU/ht01vOM8I+f7VKlwS+i9wrWnvWswi9w9JLBeqX8kOh2CEPHFE3
   wHl0uSafR/FreTPP3M4T5YxA/hirfhKdZiLLfU0u0MPlBz8q6OMhBRc3g
   kz4xUt1iXiQPN9S9v2EIVB2kZBcX9I2j/I22KctQMGOMh/ZeZJ2Pq61yM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="344962033"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="344962033"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 10:21:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="868809209"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="868809209"
Received: from lkp-server01.sh.intel.com (HELO b95e16499b55) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Apr 2023 10:21:23 -0700
Received: from kbuild by b95e16499b55 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ps5J4-00002z-2a;
        Thu, 27 Apr 2023 17:21:22 +0000
Date:   Fri, 28 Apr 2023 01:20:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     sean.wang@mediatek.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, sean.wang@mediatek.com,
        chris.lu@mediatek.com, Soul.Huang@mediatek.com,
        Leon.Yen@mediatek.com, Deren.Wu@mediatek.com, km.lin@mediatek.com,
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
Message-ID: <202304280130.Aoglg07c-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v6.3 next-20230426]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/sean-wang-mediatek-com/Bluetooth-btmtk-introduce-btmtk-reset-work/20230427-071054
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/01d3fe06d3a1e333b193e7d9fbc9cbfb4ee5d02b.1682549719.git.objelf%40gmail.com
patch subject: [PATCH v4 3/3] Bluetooth: btusb: mediatek: add MediaTek devcoredump support
config: x86_64-randconfig-r035-20211003 (https://download.01.org/0day-ci/archive/20230428/202304280130.Aoglg07c-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/d253c927e94cb7e88bfcd0182449d29e477ca011
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review sean-wang-mediatek-com/Bluetooth-btmtk-introduce-btmtk-reset-work/20230427-071054
        git checkout d253c927e94cb7e88bfcd0182449d29e477ca011
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304280130.Aoglg07c-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/bluetooth/btusb.c:28:
>> drivers/bluetooth/btmtk.h:172:6: warning: no previous prototype for 'btmtk_register_coredump' [-Wmissing-prototypes]
     172 | void btmtk_register_coredump(struct hci_dev *hdev, u32 dev_id, const char *name,
         |      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/btmtk_register_coredump +172 drivers/bluetooth/btmtk.h

   171	
 > 172	void btmtk_register_coredump(struct hci_dev *hdev, u32 dev_id, const char *name,
   173				     u32 fw_version)
   174	{
   175	}
   176	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
