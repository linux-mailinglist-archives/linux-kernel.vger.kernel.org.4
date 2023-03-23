Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362686C6C20
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjCWPSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjCWPSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:18:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954ED29405;
        Thu, 23 Mar 2023 08:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679584720; x=1711120720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fBTf1WFkxv6jpIw1EyUCMiRABvqdmGxDE71QRCONeqM=;
  b=eJDy74BnaGJQV0FBpjM/Cb66TncNeNvpUzjafx6UYGAcYDUM37oWccS2
   xFjmsttf3RmH2QzKAzKBDwR9R4XWQr9NoKRl5EZPBGpXtuq5NI8LT9Iao
   hOZxBZBaoVbN0t9v9idt8VeBxe2GZOZG3Lm0ZHC9UeNqcw5wSqWcF5hcC
   2uVHlIu8amNwkVKTgGb/CaJV97rHYzrlKyzl9l3WhH5jX5njcL/itAWGn
   IRqvMhVWIgVTle+xH4y7e4GmFn5zRQAy40RPZ6d0SIRN/3s3OWQxRQYWj
   hxq6zMz/Fed/Ux5Xz1J3h82ySyIEZEeeBm9C1SOnOkjMTAl8PhWpOav3J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="319171900"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="319171900"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 08:18:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="675745582"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="675745582"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Mar 2023 08:18:31 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfMhz-000ETr-0r;
        Thu, 23 Mar 2023 15:18:31 +0000
Date:   Thu, 23 Mar 2023 23:18:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maximilian Weigand <mweigand@mweigand.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Maximilian Weigand <mweigand@mweigand.net>,
        Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH 2/6] Input: cyttsp5: remove unused code
Message-ID: <202303232302.FB64fi39-lkp@intel.com>
References: <20230323135205.1160879-3-mweigand@mweigand.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323135205.1160879-3-mweigand@mweigand.net>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maximilian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on dtor-input/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maximilian-Weigand/Input-cyttsp5-fix-array-length/20230323-215957
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20230323135205.1160879-3-mweigand%40mweigand.net
patch subject: [PATCH 2/6] Input: cyttsp5: remove unused code
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20230323/202303232302.FB64fi39-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/4358a60821eb8149dabed197c09d3c0eab63bf38
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Maximilian-Weigand/Input-cyttsp5-fix-array-length/20230323-215957
        git checkout 4358a60821eb8149dabed197c09d3c0eab63bf38
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/input/touchscreen/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303232302.FB64fi39-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/input/touchscreen/cyttsp5.c: In function 'cyttsp5_get_hid_descriptor':
>> drivers/input/touchscreen/cyttsp5.c:604:12: warning: unused variable 'cmd' [-Wunused-variable]
     604 |         u8 cmd[2];
         |            ^~~


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
