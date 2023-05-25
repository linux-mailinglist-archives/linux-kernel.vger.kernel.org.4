Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1EC711A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 01:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbjEYXYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 19:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjEYXYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 19:24:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F67612F
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685057046; x=1716593046;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8BVCfyGEv4rfZ9qdMWwjsZnc6llmg9fGP/DcyFWl9jg=;
  b=HnA+ByV76/XjXlbywmS44r/0CC/nZD075t8miVadWghmA+6fwV0sJCvQ
   WqvBkkHnpWoVpmZzvdhmz1ysP4E+LkgljJQsUtVUi3sz1myHzPO8GK7R3
   FYoyatJTC59Rh2Ff2uqxnjEuosa+YRNqPnWhtTRSqwmc1fYY4Cj0e1Qzp
   XpwDGgmKk7s7UkFLsAXOKuecksYXp6Gkr1Y6A9cfkF88b0PKFx9pSGom+
   nOaCjM1ejgAGPHdaOkPT/p8gyOxVKv5+fhY8/9lqEx9jULYHQXmFayuI9
   ERaH8LB3ZJbNbnFGdM2P6/PEilr0DPVICUcpGF9wH4cM6mp6aBDU1xvJr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="334402783"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="334402783"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 16:24:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="708183976"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="708183976"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 25 May 2023 16:24:01 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2KJM-000G7f-27;
        Thu, 25 May 2023 23:24:00 +0000
Date:   Fri, 26 May 2023 07:23:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Smart <jsmart2021@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: drivers/scsi/lpfc/lpfc_ct.c:3113:5: sparse: sparse: symbol
 'lpfc_fdmi_hba_action' was not declared. Should it be static?
Message-ID: <202305260751.NWFvhLY5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5iHgkvvJZpmMG8Ws"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5iHgkvvJZpmMG8Ws
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9db898594c541444e19b2d20fb8a06262cf8fcd9
commit: 045c58c87560b2f9e44fe84e62ce68625a937fa7 scsi: lpfc: Rework FDMI attribute registration for unintential padding
date:   8 months ago
config: x86_64-randconfig-s022-20230525
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=045c58c87560b2f9e44fe84e62ce68625a937fa7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 045c58c87560b2f9e44fe84e62ce68625a937fa7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/scsi/lpfc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305260751.NWFvhLY5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/scsi/lpfc/lpfc_ct.c:3581:15: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:3590:20: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:3609:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:3609:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:3609:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:3609:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:3624:42: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:3638:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:3638:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:3638:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:3638:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:198:25: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_ct.c:199:24: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_ct.c:202:22: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_ct.c:212:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:212:45: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:212:45: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:510:32: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:511:32: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:531:32: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_ct.c:532:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_ct.c:534:30: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_ct.c:880:33: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:882:40: sparse: sparse: restricted __be32 degrades to integer
   drivers/scsi/lpfc/lpfc_ct.c:1032:21: sparse: sparse: restricted __be16 degrades to integer
   drivers/scsi/lpfc/lpfc_ct.c:1047:28: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:1251:21: sparse: sparse: restricted __be16 degrades to integer
   drivers/scsi/lpfc/lpfc_ct.c:1266:28: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:1369:15: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:1395:21: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:1518:15: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:1534:30: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:1535:30: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:1623:19: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:1685:21: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:1706:21: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:1727:21: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:1748:21: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:1781:21: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:1951:25: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_ct.c:1952:24: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_ct.c:1976:22: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_ct.c:1987:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:1987:52: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:1987:52: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:1999:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:1999:52: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:1999:52: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2011:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2011:52: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:2011:52: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2013:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] PortId @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2013:38: sparse:     expected unsigned int [usertype] PortId
   drivers/scsi/lpfc/lpfc_ct.c:2013:38: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2018:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2018:52: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:2018:52: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2020:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] PortId @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2020:38: sparse:     expected unsigned int [usertype] PortId
   drivers/scsi/lpfc/lpfc_ct.c:2020:38: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2026:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2026:52: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:2026:52: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2060:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2060:52: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:2060:52: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2062:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] PortId @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2062:38: sparse:     expected unsigned int [usertype] PortId
   drivers/scsi/lpfc/lpfc_ct.c:2062:38: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2070:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2070:52: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:2070:52: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2072:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] PortId @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2072:39: sparse:     expected unsigned int [usertype] PortId
   drivers/scsi/lpfc/lpfc_ct.c:2072:39: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2081:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2081:52: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:2081:52: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2093:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2093:52: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:2093:52: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2095:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] port_id @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2095:41: sparse:     expected unsigned int [usertype] port_id
   drivers/scsi/lpfc/lpfc_ct.c:2095:41: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2100:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2100:52: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:2100:52: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2102:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] PortId @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2102:38: sparse:     expected unsigned int [usertype] PortId
   drivers/scsi/lpfc/lpfc_ct.c:2102:38: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2264:17: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:2264:17: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:2280:16: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:2281:25: sparse: sparse: restricted __be16 degrades to integer
>> drivers/scsi/lpfc/lpfc_ct.c:3113:5: sparse: sparse: symbol 'lpfc_fdmi_hba_action' was not declared. Should it be static?
>> drivers/scsi/lpfc/lpfc_ct.c:3137:5: sparse: sparse: symbol 'lpfc_fdmi_port_action' was not declared. Should it be static?
   drivers/scsi/lpfc/lpfc_ct.c:3241:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3241:44: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:3241:44: sparse:     got restricted __be16 [usertype]
>> drivers/scsi/lpfc/lpfc_ct.c:3258:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] EntryCnt @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3258:42: sparse:     expected unsigned int [usertype] EntryCnt
   drivers/scsi/lpfc/lpfc_ct.c:3258:42: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:3293:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] EntryCnt @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3293:30: sparse:     expected unsigned int [usertype] EntryCnt
   drivers/scsi/lpfc/lpfc_ct.c:3293:30: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:3353:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] EntryCnt @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3353:34: sparse:     expected unsigned int [usertype] EntryCnt
   drivers/scsi/lpfc/lpfc_ct.c:3353:34: sparse:     got restricted __be32 [usertype]
>> drivers/scsi/lpfc/lpfc_ct.c:3397:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Size:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3397:42: sparse:     expected unsigned int [usertype] Size:16
   drivers/scsi/lpfc/lpfc_ct.c:3397:42: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:3532:34: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:3736:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3736:44: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:3736:44: sparse:     got restricted __be16 [usertype]
>> drivers/scsi/lpfc/lpfc_ct.c:3744:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] PortID @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3744:34: sparse:     expected unsigned int [usertype] PortID
   drivers/scsi/lpfc/lpfc_ct.c:3744:34: sparse:     got restricted __be32 [usertype]
>> drivers/scsi/lpfc/lpfc_ct.c:3747:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] no_of_objects @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3747:36: sparse:     expected unsigned int [usertype] no_of_objects
   drivers/scsi/lpfc/lpfc_ct.c:3747:36: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:3756:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] PortID @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3756:34: sparse:     expected unsigned int [usertype] PortID
   drivers/scsi/lpfc/lpfc_ct.c:3756:34: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:3763:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] PortID @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3763:34: sparse:     expected unsigned int [usertype] PortID
   drivers/scsi/lpfc/lpfc_ct.c:3763:34: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:3766:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] no_of_objects @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3766:36: sparse:     expected unsigned int [usertype] no_of_objects
   drivers/scsi/lpfc/lpfc_ct.c:3766:36: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:3778:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] PortID @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3778:34: sparse:     expected unsigned int [usertype] PortID
   drivers/scsi/lpfc/lpfc_ct.c:3778:34: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:3789:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Size:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3789:42: sparse:     expected unsigned int [usertype] Size:16
   drivers/scsi/lpfc/lpfc_ct.c:3789:42: sparse:     got restricted __be16 [usertype]

vim +/lpfc_fdmi_hba_action +3113 drivers/scsi/lpfc/lpfc_ct.c

