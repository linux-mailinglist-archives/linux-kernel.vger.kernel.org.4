Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF7D5E7021
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 01:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiIVXNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 19:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiIVXNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 19:13:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A854D1138E9;
        Thu, 22 Sep 2022 16:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663888429; x=1695424429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YYJtZOcit6qkgm5ch3A2v2ShoL6n5q9+tFdrt48fuV4=;
  b=SSFu5f2X0MVzVi0SWzL7ciIOgKtunBjAN+mS4+PZCGttNG/8FwUZ20V+
   nljPoBXMiHteiKFHn8yeesuXyWhe6v2WG8UWXt8mAPNv1w8mobtP9unIg
   KLVvgo6BJvtb2nHK20GdIEO2iV8pqkON9Pg8QhMSkgZ9hLcrTHv68Upim
   HO0k3ULd2xV/jzCu+F8/w1KlLle1bMfpuUdXds/YLjMg8f8r/PKGOc6FO
   SYW2UqNb+MAHoyPqGuKoQPTOhmqBuDrJY+betFjQmc9GJMD99b30rUcxQ
   m2f6EJQqQXEtBGbsDW+z/NdT9oITlNXCgdb4rjNW4orrjVAtDG7UL4CEV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362263336"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="362263336"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 16:13:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="653187817"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Sep 2022 16:13:46 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obVO5-00054D-2w;
        Thu, 22 Sep 2022 23:13:45 +0000
