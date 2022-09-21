Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4445DC360
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 20:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiIUSLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 14:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiIUSLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:11:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CFB80516;
        Wed, 21 Sep 2022 11:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663783871; x=1695319871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WckjFb8TNTyStYJTGw886rcvghznTu4Iq8hyPcV6+aA=;
  b=BtU2tGR5gRM/dX86a2L4FZ8t4STOryFNG50H+tqO5UaeYZQXq0hGguyK
   D9fpGkbyxk2T+eaeJHurdaYn2puwCGx3OVjZQpQlwsHffu19LjcPW47A9
   e6Hh1fvBZ1XCmZEiz/aKlGDZu4S4yVF+of2n4kvSO+jNi+DCIWFPW/e8p
   rmItMBa6S54yKajsVoOln7/wrMRf5SPb55uiga/8iU63LMTaAR6RwEPnK
   SlbFMKUP8IOdzjDUyY5OZtffw4FEfyuuhR7Bt9KA17AxbaKtc7ZEg2ksB
   kKHCb8yh4vCG1SjFRzG2wb1ycH1fyHbv2qIaG5cqAg0zHDE3OAWUC1wt/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="300925913"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="300925913"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 11:10:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="652641729"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Sep 2022 11:10:32 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ob4B5-0003pz-2H;
        Wed, 21 Sep 2022 18:10:31 +0000
Date:   Thu, 22 Sep 2022 02:10:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Julien Panis <jpanis@baylibre.com>, william.gray@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     kbuild-all@lists.01.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mranostay@ti.com
Subject: Re: [PATCH v7 3/4] counter: ti-ecap-capture: capture driver support
 for ECAP
