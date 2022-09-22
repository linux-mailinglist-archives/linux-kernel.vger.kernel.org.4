Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95575E5815
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiIVBeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiIVBd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:33:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4F39F196;
        Wed, 21 Sep 2022 18:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663810437; x=1695346437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FrDh1OS4EVJBcx7SCQU7WUXcIVjBz/R2zKglWq3IDts=;
  b=S1tgTsZ8lQfj8r7nElw1oUuLQOPETOAaJi0tphzQYSukSspjxC8/DPTN
   xJH2NMxUIUI0iE6Izg0SC2ex31M4/VI3eRoYnnOs0e1AH7Iwns0qR53nJ
   wOI7moMskNsVRP7pXtMlZN8vMDxI57HVfudCW7O2u7SWyvYpq5TEPpAJ5
   8CemUiiLHj15caeZRNE/w70YAWL7xjxr8zXiihcrDf2jumnJddqPks4NN
   /bVVd77kPmGKLuOuhjZMWOa3V0U6X3ZJaVb2lUStsoqBMAXW4D5aMVseh
   c+DWf6p7jrL4d70BfeNzZ3M7Y9EWAF5np6cM1icLE4zL5ek77WYzZTFYq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="301012759"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="301012759"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 18:33:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="650317244"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Sep 2022 18:33:53 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obB69-00049n-0w;
        Thu, 22 Sep 2022 01:33:53 +0000
Date:   Thu, 22 Sep 2022 09:33:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Julien Panis <jpanis@baylibre.com>, william.gray@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     kbuild-all@lists.01.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mranostay@ti.com
Subject: Re: [PATCH v7 3/4] counter: ti-ecap-capture: capture driver support
 for ECAP
Message-ID: <202209220938.I4JYSpmy-lkp@intel.com>
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

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.0-rc6 next-20220921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Julien-Panis/ECAP-support-on-TI-AM62x-SoC/20220921-180742
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220922/202209220938.I4JYSpmy-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/counter/ti-ecap-capture.c: In function 'ecap_cnt_watch_validate':
>> drivers/counter/ti-ecap-capture.c:234:66: error: 'COUNTER_EVENT_CAPTURE' undeclared (first use in this function); did you mean 'COUNTER_EVENT_INDEX'?
     234 |         if ((watch->channel <= ECAP_CEVT_LAST && watch->event == COUNTER_EVENT_CAPTURE) ||
         |                                                                  ^~~~~~~~~~~~~~~~~~~~~
         |                                                                  COUNTER_EVENT_INDEX
   drivers/counter/ti-ecap-capture.c:234:66: note: each undeclared identifier is reported only once for each function it appears in
   drivers/counter/ti-ecap-capture.c: At top level:
   drivers/counter/ti-ecap-capture.c:253:47: warning: 'enum counter_signal_polarity' declared inside parameter list will not be visible outside of this definition or declaration
     253 |                              size_t idx, enum counter_signal_polarity *pol)
         |                                               ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/counter/ti-ecap-capture.c: In function 'ecap_cnt_pol_read':
>> drivers/counter/ti-ecap-capture.c:259:16: error: 'COUNTER_SIGNAL_POLARITY_NEGATIVE' undeclared (first use in this function)
     259 |                COUNTER_SIGNAL_POLARITY_NEGATIVE :
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/counter/ti-ecap-capture.c:260:16: error: 'COUNTER_SIGNAL_POLARITY_POSITIVE' undeclared (first use in this function)
     260 |                COUNTER_SIGNAL_POLARITY_POSITIVE;
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/counter/ti-ecap-capture.c:258:14: error: invalid use of undefined type 'enum counter_signal_polarity'
     258 |         *pol = regmap_test_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(idx)) ?
         |              ^
   drivers/counter/ti-ecap-capture.c: At top level:
   drivers/counter/ti-ecap-capture.c:268:48: warning: 'enum counter_signal_polarity' declared inside parameter list will not be visible outside of this definition or declaration
     268 |                               size_t idx, enum counter_signal_polarity pol)
         |                                                ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/counter/ti-ecap-capture.c:268:72: error: parameter 4 ('pol') has incomplete type
     268 |                               size_t idx, enum counter_signal_polarity pol)
         |                                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
