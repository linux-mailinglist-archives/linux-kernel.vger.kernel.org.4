Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3862B6D382D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 15:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjDBN7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 09:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBN7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 09:59:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98437BBA9
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 06:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680443945; x=1711979945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NqIIJq9oIIC3liK4kLUTr7uqU3fhNcQZwV7dFB795hw=;
  b=etVFllbjXpCXqPpn7XR7P9ARnEntFQlxH5obwBrcvROXVIuNy2zyoh8N
   bracrHrs5152yKKOMIxM7zGs+TOJj/35MNLIchegerIMQhAphAjVmE8Tk
   CMtsbmdCB/P49RhVp1TUMV3cN8/cEgzBAFS/3kM52XIu6h5bAQjE9OkBy
   Hl7AQDPsFHFDUCb19Et29obPZUkh7URbV/JekL7edOXkSAJKmX1+YAVxr
   guUFdRsohj3A5x426LHmtLPKkCSDOw9pJ/yronLcgFoVsnfjEbvTrUDz0
   i1Xy4Owr1v4+OBTXd1qlkRz5V4/od52jlzU4BxfmEL6k2IqG/n4VihGgY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="322127882"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="322127882"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 06:59:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="750207449"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="750207449"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 Apr 2023 06:59:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piyEX-000NQv-2G;
        Sun, 02 Apr 2023 13:59:01 +0000
Date:   Sun, 2 Apr 2023 21:58:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Angel Alberto Carretero <angelalbertoc.r@gmail.com>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Angel Alberto Carretero <angelalbertoc.r@gmail.com>
Subject: Re: [PATCH] staging: greybus: loopback: fix up checkpath macro do
 while error.
Message-ID: <202304022121.KVyCEi5L-lkp@intel.com>
References: <20230402122550.70682-1-angelalbertoc.r@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230402122550.70682-1-angelalbertoc.r@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Angel-Alberto-Carretero/staging-greybus-loopback-fix-up-checkpath-macro-do-while-error/20230402-202947
patch link:    https://lore.kernel.org/r/20230402122550.70682-1-angelalbertoc.r%40gmail.com
patch subject: [PATCH] staging: greybus: loopback: fix up checkpath macro do while error.
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20230402/202304022121.KVyCEi5L-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dde52ce766c90df88bcff2890c586240c7a971ab
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Angel-Alberto-Carretero/staging-greybus-loopback-fix-up-checkpath-macro-do-while-error/20230402-202947
        git checkout dde52ce766c90df88bcff2890c586240c7a971ab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/staging/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304022121.KVyCEi5L-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/greybus/loopback.c:166:9: error: expected identifier or '(' before 'do'
     166 |         do {            \
         |         ^~
   drivers/staging/greybus/loopback.c:273:1: note: in expansion of macro 'gb_loopback_stats_attrs'
     273 | gb_loopback_stats_attrs(latency);
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/greybus/loopback.c:170:11: error: expected identifier or '(' before 'while'
     170 |         } while (0)
         |           ^~~~~
   drivers/staging/greybus/loopback.c:273:1: note: in expansion of macro 'gb_loopback_stats_attrs'
     273 | gb_loopback_stats_attrs(latency);
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/greybus/loopback.c:166:9: error: expected identifier or '(' before 'do'
     166 |         do {            \
         |         ^~
   drivers/staging/greybus/loopback.c:275:1: note: in expansion of macro 'gb_loopback_stats_attrs'
     275 | gb_loopback_stats_attrs(requests_per_second);
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/greybus/loopback.c:170:11: error: expected identifier or '(' before 'while'
     170 |         } while (0)
         |           ^~~~~
   drivers/staging/greybus/loopback.c:275:1: note: in expansion of macro 'gb_loopback_stats_attrs'
     275 | gb_loopback_stats_attrs(requests_per_second);
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/greybus/loopback.c:166:9: error: expected identifier or '(' before 'do'
     166 |         do {            \
         |         ^~
   drivers/staging/greybus/loopback.c:277:1: note: in expansion of macro 'gb_loopback_stats_attrs'
     277 | gb_loopback_stats_attrs(throughput);
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/greybus/loopback.c:170:11: error: expected identifier or '(' before 'while'
     170 |         } while (0)
         |           ^~~~~
   drivers/staging/greybus/loopback.c:277:1: note: in expansion of macro 'gb_loopback_stats_attrs'
     277 | gb_loopback_stats_attrs(throughput);
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/greybus/loopback.c:166:9: error: expected identifier or '(' before 'do'
     166 |         do {            \
         |         ^~
   drivers/staging/greybus/loopback.c:279:1: note: in expansion of macro 'gb_loopback_stats_attrs'
     279 | gb_loopback_stats_attrs(apbridge_unipro_latency);
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/greybus/loopback.c:170:11: error: expected identifier or '(' before 'while'
     170 |         } while (0)
         |           ^~~~~
   drivers/staging/greybus/loopback.c:279:1: note: in expansion of macro 'gb_loopback_stats_attrs'
     279 | gb_loopback_stats_attrs(apbridge_unipro_latency);
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/greybus/loopback.c:166:9: error: expected identifier or '(' before 'do'
     166 |         do {            \
         |         ^~
   drivers/staging/greybus/loopback.c:281:1: note: in expansion of macro 'gb_loopback_stats_attrs'
     281 | gb_loopback_stats_attrs(gbphy_firmware_latency);
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/greybus/loopback.c:170:11: error: expected identifier or '(' before 'while'
     170 |         } while (0)
         |           ^~~~~
   drivers/staging/greybus/loopback.c:281:1: note: in expansion of macro 'gb_loopback_stats_attrs'
     281 | gb_loopback_stats_attrs(gbphy_firmware_latency);
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/greybus/loopback.c:319:10: error: 'dev_attr_latency_min' undeclared here (not in a function); did you mean 'dev_attr_timeout_min'?
     319 |         &dev_attr_latency_min.attr,
         |          ^~~~~~~~~~~~~~~~~~~~
         |          dev_attr_timeout_min