8aaa7bcf07a2ee James Smart         2020-10-20  3111  
4258e98ee3862c James Smart         2015-12-16  3112  /* RHBA attribute jump table */
4258e98ee3862c James Smart         2015-12-16 @3113  int (*lpfc_fdmi_hba_action[])
045c58c87560b2 James Smart         2022-09-11  3114  	(struct lpfc_vport *vport, void *attrbuf) = {
4258e98ee3862c James Smart         2015-12-16  3115  	/* Action routine                 Mask bit     Attribute type */
4258e98ee3862c James Smart         2015-12-16  3116  	lpfc_fdmi_hba_attr_wwnn,	  /* bit0     RHBA_NODENAME           */
4258e98ee3862c James Smart         2015-12-16  3117  	lpfc_fdmi_hba_attr_manufacturer,  /* bit1     RHBA_MANUFACTURER       */
4258e98ee3862c James Smart         2015-12-16  3118  	lpfc_fdmi_hba_attr_sn,		  /* bit2     RHBA_SERIAL_NUMBER      */
4258e98ee3862c James Smart         2015-12-16  3119  	lpfc_fdmi_hba_attr_model,	  /* bit3     RHBA_MODEL              */
4258e98ee3862c James Smart         2015-12-16  3120  	lpfc_fdmi_hba_attr_description,	  /* bit4     RHBA_MODEL_DESCRIPTION  */
4258e98ee3862c James Smart         2015-12-16  3121  	lpfc_fdmi_hba_attr_hdw_ver,	  /* bit5     RHBA_HARDWARE_VERSION   */
4258e98ee3862c James Smart         2015-12-16  3122  	lpfc_fdmi_hba_attr_drvr_ver,	  /* bit6     RHBA_DRIVER_VERSION     */
4258e98ee3862c James Smart         2015-12-16  3123  	lpfc_fdmi_hba_attr_rom_ver,	  /* bit7     RHBA_OPTION_ROM_VERSION */
4258e98ee3862c James Smart         2015-12-16  3124  	lpfc_fdmi_hba_attr_fmw_ver,	  /* bit8     RHBA_FIRMWARE_VERSION   */
4258e98ee3862c James Smart         2015-12-16  3125  	lpfc_fdmi_hba_attr_os_ver,	  /* bit9     RHBA_OS_NAME_VERSION    */
4258e98ee3862c James Smart         2015-12-16  3126  	lpfc_fdmi_hba_attr_ct_len,	  /* bit10    RHBA_MAX_CT_PAYLOAD_LEN */
4258e98ee3862c James Smart         2015-12-16  3127  	lpfc_fdmi_hba_attr_symbolic_name, /* bit11    RHBA_SYM_NODENAME       */
4258e98ee3862c James Smart         2015-12-16  3128  	lpfc_fdmi_hba_attr_vendor_info,	  /* bit12    RHBA_VENDOR_INFO        */
4258e98ee3862c James Smart         2015-12-16  3129  	lpfc_fdmi_hba_attr_num_ports,	  /* bit13    RHBA_NUM_PORTS          */
4258e98ee3862c James Smart         2015-12-16  3130  	lpfc_fdmi_hba_attr_fabric_wwnn,	  /* bit14    RHBA_FABRIC_WWNN        */
4258e98ee3862c James Smart         2015-12-16  3131  	lpfc_fdmi_hba_attr_bios_ver,	  /* bit15    RHBA_BIOS_VERSION       */
4258e98ee3862c James Smart         2015-12-16  3132  	lpfc_fdmi_hba_attr_bios_state,	  /* bit16    RHBA_BIOS_STATE         */
4258e98ee3862c James Smart         2015-12-16  3133  	lpfc_fdmi_hba_attr_vendor_id,	  /* bit17    RHBA_VENDOR_ID          */
4258e98ee3862c James Smart         2015-12-16  3134  };
4258e98ee3862c James Smart         2015-12-16  3135  
4258e98ee3862c James Smart         2015-12-16  3136  /* RPA / RPRT attribute jump table */
4258e98ee3862c James Smart         2015-12-16 @3137  int (*lpfc_fdmi_port_action[])
045c58c87560b2 James Smart         2022-09-11  3138  	(struct lpfc_vport *vport, void *attrbuf) = {
4258e98ee3862c James Smart         2015-12-16  3139  	/* Action routine                   Mask bit   Attribute type */
4258e98ee3862c James Smart         2015-12-16  3140  	lpfc_fdmi_port_attr_fc4type,        /* bit0   RPRT_SUPPORT_FC4_TYPES  */
4258e98ee3862c James Smart         2015-12-16  3141  	lpfc_fdmi_port_attr_support_speed,  /* bit1   RPRT_SUPPORTED_SPEED    */
4258e98ee3862c James Smart         2015-12-16  3142  	lpfc_fdmi_port_attr_speed,          /* bit2   RPRT_PORT_SPEED         */
4258e98ee3862c James Smart         2015-12-16  3143  	lpfc_fdmi_port_attr_max_frame,      /* bit3   RPRT_MAX_FRAME_SIZE     */
4258e98ee3862c James Smart         2015-12-16  3144  	lpfc_fdmi_port_attr_os_devname,     /* bit4   RPRT_OS_DEVICE_NAME     */
4258e98ee3862c James Smart         2015-12-16  3145  	lpfc_fdmi_port_attr_host_name,      /* bit5   RPRT_HOST_NAME          */
4258e98ee3862c James Smart         2015-12-16  3146  	lpfc_fdmi_port_attr_wwnn,           /* bit6   RPRT_NODENAME           */
4258e98ee3862c James Smart         2015-12-16  3147  	lpfc_fdmi_port_attr_wwpn,           /* bit7   RPRT_PORTNAME           */
4258e98ee3862c James Smart         2015-12-16  3148  	lpfc_fdmi_port_attr_symbolic_name,  /* bit8   RPRT_SYM_PORTNAME       */
4258e98ee3862c James Smart         2015-12-16  3149  	lpfc_fdmi_port_attr_port_type,      /* bit9   RPRT_PORT_TYPE          */
4258e98ee3862c James Smart         2015-12-16  3150  	lpfc_fdmi_port_attr_class,          /* bit10  RPRT_SUPPORTED_CLASS    */
4258e98ee3862c James Smart         2015-12-16  3151  	lpfc_fdmi_port_attr_fabric_wwpn,    /* bit11  RPRT_FABRICNAME         */
4258e98ee3862c James Smart         2015-12-16  3152  	lpfc_fdmi_port_attr_active_fc4type, /* bit12  RPRT_ACTIVE_FC4_TYPES   */
4258e98ee3862c James Smart         2015-12-16  3153  	lpfc_fdmi_port_attr_port_state,     /* bit13  RPRT_PORT_STATE         */
4258e98ee3862c James Smart         2015-12-16  3154  	lpfc_fdmi_port_attr_num_disc,       /* bit14  RPRT_DISC_PORT          */
4258e98ee3862c James Smart         2015-12-16  3155  	lpfc_fdmi_port_attr_nportid,        /* bit15  RPRT_PORT_ID            */
4258e98ee3862c James Smart         2015-12-16  3156  	lpfc_fdmi_smart_attr_service,       /* bit16  RPRT_SMART_SERVICE      */
4258e98ee3862c James Smart         2015-12-16  3157  	lpfc_fdmi_smart_attr_guid,          /* bit17  RPRT_SMART_GUID         */
4258e98ee3862c James Smart         2015-12-16  3158  	lpfc_fdmi_smart_attr_version,       /* bit18  RPRT_SMART_VERSION      */
4258e98ee3862c James Smart         2015-12-16  3159  	lpfc_fdmi_smart_attr_model,         /* bit19  RPRT_SMART_MODEL        */
4258e98ee3862c James Smart         2015-12-16  3160  	lpfc_fdmi_smart_attr_port_info,     /* bit20  RPRT_SMART_PORT_INFO    */
4258e98ee3862c James Smart         2015-12-16  3161  	lpfc_fdmi_smart_attr_qos,           /* bit21  RPRT_SMART_QOS          */
4258e98ee3862c James Smart         2015-12-16  3162  	lpfc_fdmi_smart_attr_security,      /* bit22  RPRT_SMART_SECURITY     */
8aaa7bcf07a2ee James Smart         2020-10-20  3163  	lpfc_fdmi_vendor_attr_mi,           /* bit23  RPRT_VENDOR_MI          */
4258e98ee3862c James Smart         2015-12-16  3164  };
4258e98ee3862c James Smart         2015-12-16  3165  
4258e98ee3862c James Smart         2015-12-16  3166  /**
4258e98ee3862c James Smart         2015-12-16  3167   * lpfc_fdmi_cmd - Build and send a FDMI cmd to the specified NPort
4258e98ee3862c James Smart         2015-12-16  3168   * @vport: pointer to a host virtual N_Port data structure.
4258e98ee3862c James Smart         2015-12-16  3169   * @ndlp: ndlp to send FDMI cmd to (if NULL use FDMI_DID)
6265bc4a41cd86 Lee Jones           2020-07-21  3170   * @cmdcode: FDMI command to send
6265bc4a41cd86 Lee Jones           2020-07-21  3171   * @new_mask: Mask of HBA or PORT Attributes to send
4258e98ee3862c James Smart         2015-12-16  3172   *
4258e98ee3862c James Smart         2015-12-16  3173   * Builds and sends a FDMI command using the CT subsystem.
4258e98ee3862c James Smart         2015-12-16  3174   */
4258e98ee3862c James Smart         2015-12-16  3175  int
4258e98ee3862c James Smart         2015-12-16  3176  lpfc_fdmi_cmd(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
4258e98ee3862c James Smart         2015-12-16  3177  	      int cmdcode, uint32_t new_mask)
4258e98ee3862c James Smart         2015-12-16  3178  {
4258e98ee3862c James Smart         2015-12-16  3179  	struct lpfc_hba *phba = vport->phba;
d8cdd33a66dc8c James Smart         2022-09-11  3180  	struct lpfc_dmabuf *rq, *rsp;
4258e98ee3862c James Smart         2015-12-16  3181  	struct lpfc_sli_ct_request *CtReq;
d8cdd33a66dc8c James Smart         2022-09-11  3182  	struct ulp_bde64_le *bde;
4258e98ee3862c James Smart         2015-12-16  3183  	uint32_t bit_pos;
045c58c87560b2 James Smart         2022-09-11  3184  	uint32_t size, addsz;
4258e98ee3862c James Smart         2015-12-16  3185  	uint32_t rsp_size;
4258e98ee3862c James Smart         2015-12-16  3186  	uint32_t mask;
4258e98ee3862c James Smart         2015-12-16  3187  	struct lpfc_fdmi_reg_hba *rh;
4258e98ee3862c James Smart         2015-12-16  3188  	struct lpfc_fdmi_port_entry *pe;
2649809cd1b432 James Smart         2022-09-11  3189  	struct lpfc_fdmi_reg_portattr *pab = NULL, *base = NULL;
4258e98ee3862c James Smart         2015-12-16  3190  	struct lpfc_fdmi_attr_block *ab = NULL;
045c58c87560b2 James Smart         2022-09-11  3191  	int  (*func)(struct lpfc_vport *vport, void *attrbuf);
045c58c87560b2 James Smart         2022-09-11  3192  	void (*cmpl)(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
045c58c87560b2 James Smart         2022-09-11  3193  		     struct lpfc_iocbq *rspiocb);
4258e98ee3862c James Smart         2015-12-16  3194  
307e338097dc32 James Smart         2020-11-15  3195  	if (!ndlp)
4258e98ee3862c James Smart         2015-12-16  3196  		return 0;
4258e98ee3862c James Smart         2015-12-16  3197  
4258e98ee3862c James Smart         2015-12-16  3198  	cmpl = lpfc_cmpl_ct_disc_fdmi; /* called from discovery */
4258e98ee3862c James Smart         2015-12-16  3199  
4258e98ee3862c James Smart         2015-12-16  3200  	/* fill in BDEs for command */
4258e98ee3862c James Smart         2015-12-16  3201  	/* Allocate buffer for command payload */
d8cdd33a66dc8c James Smart         2022-09-11  3202  	rq = kmalloc(sizeof(*rq), GFP_KERNEL);
d8cdd33a66dc8c James Smart         2022-09-11  3203  	if (!rq)
4258e98ee3862c James Smart         2015-12-16  3204  		goto fdmi_cmd_exit;
4258e98ee3862c James Smart         2015-12-16  3205  
d8cdd33a66dc8c James Smart         2022-09-11  3206  	rq->virt = lpfc_mbuf_alloc(phba, 0, &rq->phys);
d8cdd33a66dc8c James Smart         2022-09-11  3207  	if (!rq->virt)
d8cdd33a66dc8c James Smart         2022-09-11  3208  		goto fdmi_cmd_free_rq;
4258e98ee3862c James Smart         2015-12-16  3209  
4258e98ee3862c James Smart         2015-12-16  3210  	/* Allocate buffer for Buffer ptr list */
d8cdd33a66dc8c James Smart         2022-09-11  3211  	rsp = kmalloc(sizeof(*rsp), GFP_KERNEL);
d8cdd33a66dc8c James Smart         2022-09-11  3212  	if (!rsp)
d8cdd33a66dc8c James Smart         2022-09-11  3213  		goto fdmi_cmd_free_rqvirt;
4258e98ee3862c James Smart         2015-12-16  3214  
d8cdd33a66dc8c James Smart         2022-09-11  3215  	rsp->virt = lpfc_mbuf_alloc(phba, 0, &rsp->phys);
d8cdd33a66dc8c James Smart         2022-09-11  3216  	if (!rsp->virt)
d8cdd33a66dc8c James Smart         2022-09-11  3217  		goto fdmi_cmd_free_rsp;
4258e98ee3862c James Smart         2015-12-16  3218  
d8cdd33a66dc8c James Smart         2022-09-11  3219  	INIT_LIST_HEAD(&rq->list);
d8cdd33a66dc8c James Smart         2022-09-11  3220  	INIT_LIST_HEAD(&rsp->list);
4258e98ee3862c James Smart         2015-12-16  3221  
2649809cd1b432 James Smart         2022-09-11  3222  	/* mbuf buffers are 1K in length - aka LPFC_BPL_SIZE */
2649809cd1b432 James Smart         2022-09-11  3223  	memset(rq->virt, 0, LPFC_BPL_SIZE);
2649809cd1b432 James Smart         2022-09-11  3224  	rsp_size = LPFC_BPL_SIZE;
2649809cd1b432 James Smart         2022-09-11  3225  
4258e98ee3862c James Smart         2015-12-16  3226  	/* FDMI request */
4258e98ee3862c James Smart         2015-12-16  3227  	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
de3ec318fee323 James Smart         2022-05-05  3228  			 "0218 FDMI Request x%x mask x%x Data: x%x x%x x%x\n",
de3ec318fee323 James Smart         2022-05-05  3229  			 cmdcode, new_mask, vport->fdmi_port_mask,
de3ec318fee323 James Smart         2022-05-05  3230  			 vport->fc_flag, vport->port_state);
de3ec318fee323 James Smart         2022-05-05  3231  
d8cdd33a66dc8c James Smart         2022-09-11  3232  	CtReq = (struct lpfc_sli_ct_request *)rq->virt;
4258e98ee3862c James Smart         2015-12-16  3233  
4258e98ee3862c James Smart         2015-12-16  3234  	/* First populate the CT_IU preamble */
4258e98ee3862c James Smart         2015-12-16  3235  	CtReq->RevisionId.bits.Revision = SLI_CT_REVISION;
4258e98ee3862c James Smart         2015-12-16  3236  	CtReq->RevisionId.bits.InId = 0;
4258e98ee3862c James Smart         2015-12-16  3237  
4258e98ee3862c James Smart         2015-12-16  3238  	CtReq->FsType = SLI_CT_MANAGEMENT_SERVICE;
4258e98ee3862c James Smart         2015-12-16  3239  	CtReq->FsSubType = SLI_CT_FDMI_Subtypes;
4258e98ee3862c James Smart         2015-12-16  3240  
4258e98ee3862c James Smart         2015-12-16  3241  	CtReq->CommandResponse.bits.CmdRsp = cpu_to_be16(cmdcode);
2649809cd1b432 James Smart         2022-09-11  3242  
4258e98ee3862c James Smart         2015-12-16  3243  	size = 0;
4258e98ee3862c James Smart         2015-12-16  3244  
4258e98ee3862c James Smart         2015-12-16  3245  	/* Next fill in the specific FDMI cmd information */
4258e98ee3862c James Smart         2015-12-16  3246  	switch (cmdcode) {
4258e98ee3862c James Smart         2015-12-16  3247  	case SLI_MGMT_RHAT:
4258e98ee3862c James Smart         2015-12-16  3248  	case SLI_MGMT_RHBA:
2649809cd1b432 James Smart         2022-09-11  3249  		rh = (struct lpfc_fdmi_reg_hba *)&CtReq->un;
4258e98ee3862c James Smart         2015-12-16  3250  		/* HBA Identifier */
4258e98ee3862c James Smart         2015-12-16  3251  		memcpy(&rh->hi.PortName, &phba->pport->fc_sparam.portName,
4258e98ee3862c James Smart         2015-12-16  3252  		       sizeof(struct lpfc_name));
2649809cd1b432 James Smart         2022-09-11  3253  		size += sizeof(struct lpfc_fdmi_hba_ident);
4258e98ee3862c James Smart         2015-12-16  3254  
4258e98ee3862c James Smart         2015-12-16  3255  		if (cmdcode == SLI_MGMT_RHBA) {
4258e98ee3862c James Smart         2015-12-16  3256  			/* Registered Port List */
4258e98ee3862c James Smart         2015-12-16  3257  			/* One entry (port) per adapter */
4258e98ee3862c James Smart         2015-12-16 @3258  			rh->rpl.EntryCnt = cpu_to_be32(1);
4cb9e1ddaa145b James Smart         2020-01-27  3259  			memcpy(&rh->rpl.pe.PortName,
4cb9e1ddaa145b James Smart         2020-01-27  3260  			       &phba->pport->fc_sparam.portName,
4258e98ee3862c James Smart         2015-12-16  3261  			       sizeof(struct lpfc_name));
2649809cd1b432 James Smart         2022-09-11  3262  			size += sizeof(struct lpfc_fdmi_reg_port_list);
4258e98ee3862c James Smart         2015-12-16  3263  		}
2649809cd1b432 James Smart         2022-09-11  3264  
4258e98ee3862c James Smart         2015-12-16  3265  		ab = (struct lpfc_fdmi_attr_block *)((uint8_t *)rh + size);
4258e98ee3862c James Smart         2015-12-16  3266  		ab->EntryCnt = 0;
2649809cd1b432 James Smart         2022-09-11  3267  		size += FOURBYTES;	/* add length of EntryCnt field */
2649809cd1b432 James Smart         2022-09-11  3268  
4258e98ee3862c James Smart         2015-12-16  3269  		bit_pos = 0;
4258e98ee3862c James Smart         2015-12-16  3270  		if (new_mask)
4258e98ee3862c James Smart         2015-12-16  3271  			mask = new_mask;
4258e98ee3862c James Smart         2015-12-16  3272  		else
4258e98ee3862c James Smart         2015-12-16  3273  			mask = vport->fdmi_hba_mask;
4258e98ee3862c James Smart         2015-12-16  3274  
4258e98ee3862c James Smart         2015-12-16  3275  		/* Mask will dictate what attributes to build in the request */
4258e98ee3862c James Smart         2015-12-16  3276  		while (mask) {
4258e98ee3862c James Smart         2015-12-16  3277  			if (mask & 0x1) {
4258e98ee3862c James Smart         2015-12-16  3278  				func = lpfc_fdmi_hba_action[bit_pos];
045c58c87560b2 James Smart         2022-09-11  3279  				addsz = func(vport, ((uint8_t *)rh + size));
045c58c87560b2 James Smart         2022-09-11  3280  				if (addsz) {
4258e98ee3862c James Smart         2015-12-16  3281  					ab->EntryCnt++;
045c58c87560b2 James Smart         2022-09-11  3282  					size += addsz;
045c58c87560b2 James Smart         2022-09-11  3283  				}
2649809cd1b432 James Smart         2022-09-11  3284  				/* check if another attribute fits */
045c58c87560b2 James Smart         2022-09-11  3285  				if ((size + FDMI_MAX_ATTRLEN) >
4258e98ee3862c James Smart         2015-12-16  3286  				    (LPFC_BPL_SIZE - LPFC_CT_PREAMBLE))
4258e98ee3862c James Smart         2015-12-16  3287  					goto hba_out;
4258e98ee3862c James Smart         2015-12-16  3288  			}
4258e98ee3862c James Smart         2015-12-16  3289  			mask = mask >> 1;
4258e98ee3862c James Smart         2015-12-16  3290  			bit_pos++;
4258e98ee3862c James Smart         2015-12-16  3291  		}
4258e98ee3862c James Smart         2015-12-16  3292  hba_out:
4258e98ee3862c James Smart         2015-12-16  3293  		ab->EntryCnt = cpu_to_be32(ab->EntryCnt);
4258e98ee3862c James Smart         2015-12-16  3294  		/* Total size */
2649809cd1b432 James Smart         2022-09-11  3295  		size += GID_REQUEST_SZ - 4;
4258e98ee3862c James Smart         2015-12-16  3296  		break;
4258e98ee3862c James Smart         2015-12-16  3297  
4258e98ee3862c James Smart         2015-12-16  3298  	case SLI_MGMT_RPRT:
de3ec318fee323 James Smart         2022-05-05  3299  		if (vport->port_type != LPFC_PHYSICAL_PORT) {
de3ec318fee323 James Smart         2022-05-05  3300  			ndlp = lpfc_findnode_did(phba->pport, FDMI_DID);
de3ec318fee323 James Smart         2022-05-05  3301  			if (!ndlp)
de3ec318fee323 James Smart         2022-05-05  3302  				return 0;
de3ec318fee323 James Smart         2022-05-05  3303  		}
de3ec318fee323 James Smart         2022-05-05  3304  		fallthrough;
4258e98ee3862c James Smart         2015-12-16  3305  	case SLI_MGMT_RPA:
2649809cd1b432 James Smart         2022-09-11  3306  		/* Store base ptr right after preamble */
2649809cd1b432 James Smart         2022-09-11  3307  		base = (struct lpfc_fdmi_reg_portattr *)&CtReq->un;
2649809cd1b432 James Smart         2022-09-11  3308  
4258e98ee3862c James Smart         2015-12-16  3309  		if (cmdcode == SLI_MGMT_RPRT) {
2649809cd1b432 James Smart         2022-09-11  3310  			rh = (struct lpfc_fdmi_reg_hba *)base;
4258e98ee3862c James Smart         2015-12-16  3311  			/* HBA Identifier */
4258e98ee3862c James Smart         2015-12-16  3312  			memcpy(&rh->hi.PortName,
4258e98ee3862c James Smart         2015-12-16  3313  			       &phba->pport->fc_sparam.portName,
4258e98ee3862c James Smart         2015-12-16  3314  			       sizeof(struct lpfc_name));
4258e98ee3862c James Smart         2015-12-16  3315  			pab = (struct lpfc_fdmi_reg_portattr *)
2649809cd1b432 James Smart         2022-09-11  3316  				((uint8_t *)base + sizeof(struct lpfc_name));
2649809cd1b432 James Smart         2022-09-11  3317  			size += sizeof(struct lpfc_name);
2649809cd1b432 James Smart         2022-09-11  3318  		} else {
2649809cd1b432 James Smart         2022-09-11  3319  			pab = base;
4258e98ee3862c James Smart         2015-12-16  3320  		}
4258e98ee3862c James Smart         2015-12-16  3321  
4258e98ee3862c James Smart         2015-12-16  3322  		memcpy((uint8_t *)&pab->PortName,
4258e98ee3862c James Smart         2015-12-16  3323  		       (uint8_t *)&vport->fc_sparam.portName,
4258e98ee3862c James Smart         2015-12-16  3324  		       sizeof(struct lpfc_name));
4258e98ee3862c James Smart         2015-12-16  3325  		pab->ab.EntryCnt = 0;
2649809cd1b432 James Smart         2022-09-11  3326  		/* add length of name and EntryCnt field */
2649809cd1b432 James Smart         2022-09-11  3327  		size += sizeof(struct lpfc_name) + FOURBYTES;
2649809cd1b432 James Smart         2022-09-11  3328  
4258e98ee3862c James Smart         2015-12-16  3329  		bit_pos = 0;
4258e98ee3862c James Smart         2015-12-16  3330  		if (new_mask)
4258e98ee3862c James Smart         2015-12-16  3331  			mask = new_mask;
4258e98ee3862c James Smart         2015-12-16  3332  		else
4258e98ee3862c James Smart         2015-12-16  3333  			mask = vport->fdmi_port_mask;
4258e98ee3862c James Smart         2015-12-16  3334  
4258e98ee3862c James Smart         2015-12-16  3335  		/* Mask will dictate what attributes to build in the request */
4258e98ee3862c James Smart         2015-12-16  3336  		while (mask) {
4258e98ee3862c James Smart         2015-12-16  3337  			if (mask & 0x1) {
4258e98ee3862c James Smart         2015-12-16  3338  				func = lpfc_fdmi_port_action[bit_pos];
045c58c87560b2 James Smart         2022-09-11  3339  				addsz = func(vport, ((uint8_t *)base + size));
045c58c87560b2 James Smart         2022-09-11  3340  				if (addsz) {
76b2c34aeb947a James Smart         2015-04-07  3341  					pab->ab.EntryCnt++;
045c58c87560b2 James Smart         2022-09-11  3342  					size += addsz;
045c58c87560b2 James Smart         2022-09-11  3343  				}
2649809cd1b432 James Smart         2022-09-11  3344  				/* check if another attribute fits */
045c58c87560b2 James Smart         2022-09-11  3345  				if ((size + FDMI_MAX_ATTRLEN) >
4258e98ee3862c James Smart         2015-12-16  3346  				    (LPFC_BPL_SIZE - LPFC_CT_PREAMBLE))
4258e98ee3862c James Smart         2015-12-16  3347  					goto port_out;
4258e98ee3862c James Smart         2015-12-16  3348  			}
4258e98ee3862c James Smart         2015-12-16  3349  			mask = mask >> 1;
4258e98ee3862c James Smart         2015-12-16  3350  			bit_pos++;
4258e98ee3862c James Smart         2015-12-16  3351  		}
76b2c34aeb947a James Smart         2015-04-07  3352  port_out:
76b2c34aeb947a James Smart         2015-04-07  3353  		pab->ab.EntryCnt = cpu_to_be32(pab->ab.EntryCnt);
2649809cd1b432 James Smart         2022-09-11  3354  		size += GID_REQUEST_SZ - 4;
dea3101e0a5c89 James Bottomley     2005-04-17  3355  		break;
dea3101e0a5c89 James Bottomley     2005-04-17  3356  
76b2c34aeb947a James Smart         2015-04-07  3357  	case SLI_MGMT_GHAT:
76b2c34aeb947a James Smart         2015-04-07  3358  	case SLI_MGMT_GRPL:
76b2c34aeb947a James Smart         2015-04-07  3359  		rsp_size = FC_MAX_NS_RSP;
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  3360  		fallthrough;
dea3101e0a5c89 James Bottomley     2005-04-17  3361  	case SLI_MGMT_DHBA:
76b2c34aeb947a James Smart         2015-04-07  3362  	case SLI_MGMT_DHAT:
2649809cd1b432 James Smart         2022-09-11  3363  		pe = (struct lpfc_fdmi_port_entry *)&CtReq->un;
dea3101e0a5c89 James Bottomley     2005-04-17  3364  		memcpy((uint8_t *)&pe->PortName,
2e0fef85e098f6 James Smart         2007-06-17  3365  		       (uint8_t *)&vport->fc_sparam.portName,
dea3101e0a5c89 James Bottomley     2005-04-17  3366  		       sizeof(struct lpfc_name));
dea3101e0a5c89 James Bottomley     2005-04-17  3367  		size = GID_REQUEST_SZ - 4 + sizeof(struct lpfc_name);
dea3101e0a5c89 James Bottomley     2005-04-17  3368  		break;
dea3101e0a5c89 James Bottomley     2005-04-17  3369  
76b2c34aeb947a James Smart         2015-04-07  3370  	case SLI_MGMT_GPAT:
76b2c34aeb947a James Smart         2015-04-07  3371  	case SLI_MGMT_GPAS:
76b2c34aeb947a James Smart         2015-04-07  3372  		rsp_size = FC_MAX_NS_RSP;
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  3373  		fallthrough;
dea3101e0a5c89 James Bottomley     2005-04-17  3374  	case SLI_MGMT_DPRT:
de3ec318fee323 James Smart         2022-05-05  3375  		if (vport->port_type != LPFC_PHYSICAL_PORT) {
de3ec318fee323 James Smart         2022-05-05  3376  			ndlp = lpfc_findnode_did(phba->pport, FDMI_DID);
de3ec318fee323 James Smart         2022-05-05  3377  			if (!ndlp)
de3ec318fee323 James Smart         2022-05-05  3378  				return 0;
de3ec318fee323 James Smart         2022-05-05  3379  		}
de3ec318fee323 James Smart         2022-05-05  3380  		fallthrough;
76b2c34aeb947a James Smart         2015-04-07  3381  	case SLI_MGMT_DPA:
2649809cd1b432 James Smart         2022-09-11  3382  		pe = (struct lpfc_fdmi_port_entry *)&CtReq->un;
dea3101e0a5c89 James Bottomley     2005-04-17  3383  		memcpy((uint8_t *)&pe->PortName,
2e0fef85e098f6 James Smart         2007-06-17  3384  		       (uint8_t *)&vport->fc_sparam.portName,
dea3101e0a5c89 James Bottomley     2005-04-17  3385  		       sizeof(struct lpfc_name));
dea3101e0a5c89 James Bottomley     2005-04-17  3386  		size = GID_REQUEST_SZ - 4 + sizeof(struct lpfc_name);
dea3101e0a5c89 James Bottomley     2005-04-17  3387  		break;
76b2c34aeb947a James Smart         2015-04-07  3388  	case SLI_MGMT_GRHL:
76b2c34aeb947a James Smart         2015-04-07  3389  		size = GID_REQUEST_SZ - 4;
76b2c34aeb947a James Smart         2015-04-07  3390  		break;
76b2c34aeb947a James Smart         2015-04-07  3391  	default:
76b2c34aeb947a James Smart         2015-04-07  3392  		lpfc_printf_vlog(vport, KERN_WARNING, LOG_DISCOVERY,
76b2c34aeb947a James Smart         2015-04-07  3393  				 "0298 FDMI cmdcode x%x not supported\n",
76b2c34aeb947a James Smart         2015-04-07  3394  				 cmdcode);
d8cdd33a66dc8c James Smart         2022-09-11  3395  		goto fdmi_cmd_free_rspvirt;
dea3101e0a5c89 James Bottomley     2005-04-17  3396  	}
76b2c34aeb947a James Smart         2015-04-07  3397  	CtReq->CommandResponse.bits.Size = cpu_to_be16(rsp_size);
dea3101e0a5c89 James Bottomley     2005-04-17  3398  
d8cdd33a66dc8c James Smart         2022-09-11  3399  	bde = (struct ulp_bde64_le *)rsp->virt;
d8cdd33a66dc8c James Smart         2022-09-11  3400  	bde->addr_high = cpu_to_le32(putPaddrHigh(rq->phys));
d8cdd33a66dc8c James Smart         2022-09-11  3401  	bde->addr_low = cpu_to_le32(putPaddrLow(rq->phys));
d8cdd33a66dc8c James Smart         2022-09-11  3402  	bde->type_size = cpu_to_le32(ULP_BDE64_TYPE_BDE_64 <<
d8cdd33a66dc8c James Smart         2022-09-11  3403  				     ULP_BDE64_TYPE_SHIFT);
d8cdd33a66dc8c James Smart         2022-09-11  3404  	bde->type_size |= cpu_to_le32(size);
dea3101e0a5c89 James Bottomley     2005-04-17  3405  
76b2c34aeb947a James Smart         2015-04-07  3406  	/*
76b2c34aeb947a James Smart         2015-04-07  3407  	 * The lpfc_ct_cmd/lpfc_get_req shall increment ndlp reference count
e47c9093531d34 James Smart         2008-02-08  3408  	 * to hold ndlp reference for the corresponding callback function.
e47c9093531d34 James Smart         2008-02-08  3409  	 */
d8cdd33a66dc8c James Smart         2022-09-11  3410  	if (!lpfc_ct_cmd(vport, rq, rsp, ndlp, cmpl, rsp_size, 0))
dea3101e0a5c89 James Bottomley     2005-04-17  3411  		return 0;
dea3101e0a5c89 James Bottomley     2005-04-17  3412  
d8cdd33a66dc8c James Smart         2022-09-11  3413  fdmi_cmd_free_rspvirt:
d8cdd33a66dc8c James Smart         2022-09-11  3414  	lpfc_mbuf_free(phba, rsp->virt, rsp->phys);
d8cdd33a66dc8c James Smart         2022-09-11  3415  fdmi_cmd_free_rsp:
d8cdd33a66dc8c James Smart         2022-09-11  3416  	kfree(rsp);
d8cdd33a66dc8c James Smart         2022-09-11  3417  fdmi_cmd_free_rqvirt:
d8cdd33a66dc8c James Smart         2022-09-11  3418  	lpfc_mbuf_free(phba, rq->virt, rq->phys);
d8cdd33a66dc8c James Smart         2022-09-11  3419  fdmi_cmd_free_rq:
d8cdd33a66dc8c James Smart         2022-09-11  3420  	kfree(rq);
dea3101e0a5c89 James Bottomley     2005-04-17  3421  fdmi_cmd_exit:
dea3101e0a5c89 James Bottomley     2005-04-17  3422  	/* Issue FDMI request failed */
e8b62011d88d6f James Smart         2007-08-02  3423  	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
e8b62011d88d6f James Smart         2007-08-02  3424  			 "0244 Issue FDMI request failed Data: x%x\n",
e8b62011d88d6f James Smart         2007-08-02  3425  			 cmdcode);
dea3101e0a5c89 James Bottomley     2005-04-17  3426  	return 1;
dea3101e0a5c89 James Bottomley     2005-04-17  3427  }
dea3101e0a5c89 James Bottomley     2005-04-17  3428  

