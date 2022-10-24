Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9223609D83
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJXJJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiJXJIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:08:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D220D116F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666602521; x=1698138521;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5L/fG/Ui8cXJbVyL/PjPunCHI8UYMxhH3x5fxgw4GKs=;
  b=jI731lTMKM2fEZrLpYr+Y+fj/pzJ4MTFHQVF85iWThPikQlmPOwWHunR
   rpj5aBYcR0yfEHEPRP3COYe1GJNWmou5Kos0jMuNd+yS0+rgrFHKSato1
   xc3irySHzIkXFSYBM+PB8fk3ZqBurQ3g/+hpMkOpyhQK3Zxl2/cez6FPW
   rtAnDgVtlaAxxPi7QZ37Z/EzdJ0Esx3ZsxH0UBpF+OcpjKFeovXqWi1TF
   sotND0sLX8baH3UMRs03FoWqj8hPMHuUi5oRTffVM2GFqb9N241p6gEpY
   fJSb21x+FkQeVtAr3JO7CoWyL6NKq2gTr81yp1vklpelTlOqxPyKd/lvA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="371591238"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="371591238"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 02:08:40 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="720424117"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="720424117"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.212.138]) ([10.254.212.138])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 02:08:39 -0700
Subject: Re: [driver-core:driver-core-testing] BUILD SUCCESS
 59789f3418dd3c0a187490d49e900a59a5c8d732
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>
References: <635484ed.ADi+2sBza+UlAhjj%lkp@intel.com>
 <Y1U0pINWo5yjUdc2@kroah.com> <Y1WZSysScBH0/6kd@smile.fi.intel.com>
 <Y1WbY903LjRATVwh@smile.fi.intel.com>
 <a762dca8-2458-c40b-7a35-80971c46ac84@intel.com>
 <Y1ZTXa0VZrl9jvUU@smile.fi.intel.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <86cafe81-004b-8a0f-b50b-2bad38f84635@intel.com>
Date:   Mon, 24 Oct 2022 17:08:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Y1ZTXa0VZrl9jvUU@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/2022 4:57 PM, Andy Shevchenko wrote:
> On Mon, Oct 24, 2022 at 09:10:53AM +0800, Chen, Rong A wrote:
>> On 10/24/2022 3:52 AM, Andy Shevchenko wrote:
>>> On Sun, Oct 23, 2022 at 10:43:07PM +0300, Andy Shevchenko wrote:
>>>> On Sun, Oct 23, 2022 at 02:33:40PM +0200, Greg Kroah-Hartman wrote:
>>>>> On Sun, Oct 23, 2022 at 08:03:57AM +0800, kernel test robot wrote:
>>>>>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-testing
>>>>>> branch HEAD: 59789f3418dd3c0a187490d49e900a59a5c8d732  device property: Constify parameter in device_dma_supported() and device_get_dma_attr()
>>>>>>
>>>>>> Unverified Warning (likely false positive, please contact us if interested):
>>>>>>
>>>>>> drivers/hwmon/iio_hwmon.c:155 iio_hwmon_probe() warn: could not determine type of argument 4
>>>>>
>>>>> Andy, this is due to your changes, here's the offending code:
>>>>>
>>>>> 	sname = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", dev_fwnode(dev));
>>>>>
>>>>> Now that dev_fwnode() is an inline function, the compiler is confused as
>>>>> to what function to select?  Maybe, I don't know, it seems odd, can you
>>>>> look into it?
>>>>
>>>> Hmm... I can't reproduce on my side.
>>>> Any (additional) information about compiler, architecture, etc?
>>>
>>> I found the original report, but I don't see how to extract the defconfig /
>>> config it used. Can you send that file to me?
>>>
>>
>> Hi Andy,
>>
>> The original report can be found at https://lists.01.org/hyperkitty/list/kbuild@lists.01.org/thread/VE7CMY7FVIPYWHL4XMOCFWCNYTGZSTKP/
>>
>> and config file can be downloaded from https://lists.01.org/hyperkitty/list/kbuild@lists.01.org/message/VE7CMY7FVIPYWHL4XMOCFWCNYTGZSTKP/attachment/2/config.ksh
> 
> Thanks!
> 
> Can't reproduce on my Debian (x86_64):
> 
> gcc (Debian 12.2.0-3) 12.2.0
> Copyright (C) 2022 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> Is it GCC issue?
> 
> Any pointers where I can download the compiler you are using?
> 

