Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031C26AADCF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 03:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjCECKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 21:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCECKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 21:10:16 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361C79EF9
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 18:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677982215; x=1709518215;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Aw7ZICILfzUEfc1c3TACgiXOOm6qAu3x+JHmN8YxoNQ=;
  b=dzT/gVOOLbuqr5864SAqprRkNTbFY4VAeWSGtypDJw6cbNG5xnDkd1cI
   z4OIE6u8hl41bJSS0J0/tnWUmVx0UT4vSt/cniAbFU9ARAiezefG49XGE
   acx7Wywym25hnKghCfhpRsgfkzEKg/OL0PSU2yNyzXbykARJuBLDLxKxG
   e4sPrUDsGVT2hgLbVh46FEJZkgea5zuK15yJh/7o7DURtTgjTvoRev7Gs
   K1mqiMLHCX/yr+Vh4DxjFxBt90d+B9cXUjEkRf1dFNWPMHac7FDRGerC/
   0ChTWGn4UjsIzNOoXfGr1XjbgfN5SMmuJbPaSm6W9/0baEJxqBatqgYRr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="334052154"
X-IronPort-AV: E=Sophos;i="5.98,234,1673942400"; 
   d="scan'208";a="334052154"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2023 18:10:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="1005000651"
X-IronPort-AV: E=Sophos;i="5.98,234,1673942400"; 
   d="scan'208";a="1005000651"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Mar 2023 18:10:13 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYdpE-0002VC-1h;
        Sun, 05 Mar 2023 02:10:12 +0000
Date:   Sun, 5 Mar 2023 10:09:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Fuad Tabba <tabba@google.com>
Subject: arch/arm64/kvm/hyp/nvhe/stacktrace.c:46:6: warning: no previous
 prototype for 'kvm_nvhe_prepare_backtrace'
Message-ID: <202303050938.aodeOdgp-lkp@intel.com>
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

Hi Kalesh,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b01fe98d34f3bed944a93bd8119fed80c856fad8
commit: 879e5ac7b2e4db05799a905b5a07fc9e5dedf651 KVM: arm64: Prepare non-protected nVHE hypervisor stacktrace
date:   7 months ago
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230305/202303050938.aodeOdgp-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=879e5ac7b2e4db05799a905b5a07fc9e5dedf651
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 879e5ac7b2e4db05799a905b5a07fc9e5dedf651
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/hyp/nvhe/ drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303050938.aodeOdgp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm64/kvm/hyp/nvhe/stacktrace.c:46:6: warning: no previous prototype for 'kvm_nvhe_prepare_backtrace' [-Wmissing-prototypes]
      46 | void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/kvm_nvhe_prepare_backtrace +46 arch/arm64/kvm/hyp/nvhe/stacktrace.c

    36	
    37	/*
    38	 * kvm_nvhe_prepare_backtrace - prepare to dump the nVHE backtrace
    39	 *
    40	 * @fp : frame pointer at which to start the unwinding.
    41	 * @pc : program counter at which to start the unwinding.
    42	 *
    43	 * Saves the information needed by the host to dump the nVHE hypervisor
    44	 * backtrace.
    45	 */
  > 46	void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
