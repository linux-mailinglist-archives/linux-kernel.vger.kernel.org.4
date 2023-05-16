Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6088704446
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 06:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjEPERE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 00:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEPERC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 00:17:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F8DF3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 21:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684210619; x=1715746619;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wmir26GwVgTrsojJMnObMCl0oeyf0jYtqzbx1GJCRfc=;
  b=DK4z4K0EgvJdBIuM3PwmCrZF8y9Rf/sTBRZElBIuliYFSsn/1GSf6HP+
   j4lTaNELfAAgr67HmU22KSp0gULXjaZJIn1255EGRBuitWwotO78+d/2L
   xfnUPbXHWJgY4bnLAUlxXlWin57DtSaVIjllfsKwuLKeZEZYHF3prl5DS
   ob4MrIU4zm1mFs101AAabgVrn93azytsE/Yu+0kuwRJduAsc89FgSOtw1
   2N+gkG4M6T3ieXTnWnq7Oq5sU97/zhev8IO5Wu6z2db+gehDDcesVD8cD
   RTH6gOhjL5oodjKRnZuAVJ2hlnUC1SdjcKnCMhhdhYT3hvx6Zb/0nA0ja
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="350212693"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="350212693"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 21:16:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="704239952"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="704239952"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 15 May 2023 21:16:52 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pym7H-0006x8-2W;
        Tue, 16 May 2023 04:16:51 +0000
Date:   Tue, 16 May 2023 12:16:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suman Anna <s-anna@ti.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
Subject: drivers/remoteproc/ti_k3_dsp_remoteproc.c:432:17: sparse: sparse:
 cast removes address space '__iomem' of expression
Message-ID: <202305161215.GH1XW3Ih-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
commit: b8431920391d36c273f63a29eab0dfc7e884dd17 remoteproc: k3-dsp: Add support for IPC-only mode for all K3 DSPs
date:   1 year, 2 months ago
config: arm64-randconfig-s031-20230515 (https://download.01.org/0day-ci/archive/20230516/202305161215.GH1XW3Ih-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b8431920391d36c273f63a29eab0dfc7e884dd17
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b8431920391d36c273f63a29eab0dfc7e884dd17
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305161215.GH1XW3Ih-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/remoteproc/ti_k3_dsp_remoteproc.c:432:17: sparse: sparse: cast removes address space '__iomem' of expression

vim +/__iomem +432 drivers/remoteproc/ti_k3_dsp_remoteproc.c

   402	
   403	/*
   404	 * This function implements the .get_loaded_rsc_table() callback and is used
   405	 * to provide the resource table for a booted DSP in IPC-only mode. The K3 DSP
   406	 * firmwares follow a design-by-contract approach and are expected to have the
   407	 * resource table at the base of the DDR region reserved for firmware usage.
   408	 * This provides flexibility for the remote processor to be booted by different
   409	 * bootloaders that may or may not have the ability to publish the resource table
   410	 * address and size through a DT property. This callback is invoked only in
   411	 * IPC-only mode.
   412	 */
   413	static struct resource_table *k3_dsp_get_loaded_rsc_table(struct rproc *rproc,
   414								  size_t *rsc_table_sz)
   415	{
   416		struct k3_dsp_rproc *kproc = rproc->priv;
   417		struct device *dev = kproc->dev;
   418	
   419		if (!kproc->rmem[0].cpu_addr) {
   420			dev_err(dev, "memory-region #1 does not exist, loaded rsc table can't be found");
   421			return ERR_PTR(-ENOMEM);
   422		}
   423	
   424		/*
   425		 * NOTE: The resource table size is currently hard-coded to a maximum
   426		 * of 256 bytes. The most common resource table usage for K3 firmwares
   427		 * is to only have the vdev resource entry and an optional trace entry.
   428		 * The exact size could be computed based on resource table address, but
   429		 * the hard-coded value suffices to support the IPC-only mode.
   430		 */
   431		*rsc_table_sz = 256;
 > 432		return (struct resource_table *)kproc->rmem[0].cpu_addr;
   433	}
   434	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
