Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4156B6A51D7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 04:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjB1DhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 22:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjB1DhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 22:37:19 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6A11E9D2;
        Mon, 27 Feb 2023 19:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677555438; x=1709091438;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=al/INyoNJ0XDfdnz7VHXZf5kkuMVxaCGXwtFpDxHwQY=;
  b=VPnaE/GQ3b0TA9m6iWN0AMCvugISMYOEeTAioLF9C70G7lSgG1ynD2f+
   uS+kFZzQzi8P6AxL9xdaMEAz4D031V2GdnwwSVBkix300XK/7eELyhN27
   UOkIdZL/IAxABb/q279kQIRjfKl6Ij+KG6C9DD9FkqBDrZZI5twn99dQs
   2tQ92x6t9ilDaM/6yLB6u99V2euRzMGUB71YzKN7NimwX5h3evOWhhVoh
   nKNXsh8aOdv3hIsrwXOdYufVQ/M4PqJk+GWrCg44Kc6soEocvlhY7aA56
   m3ZPPrSsVQAGR7VcogIZL1OLl+UAtJWL5JC2PmVrKH0gjueY/qSeP7gxR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="420298167"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="420298167"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 19:37:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="667293697"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="667293697"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Feb 2023 19:37:15 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWqni-00052r-15;
        Tue, 28 Feb 2023 03:37:14 +0000
Date:   Tue, 28 Feb 2023 11:36:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: drivers/iommu/fsl_pamu.c:586: warning: This comment starts with
 '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202302281151.B1WtZvSC-lkp@intel.com>
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

Hi Aditya,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ae3419fbac845b4d3f3a9fae4cc80c68d82cdf6e
commit: 3e58e839150db0857dfcb3a0bb3d4af4c6ac1abf scripts: kernel-doc: add warning for comment not following kernel-doc syntax
date:   1 year, 11 months ago
config: powerpc-randconfig-r002-20230227 (https://download.01.org/0day-ci/archive/20230228/202302281151.B1WtZvSC-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3e58e839150db0857dfcb3a0bb3d4af4c6ac1abf
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3e58e839150db0857dfcb3a0bb3d4af4c6ac1abf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/iommu/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302281151.B1WtZvSC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iommu/fsl_pamu.c:325: warning: Function parameter or member 'win_size' not described in 'pamu_config_ppaace'
   drivers/iommu/fsl_pamu.c:325: warning: expecting prototype for pamu_config_paace(). Prototype was for pamu_config_ppaace() instead
   drivers/iommu/fsl_pamu.c:493: warning: Function parameter or member 'omi_index' not described in 'get_ome_index'
   drivers/iommu/fsl_pamu.c:493: warning: Function parameter or member 'dev' not described in 'get_ome_index'
>> drivers/iommu/fsl_pamu.c:586: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Setup operation mapping and stash destinations for QMAN and QMAN portal.
   drivers/iommu/fsl_pamu.c:615: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Setup the operation mapping table for various devices. This is a static


vim +586 drivers/iommu/fsl_pamu.c

695093e38c3ef6 Varun Sethi 2013-07-15  584  
695093e38c3ef6 Varun Sethi 2013-07-15  585  /**
695093e38c3ef6 Varun Sethi 2013-07-15 @586   * Setup operation mapping and stash destinations for QMAN and QMAN portal.
695093e38c3ef6 Varun Sethi 2013-07-15  587   * Memory accesses to QMAN and BMAN private memory need not be coherent, so
695093e38c3ef6 Varun Sethi 2013-07-15  588   * clear the PAACE entry coherency attribute for them.
695093e38c3ef6 Varun Sethi 2013-07-15  589   */
57fb907da89977 Emil Medve  2015-03-25  590  static void setup_qbman_paace(struct paace *ppaace, int  paace_type)
695093e38c3ef6 Varun Sethi 2013-07-15  591  {
695093e38c3ef6 Varun Sethi 2013-07-15  592  	switch (paace_type) {
695093e38c3ef6 Varun Sethi 2013-07-15  593  	case QMAN_PAACE:
695093e38c3ef6 Varun Sethi 2013-07-15  594  		set_bf(ppaace->impl_attr, PAACE_IA_OTM, PAACE_OTM_INDEXED);
695093e38c3ef6 Varun Sethi 2013-07-15  595  		ppaace->op_encode.index_ot.omi = OMI_QMAN_PRIV;
695093e38c3ef6 Varun Sethi 2013-07-15  596  		/* setup QMAN Private data stashing for the L3 cache */
695093e38c3ef6 Varun Sethi 2013-07-15  597  		set_bf(ppaace->impl_attr, PAACE_IA_CID, get_stash_id(PAMU_ATTR_CACHE_L3, 0));
695093e38c3ef6 Varun Sethi 2013-07-15  598  		set_bf(ppaace->domain_attr.to_host.coherency_required, PAACE_DA_HOST_CR,
695093e38c3ef6 Varun Sethi 2013-07-15  599  		       0);
695093e38c3ef6 Varun Sethi 2013-07-15  600  		break;
695093e38c3ef6 Varun Sethi 2013-07-15  601  	case QMAN_PORTAL_PAACE:
695093e38c3ef6 Varun Sethi 2013-07-15  602  		set_bf(ppaace->impl_attr, PAACE_IA_OTM, PAACE_OTM_INDEXED);
695093e38c3ef6 Varun Sethi 2013-07-15  603  		ppaace->op_encode.index_ot.omi = OMI_QMAN;
695093e38c3ef6 Varun Sethi 2013-07-15  604  		/* Set DQRR and Frame stashing for the L3 cache */
695093e38c3ef6 Varun Sethi 2013-07-15  605  		set_bf(ppaace->impl_attr, PAACE_IA_CID, get_stash_id(PAMU_ATTR_CACHE_L3, 0));
695093e38c3ef6 Varun Sethi 2013-07-15  606  		break;
695093e38c3ef6 Varun Sethi 2013-07-15  607  	case BMAN_PAACE:
695093e38c3ef6 Varun Sethi 2013-07-15  608  		set_bf(ppaace->domain_attr.to_host.coherency_required, PAACE_DA_HOST_CR,
695093e38c3ef6 Varun Sethi 2013-07-15  609  		       0);
695093e38c3ef6 Varun Sethi 2013-07-15  610  		break;
695093e38c3ef6 Varun Sethi 2013-07-15  611  	}
695093e38c3ef6 Varun Sethi 2013-07-15  612  }
695093e38c3ef6 Varun Sethi 2013-07-15  613  

:::::: The code at line 586 was first introduced by commit
:::::: 695093e38c3ef63fcb43a2840ed865efa20671d5 iommu/fsl: Freescale PAMU driver and iommu implementation.

:::::: TO: Varun Sethi <Varun.Sethi@freescale.com>
:::::: CC: Joerg Roedel <joro@8bytes.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