>> drivers/staging/greybus/loopback.c:320:10: error: 'dev_attr_latency_max' undeclared here (not in a function); did you mean 'dev_attr_timeout_max'?
     320 |         &dev_attr_latency_max.attr,
         |          ^~~~~~~~~~~~~~~~~~~~
         |          dev_attr_timeout_max
>> drivers/staging/greybus/loopback.c:321:10: error: 'dev_attr_latency_avg' undeclared here (not in a function)
     321 |         &dev_attr_latency_avg.attr,
         |          ^~~~~~~~~~~~~~~~~~~~
>> drivers/staging/greybus/loopback.c:322:10: error: 'dev_attr_requests_per_second_min' undeclared here (not in a function)
     322 |         &dev_attr_requests_per_second_min.attr,
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/greybus/loopback.c:323:10: error: 'dev_attr_requests_per_second_max' undeclared here (not in a function)
     323 |         &dev_attr_requests_per_second_max.attr,
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/greybus/loopback.c:324:10: error: 'dev_attr_requests_per_second_avg' undeclared here (not in a function)
     324 |         &dev_attr_requests_per_second_avg.attr,
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/greybus/loopback.c:325:10: error: 'dev_attr_throughput_min' undeclared here (not in a function); did you mean 'dev_attr_timeout_min'?
     325 |         &dev_attr_throughput_min.attr,
         |          ^~~~~~~~~~~~~~~~~~~~~~~
         |          dev_attr_timeout_min
>> drivers/staging/greybus/loopback.c:326:10: error: 'dev_attr_throughput_max' undeclared here (not in a function); did you mean 'dev_attr_timeout_max'?
     326 |         &dev_attr_throughput_max.attr,
         |          ^~~~~~~~~~~~~~~~~~~~~~~
         |          dev_attr_timeout_max
