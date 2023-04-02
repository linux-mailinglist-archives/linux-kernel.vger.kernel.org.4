Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389306D387D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 16:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjDBOjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 10:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjDBOjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 10:39:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3464A5FFF
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 07:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680446351; x=1711982351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XZ4Dgr04elk8vjhUXG9FRpfmC8HfP3p+y81tEZF+PLA=;
  b=WGHuKBc9XUzthy+r+N3iNHvuQOc2M4JOxjPRccbgVe55ZS7jjkwU0hIh
   8IfCuYQVToJp2d+3dp/WYIcJH7I0HdUoR9lhlAHgLLr90Hg/kMeoaW5fY
   kyqT2qNxzdwY8p9IaRCjCJOvYTi5K48NLILasuwzNtK108otM7M+xiE5L
   aTo6NljOaPvntQykHYPi+rXUoEyNb81yX0XwQE5sGR1pCrg7hzwL5wLth
   BO/dSFBdjI/5GiElauFL//gb3q+2xm4+W0tOdTPmS+gv1498KyDZB4UjD
   YpnmZ/BtO+R4xC4zFJCMTKjfkSohnaBpOiTHmA2K+qSnDk+/UAkQbi9BR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="325735840"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="325735840"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 07:39:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="679177071"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="679177071"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 02 Apr 2023 07:39:06 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piyrJ-000NS5-2W;
        Sun, 02 Apr 2023 14:39:05 +0000
Date:   Sun, 2 Apr 2023 22:38:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Angel Alberto Carretero <angelalbertoc.r@gmail.com>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Angel Alberto Carretero <angelalbertoc.r@gmail.com>
Subject: Re: [PATCH] staging: greybus: loopback: fix up checkpath macro do
 while error.
Message-ID: <202304022211.ecILQO4f-lkp@intel.com>
References: <20230402122550.70682-1-angelalbertoc.r@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230402122550.70682-1-angelalbertoc.r@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20230402/202304022211.ecILQO4f-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dde52ce766c90df88bcff2890c586240c7a971ab
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Angel-Alberto-Carretero/staging-greybus-loopback-fix-up-checkpath-macro-do-while-error/20230402-202947
        git checkout dde52ce766c90df88bcff2890c586240c7a971ab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/staging/greybus/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304022211.ecILQO4f-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/greybus/loopback.c:273:1: error: expected identifier or '('
   gb_loopback_stats_attrs(latency);
   ^
   drivers/staging/greybus/loopback.c:166:2: note: expanded from macro 'gb_loopback_stats_attrs'
           do {            \
           ^
>> drivers/staging/greybus/loopback.c:273:1: error: expected identifier or '('
   drivers/staging/greybus/loopback.c:170:4: note: expanded from macro 'gb_loopback_stats_attrs'
           } while (0)
             ^
   drivers/staging/greybus/loopback.c:275:1: error: expected identifier or '('
   gb_loopback_stats_attrs(requests_per_second);
   ^
   drivers/staging/greybus/loopback.c:166:2: note: expanded from macro 'gb_loopback_stats_attrs'
           do {            \
           ^
   drivers/staging/greybus/loopback.c:275:1: error: expected identifier or '('
   drivers/staging/greybus/loopback.c:170:4: note: expanded from macro 'gb_loopback_stats_attrs'
           } while (0)
             ^
   drivers/staging/greybus/loopback.c:277:1: error: expected identifier or '('
   gb_loopback_stats_attrs(throughput);
   ^
   drivers/staging/greybus/loopback.c:166:2: note: expanded from macro 'gb_loopback_stats_attrs'
           do {            \
           ^
   drivers/staging/greybus/loopback.c:277:1: error: expected identifier or '('
   drivers/staging/greybus/loopback.c:170:4: note: expanded from macro 'gb_loopback_stats_attrs'
           } while (0)
             ^
   drivers/staging/greybus/loopback.c:279:1: error: expected identifier or '('
   gb_loopback_stats_attrs(apbridge_unipro_latency);
   ^
   drivers/staging/greybus/loopback.c:166:2: note: expanded from macro 'gb_loopback_stats_attrs'
           do {            \
           ^
   drivers/staging/greybus/loopback.c:279:1: error: expected identifier or '('
   drivers/staging/greybus/loopback.c:170:4: note: expanded from macro 'gb_loopback_stats_attrs'
           } while (0)
             ^
   drivers/staging/greybus/loopback.c:281:1: error: expected identifier or '('
   gb_loopback_stats_attrs(gbphy_firmware_latency);
   ^
   drivers/staging/greybus/loopback.c:166:2: note: expanded from macro 'gb_loopback_stats_attrs'
           do {            \
           ^
   drivers/staging/greybus/loopback.c:281:1: error: expected identifier or '('
   drivers/staging/greybus/loopback.c:170:4: note: expanded from macro 'gb_loopback_stats_attrs'
           } while (0)
             ^