:::::: The code at line 3113 was first introduced by commit
:::::: 4258e98ee3862ca7036654b43c839ab7668043e0 lpfc: Modularize and cleanup FDMI code in driver

:::::: TO: James Smart <james.smart@avagotech.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--5iHgkvvJZpmMG8Ws
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.0.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-12) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_CONTEXT_TRACKING_USER=y
CONFIG_CONTEXT_TRACKING_USER_FORCE=y
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# CONFIG_BPF_JIT is not set
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
# CONFIG_PREEMPT_DYNAMIC is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
# CONFIG_TICK_CPU_ACCOUNTING is not set
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_BOOST is not set
CONFIG_RCU_NOCB_CPU=y
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
CONFIG_CGROUP_FAVOR_DYNMODS=y
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
# CONFIG_RD_ZSTD is not set
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_EMBED is not set
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
CONFIG_JAILHOUSE_GUEST=y
CONFIG_ACRN_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_INJECT=y

#
# Performance monitoring
#
# end of Performance monitoring

# CONFIG_X86_16BIT is not set
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_X86_IOPL_IOPERM is not set
CONFIG_X86_MSR=m
# CONFIG_X86_CPUID is not set
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
# CONFIG_MTRR is not set
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_SPECULATION_MITIGATIONS=y
# CONFIG_PAGE_TABLE_ISOLATION is not set
# CONFIG_RETPOLINE is not set
CONFIG_SLS=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_TABLE_LIB=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_EXTLOG is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_STAT is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=m
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=y
CONFIG_CPUFREQ_DT_PLATDEV=y
# CONFIG_X86_INTEL_PSTATE is not set
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
# CONFIG_HALTPOLL_CPUIDLE is not set
# end of CPU Idle
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_PCI_CNB20LE_QUIRK=y
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
CONFIG_X86_X32_ABI=y
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_TRIM_UNUSED_KSYMS=y
CONFIG_UNUSED_KSYMS_WHITELIST=""
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_CGROUP_IOCOST=y
CONFIG_BLK_CGROUP_IOPRIO=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
CONFIG_BLK_SED_OPAL=y
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=m
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_COREDUMP is not set
# end of Executable file formats

#
# Memory Management options
#
# CONFIG_SWAP is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
# CONFIG_BALLOON_COMPACTION is not set
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_KM=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=7
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_GET_FREE_REGION=y
CONFIG_VMAP_PFN=y
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER=y
CONFIG_PTE_MARKER_UFFD_WP=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=y
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_ILA is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
# CONFIG_NETFILTER_NETLINK_QUEUE is not set
# CONFIG_NETFILTER_NETLINK_LOG is not set
# CONFIG_NETFILTER_NETLINK_OSF is not set
# CONFIG_NF_CONNTRACK is not set
# CONFIG_NF_LOG_SYSLOG is not set
# CONFIG_NF_TABLES is not set
# CONFIG_NETFILTER_XTABLES is not set
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV4 is not set
# CONFIG_NF_TPROXY_IPV4 is not set
# CONFIG_NF_DUP_IPV4 is not set
# CONFIG_NF_LOG_ARP is not set
# CONFIG_NF_LOG_IPV4 is not set
# CONFIG_NF_REJECT_IPV4 is not set
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_ARPTABLES is not set
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
# CONFIG_NF_TPROXY_IPV6 is not set
# CONFIG_NF_DUP_IPV6 is not set
# CONFIG_NF_REJECT_IPV6 is not set
# CONFIG_NF_LOG_IPV6 is not set
# CONFIG_IP6_NF_IPTABLES is not set
# end of IPv6: Netfilter Configuration

# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_MRP=y
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=y
CONFIG_IPDDP=m
# CONFIG_IPDDP_ENCAP is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
CONFIG_PHONET=m
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=y
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=y
# CONFIG_MAC802154 is not set
# CONFIG_NET_SCHED is not set
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
CONFIG_BATMAN_ADV_BATMAN_V=y
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
# CONFIG_BATMAN_ADV_NC is not set
CONFIG_BATMAN_ADV_MCAST=y
# CONFIG_BATMAN_ADV_DEBUG is not set
CONFIG_BATMAN_ADV_TRACING=y
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=y
CONFIG_HSR=y
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=m
# CONFIG_ROSE is not set

#
# AX.25 network device drivers
#
CONFIG_MKISS=m
CONFIG_6PACK=m
# CONFIG_BPQETHER is not set
CONFIG_BAYCOM_SER_FDX=m
CONFIG_BAYCOM_SER_HDX=m
CONFIG_YAM=m
# end of AX.25 network device drivers

