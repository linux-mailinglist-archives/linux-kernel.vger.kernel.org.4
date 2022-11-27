Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B973639BD3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 17:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiK0QrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 11:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiK0QrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 11:47:19 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D52EC753;
        Sun, 27 Nov 2022 08:47:15 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id p8-20020a056830130800b0066bb73cf3bcso5567853otq.11;
        Sun, 27 Nov 2022 08:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iE9KpvJeEjAEaRRMLe+BGcMh0qDAxQXpNpPsoGP8NLY=;
        b=X4AzXWO3bxIFdD3RSMo+uPE4z7dW7Yz0nMXDzaTxCkVg+PoZe0bjk2xjFa5xvoBdMF
         QgWckBvWEkpPMGorR0ZmHWPuyqxsv6XatCqNtKUL510MS9ez8ruUJCMmuYnjbSs/xXut
         tYYQDdHsoCTvnJQulDempwRl2Mag+qmup9R1JdjVd+6CYNx91pGIvlXd9NdSSh9SaGgP
         qzId+p34F5ceqn6ZauqfmH1NUXUHi8yOEBNU0h2HgNKCk5XXVebk3QXTx8RZ7Rf/WXqU
         NtJlnAgpmxAGtvUoS0Q+wIPmku4QNmvijkDiLyfvYFipxffR4yIWUnxWZxYcJCPkjYxg
         4foQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iE9KpvJeEjAEaRRMLe+BGcMh0qDAxQXpNpPsoGP8NLY=;
        b=E7yGU14XDpC7oH7Ad/O3wuHTORc3vqGNUMaAIr8mo8pTbXOnNzk/oriirX1YFjmZpl
         euOxpl1MQesMixCEzoT1JhN0so2Bmegy3K5T/d4z5eXg8b3iN+nVPhQaZHraXj4EB1kW
         026tc5wlnHEvMhGR3cdZQEIZX+0zo0RFS0E8Oe3e3Q+7RN82ncINy3mUS/nr12gD5XTa
         jkSbveYGIfs6JA6lW9wG2o4yKHGCh+IuO53VxbtgpaXjB/deSaKj6nsaECFwWtzi26To
         tPJ4WJyc5t5Xw42QA+L9EjytIvUoQeMjaczR1mBlHjymc2/xBReG89F4VxBjIkm4jWue
         E2Ng==
X-Gm-Message-State: ANoB5pm4mYVhyq32avmJEuBRj4Zcs8hudfdlN3s2gWJm83TuuXUrh9H5
        NfTPjWTzy95WELtSLY/oTFb2I6FlMyo=
X-Google-Smtp-Source: AA0mqf5mawdsAmlF2ZYFNf15DbKp6j9WA231BswzORXWWFEl+5f4r1n65xkBNyUv4Xdllq76NbJuMQ==
X-Received: by 2002:a9d:470e:0:b0:66c:5758:4a4d with SMTP id a14-20020a9d470e000000b0066c57584a4dmr23698686otf.337.1669567634459;
        Sun, 27 Nov 2022 08:47:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bu7-20020a0568300d0700b0066871c3adb3sm3888942otb.28.2022.11.27.08.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 08:47:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6ee65abe-8620-956d-a4a2-4ec5ec6257a5@roeck-us.net>
Date:   Sun, 27 Nov 2022 08:47:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221127154559.80899-1-linux@weissschuh.net>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH] watchdog: core: don't reset KEEPALIVEPING through
 sysfs
In-Reply-To: <20221127154559.80899-1-linux@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/22 07:45, Thomas Weißschuh wrote:
> Reading the watchdog status via ioctl(WDIOC_GETSTATUS) or sysfs will
> reset the status bit KEEPALIVEPING.
> 
> This is done so an application can validate that the watchdog was pinged
> since the last read of the status.
> 
> For the ioctl-based interface this is fine as only one application can
> manage a watchdog interface at a time, so it can properly handle this
> implicit state modification.
> 
> The sysfs "status" file however is world-readable. This means that the
> watchdog state can be modified by any other unprivileged process on the
> system.
> 
> As the sysfs interface can also not be used to set this bit, let's
> remove the capability to clear it.
> 
> Fixes: 90b826f17a4e ("watchdog: Implement status function in watchdog core")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> ---
> 
> I was not able to find an application (besides wdctl) that uses this
> bit. But if applications are to use it, it should probably be reliable.
> 
> Other possible solutions I can think of:
> * Only reset the bit when the file opened privileged
> * Only reset the bit when the file opened writable
> 

