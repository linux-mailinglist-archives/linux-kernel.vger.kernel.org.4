Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F43A6B4027
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCJNVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjCJNVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:21:32 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7119D13D65
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:21:30 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id A1C2660502;
        Fri, 10 Mar 2023 14:21:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678454487; bh=JXqGLzrX3FhQnp3vxNjiKMY/n5dMhP5F5mgTr9d2sIo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ntshaxaDq24kWvcmXhgML4E4FLC3qpDK9rKQ4oEzDle7bWn+5FaxF1NtTB+WlNasq
         bZGor4sxSxSWVO5DXk1Sj/tuKbMpStFmbdyjoGxQ12n2zCQFemc7Yh/SLm+4WXjg8u
         fw4oYAZYaDVk2kHAsSDJOJtHirZl2XLCFysNzZxZ823cN+bOJKEsHOUdzblXAJAFjL
         BR3KPB7JLaJLMwvdXpLvCkp/l17NKjHIemfzzqbANm2kS5N/LxagcLu/e7c40XJ/Rv
         7Vq/voV7C4sN4efMwSssmvzqUUMzzYvEyWWtl6d/BWLDGXGm7Ti6yORUDX2ndXcO78
         LswpuUvpcPvuQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qI8O6gStW31Y; Fri, 10 Mar 2023 14:21:25 +0100 (CET)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 114F960501;
        Fri, 10 Mar 2023 14:21:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678454485; bh=JXqGLzrX3FhQnp3vxNjiKMY/n5dMhP5F5mgTr9d2sIo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ttDLDfuVTpaNhTUeGbtD/3nAVDY+ZR0pYhmSmsqbKtOOaLwvWm0UEZeQEKwX7OJSU
         A+0Q2wHZhJwZ2FT0r83ouQ8t2pO5cw/zsEvGO3wUBAxp8P5muPwHFyZM4yzpU2p9Xh
         kLMkoQ+oU6wIweICP6TZJG50Gky4r2tY5DLHM1YbRA3rS7eif8S3l/DUS+tBnZclW6
         kKIaoepSno67D/bd6/zAxZhOI+AT2g1J0jb8wpyXUKPzBMT8oxPFqtwORogP7HVvNo
         Cii1HSYqKtmtkgoiFRIc59Jm8inuSmo0ss61h53BsAziaJHvJnDFpbu+qo8+9BC0la
         lPopz/7BUdn3g==
Message-ID: <83bebd97-ba44-9e19-d66c-95b43b123797@alu.unizg.hr>
Date:   Fri, 10 Mar 2023 14:21:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/1] devres: Pass unique name of the resource to
 devm_add_action()
Content-Language: en-US, hr
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
References: <20230224200745.17324-1-andriy.shevchenko@linux.intel.com>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230224200745.17324-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andy,

On 2/24/23 21:07, Andy Shevchenko wrote:
> Pass the unique name of the resource to devm_add_action(),
> so it will be easier to debug managed resources.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/base/devres.c  | 11 ++++++-----
>   include/linux/device.h |  5 ++++-
>   2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index c0e100074aa3..5c998cfac335 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -722,20 +722,21 @@ static void devm_action_release(struct device *dev, void *res)
>   }
>   
>   /**
> - * devm_add_action() - add a custom action to list of managed resources
> + * __devm_add_action() - add a custom action to list of managed resources
>    * @dev: Device that owns the action
>    * @action: Function that should be called
>    * @data: Pointer to data passed to @action implementation
> + * @name: Name of the resource (for debugging purposes)
>    *
>    * This adds a custom action to the list of managed resources so that
>    * it gets executed as part of standard resource unwinding.
>    */
> -int devm_add_action(struct device *dev, void (*action)(void *), void *data)
> +int __devm_add_action(struct device *dev, void (*action)(void *), void *data, const char *name)
>   {
>   	struct action_devres *devres;
>   
> -	devres = devres_alloc(devm_action_release,
> -			      sizeof(struct action_devres), GFP_KERNEL);
> +	devres = __devres_alloc_node(devm_action_release, sizeof(struct action_devres),
> +				     GFP_KERNEL, NUMA_NO_NODE, name);
>   	if (!devres)
>   		return -ENOMEM;
>   
> @@ -745,7 +746,7 @@ int devm_add_action(struct device *dev, void (*action)(void *), void *data)
>   	devres_add(dev, devres);
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(devm_add_action);
> +EXPORT_SYMBOL_GPL(__devm_add_action);
>   
>   /**
>    * devm_remove_action() - removes previously added custom action
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 1508e637bb26..5b9f3cb22f78 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -243,10 +243,13 @@ void __iomem *devm_of_iomap(struct device *dev,
>   			    resource_size_t *size);
>   
>   /* allows to add/remove a custom action to devres stack */
> -int devm_add_action(struct device *dev, void (*action)(void *), void *data);
>   void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
>   void devm_release_action(struct device *dev, void (*action)(void *), void *data);
>   
> +int __devm_add_action(struct device *dev, void (*action)(void *), void *data, const char *name);
> +#define devm_add_action(release, action, data) \
> +	__devm_add_action(release, action, data, #action)
> +
>   static inline int devm_add_action_or_reset(struct device *dev,
>   					   void (*action)(void *), void *data)
>   {

I have built last couple of kernels including 6.3-rc1+ w your patch.

(I'm late two weeks w testing, but those were rather busy two weeks.)

I see what it is meant to do, but I am unsure of how to test whether it works.

Being the unfaithful Thomas, I always prefer to test rather to just assume it
is OK.

Is this OK output you expected to see in syslog?

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

NOTE: Maybe I should emphasise that this is not seen in either dmesg or kernel console.

I have just checked, and DEVRES lines are only in /var/log/messages (on AlmaLinux 8.7, CentOS fork).

As you must have guessed yourself already, this will frustrate debugging past the lifetime of rsyslog process.

Also, there is no way known to me to access dmesg log from the previous kernel run.

Thanks,
Mirsad


-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