CONFIG_CAN=y
# CONFIG_CAN_RAW is not set
# CONFIG_CAN_BCM is not set
# CONFIG_CAN_GW is not set
CONFIG_CAN_J1939=y
# CONFIG_CAN_ISOTP is not set
CONFIG_BT=m
# CONFIG_BT_BREDR is not set
# CONFIG_BT_LE is not set
CONFIG_BT_LEDS=y
CONFIG_BT_MSFTEXT=y
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_FEATURE_DEBUG=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_MTK=m
# CONFIG_BT_HCIBTUSB is not set
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_SERDEV=y
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_NOKIA=m
CONFIG_BT_HCIUART_BCSP=y
# CONFIG_BT_HCIUART_ATH3K is not set
CONFIG_BT_HCIUART_LL=y
CONFIG_BT_HCIUART_3WIRE=y
# CONFIG_BT_HCIUART_INTEL is not set
CONFIG_BT_HCIUART_BCM=y
# CONFIG_BT_HCIUART_RTL is not set
# CONFIG_BT_HCIUART_QCA is not set
CONFIG_BT_HCIUART_AG6XX=y
# CONFIG_BT_HCIUART_MRVL is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIDTL1=m
# CONFIG_BT_HCIBT3C is not set
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_MTKSDIO=m
CONFIG_BT_MTKUART=m
CONFIG_BT_VIRTIO=m
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_SPY=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=y
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
# CONFIG_CFG80211_DEFAULT_PS is not set
CONFIG_CFG80211_DEBUGFS=y
# CONFIG_CFG80211_CRDA_SUPPORT is not set
CONFIG_CFG80211_WEXT=y
CONFIG_CFG80211_WEXT_EXPORT=y
CONFIG_LIB80211=y
CONFIG_LIB80211_CRYPT_WEP=y
CONFIG_LIB80211_CRYPT_CCMP=y
CONFIG_LIB80211_CRYPT_TKIP=y
CONFIG_LIB80211_DEBUG=y
# CONFIG_MAC80211 is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_INPUT is not set
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=m
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=m
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=m
# CONFIG_CAIF_USB is not set
# CONFIG_CEPH_LIB is not set
CONFIG_NFC=m
CONFIG_NFC_DIGITAL=m
CONFIG_NFC_NCI=m
CONFIG_NFC_NCI_UART=m
CONFIG_NFC_HCI=m
# CONFIG_NFC_SHDLC is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_MEI_PHY=m
CONFIG_NFC_SIM=m
CONFIG_NFC_PORT100=m
CONFIG_NFC_VIRTUAL_NCI=m
# CONFIG_NFC_FDP is not set
CONFIG_NFC_PN544=m
CONFIG_NFC_PN544_MEI=m
CONFIG_NFC_PN533=m
CONFIG_NFC_PN533_USB=m
CONFIG_NFC_PN533_I2C=m
CONFIG_NFC_PN532_UART=m
CONFIG_NFC_MICROREAD=m
CONFIG_NFC_MICROREAD_MEI=m
CONFIG_NFC_MRVL=m
# CONFIG_NFC_MRVL_USB is not set
CONFIG_NFC_MRVL_UART=m
CONFIG_NFC_MRVL_I2C=m
CONFIG_NFC_ST_NCI=m
CONFIG_NFC_ST_NCI_I2C=m
CONFIG_NFC_NXP_NCI=m
# CONFIG_NFC_NXP_NCI_I2C is not set
CONFIG_NFC_S3FWRN5=m
CONFIG_NFC_S3FWRN5_I2C=m
CONFIG_NFC_S3FWRN82_UART=m
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_DEVLINK=y
CONFIG_FAILOVER=y
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
CONFIG_EISA_PCI_EISA=y
# CONFIG_EISA_VIRTUAL_ROOT is not set
# CONFIG_EISA_NAMES is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
# CONFIG_PCIEAER_INJECT is not set
# CONFIG_PCIE_ECRC is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
CONFIG_PCIE_PTM=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=m
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
# CONFIG_PCIE_BUS_DEFAULT is not set
CONFIG_PCIE_BUS_SAFE=y
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
# CONFIG_VGA_ARB is not set
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_HOTPLUG_PCI_CPCI=y
CONFIG_HOTPLUG_PCI_CPCI_ZT5550=y
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=y
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCIE_CADENCE_PLAT_EP is not set
CONFIG_PCI_J721E=y
CONFIG_PCI_J721E_HOST=y
# CONFIG_PCI_J721E_EP is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
# CONFIG_PCI_EPF_TEST is not set
# CONFIG_PCI_EPF_NTB is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

CONFIG_CXL_BUS=y
# CONFIG_CXL_PCI is not set
CONFIG_CXL_ACPI=y
CONFIG_CXL_PMEM=m
CONFIG_CXL_PORT=y
CONFIG_CXL_REGION=y
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
# CONFIG_YENTA_O2 is not set
# CONFIG_YENTA_RICOH is not set
# CONFIG_YENTA_TI is not set
CONFIG_YENTA_TOSHIBA=y
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_TSI721=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
# CONFIG_RAPIDIO_DMA_ENGINE is not set
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=m
# CONFIG_RAPIDIO_CHMAN is not set
CONFIG_RAPIDIO_MPORT_CDEV=m

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_CPS_XX=m
CONFIG_RAPIDIO_CPS_GEN2=m
# CONFIG_RAPIDIO_RXS_GEN3 is not set
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_FW_LOADER_COMPRESS=y
# CONFIG_FW_LOADER_COMPRESS_XZ is not set
# CONFIG_FW_LOADER_COMPRESS_ZSTD is not set
CONFIG_FW_CACHE=y
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
# CONFIG_PROC_EVENTS is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=m
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=m
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
# CONFIG_GOOGLE_COREBOOT_TABLE is not set
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=m
CONFIG_GNSS_SERIAL=m
CONFIG_GNSS_MTK_SERIAL=m
# CONFIG_GNSS_SIRF_SERIAL is not set
# CONFIG_GNSS_UBX_SERIAL is not set
# CONFIG_GNSS_USB is not set
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=y
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=y
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=y
CONFIG_ZRAM=y
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_ZSTD is not set
# CONFIG_ZRAM_DEF_COMP_LZ4 is not set
# CONFIG_ZRAM_DEF_COMP_LZO is not set
# CONFIG_ZRAM_DEF_COMP_LZ4HC is not set
# CONFIG_ZRAM_DEF_COMP_842 is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_UBLK=m

#
# NVME Support
#
CONFIG_NVME_COMMON=m
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_LOOP is not set
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_TCP is not set
CONFIG_NVME_TARGET_AUTH=y
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=m
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=m
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_HI6421V600_IRQ=m
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=m
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=y
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=m
CONFIG_DS1682=m
CONFIG_SRAM=y
CONFIG_DW_XDATA_PCIE=m
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=m
# CONFIG_HISI_HIKEY_USB is not set
CONFIG_OPEN_DICE=y
# CONFIG_VCPU_STALL_DETECTOR is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=m
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_INTEL_MEI_PXP=m
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
CONFIG_MISC_ALCOR_PCI=y
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
CONFIG_HABANA_AI=m
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=y
CONFIG_PVPANIC_PCI=y
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
# CONFIG_CHR_DEV_SG is not set
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_ENCLOSURE=m
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=y
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
# CONFIG_SCSI_SRP_ATTRS is not set
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=m
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=y
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AHA1740=y
CONFIG_SCSI_AACRAID=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC79XX is not set
CONFIG_SCSI_AIC94XX=m
# CONFIG_AIC94XX_DEBUG is not set
CONFIG_SCSI_MVSAS=y
CONFIG_SCSI_MVSAS_DEBUG=y
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=y
CONFIG_SCSI_ADVANSYS=y
CONFIG_SCSI_ARCMSR=m
CONFIG_SCSI_ESAS2R=m
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=y
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=y
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=y
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=y
CONFIG_SCSI_MPI3MR=m
CONFIG_SCSI_SMARTPQI=m
# CONFIG_SCSI_HPTIOP is not set
CONFIG_SCSI_BUSLOGIC=y
CONFIG_SCSI_FLASHPOINT=y
CONFIG_SCSI_MYRB=m
CONFIG_SCSI_MYRS=m
CONFIG_VMWARE_PVSCSI=m
CONFIG_LIBFC=y
CONFIG_LIBFCOE=m
# CONFIG_FCOE is not set
# CONFIG_FCOE_FNIC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
CONFIG_SCSI_FDOMAIN=m
CONFIG_SCSI_FDOMAIN_PCI=m
CONFIG_SCSI_ISCI=m
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INITIO=m
CONFIG_SCSI_INIA100=y
# CONFIG_SCSI_STEX is not set
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCSI_SYM53C8XX_MMIO=y
CONFIG_SCSI_IPR=y
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
CONFIG_SCSI_LPFC=m
CONFIG_SCSI_LPFC_DEBUG_FS=y
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_DC395x is not set
CONFIG_SCSI_AM53C974=m
CONFIG_SCSI_WD719X=y
CONFIG_SCSI_DEBUG=y
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
CONFIG_SCSI_BFA_FC=y
# CONFIG_SCSI_VIRTIO is not set
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_LOWLEVEL_PCMCIA=y
# CONFIG_PCMCIA_AHA152X is not set
CONFIG_PCMCIA_FDOMAIN=m
# CONFIG_PCMCIA_QLOGIC is not set
CONFIG_PCMCIA_SYM53C500=m
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_AHCI_PLATFORM is not set
# CONFIG_AHCI_CEVA is not set
CONFIG_AHCI_QORIQ=m
CONFIG_SATA_INIC162X=m
CONFIG_SATA_ACARD_AHCI=y
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=y
CONFIG_SATA_DWC=m
# CONFIG_SATA_DWC_OLD_DMA is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=y
# CONFIG_SATA_SIL is not set
CONFIG_SATA_SIS=m
# CONFIG_SATA_SVW is not set
CONFIG_SATA_ULI=y
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=y
# CONFIG_PATA_AMD is not set
CONFIG_PATA_ARTOP=m
# CONFIG_PATA_ATIIXP is not set
CONFIG_PATA_ATP867X=y
# CONFIG_PATA_CMD64X is not set
CONFIG_PATA_CYPRESS=m
CONFIG_PATA_EFAR=m
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
CONFIG_PATA_HPT3X3_DMA=y
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
CONFIG_PATA_JMICRON=m
# CONFIG_PATA_MARVELL is not set
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
# CONFIG_PATA_SERVERWORKS is not set
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=y
# CONFIG_PATA_TOSHIBA is not set
CONFIG_PATA_TRIFLEX=m
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
CONFIG_PATA_MPIIX=m
# CONFIG_PATA_NS87410 is not set
CONFIG_PATA_OPTI=y
# CONFIG_PATA_PCMCIA is not set
CONFIG_PATA_PLATFORM=y
CONFIG_PATA_OF_PLATFORM=y
CONFIG_PATA_RZ1000=m

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
CONFIG_PATA_LEGACY=y
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=m
# CONFIG_TCM_FILEIO is not set
CONFIG_TCM_PSCSI=y
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
# CONFIG_ISCSI_TARGET is not set
CONFIG_SBP_TARGET=y
CONFIG_FUSION=y
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
CONFIG_FIREWIRE_SBP2=m
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=m
# CONFIG_WIREGUARD is not set
CONFIG_EQUALIZER=m
# CONFIG_NET_FC is not set
CONFIG_NET_TEAM=m
# CONFIG_NET_TEAM_MODE_BROADCAST is not set
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
# CONFIG_NET_TEAM_MODE_RANDOM is not set
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=y
# CONFIG_MACVTAP is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
CONFIG_TUN_VNET_CROSS_LE=y
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
CONFIG_ARCNET=m
CONFIG_ARCNET_1201=m
# CONFIG_ARCNET_1051 is not set
CONFIG_ARCNET_RAW=m
CONFIG_ARCNET_CAP=m
# CONFIG_ARCNET_COM90xx is not set
CONFIG_ARCNET_COM90xxIO=m
# CONFIG_ARCNET_RIM_I is not set
CONFIG_ARCNET_COM20020=m
CONFIG_ARCNET_COM20020_PCI=m
CONFIG_ARCNET_COM20020_CS=m
CONFIG_CAIF_DRIVERS=y
CONFIG_CAIF_TTY=m
CONFIG_CAIF_VIRTIO=m
CONFIG_ETHERNET=y
CONFIG_MDIO=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL3=y
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_3C589=m
CONFIG_VORTEX=m
CONFIG_TYPHOON=y
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
CONFIG_ET131X=y
# CONFIG_NET_VENDOR_ALACRITECH is not set
# CONFIG_NET_VENDOR_ALTEON is not set
CONFIG_ALTERA_TSE=y
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_VENDOR_AQUANTIA is not set
CONFIG_NET_VENDOR_ARC=y
# CONFIG_NET_VENDOR_ASIX is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
CONFIG_ATL1E=m
CONFIG_ATL1C=y
# CONFIG_ALX is not set
CONFIG_CX_ECAT=m
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
CONFIG_BCMGENET=m
CONFIG_BNX2=y
CONFIG_CNIC=m
CONFIG_TIGON3=m
# CONFIG_TIGON3_HWMON is not set
# CONFIG_BNX2X is not set
CONFIG_SYSTEMPORT=y
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
# CONFIG_MACB_PCI is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=m
CONFIG_CHELSIO_T1_1G=y
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
CONFIG_CHELSIO_T4VF=m
# CONFIG_NET_VENDOR_CIRRUS is not set
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=y
# CONFIG_NET_VENDOR_CORTINA is not set
CONFIG_NET_VENDOR_DAVICOM=y
CONFIG_DNET=m
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
# CONFIG_BE2NET_HWMON is not set
# CONFIG_BE2NET_BE2 is not set
# CONFIG_BE2NET_BE3 is not set
# CONFIG_BE2NET_LANCER is not set
# CONFIG_BE2NET_SKYHAWK is not set

#
# WARNING: be2net is useless without any enabled chip
#
# CONFIG_NET_VENDOR_ENGLEDER is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
# CONFIG_NET_VENDOR_FUNGIBLE is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_NET_VENDOR_HUAWEI is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
CONFIG_NET_VENDOR_WANGXUN=y
CONFIG_TXGBE=m
CONFIG_JME=m
# CONFIG_NET_VENDOR_LITEX is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
CONFIG_NET_VENDOR_MICREL=y
CONFIG_KS8842=y
# CONFIG_KS8851_MLL is not set
CONFIG_KSZ884X_PCI=y
# CONFIG_NET_VENDOR_MICROCHIP is not set
# CONFIG_NET_VENDOR_MICROSEMI is not set
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
CONFIG_FEALNX=y
# CONFIG_NET_VENDOR_NI is not set
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NATSEMI=m
CONFIG_NS83820=m
# CONFIG_NET_VENDOR_NETERION is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_8390 is not set
CONFIG_NET_VENDOR_NVIDIA=y
CONFIG_FORCEDETH=y
# CONFIG_NET_VENDOR_OKI is not set
CONFIG_ETHOC=y
CONFIG_NET_VENDOR_PACKET_ENGINES=y
CONFIG_HAMACHI=y
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_IONIC=y
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_BROCADE is not set
CONFIG_NET_VENDOR_QUALCOMM=y
CONFIG_QCA7000=y
CONFIG_QCA7000_UART=y
# CONFIG_QCOM_EMAC is not set
CONFIG_RMNET=m
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
CONFIG_NET_VENDOR_SEEQ=y
# CONFIG_NET_VENDOR_SILAN is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
CONFIG_SIS190=y
# CONFIG_NET_VENDOR_SOLARFLARE is not set
# CONFIG_NET_VENDOR_SMSC is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
CONFIG_DWC_XLGMAC=y
CONFIG_DWC_XLGMAC_PCI=m
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
CONFIG_TI_CPSW_PHY_SEL=y
# CONFIG_TLAN is not set
# CONFIG_NET_VENDOR_VERTEXCOM is not set
CONFIG_NET_VENDOR_VIA=y
CONFIG_VIA_RHINE=y
# CONFIG_VIA_RHINE_MMIO is not set
CONFIG_VIA_VELOCITY=y
CONFIG_NET_VENDOR_WIZNET=y
CONFIG_WIZNET_W5100=y
CONFIG_WIZNET_W5300=m
# CONFIG_WIZNET_BUS_DIRECT is not set
CONFIG_WIZNET_BUS_INDIRECT=y
# CONFIG_WIZNET_BUS_ANY is not set
# CONFIG_NET_VENDOR_XILINX is not set
# CONFIG_NET_VENDOR_XIRCOM is not set
CONFIG_FDDI=m
CONFIG_DEFXX=m
CONFIG_SKFP=m
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
CONFIG_LED_TRIGGER_PHY=y
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=m
CONFIG_BROADCOM_PHY=m
# CONFIG_BCM54140_PHY is not set
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM84881_PHY=m
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=y
CONFIG_BCM_NET_PHYPTP=m
# CONFIG_CICADA_PHY is not set
CONFIG_CORTINA_PHY=y
CONFIG_DAVICOM_PHY=m
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
CONFIG_INTEL_XWAY_PHY=m
CONFIG_LSI_ET1011C_PHY=y
# CONFIG_MARVELL_PHY is not set
CONFIG_MARVELL_10G_PHY=y
CONFIG_MARVELL_88X2222_PHY=m
CONFIG_MAXLINEAR_GPHY=y
# CONFIG_MEDIATEK_GE_PHY is not set
CONFIG_MICREL_PHY=m
CONFIG_MICROCHIP_PHY=y
CONFIG_MICROCHIP_T1_PHY=y
CONFIG_MICROSEMI_PHY=m
# CONFIG_MOTORCOMM_PHY is not set
CONFIG_NATIONAL_PHY=m
CONFIG_NXP_C45_TJA11XX_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_AT803X_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=m
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=y
CONFIG_TERANETICS_PHY=m
CONFIG_DP83822_PHY=m
# CONFIG_DP83TC811_PHY is not set
CONFIG_DP83848_PHY=y
CONFIG_DP83867_PHY=m
# CONFIG_DP83869_PHY is not set
CONFIG_DP83TD510_PHY=y
CONFIG_VITESSE_PHY=y
# CONFIG_XILINX_GMII2RGMII is not set
CONFIG_CAN_DEV=m
# CONFIG_CAN_VCAN is not set
CONFIG_CAN_VXCAN=m
# CONFIG_CAN_NETLINK is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_OF_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_BCM_UNIMAC=m
CONFIG_MDIO_CAVIUM=m
CONFIG_MDIO_GPIO=m
CONFIG_MDIO_HISI_FEMAC=m
CONFIG_MDIO_MVUSB=y
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_OCTEON is not set
CONFIG_MDIO_IPQ4019=y
CONFIG_MDIO_IPQ8064=y
CONFIG_MDIO_THUNDER=m