Message-ID: <202209220145.SYlF1Xt8-lkp@intel.com>
References: <20220921100627.124085-4-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921100627.124085-4-jpanis@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.0-rc6 next-20220921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Julien-Panis/ECAP-support-on-TI-AM62x-SoC/20220921-180742
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220922/202209220145.SYlF1Xt8-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f8a0bbe39ba2d6018559e92fb0c66b789387b293
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Julien-Panis/ECAP-support-on-TI-AM62x-SoC/20220921-180742
        git checkout f8a0bbe39ba2d6018559e92fb0c66b789387b293
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/counter/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/counter/ti-ecap-capture.c: In function 'ecap_cnt_watch_validate':
   drivers/counter/ti-ecap-capture.c:234:66: error: 'COUNTER_EVENT_CAPTURE' undeclared (first use in this function); did you mean 'COUNTER_EVENT_INDEX'?
     234 |         if ((watch->channel <= ECAP_CEVT_LAST && watch->event == COUNTER_EVENT_CAPTURE) ||
         |                                                                  ^~~~~~~~~~~~~~~~~~~~~
         |                                                                  COUNTER_EVENT_INDEX
   drivers/counter/ti-ecap-capture.c:234:66: note: each undeclared identifier is reported only once for each function it appears in
   drivers/counter/ti-ecap-capture.c: At top level:
>> drivers/counter/ti-ecap-capture.c:253:47: warning: 'enum counter_signal_polarity' declared inside parameter list will not be visible outside of this definition or declaration
     253 |                              size_t idx, enum counter_signal_polarity *pol)
         |                                               ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/counter/ti-ecap-capture.c: In function 'ecap_cnt_pol_read':
   drivers/counter/ti-ecap-capture.c:259:16: error: 'COUNTER_SIGNAL_POLARITY_NEGATIVE' undeclared (first use in this function)
     259 |                COUNTER_SIGNAL_POLARITY_NEGATIVE :
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/counter/ti-ecap-capture.c:260:16: error: 'COUNTER_SIGNAL_POLARITY_POSITIVE' undeclared (first use in this function)
     260 |                COUNTER_SIGNAL_POLARITY_POSITIVE;
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/counter/ti-ecap-capture.c:258:14: error: invalid use of undefined type 'enum counter_signal_polarity'
     258 |         *pol = regmap_test_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(idx)) ?
         |              ^
   drivers/counter/ti-ecap-capture.c: At top level:
   drivers/counter/ti-ecap-capture.c:268:48: warning: 'enum counter_signal_polarity' declared inside parameter list will not be visible outside of this definition or declaration
     268 |                               size_t idx, enum counter_signal_polarity pol)
         |                                                ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/counter/ti-ecap-capture.c:268:72: error: parameter 4 ('pol') has incomplete type
     268 |                               size_t idx, enum counter_signal_polarity pol)
         |                                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/counter/ti-ecap-capture.c:266:12: error: function declaration isn't a prototype [-Werror=strict-prototypes]
     266 | static int ecap_cnt_pol_write(struct counter_device *counter,
         |            ^~~~~~~~~~~~~~~~~~
   drivers/counter/ti-ecap-capture.c: In function 'ecap_cnt_pol_write':
   drivers/counter/ti-ecap-capture.c:276:20: error: 'COUNTER_SIGNAL_POLARITY_NEGATIVE' undeclared (first use in this function)
     276 |         if (pol == COUNTER_SIGNAL_POLARITY_NEGATIVE)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/counter/ti-ecap-capture.c: At top level:
   drivers/counter/ti-ecap-capture.c:375:43: error: array type has incomplete element type 'enum counter_signal_polarity'
     375 | static const enum counter_signal_polarity ecap_cnt_pol_avail[] = {
         |                                           ^~~~~~~~~~~~~~~~~~
   drivers/counter/ti-ecap-capture.c:376:9: error: 'COUNTER_SIGNAL_POLARITY_POSITIVE' undeclared here (not in a function)
     376 |         COUNTER_SIGNAL_POLARITY_POSITIVE,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/counter/ti-ecap-capture.c:377:9: error: 'COUNTER_SIGNAL_POLARITY_NEGATIVE' undeclared here (not in a function)
     377 |         COUNTER_SIGNAL_POLARITY_NEGATIVE,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/counter/ti-ecap-capture.c:380:77: error: expected ')' before '(' token
     380 | static DEFINE_COUNTER_ARRAY_POLARITY(ecap_cnt_pol_array, ecap_cnt_pol_avail, ECAP_NB_CEVT);
         |                                                                             ^
         |                                                                             )
   drivers/counter/ti-ecap-capture.c:383:9: error: implicit declaration of function 'COUNTER_COMP_ARRAY_POLARITY' [-Werror=implicit-function-declaration]
     383 |         COUNTER_COMP_ARRAY_POLARITY(ecap_cnt_pol_read, ecap_cnt_pol_write, ecap_cnt_pol_array),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/counter/ti-ecap-capture.c:383:76: error: 'ecap_cnt_pol_array' undeclared here (not in a function); did you mean 'ecap_cnt_pol_read'?
     383 |         COUNTER_COMP_ARRAY_POLARITY(ecap_cnt_pol_read, ecap_cnt_pol_write, ecap_cnt_pol_array),
         |                                                                            ^~~~~~~~~~~~~~~~~~
         |                                                                            ecap_cnt_pol_read
   drivers/counter/ti-ecap-capture.c:414:52: error: expected ')' before '(' token
     414 | static DEFINE_COUNTER_ARRAY_U64(ecap_cnt_cap_array, ECAP_NB_CEVT);
         |                                                    ^
         |                                                    )
   drivers/counter/ti-ecap-capture.c:417:9: error: implicit declaration of function 'COUNTER_COMP_COUNT_ARRAY_U64'; did you mean 'COUNTER_COMP_COUNT_U64'? [-Werror=implicit-function-declaration]
     417 |         COUNTER_COMP_COUNT_ARRAY_U64("capture", ecap_cnt_cap_read, NULL, ecap_cnt_cap_array),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         COUNTER_COMP_COUNT_U64
   drivers/counter/ti-ecap-capture.c:417:74: error: 'ecap_cnt_cap_array' undeclared here (not in a function); did you mean 'ecap_cnt_cap_read'?
     417 |         COUNTER_COMP_COUNT_ARRAY_U64("capture", ecap_cnt_cap_read, NULL, ecap_cnt_cap_array),
         |                                                                          ^~~~~~~~~~~~~~~~~~
         |                                                                          ecap_cnt_cap_read
   drivers/counter/ti-ecap-capture.c: In function 'ecap_cnt_isr':
   drivers/counter/ti-ecap-capture.c:449:57: error: 'COUNTER_EVENT_CAPTURE' undeclared (first use in this function); did you mean 'COUNTER_EVENT_INDEX'?
     449 |                         counter_push_event(counter_dev, COUNTER_EVENT_CAPTURE, i);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~
         |                                                         COUNTER_EVENT_INDEX
   drivers/counter/ti-ecap-capture.c: At top level:
   drivers/counter/ti-ecap-capture.c:375:43: warning: 'ecap_cnt_pol_avail' defined but not used [-Wunused-variable]
     375 | static const enum counter_signal_polarity ecap_cnt_pol_avail[] = {
         |                                           ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +253 drivers/counter/ti-ecap-capture.c

   250	
   251	static int ecap_cnt_pol_read(struct counter_device *counter,
   252				     struct counter_signal *signal,
 > 253				     size_t idx, enum counter_signal_polarity *pol)
   254	{
   255		struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
   256	
   257		pm_runtime_get_sync(counter->parent);
   258		*pol = regmap_test_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(idx)) ?
   259		       COUNTER_SIGNAL_POLARITY_NEGATIVE :
   260		       COUNTER_SIGNAL_POLARITY_POSITIVE;
   261		pm_runtime_put_sync(counter->parent);
   262	
   263		return 0;
   264	}
   265	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
