Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008566C298A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjCUFCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjCUFCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:02:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A077F36467
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 22:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679374893; x=1710910893;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iQmqupMtpBq3ZgiaQNPrWaRFEGytHt3f/SsXPYUgQGc=;
  b=NeK8EDuJCA71DEC/VVzczeGkdbEEnnlj7Qne5swF6f6CiouINJr0AF7R
   fiPRNR83KkGlCLUX2VdqOL8xP3KTpeY+It9Vhd3VdKVhJ/wjcN1DrFFFb
   5MNS6kvRBMbnpD21dilcmFxG0lladjDyIPPNaLqHULwCbOwBcfWM0WbEM
   w0LS7r97zuMJZOKW+8n0pn1/fnnVPnisc9N86g6oqm3b+4moO9kw5/r2F
   1k6XUfjs4pNbGifD/ytoEuuKGdHHXja33d8Z8e68pOphhcMHrtyAcHYlJ
   TBtrv87lPRQG+ibVvEyFJr/YChaJYwwJQCK8C0AK931J+tloHMcKmuMv4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="322689565"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="322689565"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 22:01:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="1010783181"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="1010783181"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Mar 2023 22:01:13 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peU7V-000Bbm-0G;
        Tue, 21 Mar 2023 05:01:13 +0000
Date:   Tue, 21 Mar 2023 13:01:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ranjan Kumar <ranjan.kumar@broadcom.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Subject: drivers/scsi/mpi3mr/mpi3mr_transport.c:2365
 mpi3mr_report_tgtdev_to_sas_transport() warn: inconsistent indenting
