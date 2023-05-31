Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62A4717826
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjEaH10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjEaH1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:27:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9160C0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685518025; x=1717054025;
  h=date:from:to:cc:subject:message-id;
  bh=F8DjWg42gz95fl++hq7NcxPSOAfmSCl95r8CMyUivEM=;
  b=bjUd+9OS67P0/eCyMezoRrrScRuMz/U0+kkAhxJ4T0EnekPwK1JpfaEv
   4TwDMErIgQjIqGt+f1wl2bt6jGFFIZ5f7I67iNo3IA6Jk90Hv2xbWYzPK
   krfCAh45KN+PGiw/yafCZDLd4ZRTFSfOZxMfjOhiyVFS9z/rhP5x5NNyO
   mBTb6h24BUYnuxlvsvBwe6p/RExiOKCok7Ur9OIwmadkaJU0pwRWvx3as
   JfoXHv6uyLUvg/6YqNwZ/J5qc1aUkhGLg0/LT4OlC+HW167ts5kivv0gb
   iq3LCrpt3NmSYZt+ujwxcNLT50NlJYVKK3tosUTGnnsGTyrjaMYiBUF7r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="441518829"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="441518829"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 00:27:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="736561678"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="736561678"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 31 May 2023 00:27:04 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4GEZ-000191-0h;
        Wed, 31 May 2023 07:27:03 +0000
Date:   Wed, 31 May 2023 15:26:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 2997d94b5dd0e8b10076f5e0b6f18410c73e28bd
Message-ID: <20230531072611.z28Gy%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
branch HEAD: 2997d94b5dd0e8b10076f5e0b6f18410c73e28bd  x86/resctrl: Only show tasks' pid in current pid namespace

elapsed time: 723m

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
