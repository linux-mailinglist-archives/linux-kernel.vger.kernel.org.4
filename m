Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AFE6D352D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 03:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjDBBlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 21:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBBlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 21:41:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEF225467
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 18:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680399670; x=1711935670;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FjjawPmIMLI3qdJUerLWuK0KAAK4zxhpln8oiPkeKZk=;
  b=g0hFiGWSwSNCutPbYdrC4p8IiIMFARc/7WfgoYq8n4Nv9e5MFFS3Idi9
   f8j0TgJZ5WWweJcR4lHvmSe+TeiZuq44S9OKQ/dKfkgm9qa81lQgquX5f
   EZGw0yan8cAsuB0RJB8oB+CmlVutbjr18bSCuFLiQc7WutHL0TKnVAuwD
   IIGVdVnNcCDFLdS4yZJKCAk0Z5GurV+hi1YbThMQVcFF/+8YoZBPHeQc8
   7QAzIIxbTKiPDLrzzYvvfhUx2v9lvgGz0jY/tGiJeyZJyY16MuBlNi1Yr
   A61+2widmJ7IZTgNs6o32l6QnjjH9UMDz0mhl76wA3olN7wptD1S1x0af
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="404443873"
X-IronPort-AV: E=Sophos;i="5.98,311,1673942400"; 
   d="scan'208";a="404443873"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 18:41:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="715861448"
X-IronPort-AV: E=Sophos;i="5.98,311,1673942400"; 
   d="scan'208";a="715861448"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Apr 2023 18:40:48 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pimi5-000NAD-19;
        Sun, 02 Apr 2023 01:40:45 +0000
Date:   Sun, 2 Apr 2023 09:40:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Fuad Tabba <tabba@google.com>
Subject: arch/arm64/kvm/arm.c:52:1: sparse: sparse: symbol
 '__pcpu_scope_kvm_arm_hyp_stack_page' was not declared. Should it be static?
Message-ID: <202304020902.ZvTOBKsb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   00c7b5f4ddc5b346df62b757ec73f9357bb452af
commit: db129d486ebdf4e3168282236f9d9008b42cac7e KVM: arm64: Implement non-protected nVHE hyp stack unwinder
date:   8 months ago
config: arm64-randconfig-s031-20230402 (https://download.01.org/0day-ci/archive/20230402/202304020902.ZvTOBKsb-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=db129d486ebdf4e3168282236f9d9008b42cac7e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout db129d486ebdf4e3168282236f9d9008b42cac7e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/ drivers/gpu/ drivers/usb/gadget/function/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304020902.ZvTOBKsb-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/arm64/kvm/arm.c:52:1: sparse: sparse: symbol '__pcpu_scope_kvm_arm_hyp_stack_page' was not declared. Should it be static?

vim +/__pcpu_scope_kvm_arm_hyp_stack_page +52 arch/arm64/kvm/arm.c

  > 52	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
