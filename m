Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65BE71782A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbjEaH1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbjEaH13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:27:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9E013E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685518041; x=1717054041;
  h=date:from:to:cc:subject:message-id;
  bh=R8ZCbntqObTiH6UzwjSRp6XIi68XOmQ0nBDufyVHZ34=;
  b=QyZ3iQ3T4NPNCyrIwABkQ2tzWolyM8VBNjAvQU6zcVq0ZiGywMSxBz27
   pjabqc3QKKzuwPTum8Ie4NApnhdvQ6+GFJljbpimWQ0ZJl6FtKsbl5BVi
   xv0L1W72yYoCy0AIQMFe0jYmVlmpxFvqXpGM/tx00ju1RTFesmJrNVQ9e
   wgUIL4Sno0+Ks3c364q0lptesmEXYiuRSXSQnqbdWnzNdlwAjxaeqcGwj
   fmMir0Vl1qCPrU+loKP+5Wl/n74PgnrwUIFntWk8KLJ0I2vRNiDUBNUx8
   hrPo14xP6itF0KPp60UOaNU0eoJSVaxRCvdIcGbrSjfXNASBhBnvjhj2Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="441518831"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="441518831"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 00:27:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="736561677"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="736561677"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 31 May 2023 00:27:04 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4GEZ-00018v-0V;
        Wed, 31 May 2023 07:27:03 +0000
Date:   Wed, 31 May 2023 15:26:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 dfd90d4e61152f86b8102df51a9af5ee9af77a63
Message-ID: <20230531072646.rY5fB%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: dfd90d4e61152f86b8102df51a9af5ee9af77a63  Merge x86/cache into tip/master

elapsed time: 724m

configs tested: 7
configs skipped: 107

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
