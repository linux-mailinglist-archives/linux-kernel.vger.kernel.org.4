Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216186DB6D3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 01:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjDGXHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 19:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjDGXHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 19:07:14 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE593E068;
        Fri,  7 Apr 2023 16:07:00 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1842cddca49so89035fac.1;
        Fri, 07 Apr 2023 16:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680908820; x=1683500820;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vMcypocImtzxV7/I2Ii8yYYnZJvG/LB86W8XaeGMbZM=;
        b=lNtMX+r+lAJIRIONbfqfkdV6kfPHZTkpNge7zneGuDWyEbLDVDyOYoEZaDcZ9ROM7P
         dSXA5E3eLn3PgNaHdGCSyLzHsfGfnIRtHi7CNQGP4NNZ0GCp0ZSHK7OuKILbqHgBUE2g
         6tkdxkO/h4392GCiSryc3DXUNoRhqNviE+OcVPPjXYR5aXwKwYbJPvmliVm6bzqA6A2B
         lYMsGQZeQa1anMDlUsDndgNTJBugCkilBMl4sgcstwoMJrDSmssGYGoixan9Gv1Rk/1A
         jeTWKt2epVN1tMuqvnOAIj+1kpdFolWz8YMqi43AJiEzE9xMqklNTn/5ZBCQmJCM9bCZ
         f8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680908820; x=1683500820;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMcypocImtzxV7/I2Ii8yYYnZJvG/LB86W8XaeGMbZM=;
        b=y9MvvtsSc1wlVE3HHZuSdKqfdxHKKkvOG884erPSRT+voagGPV8QDQLjqeWbE5cVID
         2Ja1AUiKbvZO09O1N0vAFOO2t2p/WwtgfYqSVY/n1QaXI7ABnyJXlrSdl6UzyeaCxalL
         JUUgg3JXyhGGyGOC1wc/+JDYCGg0RobfpGCRSGedY+YkUBzJnROMLGReL3CvA+EN/bpu
         y5Op7fQqpLzrKrwqJpaT1SRzTZjxNlg8LoxQKpf8IhPG2jmuQ4l+UnZWcV1JzZZMVD1X
         cpu7xZlQkijPjIZpjqBBz8WCb7vFWVtpS9KFYuKmgz6JWzmx/fs/1LDtBItI3L7sXdG5
         t+wA==
X-Gm-Message-State: AAQBX9ffq7JTgVeRqBGDqtOkscxnxposkqqGZL/fMbtmBAdkU9xJdrLS
        VWT5POInBsoPqr74a5imVZU=
X-Google-Smtp-Source: AKy350ZgBrDZXUkcqk0CIhjDZHKhTFYqy3aPWIQ15+brMZvnFwl5rCmnj/wPY7aDg1O0jPsWUlX8bw==
X-Received: by 2002:a05:6870:e38c:b0:17a:c141:ffdc with SMTP id x12-20020a056870e38c00b0017ac141ffdcmr2213638oad.58.1680908820130;
        Fri, 07 Apr 2023 16:07:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 5-20020a4a0d05000000b0053b543b027bsm2069448oob.42.2023.04.07.16.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 16:06:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e356c168-5e60-70f9-9985-34a909d97b6b@roeck-us.net>
Date:   Fri, 7 Apr 2023 16:06:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ufs: hwmon: constify pointers to hwmon_channel_info
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
References: <20230407150137.79947-1-krzysztof.kozlowski@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230407150137.79947-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/23 08:01, Krzysztof Kozlowski wrote:
> Statically allocated array of pointed to hwmon_channel_info can be made
> const for safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> This depends on hwmon core patch:
> https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
> 
> Therefore I propose this should also go via hwmon tree.
> 

I am not going to apply patches for 10+ subsystems through the hwmon tree.
This can only result in chaos. The dependent patch is available at

git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-const

or wait until after the next commit window to apply this patch.

Thanks,
Guenter

> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> ---
>   drivers/ufs/core/ufs-hwmon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufs-hwmon.c b/drivers/ufs/core/ufs-hwmon.c
> index 4c6a872b7a7c..229e2ad70903 100644
> --- a/drivers/ufs/core/ufs-hwmon.c
> +++ b/drivers/ufs/core/ufs-hwmon.c
> @@ -146,7 +146,7 @@ static umode_t ufs_hwmon_is_visible(const void *_data, enum hwmon_sensor_types t
>   	return 0;
>   }
>   
> -static const struct hwmon_channel_info *ufs_hwmon_info[] = {
> +static const struct hwmon_channel_info * const ufs_hwmon_info[] = {
>   	HWMON_CHANNEL_INFO(temp, HWMON_T_ENABLE | HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LCRIT),
>   	NULL
>   };

