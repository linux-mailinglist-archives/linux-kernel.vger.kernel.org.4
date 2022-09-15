Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F23D5BA196
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 21:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiIOTst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 15:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIOTsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 15:48:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6779A6F253
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 12:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663271325; x=1694807325;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GvBM4vE56s/h3Ixl3i/+pdA4YobjgEyHegkWBAXY8aM=;
  b=FQ49B7Zs7S6nwTAniDoalTTZQ1MIYO4+rcc1fbz5qAGvhVsR4T2Q6cdb
   zdU1iD6gUjiHvK98R0BUO9E6Vdnp6z5nJaeFdNOOj+KwAEQS4J9snfL0L
   vMF1KA9cet5FtBciA60zuT1GUsZNA4KO2GOkyAT2Y9s6I/8ufDahWXIov
   9HaM+P2voDEPrf/ttFe2eIOfnClDJdaDPY4AMHg+E7Wz35gWbXvwyA7Vx
   tTNncP+b9XHCLWOXu2Ev+BMkYrgxHPXUgsDSONRln3Be0kEQdMqmD3zll
   TjD5uMFtawitPm6MjBRAyU4yxxIQu1/k67QI9rZhIhfdO6i1cifuQ6T7R
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="360563488"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="360563488"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 12:48:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="568568178"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Sep 2022 12:48:42 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYuqo-0000w1-0j;
        Thu, 15 Sep 2022 19:48:42 +0000
Date:   Fri, 16 Sep 2022 03:48:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: crypto/crypto_engine.c:56:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202209160355.6tyYIizw-lkp@intel.com>
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

Hi Qing,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3245cb65fd91cd514801bf91f5a3066d562f0ac4
commit: 93a4fa622eb061f75f87f0cf9609ab4e69c67d01 LoongArch: Add STACKTRACE support
date:   5 weeks ago
config: loongarch-randconfig-s043-20220915 (https://download.01.org/0day-ci/archive/20220916/202209160355.6tyYIizw-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash crypto/ drivers/perf/ drivers/soc/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

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
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got int [noderef] __percpu *

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
https://01.org/lkp
