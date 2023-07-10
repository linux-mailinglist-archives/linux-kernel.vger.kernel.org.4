Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E8074DCA7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjGJRnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGJRnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:43:05 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE2EDD;
        Mon, 10 Jul 2023 10:43:04 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b890e2b9b7so23356715ad.3;
        Mon, 10 Jul 2023 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689010984; x=1691602984;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fDAy0vVA3a+9sJex/LHHOb6x4vi+5awTJxhRIpJhfgM=;
        b=eL2E+07U74IZq0xnbdVPQzdBSLu5MmteAAwMxGVinIep0YmICTUy7mBKdKJaZLyOXt
         TfebaFExZB2PrYzQ0V6Xj4ve9C+ISw1uBEIc4/+GHXL44T8KJkRS3ISzbrHRAnELokR9
         qUyrYV17+FMh83W7pYi0Sj9joDc00IWrr8mOdBb/EVECmFrDEA5CZjfwCdC1XSfWOc/h
         FcYyttwvfZtRJl2SWUiRUailD9qR1QTmEWBhjisD0NlmvtisMq4+AvD7UtabR4rKs4Zy
         UduUAqz0I6DNPSfJ/A9sznLx/vRrYxeU4SKjRfSlLJC+SX2t2uI+5uvfdi87tFEDv5XO
         oUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689010984; x=1691602984;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDAy0vVA3a+9sJex/LHHOb6x4vi+5awTJxhRIpJhfgM=;
        b=TfikLIWAxOhmJAaMZPNby3EOsYYyEAslVSn/YEWQ681kKF3fqTQQmVm+6AIY3VTpT8
         p7seKIJU4FcrfESu20HVUlk78TylwyVNYjC/8Oacz+0h4mEfUbBY/gcopeBG2vw043q2
         EWcWDsWURmzT0nX+kb9xbMy3jDAWkxUjlYDL9geo0Wz50j32bQuU/u+leJreO4nyvrmi
         HxMxgeykzlOmeXOBs21HN5oTIejmINmOq7wXYHKOmsuYhM6g3Ie6Uks9MgxCKViMSRsx
         Yb6d031qtLdVNn2sN9gVvfzfaBqyOnKLgg9POCMZxQu0arKAy6TUJmHAo9CHeXlUPqTg
         TVvQ==
X-Gm-Message-State: ABy/qLY26z5/d3eWwvzTFYU2kK3f1YXmMHV50Jr37k+JsHGdDZ3oD+FI
        asOxUMcYEDGYjlm5r3S9Y9w=
X-Google-Smtp-Source: APBJJlF9Ambbltxhd1I/Ksl+P1TBG1QGVr5d3WoRX+eIRyqPl4cLyavb0mOyJJbQHNJfXVOaHmzF9g==
X-Received: by 2002:a17:903:428d:b0:1b2:46ab:a9e1 with SMTP id ju13-20020a170903428d00b001b246aba9e1mr9835540plb.28.1689010983634;
        Mon, 10 Jul 2023 10:43:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902e84400b001b80971609esm172820plg.152.2023.07.10.10.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 10:43:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1f4c500b-e706-a090-516d-992b68f44f0d@roeck-us.net>
Date:   Mon, 10 Jul 2023 10:43:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hwmon: (peci/cputemp) Add Intel Sapphire Rapids support
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        openbmc@lists.ozlabs.org
References: <20230710162724.827833-1-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230710162724.827833-1-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/23 09:27, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add support to read DTS for reading Intel Sapphire Rapids platform.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

This patch touches code outside the hwmon subsystem, so I won't be able
to apply it without Ack from a maintainer.

Guenter

> ---
>   drivers/hwmon/peci/cputemp.c | 18 ++++++++++++++++++
>   drivers/peci/cpu.c           |  5 +++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c
> index e5b65a382772..a812c15948d9 100644
> --- a/drivers/hwmon/peci/cputemp.c
> +++ b/drivers/hwmon/peci/cputemp.c
> @@ -363,6 +363,7 @@ static int init_core_mask(struct peci_cputemp *priv)
>   	switch (peci_dev->info.model) {
>   	case INTEL_FAM6_ICELAKE_X:
>   	case INTEL_FAM6_ICELAKE_D:
> +	case INTEL_FAM6_SAPPHIRERAPIDS_X:
>   		ret = peci_ep_pci_local_read(peci_dev, 0, reg->bus, reg->dev,
>   					     reg->func, reg->offset + 4, &data);
>   		if (ret)
> @@ -531,6 +532,13 @@ static struct resolved_cores_reg resolved_cores_reg_icx = {
>   	.offset = 0xd0,
>   };
>   
> +static struct resolved_cores_reg resolved_cores_reg_spr = {
> +	.bus = 31,
> +	.dev = 30,
> +	.func = 6,
> +	.offset = 0x80,
> +};
> +
>   static const struct cpu_info cpu_hsx = {
>   	.reg		= &resolved_cores_reg_hsx,
>   	.min_peci_revision = 0x33,
> @@ -549,6 +557,12 @@ static const struct cpu_info cpu_icx = {
>   	.thermal_margin_to_millidegree = &dts_ten_dot_six_to_millidegree,
>   };
>   
> +static const struct cpu_info cpu_spr = {
> +	.reg		= &resolved_cores_reg_spr,
> +	.min_peci_revision = 0x40,
> +	.thermal_margin_to_millidegree = &dts_ten_dot_six_to_millidegree,
> +};
> +
>   static const struct auxiliary_device_id peci_cputemp_ids[] = {
>   	{
>   		.name = "peci_cpu.cputemp.hsx",
> @@ -574,6 +588,10 @@ static const struct auxiliary_device_id peci_cputemp_ids[] = {
>   		.name = "peci_cpu.cputemp.icxd",
>   		.driver_data = (kernel_ulong_t)&cpu_icx,
>   	},
> +	{
> +		.name = "peci_cpu.cputemp.spr",
> +		.driver_data = (kernel_ulong_t)&cpu_spr,
> +	},
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(auxiliary, peci_cputemp_ids);
> diff --git a/drivers/peci/cpu.c b/drivers/peci/cpu.c
> index de4a7b3e5966..3668a908d259 100644
> --- a/drivers/peci/cpu.c
> +++ b/drivers/peci/cpu.c
> @@ -318,6 +318,11 @@ static const struct peci_device_id peci_cpu_device_ids[] = {
>   		.model	= INTEL_FAM6_ICELAKE_X,
>   		.data	= "icx",
>   	},
> +	{ /* Sapphire Rapids Xeon */
> +		.family	= 6,
> +		.model	= INTEL_FAM6_SAPPHIRERAPIDS_X,
> +		.data	= "spr",
> +	},
>   	{ /* Icelake Xeon D */
>   		.family	= 6,
>   		.model	= INTEL_FAM6_ICELAKE_D,
> 
> base-commit: 4dbbaf8fbdbd13adc80731b2452257857e4c2d8b

