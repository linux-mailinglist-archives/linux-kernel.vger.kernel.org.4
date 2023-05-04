Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678396F79A7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 01:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjEDXOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 19:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjEDXN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 19:13:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DA693F8;
        Thu,  4 May 2023 16:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683242038; x=1714778038;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XfdmjIEG3WnKLVulWn1GDptAVLTd9JhsBE/iSFzF210=;
  b=in56dbQc2eK4+OiltmPIzzZz8DtqiJ+5a0Lcol3D8qg95Bou7IKiCeDS
   lZLXkcEFFxefv95+eRod9tBB0JWNBOTzB6L8QbzKp2FJKwB2XUAXt26P/
   HVs5LyNrQWeH3/Rg2bcBxO2AsxMC8RPiC2yCm2JAz93QabZ/0v90N4e9w
   fAh5Oh/sA+0jtEHT/yaQhN7RBX9oG7OoRB5gsfO+62bGBj1s239JBWR6N
   y14AElYpBJRflN9H3vMyUvWLfYX78Lknb5RznUt1KYkWWTXNBipvGdLqa
   WcIQ7kDzrhOIqMw9iQRwZIL5T+PKhxUdsOIUbEwsy9TUxcAEoHAL74PyN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="352107031"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="352107031"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 16:13:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="1027172407"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="1027172407"
Received: from lkp-server01.sh.intel.com (HELO 64cf2984a3fe) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 May 2023 16:13:55 -0700
Received: from kbuild by 64cf2984a3fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pui94-0000Bu-1N;
        Thu, 04 May 2023 23:13:54 +0000
Date:   Fri, 5 May 2023 07:13:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        linux-doc@vger.kernel.org
Subject: [tip:master 4/4] htmldocs: Warning: arch/x86/Kconfig references a
 file that doesn't exist: Documentation/x86/shstk.rst
Message-ID: <202305050705.5V1x1V3i-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
head:   da1c4f07aa4dd227a57103fef1215e7cef3f35a9
commit: da1c4f07aa4dd227a57103fef1215e7cef3f35a9 [4/4] Merge branch 'x86/shstk'
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=da1c4f07aa4dd227a57103fef1215e7cef3f35a9
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip master
        git checkout da1c4f07aa4dd227a57103fef1215e7cef3f35a9
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305050705.5V1x1V3i-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: arch/x86/Kconfig references a file that doesn't exist: Documentation/x86/shstk.rst

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
