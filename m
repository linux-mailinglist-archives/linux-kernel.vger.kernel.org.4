Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF3B5FBEDC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 03:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiJLBfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 21:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJLBfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 21:35:18 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD03F5AC52;
        Tue, 11 Oct 2022 18:35:16 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e129so14264921pgc.9;
        Tue, 11 Oct 2022 18:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iv50hxDOHDOsgzOAMRq0QBK53acG/P2BUJFVAKGAT4o=;
        b=RNhHYy1UfHXMhd5n5YAnce/Zp70WW6q9uoBYfQrhK1zu9MvI4ebhewW12jIx0SNz9R
         +M/xG/u16A0yXJSmO++vuRMShouqpRwgJOjTcOggxIcoRgP8wpibOSPkZYuAw1Y0s91C
         rMatDckiihko0xHYquALUnmLv0//XTalaueU/gKb1Ggv1gxUVgeN1yscEVyKD8BI/WR+
         RKi/tKIcrtKwSPejHtInDDJyDW+7knAAdIwF6a5ynYuwL/lcwjChvqLMRHpqhWUHSRMR
         6AQtJuBLhwQZliEoD1oZ3dR/SjzpEB9pGmXrztHEezssfs3UOIUxxSJ/TLRNjq3CCbHj
         rYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iv50hxDOHDOsgzOAMRq0QBK53acG/P2BUJFVAKGAT4o=;
        b=2oBJmjWY5crixx91qgfimIR5g3ef6FEhTD7nT8Qyfc7aJ7xb9k7nSj/eLFOHcek/5p
         /WrNV5s09EPGMDk6XJHi2ZZM1vbqyCEoMHMXJnI1w/KplXf3cn0roXFSwP3g1o09eNRD
         VyNc4t7DDSIhmUEDFPWTHtqL7TkRwAmzDUj1iJThTTyCElj6s2xzyjfZocjh/kIHzRr8
         KBgJ3a4uQE+5MPEycwVcqAjIoJ2l9QcItMmodTq2oe0KF3+7kVrj8WBiJG6xfMseVz3g
         38F9gEMxj7m7CG9q3reyikpAU+amETUaKB6bziep/Pupe/XAmEx6hrd6hYHPxb8KflvH
         xMmg==
X-Gm-Message-State: ACrzQf0VnD0BI16Uy+GfydldzjcNcMF/PP3p3ecSe7SulPAmsNR0a5qC
        0fVoId0ADEfQrUqUZf9tozo=
X-Google-Smtp-Source: AMsMyM5oBIu8PXuIxBRmKnnpErAVdRzStgCkrL1aBvmTfHnz+x+lClsxCe5ZnkYRl0jp9GK59mOp6Q==
X-Received: by 2002:a05:6a00:1781:b0:561:7f7f:dc38 with SMTP id s1-20020a056a00178100b005617f7fdc38mr28362340pfg.42.1665538516114;
        Tue, 11 Oct 2022 18:35:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w10-20020a62820a000000b0052dfe83e19csm9986097pfd.16.2022.10.11.18.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 18:35:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <085e90e5-d21e-9068-a2e1-6f7e07fa64df@roeck-us.net>
Date:   Tue, 11 Oct 2022 18:35:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     karthik gengan <gengankarthik@gmail.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAAboHLVgQKzNVU6XDWGZmnxGK0DGvtgyzMsY9V+UiOJVq1JyTg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] [v1 1/1]hwmon:(pmbus) Validate the data for chip
 supporting vout_mode (PMBUS_HAVE_VOUT) in the linear config.
In-Reply-To: <CAAboHLVgQKzNVU6XDWGZmnxGK0DGvtgyzMsY9V+UiOJVq1JyTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/22 16:59, karthik gengan wrote:
> Linear mode config calculation is based on the exponent value
> derived from vout_mode. So vout_mode value should be valid
> for PMBUS_VOUT_MODE command-supported chips.
> 

We can not do this. The operational word is "should". See comment
below "Not all chips support the VOUT_MODE command". It is what it is.
We can not just refuse to support such chips because they don't
support what we expect them to support.

Sure, those chips will (likely) report wrong values since the
exponent will default to 0. That can be adjusted in user space,
or whoever finds such a chip can provide a back-end driver
with the appropriate values configured (for example by providing
a dummy VOUT_MODE command response). That is better than just
rejecting the chip entirely.

 From a practical perspective, if you know about an affected chip
one that would refuse to instantiate after your patch is applied,
I would suggest to submit (or improve) a back-end driver with
an explanation instead.

Thanks,
Guenter

> Signed-off-by: karthik.gengan <gengankarthik@gmail.com <mailto:gengankarthik@gmail.com>>
> ---
>   drivers/hwmon/pmbus/pmbus_core.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 7ec04934747e..5f80c3b8f245 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2507,9 +2507,17 @@ static int pmbus_identify_common(struct i2c_client *client,
>   {
>      int vout_mode = -1;
> 
> -   if (pmbus_check_byte_register(client, page, PMBUS_VOUT_MODE))
> +   if (pmbus_check_byte_register(client, page, PMBUS_VOUT_MODE)) {
>          vout_mode = _pmbus_read_byte_data(client, page,
>                            PMBUS_VOUT_MODE);
> +       /*
> +        * If the client page supports PMBUS_VOUT_MODE,
> +        * then the output of the VOUT_MODE command should
> +        * be a valid value for linear mode calculation.
> +        */
> +       if ((data->info->format[PSC_VOLTAGE_OUT] == linear) && (vout_mode < 0))
> +           return -ENODEV;
> +   }
>      if (vout_mode >= 0 && vout_mode != 0xff) {
>          /*
>           * Not all chips support the VOUT_MODE command,
> --
> 2.25.1
> 