#
# MDIO Multiplexers
#
CONFIG_MDIO_BUS_MUX=y
# CONFIG_MDIO_BUS_MUX_GPIO is not set
CONFIG_MDIO_BUS_MUX_MULTIPLEXER=y
CONFIG_MDIO_BUS_MUX_MMIOREG=y

#
# PCS device drivers
#
# end of PCS device drivers

CONFIG_PPP=m
# CONFIG_PPP_BSDCOMP is not set
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
# CONFIG_PPP_MPPE is not set
CONFIG_PPP_MULTILINK=y
# CONFIG_PPPOE is not set
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
# CONFIG_SLIP_SMART is not set
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
# CONFIG_USB_PEGASUS is not set
CONFIG_USB_RTL8150=y
# CONFIG_USB_RTL8152 is not set
CONFIG_USB_LAN78XX=y
CONFIG_USB_USBNET=m
# CONFIG_USB_NET_AX8817X is not set
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=m
CONFIG_USB_NET_CDC_EEM=m
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
CONFIG_USB_NET_SR9700=m
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
CONFIG_USB_NET_SMSC95XX=m
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
CONFIG_USB_NET_PLUSB=m
CONFIG_USB_NET_MCS7830=m
CONFIG_USB_NET_RNDIS_HOST=m
# CONFIG_USB_NET_CDC_SUBSET is not set
CONFIG_USB_NET_ZAURUS=m
CONFIG_USB_NET_CX82310_ETH=m
# CONFIG_USB_NET_KALMIA is not set
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=y
CONFIG_USB_NET_INT51X1=m
# CONFIG_USB_CDC_PHONET is not set
CONFIG_USB_IPHETH=m
# CONFIG_USB_SIERRA_NET is not set
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
CONFIG_USB_NET_AQC111=m
CONFIG_USB_RTL8153_ECM=m
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
CONFIG_ATH5K_PCI=y
# CONFIG_ATH6KL is not set
# CONFIG_WIL6210 is not set
# CONFIG_WLAN_VENDOR_ATMEL is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_BRCMUTIL=y
CONFIG_BRCMFMAC=y
# CONFIG_BRCMFMAC_USB is not set
# CONFIG_BRCMFMAC_PCIE is not set
# CONFIG_BRCM_TRACING is not set
CONFIG_BRCMDBG=y
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
# CONFIG_AIRO_CS is not set
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_IPW2100=y
CONFIG_IPW2100_MONITOR=y
# CONFIG_IPW2100_DEBUG is not set
CONFIG_IPW2200=y
CONFIG_IPW2200_MONITOR=y
# CONFIG_IPW2200_RADIOTAP is not set
# CONFIG_IPW2200_PROMISCUOUS is not set
# CONFIG_IPW2200_QOS is not set
CONFIG_IPW2200_DEBUG=y
CONFIG_LIBIPW=y
CONFIG_LIBIPW_DEBUG=y
CONFIG_IWLWIFI=y

#
# WARNING: iwlwifi is useless without IWLDVM or IWLMVM
#

#
# Debugging Options
#
CONFIG_IWLWIFI_DEBUG=y
CONFIG_IWLWIFI_DEVICE_TRACING=y
# end of Debugging Options

# CONFIG_IWLMEI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
CONFIG_HOSTAP=m
CONFIG_HOSTAP_FIRMWARE=y
# CONFIG_HOSTAP_FIRMWARE_NVRAM is not set
# CONFIG_HOSTAP_PLX is not set
# CONFIG_HOSTAP_PCI is not set
# CONFIG_HOSTAP_CS is not set
CONFIG_HERMES=m
# CONFIG_HERMES_PRISM is not set
CONFIG_HERMES_CACHE_FW_ON_INIT=y
CONFIG_PLX_HERMES=m
CONFIG_TMD_HERMES=m
# CONFIG_NORTEL_HERMES is not set
CONFIG_PCMCIA_HERMES=m
CONFIG_PCMCIA_SPECTRUM=m
# CONFIG_ORINOCO_USB is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_LIBERTAS=m
# CONFIG_LIBERTAS_USB is not set
CONFIG_LIBERTAS_CS=m
CONFIG_LIBERTAS_SDIO=m
CONFIG_LIBERTAS_DEBUG=y
CONFIG_LIBERTAS_MESH=y
CONFIG_MWIFIEX=m
CONFIG_MWIFIEX_SDIO=m
CONFIG_MWIFIEX_PCIE=m
CONFIG_MWIFIEX_USB=m
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_WLAN_VENDOR_MICROCHIP is not set
CONFIG_WLAN_VENDOR_PURELIFI=y
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_WLAN_VENDOR_REALTEK is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_WLAN_VENDOR_SILABS is not set
# CONFIG_WLAN_VENDOR_ST is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WLAN_VENDOR_ZYDAS is not set
# CONFIG_WLAN_VENDOR_QUANTENNA is not set
CONFIG_PCMCIA_RAYCS=m
CONFIG_PCMCIA_WL3501=m
CONFIG_USB_NET_RNDIS_WLAN=m
CONFIG_VIRT_WIFI=y
CONFIG_WAN=y
CONFIG_HDLC=m
# CONFIG_HDLC_RAW is not set
CONFIG_HDLC_RAW_ETH=m
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
CONFIG_PCI200SYN=m
CONFIG_WANXL=m
# CONFIG_WANXL_BUILD_FIRMWARE is not set
CONFIG_PC300TOO=m
CONFIG_FARSYNC=m
CONFIG_IEEE802154_DRIVERS=y

#
# Wireless WAN
#
CONFIG_WWAN=y
# CONFIG_WWAN_DEBUGFS is not set
# CONFIG_WWAN_HWSIM is not set
CONFIG_RPMSG_WWAN_CTRL=m
CONFIG_MTK_T7XX=m
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_USB4_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=y
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=y
# CONFIG_MISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADP5588=m
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=m
CONFIG_KEYBOARD_QT1070=m
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=m
CONFIG_KEYBOARD_GPIO_POLLED=m
CONFIG_KEYBOARD_TCA6416=m
# CONFIG_KEYBOARD_TCA8418 is not set
CONFIG_KEYBOARD_MATRIX=m
CONFIG_KEYBOARD_LM8323=m
CONFIG_KEYBOARD_LM8333=m
# CONFIG_KEYBOARD_MAX7359 is not set
CONFIG_KEYBOARD_MCS=m
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_NEWTON=m
CONFIG_KEYBOARD_OPENCORES=y
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
CONFIG_KEYBOARD_STOWAWAY=m
CONFIG_KEYBOARD_SUNKBD=m
# CONFIG_KEYBOARD_STMPE is not set
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
CONFIG_KEYBOARD_TWL4030=m
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_KEYBOARD_CROS_EC=m
CONFIG_KEYBOARD_CAP11XX=m
# CONFIG_KEYBOARD_BCM is not set
CONFIG_KEYBOARD_MTK_PMIC=m
CONFIG_KEYBOARD_CYPRESS_SF=m
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=y
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=m
CONFIG_INPUT_TOUCHSCREEN=y
# CONFIG_TOUCHSCREEN_AD7879 is not set
CONFIG_TOUCHSCREEN_AR1021_I2C=y
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
CONFIG_TOUCHSCREEN_BU21013=m
CONFIG_TOUCHSCREEN_BU21029=m
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=y
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
CONFIG_TOUCHSCREEN_CY8CTMA140=y
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
# CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
CONFIG_TOUCHSCREEN_DA9034=m
CONFIG_TOUCHSCREEN_DA9052=m
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
CONFIG_TOUCHSCREEN_HAMPSHIRE=m
CONFIG_TOUCHSCREEN_EETI=m
CONFIG_TOUCHSCREEN_EGALAX=m
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
CONFIG_TOUCHSCREEN_EXC3000=m
CONFIG_TOUCHSCREEN_FUJITSU=y
# CONFIG_TOUCHSCREEN_GOODIX is not set
CONFIG_TOUCHSCREEN_HIDEEP=m
CONFIG_TOUCHSCREEN_HYCON_HY46XX=m
CONFIG_TOUCHSCREEN_ILI210X=y
CONFIG_TOUCHSCREEN_ILITEK=m
# CONFIG_TOUCHSCREEN_S6SY761 is not set
CONFIG_TOUCHSCREEN_GUNZE=m
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=y
CONFIG_TOUCHSCREEN_WACOM_I2C=y
CONFIG_TOUCHSCREEN_MAX11801=m
CONFIG_TOUCHSCREEN_MCS5000=y
# CONFIG_TOUCHSCREEN_MMS114 is not set
CONFIG_TOUCHSCREEN_MELFAS_MIP4=m
CONFIG_TOUCHSCREEN_MSG2638=y
CONFIG_TOUCHSCREEN_MTOUCH=y
CONFIG_TOUCHSCREEN_IMAGIS=y
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
CONFIG_TOUCHSCREEN_INEXIO=m
# CONFIG_TOUCHSCREEN_MK712 is not set
CONFIG_TOUCHSCREEN_PENMOUNT=m
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
CONFIG_TOUCHSCREEN_TOUCHWIN=y
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
CONFIG_TOUCHSCREEN_PIXCIR=m
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
CONFIG_TOUCHSCREEN_WM831X=y
CONFIG_TOUCHSCREEN_USB_COMPOSITE=y
# CONFIG_TOUCHSCREEN_USB_EGALAX is not set
# CONFIG_TOUCHSCREEN_USB_PANJIT is not set
# CONFIG_TOUCHSCREEN_USB_3M is not set
# CONFIG_TOUCHSCREEN_USB_ITM is not set
CONFIG_TOUCHSCREEN_USB_ETURBO=y
CONFIG_TOUCHSCREEN_USB_GUNZE=y
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
# CONFIG_TOUCHSCREEN_USB_IRTOUCH is not set
# CONFIG_TOUCHSCREEN_USB_IDEALTEK is not set
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
# CONFIG_TOUCHSCREEN_USB_GOTOP is not set
CONFIG_TOUCHSCREEN_USB_JASTEC=y
CONFIG_TOUCHSCREEN_USB_ELO=y
# CONFIG_TOUCHSCREEN_USB_E2I is not set
# CONFIG_TOUCHSCREEN_USB_ZYTRONIC is not set
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
# CONFIG_TOUCHSCREEN_USB_NEXIO is not set
# CONFIG_TOUCHSCREEN_USB_EASYTOUCH is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=m
CONFIG_TOUCHSCREEN_TSC_SERIO=m
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
CONFIG_TOUCHSCREEN_RM_TS=m
CONFIG_TOUCHSCREEN_SILEAD=y
CONFIG_TOUCHSCREEN_SIS_I2C=m
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
CONFIG_TOUCHSCREEN_STMPE=m
CONFIG_TOUCHSCREEN_SX8654=y
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
CONFIG_TOUCHSCREEN_ZFORCE=m
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
CONFIG_TOUCHSCREEN_IQS5XX=m
# CONFIG_TOUCHSCREEN_ZINITIX is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=m
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
# CONFIG_RMI4_F30 is not set
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F3A=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=m
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_APBPS2 is not set
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
# CONFIG_GAMEPORT_L4 is not set
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_FM801=y
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=m
CONFIG_SERIAL_8250_EXAR=m
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=m
CONFIG_SERIAL_8250_MID=m
# CONFIG_SERIAL_8250_PERICOM is not set
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
# CONFIG_SERIAL_SIFIVE is not set
CONFIG_SERIAL_LANTIQ=y
CONFIG_SERIAL_LANTIQ_CONSOLE=y
CONFIG_SERIAL_SCCNXP=m
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
CONFIG_SERIAL_RP2=y
CONFIG_SERIAL_RP2_NR_UARTS=32
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=m
CONFIG_SERIAL_MEN_Z135=y
CONFIG_SERIAL_SPRD=y
CONFIG_SERIAL_SPRD_CONSOLE=y
CONFIG_SERIAL_LITEUART=m
CONFIG_SERIAL_LITEUART_MAX_PORTS=1
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_GOLDFISH_TTY=y
CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
CONFIG_NULL_TTY=y
CONFIG_HVC_DRIVER=y
CONFIG_RPMSG_TTY=m
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_TTY_PRINTK=m
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
# CONFIG_IPMI_IPMB is not set
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=m
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
# CONFIG_HW_RANDOM_INTEL is not set
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
# CONFIG_HW_RANDOM_VIA is not set
# CONFIG_HW_RANDOM_VIRTIO is not set
# CONFIG_HW_RANDOM_CCTRNG is not set
CONFIG_HW_RANDOM_XIPHERA=m
CONFIG_APPLICOM=m

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=m
CONFIG_SCR24X=m
CONFIG_IPWIRELESS=m
# end of PCMCIA character devices

CONFIG_MWAVE=m
# CONFIG_DEVMEM is not set
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=m
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=m
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_I2C=m
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TELCLOCK is not set
CONFIG_XILLYBUS_CLASS=m
CONFIG_XILLYBUS=m
CONFIG_XILLYBUS_OF=m
CONFIG_XILLYUSB=m
CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_GPMUX=y
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=m
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=y
# CONFIG_I2C_ALI1535 is not set
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
# CONFIG_I2C_ISCH is not set
CONFIG_I2C_ISMT=y
CONFIG_I2C_PIIX4=m
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_NVIDIA_GPU=y
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
CONFIG_I2C_DESIGNWARE_PCI=y
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
# CONFIG_I2C_KEMPLD is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_DLN2=m
CONFIG_I2C_CP2615=m
CONFIG_I2C_ROBOTFUZZ_OSIF=m
CONFIG_I2C_TAOS_EVM=m
CONFIG_I2C_TINY_USB=y
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# CONFIG_I2C_CROS_EC_TUNNEL is not set
CONFIG_I2C_FSI=m
CONFIG_I2C_VIRTIO=m
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
CONFIG_I2C_SLAVE_TESTUNIT=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
CONFIG_SPMI=m
# CONFIG_SPMI_HISI3670 is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m
# CONFIG_PPS is not set

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# end of PTP clock support

# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=m
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_CADENCE is not set
CONFIG_GPIO_DWAPB=y
CONFIG_GPIO_EXAR=m
# CONFIG_GPIO_FTGPIO010 is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_GRGPIO=y
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_LOGICVC=y
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=m
# CONFIG_GPIO_SIFIVE is not set
CONFIG_GPIO_SYSCON=m
CONFIG_GPIO_VX855=y
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_I8255=m
# CONFIG_GPIO_104_DIO_48E is not set
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=m
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_GPIO_MM=m
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH311X=m
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=m
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_GW_PLD=m
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCA9570=m
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=y
# CONFIG_GPIO_DA9052 is not set
# CONFIG_GPIO_DA9055 is not set
CONFIG_GPIO_DLN2=m
# CONFIG_GPIO_KEMPLD is not set
# CONFIG_GPIO_LP87565 is not set
# CONFIG_GPIO_MAX77620 is not set
# CONFIG_GPIO_PALMAS is not set
# CONFIG_GPIO_STMPE is not set
CONFIG_GPIO_TPS65218=m
# CONFIG_GPIO_TPS6586X is not set
CONFIG_GPIO_TPS65910=y
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_TWL4030=y
# CONFIG_GPIO_TWL6040 is not set
CONFIG_GPIO_WM831X=m
# CONFIG_GPIO_WM8350 is not set
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCI_IDIO_16=m
# CONFIG_GPIO_PCIE_IDIO_24 is not set
CONFIG_GPIO_RDC321X=y
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VIRTIO=m
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=m
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=m
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=m
# CONFIG_W1_SLAVE_DS2408 is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=m
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2430=m
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=m
CONFIG_W1_SLAVE_DS2433_CRC=y
# CONFIG_W1_SLAVE_DS2438 is not set
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_AS3722=y
CONFIG_POWER_RESET_GPIO=y
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_LTC2952 is not set
CONFIG_POWER_RESET_MT6323=y
# CONFIG_POWER_RESET_REGULATOR is not set
CONFIG_POWER_RESET_RESTART=y
# CONFIG_POWER_RESET_SYSCON is not set
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=m
CONFIG_IP5XXX_POWER=y
CONFIG_MAX8925_POWER=y
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
CONFIG_WM8350_POWER=m
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_ACT8945A=y
# CONFIG_BATTERY_CW2015 is not set
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=m
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SAMSUNG_SDI=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9030=m
# CONFIG_BATTERY_DA9052 is not set
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=m
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_ISP1704=y
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=m
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=m
CONFIG_CHARGER_LT3651=m
# CONFIG_CHARGER_LTC4162L is not set
CONFIG_CHARGER_MAX14577=m
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX77976=m
# CONFIG_CHARGER_MT6360 is not set
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ2515X=m
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_BQ256XX=y
CONFIG_CHARGER_SMB347=m
CONFIG_CHARGER_TPS65217=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_CROS_PCHG=m
# CONFIG_CHARGER_UCS1002 is not set
CONFIG_CHARGER_BD99954=y
CONFIG_BATTERY_UG3105=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
# CONFIG_SENSORS_ABITUGURU3 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_AHT10=y
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_CORSAIR_CPRO is not set
CONFIG_SENSORS_CORSAIR_PSU=y
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
# CONFIG_I8K is not set
CONFIG_SENSORS_DA9052_ADC=m
CONFIG_SENSORS_DA9055=m
CONFIG_SENSORS_I5K_AMB=y
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=y
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_GPIO_FAN=m
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=m
# CONFIG_SENSORS_IBMPEX is not set
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
CONFIG_SENSORS_LTC2990=m
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX127=m
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=m
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX31730=y
CONFIG_SENSORS_MAX6620=m
CONFIG_SENSORS_MAX6621=m
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=y
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_MLXREG_FAN=y
CONFIG_SENSORS_TC654=m
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_MR75203=m
CONFIG_SENSORS_LM63=y
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=m
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
CONFIG_SENSORS_NCT7802=m
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_NZXT_KRAKEN2=y
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
CONFIG_SENSORS_BEL_PFE=m
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
CONFIG_SENSORS_FSP_3Y=m
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_DPS920AB=y
CONFIG_SENSORS_INSPUR_IPSPS=y
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_IR36021=m
CONFIG_SENSORS_IR38064=y
CONFIG_SENSORS_IR38064_REGULATOR=y
CONFIG_SENSORS_IRPS5401=y
CONFIG_SENSORS_ISL68137=y
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LT7182S=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=m
CONFIG_SENSORS_MAX15301=y
CONFIG_SENSORS_MAX16064=m
CONFIG_SENSORS_MAX16601=m
# CONFIG_SENSORS_MAX20730 is not set
CONFIG_SENSORS_MAX20751=m
# CONFIG_SENSORS_MAX31785 is not set
# CONFIG_SENSORS_MAX34440 is not set
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_MP2888=y
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
CONFIG_SENSORS_PIM4328=m
# CONFIG_SENSORS_PLI1209BC is not set
CONFIG_SENSORS_PM6764TR=y
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
CONFIG_SENSORS_STPDDC60=m
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=y
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_XDPE152=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_PWM_FAN is not set
CONFIG_SENSORS_SBTSI=y
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=y
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHT4x=y
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_DME1737=m
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=y
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA238=y
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=m
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_TMP464=m
CONFIG_SENSORS_TMP513=y
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=m
# CONFIG_SENSORS_VT1211 is not set
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=m
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=y
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM831X=m
CONFIG_SENSORS_WM8350=m

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_WMI_EC is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_OF is not set
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_THERMAL_MMIO=y
CONFIG_MAX77620_THERMAL=y
CONFIG_DA9062_THERMAL=y

#
# Intel thermal drivers
#
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_INTEL_TCC_COOLING=m
# CONFIG_INTEL_MENLOW is not set
# end of Intel thermal drivers

# CONFIG_TI_SOC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_BD957XMUF_WATCHDOG=m
CONFIG_DA9052_WATCHDOG=y
CONFIG_DA9055_WATCHDOG=y
CONFIG_DA9062_WATCHDOG=y
# CONFIG_GPIO_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=m
CONFIG_MENZ069_WATCHDOG=m
# CONFIG_WDAT_WDT is not set
# CONFIG_WM831X_WATCHDOG is not set
# CONFIG_WM8350_WATCHDOG is not set
CONFIG_XILINX_WATCHDOG=m
CONFIG_ZIIRAVE_WATCHDOG=m
# CONFIG_RAVE_SP_WATCHDOG is not set
CONFIG_MLX_WDT=y
CONFIG_CADENCE_WATCHDOG=m
CONFIG_DW_WATCHDOG=y
CONFIG_RN5T618_WATCHDOG=m
CONFIG_TWL4030_WATCHDOG=m
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_MAX77620_WATCHDOG=y
CONFIG_RETU_WATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
CONFIG_ALIM1535_WDT=y
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
CONFIG_EUROTECH_WDT=y
# CONFIG_IB700_WDT is not set
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=m
CONFIG_I6300ESB_WDT=m
# CONFIG_IE6XX_WDT is not set
CONFIG_ITCO_WDT=m
# CONFIG_ITCO_VENDOR_SUPPORT is not set
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=y
CONFIG_HP_WATCHDOG=y
# CONFIG_HPWDT_NMI_DECODING is not set
CONFIG_KEMPLD_WDT=m
CONFIG_SC1200_WDT=y
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=y
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
CONFIG_SMSC37B787_WDT=y
CONFIG_TQMX86_WDT=y
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=y
CONFIG_W83977F_WDT=m
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=y
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=m
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=m
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC_DEV=m
# CONFIG_MFD_MADERA is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_DLN2=m
# CONFIG_MFD_GATEWORKS_GSC is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_HI6421_PMIC is not set
CONFIG_MFD_HI6421_SPMI=m
CONFIG_HTC_PASIC3=m
# CONFIG_HTC_I2CPLD is not set
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
CONFIG_MFD_IQS62X=m
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=m
CONFIG_MFD_88PM805=m
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77650 is not set
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77714=m
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6360=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_VIPERBOARD=m
CONFIG_MFD_NTXEC=m
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=m
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SIMPLE_MFD_I2C=m
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=m
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_TWL4030_CORE=y
# CONFIG_MFD_TWL4030_AUDIO is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=y
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_CS47L24 is not set
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=m
# CONFIG_MFD_ROHM_BD718XX is not set
# CONFIG_MFD_ROHM_BD71828 is not set
CONFIG_MFD_ROHM_BD957XMUF=y
# CONFIG_MFD_STPMIC1 is not set
# CONFIG_MFD_STMFX is not set
# CONFIG_MFD_ATC260X_I2C is not set
CONFIG_MFD_QCOM_PM8008=m
CONFIG_RAVE_SP_CORE=y
CONFIG_MFD_RSMU_I2C=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_ACT8865=m
# CONFIG_REGULATOR_ACT8945A is not set
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AS3722=m
# CONFIG_REGULATOR_BCM590XX is not set
# CONFIG_REGULATOR_BD957XMUF is not set
CONFIG_REGULATOR_CROS_EC=m
CONFIG_REGULATOR_DA903X=m
CONFIG_REGULATOR_DA9052=y
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9062=y
CONFIG_REGULATOR_DA9121=m
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=m
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_FAN53880=y
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_HI6421V600 is not set
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LP3971=m
CONFIG_REGULATOR_LP3972=m
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP87565=y
# CONFIG_REGULATOR_LTC3589 is not set
# CONFIG_REGULATOR_LTC3676 is not set
# CONFIG_REGULATOR_MAX14577 is not set
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8893 is not set
CONFIG_REGULATOR_MAX8907=m
# CONFIG_REGULATOR_MAX8925 is not set
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX8998 is not set
CONFIG_REGULATOR_MAX20086=m
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MCP16502=m
CONFIG_REGULATOR_MP5416=m
CONFIG_REGULATOR_MP8859=m
CONFIG_REGULATOR_MP886X=y
# CONFIG_REGULATOR_MPQ7920 is not set
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6315=m
CONFIG_REGULATOR_MT6323=y
CONFIG_REGULATOR_MT6358=y
# CONFIG_REGULATOR_MT6359 is not set
# CONFIG_REGULATOR_MT6360 is not set
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PALMAS=y
CONFIG_REGULATOR_PCA9450=m
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PF8X00=m
CONFIG_REGULATOR_PFUZE100=m
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=m
# CONFIG_REGULATOR_QCOM_SPMI is not set
# CONFIG_REGULATOR_QCOM_USB_VBUS is not set
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
CONFIG_REGULATOR_RN5T618=m
CONFIG_REGULATOR_RT4801=m
CONFIG_REGULATOR_RT5190A=m
CONFIG_REGULATOR_RT5759=y
CONFIG_REGULATOR_RT6160=m
CONFIG_REGULATOR_RT6245=m
CONFIG_REGULATOR_RTQ2134=m
CONFIG_REGULATOR_RTMV20=y
CONFIG_REGULATOR_RTQ6752=m
CONFIG_REGULATOR_S2MPA01=y
# CONFIG_REGULATOR_S2MPS11 is not set
# CONFIG_REGULATOR_S5M8767 is not set
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_SLG51000=m
CONFIG_REGULATOR_SY7636A=m
CONFIG_REGULATOR_SY8106A=m
CONFIG_REGULATOR_SY8824X=y
CONFIG_REGULATOR_SY8827N=m
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS6286X is not set
CONFIG_REGULATOR_TPS65023=m
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65132=y
# CONFIG_REGULATOR_TPS65217 is not set
CONFIG_REGULATOR_TPS65218=m
CONFIG_REGULATOR_TPS6586X=m
CONFIG_REGULATOR_TPS65910=m
CONFIG_REGULATOR_TPS65912=y
# CONFIG_REGULATOR_TWL4030 is not set
# CONFIG_REGULATOR_VCTRL is not set
CONFIG_REGULATOR_WM831X=m
# CONFIG_REGULATOR_WM8350 is not set
CONFIG_REGULATOR_WM8994=m
# CONFIG_REGULATOR_QCOM_LABIBB is not set
CONFIG_RC_CORE=y
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
# CONFIG_IR_IMON_DECODER is not set
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=y
# CONFIG_IR_RC6_DECODER is not set
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_SONY_DECODER=y
CONFIG_IR_XMP_DECODER=m
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_RC is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=m
CONFIG_AGP_SIS=y
# CONFIG_AGP_VIA is not set
CONFIG_INTEL_GTT=m
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DEBUG_MM=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
# CONFIG_DRM_FBDEV_EMULATION is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DP_AUX_BUS=y
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=y
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
CONFIG_DRM_I2C_SIL164=y
CONFIG_DRM_I2C_NXP_TDA998X=y
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
# CONFIG_DRM_I915_USERPTR is not set
# CONFIG_DRM_I915_PXP is not set

#
# drm/i915 Debugging
#
CONFIG_DRM_I915_WERROR=y
# CONFIG_DRM_I915_DEBUG is not set
CONFIG_DRM_I915_DEBUG_MMIO=y
CONFIG_DRM_I915_DEBUG_GEM=y
CONFIG_DRM_I915_DEBUG_GEM_ONCE=y
CONFIG_DRM_I915_ERRLOG_GEM=y
# CONFIG_DRM_I915_TRACE_GEM is not set
CONFIG_DRM_I915_TRACE_GTT=y
CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=y
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS=y
CONFIG_DRM_I915_DEBUG_VBLANK_EVADE=y
CONFIG_DRM_I915_DEBUG_RUNTIME_PM=y
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=y
CONFIG_DRM_VMWGFX_MKSSTATS=y
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_RCAR_DW_HDMI is not set
CONFIG_DRM_RCAR_USE_LVDS=y
# CONFIG_DRM_RCAR_MIPI_DSI is not set
CONFIG_DRM_QXL=m
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
# CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596 is not set
CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0=y
CONFIG_DRM_PANEL_BOE_HIMAX8279D=m
CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=y
# CONFIG_DRM_PANEL_DSI_CM is not set
CONFIG_DRM_PANEL_LVDS=y
# CONFIG_DRM_PANEL_SIMPLE is not set
CONFIG_DRM_PANEL_EDP=m
CONFIG_DRM_PANEL_EBBG_FT8719=y
CONFIG_DRM_PANEL_ELIDA_KD35T133=y
CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02=m
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=m
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=m
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
# CONFIG_DRM_PANEL_JDI_R63452 is not set
CONFIG_DRM_PANEL_KHADAS_TS050=m
# CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W=m
CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=y
CONFIG_DRM_PANEL_NOVATEK_NT35510=m
CONFIG_DRM_PANEL_NOVATEK_NT35560=y
# CONFIG_DRM_PANEL_NOVATEK_NT35950 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT36672A is not set
# CONFIG_DRM_PANEL_MANTIX_MLAF057WE51 is not set
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=y
# CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
# CONFIG_DRM_PANEL_RAYDIUM_RM67191 is not set
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
CONFIG_DRM_PANEL_RONBO_RB070D30=y
# CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=y
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
CONFIG_DRM_PANEL_SAMSUNG_SOFEF00=m
CONFIG_DRM_PANEL_SEIKO_43WVF1G=m
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
CONFIG_DRM_PANEL_SHARP_LS037V7DW01=y
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=m
# CONFIG_DRM_PANEL_SHARP_LS060T1SX01 is not set
CONFIG_DRM_PANEL_SITRONIX_ST7701=y
CONFIG_DRM_PANEL_SITRONIX_ST7703=m
CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521=m
CONFIG_DRM_PANEL_TDO_TL070WSH30=m
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
CONFIG_DRM_PANEL_VISIONOX_RM69299=m
CONFIG_DRM_PANEL_XINPENG_XPP055C272=y
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_CDNS_DSI=y
# CONFIG_DRM_CHIPONE_ICN6211 is not set
CONFIG_DRM_CHRONTEL_CH7033=y
CONFIG_DRM_DISPLAY_CONNECTOR=m
CONFIG_DRM_ITE_IT6505=y
# CONFIG_DRM_LONTIUM_LT8912B is not set
# CONFIG_DRM_LONTIUM_LT9211 is not set
# CONFIG_DRM_LONTIUM_LT9611 is not set
# CONFIG_DRM_LONTIUM_LT9611UXC is not set
CONFIG_DRM_ITE_IT66121=m
CONFIG_DRM_LVDS_CODEC=y
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
CONFIG_DRM_NWL_MIPI_DSI=y
CONFIG_DRM_NXP_PTN3460=y
# CONFIG_DRM_PARADE_PS8622 is not set
# CONFIG_DRM_PARADE_PS8640 is not set
# CONFIG_DRM_SIL_SII8620 is not set
CONFIG_DRM_SII902X=y
CONFIG_DRM_SII9234=y
CONFIG_DRM_SIMPLE_BRIDGE=m
# CONFIG_DRM_THINE_THC63LVD1024 is not set
CONFIG_DRM_TOSHIBA_TC358762=m
CONFIG_DRM_TOSHIBA_TC358764=m
CONFIG_DRM_TOSHIBA_TC358767=y
# CONFIG_DRM_TOSHIBA_TC358768 is not set
CONFIG_DRM_TOSHIBA_TC358775=m
CONFIG_DRM_TI_DLPC3433=y
CONFIG_DRM_TI_TFP410=m
CONFIG_DRM_TI_SN65DSI83=m
CONFIG_DRM_TI_SN65DSI86=m
CONFIG_DRM_TI_TPD12S015=m
CONFIG_DRM_ANALOGIX_ANX6345=y
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_ANALOGIX_DP=y
CONFIG_DRM_ANALOGIX_ANX7625=y
CONFIG_DRM_I2C_ADV7511=m
CONFIG_DRM_I2C_ADV7511_CEC=y
CONFIG_DRM_CDNS_MHDP8546=m
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=y
CONFIG_DRM_ETNAVIV_THERMAL=y
# CONFIG_DRM_LOGICVC is not set
# CONFIG_DRM_MXSFB is not set
# CONFIG_DRM_IMX_LCDIF is not set
CONFIG_DRM_ARCPGU=y
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_GM12U320=y
CONFIG_DRM_SIMPLEDRM=y
CONFIG_DRM_VBOXVIDEO=y
CONFIG_DRM_GUD=y
CONFIG_DRM_SSD130X=y
CONFIG_DRM_SSD130X_I2C=y
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
CONFIG_FB_BOTH_ENDIAN=y
# CONFIG_FB_BIG_ENDIAN is not set
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
CONFIG_FB_PM2=y
CONFIG_FB_PM2_FIFO_DISCONNECT=y
CONFIG_FB_CYBER2000=y
CONFIG_FB_CYBER2000_DDC=y
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_UVESA=m
# CONFIG_FB_VESA is not set
CONFIG_FB_N411=m
CONFIG_FB_HGA=m
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=y
# CONFIG_FB_NVIDIA_I2C is not set
CONFIG_FB_NVIDIA_DEBUG=y
# CONFIG_FB_NVIDIA_BACKLIGHT is not set
CONFIG_FB_RIVA=m
CONFIG_FB_RIVA_I2C=y
CONFIG_FB_RIVA_DEBUG=y
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_I740=m
# CONFIG_FB_LE80578 is not set
CONFIG_FB_INTEL=m
CONFIG_FB_INTEL_DEBUG=y
CONFIG_FB_INTEL_I2C=y
CONFIG_FB_MATROX=m
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
# CONFIG_FB_MATROX_G is not set
# CONFIG_FB_MATROX_I2C is not set
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=m
# CONFIG_FB_ATY128_BACKLIGHT is not set
# CONFIG_FB_ATY is not set
CONFIG_FB_S3=m
CONFIG_FB_S3_DDC=y
CONFIG_FB_SAVAGE=y
# CONFIG_FB_SAVAGE_I2C is not set
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=y
# CONFIG_FB_SIS_300 is not set
CONFIG_FB_SIS_315=y
CONFIG_FB_VIA=y
CONFIG_FB_VIA_DIRECT_PROCFS=y
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
CONFIG_FB_3DFX=y
# CONFIG_FB_3DFX_ACCEL is not set
CONFIG_FB_3DFX_I2C=y
CONFIG_FB_VOODOO1=m
CONFIG_FB_VT8623=m
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
# CONFIG_FB_CARMINE is not set
CONFIG_FB_SM501=m
CONFIG_FB_SMSCUFX=y
CONFIG_FB_UDL=m
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=m
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
CONFIG_FB_MB862XX=m
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=m
# CONFIG_BACKLIGHT_PWM is not set
# CONFIG_BACKLIGHT_DA903X is not set
CONFIG_BACKLIGHT_DA9052=m
# CONFIG_BACKLIGHT_MAX8925 is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=m
CONFIG_BACKLIGHT_SAHARA=m
CONFIG_BACKLIGHT_WM831X=m
CONFIG_BACKLIGHT_ADP8860=m
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_PCF50633=m
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_PANDORA=y
# CONFIG_BACKLIGHT_SKY81452 is not set
# CONFIG_BACKLIGHT_TPS65217 is not set
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=m
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=m
# CONFIG_BACKLIGHT_RAVE_SP is not set
CONFIG_BACKLIGHT_LED=m
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=m
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=y
CONFIG_HID_ASUS=y
CONFIG_HID_AUREAL=m
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
CONFIG_HID_BIGBEN_FF=y
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
CONFIG_HID_CORSAIR=m
# CONFIG_HID_COUGAR is not set
CONFIG_HID_MACALLY=y
CONFIG_HID_CMEDIA=m
CONFIG_HID_CP2112=m
CONFIG_HID_CREATIVE_SB0540=m
CONFIG_HID_CYPRESS=m
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=y
CONFIG_HID_ELO=y
CONFIG_HID_EZKEY=m
CONFIG_HID_FT260=y
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
CONFIG_HID_GLORIOUS=m
CONFIG_HID_HOLTEK=m
CONFIG_HOLTEK_FF=y
CONFIG_HID_VIVALDI_COMMON=m
CONFIG_HID_GOOGLE_HAMMER=m
# CONFIG_HID_VIVALDI is not set
CONFIG_HID_GT683R=m
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=y
CONFIG_HID_UCLOGIC=m
# CONFIG_HID_WALTOP is not set
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_XIAOMI=m
CONFIG_HID_GYRATION=y
# CONFIG_HID_ICADE is not set
CONFIG_HID_ITE=m
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=y
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
# CONFIG_HID_LOGITECH_DJ is not set
CONFIG_HID_LOGITECH_HIDPP=m
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
CONFIG_LOGIG940_FF=y
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=m
# CONFIG_HID_MALTRON is not set
CONFIG_HID_MAYFLASH=m
CONFIG_HID_MEGAWORLD_FF=y
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NINTENDO=y
CONFIG_NINTENDO_FF=y
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
CONFIG_HID_PICOLCD_LEDS=y
# CONFIG_HID_PICOLCD_CIR is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PLAYSTATION is not set
CONFIG_HID_RAZER=m
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_RETRODE=m
CONFIG_HID_ROCCAT=y
CONFIG_HID_SAITEK=m
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
CONFIG_HID_SONY=y
CONFIG_SONY_FF=y
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEAM=m
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=m
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_U2FZERO=m
CONFIG_HID_WACOM=y
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=y
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
CONFIG_HID_ALPS=y
CONFIG_HID_MCP2221=m
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
CONFIG_I2C_HID_OF=m
# CONFIG_I2C_HID_OF_ELAN is not set
CONFIG_I2C_HID_OF_GOODIX=m
# end of I2C HID support