Message-ID: <202303211202.uf1kNr2C-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   17214b70a159c6547df9ae204a6275d983146f6b
commit: 8e45183978d64699df639e795235433a60f35047 scsi: mpi3mr: Bad drive in topology results kernel crash
date:   2 weeks ago
config: riscv-randconfig-m031-20230319 (https://download.01.org/0day-ci/archive/20230321/202303211202.uf1kNr2C-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303211202.uf1kNr2C-lkp@intel.com/

New smatch warnings:
drivers/scsi/mpi3mr/mpi3mr_transport.c:2365 mpi3mr_report_tgtdev_to_sas_transport() warn: inconsistent indenting

Old smatch warnings:
drivers/scsi/mpi3mr/mpi3mr_transport.c:2064 mpi3mr_expander_add() warn: returning -1 instead of -ENOMEM is sloppy

vim +2365 drivers/scsi/mpi3mr/mpi3mr_transport.c

7f56c791969e0c Sreekanth Reddy 2022-08-04  2304  
7f56c791969e0c Sreekanth Reddy 2022-08-04  2305  /**
7f56c791969e0c Sreekanth Reddy 2022-08-04  2306   * mpi3mr_report_tgtdev_to_sas_transport - expose dev to SAS TL
7f56c791969e0c Sreekanth Reddy 2022-08-04  2307   * @mrioc: Adapter instance reference
7f56c791969e0c Sreekanth Reddy 2022-08-04  2308   * @tgtdev: Target device
7f56c791969e0c Sreekanth Reddy 2022-08-04  2309   *
7f56c791969e0c Sreekanth Reddy 2022-08-04  2310   * This function exposes the target device after
7f56c791969e0c Sreekanth Reddy 2022-08-04  2311   * preparing host_phy, setting up link rate etc.
7f56c791969e0c Sreekanth Reddy 2022-08-04  2312   *
7f56c791969e0c Sreekanth Reddy 2022-08-04  2313   * Return: 0 on success, non-zero for failure.
7f56c791969e0c Sreekanth Reddy 2022-08-04  2314   */
7f56c791969e0c Sreekanth Reddy 2022-08-04  2315  int mpi3mr_report_tgtdev_to_sas_transport(struct mpi3mr_ioc *mrioc,
7f56c791969e0c Sreekanth Reddy 2022-08-04  2316  	struct mpi3mr_tgt_dev *tgtdev)
7f56c791969e0c Sreekanth Reddy 2022-08-04  2317  {
7f56c791969e0c Sreekanth Reddy 2022-08-04  2318  	int retval = 0;
7f56c791969e0c Sreekanth Reddy 2022-08-04  2319  	u8 link_rate, parent_phy_number;
7f56c791969e0c Sreekanth Reddy 2022-08-04  2320  	u64 sas_address_parent, sas_address;
7f56c791969e0c Sreekanth Reddy 2022-08-04  2321  	struct mpi3mr_hba_port *hba_port;
7f56c791969e0c Sreekanth Reddy 2022-08-04  2322  	u8 port_id;
7f56c791969e0c Sreekanth Reddy 2022-08-04  2323  
7f56c791969e0c Sreekanth Reddy 2022-08-04  2324  	if ((tgtdev->dev_type != MPI3_DEVICE_DEVFORM_SAS_SATA) ||
7f56c791969e0c Sreekanth Reddy 2022-08-04  2325  	    !mrioc->sas_transport_enabled)
7f56c791969e0c Sreekanth Reddy 2022-08-04  2326  		return -1;
7f56c791969e0c Sreekanth Reddy 2022-08-04  2327  
7f56c791969e0c Sreekanth Reddy 2022-08-04  2328  	sas_address = tgtdev->dev_spec.sas_sata_inf.sas_address;
7f56c791969e0c Sreekanth Reddy 2022-08-04  2329  	if (!mrioc->sas_hba.num_phys)
7f56c791969e0c Sreekanth Reddy 2022-08-04  2330  		mpi3mr_sas_host_add(mrioc);
7f56c791969e0c Sreekanth Reddy 2022-08-04  2331  	else
7f56c791969e0c Sreekanth Reddy 2022-08-04  2332  		mpi3mr_sas_host_refresh(mrioc);
7f56c791969e0c Sreekanth Reddy 2022-08-04  2333  
7f56c791969e0c Sreekanth Reddy 2022-08-04  2334  	if (mpi3mr_get_sas_address(mrioc, tgtdev->parent_handle,
7f56c791969e0c Sreekanth Reddy 2022-08-04  2335  	    &sas_address_parent) != 0) {
7f56c791969e0c Sreekanth Reddy 2022-08-04  2336  		ioc_err(mrioc, "failure at %s:%d/%s()!\n",
7f56c791969e0c Sreekanth Reddy 2022-08-04  2337  		    __FILE__, __LINE__, __func__);
7f56c791969e0c Sreekanth Reddy 2022-08-04  2338  		return -1;
7f56c791969e0c Sreekanth Reddy 2022-08-04  2339  	}
7f56c791969e0c Sreekanth Reddy 2022-08-04  2340  	tgtdev->dev_spec.sas_sata_inf.sas_address_parent = sas_address_parent;
7f56c791969e0c Sreekanth Reddy 2022-08-04  2341  
7f56c791969e0c Sreekanth Reddy 2022-08-04  2342  	parent_phy_number = tgtdev->dev_spec.sas_sata_inf.phy_id;
7f56c791969e0c Sreekanth Reddy 2022-08-04  2343  	port_id = tgtdev->io_unit_port;
7f56c791969e0c Sreekanth Reddy 2022-08-04  2344  
7f56c791969e0c Sreekanth Reddy 2022-08-04  2345  	hba_port = mpi3mr_get_hba_port_by_id(mrioc, port_id);
7f56c791969e0c Sreekanth Reddy 2022-08-04  2346  	if (!hba_port) {
7f56c791969e0c Sreekanth Reddy 2022-08-04  2347  		ioc_err(mrioc, "failure at %s:%d/%s()!\n",
7f56c791969e0c Sreekanth Reddy 2022-08-04  2348  		    __FILE__, __LINE__, __func__);
7f56c791969e0c Sreekanth Reddy 2022-08-04  2349  		return -1;
7f56c791969e0c Sreekanth Reddy 2022-08-04  2350  	}
7f56c791969e0c Sreekanth Reddy 2022-08-04  2351  	tgtdev->dev_spec.sas_sata_inf.hba_port = hba_port;
7f56c791969e0c Sreekanth Reddy 2022-08-04  2352  
7f56c791969e0c Sreekanth Reddy 2022-08-04  2353  	link_rate = mpi3mr_get_sas_negotiated_logical_linkrate(mrioc, tgtdev);
7f56c791969e0c Sreekanth Reddy 2022-08-04  2354  
7f56c791969e0c Sreekanth Reddy 2022-08-04  2355  	mpi3mr_update_links(mrioc, sas_address_parent, tgtdev->dev_handle,
7f56c791969e0c Sreekanth Reddy 2022-08-04  2356  	    parent_phy_number, link_rate, hba_port);
7f56c791969e0c Sreekanth Reddy 2022-08-04  2357  
7f56c791969e0c Sreekanth Reddy 2022-08-04  2358  	tgtdev->host_exposed = 1;
7f56c791969e0c Sreekanth Reddy 2022-08-04  2359  	if (!mpi3mr_sas_port_add(mrioc, tgtdev->dev_handle,
7f56c791969e0c Sreekanth Reddy 2022-08-04  2360  	    sas_address_parent, hba_port)) {
7f56c791969e0c Sreekanth Reddy 2022-08-04  2361  		retval = -1;
8e45183978d646 Ranjan Kumar    2023-02-28  2362  		} else if ((!tgtdev->starget) && (!mrioc->is_driver_loading)) {
7f56c791969e0c Sreekanth Reddy 2022-08-04  2363  			mpi3mr_sas_port_remove(mrioc, sas_address,
7f56c791969e0c Sreekanth Reddy 2022-08-04  2364  			    sas_address_parent, hba_port);
7f56c791969e0c Sreekanth Reddy 2022-08-04 @2365  		retval = -1;
7f56c791969e0c Sreekanth Reddy 2022-08-04  2366  	}
8e45183978d646 Ranjan Kumar    2023-02-28  2367  	if (retval) {
8e45183978d646 Ranjan Kumar    2023-02-28  2368  		tgtdev->dev_spec.sas_sata_inf.hba_port = NULL;
8e45183978d646 Ranjan Kumar    2023-02-28  2369  		tgtdev->host_exposed = 0;
8e45183978d646 Ranjan Kumar    2023-02-28  2370  	}
7f56c791969e0c Sreekanth Reddy 2022-08-04  2371  	return retval;
7f56c791969e0c Sreekanth Reddy 2022-08-04  2372  }
7f56c791969e0c Sreekanth Reddy 2022-08-04  2373  

:::::: The code at line 2365 was first introduced by commit
:::::: 7f56c791969e0c19b8b5ee12058b636bf173eb90 scsi: mpi3mr: Add SAS SATA end devices to STL

:::::: TO: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
