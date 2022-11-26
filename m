Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215276392D0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiKZAhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiKZAhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:37:11 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E235532C0;
        Fri, 25 Nov 2022 16:37:10 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id n186so5962696oih.7;
        Fri, 25 Nov 2022 16:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iCaceALPA+uyA4RelrcFIgJlb1OAS9i7cU+UvZ4U5QI=;
        b=JquloSc6fcBDkCLspdkg8gDuh+iY4YIS+sjEkuTNBCsZJ6gtbGcaY6RzZgAibXEA93
         aP4bPvblwbVNvSA8t7qikKV0pBTtoIe1v9TPQtxy88gbF/JYFu6B8gMWniwUZWx4bTT+
         0NNNbhtdOlKgISunELmbFpUUWSjyj9pfabZ9v1I+wiPFONV0EoIiQiddkqbbnS+xZK2q
         vW+luBmeAZchEk1wjDrPViA7Vxc1sQ8nNCcHli+B8CictjAv7A3LNjxgCHLoSrZjcbOJ
         yc+yKOFWIL8RX3YEBv48Ey+wOue4ahX6VYMOSTc9D9kj2Mmkebq5wmQLeGBNHVew9h32
         UuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCaceALPA+uyA4RelrcFIgJlb1OAS9i7cU+UvZ4U5QI=;
        b=2ubccQ/O485KgY3pG5LK7Lj3LJfwF7WEc3sKrx82EWb0DGl/P7Ebs6NhYemQgkBpUo
         1otB9RuNNHYaJftmAJ4LNilQUl9SaKMj5y9V/ZXc5kBi57q3N4xLzSRAkREHRZVplUU5
         26dyKJ6AHHniffbPoFTSdLiXJp4+6mnO7lzscE77yPxe9WjNEksHJHltclMIRrrMPvgS
         VQzQeiL8KBeqmN8GQWQ8lUw4tvgmsBSG3WspuwKUaQ7ZOu/7Az4/RZpUX1w/hZlIiKXx
         PUFPCjYFXOL3Cm8BDNSRLpdqReynERGIj9nic+Yzl8x6khAlF5pyHUr6bwToU4exnNlZ
         s3zQ==
X-Gm-Message-State: ANoB5pkGcQIcTBajqh6M8/kPjeOEdT9o+yriDD/auQn6fu49/aR4XuxT
        BMeTj+neisQ/uvXOBVqgXdQ=
X-Google-Smtp-Source: AA0mqf61YkUoqoMShkN+ok/V8H/76imG1oQQQoU5KyEhPCrBshIb6M0bBqYHVkpuOGHilBK9QCtypQ==
X-Received: by 2002:a05:6808:152c:b0:354:da02:c05f with SMTP id u44-20020a056808152c00b00354da02c05fmr10105211oiw.290.1669423029686;
        Fri, 25 Nov 2022 16:37:09 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v71-20020acaac4a000000b0035418324b78sm2042330oie.11.2022.11.25.16.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 16:37:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <da94449e-d250-1b44-0e72-f951b73b1946@roeck-us.net>
Date:   Fri, 25 Nov 2022 16:37:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] watchdog: Report firmware_version in sysfs
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221125222315.4925-1-linux@weissschuh.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221125222315.4925-1-linux@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/22 14:23, Thomas Weißschuh wrote:
> This synchronizes the information reported by ioctl and sysfs.
> The mismatch is confusing because "wdctl" from util-linux uses the ioctl
> when used with root privileges and sysfs without.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> ---
> 
> Userspace implementation:
> 
> https://github.com/util-linux/util-linux/pull/1927
> ---
>   drivers/watchdog/watchdog_dev.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 55574ed42504..88c76e27873c 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -555,6 +555,15 @@ static ssize_t identity_show(struct device *dev, struct device_attribute *attr,
>   }
>   static DEVICE_ATTR_RO(identity);
>   
> +static ssize_t firmware_version_show(struct device *dev, struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct watchdog_device *wdd = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", wdd->info->firmware_version);
> +}
> +static DEVICE_ATTR_RO(firmware_version);
> +
>   static ssize_t state_show(struct device *dev, struct device_attribute *attr,
>   				char *buf)
>   {
> @@ -618,6 +627,7 @@ static umode_t wdt_is_visible(struct kobject *kobj, struct attribute *attr,
>   static struct attribute *wdt_attrs[] = {
>   	&dev_attr_state.attr,
>   	&dev_attr_identity.attr,
> +	&dev_attr_firmware_version.attr,
>   	&dev_attr_timeout.attr,
>   	&dev_attr_min_timeout.attr,
>   	&dev_attr_max_timeout.attr,
> 
> base-commit: 0b1dcc2cf55ae6523c6fbd0d741b3ac28c9f4536

I think this conflicts with drivers/watchdog/ziirave_wdt.c which generates its own
firmnware_version attribute.

Guenter

