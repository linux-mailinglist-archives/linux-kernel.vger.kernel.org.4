Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF725B40BF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiIIUdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiIIUca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:32:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE25167F3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662755528; x=1694291528;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Pmu8frnOL/Ly+FNwVD525vqNUcP+gJG6E+zFw5SaXio=;
  b=kyC/NX9EMrMoEFOypn230UO6ZDnU+5De0hShsFaO/ltY69+VXotl0WxT
   OgZcfwZLJa0XTjdAVP2n5SMzwJXrauhGoTU1EcvIE/dsgwTWlsxrPcZgA
   ipnXnBnp17DUMDSr5aPV7aBfaIwtY4IjaRY53Dtk8mrJW3pwDOip4mnp/
   ScVHz2r8k8YV4gtWVanA0O1maMGo/8RNIeHY+E7VgXJjZdGx99Gsh/tye
   zL7VxeJJlojb4lk+8VWcBd12s4bz2RpYJ/YALF6ezO9Zu8VlUJoPppbbj
   lKC40RO6GkzMstFBHMMl43Y05rRZ/0Ai/Rf0bfcp/a9yFaKHM4HkVTyc4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="359289176"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="359289176"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 13:32:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="683767711"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Sep 2022 13:32:06 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWkfW-0001hl-0b;
        Fri, 09 Sep 2022 20:32:06 +0000
Date:   Sat, 10 Sep 2022 04:31:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:tp_fix 1/1] trampoline.c:undefined reference to
 `bpf_prog_inc_misses_counter'
Message-ID: <202209100409.3Y73xcfp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git tp_fix
head:   1d5150ae30634ba3ff98b5ac0489f44375acca56
commit: 1d5150ae30634ba3ff98b5ac0489f44375acca56 [1/1] bpf: Prevent bpf program recursion for raw tracepoint probes
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220910/202209100409.3Y73xcfp-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=1d5150ae30634ba3ff98b5ac0489f44375acca56
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf tp_fix
        git checkout 1d5150ae30634ba3ff98b5ac0489f44375acca56
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: kernel/bpf/trampoline.o: in function `__bpf_prog_enter':
>> trampoline.c:(.text+0x1681): undefined reference to `bpf_prog_inc_misses_counter'
   ld: kernel/bpf/trampoline.o: in function `__bpf_prog_enter_sleepable':
   trampoline.c:(.text+0x19b1): undefined reference to `bpf_prog_inc_misses_counter'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
