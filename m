Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95B66CA8CB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjC0PSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjC0PSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:18:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3393F19A1;
        Mon, 27 Mar 2023 08:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679930312; x=1711466312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=17LMq6FcckRvCjRKh2cYsU9tHbmYq+HS/t9LCbX9zWs=;
  b=XRxKw6YDlwBjmsBEeav0LrqO3G2aKK/iojUhC19QrU4PpcmL17WaU9gR
   ysUh9e2f/qtH+5KQ5MrBDJIQWBhbfeVixS1GEKkmct95+OczyGaCLuE4x
   nWxhkkcQVZzh18u6YaiPHZ87N3PeuZsTQntlg0vUz3FRua9whQUxjsoZx
   394K7rLvaEyUJ5lr/Qe/DIY6pFxXusQH0pVLRHUYh4sDJOGpr57abwFN5
   0g+wINomQr+6l9z4h4R5/z6uYEgjPZRqiziTIrAt1xl16ZWbwhU5ghFJq
   xGGWKQIaYCOn2ZFq3hLKm9UGD+89JvZgvc4o9VQbly1Gtb5En/nuaD19C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320693417"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="320693417"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 08:18:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="676999194"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="676999194"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Mar 2023 08:18:16 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pgobv-000Hnx-10;
        Mon, 27 Mar 2023 15:18:15 +0000
Date:   Mon, 27 Mar 2023 23:17:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maximilian Weigand <mweigand@mweigand.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Maximilian Weigand <mweigand@mweigand.net>,
        Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH 2/6] Input: cyttsp5: remove unused code
Message-ID: <202303272323.nRNi9Sso-lkp@intel.com>
References: <20230323135205.1160879-3-mweigand@mweigand.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323135205.1160879-3-mweigand@mweigand.net>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maximilian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on dtor-input/for-linus linus/master v6.3-rc4 next-20230327]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maximilian-Weigand/Input-cyttsp5-fix-array-length/20230323-215957
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20230323135205.1160879-3-mweigand%40mweigand.net
patch subject: [PATCH 2/6] Input: cyttsp5: remove unused code
config: i386-randconfig-a011-20230327 (https://download.01.org/0day-ci/archive/20230327/202303272323.nRNi9Sso-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4358a60821eb8149dabed197c09d3c0eab63bf38
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Maximilian-Weigand/Input-cyttsp5-fix-array-length/20230323-215957
        git checkout 4358a60821eb8149dabed197c09d3c0eab63bf38
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/input/touchscreen/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303272323.nRNi9Sso-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/input/touchscreen/cyttsp5.c:604:5: warning: unused variable 'cmd' [-Wunused-variable]
           u8 cmd[2];
              ^
   1 warning generated.


vim +/cmd +604 drivers/input/touchscreen/cyttsp5.c

5b0c03e24a061f Alistair Francis 2022-10-31  598  
5b0c03e24a061f Alistair Francis 2022-10-31  599  static int cyttsp5_get_hid_descriptor(struct cyttsp5 *ts,
5b0c03e24a061f Alistair Francis 2022-10-31  600  				      struct cyttsp5_hid_desc *desc)
5b0c03e24a061f Alistair Francis 2022-10-31  601  {
5b0c03e24a061f Alistair Francis 2022-10-31  602  	struct device *dev = ts->dev;
5b0c03e24a061f Alistair Francis 2022-10-31  603  	int rc;
5b0c03e24a061f Alistair Francis 2022-10-31 @604  	u8 cmd[2];
5b0c03e24a061f Alistair Francis 2022-10-31  605  
5b0c03e24a061f Alistair Francis 2022-10-31  606  	rc = cyttsp5_write(ts, HID_DESC_REG, NULL, 0);
5b0c03e24a061f Alistair Francis 2022-10-31  607  	if (rc) {
5b0c03e24a061f Alistair Francis 2022-10-31  608  		dev_err(dev, "Failed to get HID descriptor, rc=%d\n", rc);
5b0c03e24a061f Alistair Francis 2022-10-31  609  		return rc;
5b0c03e24a061f Alistair Francis 2022-10-31  610  	}
5b0c03e24a061f Alistair Francis 2022-10-31  611  
5b0c03e24a061f Alistair Francis 2022-10-31  612  	rc = wait_for_completion_interruptible_timeout(&ts->cmd_done,
5b0c03e24a061f Alistair Francis 2022-10-31  613  			msecs_to_jiffies(CY_HID_GET_HID_DESCRIPTOR_TIMEOUT_MS));
5b0c03e24a061f Alistair Francis 2022-10-31  614  	if (rc <= 0) {
5b0c03e24a061f Alistair Francis 2022-10-31  615  		dev_err(ts->dev, "HID get descriptor timed out\n");
5b0c03e24a061f Alistair Francis 2022-10-31  616  		rc = -ETIMEDOUT;
5b0c03e24a061f Alistair Francis 2022-10-31  617  		return rc;
5b0c03e24a061f Alistair Francis 2022-10-31  618  	}
5b0c03e24a061f Alistair Francis 2022-10-31  619  
5b0c03e24a061f Alistair Francis 2022-10-31  620  	memcpy(desc, ts->response_buf, sizeof(*desc));
5b0c03e24a061f Alistair Francis 2022-10-31  621  
5b0c03e24a061f Alistair Francis 2022-10-31  622  	/* Check HID descriptor length and version */
5b0c03e24a061f Alistair Francis 2022-10-31  623  	if (le16_to_cpu(desc->hid_desc_len) != sizeof(*desc) ||
5b0c03e24a061f Alistair Francis 2022-10-31  624  	    le16_to_cpu(desc->bcd_version) != HID_VERSION) {
5b0c03e24a061f Alistair Francis 2022-10-31  625  		dev_err(dev, "Unsupported HID version\n");
5b0c03e24a061f Alistair Francis 2022-10-31  626  		return -ENODEV;
5b0c03e24a061f Alistair Francis 2022-10-31  627  	}
5b0c03e24a061f Alistair Francis 2022-10-31  628  
5b0c03e24a061f Alistair Francis 2022-10-31  629  	return 0;
5b0c03e24a061f Alistair Francis 2022-10-31  630  }
5b0c03e24a061f Alistair Francis 2022-10-31  631  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