>> drivers/counter/ti-ecap-capture.c:266:12: error: function declaration isn't a prototype [-Werror=strict-prototypes]
     266 | static int ecap_cnt_pol_write(struct counter_device *counter,
         |            ^~~~~~~~~~~~~~~~~~
   drivers/counter/ti-ecap-capture.c: In function 'ecap_cnt_pol_write':
   drivers/counter/ti-ecap-capture.c:276:20: error: 'COUNTER_SIGNAL_POLARITY_NEGATIVE' undeclared (first use in this function)
     276 |         if (pol == COUNTER_SIGNAL_POLARITY_NEGATIVE)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/counter/ti-ecap-capture.c: At top level:
>> drivers/counter/ti-ecap-capture.c:375:43: error: array type has incomplete element type 'enum counter_signal_polarity'
     375 | static const enum counter_signal_polarity ecap_cnt_pol_avail[] = {
         |                                           ^~~~~~~~~~~~~~~~~~
>> drivers/counter/ti-ecap-capture.c:376:9: error: 'COUNTER_SIGNAL_POLARITY_POSITIVE' undeclared here (not in a function)
     376 |         COUNTER_SIGNAL_POLARITY_POSITIVE,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/counter/ti-ecap-capture.c:377:9: error: 'COUNTER_SIGNAL_POLARITY_NEGATIVE' undeclared here (not in a function)
     377 |         COUNTER_SIGNAL_POLARITY_NEGATIVE,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/counter/ti-ecap-capture.c:380:77: error: expected ')' before '(' token
     380 | static DEFINE_COUNTER_ARRAY_POLARITY(ecap_cnt_pol_array, ecap_cnt_pol_avail, ECAP_NB_CEVT);
         |                                                                             ^
         |                                                                             )
>> drivers/counter/ti-ecap-capture.c:383:9: error: implicit declaration of function 'COUNTER_COMP_ARRAY_POLARITY' [-Werror=implicit-function-declaration]
     383 |         COUNTER_COMP_ARRAY_POLARITY(ecap_cnt_pol_read, ecap_cnt_pol_write, ecap_cnt_pol_array),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/counter/ti-ecap-capture.c:383:76: error: 'ecap_cnt_pol_array' undeclared here (not in a function); did you mean 'ecap_cnt_pol_read'?
     383 |         COUNTER_COMP_ARRAY_POLARITY(ecap_cnt_pol_read, ecap_cnt_pol_write, ecap_cnt_pol_array),
         |                                                                            ^~~~~~~~~~~~~~~~~~
         |                                                                            ecap_cnt_pol_read
   drivers/counter/ti-ecap-capture.c:414:52: error: expected ')' before '(' token
     414 | static DEFINE_COUNTER_ARRAY_U64(ecap_cnt_cap_array, ECAP_NB_CEVT);
         |                                                    ^
         |                                                    )
>> drivers/counter/ti-ecap-capture.c:417:9: error: implicit declaration of function 'COUNTER_COMP_COUNT_ARRAY_U64'; did you mean 'COUNTER_COMP_COUNT_U64'? [-Werror=implicit-function-declaration]
     417 |         COUNTER_COMP_COUNT_ARRAY_U64("capture", ecap_cnt_cap_read, NULL, ecap_cnt_cap_array),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         COUNTER_COMP_COUNT_U64
>> drivers/counter/ti-ecap-capture.c:417:74: error: 'ecap_cnt_cap_array' undeclared here (not in a function); did you mean 'ecap_cnt_cap_read'?
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


