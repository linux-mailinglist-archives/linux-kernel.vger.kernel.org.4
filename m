Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BC26D1CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjCaJlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCaJlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:41:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43F4A6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680255698; x=1711791698;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B2tO/P/P2UXnSRs+yYryjFmxuGvgvKCtVxOJlLufAx0=;
  b=ZOttVOYD3izv+H4a+g1hQpd7ZVfPjJBY3qj8yu0ZH+5n2TLQ3HADT6Hn
   pTXHBGf0cccSuFXHmGkhqDUnEizmp5D/YgEyUStqwXaTscAHlU2xgoGSh
   eUutdn0iKz+nlAxD2Wvys9cxQmNEHslEATJBWzTpKYlx5YktKJvEHoW9i
   aP/AgTALRRYMW/PBm8KifU0XTXX1JDcH4DBYL2oQYzluz07OOBmWuON7M
   UdsE6bnOE0Mc2tjEbqXxNw3f9ARMpeVTS+OsMVaFYKhwG5SfcZxBAqhu3
   NzsA0o06yAUiNZrbEu2qg465FBA1TcWmiDLDHqnKGK58rhZlUA4fZu7vs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="343926957"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="343926957"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 02:41:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="662353428"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="662353428"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Mar 2023 02:41:36 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piBGE-000Lei-2c;
        Fri, 31 Mar 2023 09:41:30 +0000
