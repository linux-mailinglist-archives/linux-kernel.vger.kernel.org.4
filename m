Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6E063932E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 02:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiKZBqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 20:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKZBqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 20:46:44 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3CD450AC;
        Fri, 25 Nov 2022 17:46:43 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id a13-20020a9d6e8d000000b00668d65fc44fso3648140otr.9;
        Fri, 25 Nov 2022 17:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zSVu8IzWQnukYfrlr5/HsImCuo05xjm0CcfHLq4urLI=;
        b=RZC2Lxjfq7QI2Nc/9un0NKkTteBkrHjVjqKdAqOInw7u9Gsi7ro4i9TNGDxKyzNGMV
         ojewZguGFeqvzygkN0UCUKMRraJRWpd9fAoxV+HXoflyp9vm3oJKA0uN+VRRvCjIZiAh
         jpcGiTBLzmEDNs7+tZiPsDdDPiPZlqX1mHm5XhAkGfzacdy3NpvRcOLBs8I243x1FCMl
         TCunXaWytSvSFSxcQXDGv0djUBaHwPv1u58xLrGPON18haElE1epFLyTbs+o+A5WsPh1
         h1o07+OaJwQ24MxrkVCsH6CsRA4Gtceplk7/o0HCdGwp8bFTEG+P+WTqthsC30m+lMou
         29Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSVu8IzWQnukYfrlr5/HsImCuo05xjm0CcfHLq4urLI=;
        b=Wvn9ccLmHA+ceiH9s/7JbajxZMhewsQKYaDmfrXEyRs2qFVlczaYb4gJXv44Ura3+R
         jHLWMrN1uit1yxamHvnwNcNinIfogs5s2yq6E0DR2KpxrshJIskjJK+bYcksuN1IwFtL
         A/fvPOoWj3htlKHqoz9vfCMSb5a8cxCn87+mwn4rbX66mdLGLw8tPksGR2R3FLU+L+tY
         kEeGBq1UuorSHKUWy7fOIKAMesDZjMJowYkkbHJZCKbeWr09vFOmjEZ/xz8oyPkB61qz
         JTDGD2VzzqvKp/faCrQhbWlPUBC5MMx7tD4lQ053pt9DBOvWqn5pFCGUHxIuZ7wBoc1J
         bUWw==
X-Gm-Message-State: ANoB5pnzLupHI7/yViWKpfwrGj2kHJnVZtnRB7LPxoappLtJZ6TnF29Q
        z6DV2p/iQ1r4zYZMiI2HgXsiRTCRHyU=
X-Google-Smtp-Source: AA0mqf6m1IZqpqNKxu6eqLQBMxG/ut11WVzoaY1UoHXO1V99N2U4iXVaS7dxXZM2z7Xze6y7pdW0eg==
X-Received: by 2002:a05:6830:1e96:b0:66b:48e3:655a with SMTP id n22-20020a0568301e9600b0066b48e3655amr10595917otr.20.1669427202585;
        Fri, 25 Nov 2022 17:46:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g31-20020a056830309f00b0066cf6a14d1asm2344284ots.23.2022.11.25.17.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 17:46:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7c38ad68-49cb-0f8a-18a4-fa78f0429bdd@roeck-us.net>
Date:   Fri, 25 Nov 2022 17:46:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] watchdog: Report firmware_version in sysfs
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221125222315.4925-1-linux@weissschuh.net>
 <da94449e-d250-1b44-0e72-f951b73b1946@roeck-us.net>
 <ddd1ea7b-0be7-4c16-a5ac-56516f955ef9@t-8ch.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ddd1ea7b-0be7-4c16-a5ac-56516f955ef9@t-8ch.de>
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

On 11/25/22 17:00, Thomas Weißschuh wrote:
> On 2022-11-25 16:37-0800, Guenter Roeck wrote:
>> On 11/25/22 14:23, Thomas Weißschuh wrote:
>>> This synchronizes the information reported by ioctl and sysfs.
>>> The mismatch is confusing because "wdctl" from util-linux uses the ioctl
>>> when used with root privileges and sysfs without.
>>>
>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>>
>>> ---
>>>
>>> Userspace implementation:
>>>
>>> https://github.com/util-linux/util-linux/pull/1927
>>> ---
>>>    drivers/watchdog/watchdog_dev.c | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
>>> index 55574ed42504..88c76e27873c 100644
>>> --- a/drivers/watchdog/watchdog_dev.c
>>> +++ b/drivers/watchdog/watchdog_dev.c
>>> @@ -555,6 +555,15 @@ static ssize_t identity_show(struct device *dev, struct device_attribute *attr,
>>>    }
>>>    static DEVICE_ATTR_RO(identity);
>>> +static ssize_t firmware_version_show(struct device *dev, struct device_attribute *attr,
>>> +				     char *buf)
>>> +{
>>> +	struct watchdog_device *wdd = dev_get_drvdata(dev);
>>> +
>>> +	return sysfs_emit(buf, "%d\n", wdd->info->firmware_version);
>>> +}
>>> +static DEVICE_ATTR_RO(firmware_version);
>>> +
>>>    static ssize_t state_show(struct device *dev, struct device_attribute *attr,
>>>    				char *buf)
>>>    {
>>> @@ -618,6 +627,7 @@ static umode_t wdt_is_visible(struct kobject *kobj, struct attribute *attr,
>>>    static struct attribute *wdt_attrs[] = {
>>>    	&dev_attr_state.attr,
>>>    	&dev_attr_identity.attr,
>>> +	&dev_attr_firmware_version.attr,
>>>    	&dev_attr_timeout.attr,
>>>    	&dev_attr_min_timeout.attr,
>>>    	&dev_attr_max_timeout.attr,
>>>
>>> base-commit: 0b1dcc2cf55ae6523c6fbd0d741b3ac28c9f4536
>>
>> I think this conflicts with drivers/watchdog/ziirave_wdt.c which generates its own
>> firmnware_version attribute.
> 
> Indeed, thanks for the catch.
> 
> We probably can't change the attribute from ziirave_wdt, which is a bit
> unfortunate as "firmware_version" would nicely match the name from
> "struct watchdog_info".
> 
> How about "fw_version"?
> 

I don't have a better idea. Go for it.

Guenter

> That would match the naming of sysfs attributes from a bunch of other
> subsystems.
> 
> And obviously an addition to Documentation/ABI/testing/sysfs-class-watchdog is
> also missing from the patch.
> I'll add it in v2.
> 
> Thomas

