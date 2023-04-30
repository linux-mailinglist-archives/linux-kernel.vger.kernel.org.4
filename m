Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F116F2A9E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 22:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjD3Ubv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 16:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjD3Ubt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 16:31:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9CAE57
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 13:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682886707; x=1714422707;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s1mgioCZSCdz0fUDhSc5gkRh1hbGcWpMfZ9SF2eqcRY=;
  b=ixKUeLc7lrVkX6bh+GaBb/KQM6kea1oeTSS/I91+QInCc+Q/314zYo5T
   yutzQ5sXvAtMqviZLMj0R2MA7QRbkfU5dTSAoJvl2TmO92HSFwWK/Ojc+
   Yuv8Pf/fG6qymPAVb0PSXbTTiVBgClp9pUSLWEE7Gxxn86zJOXHgHdIls
   ft309F8JGRlkmis9ydzON2akrQNKtOpgdrFFKHVcmsZIPUJ1C5+SW9+rV
   FlmzwaJqoWH4HA92lrX0Me8bKNPh+TmbAYqgQa48PPvQwsOQZdy4SQ5QB
   /y16Y0u/Ln2jzonzh+CWYI5Rshn40JQTZXqKp/hX4VB0nhZBhbkElqO3S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10696"; a="337166818"
X-IronPort-AV: E=Sophos;i="5.99,239,1677571200"; 
   d="scan'208";a="337166818"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2023 13:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10696"; a="726140964"
X-IronPort-AV: E=Sophos;i="5.99,239,1677571200"; 
   d="scan'208";a="726140964"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Apr 2023 13:31:45 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ptDhw-00007J-0t;
        Sun, 30 Apr 2023 20:31:44 +0000
Date:   Mon, 1 May 2023 04:30:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1174:29: error:
 enumerator value for
 'i40e_static_assert_i40e_aqc_cloud_filters_element_data' is not an integer
 constant
Message-ID: <202305010452.f7mWeaXF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   825a0714d2b3883d4f8ff64f6933fb73ee3f1834
commit: df99e7bbbec3180693b3d932a9cbc88346e2a30e ARM: omap1: use pci_remap_iospace() for omap_cf
date:   1 year ago
config: arm-buildonly-randconfig-r001-20230501 (https://download.01.org/0day-ci/archive/20230501/202305010452.f7mWeaXF-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=df99e7bbbec3180693b3d932a9cbc88346e2a30e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout df99e7bbbec3180693b3d932a9cbc88346e2a30e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305010452.f7mWeaXF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/intel/i40e/i40e_adminq.h:9,
                    from drivers/net/ethernet/intel/i40e/i40e_type.h:10,
                    from drivers/net/ethernet/intel/i40e/i40e.h:40,
                    from drivers/net/ethernet/intel/i40e/i40e_main.c:12:
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
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
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
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
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
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
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
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
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
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
>> include/linux/avf/virtchnl.h:391:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_irq_map_info' is not an integer constant
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
>> include/linux/avf/virtchnl.h:484:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_vlan_filter_list' is not an integer constant
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
>> include/linux/avf/virtchnl.h:869:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_key' is not an integer constant
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
>> include/linux/avf/virtchnl.h:877:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_lut' is not an integer constant
     877 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
         |                              ^~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:160:60: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                            ^
--
   In file included from drivers/net/ethernet/intel/i40e/i40e_adminq.h:9,
                    from drivers/net/ethernet/intel/i40e/i40e_type.h:10,
                    from drivers/net/ethernet/intel/i40e/i40e.h:40,
                    from drivers/net/ethernet/intel/i40e/i40e_main.c:12:
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
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
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
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
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
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
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
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
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
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
>> include/linux/avf/virtchnl.h:391:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_irq_map_info' is not an integer constant
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
>> include/linux/avf/virtchnl.h:484:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_vlan_filter_list' is not an integer constant
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
>> include/linux/avf/virtchnl.h:869:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_key' is not an integer constant
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
>> include/linux/avf/virtchnl.h:877:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_lut' is not an integer constant
     877 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
         |                              ^~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:160:60: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                            ^
   In file included from drivers/net/ethernet/intel/i40e/i40e_trace.h:209,
                    from drivers/net/ethernet/intel/i40e/i40e_main.c:22:
   include/trace/define_trace.h:95:42: fatal error: ./i40e_trace.h: No such file or directory
      95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
         |                                          ^
   compilation terminated.


vim +/i40e_static_assert_i40e_aqc_cloud_filters_element_data +1174 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h

56a62fc8689509 Jesse Brandeburg 2013-09-11  1173  
2c0015238f7d35 Amritha Nambiar  2017-10-27 @1174  I40E_CHECK_STRUCT_LEN(0x40, i40e_aqc_cloud_filters_element_data);
2c0015238f7d35 Amritha Nambiar  2017-10-27  1175  
2c0015238f7d35 Amritha Nambiar  2017-10-27  1176  /* i40e_aqc_cloud_filters_element_bb is used when
2c0015238f7d35 Amritha Nambiar  2017-10-27  1177   * I40E_AQC_CLOUD_CMD_BB flag is set.
2c0015238f7d35 Amritha Nambiar  2017-10-27  1178   */
2c0015238f7d35 Amritha Nambiar  2017-10-27  1179  struct i40e_aqc_cloud_filters_element_bb {
2c0015238f7d35 Amritha Nambiar  2017-10-27  1180  	struct i40e_aqc_cloud_filters_element_data element;
2c0015238f7d35 Amritha Nambiar  2017-10-27  1181  	u16     general_fields[32];
2c0015238f7d35 Amritha Nambiar  2017-10-27  1182  #define I40E_AQC_ADD_CLOUD_FV_FLU_0X16_WORD0	15
2c0015238f7d35 Amritha Nambiar  2017-10-27  1183  };
2c0015238f7d35 Amritha Nambiar  2017-10-27  1184  
2c0015238f7d35 Amritha Nambiar  2017-10-27 @1185  I40E_CHECK_STRUCT_LEN(0x80, i40e_aqc_cloud_filters_element_bb);
2c0015238f7d35 Amritha Nambiar  2017-10-27  1186  

:::::: The code at line 1174 was first introduced by commit
:::::: 2c0015238f7d357f179249f101d6ed0327bc642a i40e: Admin queue definitions for cloud filters

:::::: TO: Amritha Nambiar <amritha.nambiar@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
