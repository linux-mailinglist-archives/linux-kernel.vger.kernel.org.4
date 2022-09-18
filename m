Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7BA5BBBA0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 06:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiIREdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 00:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIREdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 00:33:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC41275C7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 21:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663475599; x=1695011599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YFsGHYQm8fWHF/Mh2opqm57tS+b/OEtqHzuBxfwojsw=;
  b=dYGquILZbGVJMxGc8pBHUV9nRs1N0VBXXTPJDSTbXMvYwccfuZ1IXWHs
   atExdBjxkjh53y5LuArLJQQbd2ZcKgHbPSnBA9tr1GDWjSgtuFs1S5I8b
   16EXfDfNeeqnyL3qTIb/qLBuyANRMJnp0TqSUt6OEocLkCwO5dwcOMKzj
   VMmvNLj3ZTWNQ5sWg0cmPsL5wm4L2CBLn1XyPGcRNjFUKFgviHCH4bgXW
   0TuJjqsJUjA/dL1BR4iW5Kx2uPYp2PBCSFNKgmCwOSf5F1FgU+14ckEfa
   mTSJA+j3A44N3ts17Pt0IMbIwQeoe99zIaEcqiYIYcCX64HIFchwBenfQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="286245060"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="286245060"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 21:33:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="569261809"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 Sep 2022 21:33:17 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZlzY-0000sX-2I;
        Sun, 18 Sep 2022 04:33:16 +0000
Date:   Sun, 18 Sep 2022 12:32:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jingyu Wang <jingyuwang_vip@163.com>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jingyu Wang <jingyuwang_vip@163.com>
Subject: Re: [PATCH] firmware: arm_scmi: remove unnecessary 'NULL' values
 from pointer
Message-ID: <202209181214.kSFKDUG9-lkp@intel.com>
References: <20220918021410.17369-1-jingyuwang_vip@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220918021410.17369-1-jingyuwang_vip@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jingyu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on d5538ab91d3a9a237805be6f8c6c272af2987995]