>> drivers/staging/greybus/loopback.c:319:3: error: use of undeclared identifier 'dev_attr_latency_min'; did you mean 'dev_attr_timeout_min'?
           &dev_attr_latency_min.attr,
            ^~~~~~~~~~~~~~~~~~~~
            dev_attr_timeout_min
   drivers/staging/greybus/loopback.c:290:1: note: 'dev_attr_timeout_min' declared here
   gb_loopback_ro_attr(timeout_min);
   ^
   drivers/staging/greybus/loopback.c:130:8: note: expanded from macro 'gb_loopback_ro_attr'
   static DEVICE_ATTR_RO(field)
          ^
   include/linux/device.h:136:26: note: expanded from macro 'DEVICE_ATTR_RO'
           struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
                                   ^
   <scratch space>:164:1: note: expanded from here
   dev_attr_timeout_min
   ^
>> drivers/staging/greybus/loopback.c:320:3: error: use of undeclared identifier 'dev_attr_latency_max'; did you mean 'dev_attr_timeout_max'?
           &dev_attr_latency_max.attr,
            ^~~~~~~~~~~~~~~~~~~~
            dev_attr_timeout_max
   drivers/staging/greybus/loopback.c:292:1: note: 'dev_attr_timeout_max' declared here
   gb_loopback_ro_attr(timeout_max);
   ^
   drivers/staging/greybus/loopback.c:130:8: note: expanded from macro 'gb_loopback_ro_attr'
   static DEVICE_ATTR_RO(field)
          ^
   include/linux/device.h:136:26: note: expanded from macro 'DEVICE_ATTR_RO'
           struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
                                   ^
   <scratch space>:168:1: note: expanded from here
   dev_attr_timeout_max
   ^
>> drivers/staging/greybus/loopback.c:321:3: error: use of undeclared identifier 'dev_attr_latency_avg'
           &dev_attr_latency_avg.attr,
            ^
>> drivers/staging/greybus/loopback.c:322:3: error: use of undeclared identifier 'dev_attr_requests_per_second_min'
           &dev_attr_requests_per_second_min.attr,
            ^
>> drivers/staging/greybus/loopback.c:323:3: error: use of undeclared identifier 'dev_attr_requests_per_second_max'
           &dev_attr_requests_per_second_max.attr,
            ^
>> drivers/staging/greybus/loopback.c:324:3: error: use of undeclared identifier 'dev_attr_requests_per_second_avg'
           &dev_attr_requests_per_second_avg.attr,
            ^
>> drivers/staging/greybus/loopback.c:325:3: error: use of undeclared identifier 'dev_attr_throughput_min'; did you mean 'dev_attr_timeout_min'?
           &dev_attr_throughput_min.attr,
            ^~~~~~~~~~~~~~~~~~~~~~~
            dev_attr_timeout_min
   drivers/staging/greybus/loopback.c:290:1: note: 'dev_attr_timeout_min' declared here
   gb_loopback_ro_attr(timeout_min);
   ^
   drivers/staging/greybus/loopback.c:130:8: note: expanded from macro 'gb_loopback_ro_attr'
   static DEVICE_ATTR_RO(field)
          ^
   include/linux/device.h:136:26: note: expanded from macro 'DEVICE_ATTR_RO'
           struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
                                   ^
   <scratch space>:164:1: note: expanded from here
   dev_attr_timeout_min
   ^
