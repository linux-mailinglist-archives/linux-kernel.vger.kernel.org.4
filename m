Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02545639B7A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 16:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiK0PB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 10:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiK0PBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 10:01:55 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9F7F5BF;
        Sun, 27 Nov 2022 07:01:51 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-14279410bf4so10362089fac.8;
        Sun, 27 Nov 2022 07:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=T1gR/seHUMb9PSx4Pa55lmn5LTDZiyjov4uQ+3anCp0=;
        b=JZI6No2hJG88G8Y1lJbIfK5fat6gphCrXyljlK59186mYUHvDEDxJzR6/nT9sy+tYj
         PfSXihZRvJBEggYsHX6XgaJPF10bUhfwjYJ4qMg/CBs9NRdFs9OzQnEYkblwvMj2/d3i
         sdpWdRDh6FmEVoYu+COClY+ZhIKbnGWQ2+bZV0BQnmrUX31Ota2joZYp0OW/8QVY60mb
         iCusRBJqdya9C25E+JfzbQbyJNsjlwbX3fa9oPnBcC4Oyqfdye0lj+iytqJROPchwyqb
         QFEiwtJGKz1IwVxb38NNP/FYcqZJ/nQLfLEoGSEgxZ0hG7xgxOFGyotBAYL3qSdU0lVC
         paDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T1gR/seHUMb9PSx4Pa55lmn5LTDZiyjov4uQ+3anCp0=;
        b=C/S2dxAJOuWC4Uajns3STPgIZe4+8oNdlKMqN64yuerFhNN2IeHHsEqoEFif54Y/zM
         82377/JWs8IbU8oapPpFZuz/15NdoxdLajNkZcmsPNVF5A9I6Pjn7Fwf7izOE5wM7V49
         aAETNYf7ARuzsvNj3GjHrYFLq1pvocP0WvApTXuDO6/zFH/UsxulxCO3D2M94Z7QUkWJ
         onzS0qLlg42ip83D5QWp4u7v7am2bdxdMKrMpOZ25VMnEP/SIS4iOlOP4aCzqDnSK4Cz
         jOLoM9B17syOZIkmgPJrApc/n6jPv6ujwFr9cRbmfXjTUd48eHwAxj4C/FMa1IucEKge
         +SKw==
X-Gm-Message-State: ANoB5pnK+9+Cdv3W3lkG0atICiBIVsq8D/KfrDizt3Eg7raPyoHBs46I
        tdqr0lIvIqJyTuxcK/oVVE0=
X-Google-Smtp-Source: AA0mqf7I0yxRPOHKdhNXaaYmXSC6xFadCu26Sat25jRhcuZGlvooff4WK8nmR+96/QWK61h+Un9XKg==
X-Received: by 2002:a05:6870:6a92:b0:136:6256:a207 with SMTP id mv18-20020a0568706a9200b001366256a207mr25902292oab.154.1669561309413;
        Sun, 27 Nov 2022 07:01:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r19-20020a056870581300b001438e8f097asm1913420oap.58.2022.11.27.07.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 07:01:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e3017eda-3764-4ff0-71fc-0f33f5ad8085@roeck-us.net>
Date:   Sun, 27 Nov 2022 07:01:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] hwmon: (hih6130) Modify mismatched function name
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20221127134351.87394-1-jiapeng.chong@linux.alibaba.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221127134351.87394-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/27/22 05:43, Jiapeng Chong wrote:
> No functional modification involved.
> 
> drivers/hwmon/hih6130.c:185: warning: expecting prototype for hih6130_show_humidity(). Prototype was for hih6130_humidity_show() instead.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3264
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

NACK. We don't start changing function names because some robot
thinks we should. Please do not submit such patches against the hwmon
or watchdog subsystems.

Guenter

> ---
>   drivers/hwmon/hih6130.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/hih6130.c b/drivers/hwmon/hih6130.c
> index d9394e19fea8..764e6e185d98 100644
> --- a/drivers/hwmon/hih6130.c
> +++ b/drivers/hwmon/hih6130.c
> @@ -172,7 +172,7 @@ static ssize_t hih6130_temperature_show(struct device *dev,
>   }
>   
>   /**
> - * hih6130_show_humidity() - show humidity measurement value in sysfs
> + * hih6130_humidity_show() - show humidity measurement value in sysfs
>    * @dev: device
>    * @attr: device attribute
>    * @buf: sysfs buffer (PAGE_SIZE) where measurement values are written to