url:    https://github.com/intel-lab-lkp/linux/commits/Jingyu-Wang/firmware-arm_scmi-remove-unnecessary-NULL-values-from-pointer/20220918-101734
base:   d5538ab91d3a9a237805be6f8c6c272af2987995
config: riscv-randconfig-r042-20220918 (https://download.01.org/0day-ci/archive/20220918/202209181214.kSFKDUG9-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/7fd368bb28e43ed330ef1e678986e3ef1fbc4295
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jingyu-Wang/firmware-arm_scmi-remove-unnecessary-NULL-values-from-pointer/20220918-101734
        git checkout 7fd368bb28e43ed330ef1e678986e3ef1fbc4295
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/firmware/arm_scmi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/firmware/arm_scmi/perf.c:762:2: warning: variable 'rep' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
           default:
           ^~~~~~~
   drivers/firmware/arm_scmi/perf.c:766:9: note: uninitialized use occurs here
           return rep;
                  ^~~
>> drivers/firmware/arm_scmi/perf.c:751:7: warning: variable 'rep' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
                   if (sizeof(*p) != payld_sz)
                       ^~~~~~~~~~~~~~~~~~~~~~
   drivers/firmware/arm_scmi/perf.c:766:9: note: uninitialized use occurs here
           return rep;
                  ^~~
   drivers/firmware/arm_scmi/perf.c:751:3: note: remove the 'if' if its condition is always false
                   if (sizeof(*p) != payld_sz)
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/firmware/arm_scmi/perf.c:734:7: warning: variable 'rep' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
                   if (sizeof(*p) != payld_sz)
                       ^~~~~~~~~~~~~~~~~~~~~~
   drivers/firmware/arm_scmi/perf.c:766:9: note: uninitialized use occurs here
           return rep;
                  ^~~
   drivers/firmware/arm_scmi/perf.c:734:3: note: remove the 'if' if its condition is always false
                   if (sizeof(*p) != payld_sz)
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/firmware/arm_scmi/perf.c:726:11: note: initialize the variable 'rep' to silence this warning
           void *rep;
                    ^
                     = NULL
   3 warnings generated.


vim +/rep +762 drivers/firmware/arm_scmi/perf.c

fb5086dc474618 Cristian Marussi 2020-07-01  720  
3cb8c95f4b3055 Cristian Marussi 2021-03-16  721  static void *scmi_perf_fill_custom_report(const struct scmi_protocol_handle *ph,
72a5eb9d9c319c Cristian Marussi 2020-07-10  722  					  u8 evt_id, ktime_t timestamp,
fb5086dc474618 Cristian Marussi 2020-07-01  723  					  const void *payld, size_t payld_sz,
fb5086dc474618 Cristian Marussi 2020-07-01  724  					  void *report, u32 *src_id)
fb5086dc474618 Cristian Marussi 2020-07-01  725  {
7fd368bb28e43e Jingyu Wang      2022-09-18  726  	void *rep;
fb5086dc474618 Cristian Marussi 2020-07-01  727  
fb5086dc474618 Cristian Marussi 2020-07-01  728  	switch (evt_id) {
fb5086dc474618 Cristian Marussi 2020-07-01  729  	case SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED:
fb5086dc474618 Cristian Marussi 2020-07-01  730  	{
fb5086dc474618 Cristian Marussi 2020-07-01  731  		const struct scmi_perf_limits_notify_payld *p = payld;
fb5086dc474618 Cristian Marussi 2020-07-01  732  		struct scmi_perf_limits_report *r = report;
fb5086dc474618 Cristian Marussi 2020-07-01  733  
fb5086dc474618 Cristian Marussi 2020-07-01  734  		if (sizeof(*p) != payld_sz)
fb5086dc474618 Cristian Marussi 2020-07-01  735  			break;
fb5086dc474618 Cristian Marussi 2020-07-01  736  
fb5086dc474618 Cristian Marussi 2020-07-01  737  		r->timestamp = timestamp;
fb5086dc474618 Cristian Marussi 2020-07-01  738  		r->agent_id = le32_to_cpu(p->agent_id);
fb5086dc474618 Cristian Marussi 2020-07-01  739  		r->domain_id = le32_to_cpu(p->domain_id);
fb5086dc474618 Cristian Marussi 2020-07-01  740  		r->range_max = le32_to_cpu(p->range_max);
fb5086dc474618 Cristian Marussi 2020-07-01  741  		r->range_min = le32_to_cpu(p->range_min);
fb5086dc474618 Cristian Marussi 2020-07-01  742  		*src_id = r->domain_id;
fb5086dc474618 Cristian Marussi 2020-07-01  743  		rep = r;
fb5086dc474618 Cristian Marussi 2020-07-01  744  		break;
fb5086dc474618 Cristian Marussi 2020-07-01  745  	}
fb5086dc474618 Cristian Marussi 2020-07-01  746  	case SCMI_EVENT_PERFORMANCE_LEVEL_CHANGED:
fb5086dc474618 Cristian Marussi 2020-07-01  747  	{
fb5086dc474618 Cristian Marussi 2020-07-01  748  		const struct scmi_perf_level_notify_payld *p = payld;
fb5086dc474618 Cristian Marussi 2020-07-01  749  		struct scmi_perf_level_report *r = report;
fb5086dc474618 Cristian Marussi 2020-07-01  750  
fb5086dc474618 Cristian Marussi 2020-07-01 @751  		if (sizeof(*p) != payld_sz)
fb5086dc474618 Cristian Marussi 2020-07-01  752  			break;
fb5086dc474618 Cristian Marussi 2020-07-01  753  
fb5086dc474618 Cristian Marussi 2020-07-01  754  		r->timestamp = timestamp;
fb5086dc474618 Cristian Marussi 2020-07-01  755  		r->agent_id = le32_to_cpu(p->agent_id);
fb5086dc474618 Cristian Marussi 2020-07-01  756  		r->domain_id = le32_to_cpu(p->domain_id);
fb5086dc474618 Cristian Marussi 2020-07-01  757  		r->performance_level = le32_to_cpu(p->performance_level);
fb5086dc474618 Cristian Marussi 2020-07-01  758  		*src_id = r->domain_id;
fb5086dc474618 Cristian Marussi 2020-07-01  759  		rep = r;
fb5086dc474618 Cristian Marussi 2020-07-01  760  		break;
fb5086dc474618 Cristian Marussi 2020-07-01  761  	}
fb5086dc474618 Cristian Marussi 2020-07-01 @762  	default:
fb5086dc474618 Cristian Marussi 2020-07-01  763  		break;
fb5086dc474618 Cristian Marussi 2020-07-01  764  	}
fb5086dc474618 Cristian Marussi 2020-07-01  765  
fb5086dc474618 Cristian Marussi 2020-07-01  766  	return rep;
fb5086dc474618 Cristian Marussi 2020-07-01  767  }
fb5086dc474618 Cristian Marussi 2020-07-01  768  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
