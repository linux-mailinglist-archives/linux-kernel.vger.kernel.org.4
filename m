Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838A26BD0B3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCPNWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCPNWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:22:45 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF2A40DF;
        Thu, 16 Mar 2023 06:22:44 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id w4so992865ilv.0;
        Thu, 16 Mar 2023 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678972963;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S5sSFUdtd3cNMo0njsQgepng/82qKfEU010rAD5k6+g=;
        b=Y3roQCLfCL34Z0TphtG+It8ee10Casj6FOGbxX3W2opRCasdLV3LXb7ywjfNXp1rM9
         SgVM78EpswonMEAiiIdoNsHgx8fVoJ17NS+1B5cNejuQUIJfPQFjUdpgSb9GLpqhJEYn
         iuiTl/Bs8SLCjNDRRKKebqK5a4OkItQQkF6bWdHoY9iGyPaK3G8+nnDVP+pwtkyNoanH
         Zlyn4+gxLfBk9KKv1r7BHmnbUTcVuZSIAzNfXvRUvUu7ry8zSgWHuJX2Sjnn0R4QIMJ0
         AGh5dpj0EIQarNZqZbQ5DIghY5GI8NJ48c3iW6WEjDbMME7DWvzr8J7x7JoByDzssrGh
         /Fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678972963;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5sSFUdtd3cNMo0njsQgepng/82qKfEU010rAD5k6+g=;
        b=6iK+0avr0UFy7tPQ2+Ow4Iv4gEVhQMhB7BWeCD8026swAA2sQq7VxnCCWgZ+C17Z3q
         iUdJSGhxoc24WaGUiKzWP9e3fmbiXpTXBdBF1BMHCT5PgFwdoy451X81YMix396HobVN
         RZFUU/sHYAhYLDqA02lUqex7ROsnZx+F9zYmBPZ2EZ5sfgz4HLkEhe8prQmqUQ19EypZ
         HSoHuGunWYR72ZHknWST/fkRTsL2JFLvjHjqMnFacqjumbVsbc3qucSClCfyHmCYwHYS
         wIY4ysRohjxMjE1siEFA/1MoJycPJCSexmOAFiBYDykJer8J2bf3FTucxA4eV6/1cUHU
         RAeg==
X-Gm-Message-State: AO0yUKXvfPzixRNi+SrjVkdEWB3Yc6J+kKUPwogvXvuH3H+0vFk3AB67
        PlD91hBhUM0BSvXxTWdGaw0=
X-Google-Smtp-Source: AK7set9ND98+MbdCQiDruAvYEZvnrPsWmOuVfhhQAM/wtm0CL5nKjv9BUw34wcR8ItKsK0tYWu8cFA==
X-Received: by 2002:a05:6e02:1c2e:b0:316:e54a:82a3 with SMTP id m14-20020a056e021c2e00b00316e54a82a3mr8870626ilh.30.1678972963473;
        Thu, 16 Mar 2023 06:22:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u27-20020a02cbdb000000b00402e2521635sm2476164jaq.163.2023.03.16.06.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 06:22:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8c835412-f78f-570d-30a5-24f4c02a8438@roeck-us.net>
Date:   Thu, 16 Mar 2023 06:22:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Phinex Hung <phinex@realtek.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230315121606.GA71707@threadripper>
 <8dbed631-62b6-1802-8f4e-7141b1a91a56@roeck-us.net>
 <D23B9D06-0DEA-4E3B-A64C-C928CAF2FEF8@realtek.com>
 <aaf0553c-48de-580f-70d5-aafeecb19e16@roeck-us.net>
 <1E8784A0-713E-41A8-A26D-72869E3E5779@realtek.com>
 <5c805125-4cb5-cdf8-6b50-5a6ce7e97149@roeck-us.net>
 <2686E7B8-BD3F-4C86-97B6-447343BFCF22@realtek.com>
 <A6DF8FB3-6318-40CD-A364-603A3E581511@realtek.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1] hwmon: drivetemp: support to be a platform driver for
 thermal_of
In-Reply-To: <A6DF8FB3-6318-40CD-A364-603A3E581511@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/23 00:48, Phinex Hung wrote:
> 
> 
> ﻿On 3/16/23 15:35 "Phinex Hung" <phinex@realtek.com <mailto:phinex@realtek.com> wrote:
> 
>> Not sure whether this is the difference, but use the following patch can solve this issue.
> 
>> @@ -540,9 +531,9 @@ static int drivetemp_add(struct device *dev, struct class_interface *intf)
>> goto abort;
>> }
>>
>>
>> - st->hwdev = hwmon_device_register_with_info(dev->parent, "drivetemp",
>> - st, &drivetemp_chip_info,
>> - NULL);
>> + st->hwdev = hwmon_device_register_with_info(
>> + dev->parent->parent->parent->parent->parent, "drivetemp", st,
>> + &drivetemp_chip_info, NULL);
> 
> 
> A more generic patch works in my case, listed below:
> 
> diff --git a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
> index 1cf4f9015316..a4cddfea8d22 100644
> --- a/drivers/hwmon/drivetemp.c
> +++ b/drivers/hwmon/drivetemp.c
> @@ -525,6 +525,7 @@ static int drivetemp_add(struct device *dev, struct class_interface *intf)
>   {
>          struct scsi_device *sdev = to_scsi_device(dev->parent);
>          struct drivetemp_data *st;
> +       struct device *tdev = dev->parent;
>          int err;
> 
>          st = kzalloc(sizeof(*st), GFP_KERNEL);
> @@ -540,8 +541,11 @@ static int drivetemp_add(struct device *dev, struct class_interface *intf)
>                  goto abort;
>          }
> 
> -       st->hwdev = hwmon_device_register_with_info(dev->parent, "drivetemp",
> -                                                   st, &drivetemp_chip_info,
> +       while(!tdev->of_node)
> +               tdev = tdev->parent;
> +

That needs to be in the hwmon core. We can not change the device pointer
passed to hwmon_device_register_with_info() because that determines the
lifetime of the hwmon device.

Guenter

> +       st->hwdev = hwmon_device_register_with_info(tdev, "drivetemp", st,
> +                                                   &drivetemp_chip_info,
>                                                      NULL);
>          if (IS_ERR(st->hwdev)) {
>                  err = PTR_ERR(st->hwdev);
> 
> Thanks
> 
> Regards,
> Phinex
> 
> 
> 
> 

