Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F269569014A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjBIHkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBIHke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:40:34 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722F62411E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 23:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675928432; x=1707464432;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B1TOyY+MhZjVA+vzPBQbOLfHQzxw482GbD8zN6ODZUs=;
  b=Lxp63fn/L2oSTQKEx9oo0SnTcdfW9clNoB86/IjTuJAEgjCv9slQ7N2p
   H/JeAuqNStDIS81lWS+m1yqxNtvS20keiCzr29s3rDl1d9Xm91VeOy5ma
   GfVXPBcwXhjwHiNTIt6kow40LFO7VghZCMZzYduSGgMraJwm4BNBSHla7
   pHfPJim12DM/gO27QWQH6Mykki55CxZIYHQpbeRV9G2411XNmNVTCNFow
   6DDD0m49lA47fevU4SQuGK8ls2PtunRy8fxb4W780ejJUaGvxBQii9OXw
   e4etn15dpNx8L4P8AJih24lma3Rz+EA9CzHF6WS6WW+cBkiHFAi9u3YdK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="332159767"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="332159767"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 23:40:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669493062"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="669493062"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 23:40:30 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQ1Xh-0004vE-0r;
        Thu, 09 Feb 2023 07:40:29 +0000
Date:   Thu, 9 Feb 2023 15:40:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/perf/arm-ccn.c:835:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202302091516.hPClaPyK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0983f6bf2bfc0789b51ddf7315f644ff4da50acb
commit: f3c0eba287049237b23d1300376768293eb89e69 perf: Add a few assertions
date:   5 months ago
config: loongarch-randconfig-s031-20230209 (https://download.01.org/0day-ci/archive/20230209/202302091516.hPClaPyK-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f3c0eba287049237b23d1300376768293eb89e69
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f3c0eba287049237b23d1300376768293eb89e69
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/perf/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302091516.hPClaPyK-lkp@intel.com

sparse warnings: (new ones prefixed by >>)
>> drivers/perf/arm-ccn.c:835:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm-ccn.c:835:9: sparse:     expected void *ptr
   drivers/perf/arm-ccn.c:835:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm-ccn.c:835:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm-ccn.c:835:9: sparse:     expected void *ptr
   drivers/perf/arm-ccn.c:835:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm-ccn.c:835:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm-ccn.c:835:9: sparse:     expected void *ptr
   drivers/perf/arm-ccn.c:835:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm-ccn.c:835:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm-ccn.c:835:9: sparse:     expected void *ptr
   drivers/perf/arm-ccn.c:835:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm-ccn.c:835:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm-ccn.c:835:9: sparse:     expected void *ptr
   drivers/perf/arm-ccn.c:835:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm-ccn.c:835:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm-ccn.c:835:9: sparse:     expected void *ptr
   drivers/perf/arm-ccn.c:835:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm-ccn.c:835:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm-ccn.c:835:9: sparse:     expected void *ptr
   drivers/perf/arm-ccn.c:835:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm-ccn.c:835:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm-ccn.c:835:9: sparse:     expected void *ptr
   drivers/perf/arm-ccn.c:835:9: sparse:     got int [noderef] __percpu *
   drivers/perf/arm-ccn.c: note: in included file (through arch/loongarch/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:239:15: sparse: sparse: cast to restricted __le64

vim +835 drivers/perf/arm-ccn.c

8fb22264350d99 drivers/bus/arm-ccn.c  Pawel Moll     2014-09-02  712  
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  713  static int arm_ccn_pmu_event_init(struct perf_event *event)
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  714  {
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  715  	struct arm_ccn *ccn;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  716  	struct hw_perf_event *hw = &event->hw;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  717  	u32 node_xp, type, event_id;
57006d3e6f62de drivers/bus/arm-ccn.c  Pawel Moll     2015-04-17  718  	int valid;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  719  	int i;
9ce1aa869e69cf drivers/bus/arm-ccn.c  Pawel Moll     2015-04-17  720  	struct perf_event *sibling;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  721  
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  722  	if (event->attr.type != event->pmu->type)
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  723  		return -ENOENT;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  724  
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  725  	ccn = pmu_to_arm_ccn(event->pmu);
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  726  
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  727  	if (hw->sample_period) {
1898eb61fbc970 drivers/perf/arm-ccn.c Mark Rutland   2018-05-21  728  		dev_dbg(ccn->dev, "Sampling not supported!\n");
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  729  		return -EOPNOTSUPP;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  730  	}
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  731  
306563985819ed drivers/perf/arm-ccn.c Andrew Murray  2019-01-10  732  	if (has_branch_stack(event)) {
1898eb61fbc970 drivers/perf/arm-ccn.c Mark Rutland   2018-05-21  733  		dev_dbg(ccn->dev, "Can't exclude execution levels!\n");
3249bce459ff0b drivers/bus/arm-ccn.c  Pawel Moll     2016-08-11  734  		return -EINVAL;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  735  	}
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  736  
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  737  	if (event->cpu < 0) {
1898eb61fbc970 drivers/perf/arm-ccn.c Mark Rutland   2018-05-21  738  		dev_dbg(ccn->dev, "Can't provide per-task data!\n");
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  739  		return -EOPNOTSUPP;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  740  	}
ffa415245b8666 drivers/bus/arm-ccn.c  Pawel Moll     2015-04-16  741  	/*
ffa415245b8666 drivers/bus/arm-ccn.c  Pawel Moll     2015-04-16  742  	 * Many perf core operations (eg. events rotation) operate on a
ffa415245b8666 drivers/bus/arm-ccn.c  Pawel Moll     2015-04-16  743  	 * single CPU context. This is obvious for CPU PMUs, where one
ffa415245b8666 drivers/bus/arm-ccn.c  Pawel Moll     2015-04-16  744  	 * expects the same sets of events being observed on all CPUs,
ffa415245b8666 drivers/bus/arm-ccn.c  Pawel Moll     2015-04-16  745  	 * but can lead to issues for off-core PMUs, like CCN, where each
ffa415245b8666 drivers/bus/arm-ccn.c  Pawel Moll     2015-04-16  746  	 * event could be theoretically assigned to a different CPU. To
ffa415245b8666 drivers/bus/arm-ccn.c  Pawel Moll     2015-04-16  747  	 * mitigate this, we enforce CPU assignment to one, selected
ffa415245b8666 drivers/bus/arm-ccn.c  Pawel Moll     2015-04-16  748  	 * processor (the one described in the "cpumask" attribute).
ffa415245b8666 drivers/bus/arm-ccn.c  Pawel Moll     2015-04-16  749  	 */
9bcb929f969e40 drivers/perf/arm-ccn.c Robin Murphy   2019-04-16  750  	event->cpu = ccn->dt.cpu;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  751  
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  752  	node_xp = CCN_CONFIG_NODE(event->attr.config);
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  753  	type = CCN_CONFIG_TYPE(event->attr.config);
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  754  	event_id = CCN_CONFIG_EVENT(event->attr.config);
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  755  
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  756  	/* Validate node/xp vs topology */
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  757  	switch (type) {
4e486cba285ff0 drivers/bus/arm-ccn.c  Pawel Moll     2016-08-02  758  	case CCN_TYPE_MN:
4e486cba285ff0 drivers/bus/arm-ccn.c  Pawel Moll     2016-08-02  759  		if (node_xp != ccn->mn_id) {
1898eb61fbc970 drivers/perf/arm-ccn.c Mark Rutland   2018-05-21  760  			dev_dbg(ccn->dev, "Invalid MN ID %d!\n", node_xp);
4e486cba285ff0 drivers/bus/arm-ccn.c  Pawel Moll     2016-08-02  761  			return -EINVAL;
4e486cba285ff0 drivers/bus/arm-ccn.c  Pawel Moll     2016-08-02  762  		}
4e486cba285ff0 drivers/bus/arm-ccn.c  Pawel Moll     2016-08-02  763  		break;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  764  	case CCN_TYPE_XP:
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  765  		if (node_xp >= ccn->num_xps) {
1898eb61fbc970 drivers/perf/arm-ccn.c Mark Rutland   2018-05-21  766  			dev_dbg(ccn->dev, "Invalid XP ID %d!\n", node_xp);
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  767  			return -EINVAL;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  768  		}
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  769  		break;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  770  	case CCN_TYPE_CYCLES:
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  771  		break;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  772  	default:
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  773  		if (node_xp >= ccn->num_nodes) {
1898eb61fbc970 drivers/perf/arm-ccn.c Mark Rutland   2018-05-21  774  			dev_dbg(ccn->dev, "Invalid node ID %d!\n", node_xp);
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  775  			return -EINVAL;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  776  		}
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  777  		if (!arm_ccn_pmu_type_eq(type, ccn->node[node_xp].type)) {
1898eb61fbc970 drivers/perf/arm-ccn.c Mark Rutland   2018-05-21  778  			dev_dbg(ccn->dev, "Invalid type 0x%x for node %d!\n",
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  779  					type, node_xp);
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  780  			return -EINVAL;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  781  		}
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  782  		break;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  783  	}
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  784  
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  785  	/* Validate event ID vs available for the type */
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  786  	for (i = 0, valid = 0; i < ARRAY_SIZE(arm_ccn_pmu_events) && !valid;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  787  			i++) {
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  788  		struct arm_ccn_pmu_event *e = &arm_ccn_pmu_events[i];
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  789  		u32 port = CCN_CONFIG_PORT(event->attr.config);
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  790  		u32 vc = CCN_CONFIG_VC(event->attr.config);
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  791  
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  792  		if (!arm_ccn_pmu_type_eq(type, e->type))
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  793  			continue;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  794  		if (event_id != e->event)
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  795  			continue;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  796  		if (e->num_ports && port >= e->num_ports) {
1898eb61fbc970 drivers/perf/arm-ccn.c Mark Rutland   2018-05-21  797  			dev_dbg(ccn->dev, "Invalid port %d for node/XP %d!\n",
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  798  					port, node_xp);
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  799  			return -EINVAL;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  800  		}
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  801  		if (e->num_vcs && vc >= e->num_vcs) {
1898eb61fbc970 drivers/perf/arm-ccn.c Mark Rutland   2018-05-21  802  			dev_dbg(ccn->dev, "Invalid vc %d for node/XP %d!\n",
bf87bb12bd7062 drivers/bus/arm-ccn.c  Pawel Moll     2014-08-18  803  					vc, node_xp);
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  804  			return -EINVAL;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  805  		}
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  806  		valid = 1;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  807  	}
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  808  	if (!valid) {
1898eb61fbc970 drivers/perf/arm-ccn.c Mark Rutland   2018-05-21  809  		dev_dbg(ccn->dev, "Invalid event 0x%x for node/XP %d!\n",
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  810  				event_id, node_xp);
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  811  		return -EINVAL;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  812  	}
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  813  
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  814  	/* Watchpoint-based event for a node is actually set on XP */
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  815  	if (event_id == CCN_EVENT_WATCHPOINT && type != CCN_TYPE_XP) {
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  816  		u32 port;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  817  
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  818  		type = CCN_TYPE_XP;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  819  		port = arm_ccn_node_to_xp_port(node_xp);
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  820  		node_xp = arm_ccn_node_to_xp(node_xp);
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  821  
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  822  		arm_ccn_pmu_config_set(&event->attr.config,
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  823  				node_xp, type, port);
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  824  	}
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  825  
9ce1aa869e69cf drivers/bus/arm-ccn.c  Pawel Moll     2015-04-17  826  	/*
9ce1aa869e69cf drivers/bus/arm-ccn.c  Pawel Moll     2015-04-17  827  	 * We must NOT create groups containing mixed PMUs, although software
9ce1aa869e69cf drivers/bus/arm-ccn.c  Pawel Moll     2015-04-17  828  	 * events are acceptable (for example to create a CCN group
9ce1aa869e69cf drivers/bus/arm-ccn.c  Pawel Moll     2015-04-17  829  	 * periodically read when a hrtimer aka cpu-clock leader triggers).
9ce1aa869e69cf drivers/bus/arm-ccn.c  Pawel Moll     2015-04-17  830  	 */
9ce1aa869e69cf drivers/bus/arm-ccn.c  Pawel Moll     2015-04-17  831  	if (event->group_leader->pmu != event->pmu &&
9ce1aa869e69cf drivers/bus/arm-ccn.c  Pawel Moll     2015-04-17  832  			!is_software_event(event->group_leader))
9ce1aa869e69cf drivers/bus/arm-ccn.c  Pawel Moll     2015-04-17  833  		return -EINVAL;
9ce1aa869e69cf drivers/bus/arm-ccn.c  Pawel Moll     2015-04-17  834  
edb39592a5877b drivers/bus/arm-ccn.c  Peter Zijlstra 2018-03-15 @835  	for_each_sibling_event(sibling, event->group_leader) {
9ce1aa869e69cf drivers/bus/arm-ccn.c  Pawel Moll     2015-04-17  836  		if (sibling->pmu != event->pmu &&
9ce1aa869e69cf drivers/bus/arm-ccn.c  Pawel Moll     2015-04-17  837  				!is_software_event(sibling))
9ce1aa869e69cf drivers/bus/arm-ccn.c  Pawel Moll     2015-04-17  838  			return -EINVAL;
edb39592a5877b drivers/bus/arm-ccn.c  Peter Zijlstra 2018-03-15  839  	}
9ce1aa869e69cf drivers/bus/arm-ccn.c  Pawel Moll     2015-04-17  840  
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  841  	return 0;
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  842  }
a33b0daab73a0e drivers/bus/arm-ccn.c  Pawel Moll     2014-07-22  843  

:::::: The code at line 835 was first introduced by commit
:::::: edb39592a5877bd91b2e6ee15194268f35b04892 perf: Fix sibling iteration

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
