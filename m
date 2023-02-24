Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598FF6A153F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 04:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjBXDQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 22:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBXDQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:16:39 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ADF311EB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 19:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677208598; x=1708744598;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kviqoXrzMaBFxzY/PLk4rLq7RoEXLaN/OBT9RBs+qDk=;
  b=GmbfGySxTQYwtzf2lacd4YrqF+MZYQ34eMtQySDTBro55Qyq8EAKdZeU
   n52xhE3Aevfjj1v0iV9mebGfT/zmX3S/yiPkH7TToPfoDXS49GbJ+npj+
   qBsQXhPTybn3gu+AtgMMXe9TnXGGsY9L4Jpyd9TcA8SpFxDC0C2QeYyW+
   t4uLf6duzApktziyoB1+vZXCHKCzN9GK3hXse6i4GycuaWNiMDQSjrm2f
   S0ByUlZdHGRGsLo2NgZFaInCR3Q7+ScsIJXZzMzjj25TX6G3yJ6DRKV2A
   eRLGLpRD/VLRomjjeAGyLgHG01OYIVof0vE5hK25zdU1e7iaA6mGYkL6N
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="334805231"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="334805231"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 19:16:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="1001674782"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="1001674782"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Feb 2023 19:16:35 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVOZW-00025J-1w;
        Fri, 24 Feb 2023 03:16:34 +0000
Date:   Fri, 24 Feb 2023 11:16:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     M Chetan Kumar <m.chetan.kumar@linux.intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/net/wwan/iosm/iosm_ipc_mux.h:369:17: warning: field
 adb_finish_timer within 'struct iosm_mux' is less aligned than 'struct
 hrtimer' and is usually due to 'struct iosm_mux' being packed, which can
 lead to unaligned accesses