CONFIG_I2C_HID_CORE=m

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER=m
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_CONN_GPIO=m
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
# CONFIG_USB_PCI is not set
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_FEW_INIT_RETRIES is not set
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=m
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_FSL=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_U132_HCD=y
CONFIG_USB_SL811_HCD=m
CONFIG_USB_SL811_HCD_ISO=y
# CONFIG_USB_SL811_CS is not set
CONFIG_USB_R8A66597_HCD=m
CONFIG_USB_HCD_SSB=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
# CONFIG_USB_STORAGE_JUMPSHOT is not set
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
CONFIG_USB_STORAGE_ENE_UB6250=m
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
CONFIG_USB_MUSB_HDRC=m
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=m
CONFIG_USB_DWC3_ULPI=y
CONFIG_USB_DWC3_HOST=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_OF_SIMPLE=m
# CONFIG_USB_DWC2 is not set
CONFIG_USB_CHIPIDEA=y
CONFIG_USB_CHIPIDEA_HOST=y
CONFIG_USB_CHIPIDEA_MSM=y
CONFIG_USB_CHIPIDEA_IMX=m
# CONFIG_USB_CHIPIDEA_GENERIC is not set
CONFIG_USB_CHIPIDEA_TEGRA=m
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_SIMPLE=m
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
# CONFIG_USB_SERIAL_BELKIN is not set
CONFIG_USB_SERIAL_CH341=m
# CONFIG_USB_SERIAL_WHITEHEAT is not set
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=y
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=y
CONFIG_USB_SERIAL_IPAQ=y
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=y
CONFIG_USB_SERIAL_F81232=m
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=y
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=y
CONFIG_USB_SERIAL_KLSI=y
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
CONFIG_USB_SERIAL_MCT_U232=y
CONFIG_USB_SERIAL_METRO=m
# CONFIG_USB_SERIAL_MOS7720 is not set
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
CONFIG_USB_SERIAL_PL2303=y
CONFIG_USB_SERIAL_OTI6858=y
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
CONFIG_USB_SERIAL_SPCP8X5=y
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
CONFIG_USB_SERIAL_SYMBOL=m
CONFIG_USB_SERIAL_TI=y
# CONFIG_USB_SERIAL_CYBERJACK is not set
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=y
CONFIG_USB_SERIAL_WISHBONE=y
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
CONFIG_USB_SERIAL_UPD78F0730=m
CONFIG_USB_SERIAL_XR=y
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=y
CONFIG_USB_SEVSEG=y
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_CYPRESS_CY7C63=m
CONFIG_USB_CYTHERM=y
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=m
CONFIG_APPLE_MFI_FASTCHARGE=y
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_LD=y
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=m
CONFIG_USB_HSIC_USB4604=y
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ONBOARD_HUB=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=m
CONFIG_USB_GPIO_VBUS=y
CONFIG_TAHVO_USB=m
# CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=m
CONFIG_TYPEC_TCPM=m
CONFIG_TYPEC_TCPCI=m
CONFIG_TYPEC_RT1711H=m
CONFIG_TYPEC_MT6360=m
# CONFIG_TYPEC_TCPCI_MAXIM is not set
CONFIG_TYPEC_FUSB302=m
CONFIG_TYPEC_UCSI=m
CONFIG_UCSI_CCG=m
# CONFIG_UCSI_ACPI is not set
# CONFIG_UCSI_STM32G0 is not set
CONFIG_TYPEC_TPS6598X=m
# CONFIG_TYPEC_ANX7411 is not set
CONFIG_TYPEC_RT1719=m
# CONFIG_TYPEC_HD3SS3220 is not set
CONFIG_TYPEC_STUSB160X=m
CONFIG_TYPEC_WUSB3801=m

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_FSA4480=m
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_MMC=m
# CONFIG_PWRSEQ_EMMC is not set
# CONFIG_PWRSEQ_SD8787 is not set
CONFIG_PWRSEQ_SIMPLE=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
# CONFIG_MMC_RICOH_MMC is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_OF_ARASAN is not set
# CONFIG_MMC_SDHCI_OF_ASPEED is not set
CONFIG_MMC_SDHCI_OF_AT91=m
CONFIG_MMC_SDHCI_OF_DWCMSHC=m
CONFIG_MMC_SDHCI_CADENCE=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
CONFIG_MMC_SDHCI_MILBEAUT=m
CONFIG_MMC_WBSD=m
# CONFIG_MMC_ALCOR is not set
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_SDRICOH_CS=m
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
CONFIG_MMC_USDHI6ROL0=m
CONFIG_MMC_CQHCI=m
CONFIG_MMC_HSQ=m
CONFIG_MMC_TOSHIBA_PCI=m
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MMC_SDHCI_OMAP=m
# CONFIG_MMC_SDHCI_AM654 is not set
CONFIG_MMC_SDHCI_EXTERNAL_DMA=y
CONFIG_MMC_LITEX=m
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFS_BSG=y
# CONFIG_SCSI_UFS_HPB is not set
# CONFIG_SCSI_UFS_FAULT_INJECTION is not set
CONFIG_SCSI_UFS_HWMON=y
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=m
# CONFIG_SCSI_UFS_CDNS_PLATFORM is not set
CONFIG_SCSI_UFS_DWC_TC_PLATFORM=m
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
# CONFIG_MSPRO_BLOCK is not set
CONFIG_MS_BLOCK=m

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
CONFIG_MEMSTICK_JMICRON_38X=y
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
CONFIG_LEDS_CLASS_MULTICOLOR=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_APU=m
CONFIG_LEDS_AW2013=y
CONFIG_LEDS_BCM6328=y
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3642=m
# CONFIG_LEDS_LM3692X is not set
# CONFIG_LEDS_MT6323 is not set
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP50XX=y
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_PCA955X=m
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM831X_STATUS is not set
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_DA903X=m
CONFIG_LEDS_DA9052=m
CONFIG_LEDS_PWM=y
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=m
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_TCA6507=m
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_MENF21BMC is not set
# CONFIG_LEDS_IS31FL319X is not set
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXCPLD=m
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=m
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM3697=m
CONFIG_LEDS_LM36274=m
CONFIG_LEDS_TPS6105X=m
CONFIG_LEDS_LGM=m

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AS3645A=m
CONFIG_LEDS_KTD2692=m
CONFIG_LEDS_LM3601X=m
# CONFIG_LEDS_MT6360 is not set
# CONFIG_LEDS_RT4505 is not set
CONFIG_LEDS_RT8515=m
CONFIG_LEDS_SGM3140=m

#
# RGB LED drivers
#
CONFIG_LEDS_PWM_MULTICOLOR=m
# CONFIG_LEDS_QCOM_LPG is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_DISK=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_NETDEV=y
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
CONFIG_EDAC_DEBUG=y
CONFIG_EDAC_E752X=y
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=y
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
# CONFIG_EDAC_X38 is not set
CONFIG_EDAC_I5400=y
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM80X=m
CONFIG_RTC_DRV_ABB5ZES3=m
CONFIG_RTC_DRV_ABEOZ9=y
CONFIG_RTC_DRV_ABX80X=m
CONFIG_RTC_DRV_AS3722=m
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=y
# CONFIG_RTC_DRV_HYM8563 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
CONFIG_RTC_DRV_MAX8907=y
CONFIG_RTC_DRV_MAX8925=y
CONFIG_RTC_DRV_MAX8998=y
CONFIG_RTC_DRV_MAX77686=m
CONFIG_RTC_DRV_NCT3018Y=m
CONFIG_RTC_DRV_RS5C372=y
# CONFIG_RTC_DRV_ISL1208 is not set
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_ISL12026=m
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_DRV_PCF8523=m
CONFIG_RTC_DRV_PCF85063=m
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=m
# CONFIG_RTC_DRV_M41T80_WDT is not set
# CONFIG_RTC_DRV_BQ32K is not set
CONFIG_RTC_DRV_TWL4030=y
# CONFIG_RTC_DRV_PALMAS is not set
CONFIG_RTC_DRV_TPS6586X=m
# CONFIG_RTC_DRV_TPS65910 is not set
# CONFIG_RTC_DRV_RC5T619 is not set
CONFIG_RTC_DRV_S35390A=m
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=y
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3028 is not set
CONFIG_RTC_DRV_RV3032=m
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=y
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
# CONFIG_RTC_DRV_DS3232_HWMON is not set
CONFIG_RTC_DRV_PCF2127=y
# CONFIG_RTC_DRV_RV3029C2 is not set
CONFIG_RTC_DRV_RX6110=y

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_DA9052 is not set
# CONFIG_RTC_DRV_DA9055 is not set
# CONFIG_RTC_DRV_DA9063 is not set
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=y
CONFIG_RTC_DRV_BQ4802=y
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
CONFIG_RTC_DRV_WM831X=m
# CONFIG_RTC_DRV_WM8350 is not set
# CONFIG_RTC_DRV_PCF50633 is not set
# CONFIG_RTC_DRV_ZYNQMP is not set
CONFIG_RTC_DRV_CROS_EC=m
CONFIG_RTC_DRV_NTXEC=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_CADENCE is not set
CONFIG_RTC_DRV_FTRTC010=y
# CONFIG_RTC_DRV_MT6397 is not set
# CONFIG_RTC_DRV_R7301 is not set

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_GOLDFISH=m
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=m
CONFIG_DW_AXI_DMAC=y
# CONFIG_FSL_EDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD_COMPAT is not set
# CONFIG_INTEL_IOATDMA is not set
CONFIG_PLX_DMA=m
CONFIG_XILINX_ZYNQMP_DPDMA=y
# CONFIG_AMD_PTDMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=m
CONFIG_SF_PDMA=m
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
CONFIG_DMABUF_MOVE_NOTIFY=y
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
CONFIG_DMABUF_HEAPS_SYSTEM=y
CONFIG_DMABUF_HEAPS_CMA=y
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=y
CONFIG_UIO_CIF=y
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_UIO_DMEM_GENIRQ=m
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
CONFIG_UIO_PCI_GENERIC=m
CONFIG_UIO_NETX=y
CONFIG_UIO_PRUSS=y
CONFIG_UIO_MF624=y
# CONFIG_UIO_DFL is not set
CONFIG_VFIO=y
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
CONFIG_VFIO_PCI_IGD=y
# CONFIG_VFIO_MDEV is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=m
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=m
# CONFIG_VIRTIO_PCI_LEGACY is not set
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=m
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST_RING=m
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_COMEDI=m
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
CONFIG_COMEDI_ISA_DRIVERS=y
# CONFIG_COMEDI_PCL711 is not set
# CONFIG_COMEDI_PCL724 is not set
CONFIG_COMEDI_PCL726=m
CONFIG_COMEDI_PCL730=m
CONFIG_COMEDI_PCL812=m
CONFIG_COMEDI_PCL816=m
CONFIG_COMEDI_PCL818=m
# CONFIG_COMEDI_PCM3724 is not set
# CONFIG_COMEDI_AMPLC_DIO200_ISA is not set
# CONFIG_COMEDI_AMPLC_PC236_ISA is not set
CONFIG_COMEDI_AMPLC_PC263_ISA=m
CONFIG_COMEDI_RTI800=m
CONFIG_COMEDI_RTI802=m
CONFIG_COMEDI_DAC02=m
# CONFIG_COMEDI_DAS16M1 is not set
# CONFIG_COMEDI_DAS08_ISA is not set
CONFIG_COMEDI_DAS16=m
# CONFIG_COMEDI_DAS800 is not set
# CONFIG_COMEDI_DAS1800 is not set
CONFIG_COMEDI_DAS6402=m
CONFIG_COMEDI_DT2801=m
# CONFIG_COMEDI_DT2811 is not set
CONFIG_COMEDI_DT2814=m
CONFIG_COMEDI_DT2815=m
CONFIG_COMEDI_DT2817=m
CONFIG_COMEDI_DT282X=m
# CONFIG_COMEDI_DMM32AT is not set
CONFIG_COMEDI_FL512=m
# CONFIG_COMEDI_AIO_AIO12_8 is not set
CONFIG_COMEDI_AIO_IIRO_16=m
CONFIG_COMEDI_II_PCI20KC=m
CONFIG_COMEDI_C6XDIGIO=m
CONFIG_COMEDI_MPC624=m
# CONFIG_COMEDI_ADQ12B is not set
# CONFIG_COMEDI_NI_AT_A2150 is not set
CONFIG_COMEDI_NI_AT_AO=m
CONFIG_COMEDI_NI_ATMIO=m
CONFIG_COMEDI_NI_ATMIO16D=m
# CONFIG_COMEDI_NI_LABPC_ISA is not set
# CONFIG_COMEDI_PCMAD is not set
CONFIG_COMEDI_PCMDA12=m
CONFIG_COMEDI_PCMMIO=m
CONFIG_COMEDI_PCMUIO=m
CONFIG_COMEDI_MULTIQ3=m
CONFIG_COMEDI_S526=m
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_PCMCIA_DRIVERS=m
CONFIG_COMEDI_CB_DAS16_CS=m
CONFIG_COMEDI_DAS08_CS=m
CONFIG_COMEDI_NI_DAQ_700_CS=m
# CONFIG_COMEDI_NI_DAQ_DIO24_CS is not set
CONFIG_COMEDI_NI_LABPC_CS=m
# CONFIG_COMEDI_NI_MIO_CS is not set
CONFIG_COMEDI_QUATECH_DAQP_CS=m
CONFIG_COMEDI_USB_DRIVERS=m
CONFIG_COMEDI_DT9812=m
CONFIG_COMEDI_NI_USB6501=m
CONFIG_COMEDI_USBDUX=m
CONFIG_COMEDI_USBDUXFAST=m
CONFIG_COMEDI_USBDUXSIGMA=m
# CONFIG_COMEDI_VMK80XX is not set
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=m
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_ISADMA=m
CONFIG_COMEDI_NI_LABPC=m
CONFIG_COMEDI_NI_TIO=m
CONFIG_COMEDI_NI_ROUTING=m
# CONFIG_COMEDI_TESTS is not set
CONFIG_STAGING=y
CONFIG_PRISM2_USB=y
CONFIG_RTL8192U=m
CONFIG_RTLLIB=m
# CONFIG_RTLLIB_CRYPTO_CCMP is not set
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
# CONFIG_RTL8192E is not set
# CONFIG_RTL8723BS is not set
# CONFIG_R8712U is not set
CONFIG_R8188EU=m
CONFIG_RTS5208=m
# CONFIG_FB_SM750 is not set
CONFIG_STAGING_MEDIA=y
CONFIG_STAGING_BOARD=y
# CONFIG_LTE_GDM724X is not set
# CONFIG_FIREWIRE_SERIAL is not set
CONFIG_COMMON_CLK_XLNX_CLKWZRD=m
# CONFIG_KS7010 is not set
# CONFIG_XIL_AXIS_FIFO is not set
CONFIG_FIELDBUS_DEV=y
CONFIG_HMS_ANYBUSS_BUS=m
CONFIG_ARCX_ANYBUS_CONTROLLER=m
# CONFIG_HMS_PROFINET is not set
CONFIG_QLGE=y
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
# CONFIG_VME_TSI148 is not set
# CONFIG_VME_FAKE is not set

