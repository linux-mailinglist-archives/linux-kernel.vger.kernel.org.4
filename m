Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1526F216C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 01:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346866AbjD1XzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 19:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347058AbjD1Xyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 19:54:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEC219A1;
        Fri, 28 Apr 2023 16:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682726091; x=1714262091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SJXp+1HzoIh0ZhIOJuOclUQJn51bNAqL1ZXszXf+6/0=;
  b=gs4Qcnd1rLaEbO5CjCbv8jH++DircSrNw1XZPlc8ZRkgBSJHDAClgbgS
   EfyjUnxY2Duc3I+zVXz/GIcn0WW+g+La44y8PNGm9/v5DJ2Z2K+i7xz/k
   Qg77yBH/uFhCDtw6etsAJodZNTWCepxy8osJNY9N0znz9Z/8rk5R6DZaM
   IzacARTRDgcTob+xtbkNjv4Bp/uMNdxK51gNpzLdOTku/6aRjo4tJPAnY
   IJsjgv/NXUK5NLXcMgysZf+Fw5vl0bJ/rDumwaIJtyc+WQtxCnqPvxG+6
   7U1loGX0Zv45SY687DMmKF+eQsBvhAQR4FV8DuayhbqqgS98j0kTWXwS5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="346655292"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="346655292"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 16:54:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="689030623"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="689030623"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Apr 2023 16:54:48 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psXvL-0000lD-1J;
        Fri, 28 Apr 2023 23:54:47 +0000
Date:   Sat, 29 Apr 2023 07:54:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sai Teja Aluvala <quic_saluvala@quicinc.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, quic_hemantg@quicinc.com,
        quic_bgodavar@quicinc.com, quic_rameshn@quicinc.com,
        jiangzp@google.com, mmandlik@google.com,
        Sai Teja Aluvala <quic_saluvala@quicinc.com>
Subject: Re: [PATCH v1 2/2] Bluetooth: hci_qca: Add qcomm devcoredump support
Message-ID: <202304290720.TfpPCFY6-lkp@intel.com>
References: <1682666311-8452-1-git-send-email-quic_saluvala@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682666311-8452-1-git-send-email-quic_saluvala@quicinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v6.3 next-20230428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sai-Teja-Aluvala/Bluetooth-hci_qca-Add-qcomm-devcoredump-support/20230428-152145
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/1682666311-8452-1-git-send-email-quic_saluvala%40quicinc.com
patch subject: [PATCH v1 2/2] Bluetooth: hci_qca: Add qcomm devcoredump support
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230429/202304290720.TfpPCFY6-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a3c3d43057a99f13198754e0b8eaf944d1853142
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sai-Teja-Aluvala/Bluetooth-hci_qca-Add-qcomm-devcoredump-support/20230428-152145
        git checkout a3c3d43057a99f13198754e0b8eaf944d1853142
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304290720.TfpPCFY6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/bluetooth/hci_qca.c:981:5: warning: no previous prototype for 'qca_dmp_hdr' [-Wmissing-prototypes]
     981 | int qca_dmp_hdr(struct hci_dev *hdev, char *buf, size_t size)
         |     ^~~~~~~~~~~
   drivers/bluetooth/hci_qca.c: In function 'qca_controller_memdump':
   drivers/bluetooth/hci_qca.c:1070:31: error: implicit declaration of function 'hci_devcoredump_init' [-Werror=implicit-function-declaration]
    1070 |                         ret = hci_devcoredump_init(hu->hdev, qca_memdump->ram_dump_size);
         |                               ^~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/hci_qca.c:1119:25: error: implicit declaration of function 'hci_devcoredump_append_pattern' [-Werror=implicit-function-declaration]
    1119 |                         hci_devcoredump_append_pattern(hu->hdev, 0x00,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/hci_qca.c:1136:25: error: implicit declaration of function 'hci_devcoredump_append' [-Werror=implicit-function-declaration]
    1136 |                         hci_devcoredump_append(hu->hdev, skb);
         |                         ^~~~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/hci_qca.c:1150:25: error: implicit declaration of function 'hci_devcoredump_complete' [-Werror=implicit-function-declaration]
    1150 |                         hci_devcoredump_complete(hu->hdev);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/hci_qca.c: In function 'qca_hw_error':
   drivers/bluetooth/hci_qca.c:1557:17: error: implicit declaration of function 'hci_devcoredump_abort' [-Werror=implicit-function-declaration]
    1557 |                 hci_devcoredump_abort(hu->hdev);
         |                 ^~~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/hci_qca.c: In function 'hciqca_coredump_enabled':
   drivers/bluetooth/hci_qca.c:1727:32: error: 'struct device' has no member named 'coredump_disabled'
    1727 |         return !hu->serdev->dev.coredump_disabled;
         |                                ^
   drivers/bluetooth/hci_qca.c: In function 'qca_setup':
   drivers/bluetooth/hci_qca.c:1866:25: error: 'struct hci_dev' has no member named 'dump'
    1866 |                 hu->hdev->dump.enabled = hciqca_coredump_enabled;
         |                         ^~
   drivers/bluetooth/hci_qca.c:1906:9: error: implicit declaration of function 'hci_devcoredump_register' [-Werror=implicit-function-declaration]
    1906 |         hci_devcoredump_register(hdev, hci_coredump_qca, qca_dmp_hdr, NULL);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/hci_qca.c: In function 'hciqca_coredump':
   drivers/bluetooth/hci_qca.c:2458:17: error: 'struct device' has no member named 'coredump_disabled'
    2458 |         if (!dev->coredump_disabled && hdev->dump.coredump)
         |                 ^~
   drivers/bluetooth/hci_qca.c:2458:44: error: 'struct hci_dev' has no member named 'dump'
    2458 |         if (!dev->coredump_disabled && hdev->dump.coredump)
         |                                            ^~
   drivers/bluetooth/hci_qca.c:2459:21: error: 'struct hci_dev' has no member named 'dump'
    2459 |                 hdev->dump.coredump(hdev);
         |                     ^~
   cc1: some warnings being treated as errors


vim +/qca_dmp_hdr +981 drivers/bluetooth/hci_qca.c

   980	
 > 981	int qca_dmp_hdr(struct hci_dev *hdev, char *buf, size_t size)
   982	{
   983		struct hci_uart *hu = hci_get_drvdata(hdev);
   984		struct qca_data *qca = hu->priv;
   985		int len = 0;
   986	
   987		len += snprintf(buf + len, size-len, "Controller Name: 0x%x\n",
   988				qca->controller_id);
   989	
   990		len += snprintf(buf + len, size-len, "Firmware Version: 0x%x\n",
   991				qca->fw_version);
   992	
   993		len += snprintf(buf + len, size-len, "Vendor:Qualcomm\n");
   994	
   995		len += snprintf(buf + len, size-len, "Driver: %s\n",
   996				hu->serdev->dev.driver->name);
   997	
   998		bt_dev_info(hdev, "vendor dump hdr size(%d)", len);
   999		return len;
  1000	}
  1001	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
