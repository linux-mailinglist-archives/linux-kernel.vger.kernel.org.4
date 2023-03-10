Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6615C6B5545
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjCJXDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjCJXDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:03:14 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCAA1A953
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:03:09 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 0587A604EF;
        Sat, 11 Mar 2023 00:03:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678489388; bh=3fH7qot9ktCICiPVxk6Knkoz7L9okdk78p8oYrlJ0Q4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fgZp4IW9if6Vgs/Dyc1pdp0W56KQRxAUZnxh3/wn3vZwTy51NpKBHb1el4VqONnms
         xkjiFOcetkIDLOcHIsgjIgmRirnsCUWorrm40kiy621mDgtFg2hHZfNHB05oktNBKJ
         dCidHpiLFb0uB44qyrTCwBACLHZv89798llvyv092CMYeNPPzM5Q3kuDJTZ31n4uwm
         zFQ2jLm0zFsRvfYRAl1gGwbcX0uwSr9EOKdVX5h32AsDeAaqAF48rTN5DCMEqurxLw
         5/nAsOghmYS0bEdh+tFNozEQevFhrhgx+MGqm5Cr/Lfe1QxV9JDdXy88tfpNsNg/D5
         Kf6ZDNIn5sHSg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WOdcOeLpFDJi; Sat, 11 Mar 2023 00:03:04 +0100 (CET)
Received: from [192.168.1.4] (unknown [77.237.109.125])
        by domac.alu.hr (Postfix) with ESMTPSA id 83F84604ED;
        Sat, 11 Mar 2023 00:03:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678489384; bh=3fH7qot9ktCICiPVxk6Knkoz7L9okdk78p8oYrlJ0Q4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lQcGye6k2iET+wQiRCnat/uTd0FOBZOPfcYuoz9wUIo+uq9Z+qG7E2gohHN7UOv/v
         RaQFLHbzXzk0FWJwfaCcb3XqZaFmbToRnsSlgMxAMt8SrNj3n6Glprx2/zLfvnmpYr
         PMSDLE2ip9QpvP5uFeECd+JnxgCduHKDT7pxAODlHqGDzUKj1GgOi1xrURoxcq7UQT
         n+ZT7IGrXkCR6Gplw282sDxzJgL4iJN2hWDsQZmBp3Y45B8/wrgAvx3n/YkZD9ueVh
         ckk5Lz8/UT+EVU6XlUGvzULge6twk2EOq2g8491QsnB1TBdoHJXRaivBZDuDn00Oo5
         exKBNx0PGrH2Q==
Message-ID: <b4c5a280-c619-4713-0295-75d67aefbaeb@alu.unizg.hr>
Date:   Sat, 11 Mar 2023 00:03:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 1/1] devres: Pass unique name of the resource to
 devm_add_action() P.S.
Content-Language: en-US, hr
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20230224200745.17324-1-andriy.shevchenko@linux.intel.com>
 <83bebd97-ba44-9e19-d66c-95b43b123797@alu.unizg.hr>
 <ZAs6nZz05C016l0E@smile.fi.intel.com>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZAs6nZz05C016l0E@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 03. 2023. 15:11, Andy Shevchenko wrote:
> On Fri, Mar 10, 2023 at 02:21:24PM +0100, Mirsad Todorovac wrote:
>> On 2/24/23 21:07, Andy Shevchenko wrote:
>>> Pass the unique name of the resource to devm_add_action(),
>>> so it will be easier to debug managed resources.
> 
> ...
> 
>> (I'm late two weeks w testing, but those were rather busy two weeks.)
> 
> Thank you for this test!
> 
>> I see what it is meant to do, but I am unsure of how to test whether it works.
> 
> Your test below is good enough.
> 
>> Being the unfaithful Thomas, I always prefer to test rather to just assume it
>> is OK.
>>
>> Is this OK output you expected to see in syslog?
> 
> Not really. It seems that we need to also wrap the devm_add_action_or_reset()
> separately.
> 
>> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000ea28d384 action (16 bytes)
> 
>> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000004090f288 action (16 bytes)
>> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000004090f288 action (16 bytes)
> 
>> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000ea28d384 action (16 bytes)
> 
> Instead of 'action' we need to see the real name of the action.
> 
>> NOTE: Maybe I should emphasise that this is not seen in either dmesg or kernel console.
> 
> Do you have 'ignore_loglevel' in the kernel command line? You should,
> independently on this patch, for debug testing.
> 
>> I have just checked, and DEVRES lines are only in /var/log/messages (on AlmaLinux 8.7, CentOS fork).
>>
>> As you must have guessed yourself already, this will frustrate debugging past the lifetime of rsyslog process.
>>
>> Also, there is no way known to me to access dmesg log from the previous kernel run.
> 
> Can you test this on top?
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 0f128520f6e5..12dc08aa5c0f 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -250,17 +250,19 @@ int __devm_add_action(struct device *dev, void (*action)(void *), void *data, co
>  #define devm_add_action(release, action, data) \
>  	__devm_add_action(release, action, data, #action)
>  
> -static inline int devm_add_action_or_reset(struct device *dev,
> -					   void (*action)(void *), void *data)
> +static inline int __devm_add_action_or_reset(struct device *dev, void (*action)(void *),
> +					     void *data, const char *name)
>  {
>  	int ret;
>  
> -	ret = devm_add_action(dev, action, data);
> +	ret = __devm_add_action(dev, action, data, name);
>  	if (ret)
>  		action(data);
>  
>  	return ret;
>  }
> +#define devm_add_action_or_reset(release, action, data) \
> +	__devm_add_action_or_reset(release, action, data, #action)
>  
>  /**
>   * devm_alloc_percpu - Resource-managed alloc_percpu

Hi again,

I hope I am not harassing you with these patch tests, but I wanted
to have something done before the weekend rest. 

But I consider myself more an enthusiast than professional software
developer, let alone the Linux kernel developer. Tester, maybe.

W/o cmdline option ignore_loglevel I get gpio-sim.sh DEVRES trace,
which didn't show in the previous run with the cmdline option on
and attempted "echo 0 > /sys/module/printk/parameters/ignore_loglevel".

I have used the same method of enabling gpio-sim trace in both cases:

[root@pc-mtodorov gpio]# echo 1 > /sys/kernel/tracing/events/gpio/enable

The output looks like:

Mar 10 23:42:01 pc-mtodorov kernel: gpio_stub_drv gpiochip19: DEVRES ADD 00000000b9d73192 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio_stub_drv gpiochip19: DEVRES ADD 00000000db6dfc59 devm_pinctrl_release (8 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio_stub_drv gpiochip19: DEVRES REM 00000000db6dfc59 devm_pinctrl_release (8 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio_stub_drv gpiochip19: DEVRES REM 00000000b9d73192 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000db6dfc59 devm_gpio_chip_release (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000000a8e239e devm_kzalloc_release (72 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000b9d73192 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000001cca9244 devm_kzalloc_release (24 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000b48fafb3 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000851e261f devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000fdd26366 devm_kzalloc_release (10 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000009da8f8c1 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000d2943a71 devm_kzalloc_release (24 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000079ee058a devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000a438b9e3 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000ac3cbdf9 devm_kzalloc_release (10 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000056e918b2 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000ef18c8eb devm_kzalloc_release (24 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000000a01175 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000899b03e8 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000054d38b9e devm_kzalloc_release (10 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000e6cd1347 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000f66bdca7 devm_kzalloc_release (24 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000988ba3f7 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000008cb9b21c devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000009bf508f9 devm_kzalloc_release (10 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000c3dd6a9d devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000045c8d318 devm_kzalloc_release (24 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000c955af94 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000dc8d8fe4 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000157ab2af devm_kzalloc_release (10 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000cd587eda devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000034a5b9e7 devm_kzalloc_release (24 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000007ae99ea1 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000009ecae236 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000001c1415ef devm_kzalloc_release (10 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000fcdf925a devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000020285b2d devm_kzalloc_release (24 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000fa7f9d4a devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000c5b2d23e devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000acaa5f2e devm_kzalloc_release (10 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000445e422d devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000014549196 devm_kzalloc_release (24 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000847e426d devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000026c20f81 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000a88df26e devm_kzalloc_release (10 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000000eaf3f56 gpio_sim_sysfs_remove (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000000eaf3f56 gpio_sim_sysfs_remove (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000a88df26e devm_kzalloc_release (10 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000026c20f81 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000847e426d devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000014549196 devm_kzalloc_release (24 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000445e422d devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000acaa5f2e devm_kzalloc_release (10 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000c5b2d23e devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000fa7f9d4a devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000020285b2d devm_kzalloc_release (24 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000fcdf925a devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000001c1415ef devm_kzalloc_release (10 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000009ecae236 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000007ae99ea1 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000034a5b9e7 devm_kzalloc_release (24 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000cd587eda devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000157ab2af devm_kzalloc_release (10 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000dc8d8fe4 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000c955af94 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000045c8d318 devm_kzalloc_release (24 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000c3dd6a9d devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000009bf508f9 devm_kzalloc_release (10 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000008cb9b21c devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000988ba3f7 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000f66bdca7 devm_kzalloc_release (24 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000e6cd1347 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000054d38b9e devm_kzalloc_release (10 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000899b03e8 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000000a01175 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000ef18c8eb devm_kzalloc_release (24 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000056e918b2 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000ac3cbdf9 devm_kzalloc_release (10 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000a438b9e3 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000079ee058a devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000d2943a71 devm_kzalloc_release (24 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000009da8f8c1 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000fdd26366 devm_kzalloc_release (10 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000851e261f devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000b48fafb3 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000001cca9244 devm_kzalloc_release (24 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000b9d73192 devm_kzalloc_release (40 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000000a8e239e devm_kzalloc_release (72 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000db6dfc59 devm_gpio_chip_release (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000008be0d08c gpio_sim_mutex_destroy (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000cca4b2d6 devm_irq_domain_remove_sim (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000f848380a devm_bitmap_free (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000050ab06c8 devm_bitmap_free (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000064ebe727 devm_bitmap_free (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000004d67f192 devm_kzalloc_release (656 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000064c8d56b devm_kzalloc_release (17 bytes)

Please note that "rmmod gpio-sim" didn't add any new DEVRES entries, if that makes
a difference.

I've been trying to separate the events by running "gpio-sim.sh" at 23:42 and "rmmod gpio-sim" at 23:45,
and the result is evident, but will not delve now into it because I am a bit weather-beaten.

In  particular, when comparing to the old test results without the last change:

Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000ea28d384 action (16 bytes)
Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000000cb0e6b1 devm_kzalloc_release (16 bytes)
Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000056043cc0 devm_kzalloc_release (40 bytes)
Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000c904ae95 devm_kzalloc_release (24 bytes)
Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000cd39c068 devm_kzalloc_release (40 bytes)
Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000918a0de4 devm_kzalloc_release (40 bytes)
Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000008192a378 devm_kzalloc_release (10 bytes)
Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000004090f288 action (16 bytes)
Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000004090f288 action (16 bytes)
Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000008192a378 devm_kzalloc_release (10 bytes)
Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000918a0de4 devm_kzalloc_release (40 bytes)
Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000cd39c068 devm_kzalloc_release (40 bytes)
Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000c904ae95 devm_kzalloc_release (24 bytes)
Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000056043cc0 devm_kzalloc_release (40 bytes)
Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000000cb0e6b1 devm_kzalloc_release (16 bytes)
Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000ea28d384 action (16 bytes)

.. there were these "action" calls with (16 bytes).

Now those look like this, if I figured it out well:

Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000567cd854 devm_bitmap_free (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000098394533 devm_bitmap_free (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000064c8d56b devm_bitmap_free (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000007c05a459 devm_bitmap_free (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000056f5b5e6 devm_bitmap_free (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000ab3f962b devm_bitmap_free (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000c0a797cb devm_irq_domain_remove_sim (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000007ad662a5 gpio_sim_mutex_destroy (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000d12bc3dc devm_gpio_chip_release (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000002de3d4c9 gpio_sim_sysfs_remove (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000002de3d4c9 gpio_sim_sysfs_remove (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000d12bc3dc devm_gpio_chip_release (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000007ad662a5 gpio_sim_mutex_destroy (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000c0a797cb devm_irq_domain_remove_sim (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000ab3f962b devm_bitmap_free (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000056f5b5e6 devm_bitmap_free (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000007c05a459 devm_bitmap_free (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000cbf11512 devm_bitmap_free (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000023cc8968 devm_bitmap_free (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000cd9fed5b devm_bitmap_free (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000e2c397e4 devm_irq_domain_remove_sim (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000cb4dbe1d gpio_sim_mutex_destroy (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000065384fb9 devm_gpio_chip_release (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000fe114c27 devm_kzalloc_release (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000001c3cf972 gpio_sim_sysfs_remove (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000001c3cf972 gpio_sim_sysfs_remove (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000fe114c27 devm_kzalloc_release (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000065384fb9 devm_gpio_chip_release (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000cb4dbe1d gpio_sim_mutex_destroy (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000e2c397e4 devm_irq_domain_remove_sim (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000cd9fed5b devm_bitmap_free (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000023cc8968 devm_bitmap_free (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000cbf11512 devm_bitmap_free (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000477f9c62 devm_bitmap_free (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000210ce87c devm_bitmap_free (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000629819f6 devm_bitmap_free (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000023a7be05 devm_irq_domain_remove_sim (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000001723fc6e gpio_sim_mutex_destroy (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000000b9b893b devm_gpio_chip_release (16 bytes)
Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000493d92e3 gpio_sim_sysfs_remove (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000493d92e3 gpio_sim_sysfs_remove (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000000b9b893b devm_gpio_chip_release (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000001723fc6e gpio_sim_mutex_destroy (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000023a7be05 devm_irq_domain_remove_sim (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000629819f6 devm_bitmap_free (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000210ce87c devm_bitmap_free (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000477f9c62 devm_bitmap_free (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000064ebe727 devm_bitmap_free (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000050ab06c8 devm_bitmap_free (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000f848380a devm_bitmap_free (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000cca4b2d6 devm_irq_domain_remove_sim (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000008be0d08c gpio_sim_mutex_destroy (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000db6dfc59 devm_gpio_chip_release (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000000eaf3f56 gpio_sim_sysfs_remove (16 bytes)
Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000000eaf3f56 gpio_sim_sysfs_remove (16 bytes)

I hope this helps the big picture.

I hope this redeems me from by Reviewed-by: blunder?

Of course, I realise that I am doing this as a pet project ATM and you might have
professional constraints and reputation to care about I did not consider.

I certainly aim to cling to the Code of Conduct to the fullest. In the academic
sense, appropriating credits where they are due is of utmost importance, too.

I believe that errors and blunders make me authentic :-) It took me time to learn
to live with the fact that I make errors no matter how hard I might try not to.

Best regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