>> drivers/staging/greybus/loopback.c:326:3: error: use of undeclared identifier 'dev_attr_throughput_max'; did you mean 'dev_attr_timeout_max'?
           &dev_attr_throughput_max.attr,
            ^~~~~~~~~~~~~~~~~~~~~~~
            dev_attr_timeout_max
   drivers/staging/greybus/loopback.c:292:1: note: 'dev_attr_timeout_max' declared here
   gb_loopback_ro_attr(timeout_max);
   ^
   drivers/staging/greybus/loopback.c:130:8: note: expanded from macro 'gb_loopback_ro_attr'
   static DEVICE_ATTR_RO(field)
          ^
   include/linux/device.h:136:26: note: expanded from macro 'DEVICE_ATTR_RO'
           struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
                                   ^
   <scratch space>:168:1: note: expanded from here
   dev_attr_timeout_max
   ^
>> drivers/staging/greybus/loopback.c:327:3: error: use of undeclared identifier 'dev_attr_throughput_avg'
           &dev_attr_throughput_avg.attr,
            ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.


vim +273 drivers/staging/greybus/loopback.c

355a7058153e04 Alexandre Bailon        2015-03-31  120  
355a7058153e04 Alexandre Bailon        2015-03-31  121  /* interface sysfs attributes */
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  122  #define gb_loopback_ro_attr(field)				\
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  123  static ssize_t field##_show(struct device *dev,			\
355a7058153e04 Alexandre Bailon        2015-03-31  124  			    struct device_attribute *attr,		\
355a7058153e04 Alexandre Bailon        2015-03-31  125  			    char *buf)					\
355a7058153e04 Alexandre Bailon        2015-03-31  126  {									\
079fa32ba53a20 Axel Haslam             2015-12-11  127  	struct gb_loopback *gb = dev_get_drvdata(dev);			\
19c2a443c9efc8 Alex Elder              2015-08-03  128  	return sprintf(buf, "%u\n", gb->field);			\
f06272b283e159 Bryan O'Donoghue        2015-08-17  129  }									\
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03 @130  static DEVICE_ATTR_RO(field)
355a7058153e04 Alexandre Bailon        2015-03-31  131  
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  132  #define gb_loopback_ro_stats_attr(name, field, type)		\
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  133  static ssize_t name##_##field##_show(struct device *dev,	\
355a7058153e04 Alexandre Bailon        2015-03-31  134  			    struct device_attribute *attr,		\
355a7058153e04 Alexandre Bailon        2015-03-31  135  			    char *buf)					\
355a7058153e04 Alexandre Bailon        2015-03-31  136  {									\
079fa32ba53a20 Axel Haslam             2015-12-11  137  	struct gb_loopback *gb = dev_get_drvdata(dev);			\
3b75d8bd3be49f Till Varoquaux          2020-05-25  138  	/* Report 0 for min and max if no transfer succeeded */		\
1dc8d3d7c568d9 Alexandre Bailon        2016-03-11  139  	if (!gb->requests_completed)					\
1dc8d3d7c568d9 Alexandre Bailon        2016-03-11  140  		return sprintf(buf, "0\n");				\
355a7058153e04 Alexandre Bailon        2015-03-31  141  	return sprintf(buf, "%" #type "\n", gb->name.field);		\
355a7058153e04 Alexandre Bailon        2015-03-31  142  }									\
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  143  static DEVICE_ATTR_RO(name##_##field)
355a7058153e04 Alexandre Bailon        2015-03-31  144  
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  145  #define gb_loopback_ro_avg_attr(name)			\
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  146  static ssize_t name##_avg_show(struct device *dev,		\
7a135a965c62f7 Alex Elder              2015-08-03  147  			    struct device_attribute *attr,		\
7a135a965c62f7 Alex Elder              2015-08-03  148  			    char *buf)					\
7a135a965c62f7 Alex Elder              2015-08-03  149  {									\
f06272b283e159 Bryan O'Donoghue        2015-08-17  150  	struct gb_loopback_stats *stats;				\
f06272b283e159 Bryan O'Donoghue        2015-08-17  151  	struct gb_loopback *gb;						\
fb37f137b78f18 Alexandre Bailon        2016-02-25  152  	u64 avg, rem;							\
fb37f137b78f18 Alexandre Bailon        2016-02-25  153  	u32 count;							\
079fa32ba53a20 Axel Haslam             2015-12-11  154  	gb = dev_get_drvdata(dev);			\
f06272b283e159 Bryan O'Donoghue        2015-08-17  155  	stats = &gb->name;					\
f06272b283e159 Bryan O'Donoghue        2015-08-17  156  	count = stats->count ? stats->count : 1;			\
58a527afff2b27 Alexandre Bailon        2016-03-08  157  	avg = stats->sum + count / 2000000; /* round closest */		\
f06272b283e159 Bryan O'Donoghue        2015-08-17  158  	rem = do_div(avg, count);					\
89ec14ceaedf88 Alexandre Bailon        2016-03-08  159  	rem *= 1000000;							\
89ec14ceaedf88 Alexandre Bailon        2016-03-08  160  	do_div(rem, count);						\
fb37f137b78f18 Alexandre Bailon        2016-02-25  161  	return sprintf(buf, "%llu.%06u\n", avg, (u32)rem);		\
7a135a965c62f7 Alex Elder              2015-08-03  162  }									\
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  163  static DEVICE_ATTR_RO(name##_avg)
7a135a965c62f7 Alex Elder              2015-08-03  164  
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  165  #define gb_loopback_stats_attrs(field)				\
dde52ce766c90d Angel Alberto Carretero 2023-04-02 @166  	do {		\
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  167  		gb_loopback_ro_stats_attr(field, min, u);		\
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  168  		gb_loopback_ro_stats_attr(field, max, u);		\
dde52ce766c90d Angel Alberto Carretero 2023-04-02  169  		gb_loopback_ro_avg_attr(field);		\
dde52ce766c90d Angel Alberto Carretero 2023-04-02  170  	} while (0)
355a7058153e04 Alexandre Bailon        2015-03-31  171  
355a7058153e04 Alexandre Bailon        2015-03-31  172  #define gb_loopback_attr(field, type)					\
355a7058153e04 Alexandre Bailon        2015-03-31  173  static ssize_t field##_show(struct device *dev,				\
355a7058153e04 Alexandre Bailon        2015-03-31  174  			    struct device_attribute *attr,		\
355a7058153e04 Alexandre Bailon        2015-03-31  175  			    char *buf)					\
355a7058153e04 Alexandre Bailon        2015-03-31  176  {									\
079fa32ba53a20 Axel Haslam             2015-12-11  177  	struct gb_loopback *gb = dev_get_drvdata(dev);			\
355a7058153e04 Alexandre Bailon        2015-03-31  178  	return sprintf(buf, "%" #type "\n", gb->field);			\
355a7058153e04 Alexandre Bailon        2015-03-31  179  }									\
355a7058153e04 Alexandre Bailon        2015-03-31  180  static ssize_t field##_store(struct device *dev,			\
355a7058153e04 Alexandre Bailon        2015-03-31  181  			    struct device_attribute *attr,		\
355a7058153e04 Alexandre Bailon        2015-03-31  182  			    const char *buf,				\
355a7058153e04 Alexandre Bailon        2015-03-31  183  			    size_t len)					\
355a7058153e04 Alexandre Bailon        2015-03-31  184  {									\
355a7058153e04 Alexandre Bailon        2015-03-31  185  	int ret;							\
079fa32ba53a20 Axel Haslam             2015-12-11  186  	struct gb_loopback *gb = dev_get_drvdata(dev);			\
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  187  	mutex_lock(&gb->mutex);						\
355a7058153e04 Alexandre Bailon        2015-03-31  188  	ret = sscanf(buf, "%"#type, &gb->field);			\
355a7058153e04 Alexandre Bailon        2015-03-31  189  	if (ret != 1)							\
85d678c0bee883 Bryan O'Donoghue        2015-07-28  190  		len = -EINVAL;						\
85d678c0bee883 Bryan O'Donoghue        2015-07-28  191  	else								\
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  192  		gb_loopback_check_attr(gb, bundle);			\
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  193  	mutex_unlock(&gb->mutex);					\
355a7058153e04 Alexandre Bailon        2015-03-31  194  	return len;							\
355a7058153e04 Alexandre Bailon        2015-03-31  195  }									\
355a7058153e04 Alexandre Bailon        2015-03-31  196  static DEVICE_ATTR_RW(field)
355a7058153e04 Alexandre Bailon        2015-03-31  197  
f06272b283e159 Bryan O'Donoghue        2015-08-17  198  #define gb_dev_loopback_ro_attr(field, conn)				\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  199  static ssize_t field##_show(struct device *dev,		\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  200  			    struct device_attribute *attr,		\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  201  			    char *buf)					\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  202  {									\
079fa32ba53a20 Axel Haslam             2015-12-11  203  	struct gb_loopback *gb = dev_get_drvdata(dev);			\
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  204  	return sprintf(buf, "%u\n", gb->field);				\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  205  }									\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  206  static DEVICE_ATTR_RO(field)
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  207  
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  208  #define gb_dev_loopback_rw_attr(field, type)				\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  209  static ssize_t field##_show(struct device *dev,				\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  210  			    struct device_attribute *attr,		\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  211  			    char *buf)					\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  212  {									\
079fa32ba53a20 Axel Haslam             2015-12-11  213  	struct gb_loopback *gb = dev_get_drvdata(dev);			\
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  214  	return sprintf(buf, "%" #type "\n", gb->field);			\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  215  }									\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  216  static ssize_t field##_store(struct device *dev,			\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  217  			    struct device_attribute *attr,		\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  218  			    const char *buf,				\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  219  			    size_t len)					\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  220  {									\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  221  	int ret;							\
079fa32ba53a20 Axel Haslam             2015-12-11  222  	struct gb_loopback *gb = dev_get_drvdata(dev);			\
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  223  	mutex_lock(&gb->mutex);						\
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  224  	ret = sscanf(buf, "%"#type, &gb->field);			\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  225  	if (ret != 1)							\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  226  		len = -EINVAL;						\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  227  	else								\
079fa32ba53a20 Axel Haslam             2015-12-11  228  		gb_loopback_check_attr(gb);		\
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  229  	mutex_unlock(&gb->mutex);					\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  230  	return len;							\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  231  }									\
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  232  static DEVICE_ATTR_RW(field)
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  233  
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  234  static void gb_loopback_reset_stats(struct gb_loopback *gb);
079fa32ba53a20 Axel Haslam             2015-12-11  235  static void gb_loopback_check_attr(struct gb_loopback *gb)
355a7058153e04 Alexandre Bailon        2015-03-31  236  {
b36f04fa9417c5 Bryan O'Donoghue        2015-12-07  237  	if (gb->us_wait > GB_LOOPBACK_US_WAIT_MAX)
b36f04fa9417c5 Bryan O'Donoghue        2015-12-07  238  		gb->us_wait = GB_LOOPBACK_US_WAIT_MAX;
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  239  	if (gb->size > gb_dev.size_max)
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  240  		gb->size = gb_dev.size_max;
12927835d21127 Bryan O'Donoghue        2015-12-07  241  	gb->requests_timedout = 0;
12927835d21127 Bryan O'Donoghue        2015-12-07  242  	gb->requests_completed = 0;
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  243  	gb->iteration_count = 0;
01480ba336982d Alexandre Bailon        2016-03-08  244  	gb->send_count = 0;
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  245  	gb->error = 0;
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  246  
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  247  	if (kfifo_depth < gb->iteration_max) {
079fa32ba53a20 Axel Haslam             2015-12-11  248  		dev_warn(gb->dev,
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  249  			 "cannot log bytes %u kfifo_depth %u\n",
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  250  			 gb->iteration_max, kfifo_depth);
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  251  	}
4b0ea00caf8371 Bryan O'Donoghue        2015-08-17  252  	kfifo_reset_out(&gb->kfifo_lat);
cb60f4960ea03d Bryan O'Donoghue        2015-07-28  253  
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  254  	switch (gb->type) {
a598f4384d9e95 Bryan O'Donoghue        2015-07-13  255  	case GB_LOOPBACK_TYPE_PING:
a598f4384d9e95 Bryan O'Donoghue        2015-07-13  256  	case GB_LOOPBACK_TYPE_TRANSFER:
384a7a3c4f8bf9 Bryan O'Donoghue        2015-07-13  257  	case GB_LOOPBACK_TYPE_SINK:
12927835d21127 Bryan O'Donoghue        2015-12-07  258  		gb->jiffy_timeout = usecs_to_jiffies(gb->timeout);
12927835d21127 Bryan O'Donoghue        2015-12-07  259  		if (!gb->jiffy_timeout)
12927835d21127 Bryan O'Donoghue        2015-12-07  260  			gb->jiffy_timeout = GB_LOOPBACK_TIMEOUT_MIN;
12927835d21127 Bryan O'Donoghue        2015-12-07  261  		else if (gb->jiffy_timeout > GB_LOOPBACK_TIMEOUT_MAX)
12927835d21127 Bryan O'Donoghue        2015-12-07  262  			gb->jiffy_timeout = GB_LOOPBACK_TIMEOUT_MAX;
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  263  		gb_loopback_reset_stats(gb);
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  264  		wake_up(&gb->wq);
a598f4384d9e95 Bryan O'Donoghue        2015-07-13  265  		break;
a598f4384d9e95 Bryan O'Donoghue        2015-07-13  266  	default:
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  267  		gb->type = 0;
a598f4384d9e95 Bryan O'Donoghue        2015-07-13  268  		break;
a598f4384d9e95 Bryan O'Donoghue        2015-07-13  269  	}
355a7058153e04 Alexandre Bailon        2015-03-31  270  }
355a7058153e04 Alexandre Bailon        2015-03-31  271  
355a7058153e04 Alexandre Bailon        2015-03-31  272  /* Time to send and receive one message */
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03 @273  gb_loopback_stats_attrs(latency);
583cbf50e0a4c8 Bryan O'Donoghue        2015-07-21  274  /* Number of requests sent per second on this cport */
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  275  gb_loopback_stats_attrs(requests_per_second);
355a7058153e04 Alexandre Bailon        2015-03-31  276  /* Quantity of data sent and received on this cport */
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  277  gb_loopback_stats_attrs(throughput);
1ec5843ee98899 Bryan O'Donoghue        2015-10-15  278  /* Latency across the UniPro link from APBridge's perspective */
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  279  gb_loopback_stats_attrs(apbridge_unipro_latency);
1ec5843ee98899 Bryan O'Donoghue        2015-10-15  280  /* Firmware induced overhead in the GPBridge */
e54b106dd1be50 Sandeep Patil           2016-05-19  281  gb_loopback_stats_attrs(gbphy_firmware_latency);
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  282  
e140c75ed9f689 Bryan O'Donoghue        2015-07-21  283  /* Number of errors encountered during loop */
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  284  gb_loopback_ro_attr(error);
12927835d21127 Bryan O'Donoghue        2015-12-07  285  /* Number of requests successfully completed async */
12927835d21127 Bryan O'Donoghue        2015-12-07  286  gb_loopback_ro_attr(requests_completed);
12927835d21127 Bryan O'Donoghue        2015-12-07  287  /* Number of requests timed out async */
12927835d21127 Bryan O'Donoghue        2015-12-07  288  gb_loopback_ro_attr(requests_timedout);
12927835d21127 Bryan O'Donoghue        2015-12-07  289  /* Timeout minimum in useconds */
12927835d21127 Bryan O'Donoghue        2015-12-07  290  gb_loopback_ro_attr(timeout_min);
12927835d21127 Bryan O'Donoghue        2015-12-07  291  /* Timeout minimum in useconds */
12927835d21127 Bryan O'Donoghue        2015-12-07  292  gb_loopback_ro_attr(timeout_max);
355a7058153e04 Alexandre Bailon        2015-03-31  293  
355a7058153e04 Alexandre Bailon        2015-03-31  294  /*
799a3f03572afa Bryan O'Donoghue        2015-07-21  295   * Type of loopback message to send based on protocol type definitions
355a7058153e04 Alexandre Bailon        2015-03-31  296   * 0 => Don't send message
799a3f03572afa Bryan O'Donoghue        2015-07-21  297   * 2 => Send ping message continuously (message without payload)
006335a02677ed Alex Elder              2015-08-03  298   * 3 => Send transfer message continuously (message with payload,
799a3f03572afa Bryan O'Donoghue        2015-07-21  299   *					   payload returned in response)
799a3f03572afa Bryan O'Donoghue        2015-07-21  300   * 4 => Send a sink message (message with payload, no payload in response)
355a7058153e04 Alexandre Bailon        2015-03-31  301   */
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  302  gb_dev_loopback_rw_attr(type, d);
355a7058153e04 Alexandre Bailon        2015-03-31  303  /* Size of transfer message payload: 0-4096 bytes */
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  304  gb_dev_loopback_rw_attr(size, u);
48f19ee8244776 Alex Elder              2015-05-11  305  /* Time to wait between two messages: 0-1000 ms */
b36f04fa9417c5 Bryan O'Donoghue        2015-12-07  306  gb_dev_loopback_rw_attr(us_wait, d);
00af6583d15038 Bryan O'Donoghue        2015-07-21  307  /* Maximum iterations for a given operation: 1-(2^32-1), 0 implies infinite */
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  308  gb_dev_loopback_rw_attr(iteration_max, u);
67d1eeceb1aab4 Bryan O'Donoghue        2015-08-17  309  /* The current index of the for (i = 0; i < iteration_max; i++) loop */
f06272b283e159 Bryan O'Donoghue        2015-08-17  310  gb_dev_loopback_ro_attr(iteration_count, false);
12927835d21127 Bryan O'Donoghue        2015-12-07  311  /* A flag to indicate synchronous or asynchronous operations */
12927835d21127 Bryan O'Donoghue        2015-12-07  312  gb_dev_loopback_rw_attr(async, u);
12927835d21127 Bryan O'Donoghue        2015-12-07  313  /* Timeout of an individual asynchronous request */
12927835d21127 Bryan O'Donoghue        2015-12-07  314  gb_dev_loopback_rw_attr(timeout, u);
8e3fba55d379bb Bryan O'Donoghue        2015-12-11  315  /* Maximum number of in-flight operations before back-off */
8e3fba55d379bb Bryan O'Donoghue        2015-12-11  316  gb_dev_loopback_rw_attr(outstanding_operations_max, u);
355a7058153e04 Alexandre Bailon        2015-03-31  317  
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  318  static struct attribute *loopback_attrs[] = {
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03 @319  	&dev_attr_latency_min.attr,
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03 @320  	&dev_attr_latency_max.attr,
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03 @321  	&dev_attr_latency_avg.attr,
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03 @322  	&dev_attr_requests_per_second_min.attr,
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03 @323  	&dev_attr_requests_per_second_max.attr,
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03 @324  	&dev_attr_requests_per_second_avg.attr,
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03 @325  	&dev_attr_throughput_min.attr,
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03 @326  	&dev_attr_throughput_max.attr,
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03 @327  	&dev_attr_throughput_avg.attr,
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  328  	&dev_attr_apbridge_unipro_latency_min.attr,
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  329  	&dev_attr_apbridge_unipro_latency_max.attr,
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  330  	&dev_attr_apbridge_unipro_latency_avg.attr,
e54b106dd1be50 Sandeep Patil           2016-05-19  331  	&dev_attr_gbphy_firmware_latency_min.attr,
e54b106dd1be50 Sandeep Patil           2016-05-19  332  	&dev_attr_gbphy_firmware_latency_max.attr,
e54b106dd1be50 Sandeep Patil           2016-05-19  333  	&dev_attr_gbphy_firmware_latency_avg.attr,
355a7058153e04 Alexandre Bailon        2015-03-31  334  	&dev_attr_type.attr,
355a7058153e04 Alexandre Bailon        2015-03-31  335  	&dev_attr_size.attr,
b36f04fa9417c5 Bryan O'Donoghue        2015-12-07  336  	&dev_attr_us_wait.attr,
00af6583d15038 Bryan O'Donoghue        2015-07-21  337  	&dev_attr_iteration_count.attr,
00af6583d15038 Bryan O'Donoghue        2015-07-21  338  	&dev_attr_iteration_max.attr,
12927835d21127 Bryan O'Donoghue        2015-12-07  339  	&dev_attr_async.attr,
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  340  	&dev_attr_error.attr,
12927835d21127 Bryan O'Donoghue        2015-12-07  341  	&dev_attr_requests_completed.attr,
12927835d21127 Bryan O'Donoghue        2015-12-07  342  	&dev_attr_requests_timedout.attr,
12927835d21127 Bryan O'Donoghue        2015-12-07  343  	&dev_attr_timeout.attr,
8e3fba55d379bb Bryan O'Donoghue        2015-12-11  344  	&dev_attr_outstanding_operations_max.attr,
12927835d21127 Bryan O'Donoghue        2015-12-07  345  	&dev_attr_timeout_min.attr,
12927835d21127 Bryan O'Donoghue        2015-12-07  346  	&dev_attr_timeout_max.attr,
f06272b283e159 Bryan O'Donoghue        2015-08-17  347  	NULL,
f06272b283e159 Bryan O'Donoghue        2015-08-17  348  };
8e1d6c336d7497 Bryan O'Donoghue        2015-12-03  349  ATTRIBUTE_GROUPS(loopback);
355a7058153e04 Alexandre Bailon        2015-03-31  350  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