Hi Andy,

It's a smatch warning, it may be a false positive since Dan didn't 
forward the report. +Dan

smatch warnings:
drivers/hwmon/iio_hwmon.c:155 iio_hwmon_probe() warn: could not 
determine type of argument 4

vim +155 drivers/hwmon/iio_hwmon.c

e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15   65
4ae1c61ff2ba4f drivers/staging/iio/iio_hwmon.c Bill Pemberton 
2012-11-19   66  static int iio_hwmon_probe(struct platform_device *pdev)
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15   67  {
c4ac7b98bdeb04 drivers/staging/iio/iio_hwmon.c Guenter Roeck 
2013-01-31   68  	struct device *dev = &pdev->dev;
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15   69  	struct iio_hwmon_state *st;
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15   70  	struct sensor_device_attribute *a;
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15   71  	int ret, i;
bc34301b10672d drivers/hwmon/iio_hwmon.c       Michal Simek 
2019-08-22   72  	int in_i = 1, temp_i = 1, curr_i = 1, humidity_i = 1, 
power_i = 1;
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15   73  	enum iio_chan_type type;
ca7d98dbd7db6a drivers/staging/iio/iio_hwmon.c Guenter Roeck 
2013-01-31   74  	struct iio_channel *channels;
12005ec33f3a7e drivers/hwmon/iio_hwmon.c       Maxime Roussin-Bélanger 
2018-07-22   75  	struct device *hwmon_dev;
b92fe9e3379c8d drivers/hwmon/iio_hwmon.c       Sanchayan Maity 
2016-02-16   76  	char *sname;
4b49cca36ee9bb drivers/hwmon/iio_hwmon.c       Guenter Roeck 
2013-12-01   77
12005ec33f3a7e drivers/hwmon/iio_hwmon.c       Maxime Roussin-Bélanger 
2018-07-22   78  	channels = devm_iio_channel_get_all(dev);
9417fefe6f6ec2 drivers/hwmon/iio_hwmon.c       Quentin Schulz 
2016-09-08   79  	if (IS_ERR(channels)) {
9417fefe6f6ec2 drivers/hwmon/iio_hwmon.c       Quentin Schulz 
2016-09-08   80  		if (PTR_ERR(channels) == -ENODEV)
9417fefe6f6ec2 drivers/hwmon/iio_hwmon.c       Quentin Schulz 
2016-09-08   81  			return -EPROBE_DEFER;
ca7d98dbd7db6a drivers/staging/iio/iio_hwmon.c Guenter Roeck 
2013-01-31   82  		return PTR_ERR(channels);
9417fefe6f6ec2 drivers/hwmon/iio_hwmon.c       Quentin Schulz 
2016-09-08   83  	}
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15   84
c4ac7b98bdeb04 drivers/staging/iio/iio_hwmon.c Guenter Roeck 
2013-01-31   85  	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
12005ec33f3a7e drivers/hwmon/iio_hwmon.c       Maxime Roussin-Bélanger 
2018-07-22   86  	if (st == NULL)
12005ec33f3a7e drivers/hwmon/iio_hwmon.c       Maxime Roussin-Bélanger 
2018-07-22   87  		return -ENOMEM;
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15   88
ca7d98dbd7db6a drivers/staging/iio/iio_hwmon.c Guenter Roeck 
2013-01-31   89  	st->channels = channels;
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15   90
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15   91  	/* count how many attributes we have */
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15   92  	while (st->channels[st->num_channels].indio_dev)
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15   93  		st->num_channels++;
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15   94
a86854d0c599b3 drivers/hwmon/iio_hwmon.c       Kees Cook 
2018-06-12   95  	st->attrs = devm_kcalloc(dev,
a86854d0c599b3 drivers/hwmon/iio_hwmon.c       Kees Cook 
2018-06-12   96  				 st->num_channels + 1, sizeof(*st->attrs),
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15   97  				 GFP_KERNEL);
12005ec33f3a7e drivers/hwmon/iio_hwmon.c       Maxime Roussin-Bélanger 
2018-07-22   98  	if (st->attrs == NULL)
12005ec33f3a7e drivers/hwmon/iio_hwmon.c       Maxime Roussin-Bélanger 
2018-07-22   99  		return -ENOMEM;
c4ac7b98bdeb04 drivers/staging/iio/iio_hwmon.c Guenter Roeck 
2013-01-31  100
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15  101  	for (i = 0; i < st->num_channels; i++) {
cb202bb8b3238f drivers/hwmon/iio_hwmon.c       Andrey Smirnov 
2019-04-02  102  		const char *prefix;
cb202bb8b3238f drivers/hwmon/iio_hwmon.c       Andrey Smirnov 
2019-04-02  103  		int n;
cb202bb8b3238f drivers/hwmon/iio_hwmon.c       Andrey Smirnov 
2019-04-02  104
c4ac7b98bdeb04 drivers/staging/iio/iio_hwmon.c Guenter Roeck 
2013-01-31  105  		a = devm_kzalloc(dev, sizeof(*a), GFP_KERNEL);
12005ec33f3a7e drivers/hwmon/iio_hwmon.c       Maxime Roussin-Bélanger 
2018-07-22  106  		if (a == NULL)
12005ec33f3a7e drivers/hwmon/iio_hwmon.c       Maxime Roussin-Bélanger 
2018-07-22  107  			return -ENOMEM;
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15  108
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15  109  		sysfs_attr_init(&a->dev_attr.attr);
314be14bb89369 drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-05-01  110  		ret = iio_get_channel_type(&st->channels[i], &type);
c4ac7b98bdeb04 drivers/staging/iio/iio_hwmon.c Guenter Roeck 
2013-01-31  111  		if (ret < 0)
12005ec33f3a7e drivers/hwmon/iio_hwmon.c       Maxime Roussin-Bélanger 
2018-07-22  112  			return ret;
c4ac7b98bdeb04 drivers/staging/iio/iio_hwmon.c Guenter Roeck 
2013-01-31  113
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15  114  		switch (type) {
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15  115  		case IIO_VOLTAGE:
cb202bb8b3238f drivers/hwmon/iio_hwmon.c       Andrey Smirnov 
2019-04-02  116  			n = in_i++;
cb202bb8b3238f drivers/hwmon/iio_hwmon.c       Andrey Smirnov 
2019-04-02  117  			prefix = "in";
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15  118  			break;
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15  119  		case IIO_TEMP:
cb202bb8b3238f drivers/hwmon/iio_hwmon.c       Andrey Smirnov 
2019-04-02  120  			n = temp_i++;
cb202bb8b3238f drivers/hwmon/iio_hwmon.c       Andrey Smirnov 
2019-04-02  121  			prefix = "temp";
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15  122  			break;
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15  123  		case IIO_CURRENT:
cb202bb8b3238f drivers/hwmon/iio_hwmon.c       Andrey Smirnov 
2019-04-02  124  			n = curr_i++;
cb202bb8b3238f drivers/hwmon/iio_hwmon.c       Andrey Smirnov 
2019-04-02  125  			prefix = "curr";
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15  126  			break;
bc34301b10672d drivers/hwmon/iio_hwmon.c       Michal Simek 
2019-08-22  127  		case IIO_POWER:
bc34301b10672d drivers/hwmon/iio_hwmon.c       Michal Simek 
2019-08-22  128  			n = power_i++;
bc34301b10672d drivers/hwmon/iio_hwmon.c       Michal Simek 
2019-08-22  129  			prefix = "power";
bc34301b10672d drivers/hwmon/iio_hwmon.c       Michal Simek 
2019-08-22  130  			break;
61bb53bcbdd86e drivers/hwmon/iio_hwmon.c       Guenter Roeck 
2014-09-27  131  		case IIO_HUMIDITYRELATIVE:
cb202bb8b3238f drivers/hwmon/iio_hwmon.c       Andrey Smirnov 
2019-04-02  132  			n = humidity_i++;
cb202bb8b3238f drivers/hwmon/iio_hwmon.c       Andrey Smirnov 
2019-04-02  133  			prefix = "humidity";
61bb53bcbdd86e drivers/hwmon/iio_hwmon.c       Guenter Roeck 
2014-09-27  134  			break;
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15  135  		default:
12005ec33f3a7e drivers/hwmon/iio_hwmon.c       Maxime Roussin-Bélanger 
2018-07-22  136  			return -EINVAL;
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15  137  		}
cb202bb8b3238f drivers/hwmon/iio_hwmon.c       Andrey Smirnov 
2019-04-02  138
cb202bb8b3238f drivers/hwmon/iio_hwmon.c       Andrey Smirnov 
2019-04-02  139  		a->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
cb202bb8b3238f drivers/hwmon/iio_hwmon.c       Andrey Smirnov 
2019-04-02  140  						       "%s%d_input",
cb202bb8b3238f drivers/hwmon/iio_hwmon.c       Andrey Smirnov 
2019-04-02  141  						       prefix, n);
12005ec33f3a7e drivers/hwmon/iio_hwmon.c       Maxime Roussin-Bélanger 
2018-07-22  142  		if (a->dev_attr.attr.name == NULL)
12005ec33f3a7e drivers/hwmon/iio_hwmon.c       Maxime Roussin-Bélanger 
2018-07-22  143  			return -ENOMEM;
12005ec33f3a7e drivers/hwmon/iio_hwmon.c       Maxime Roussin-Bélanger 
2018-07-22  144
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15  145  		a->dev_attr.show = iio_hwmon_read_val;
389bc38eeb4aa8 drivers/hwmon/iio_hwmon.c       Guenter Roeck 
2018-12-10  146  		a->dev_attr.attr.mode = 0444;
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15  147  		a->index = i;
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15  148  		st->attrs[i] = &a->dev_attr.attr;
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15  149  	}
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15  150
4b49cca36ee9bb drivers/hwmon/iio_hwmon.c       Guenter Roeck 
2013-12-01  151  	st->attr_group.attrs = st->attrs;
4b49cca36ee9bb drivers/hwmon/iio_hwmon.c       Guenter Roeck 
2013-12-01  152  	st->groups[0] = &st->attr_group;
b92fe9e3379c8d drivers/hwmon/iio_hwmon.c       Sanchayan Maity 
2016-02-16  153
b7b568c2525b3a drivers/hwmon/iio_hwmon.c       Andy Shevchenko 
2022-08-26  154  	if (dev_fwnode(dev)) {
b7b568c2525b3a drivers/hwmon/iio_hwmon.c       Andy Shevchenko 
2022-08-26 @155  		sname = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", 
dev_fwnode(dev));
12005ec33f3a7e drivers/hwmon/iio_hwmon.c       Maxime Roussin-Bélanger 
2018-07-22  156  		if (!sname)
12005ec33f3a7e drivers/hwmon/iio_hwmon.c       Maxime Roussin-Bélanger 
2018-07-22  157  			return -ENOMEM;
b92fe9e3379c8d drivers/hwmon/iio_hwmon.c       Sanchayan Maity 
2016-02-16  158  		strreplace(sname, '-', '_');
86103cffe8834f drivers/hwmon/iio_hwmon.c       Guenter Roeck 
2018-08-28  159  	} else {
86103cffe8834f drivers/hwmon/iio_hwmon.c       Guenter Roeck 
2018-08-28  160  		sname = "iio_hwmon";
86103cffe8834f drivers/hwmon/iio_hwmon.c       Guenter Roeck 
2018-08-28  161  	}
86103cffe8834f drivers/hwmon/iio_hwmon.c       Guenter Roeck 
2018-08-28  162
12005ec33f3a7e drivers/hwmon/iio_hwmon.c       Maxime Roussin-Bélanger 
2018-07-22  163  	hwmon_dev = 
devm_hwmon_device_register_with_groups(dev, sname, st,
4b49cca36ee9bb drivers/hwmon/iio_hwmon.c       Guenter Roeck 
2013-12-01  164  							   st->groups);
12005ec33f3a7e drivers/hwmon/iio_hwmon.c       Maxime Roussin-Bélanger 
2018-07-22  165  	return PTR_ERR_OR_ZERO(hwmon_dev);
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15  166  }
e0f8a24e0edfde drivers/staging/iio/iio_hwmon.c Jonathan Cameron 
2012-02-15  167

Best Regards,
Rong Chen