#
# VME Device Drivers
#
CONFIG_VME_USER=m
# CONFIG_GOLDFISH_PIPE is not set
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_ACPI is not set
CONFIG_CHROMEOS_LAPTOP=m
CONFIG_CHROMEOS_PSTORE=m
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=m
# CONFIG_CROS_EC_I2C is not set
CONFIG_CROS_EC_RPMSG=m
# CONFIG_CROS_EC_ISHTP is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=m
# CONFIG_CROS_EC_CHARDEV is not set
CONFIG_CROS_EC_LIGHTBAR=m
CONFIG_CROS_EC_VBC=m
# CONFIG_CROS_EC_DEBUGFS is not set
CONFIG_CROS_EC_SENSORHUB=m
CONFIG_CROS_EC_SYSFS=m
# CONFIG_CROS_USBPD_NOTIFY is not set
# CONFIG_CHROMEOS_PRIVACY_SCREEN is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
CONFIG_MLXREG_IO=m
CONFIG_MLXREG_LC=m
CONFIG_NVSW_SN2201=m
# CONFIG_SURFACE_PLATFORMS is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_MXM_WMI is not set
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACER_WMI is not set
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_EEEPC_LAPTOP is not set
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
# CONFIG_AMILO_RFKILL is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_HP_WMI is not set
# CONFIG_IBM_RTL is not set
# CONFIG_IDEAPAD_LAPTOP is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_LED is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_SAR_INT1092 is not set
# CONFIG_INTEL_SKL_INT3472 is not set
# CONFIG_INTEL_PMC_CORE is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
# CONFIG_INTEL_WMI_THUNDERBOLT is not set

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_OAKTRAIL is not set
# CONFIG_INTEL_ISHTP_ECLITE is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_LAPTOP is not set
# CONFIG_MSI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
# CONFIG_SAMSUNG_LAPTOP is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_COMPAL_LAPTOP is not set
# CONFIG_LG_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SONY_LAPTOP is not set
# CONFIG_SYSTEM76_ACPI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_TOUCHSCREEN_DMI is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y
# CONFIG_COMMON_CLK_MAX77686 is not set
CONFIG_COMMON_CLK_MAX9485=y
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_COMMON_CLK_S2MPS11=m
CONFIG_CLK_TWL6040=m
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
CONFIG_COMMON_CLK_PALMAS=m
CONFIG_COMMON_CLK_PWM=m
# CONFIG_COMMON_CLK_RS9_PCIE is not set
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_FIXED_MMIO=y
CONFIG_CLK_LGM_CGU=y
CONFIG_XILINX_VCU=y
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_OF_IOMMU=y
# CONFIG_AMD_IOMMU is not set
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_REMOTEPROC_CDEV=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
CONFIG_RPMSG_CHAR=m
CONFIG_RPMSG_CTRL=m
CONFIG_RPMSG_NS=m
CONFIG_RPMSG_QCOM_GLINK=m
CONFIG_RPMSG_QCOM_GLINK_RPM=m
CONFIG_RPMSG_VIRTIO=m
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=m
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_FSA9480=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=m
# CONFIG_EXTCON_PALMAS is not set
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=m
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_EXTCON_USBC_CROS_EC is not set
CONFIG_EXTCON_USBC_TUSB320=m
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
CONFIG_PWM_ATMEL_HLCDC_PWM=m
CONFIG_PWM_ATMEL_TCB=m
CONFIG_PWM_CLK=m
CONFIG_PWM_CROS_EC=m
# CONFIG_PWM_DWC is not set
CONFIG_PWM_FSL_FTM=y
# CONFIG_PWM_INTEL_LGM is not set
CONFIG_PWM_IQS620A=m
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_NTXEC=m
CONFIG_PWM_PCA9685=m
# CONFIG_PWM_STMPE is not set
CONFIG_PWM_TWL=y
# CONFIG_PWM_TWL_LED is not set
CONFIG_PWM_XILINX=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_AL_FIC=y
# CONFIG_XILINX_INTC is not set
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_INTEL_GW is not set
# CONFIG_RESET_SIMPLE is not set
CONFIG_RESET_TI_SYSCON=y
CONFIG_RESET_TI_TPS380X=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_USB_LGM_PHY is not set
CONFIG_PHY_CAN_TRANSCEIVER=m

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=m
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=y
# CONFIG_PHY_CADENCE_DPHY is not set
# CONFIG_PHY_CADENCE_DPHY_RX is not set
CONFIG_PHY_CADENCE_SIERRA=m
CONFIG_PHY_CADENCE_SALVO=m
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_LAN966X_SERDES=m
CONFIG_PHY_MAPPHONE_MDM6600=m
CONFIG_PHY_OCELOT_SERDES=m
# CONFIG_PHY_QCOM_USB_HS is not set
# CONFIG_PHY_QCOM_USB_HSIC is not set
CONFIG_PHY_TUSB1210=y
CONFIG_PHY_INTEL_LGM_COMBO=y
CONFIG_PHY_INTEL_LGM_EMMC=m
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=y
CONFIG_MCB_PCI=y
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_RAS_CEC=y
CONFIG_RAS_CEC_DEBUG=y
CONFIG_USB4=y
CONFIG_USB4_DEBUGFS_WRITE=y
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDERFS is not set
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

CONFIG_LIBNVDIMM=y
# CONFIG_BLK_DEV_PMEM is not set
CONFIG_ND_CLAIM=y
CONFIG_BTT=y
# CONFIG_OF_PMEM is not set
CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_SPMI_SDAM is not set
# CONFIG_RAVE_SP_EEPROM is not set
CONFIG_NVMEM_RMEM=m

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=m
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=y
# CONFIG_STM_SOURCE_HEARTBEAT is not set
CONFIG_STM_SOURCE_FTRACE=y
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
# CONFIG_INTEL_TH_ACPI is not set
# CONFIG_INTEL_TH_GTH is not set
# CONFIG_INTEL_TH_STH is not set
# CONFIG_INTEL_TH_MSU is not set
# CONFIG_INTEL_TH_PTI is not set
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=m
CONFIG_ALTERA_PR_IP_CORE=m
# CONFIG_ALTERA_PR_IP_CORE_PLAT is not set
CONFIG_FPGA_MGR_ALTERA_CVP=m
CONFIG_FPGA_BRIDGE=m
CONFIG_ALTERA_FREEZE_BRIDGE=m
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
CONFIG_OF_FPGA_REGION=m
CONFIG_FPGA_DFL=m
CONFIG_FPGA_DFL_FME=m
CONFIG_FPGA_DFL_FME_MGR=m
CONFIG_FPGA_DFL_FME_BRIDGE=m
CONFIG_FPGA_DFL_FME_REGION=m
# CONFIG_FPGA_DFL_AFU is not set
CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000=m
# CONFIG_FPGA_DFL_PCI is not set
CONFIG_FSI=y
# CONFIG_FSI_NEW_DEV_NODE is not set
CONFIG_FSI_MASTER_GPIO=m
# CONFIG_FSI_MASTER_HUB is not set
# CONFIG_FSI_MASTER_ASPEED is not set
# CONFIG_FSI_SCOM is not set
CONFIG_FSI_SBEFIFO=m
CONFIG_FSI_OCC=m
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
# CONFIG_MUX_GPIO is not set
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=m
# CONFIG_104_QUAD_8 is not set
CONFIG_INTERRUPT_CNT=m
CONFIG_FTM_QUADDEC=m
# CONFIG_MICROCHIP_TCB_CAPTURE is not set
# CONFIG_INTEL_QEP is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=m
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=m
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_SECURITY is not set
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=y
# CONFIG_XFS_SUPPORT_V4 is not set
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_FS_REF_VERIFY=y
CONFIG_NILFS2_FS=m
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
CONFIG_F2FS_CHECK_FS=y
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_ZONEFS_FS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_DEBUG=y
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
# CONFIG_HUGETLBFS is not set
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_ECRYPT_FS=m
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_HFS_FS=y
CONFIG_HFSPLUS_FS=m
CONFIG_BEFS_FS=y
CONFIG_BEFS_DEBUG=y
CONFIG_BFS_FS=y
CONFIG_EFS_FS=m
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
CONFIG_SQUASHFS_DECOMP_MULTI=y
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
# CONFIG_SQUASHFS_ZLIB is not set
# CONFIG_SQUASHFS_LZ4 is not set
# CONFIG_SQUASHFS_LZO is not set
CONFIG_SQUASHFS_XZ=y
CONFIG_SQUASHFS_ZSTD=y
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=y
CONFIG_OMFS_FS=y
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=m
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=m
CONFIG_PSTORE_LZO_COMPRESS=m
CONFIG_PSTORE_LZ4_COMPRESS=m
CONFIG_PSTORE_LZ4HC_COMPRESS=m
CONFIG_PSTORE_842_COMPRESS=y
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_842_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="842"
CONFIG_PSTORE_CONSOLE=y
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_RAM is not set
# CONFIG_PSTORE_BLK is not set
CONFIG_SYSV_FS=m
# CONFIG_UFS_FS is not set
CONFIG_EROFS_FS=y
# CONFIG_EROFS_FS_DEBUG is not set
# CONFIG_EROFS_FS_XATTR is not set
# CONFIG_EROFS_FS_ZIP is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=m
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=m
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=m
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
CONFIG_UNICODE=m
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y

#
# No trust source selected!
#
CONFIG_ENCRYPTED_KEYS=m
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
# CONFIG_SECURITYFS is not set
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
CONFIG_ZERO_CALL_USED_REGS=y
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=m
# CONFIG_CRYPTO_ECRDSA is not set
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=m
CONFIG_CRYPTO_CURVE25519_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=m
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
# CONFIG_CRYPTO_SEQIV is not set
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=m
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=m
# CONFIG_CRYPTO_XTS is not set
CONFIG_CRYPTO_KEYWRAP=m
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_NHPOLY1305_SSE2=m
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_HCTR2 is not set
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_BLAKE2S_X86=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
CONFIG_CRYPTO_GHASH=m
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
CONFIG_CRYPTO_SM3_AVX_X86_64=m
CONFIG_CRYPTO_STREEBOG=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_ARIA=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=m
CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64=y
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=m
CONFIG_CRYPTO_USER_API_RNG=m
CONFIG_CRYPTO_USER_API_RNG_CAVP=y
CONFIG_CRYPTO_USER_API_AEAD=y
# CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
CONFIG_CRYPTO_DEV_ATMEL_I2C=y
CONFIG_CRYPTO_DEV_ATMEL_ECC=y
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=m
# CONFIG_CRYPTO_DEV_CCP is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_4XXX=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
# CONFIG_CRYPTO_DEV_VIRTIO is not set
CONFIG_CRYPTO_DEV_SAFEXCEL=m
# CONFIG_CRYPTO_DEV_CCREE is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=m
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=m
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_RESTRICTED_POOL is not set
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
CONFIG_CMA_SIZE_SEL_PERCENTAGE=y
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_POLYNOMIAL=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
# CONFIG_SYMBOLIC_ERRNAME is not set
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
CONFIG_DEBUG_INFO_DWARF5=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_GDB_SCRIPTS=y
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
# CONFIG_VMLINUX_MAP is not set
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
CONFIG_DEBUG_NET=y
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
CONFIG_PAGE_POISONING=y
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
CONFIG_DEBUG_OBJECTS_WORK=y
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
# CONFIG_DEBUG_KMEMLEAK_TEST is not set
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
# CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
CONFIG_CSD_LOCK_WAIT_DEBUG=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# CONFIG_RCU_STRICT_GRACE_PERIOD is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_ENABLE_DEFAULT_TRACERS is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
CONFIG_SAMPLE_TRACE_EVENTS=m
CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS=m
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_TRACE_ARRAY=m
# CONFIG_SAMPLE_KOBJECT is not set
CONFIG_SAMPLE_KPROBES=m
CONFIG_SAMPLE_KRETPROBES=m
CONFIG_SAMPLE_HW_BREAKPOINT=m
CONFIG_SAMPLE_KFIFO=m
# CONFIG_SAMPLE_RPMSG_CLIENT is not set
CONFIG_SAMPLE_CONFIGFS=m
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=y
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAULT_INJECTION_USERCOPY=y
# CONFIG_FAIL_MAKE_REQUEST is not set
CONFIG_FAIL_IO_TIMEOUT=y
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAIL_FUNCTION=y
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--5iHgkvvJZpmMG8Ws--
