Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08955BA3C7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 03:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiIPBQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 21:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIPBQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 21:16:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E194F19A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 18:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663290961; x=1694826961;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9Ihfwn7NXOoXT4dpjk6Ow0fAbq9eRKXs7h0VAVEIM00=;
  b=fkVMtQ25hJVX7VXuIh4XfigaRX2xB9qJ6WbvnZW3oCh3QKGGZpe3xOhq
   sD3xJudXbW4LbFlqWsKJT/TdTCQgDSJBCAbfm3p73b15vpamqIsukg+bd
   KE5j+tdAet0tqtV/yTvShHshI7ftFjw0dtskoeR/UaUX43Uq1az+c0AO5
   OoSfkgmANqOfTN0M8pVY6QFbP/YMAmtbiFeAkWo7MgvoitpVEZs5l7GRF
   NrmDdKLB/M1ICIdA5H77aBc+hMxPu5U/VEZNK5qoerT/7cjlS1YsUcDhO
   BTP+19wNsh9lXO6rDQNScdgnwZ1ZTfPhi3SyGwweG0eILomHVJtD6Vj2r
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="325150428"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="325150428"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 18:16:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="946196435"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 15 Sep 2022 18:16:00 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYzxX-0001Gl-29;
        Fri, 16 Sep 2022 01:15:59 +0000
Date:   Fri, 16 Sep 2022 09:15:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/vdso 3/3] ld:
 arch/x86/entry/syscall_32.o:undefined reference to
 `__ia32_sys_vgetrandom_alloc'
Message-ID: <202209160958.4VsH4AEf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/vdso
head:   a3cff810520ec7bb9afb9020a1cb7945e4bdb8b2
commit: a3cff810520ec7bb9afb9020a1cb7945e4bdb8b2 [3/3] random: implement getrandom() in vDSO
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220916/202209160958.4VsH4AEf-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/a3cff810520ec7bb9afb9020a1cb7945e4bdb8b2
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/vdso
        git checkout a3cff810520ec7bb9afb9020a1cb7945e4bdb8b2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld: arch/x86/entry/syscall_32.o:(.rodata+0x70c): undefined reference to `__ia32_sys_vgetrandom_alloc'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
