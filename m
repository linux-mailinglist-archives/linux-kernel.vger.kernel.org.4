Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D006DCA75
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjDJSJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjDJSJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:09:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E31198C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 11:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681150132; x=1712686132;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aRAiifI4ZZkHlGMbD5DcdUDmnY+ieOjegozrR5b4WfI=;
  b=NHrlTmcH6lT/+uZXBJQxYPwLrBjqizKu6SfbojwY/t/a0WQFhy6ExlJR
   ZgJiEn3UcEb9lv3d6+hcTN1TG3vXkKd8oPYBKo6WDe4AhqslaAE4pGyBy
   Y7Vw4Hd8yVnyscarM0ZkblrNuC0tgCoNVKZ+rcu/YXS5IgTky2RcTr8Xf
   ALnPhPURY3Ko7WnJJub1MqO1QFBoyc+2PDzpwwH4rw7oHp5SEvFOcwuzY
   y/PTGlgR5yfzs7JmAwmZTowXj0NMBV4qMgaUa77T1CHH6MHRH2+rsI5hJ
   djF90C0EW6JqWdKxu7z6zhm+Mq9DR5yZLq2D2LbRzC++V7iWWofejmo9j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="408558198"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="408558198"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 11:08:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="799582798"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="799582798"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2023 11:08:34 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1plvwP-000VZN-17;
        Mon, 10 Apr 2023 18:08:33 +0000
Date:   Tue, 11 Apr 2023 02:07:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/wireless/intersil/hostap/hostap_ap.c:575:36: warning:
 'prism2_ap_proc_seqops' defined but not used
Message-ID: <202304110247.1u15zaZc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
commit: d51269592c327fcfe8ec80fd169a84f8dc0de73b hostap: switch to proc_create_{seq,single}_data
date:   4 years, 11 months ago
config: i386-buildonly-randconfig-r006-20230410 (https://download.01.org/0day-ci/archive/20230411/202304110247.1u15zaZc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d51269592c327fcfe8ec80fd169a84f8dc0de73b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d51269592c327fcfe8ec80fd169a84f8dc0de73b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash M=drivers/net/wireless/intersil/hostap

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304110247.1u15zaZc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/intersil/hostap/hostap_ap.c: In function 'handle_assoc':
   drivers/net/wireless/intersil/hostap/hostap_ap.c:1507:15: warning: variable 'txt' set but not used [-Wunused-but-set-variable]
    1507 |         char *txt = "";
         |               ^~~
   At top level:
   drivers/net/wireless/intersil/hostap/hostap_ap.c:994:12: warning: 'prism2_sta_proc_show' defined but not used [-Wunused-function]
     994 | static int prism2_sta_proc_show(struct seq_file *m, void *v)
         |            ^~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/intersil/hostap/hostap_ap.c:575:36: warning: 'prism2_ap_proc_seqops' defined but not used [-Wunused-const-variable=]
     575 | static const struct seq_operations prism2_ap_proc_seqops = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/intersil/hostap/hostap_ap.c:373:36: warning: 'ap_control_proc_seqops' defined but not used [-Wunused-const-variable=]
     373 | static const struct seq_operations ap_control_proc_seqops = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intersil/hostap/hostap_ap.c:70:12: warning: 'ap_debug_proc_show' defined but not used [-Wunused-function]
      70 | static int ap_debug_proc_show(struct seq_file *m, void *v)
         |            ^~~~~~~~~~~~~~~~~~
--
>> drivers/net/wireless/intersil/hostap/hostap_proc.c:346:36: warning: 'prism2_scan_results_proc_seqops' defined but not used [-Wunused-const-variable=]
     346 | static const struct seq_operations prism2_scan_results_proc_seqops = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intersil/hostap/hostap_proc.c:224:37: warning: 'prism2_aux_dump_proc_fops' defined but not used [-Wunused-const-variable=]
     224 | static const struct file_operations prism2_aux_dump_proc_fops = {
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intersil/hostap/hostap_proc.c:212:37: warning: 'prism2_pda_proc_fops' defined but not used [-Wunused-const-variable=]
     212 | static const struct file_operations prism2_pda_proc_fops = {
         |                                     ^~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intersil/hostap/hostap_proc.c:177:12: warning: 'prism2_crypt_proc_show' defined but not used [-Wunused-function]
     177 | static int prism2_crypt_proc_show(struct seq_file *m, void *v)
         |            ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/intersil/hostap/hostap_proc.c:170:36: warning: 'prism2_bss_list_proc_seqops' defined but not used [-Wunused-const-variable=]
     170 | static const struct seq_operations prism2_bss_list_proc_seqops = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/intersil/hostap/hostap_proc.c:117:36: warning: 'prism2_wds_proc_seqops' defined but not used [-Wunused-const-variable=]
     117 | static const struct seq_operations prism2_wds_proc_seqops = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intersil/hostap/hostap_proc.c:49:12: warning: 'prism2_stats_proc_show' defined but not used [-Wunused-function]
      49 | static int prism2_stats_proc_show(struct seq_file *m, void *v)
         |            ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intersil/hostap/hostap_proc.c:16:12: warning: 'prism2_debug_proc_show' defined but not used [-Wunused-function]
      16 | static int prism2_debug_proc_show(struct seq_file *m, void *v)
         |            ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/wireless/intersil/hostap/hostap_proc.c:10:
   drivers/net/wireless/intersil/hostap/hostap.h:11:19: warning: 'freq_list' defined but not used [-Wunused-const-variable=]
      11 | static const long freq_list[] = { 2412, 2417, 2422, 2427, 2432, 2437, 2442,
         |                   ^~~~~~~~~


vim +/prism2_ap_proc_seqops +575 drivers/net/wireless/intersil/hostap/hostap_ap.c

ff1d2767d5a43c drivers/net/wireless/hostap/hostap_ap.c Jouni Malinen 2005-05-12  574  
6bbefe86796c07 drivers/net/wireless/hostap/hostap_ap.c David Howells 2013-04-10 @575  static const struct seq_operations prism2_ap_proc_seqops = {
6bbefe86796c07 drivers/net/wireless/hostap/hostap_ap.c David Howells 2013-04-10  576  	.start	= prism2_ap_proc_start,
6bbefe86796c07 drivers/net/wireless/hostap/hostap_ap.c David Howells 2013-04-10  577  	.next	= prism2_ap_proc_next,
6bbefe86796c07 drivers/net/wireless/hostap/hostap_ap.c David Howells 2013-04-10  578  	.stop	= prism2_ap_proc_stop,
6bbefe86796c07 drivers/net/wireless/hostap/hostap_ap.c David Howells 2013-04-10  579  	.show	= prism2_ap_proc_show,
6bbefe86796c07 drivers/net/wireless/hostap/hostap_ap.c David Howells 2013-04-10  580  };
ff1d2767d5a43c drivers/net/wireless/hostap/hostap_ap.c Jouni Malinen 2005-05-12  581  #endif /* PRISM2_NO_KERNEL_IEEE80211_MGMT */
ff1d2767d5a43c drivers/net/wireless/hostap/hostap_ap.c Jouni Malinen 2005-05-12  582  
ff1d2767d5a43c drivers/net/wireless/hostap/hostap_ap.c Jouni Malinen 2005-05-12  583  

:::::: The code at line 575 was first introduced by commit
:::::: 6bbefe86796c07fb8a6d28114f1e3f770586ba05 hostap: Don't use create_proc_read_entry()

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
