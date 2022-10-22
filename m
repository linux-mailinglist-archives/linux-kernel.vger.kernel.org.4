Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57D0608411
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 06:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJVECm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 00:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJVECk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 00:02:40 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2524B98A;
        Fri, 21 Oct 2022 21:02:39 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1321a1e94b3so5965954fac.1;
        Fri, 21 Oct 2022 21:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4xWdk81FEXsVhjbOXfb7yz/8N7pwijlgdzi/aQ2AJlA=;
        b=VuL7NaxQeuWEIcG9inA2o8PdRCds/3H8UMU+7s8SVjDmPK1zaj+3wXQw75vhpuM2bR
         kAKyS6MbyBHFEr81AEtmSGCLvg01aS7Sh0ORIEda7PmXwIbCgNsDju8oJiAi3iKrtTU5
         pxtNm/fEgOWdkCN/ro6IF4QTC7eNbvJAMRWH8Wx07X4juazqPlObD4/O8IQiVB2bwyTe
         iuYbwtp6TSmjwBImm1/bYUcFlh7k21oCqWICCs5XiCXbYrbulZY+DhU7e5a3/P3n9fV4
         CJcgqSktpuCkIQXB9og/sOcrOoomd54EpZmpDFmjX58otNDur2EtwObgmzFSeoNkZbvR
         4TRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xWdk81FEXsVhjbOXfb7yz/8N7pwijlgdzi/aQ2AJlA=;
        b=KbprJhV+Kj3hoG21ocUAVrUbl1KhnU/q9w/Prp7nLhgM4X25JAfEOT2NBagNsDUxXJ
         7snTI2r7RGfjHlTvyaKGOW0qgwdoRYhUFQ7aqm3gMDTHDL40fBCbrFLl4OsoSVDcvn6F
         8+WYn42gVRYvjea95qneMvIs17sFqXUcdcIqE/jgef6vSsO63X4Pn2CytH1ASJs1JcQN
         m1ssR9jsoiZCTdA3SGDxtaFNogI/iNDyZy3VwxBMXwa5y8rJIiBwk+3xCphvRS5YFoKq
         v+lDhShmd8q4fFFiqSmSDXd8GhAI4JuPc0hy5igx/w7JvVe5WtwFJ/Y+oulkRqHoeq9c
         W3WQ==
X-Gm-Message-State: ACrzQf2kSQfZrwUZgGN0aSp9wWD8YDz4WRJAXtVCpo0Wl5tD5+FLA4Ax
        4NV0pszeFSyrbJDaqnAkJu461SlGzWM=
X-Google-Smtp-Source: AMsMyM4eUvHArFQu2nMlTdTF/jpl91Qt7+tsHWplzsPA2q0SYRXejIa8NVh5KC+vN4+z3byUpQLr1w==
X-Received: by 2002:a05:6870:580c:b0:12a:f136:a8f5 with SMTP id r12-20020a056870580c00b0012af136a8f5mr31079144oap.269.1666411358624;
        Fri, 21 Oct 2022 21:02:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f17-20020a4ae611000000b00480b7efd5d9sm8420329oot.6.2022.10.21.21.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 21:02:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3644e7cb-4a1e-b78b-5ac6-594590190a20@roeck-us.net>
Date:   Fri, 21 Oct 2022 21:02:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 08/21] hwmon: remove s3c driver
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-8-arnd@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221021203329.4143397-8-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/21/22 13:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The s3c adc driver was removed along with the s3c24xx platform, so the
> hwmon driver is orphaned and can be removed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Guenter Roeck <linux@roeck-us.net>

I assume you plan to push the series together. If not, please let me know.

Guenter

> ---
>   drivers/hwmon/Kconfig     |  17 --
>   drivers/hwmon/Makefile    |   1 -
>   drivers/hwmon/s3c-hwmon.c | 379 --------------------------------------
>   3 files changed, 397 deletions(-)
>   delete mode 100644 drivers/hwmon/s3c-hwmon.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 7ac3daaf59ce..c98a068b5be2 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1729,23 +1729,6 @@ config SENSORS_SHTC1
>   	  This driver can also be built as a module. If so, the module
>   	  will be called shtc1.
>   
> -config SENSORS_S3C
> -	tristate "Samsung built-in ADC"
> -	depends on S3C_ADC
> -	help
> -	  If you say yes here you get support for the on-board ADCs of
> -	  the Samsung S3C24XX, S3C64XX and other series of SoC
> -
> -	  This driver can also be built as a module. If so, the module
> -	  will be called s3c-hwmon.
> -
> -config SENSORS_S3C_RAW
> -	bool "Include raw channel attributes in sysfs"
> -	depends on SENSORS_S3C
> -	help
> -	  Say Y here if you want to include raw copies of all the ADC
> -	  channels in sysfs.
> -
>   config SENSORS_SIS5595
>   	tristate "Silicon Integrated Systems Corp. SiS5595"
>   	depends on PCI
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 11d076cad8a2..b5a401ce3285 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -173,7 +173,6 @@ obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
>   obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
>   obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
>   obj-$(CONFIG_SENSORS_RASPBERRYPI_HWMON)	+= raspberrypi-hwmon.o
> -obj-$(CONFIG_SENSORS_S3C)	+= s3c-hwmon.o
>   obj-$(CONFIG_SENSORS_SBTSI)	+= sbtsi_temp.o
>   obj-$(CONFIG_SENSORS_SBRMI)	+= sbrmi.o
>   obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
> diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
> deleted file mode 100644
> index 70ae665db477..000000000000

