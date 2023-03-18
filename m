Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB3B6BFC3D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 20:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCRTG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 15:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRTGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 15:06:55 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DEE1B332
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 12:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679166414; x=1710702414;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/1UEoVuOvvsboY0RO0tSRLaCb+OMWsXgB32jNVQngTk=;
  b=Tjydze7NteNKv1UXrsHo/eqi/wkrf3u4qymjKrZIvfA3NrxxnaSA3C8W
   98hvk+DENOLH/67yFEf2tRaBMtwDOX31CSgd8bEPw8K2bv+6un+7tZ+Yp
   7de89eMDFWftsY7x45dX8XNWGVLLFfnS9sKD7o408piXZox1tfCvfk1n2
   oLo8IbaWshmRsDTEwYXfZc+LaIDntddg1zBxZ3BfJwqbXwmpDb/D9GwiE
   uzxmRO5/Qh4cyhywwLGeZXXc4R2x/QM/8gQqXg5I6ZGScqQO/C48Kt6ip
   dSZS29TPjRBx+SP7qqF4TwybuC4IZQuV7ans9/UrqldqF/esIAVkuFk3M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="337164109"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="337164109"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 12:06:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="713104556"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="713104556"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Mar 2023 12:06:52 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdbtE-000ADy-00;
        Sat, 18 Mar 2023 19:06:52 +0000
Date:   Sun, 19 Mar 2023 03:05:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/spi/spi-mpc52xx-psc.c:195:5: warning: no previous prototype
 for 'mpc52xx_psc_spi_transfer_one_message'
Message-ID: <202303190242.zHzK9uDP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   efbcbb12ee99f750c9f25c873b55ad774871de2a
commit: 145cfc3840e5931a789a8e2e76af841ab4cad44b spi: mpc52xx-psc: Switch to using core message queue
date:   9 months ago
config: powerpc-randconfig-r006-20230319 (https://download.01.org/0day-ci/archive/20230319/202303190242.zHzK9uDP-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=145cfc3840e5931a789a8e2e76af841ab4cad44b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 145cfc3840e5931a789a8e2e76af841ab4cad44b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303190242.zHzK9uDP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-mpc52xx-psc.c:195:5: warning: no previous prototype for 'mpc52xx_psc_spi_transfer_one_message' [-Wmissing-prototypes]
     195 | int mpc52xx_psc_spi_transfer_one_message(struct spi_controller *ctlr,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/mpc52xx_psc_spi_transfer_one_message +195 drivers/spi/spi-mpc52xx-psc.c

   194	
 > 195	int mpc52xx_psc_spi_transfer_one_message(struct spi_controller *ctlr,
   196						 struct spi_message *m)
   197	{
   198		struct spi_device *spi;
   199		struct spi_transfer *t = NULL;
   200		unsigned cs_change;
   201		int status;
   202	
   203		spi = m->spi;
   204		cs_change = 1;
   205		status = 0;
   206		list_for_each_entry (t, &m->transfers, transfer_list) {
   207			if (t->bits_per_word || t->speed_hz) {
   208				status = mpc52xx_psc_spi_transfer_setup(spi, t);
   209				if (status < 0)
   210					break;
   211			}
   212	
   213			if (cs_change)
   214				mpc52xx_psc_spi_activate_cs(spi);
   215			cs_change = t->cs_change;
   216	
   217			status = mpc52xx_psc_spi_transfer_rxtx(spi, t);
   218			if (status)
   219				break;
   220			m->actual_length += t->len;
   221	
   222			spi_transfer_delay_exec(t);
   223	
   224			if (cs_change)
   225				mpc52xx_psc_spi_deactivate_cs(spi);
   226		}
   227	
   228		m->status = status;
   229		if (status || !cs_change)
   230			mpc52xx_psc_spi_deactivate_cs(spi);
   231	
   232		mpc52xx_psc_spi_transfer_setup(spi, NULL);
   233	
   234		spi_finalize_current_message(ctlr);
   235	
   236		return 0;
   237	}
   238	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
