Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A4A6CCF8C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 03:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjC2Bfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 21:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2Bfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:35:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7472319BF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 18:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680053731; x=1711589731;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9GTVNxeBD4oL31NMZdlMpkdB6aNDnGTaWwGCJFVPy1I=;
  b=WMLhiP6RsaiVgNqwG6w1ZI7yPDOgT8T0oMm3ftyURB1gCKX1rup/cVUC
   gN011qnACs4QweNf6y0dfx8qEHDGtfQeJOTfZ8Ln8yp3YS/7BD6mLEKaA
   L6/qJpRKpVV3kGTymt+DsNITbUlKmjKe/g+hmsWLCm05W0VEg5q3rX9eg
   rD6PT3+5NI4d6a/BJ1vUKsz3ja3cI421DIpVIkRLX4LrOFqNh47tzx+W0
   9WcHQUsx21qxiEhwlJYWzBvf7uX5EPsHASMkaRbx80NYAG4g+28C+VIGW
   WinjqI+cqOyCQ1L3l07GbOLSN3m70HJKT1XVUj6qorO2Fu5nkhrZlGwXZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="338247055"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="338247055"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 18:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="858290384"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="858290384"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Mar 2023 18:35:29 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phKim-000J3H-2M;
        Wed, 29 Mar 2023 01:35:28 +0000
Date:   Wed, 29 Mar 2023 09:34:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 4b7aa0abddffed3cdd3f96bbf32ae98cd68f4d30
Message-ID: <642395bb.Y03WSydFY8Ot/x1l%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 4b7aa0abddffed3cdd3f96bbf32ae98cd68f4d30  Merge x86/sev into tip/master

elapsed time: 743m

configs tested: 8
configs skipped: 146

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