Message-ID: <202302241140.XzIRs2Td-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2980d8d826554fa6981d621e569a453787472f8
commit: 035e3befc191347331dd2530c3686e05a8acfbb2 net: wwan: iosm: fix driver not working with INTEL_IOMMU disabled
date:   4 months ago
config: arm-randconfig-r004-20230224 (https://download.01.org/0day-ci/archive/20230224/202302241140.XzIRs2Td-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=035e3befc191347331dd2530c3686e05a8acfbb2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 035e3befc191347331dd2530c3686e05a8acfbb2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302241140.XzIRs2Td-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/wwan/iosm/iosm_ipc_debugfs.c:10:
   In file included from drivers/net/wwan/iosm/iosm_ipc_trace.h:12:
   In file included from drivers/net/wwan/iosm/iosm_ipc_chnl_cfg.h:9:
>> drivers/net/wwan/iosm/iosm_ipc_mux.h:369:17: warning: field adb_finish_timer within 'struct iosm_mux' is less aligned than 'struct hrtimer' and is usually due to 'struct iosm_mux' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           struct hrtimer adb_finish_timer;
                          ^
   1 warning generated.


vim +369 drivers/net/wwan/iosm/iosm_ipc_mux.h

51c45fa95435c5 M Chetan Kumar 2021-06-13  309  
51c45fa95435c5 M Chetan Kumar 2021-06-13  310  /**
51c45fa95435c5 M Chetan Kumar 2021-06-13  311   * struct iosm_mux - Structure of the data multiplexing over an IP channel.
51c45fa95435c5 M Chetan Kumar 2021-06-13  312   * @dev:		Pointer to device structure
51c45fa95435c5 M Chetan Kumar 2021-06-13  313   * @session:		Array of the MUX sessions.
51c45fa95435c5 M Chetan Kumar 2021-06-13  314   * @channel:		Reference to the IP MUX channel
51c45fa95435c5 M Chetan Kumar 2021-06-13  315   * @pcie:		Pointer to iosm_pcie struct
51c45fa95435c5 M Chetan Kumar 2021-06-13  316   * @imem:		Pointer to iosm_imem
51c45fa95435c5 M Chetan Kumar 2021-06-13  317   * @wwan:		Poinetr to iosm_wwan
51c45fa95435c5 M Chetan Kumar 2021-06-13  318   * @ipc_protocol:	Pointer to iosm_protocol
51c45fa95435c5 M Chetan Kumar 2021-06-13  319   * @channel_id:		Channel ID for MUX
51c45fa95435c5 M Chetan Kumar 2021-06-13  320   * @protocol:		Type of the MUX protocol
51c45fa95435c5 M Chetan Kumar 2021-06-13  321   * @ul_flow:		UL Flow type
51c45fa95435c5 M Chetan Kumar 2021-06-13  322   * @nr_sessions:	Number of sessions
51c45fa95435c5 M Chetan Kumar 2021-06-13  323   * @instance_id:	Instance ID
51c45fa95435c5 M Chetan Kumar 2021-06-13  324   * @state:		States of the MUX object
51c45fa95435c5 M Chetan Kumar 2021-06-13  325   * @event:		Initiated actions to change the state of the MUX object
51c45fa95435c5 M Chetan Kumar 2021-06-13  326   * @tx_transaction_id:	Transaction id for the ACB command.
51c45fa95435c5 M Chetan Kumar 2021-06-13  327   * @rr_next_session:	Next session number for round robin.
51c45fa95435c5 M Chetan Kumar 2021-06-13  328   * @ul_adb:		State of the UL ADB/ADGH.
51c45fa95435c5 M Chetan Kumar 2021-06-13  329   * @size_needed:	Variable to store the size needed during ADB preparation
51c45fa95435c5 M Chetan Kumar 2021-06-13  330   * @ul_data_pend_bytes:	Pending UL data to be processed in bytes
51c45fa95435c5 M Chetan Kumar 2021-06-13  331   * @acb:		Temporary ACB state
51c45fa95435c5 M Chetan Kumar 2021-06-13  332   * @wwan_q_offset:	This will hold the offset of the given instance
51c45fa95435c5 M Chetan Kumar 2021-06-13  333   *			Useful while passing or receiving packets from
51c45fa95435c5 M Chetan Kumar 2021-06-13  334   *			wwan/imem layer.
1f52d7b622854b M Chetan Kumar 2022-02-10  335   * @adb_finish_timer:	Timer for forcefully finishing the ADB
1f52d7b622854b M Chetan Kumar 2022-02-10  336   * @acb_tx_sequence_nr: Sequence number for the ACB header.
1f52d7b622854b M Chetan Kumar 2022-02-10  337   * @params:		user configurable parameters
1f52d7b622854b M Chetan Kumar 2022-02-10  338   * @adb_tx_sequence_nr: Sequence number for ADB header
1f52d7b622854b M Chetan Kumar 2022-02-10  339   * @acc_adb_size:       Statistic data for logging
1f52d7b622854b M Chetan Kumar 2022-02-10  340   * @acc_payload_size:   Statistic data for logging
51c45fa95435c5 M Chetan Kumar 2021-06-13  341   * @initialized:	MUX object is initialized
51c45fa95435c5 M Chetan Kumar 2021-06-13  342   * @ev_mux_net_transmit_pending:
51c45fa95435c5 M Chetan Kumar 2021-06-13  343   *			0 means inform the IPC tasklet to pass the
51c45fa95435c5 M Chetan Kumar 2021-06-13  344   *			accumulated uplink ADB to CP.
51c45fa95435c5 M Chetan Kumar 2021-06-13  345   * @adb_prep_ongoing:	Flag for ADB preparation status
51c45fa95435c5 M Chetan Kumar 2021-06-13  346   */
51c45fa95435c5 M Chetan Kumar 2021-06-13  347  struct iosm_mux {
51c45fa95435c5 M Chetan Kumar 2021-06-13  348  	struct device *dev;
51c45fa95435c5 M Chetan Kumar 2021-06-13  349  	struct mux_session session[IPC_MEM_MUX_IP_SESSION_ENTRIES];
51c45fa95435c5 M Chetan Kumar 2021-06-13  350  	struct ipc_mem_channel *channel;
51c45fa95435c5 M Chetan Kumar 2021-06-13  351  	struct iosm_pcie *pcie;
51c45fa95435c5 M Chetan Kumar 2021-06-13  352  	struct iosm_imem *imem;
51c45fa95435c5 M Chetan Kumar 2021-06-13  353  	struct iosm_wwan *wwan;
51c45fa95435c5 M Chetan Kumar 2021-06-13  354  	struct iosm_protocol *ipc_protocol;
51c45fa95435c5 M Chetan Kumar 2021-06-13  355  	int channel_id;
51c45fa95435c5 M Chetan Kumar 2021-06-13  356  	enum ipc_mux_protocol protocol;
51c45fa95435c5 M Chetan Kumar 2021-06-13  357  	enum ipc_mux_ul_flow ul_flow;
51c45fa95435c5 M Chetan Kumar 2021-06-13  358  	int nr_sessions;
51c45fa95435c5 M Chetan Kumar 2021-06-13  359  	int instance_id;
51c45fa95435c5 M Chetan Kumar 2021-06-13  360  	enum mux_state state;
51c45fa95435c5 M Chetan Kumar 2021-06-13  361  	enum mux_event event;
51c45fa95435c5 M Chetan Kumar 2021-06-13  362  	u32 tx_transaction_id;
51c45fa95435c5 M Chetan Kumar 2021-06-13  363  	int rr_next_session;
51c45fa95435c5 M Chetan Kumar 2021-06-13  364  	struct mux_adb ul_adb;
51c45fa95435c5 M Chetan Kumar 2021-06-13  365  	int size_needed;
51c45fa95435c5 M Chetan Kumar 2021-06-13  366  	long long ul_data_pend_bytes;
51c45fa95435c5 M Chetan Kumar 2021-06-13  367  	struct mux_acb acb;
51c45fa95435c5 M Chetan Kumar 2021-06-13  368  	int wwan_q_offset;
1f52d7b622854b M Chetan Kumar 2022-02-10 @369  	struct hrtimer adb_finish_timer;
1f52d7b622854b M Chetan Kumar 2022-02-10  370  	u16 acb_tx_sequence_nr;
1f52d7b622854b M Chetan Kumar 2022-02-10  371  	struct ipc_params *params;
1f52d7b622854b M Chetan Kumar 2022-02-10  372  	u16 adb_tx_sequence_nr;
1f52d7b622854b M Chetan Kumar 2022-02-10  373  	unsigned long long acc_adb_size;
1f52d7b622854b M Chetan Kumar 2022-02-10  374  	unsigned long long acc_payload_size;
51c45fa95435c5 M Chetan Kumar 2021-06-13  375  	u8 initialized:1,
51c45fa95435c5 M Chetan Kumar 2021-06-13  376  	   ev_mux_net_transmit_pending:1,
1f52d7b622854b M Chetan Kumar 2022-02-10  377  	   adb_prep_ongoing;
1f52d7b622854b M Chetan Kumar 2022-02-10  378  } __packed;
51c45fa95435c5 M Chetan Kumar 2021-06-13  379  

:::::: The code at line 369 was first introduced by commit
:::::: 1f52d7b622854b8bd7a1be3de095ca2e1f77098e net: wwan: iosm: Enable M.2 7360 WWAN card support

:::::: TO: M Chetan Kumar <m.chetan.kumar@linux.intel.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
