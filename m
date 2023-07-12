Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB3A750A44
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjGLOA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjGLOAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:00:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC221711
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689170423; x=1720706423;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LyB0zD5+AG6Lhc8b4Tdz6GicNxX4DRWTxelGM9Tcvyg=;
  b=ZskmJhJzSsgZtKq65M1l2JwFkI1004wLkF9wW/NnN3yggWJ8ffIp75K0
   7PXJx4umauciH+9yuS4wzDbtDr8hvL9XtXF2GHsN4LGG6xTJHayKk/t5/
   TpXdTKZuz7JucqVdJnWkX9yk8UxAVZ93guiGlM7+n6/6RaNL7kdqXH2f5
   PFP6XMVmVVIR0FHNmj3/+9sALZ1bdZboNI6TCRenk3uufaLUzRrWxYTwp
   qA+ffRq1jD/w5I+BCcDeMtq2w/IfJH8MP5T3SXxDRZWmoi7S5cy/eMptB
   MOHVgQtoSEzAtU1yhp16m/t3NTr0frLAsgK992X9rmGPG5wkPcgm67bF+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="431027480"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="431027480"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 06:59:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="698875813"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="698875813"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 12 Jul 2023 06:59:57 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJaNo-0005kL-1K;
        Wed, 12 Jul 2023 13:59:56 +0000
Date:   Wed, 12 Jul 2023 21:59:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/soc/qcom/qdsp6/q6apm.c:30:14: sparse: sparse: symbol 'g_apm'
 was not declared. Should it be static?
Message-ID: <202307122100.08XU08G6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
commit: 47bc8cf60e926d1fb0c5d990bf6f5e01e9b3352e ASoC: qdsp6: audioreach: Add ADSP ready check
date:   6 months ago
config: arm64-randconfig-r072-20230712 (https://download.01.org/0day-ci/archive/20230712/202307122100.08XU08G6-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230712/202307122100.08XU08G6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307122100.08XU08G6-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/soc/qcom/qdsp6/q6apm.c:30:14: sparse: sparse: symbol 'g_apm' was not declared. Should it be static?

vim +/g_apm +30 sound/soc/qcom/qdsp6/q6apm.c

    29	
  > 30	struct q6apm *g_apm;
    31	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