Date:   Fri, 31 Mar 2023 17:40:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: crypto/crypto_engine.c:56:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202303311726.MyYoXQRd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   62bad54b26db8bc98e28749cd76b2d890edb4258
commit: 93a4fa622eb061f75f87f0cf9609ab4e69c67d01 LoongArch: Add STACKTRACE support
date:   8 months ago
config: loongarch-randconfig-s033-20230329 (https://download.01.org/0day-ci/archive/20230331/202303311726.MyYoXQRd-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=93a4fa622eb061f75f87f0cf9609ab4e69c67d01
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 93a4fa622eb061f75f87f0cf9609ab4e69c67d01
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash arch/loongarch/kernel/ crypto/ drivers/perf/ kernel/events/ kernel/time/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303311726.MyYoXQRd-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> crypto/crypto_engine.c:56:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   crypto/crypto_engine.c:56:9: sparse:     expected void *ptr
   crypto/crypto_engine.c:56:9: sparse:     got unsigned int [noderef] __percpu *
>> crypto/crypto_engine.c:56:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   crypto/crypto_engine.c:56:9: sparse:     expected void *ptr
   crypto/crypto_engine.c:56:9: sparse:     got unsigned int [noderef] __percpu *
>> crypto/crypto_engine.c:56:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   crypto/crypto_engine.c:56:9: sparse:     expected void *ptr
   crypto/crypto_engine.c:56:9: sparse:     got unsigned int [noderef] __percpu *
>> crypto/crypto_engine.c:56:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   crypto/crypto_engine.c:56:9: sparse:     expected void *ptr
   crypto/crypto_engine.c:56:9: sparse:     got unsigned int [noderef] __percpu *
--
>> kernel/time/tick-sched.c:289:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:289:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:289:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/tick-sched.c:289:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:289:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:289:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/tick-sched.c:289:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:289:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:289:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/tick-sched.c:289:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:289:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:289:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/tick-sched.c:289:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:289:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:289:9: sparse:     got int [noderef] __percpu *
>> kernel/time/tick-sched.c:289:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:289:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:289:9: sparse:     got int [noderef] __percpu *
>> kernel/time/tick-sched.c:289:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:289:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:289:9: sparse:     got int [noderef] __percpu *
>> kernel/time/tick-sched.c:289:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:289:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:289:9: sparse:     got int [noderef] __percpu *
   kernel/time/tick-sched.c:490:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   kernel/time/tick-sched.c:490:17: sparse:     expected struct lockdep_map const *lock
   kernel/time/tick-sched.c:490:17: sparse:     got struct lockdep_map [noderef] __rcu *
   kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got int [noderef] __percpu *
   kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got int [noderef] __percpu *
   kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got int [noderef] __percpu *
   kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got int [noderef] __percpu *

vim +56 crypto/crypto_engine.c

735d37b5424b27 Baolin Wang    2016-01-26  18  
218d1cc1860c45 Corentin LABBE 2018-01-26  19  /**
218d1cc1860c45 Corentin LABBE 2018-01-26  20   * crypto_finalize_request - finalize one request if the request is done
218d1cc1860c45 Corentin LABBE 2018-01-26  21   * @engine: the hardware engine
218d1cc1860c45 Corentin LABBE 2018-01-26  22   * @req: the request need to be finalized
218d1cc1860c45 Corentin LABBE 2018-01-26  23   * @err: error number
218d1cc1860c45 Corentin LABBE 2018-01-26  24   */
218d1cc1860c45 Corentin LABBE 2018-01-26  25  static void crypto_finalize_request(struct crypto_engine *engine,
218d1cc1860c45 Corentin LABBE 2018-01-26  26  				    struct crypto_async_request *req, int err)
218d1cc1860c45 Corentin LABBE 2018-01-26  27  {
218d1cc1860c45 Corentin LABBE 2018-01-26  28  	unsigned long flags;
6a89f492f8e509 Iuliana Prodan 2020-04-28  29  	bool finalize_req = false;
218d1cc1860c45 Corentin LABBE 2018-01-26  30  	int ret;
218d1cc1860c45 Corentin LABBE 2018-01-26  31  	struct crypto_engine_ctx *enginectx;
218d1cc1860c45 Corentin LABBE 2018-01-26  32  
6a89f492f8e509 Iuliana Prodan 2020-04-28  33  	/*
6a89f492f8e509 Iuliana Prodan 2020-04-28  34  	 * If hardware cannot enqueue more requests
6a89f492f8e509 Iuliana Prodan 2020-04-28  35  	 * and retry mechanism is not supported
6a89f492f8e509 Iuliana Prodan 2020-04-28  36  	 * make sure we are completing the current request
6a89f492f8e509 Iuliana Prodan 2020-04-28  37  	 */
6a89f492f8e509 Iuliana Prodan 2020-04-28  38  	if (!engine->retry_support) {
218d1cc1860c45 Corentin LABBE 2018-01-26  39  		spin_lock_irqsave(&engine->queue_lock, flags);
6a89f492f8e509 Iuliana Prodan 2020-04-28  40  		if (engine->cur_req == req) {
6a89f492f8e509 Iuliana Prodan 2020-04-28  41  			finalize_req = true;
6a89f492f8e509 Iuliana Prodan 2020-04-28  42  			engine->cur_req = NULL;
6a89f492f8e509 Iuliana Prodan 2020-04-28  43  		}
218d1cc1860c45 Corentin LABBE 2018-01-26  44  		spin_unlock_irqrestore(&engine->queue_lock, flags);
6a89f492f8e509 Iuliana Prodan 2020-04-28  45  	}
218d1cc1860c45 Corentin LABBE 2018-01-26  46  
6a89f492f8e509 Iuliana Prodan 2020-04-28  47  	if (finalize_req || engine->retry_support) {
218d1cc1860c45 Corentin LABBE 2018-01-26  48  		enginectx = crypto_tfm_ctx(req->tfm);
6a89f492f8e509 Iuliana Prodan 2020-04-28  49  		if (enginectx->op.prepare_request &&
218d1cc1860c45 Corentin LABBE 2018-01-26  50  		    enginectx->op.unprepare_request) {
218d1cc1860c45 Corentin LABBE 2018-01-26  51  			ret = enginectx->op.unprepare_request(engine, req);
218d1cc1860c45 Corentin LABBE 2018-01-26  52  			if (ret)
218d1cc1860c45 Corentin LABBE 2018-01-26  53  				dev_err(engine->dev, "failed to unprepare request\n");
218d1cc1860c45 Corentin LABBE 2018-01-26  54  		}
218d1cc1860c45 Corentin LABBE 2018-01-26  55  	}
4058cf08945c18 Corentin Labbe 2022-02-21 @56  	lockdep_assert_in_softirq();
218d1cc1860c45 Corentin LABBE 2018-01-26  57  	req->complete(req, err);
218d1cc1860c45 Corentin LABBE 2018-01-26  58  
218d1cc1860c45 Corentin LABBE 2018-01-26  59  	kthread_queue_work(engine->kworker, &engine->pump_requests);
218d1cc1860c45 Corentin LABBE 2018-01-26  60  }
218d1cc1860c45 Corentin LABBE 2018-01-26  61  

:::::: The code at line 56 was first introduced by commit
:::::: 4058cf08945c18a6de193f4118fd05d83d3d4285 crypto: engine - check if BH is disabled during completion

:::::: TO: Corentin Labbe <clabbe@baylibre.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
