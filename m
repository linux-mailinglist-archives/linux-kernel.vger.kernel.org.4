Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D922702B47
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbjEOLTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjEOLTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:19:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93AA1725
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684149554; x=1715685554;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vzb9Of6YL+Mb+ZRCYAhcJIFkmHeIqAmpZiiEQImVciM=;
  b=XAIx1x17s0UpzaOLOw+bVRrsJggH7/IX86vC8srOY6/+UsAK2J+NmAKx
   ZfWRULBpH3ZCGYZs0rPay+XTjtysYl4QDS3IQtBVyyh7GlXl5RzVYnX+3
   7kiLD1OSr75I+kn6imw+6STW+7PqcOSwDDTXeL6nYGzY2WSqR3vG83l/L
   6wRE8DD+0VPJ0c/J/tARIy1brn4T+M/P6EABpW9olJcgTpBbN18HmUjTo
   Hjq+2SMprMbJT0O+mQdux6C0j9XWfysBXOrX+HXUO7fr0BMBQHRQA92Yo
   Cf0YMYb0Ge30TfolI3gLkKYwwQNS6JlUxwcDa1JaWy+adlMxDLY6/piqG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="379336123"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="379336123"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 04:19:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694981858"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="694981858"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 15 May 2023 04:19:13 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pyWES-0006KI-1X;
        Mon, 15 May 2023 11:19:12 +0000
Date:   Mon, 15 May 2023 19:18:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/spi/spi-mpc52xx-psc.c:195:5: sparse: sparse: symbol
 'mpc52xx_psc_spi_transfer_one_message' was not declared. Should it be
 static?
Message-ID: <202305151908.MNazRAGc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
commit: 145cfc3840e5931a789a8e2e76af841ab4cad44b spi: mpc52xx-psc: Switch to using core message queue
date:   11 months ago
config: powerpc-randconfig-s051-20230515 (https://download.01.org/0day-ci/archive/20230515/202305151908.MNazRAGc-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=145cfc3840e5931a789a8e2e76af841ab4cad44b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 145cfc3840e5931a789a8e2e76af841ab4cad44b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305151908.MNazRAGc-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-mpc52xx-psc.c:195:5: sparse: sparse: symbol 'mpc52xx_psc_spi_transfer_one_message' was not declared. Should it be static?
   drivers/spi/spi-mpc52xx-psc.c:398:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int const [usertype] *regaddr_p @@     got restricted __be32 const [usertype] * @@
   drivers/spi/spi-mpc52xx-psc.c:398:19: sparse:     expected unsigned int const [usertype] *regaddr_p
   drivers/spi/spi-mpc52xx-psc.c:398:19: sparse:     got restricted __be32 const [usertype] *
   drivers/spi/spi-mpc52xx-psc.c:403:59: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 const [usertype] *addr @@     got unsigned int const [usertype] *regaddr_p @@
   drivers/spi/spi-mpc52xx-psc.c:403:59: sparse:     expected restricted __be32 const [usertype] *addr
   drivers/spi/spi-mpc52xx-psc.c:403:59: sparse:     got unsigned int const [usertype] *regaddr_p

vim +/mpc52xx_psc_spi_transfer_one_message +195 drivers/spi/spi-mpc52xx-psc.c

   177	
   178	int mpc52xx_psc_spi_transfer_one_message(struct spi_controller *ctlr,
   179						 struct spi_message *m)
   180	{
   181		struct spi_device *spi;
   182		struct spi_transfer *t = NULL;
   183		unsigned cs_change;
   184		int status;
   185	
   186		spi = m->spi;
   187		cs_change = 1;
   188		status = 0;
   189		list_for_each_entry (t, &m->transfers, transfer_list) {
   190			if (t->bits_per_word || t->speed_hz) {
   191				status = mpc52xx_psc_spi_transfer_setup(spi, t);
   192				if (status < 0)
   193					break;
   194			}
 > 195	
   196			if (cs_change)
   197				mpc52xx_psc_spi_activate_cs(spi);
   198			cs_change = t->cs_change;
   199	
   200			status = mpc52xx_psc_spi_transfer_rxtx(spi, t);
   201			if (status)
   202				break;
   203			m->actual_length += t->len;
   204	
   205			spi_transfer_delay_exec(t);
   206		}
   207	
   208		m->status = status;
   209	
   210		mpc52xx_psc_spi_transfer_setup(spi, NULL);
   211	
   212		spi_finalize_current_message(ctlr);
   213	
   214		return 0;
   215	}
   216	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
