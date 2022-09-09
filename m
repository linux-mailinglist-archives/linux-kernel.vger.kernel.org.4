Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C5C5B4042
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIITzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiIITzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:55:39 -0400
X-Greylist: delayed 445 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Sep 2022 12:55:25 PDT
Received: from vorpal.se (unknown [151.236.221.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B81FB4416
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:55:25 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id D1417142D4;
        Fri,  9 Sep 2022 19:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1662752849; bh=m5F9OisW+215YqSsE6KG9srcunWjr9IKPLu0+1gUwkM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XqNwTs8wTd/M0CbuYQvDJ3ZmWv23sIIwrtBLjJoaCGy9wSK3CzC71m0QTt1N3G45I
         SkYrj5S1HSBo0MUZcIO0QzQHCB5GQ0up1zSmJFKRGmAwEMzAObyuaFoO4KXhlIm8k3
         PPV7PFK6L4Yi+lCdSsup2/ftFArccJKlgkMJpMaxp1ZJg6cdpej//Bg+wctr5u/CN+
         jwLrJK8gsTXUKRdPAHjLhvB9zFBVt3dXznN+/vsUEyqaW5/csF6RvLUjlzA8CnmpIk
         3YaVSndfbWAcUIUzvKtQ3vGbWC6r+MAsEWQkpfF7YauBK2/btD9c7pDgklAvImqXQQ
         5baCNBEC95+xA==
Message-ID: <695c3c05-d6c9-8717-4cca-2119542f2f43@vorpal.se>
Date:   Fri, 9 Sep 2022 21:47:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [pdx86-platform-drivers-x86:review-hans 59/65]
 drivers/platform/x86/toshiba_acpi.c:2937:9: warning: no previous prototype
 for 'toshiba_acpi_hwmon_is_visible'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
References: <202209100300.LjCie4bn-lkp@intel.com>
From:   Arvid Norlander <lkml@vorpal.se>
In-Reply-To: <202209100300.LjCie4bn-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,NO_DNS_FOR_FROM,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022-09-09 21:19, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
> head:   79e8f8235a1686d0656b60cf72f7fda5530ee1cf
> commit: b5f3665e82591d465357f4a69196f46b3d30e997 [59/65] platform/x86: toshiba_acpi: Add fan RPM reading (hwmon interface)
> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220910/202209100300.LjCie4bn-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=b5f3665e82591d465357f4a69196f46b3d30e997
>         git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
>         git fetch --no-tags pdx86-platform-drivers-x86 review-hans
>         git checkout b5f3665e82591d465357f4a69196f46b3d30e997
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/platform/x86/toshiba_acpi.c:2937:9: warning: no previous prototype for 'toshiba_acpi_hwmon_is_visible' [-Wmissing-prototypes]
>     2937 | umode_t toshiba_acpi_hwmon_is_visible(const void *drvdata,
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/platform/x86/toshiba_acpi.c:2944:5: warning: no previous prototype for 'toshiba_acpi_hwmon_read' [-Wmissing-prototypes]
>     2944 | int toshiba_acpi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>          |     ^~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/toshiba_acpi_hwmon_is_visible +2937 drivers/platform/x86/toshiba_acpi.c
> 
>   2934	
>   2935	/* HWMON support for fan */
>   2936	#if IS_ENABLED(CONFIG_HWMON)
>> 2937	umode_t toshiba_acpi_hwmon_is_visible(const void *drvdata,
>   2938					      enum hwmon_sensor_types type,
>   2939					      u32 attr, int channel)
>   2940	{
>   2941		return 0444;
>   2942	}
>   2943	
>> 2944	int toshiba_acpi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>   2945				    u32 attr, int channel, long *val)

Oops, clearly these are missing "static". Hans de Goede: Can you apply that
fix locally easily, or should I send a patch? I must have forgotten to
build with W=1.

>   2946	{
>   2947		/*
>   2948		 * There is only a single channel and single attribute (for the
>   2949		 * fan) at this point.
>   2950		 * This can be replaced with more advanced logic in the future,
>   2951		 * should the need arise.
>   2952		 */
>   2953		if (type == hwmon_fan && channel == 0 && attr == hwmon_fan_input) {
>   2954			u32 value;
>   2955			int ret;
>   2956	
>   2957			ret = get_fan_rpm(toshiba_acpi, &value);
>   2958			if (ret)
>   2959				return ret;
>   2960	
>   2961			*val = value;
>   2962			return 0;
>   2963		}
>   2964		return -EOPNOTSUPP;
>   2965	}
>   2966	
> 

Best regards,
Arvid Norlander
