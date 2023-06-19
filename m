Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEE873497D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 02:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjFSAjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 20:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFSAjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 20:39:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43008137
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 17:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687135137; x=1718671137;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ssQ2QKM8aldJQhHlFukVmKmJTO2N+RnJsdadiIB56vg=;
  b=OG62YhDfjdrGBktxWi5Ms35boWPScPUWd+0mwD6rwMupbxfhrG82dUIZ
   pXfYwwiIUQ7rPb5+MiTfPUHTFJjI6BYp3U8GNHQiJCnho8641ePSZKug7
   0coJ7oYFXdTyAkcV35NpsiHMQ/BJBtoaw2cWa5oKx3A3ITKl1ANDvHcwS
   PxYFTeEWMOORkax+DFsWcFDCFquGDxVtk5RTG/G4KB3D7eJLKDFjd6RPY
   Rpcvvhsh4h+jGDJTjKoKjA+U+lM6N7CWJlHlRJczPCFEihuYm3vdSMlS+
   vsO5sW/KgSW3xHA3jezOG8ERVMWY1gDWCGPJHJyPUlCjc5ovyApg0vZhh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="358391342"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="358391342"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 17:38:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="663801325"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="663801325"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Jun 2023 17:38:55 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qB2v0-00049s-0v;
        Mon, 19 Jun 2023 00:38:54 +0000
Date:   Mon, 19 Jun 2023 08:37:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/linux/compiler_types.h:352:45: error: call to
 '__compiletime_assert_406' declared with attribute error: BUILD_BUG_ON
 failed: sizeof(cmd_a64_entry_t) != 64
