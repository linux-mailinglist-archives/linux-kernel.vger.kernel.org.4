Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD8C6D680F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjDDP6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDDP6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:58:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5854518D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680623919; x=1712159919;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RBQmbevQWhkiiurYdI0qrk1YkroGIug5Hlcj+Prt3PQ=;
  b=Y28c6+VpqNFsYbwEW6b06eugg/WOhy2NbX83exkIm64NPMHJ19aSuN6O
   DoCuaksykrGGn/5J3mFD84AZdCb1AcQzh/dNpEdudmL0fixNgwteDYzh3
   G1Rm2UOiR3lsuYqvfG9BiswqyO5tnFc7yfno74uUr/dTKZokZBDJvTGc2
   hVMmqpSUudVbFWRD2FUIycNYq2w9KNMBuXQNneRYuJaME4BlDBATpeeHA
   ftr8nY08tzEjus5q+cECVmc3ugjw3yagAWmSBUZbmHYXMZcwEVMLF9ydv
   NciXyx5ViveAvhhqxY9OsXGJK9PTJNabux2bc3E2oAnno5m87oIQ6b862
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="407296602"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="407296602"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 08:58:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="718989430"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="718989430"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Apr 2023 08:58:37 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjj3I-000PrA-0a;
        Tue, 04 Apr 2023 15:58:32 +0000
Date:   Tue, 4 Apr 2023 23:58:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: thermometer.c:21:10: fatal error: libconfig.h: No such file or
 directory
Message-ID: <202304042346.joPYYFMi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   148341f0a2f53b5e8808d093333d85170586a15d
commit: 110acbc6a4518145db3a1a9c0686d730bb258bf1 tools/thermal: Add a temperature capture tool
date:   11 months ago
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=110acbc6a4518145db3a1a9c0686d730bb258bf1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 110acbc6a4518145db3a1a9c0686d730bb258bf1
        make O=/tmp/kselftest headers
        make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304042346.joPYYFMi-lkp@intel.com/

All errors (new ones prefixed by >>):

>> thermometer.c:21:10: fatal error: libconfig.h: No such file or directory
      21 | #include <libconfig.h>
         |          ^~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [Makefile:23: thermometer] Error 1

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