Date:   Fri, 23 Sep 2022 07:13:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yihao Han <hanyihao@vivo.com>, Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Yihao Han <hanyihao@vivo.com>
Subject: Re: [PATCH] scsi: qla2xxx: fix excluded_middle.cocci warnings
Message-ID: <202209230711.vQKIDdtE-lkp@intel.com>
References: <20220920024554.2606-1-hanyihao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920024554.2606-1-hanyihao@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yihao,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jejb-scsi/for-next]
[also build test ERROR on mkp-scsi/for-next linus/master v6.0-rc6 next-20220921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yihao-Han/scsi-qla2xxx-fix-excluded_middle-cocci-warnings/20220920-104643
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
config: microblaze-randconfig-r032-20220922 (https://download.01.org/0day-ci/archive/20220923/202209230711.vQKIDdtE-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/81672bb39d1900d22e851a7cfb0b9a0aa35df8af
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yihao-Han/scsi-qla2xxx-fix-excluded_middle-cocci-warnings/20220920-104643
        git checkout 81672bb39d1900d22e851a7cfb0b9a0aa35df8af
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/scsi/qla2xxx/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/scsi/qla2xxx/qla_target.c: In function 'qlt_free_session_done':
>> drivers/scsi/qla2xxx/qla_target.c:7409:2: error: unterminated argument list invoking macro "if"
    7409 | }
         |  ^
>> drivers/scsi/qla2xxx/qla_target.c:7410: error: expected '(' at end of input
   drivers/scsi/qla2xxx/qla_target.c:1030:17: note: '-Wmisleading-indentation' is disabled from this point onwards, since column-tracking was disabled due to the size of the code/headers
    1030 |                 if (ha->flags.edif_enabled &&
         |                 ^~
   drivers/scsi/qla2xxx/qla_target.c:1030:17: note: adding '-flarge-source-files' will allow for more column-tracking support, at the expense of compilation time and memory
>> drivers/scsi/qla2xxx/qla_target.c:1030:17: error: expected declaration or statement at end of input
>> drivers/scsi/qla2xxx/qla_target.c:1030:17: error: expected declaration or statement at end of input
   drivers/scsi/qla2xxx/qla_target.c:971:26: warning: unused variable 'base_vha' [-Wunused-variable]
     971 |         scsi_qla_host_t *base_vha = pci_get_drvdata(ha->pdev);
         |                          ^~~~~~~~
>> drivers/scsi/qla2xxx/qla_target.c:970:14: warning: variable 'logout_started' set but not used [-Wunused-but-set-variable]
     970 |         bool logout_started = false;
         |              ^~~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_target.c:969:23: warning: unused variable 'flags' [-Wunused-variable]
     969 |         unsigned long flags;
         |                       ^~~~~
   drivers/scsi/qla2xxx/qla_target.c:966:25: warning: unused variable 'tgt' [-Wunused-variable]
     966 |         struct qla_tgt *tgt = sess->tgt;
         |                         ^~~
   drivers/scsi/qla2xxx/qla_target.c: At top level:
>> drivers/scsi/qla2xxx/qla_target.c:101:13: warning: 'qlt_24xx_atio_pkt' used but never defined
     101 | static void qlt_24xx_atio_pkt(struct scsi_qla_host *ha,
         |             ^~~~~~~~~~~~~~~~~
>> drivers/scsi/qla2xxx/qla_target.c:103:13: warning: 'qlt_response_pkt' used but never defined
     103 | static void qlt_response_pkt(struct scsi_qla_host *ha, struct rsp_que *rsp,
         |             ^~~~~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_target.c:105:12: warning: 'qlt_issue_task_mgmt' declared 'static' but never defined [-Wunused-function]
     105 | static int qlt_issue_task_mgmt(struct fc_port *sess, u64 lun,
         |            ^~~~~~~~~~~~~~~~~~~
>> drivers/scsi/qla2xxx/qla_target.c:107:13: warning: 'qlt_send_term_exchange' used but never defined
     107 | static void qlt_send_term_exchange(struct qla_qpair *, struct qla_tgt_cmd
         |             ^~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_target.c:109:13: warning: 'qlt_alloc_qfull_cmd' declared 'static' but never defined [-Wunused-function]
     109 | static void qlt_alloc_qfull_cmd(struct scsi_qla_host *vha,
         |             ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_target.c:111:13: warning: 'qlt_disable_vha' declared 'static' but never defined [-Wunused-function]
     111 | static void qlt_disable_vha(struct scsi_qla_host *vha);
         |             ^~~~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_target.c:112:13: warning: 'qlt_clear_tgt_db' declared 'static' but never defined [-Wunused-function]
     112 | static void qlt_clear_tgt_db(struct qla_tgt *tgt);
         |             ^~~~~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_target.c:113:13: warning: 'qlt_send_notify_ack' declared 'static' but never defined [-Wunused-function]
     113 | static void qlt_send_notify_ack(struct qla_qpair *qpair,
         |             ^~~~~~~~~~~~~~~~~~~
>> drivers/scsi/qla2xxx/qla_target.c:117:13: warning: 'qlt_send_term_imm_notif' used but never defined
     117 | static void qlt_send_term_imm_notif(struct scsi_qla_host *vha,
         |             ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/qla2xxx/qla_target.c:119:24: warning: 'qlt_create_sess' used but never defined
     119 | static struct fc_port *qlt_create_sess(struct scsi_qla_host *vha,
         |                        ^~~~~~~~~~~~~~~
>> drivers/scsi/qla2xxx/qla_target.c:122:13: warning: 'qlt_24xx_handle_abts' used but never defined
     122 | static void qlt_24xx_handle_abts(struct scsi_qla_host *,
         |             ^~~~~~~~~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_target.c:124:13: warning: 'qlt_send_busy' declared 'static' but never defined [-Wunused-function]
     124 | static void qlt_send_busy(struct qla_qpair *, struct atio_from_isp *,
         |             ^~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_target.c:126:12: warning: 'qlt_check_reserve_free_req' declared 'static' but never defined [-Wunused-function]
     126 | static int qlt_check_reserve_free_req(struct qla_qpair *qpair, uint32_t);
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_target.c:127:24: warning: 'qlt_make_handle' declared 'static' but never defined [-Wunused-function]
     127 | static inline uint32_t qlt_make_handle(struct qla_qpair *);
         |                        ^~~~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_target.c:793:1: warning: 'qlt_plogi_ack_find_add' defined but not used [-Wunused-function]
     793 | qlt_plogi_ack_find_add(struct scsi_qla_host *vha, port_id_t *id,
         | ^~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_target.c:332:13: warning: 'qlt_24xx_atio_pkt_all_vps' defined but not used [-Wunused-function]
     332 | static bool qlt_24xx_atio_pkt_all_vps(struct scsi_qla_host *vha,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_target.c:139:20: warning: 'prot_op_str' defined but not used [-Wunused-function]
     139 | static const char *prot_op_str(u32 prot_op)
         |                    ^~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_target.c:135:33: warning: 'qla_tgt_wq' defined but not used [-Wunused-variable]
     135 | static struct workqueue_struct *qla_tgt_wq;
         |                                 ^~~~~~~~~~
   drivers/scsi/qla2xxx/qla_target.c:134:19: warning: 'qla_tgt_mgmt_cmd_mempool' defined but not used [-Wunused-variable]
     134 | static mempool_t *qla_tgt_mgmt_cmd_mempool;
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_target.c:132:27: warning: 'qla_tgt_mgmt_cmd_cachep' defined but not used [-Wunused-variable]
     132 | static struct kmem_cache *qla_tgt_mgmt_cmd_cachep;
         |                           ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_target.c:61:12: warning: 'tc_sam_status' defined but not used [-Wunused-variable]
      61 | static int tc_sam_status = SAM_STAT_TASK_SET_FULL; /* target core */
         |            ^~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_target.c:60:12: warning: 'qla_sam_status' defined but not used [-Wunused-variable]
      60 | static int qla_sam_status = SAM_STAT_BUSY;
         |            ^~~~~~~~~~~~~~


vim +/if +7409 drivers/scsi/qla2xxx/qla_target.c

2d70c103fd2a066 Nicholas Bellinger 2012-05-15  7399  
2d70c103fd2a066 Nicholas Bellinger 2012-05-15  7400  void qlt_exit(void)
2d70c103fd2a066 Nicholas Bellinger 2012-05-15  7401  {
2d70c103fd2a066 Nicholas Bellinger 2012-05-15  7402  	if (!QLA_TGT_MODE_ENABLED())
2d70c103fd2a066 Nicholas Bellinger 2012-05-15  7403  		return;
2d70c103fd2a066 Nicholas Bellinger 2012-05-15  7404  
2d70c103fd2a066 Nicholas Bellinger 2012-05-15  7405  	destroy_workqueue(qla_tgt_wq);
2d70c103fd2a066 Nicholas Bellinger 2012-05-15  7406  	mempool_destroy(qla_tgt_mgmt_cmd_mempool);
b7bd104e6f1c3be Alexei Potashnik   2015-12-17  7407  	kmem_cache_destroy(qla_tgt_plogi_cachep);
2d70c103fd2a066 Nicholas Bellinger 2012-05-15  7408  	kmem_cache_destroy(qla_tgt_mgmt_cmd_cachep);
2d70c103fd2a066 Nicholas Bellinger 2012-05-15 @7409  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
