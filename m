Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCCB5BD49C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiISSOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiISSNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:13:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316F045F59
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663611234; x=1695147234;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6qVBee4sbFvq7itksIrlagb/Qx0I8jv4UNGR21bkTJA=;
  b=ljbSExjmk5T1AdpIB5ugPtFIkN/MnZr+6DedR+/ZUErp/eSA0Z7ZRPFK
   +b4k0VcQTTbJuNPh+vjR4SPdtToHwvmO1+ZHoGa4eXhgTZRwK1F32eh7L
   KVycLWgKc8ZfaQFJJlSLa+VRxSnelRNzWYfR7xQU68YZKeqX7O2P9Yvrd
   oIyqUR+/DY+9Hv/IH2OIlJGQxmKRj0sjmuGsY+H+sRfbdrLUsLGtM8yZM
   eDznb8geytkWEjzb9F4rB2HpxlSR9jPX8mFnSP6knd/4Asng7Dl1/ziDP
   f0P5zZ08AC28Oa8uj6Vht6Tdc/itkj/h9lgARgOJZGQpKSpPgw8e3mUZR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="286523748"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="286523748"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 11:13:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="680956884"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 19 Sep 2022 11:13:50 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaLHC-0002A5-08;
        Mon, 19 Sep 2022 18:13:50 +0000
Date:   Tue, 20 Sep 2022 02:13:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Erdem Aktas <erdemaktas@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>
Subject: [intel-tdx:kvm-upstream-workaround 206/314] lib/kvm_util.c:191:20:
 error: 'type' undeclared
Message-ID: <202209200124.Y8biqSRC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   552dd80c48f67ca01bcdd10667e0c11efd375177
commit: 38b15ceaa9014e2df231dbbca752bdb17c3880c7 [206/314] KVM: selftest: Add support for creating non-default type VMs
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # https://github.com/intel/tdx/commit/38b15ceaa9014e2df231dbbca752bdb17c3880c7
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 38b15ceaa9014e2df231dbbca752bdb17c3880c7
        make O=/tmp/kselftest headers
        make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   lib/kvm_util.c: In function '____vm_create':
>> lib/kvm_util.c:191:20: error: 'type' undeclared (first use in this function)
     191 |         vm->type = type;
         |                    ^~~~
   lib/kvm_util.c:191:20: note: each undeclared identifier is reported only once for each function it appears in

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