All suggested solutions would be changing the ABI, which would be problematic.

As you have proposed elsewhere, it is possible for applications to chose where
to get the status from: sysfs or ioctl. It may well be that there is some
application out there which uses the sysfs attribute to read the status
and the ioctl otherwise. That would be odd, but possible.

Also, I can not imagine a real world use except for maybe reading the status
bit using sysfs from one application and checking if the watchdog demon actually
pinged it as it should ... but that is exactly what you are trying to disable
here.

Overall, this is probably the least valuable status bit. Any application should
know if it pinged the watchdog or not.

So: What real world problem have you observed that you are trying to solve ?
If there is no real observed problem, we should not entertain changing the ABI.
Actually, we can not change the ABI We would have to add another non-invasive
attribute that doesn't change the status when read. That should really be
worth the trouble.

Guenter

> Instead of using a status bit to check if the watchdog was pinged it
> would probably be more robust to use a sequence counter or timestamp.
> Especially as it seems more operations are being exposed over sysfs over
> time.
> 
> I'm not sure it's worth it though.
> ---
>   Documentation/ABI/testing/sysfs-class-watchdog |  3 ++-
>   drivers/watchdog/watchdog_dev.c                | 13 +++++++++----
>   2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-watchdog b/Documentation/ABI/testing/sysfs-class-watchdog
> index 585caecda3a5..182a8a9e530e 100644
> --- a/Documentation/ABI/testing/sysfs-class-watchdog
> +++ b/Documentation/ABI/testing/sysfs-class-watchdog
> @@ -38,7 +38,8 @@ Contact:	Wim Van Sebroeck <wim@iguana.be>
>   Description:
>   		It is a read only file. It contains watchdog device's
>   		internal status bits. It is equivalent to WDIOC_GETSTATUS
> -		of ioctl interface.
> +		of ioctl interface, except that the status bit
> +		WDIOF_KEEPALIVEPING is not reset.
>   
>   What:		/sys/class/watchdog/watchdogn/timeleft
>   Date:		August 2015
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 55574ed42504..7e3e964c4d6f 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -320,13 +320,15 @@ static int watchdog_stop(struct watchdog_device *wdd)
>   /*
>    * watchdog_get_status - wrapper to get the watchdog status
>    * @wdd: The watchdog device to get the status from
> + * @reset_keepaliveping: Reset the status bit _WDOG_KEEPALIVE
>    *
>    * Get the watchdog's status flags.
>    * The caller must hold wd_data->lock.
>    *
>    * Return: watchdog's status flags.
>    */
> -static unsigned int watchdog_get_status(struct watchdog_device *wdd)
> +static unsigned int watchdog_get_status(struct watchdog_device *wdd,
> +					bool reset_keepaliveping)
>   {
>   	struct watchdog_core_data *wd_data = wdd->wd_data;
>   	unsigned int status;
> @@ -345,9 +347,12 @@ static unsigned int watchdog_get_status(struct watchdog_device *wdd)
>   	if (test_bit(_WDOG_ALLOW_RELEASE, &wd_data->status))
>   		status |= WDIOF_MAGICCLOSE;
>   
> -	if (test_and_clear_bit(_WDOG_KEEPALIVE, &wd_data->status))
> +	if (test_bit(_WDOG_KEEPALIVE, &wd_data->status))
>   		status |= WDIOF_KEEPALIVEPING;
>   
> +	if (reset_keepaliveping)
> +		clear_bit(_WDOG_KEEPALIVE, &wd_data->status);
> +
>   	if (IS_ENABLED(CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT))
>   		status |= WDIOF_PRETIMEOUT;
>   
> @@ -476,7 +481,7 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
>   	unsigned int status;
>   
>   	mutex_lock(&wd_data->lock);
> -	status = watchdog_get_status(wdd);
> +	status = watchdog_get_status(wdd, false);
>   	mutex_unlock(&wd_data->lock);
>   
>   	return sysfs_emit(buf, "0x%x\n", status);
> @@ -753,7 +758,7 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
>   			sizeof(struct watchdog_info)) ? -EFAULT : 0;
>   		break;
>   	case WDIOC_GETSTATUS:
> -		val = watchdog_get_status(wdd);
> +		val = watchdog_get_status(wdd, true);
>   		err = put_user(val, p);
>   		break;
>   	case WDIOC_GETBOOTSTATUS:
> 
> base-commit: faf68e3523c21d07c5f7fdabd0daf6301ff8db3f