Message-ID: <202306190822.TJJHJRv7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   45a3e24f65e90a047bef86f927ebdc4c710edaa1
commit: 250c1a694ff304e5d69e74ab32755eddcc2b8f65 ARM: pxa: convert to multiplatform
date:   1 year, 1 month ago
config: arm-randconfig-r023-20230619 (https://download.01.org/0day-ci/archive/20230619/202306190822.TJJHJRv7-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230619/202306190822.TJJHJRv7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306190822.TJJHJRv7-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/scsi/qla2xxx/qla_os.c: In function 'qla2x00_module_init':
>> include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert_406' declared with attribute error: BUILD_BUG_ON failed: sizeof(cmd_a64_entry_t) != 64
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:333:25: note: in definition of macro '__compiletime_assert'
     333 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_os.c:8033:9: note: in expansion of macro 'BUILD_BUG_ON'
    8033 |         BUILD_BUG_ON(sizeof(cmd_a64_entry_t) != 64);
         |         ^~~~~~~~~~~~
--
   In file included from <command-line>:
   drivers/scsi/qla2xxx/qla_target.c: In function 'qlt_init':
>> include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert_323' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct ctio7_to_24xx) != 64
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:333:25: note: in definition of macro '__compiletime_assert'
     333 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_target.c:7413:9: note: in expansion of macro 'BUILD_BUG_ON'
    7413 |         BUILD_BUG_ON(sizeof(struct ctio7_to_24xx) != 64);
         |         ^~~~~~~~~~~~
--
   In file included from <command-line>:
   drivers/scsi/qla2xxx/tcm_qla2xxx.c: In function 'tcm_qla2xxx_init':
>> include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert_310' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct abts_recv_from_24xx) != 64
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:333:25: note: in definition of macro '__compiletime_assert'
     333 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/scsi/qla2xxx/tcm_qla2xxx.c:1923:9: note: in expansion of macro 'BUILD_BUG_ON'
    1923 |         BUILD_BUG_ON(sizeof(struct abts_recv_from_24xx) != 64);
         |         ^~~~~~~~~~~~
--
   In file included from drivers/net/ethernet/intel/i40e/i40e_adminq.h:9,
                    from drivers/net/ethernet/intel/i40e/i40e_type.h:10,
                    from drivers/net/ethernet/intel/i40e/i40e.h:40,
                    from drivers/net/ethernet/intel/i40e/i40e_ptp.c:4:
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                       ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1174:1: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
    1174 | I40E_CHECK_STRUCT_LEN(0x40, i40e_aqc_cloud_filters_element_data);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1174:29: error: enumerator value for 'i40e_static_assert_i40e_aqc_cloud_filters_element_data' is not an integer constant
    1174 | I40E_CHECK_STRUCT_LEN(0x40, i40e_aqc_cloud_filters_element_data);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:56: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                        ^
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                       ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1185:1: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
    1185 | I40E_CHECK_STRUCT_LEN(0x80, i40e_aqc_cloud_filters_element_bb);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1185:29: error: enumerator value for 'i40e_static_assert_i40e_aqc_cloud_filters_element_bb' is not an integer constant
    1185 | I40E_CHECK_STRUCT_LEN(0x80, i40e_aqc_cloud_filters_element_bb);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:56: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                        ^
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                       ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1506:1: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
    1506 | I40E_CHECK_STRUCT_LEN(0x22, i40e_aqc_configure_partition_bw_data);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1506:29: error: enumerator value for 'i40e_static_assert_i40e_aqc_configure_partition_bw_data' is not an integer constant
    1506 | I40E_CHECK_STRUCT_LEN(0x22, i40e_aqc_configure_partition_bw_data);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:56: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                        ^
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                       ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:306:41: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
     306 | #define I40E_CHECK_CMD_LENGTH(X)        I40E_CHECK_STRUCT_LEN(16, X)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1769:1: note: in expansion of macro 'I40E_CHECK_CMD_LENGTH'
    1769 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1769:23: error: enumerator value for 'i40e_static_assert_i40e_aqc_get_link_status' is not an integer constant
    1769 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:56: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                        ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1769:1: note: in expansion of macro 'I40E_CHECK_CMD_LENGTH'
    1769 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                       ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1908:1: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
    1908 | I40E_CHECK_STRUCT_LEN(0x6, i40e_aqc_nvm_config_data_feature);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1908:28: error: enumerator value for 'i40e_static_assert_i40e_aqc_nvm_config_data_feature' is not an integer constant
    1908 | I40E_CHECK_STRUCT_LEN(0x6, i40e_aqc_nvm_config_data_feature);
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:56: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                        ^
   In file included from drivers/net/ethernet/intel/i40e/i40e_prototype.h:9,
                    from drivers/net/ethernet/intel/i40e/i40e.h:41:
   include/linux/avf/virtchnl.h:160:43: warning: division by zero [-Wdiv-by-zero]
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                           ^
   include/linux/avf/virtchnl.h:391:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     391 | VIRTCHNL_CHECK_STRUCT_LEN(14, virtchnl_irq_map_info);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:391:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_irq_map_info' is not an integer constant
     391 | VIRTCHNL_CHECK_STRUCT_LEN(14, virtchnl_irq_map_info);
         |                               ^~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:160:60: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                            ^
   include/linux/avf/virtchnl.h:160:43: warning: division by zero [-Wdiv-by-zero]
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                           ^
   include/linux/avf/virtchnl.h:484:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     484 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_vlan_filter_list);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:484:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_vlan_filter_list' is not an integer constant
     484 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_vlan_filter_list);
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:160:60: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                            ^
   include/linux/avf/virtchnl.h:160:43: warning: division by zero [-Wdiv-by-zero]
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                           ^
   include/linux/avf/virtchnl.h:869:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     869 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:869:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_key' is not an integer constant
     869 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
         |                              ^~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:160:60: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                            ^
   include/linux/avf/virtchnl.h:160:43: warning: division by zero [-Wdiv-by-zero]
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                           ^
   include/linux/avf/virtchnl.h:877:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     877 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:877:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_lut' is not an integer constant
     877 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
         |                              ^~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:160:60: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                            ^


vim +/__compiletime_assert_406 +352 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  338  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  339  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  340  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  341  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  342  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  343   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  344   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  345   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  346   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  347   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  348   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  349   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  350   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  351  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @352  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  353  

:::::: The code at line 352 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
