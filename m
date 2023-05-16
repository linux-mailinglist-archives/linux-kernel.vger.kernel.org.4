Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2F6704D92
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjEPMPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjEPMPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:15:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7459EFA
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684239331; x=1715775331;
  h=date:from:to:cc:subject:message-id;
  bh=83sOG0BE57ZFxs5FwGb5WLqeRX9/YK/U/S4cmVJuPO0=;
  b=DNZFWDIoqT0nkGj2P5kby+kPKphXzO1eq03YS7YjeyC9x1z4I/Z/lOJ1
   F+yCCNS1RL16InRV6dCCBiqEeVeqjK78fFh6sDfDU6fZgmieOI0zSR2Px
   nBJxkgKh6uC5hiH80T6GnUbIY+HGe3Ug/+2KlfEBo9ZrxSCz3s1IenT3p
   oBxvo+Mvz1wreguw8H5+Ws8iflTehMr+Uy75LV0ioeftdzOksmPY7TbIJ
   h9QWSsj+Dqej3ikUgIpMGCzdwPcUdJp50cIZW7+sLE8R+PYKFklsql5tt
   S6J8S1XptSxNM84DXXiBDhlUiI1+7Kc28LqEfR2rQladioGkhTawxUPQQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="353740779"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="353740779"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 05:15:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="766343937"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="766343937"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 16 May 2023 05:15:14 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pytaD-0007Qb-2B;
        Tue, 16 May 2023 12:15:13 +0000
Date:   Tue, 16 May 2023 20:14:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 7583e8fbdc49a4dbd916d14863cf1deeddb982f9
Message-ID: <20230516121449.2102u%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230516180935/lkp-src/repo/*/tip
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 7583e8fbdc49a4dbd916d14863cf1deeddb982f9  x86/cpu: Remove X86_FEATURE_NAMES

elapsed time: 859m

configs tested: 8
configs skipped: 93

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