>> drivers/staging/greybus/loopback.c:327:10: error: 'dev_attr_throughput_avg' undeclared here (not in a function)
     327 |         &dev_attr_throughput_avg.attr,
         |          ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/greybus/loopback.c:328:10: error: 'dev_attr_apbridge_unipro_latency_min' undeclared here (not in a function)
     328 |         &dev_attr_apbridge_unipro_latency_min.attr,
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/greybus/loopback.c:329:10: error: 'dev_attr_apbridge_unipro_latency_max' undeclared here (not in a function)
     329 |         &dev_attr_apbridge_unipro_latency_max.attr,
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/greybus/loopback.c:330:10: error: 'dev_attr_apbridge_unipro_latency_avg' undeclared here (not in a function)
     330 |         &dev_attr_apbridge_unipro_latency_avg.attr,
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/greybus/loopback.c:331:10: error: 'dev_attr_gbphy_firmware_latency_min' undeclared here (not in a function)
     331 |         &dev_attr_gbphy_firmware_latency_min.attr,
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/greybus/loopback.c:332:10: error: 'dev_attr_gbphy_firmware_latency_max' undeclared here (not in a function)
     332 |         &dev_attr_gbphy_firmware_latency_max.attr,
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/greybus/loopback.c:333:10: error: 'dev_attr_gbphy_firmware_latency_avg' undeclared here (not in a function)
     333 |         &dev_attr_gbphy_firmware_latency_avg.attr,
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +166 drivers/staging/greybus/loopback.c

   164	
   165	#define gb_loopback_stats_attrs(field)				\
 > 166		do {		\
   167			gb_loopback_ro_stats_attr(field, min, u);		\
   168			gb_loopback_ro_stats_attr(field, max, u);		\
   169			gb_loopback_ro_avg_attr(field);		\
 > 170		} while (0)
   171	
   172	#define gb_loopback_attr(field, type)					\
   173	static ssize_t field##_show(struct device *dev,				\
   174				    struct device_attribute *attr,		\
   175				    char *buf)					\
   176	{									\
   177		struct gb_loopback *gb = dev_get_drvdata(dev);			\
   178		return sprintf(buf, "%" #type "\n", gb->field);			\
   179	}									\
   180	static ssize_t field##_store(struct device *dev,			\
   181				    struct device_attribute *attr,		\
   182				    const char *buf,				\
   183				    size_t len)					\
   184	{									\
   185		int ret;							\
   186		struct gb_loopback *gb = dev_get_drvdata(dev);			\
   187		mutex_lock(&gb->mutex);						\
   188		ret = sscanf(buf, "%"#type, &gb->field);			\
   189		if (ret != 1)							\
   190			len = -EINVAL;						\
   191		else								\
   192			gb_loopback_check_attr(gb, bundle);			\
   193		mutex_unlock(&gb->mutex);					\
   194		return len;							\
   195	}									\
   196	static DEVICE_ATTR_RW(field)
   197	
   198	#define gb_dev_loopback_ro_attr(field, conn)				\
   199	static ssize_t field##_show(struct device *dev,		\
   200				    struct device_attribute *attr,		\
   201				    char *buf)					\
   202	{									\
   203		struct gb_loopback *gb = dev_get_drvdata(dev);			\
   204		return sprintf(buf, "%u\n", gb->field);				\
   205	}									\
   206	static DEVICE_ATTR_RO(field)
   207	
   208	#define gb_dev_loopback_rw_attr(field, type)				\
   209	static ssize_t field##_show(struct device *dev,				\
   210				    struct device_attribute *attr,		\
   211				    char *buf)					\
   212	{									\
   213		struct gb_loopback *gb = dev_get_drvdata(dev);			\
   214		return sprintf(buf, "%" #type "\n", gb->field);			\
   215	}									\
   216	static ssize_t field##_store(struct device *dev,			\
   217				    struct device_attribute *attr,		\
   218				    const char *buf,				\
   219				    size_t len)					\
   220	{									\
   221		int ret;							\
   222		struct gb_loopback *gb = dev_get_drvdata(dev);			\
   223		mutex_lock(&gb->mutex);						\
   224		ret = sscanf(buf, "%"#type, &gb->field);			\
   225		if (ret != 1)							\
   226			len = -EINVAL;						\
   227		else								\
   228			gb_loopback_check_attr(gb);		\
   229		mutex_unlock(&gb->mutex);					\
   230		return len;							\
   231	}									\
   232	static DEVICE_ATTR_RW(field)
   233	
   234	static void gb_loopback_reset_stats(struct gb_loopback *gb);
   235	static void gb_loopback_check_attr(struct gb_loopback *gb)
   236	{
   237		if (gb->us_wait > GB_LOOPBACK_US_WAIT_MAX)
   238			gb->us_wait = GB_LOOPBACK_US_WAIT_MAX;
   239		if (gb->size > gb_dev.size_max)
   240			gb->size = gb_dev.size_max;
   241		gb->requests_timedout = 0;
   242		gb->requests_completed = 0;
   243		gb->iteration_count = 0;
   244		gb->send_count = 0;
   245		gb->error = 0;
   246	
   247		if (kfifo_depth < gb->iteration_max) {
   248			dev_warn(gb->dev,
   249				 "cannot log bytes %u kfifo_depth %u\n",
   250				 gb->iteration_max, kfifo_depth);
   251		}
   252		kfifo_reset_out(&gb->kfifo_lat);
   253	
   254		switch (gb->type) {
   255		case GB_LOOPBACK_TYPE_PING:
   256		case GB_LOOPBACK_TYPE_TRANSFER:
   257		case GB_LOOPBACK_TYPE_SINK:
   258			gb->jiffy_timeout = usecs_to_jiffies(gb->timeout);
   259			if (!gb->jiffy_timeout)
   260				gb->jiffy_timeout = GB_LOOPBACK_TIMEOUT_MIN;
   261			else if (gb->jiffy_timeout > GB_LOOPBACK_TIMEOUT_MAX)
   262				gb->jiffy_timeout = GB_LOOPBACK_TIMEOUT_MAX;
   263			gb_loopback_reset_stats(gb);
   264			wake_up(&gb->wq);
   265			break;
   266		default:
   267			gb->type = 0;
   268			break;
   269		}
   270	}
   271	
   272	/* Time to send and receive one message */
   273	gb_loopback_stats_attrs(latency);
   274	/* Number of requests sent per second on this cport */
   275	gb_loopback_stats_attrs(requests_per_second);
   276	/* Quantity of data sent and received on this cport */
   277	gb_loopback_stats_attrs(throughput);
   278	/* Latency across the UniPro link from APBridge's perspective */
   279	gb_loopback_stats_attrs(apbridge_unipro_latency);
   280	/* Firmware induced overhead in the GPBridge */
 > 281	gb_loopback_stats_attrs(gbphy_firmware_latency);
   282	
   283	/* Number of errors encountered during loop */
   284	gb_loopback_ro_attr(error);
   285	/* Number of requests successfully completed async */
   286	gb_loopback_ro_attr(requests_completed);
   287	/* Number of requests timed out async */
   288	gb_loopback_ro_attr(requests_timedout);
   289	/* Timeout minimum in useconds */
   290	gb_loopback_ro_attr(timeout_min);
   291	/* Timeout minimum in useconds */
   292	gb_loopback_ro_attr(timeout_max);
   293	
   294	/*
   295	 * Type of loopback message to send based on protocol type definitions
   296	 * 0 => Don't send message
   297	 * 2 => Send ping message continuously (message without payload)
   298	 * 3 => Send transfer message continuously (message with payload,
   299	 *					   payload returned in response)
   300	 * 4 => Send a sink message (message with payload, no payload in response)
   301	 */
   302	gb_dev_loopback_rw_attr(type, d);
   303	/* Size of transfer message payload: 0-4096 bytes */
   304	gb_dev_loopback_rw_attr(size, u);
   305	/* Time to wait between two messages: 0-1000 ms */
   306	gb_dev_loopback_rw_attr(us_wait, d);
   307	/* Maximum iterations for a given operation: 1-(2^32-1), 0 implies infinite */
   308	gb_dev_loopback_rw_attr(iteration_max, u);
   309	/* The current index of the for (i = 0; i < iteration_max; i++) loop */
   310	gb_dev_loopback_ro_attr(iteration_count, false);
   311	/* A flag to indicate synchronous or asynchronous operations */
   312	gb_dev_loopback_rw_attr(async, u);
   313	/* Timeout of an individual asynchronous request */
   314	gb_dev_loopback_rw_attr(timeout, u);
   315	/* Maximum number of in-flight operations before back-off */
   316	gb_dev_loopback_rw_attr(outstanding_operations_max, u);
   317	
   318	static struct attribute *loopback_attrs[] = {
 > 319		&dev_attr_latency_min.attr,
 > 320		&dev_attr_latency_max.attr,
 > 321		&dev_attr_latency_avg.attr,
 > 322		&dev_attr_requests_per_second_min.attr,
 > 323		&dev_attr_requests_per_second_max.attr,
 > 324		&dev_attr_requests_per_second_avg.attr,
 > 325		&dev_attr_throughput_min.attr,
 > 326		&dev_attr_throughput_max.attr,
 > 327		&dev_attr_throughput_avg.attr,
 > 328		&dev_attr_apbridge_unipro_latency_min.attr,
 > 329		&dev_attr_apbridge_unipro_latency_max.attr,
 > 330		&dev_attr_apbridge_unipro_latency_avg.attr,
 > 331		&dev_attr_gbphy_firmware_latency_min.attr,
 > 332		&dev_attr_gbphy_firmware_latency_max.attr,
 > 333		&dev_attr_gbphy_firmware_latency_avg.attr,
   334		&dev_attr_type.attr,
   335		&dev_attr_size.attr,
   336		&dev_attr_us_wait.attr,
   337		&dev_attr_iteration_count.attr,
   338		&dev_attr_iteration_max.attr,
   339		&dev_attr_async.attr,
   340		&dev_attr_error.attr,
   341		&dev_attr_requests_completed.attr,
   342		&dev_attr_requests_timedout.attr,
   343		&dev_attr_timeout.attr,
   344		&dev_attr_outstanding_operations_max.attr,
   345		&dev_attr_timeout_min.attr,
   346		&dev_attr_timeout_max.attr,
   347		NULL,
   348	};
   349	ATTRIBUTE_GROUPS(loopback);
   350	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
