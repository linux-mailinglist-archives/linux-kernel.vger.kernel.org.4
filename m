Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30D369B6F2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjBRAh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjBRAhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:37:53 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1CD692BA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676680640; x=1708216640;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9fLuJ86ON+BO54+qy6eHlF7FUBiIE7Xz9CNdZfTRk80=;
  b=l0/jvVS2nIqC/yMCdQhWnV8754xgGBb4g48VH7IZ8CQeUlAFP13Wu3qz
   7TCn7tODqu28bc6H4zSH+BE2EMoz9Era4I0Ck7fiSPJwwHd61U06phLUE
   tPpS1kODhzTOAn4btUgXeIgjfO73H2RsooQWaJWAD5f3N1S0wwmrMQ41R
   ykc6CnkAGBZ6SJA9n0oi172d4ZxYjEyv85b7uvHafT6kxqL5UMPy8JznL
   kDQBWdhSdYvLeoBFfo79UNkQ/f/ArqY4FhILEDjQ1D6MrzWxGd4dnpfh5
   fHHfYdE9OqcFzwjbKMdUTuGJiZI1xKjZrFShBxofxqOJCofsYReiTTEEb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="332129914"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="332129914"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 16:36:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="779954138"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="779954138"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 17 Feb 2023 16:35:39 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTBCU-000BwL-2g;
        Sat, 18 Feb 2023 00:35:38 +0000
Date:   Sat, 18 Feb 2023 08:35:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>
Subject: drivers/platform/chrome/cros_ec_proto_test.c:2530:13: warning: stack
 frame size (1040) exceeds limit (1024) in
 'cros_ec_proto_test_get_sensor_count_legacy'
Message-ID: <202302180845.wuJUgQ2h-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tzung-Bi,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dbeed98d89ea91ae68ff6dce6060671726292e85
commit: 33f0fdba6066b504ee0b5f1480b1f93b06050df6 platform/chrome: cros_ec_proto: add Kunit tests for get_sensor_count
date:   7 months ago
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20230218/202302180845.wuJUgQ2h-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=33f0fdba6066b504ee0b5f1480b1f93b06050df6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 33f0fdba6066b504ee0b5f1480b1f93b06050df6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/platform/chrome/ drivers/staging/media/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302180845.wuJUgQ2h-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/chrome/cros_ec_proto_test.c:2530:13: warning: stack frame size (1040) exceeds limit (1024) in 'cros_ec_proto_test_get_sensor_count_legacy' [-Wframe-larger-than]
   static void cros_ec_proto_test_get_sensor_count_legacy(struct kunit *test)
               ^
   140/1040 (13.46%) spills, 900/1040 (86.54%) variables
   1 warning generated.


vim +/cros_ec_proto_test_get_sensor_count_legacy +2530 drivers/platform/chrome/cros_ec_proto_test.c

  2529	
> 2530	static void cros_ec_proto_test_get_sensor_count_legacy(struct kunit *test)
  2531	{
  2532		struct cros_ec_proto_test_priv *priv = test->priv;
  2533		struct cros_ec_device *ec_dev = &priv->ec_dev;
  2534		struct ec_xfer_mock *mock;
  2535		int ret, i;
  2536		struct cros_ec_dev ec;
  2537		struct {
  2538			u8 readmem_data;
  2539			int expected_result;
  2540		} test_data[] = {
  2541			{ 0, 0 },
  2542			{ EC_MEMMAP_ACC_STATUS_PRESENCE_BIT, 2 },
  2543		};
  2544	
  2545		ec_dev->max_request = 0xff;
  2546		ec_dev->max_response = 0xee;
  2547		ec_dev->cmd_readmem = cros_kunit_readmem_mock;
  2548		ec.ec_dev = ec_dev;
  2549		ec.dev = ec_dev->dev;
  2550		ec.cmd_offset = 0;
  2551	
  2552		for (i = 0; i < ARRAY_SIZE(test_data); ++i) {
  2553			/* For EC_CMD_MOTION_SENSE_CMD. */
  2554			{
  2555				mock = cros_kunit_ec_xfer_mock_addx(test, -EPROTO, EC_RES_SUCCESS, 0);
  2556				KUNIT_ASSERT_PTR_NE(test, mock, NULL);
  2557			}
  2558	
  2559			/* For readmem. */
  2560			{
  2561				cros_kunit_readmem_mock_data = kunit_kzalloc(test, 1, GFP_KERNEL);
  2562				KUNIT_ASSERT_PTR_NE(test, cros_kunit_readmem_mock_data, NULL);
  2563				cros_kunit_readmem_mock_data[0] = test_data[i].readmem_data;
  2564	
  2565				cros_kunit_ec_xfer_mock_default_ret = 1;
  2566			}
  2567	
  2568			ret = cros_ec_get_sensor_count(&ec);
  2569			KUNIT_EXPECT_EQ(test, ret, test_data[i].expected_result);
  2570	
  2571			/* For EC_CMD_MOTION_SENSE_CMD. */
  2572			{
  2573				struct ec_params_motion_sense *data;
  2574	
  2575				mock = cros_kunit_ec_xfer_mock_next();
  2576				KUNIT_EXPECT_PTR_NE(test, mock, NULL);
  2577	
  2578				KUNIT_EXPECT_EQ(test, mock->msg.version, 1);
  2579				KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_MOTION_SENSE_CMD);
  2580				KUNIT_EXPECT_EQ(test, mock->msg.insize,
  2581						sizeof(struct ec_response_motion_sense));
  2582				KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(*data));
  2583	
  2584				data = (struct ec_params_motion_sense *)mock->i_data;
  2585				KUNIT_EXPECT_EQ(test, data->cmd, MOTIONSENSE_CMD_DUMP);
  2586			}
  2587	
  2588			/* For readmem. */
  2589			{
  2590				KUNIT_EXPECT_EQ(test, cros_kunit_readmem_mock_offset, EC_MEMMAP_ACC_STATUS);
  2591			}
  2592		}
  2593	}
  2594	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