vim +234 drivers/counter/ti-ecap-capture.c

   230	
   231	static int ecap_cnt_watch_validate(struct counter_device *counter,
   232					   const struct counter_watch *watch)
   233	{
 > 234		if ((watch->channel <= ECAP_CEVT_LAST && watch->event == COUNTER_EVENT_CAPTURE) ||
   235		    (watch->channel == ECAP_CNTOVF && watch->event == COUNTER_EVENT_OVERFLOW))
   236			return 0;
   237	
   238		return -EINVAL;
   239	}
   240	
   241	static int ecap_cnt_clk_get_freq(struct counter_device *counter,
   242					 struct counter_signal *signal, u64 *freq)
   243	{
   244		struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
   245	
   246		*freq = clk_get_rate(ecap_dev->clk);
   247	
   248		return 0;
   249	}
   250	
   251	static int ecap_cnt_pol_read(struct counter_device *counter,
   252				     struct counter_signal *signal,
   253				     size_t idx, enum counter_signal_polarity *pol)
   254	{
   255		struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
   256	
   257		pm_runtime_get_sync(counter->parent);
 > 258		*pol = regmap_test_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(idx)) ?
 > 259		       COUNTER_SIGNAL_POLARITY_NEGATIVE :
 > 260		       COUNTER_SIGNAL_POLARITY_POSITIVE;
   261		pm_runtime_put_sync(counter->parent);
   262	
   263		return 0;
   264	}
   265	
 > 266	static int ecap_cnt_pol_write(struct counter_device *counter,
   267				      struct counter_signal *signal,
 > 268				      size_t idx, enum counter_signal_polarity pol)
   269	{
   270		struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
   271	
   272		if (ecap_dev->enabled)
   273			return -EBUSY;
   274	
   275		pm_runtime_get_sync(counter->parent);
   276		if (pol == COUNTER_SIGNAL_POLARITY_NEGATIVE)
   277			regmap_set_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(idx));
   278		else
   279			regmap_clear_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(idx));
   280		pm_runtime_put_sync(counter->parent);
   281	
   282		return 0;
   283	}
   284	
   285	static inline int ecap_cnt_cap_read(struct counter_device *counter,
   286					    struct counter_count *count,
   287					    size_t idx, u64 *cap)
   288	{
   289		return ecap_cnt_count_get_val(counter, ECAP_CAP_REG(idx), cap);
   290	}
   291	
   292	static int ecap_cnt_nb_ovf_read(struct counter_device *counter,
   293					struct counter_count *count, u64 *val)
   294	{
   295		struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
   296	
   297		*val = atomic_read(&ecap_dev->nb_ovf);
   298	
   299		return 0;
   300	}
   301	
   302	static int ecap_cnt_nb_ovf_write(struct counter_device *counter,
   303					 struct counter_count *count, u64 val)
   304	{
   305		struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
   306	
   307		if (ecap_dev->enabled)
   308			return -EBUSY;
   309		if (val > 0)
   310			return -EINVAL;
   311	
   312		atomic_set(&ecap_dev->nb_ovf, val);
   313	
   314		return 0;
   315	}
   316	
   317	static int ecap_cnt_ceiling_read(struct counter_device *counter,
   318					 struct counter_count *count, u64 *val)
   319	{
   320		*val = U32_MAX;
   321	
   322		return 0;
   323	}
   324	
   325	static int ecap_cnt_enable_read(struct counter_device *counter,
   326					struct counter_count *count, u8 *enable)
   327	{
   328		struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
   329	
   330		*enable = ecap_dev->enabled;
   331	
   332		return 0;
   333	}
   334	
   335	static int ecap_cnt_enable_write(struct counter_device *counter,
   336					 struct counter_count *count, u8 enable)
   337	{
   338		struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
   339	
   340		if (enable == ecap_dev->enabled)
   341			return 0;
   342		if (enable)
   343			ecap_cnt_capture_enable(counter);
   344		else
   345			ecap_cnt_capture_disable(counter);
   346		ecap_dev->enabled = enable;
   347	
   348		return 0;
   349	}
   350	
   351	static const struct counter_ops ecap_cnt_ops = {
   352		.count_read = ecap_cnt_count_read,
   353		.count_write = ecap_cnt_count_write,
   354		.function_read = ecap_cnt_function_read,
   355		.action_read = ecap_cnt_action_read,
   356		.watch_validate = ecap_cnt_watch_validate,
   357	};
   358	
   359	static const enum counter_function ecap_cnt_functions[] = {
   360		COUNTER_FUNCTION_INCREASE,
   361	};
   362	
   363	static const enum counter_synapse_action ecap_cnt_clock_actions[] = {
   364		COUNTER_SYNAPSE_ACTION_RISING_EDGE,
   365	};
   366	
   367	static const enum counter_synapse_action ecap_cnt_input_actions[] = {
   368		COUNTER_SYNAPSE_ACTION_NONE,
   369	};
   370	
   371	static struct counter_comp ecap_cnt_clock_ext[] = {
   372		COUNTER_COMP_SIGNAL_U64("frequency", ecap_cnt_clk_get_freq, NULL),
   373	};
   374	
 > 375	static const enum counter_signal_polarity ecap_cnt_pol_avail[] = {
 > 376		COUNTER_SIGNAL_POLARITY_POSITIVE,
 > 377		COUNTER_SIGNAL_POLARITY_NEGATIVE,
   378	};
   379	
 > 380	static DEFINE_COUNTER_ARRAY_POLARITY(ecap_cnt_pol_array, ecap_cnt_pol_avail, ECAP_NB_CEVT);
   381	
   382	static struct counter_comp ecap_cnt_signal_ext[] = {
 > 383		COUNTER_COMP_ARRAY_POLARITY(ecap_cnt_pol_read, ecap_cnt_pol_write, ecap_cnt_pol_array),
   384	};
   385	
   386	static struct counter_signal ecap_cnt_signals[] = {
   387		{
   388			.id = ECAP_CLOCK_SIG,
   389			.name = "Clock Signal",
   390			.ext = ecap_cnt_clock_ext,
   391			.num_ext = ARRAY_SIZE(ecap_cnt_clock_ext),
   392		},
   393		{
   394			.id = ECAP_INPUT_SIG,
   395			.name = "Input Signal",
   396			.ext = ecap_cnt_signal_ext,
   397			.num_ext = ARRAY_SIZE(ecap_cnt_signal_ext),
   398		},
   399	};
   400	
   401	static struct counter_synapse ecap_cnt_synapses[] = {
   402		{
   403			.actions_list = ecap_cnt_clock_actions,
   404			.num_actions = ARRAY_SIZE(ecap_cnt_clock_actions),
   405			.signal = &ecap_cnt_signals[ECAP_CLOCK_SIG],
   406		},
   407		{
   408			.actions_list = ecap_cnt_input_actions,
   409			.num_actions = ARRAY_SIZE(ecap_cnt_input_actions),
   410			.signal = &ecap_cnt_signals[ECAP_INPUT_SIG],
   411		},
   412	};
   413	
   414	static DEFINE_COUNTER_ARRAY_U64(ecap_cnt_cap_array, ECAP_NB_CEVT);
   415	
   416	static struct counter_comp ecap_cnt_count_ext[] = {
 > 417		COUNTER_COMP_COUNT_ARRAY_U64("capture", ecap_cnt_cap_read, NULL, ecap_cnt_cap_array),
   418		COUNTER_COMP_COUNT_U64("num_overflows", ecap_cnt_nb_ovf_read, ecap_cnt_nb_ovf_write),
   419		COUNTER_COMP_CEILING(ecap_cnt_ceiling_read, NULL),
   420		COUNTER_COMP_ENABLE(ecap_cnt_enable_read, ecap_cnt_enable_write),
   421	};
   422	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
