Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9CC5BCD15
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiISNZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiISNZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:25:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC39DF39
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 06:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663593934; x=1695129934;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uDzBR8WNG0RIWmKhznfJ0ynAQY2rx7AX3/LvMnWgNNI=;
  b=CCsjKZyObjK5Artb3jFvxAbGbCZGCOTRfACvCHciaVyEU0MWXAhJ/B8A
   qLcGQ/TyZ0SIsPk7/uAjI4PaeMC6efVSX8fnFcpodlMuArxW5R2BSAWm9
   gmBKYfZGYAwjgVm7Po8kiXF/851/uMfHTQP+GV+QckQQcM7gmkzyLjtrd
   E3LmvzDOY1+cGAattmIc7n+qapK+s9HE/s2iAsup2lPBrqJSwtP7oZRa3
   gKgDmP5ToxCuMj/W3DpYHOIGA0Sl9PFGI/4UcyX46p9LTStszCv4V0eBq
   CReSFtA6jafAYQ04l3xJ7n0OmMwnMa+b4GcDuIT7gSErMCzAqMFfNQkdK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="296992033"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="296992033"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 06:25:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="569651758"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Sep 2022 06:25:33 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaGmC-0001zf-1W;
        Mon, 19 Sep 2022 13:25:32 +0000
Date:   Mon, 19 Sep 2022 21:24:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 135/314] memfd_test.c:1025:34:
 error: 'F_SEAL_AUTO_ALLOCATE' undeclared
Message-ID: <202209192142.TsjtmilL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   552dd80c48f67ca01bcdd10667e0c11efd375177
commit: 6fc2c0d90c42ad750192a03cdf03d78befd0d8ce [135/314] selftests/memfd: Add tests for F_SEAL_AUTO_ALLOCATE
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # https://github.com/intel/tdx/commit/6fc2c0d90c42ad750192a03cdf03d78befd0d8ce
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 6fc2c0d90c42ad750192a03cdf03d78befd0d8ce
        make O=/tmp/kselftest headers
        make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   memfd_test.c: In function 'test_seal_auto_allocate':
>> memfd_test.c:1025:34: error: 'F_SEAL_AUTO_ALLOCATE' undeclared (first use in this function)
    1025 |         mfd_assert_add_seals(fd, F_SEAL_AUTO_ALLOCATE);
         |                                  ^~~~~~~~~~~~~~~~~~~~
   memfd_test.c:1025:34: note: each undeclared identifier is reported only once for each function it appears in

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
