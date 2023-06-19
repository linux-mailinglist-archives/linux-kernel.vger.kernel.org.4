Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69517735CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjFSRHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFSRHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:07:22 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0215124;
        Mon, 19 Jun 2023 10:07:21 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-39ee19cfb77so647437b6e.0;
        Mon, 19 Jun 2023 10:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687194441; x=1689786441;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bRJlXAK0GLifL/6sbIsWFY66HEmTj1aB/zhZvbrx7Lw=;
        b=Jdg7dcywDJr5WWIe8jqdGKw5ATll9kBe6Wd9iMIAjOh9QvCzolYwxzaO7lp7MxibQd
         Eunn8/2xk233rmrThMWU2DLTxSihGShHyWm3afwOHsdy1lTycizZPuSxaokFmbsYOsz2
         CpBecfTOzt1v+7CCa31pPdaie7MhkLlIKhnH1lhQrcaRtlKWySs/pAXi+fkbymmYAMKC
         kKBtsHqmk8TK3qGnhCpEfzOSMFh5qhiX03acCkS2U76yqIWz7vDfFMJ/UH96pAt0Fkw1
         QGOIsFhDUkix2nn+5qLRLDXuSr6OgrqzNggde4M4En/PIt3bmvkiFf7yY8/VZa158gJF
         Pv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687194441; x=1689786441;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRJlXAK0GLifL/6sbIsWFY66HEmTj1aB/zhZvbrx7Lw=;
        b=LcYGGf5wDZvF06wIwIGKjV0FQYLksI/Z9mRjrGrbUhSCI3u2s7Uk4yCY6NLrq6bqU7
         JfgI5JlNtEGz7E7pMR07VtT2lONfSa+gXg8fM0hfHizsvNvLuF3n+eE5ZlC2+9DLWwWF
         H+iJVcD65hr4D0pzWoY8C4bDx4q87NeC6YCtkh3gWs5BOpgRugDQJz06kM9BlnnqkS9Y
         kG5bM8rk11PrNeAVnvfmsqOSpjx7CiG6vc/5CdmpZSWle+aAZY0B3O61HDfLWt+9Flcf
         SbvouopG88r7TFJLAeKSKObHZGtzdDoLPivQmb10Ry8MfYalYyaAkGMluWSTa3Yng0CE
         NU+w==
X-Gm-Message-State: AC+VfDyz5ngwsmVdhuR0+Bi1oD/Dau9IfW79pi0QIoBKsjF+lgDCZO6A
        EfHSPzEiHSaVvJ38zXkC9FBADCmAvLc=
X-Google-Smtp-Source: ACHHUZ4B7iIRRgPh8epIfSj0RWc7ZeBy8DxB616R1Q1hL9fMln0Rj9LE7dznGm6dEYpoIkNMsVQGZQ==
X-Received: by 2002:a05:6808:152b:b0:39e:ddd8:4c4 with SMTP id u43-20020a056808152b00b0039eddd804c4mr3589926oiw.9.1687194440982;
        Mon, 19 Jun 2023 10:07:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bo24-20020a17090b091800b00246f9725ffcsm82713pjb.33.2023.06.19.10.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 10:07:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4585ec62-b7bb-9f2a-eee0-07032648e55a@roeck-us.net>
Date:   Mon, 19 Jun 2023 10:07:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] hwmon: (k10temp) Enable AMD3255 Proc to show negative
 temperature
Content-Language: en-US
To:     Baskaran Kannan <Baski.Kannan@amd.com>, Mario.Limonciello@amd.com,
        babu.moger@amd.com, clemens@ladisch.de, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230619165413.806450-1-Baski.Kannan@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230619165413.806450-1-Baski.Kannan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/23 09:54, Baskaran Kannan wrote:
> Industrial processor i3255 supports temperatures -40 deg celcius
> to 105 deg Celcius. The current implementation of k10temp_read_temp
> rounds off any negative
> temperatures to '0'. To fix this, the following changes have been made.
> Added a flag 'disp_negative' to struct k10temp_data to support
> AMD i3255 processors. Flag 'disp_negative' is set if 3255 processor
> is found during k10temp_probe.  Flag 'disp_negative' is used to determine
> whether to round off negative temperatures to '0' in k10temp_read_temp.
> 
> Signed-off-by: Baskaran Kannan <Baski.Kannan@amd.com>

Now you have made changes you were not asked to make, extended the flag
to cover a range of processors instead of just i3255, and did not provide
a change log nor a comment in the code describing why processors with
certain model numbers should display negative temperatures.

Guenter

> ---
>   drivers/hwmon/k10temp.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 7b177b9fbb09..2613420d43ff 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -86,6 +86,7 @@ struct k10temp_data {
>   	u32 show_temp;
>   	bool is_zen;
>   	u32 ccd_offset;
> +	bool disp_negative;
>   };
>   
>   #define TCTL_BIT	0
> @@ -204,12 +205,12 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>   		switch (channel) {
>   		case 0:		/* Tctl */
>   			*val = get_raw_temp(data);
> -			if (*val < 0)
> +			if (*val < 0 && !data->disp_negative)
>   				*val = 0;
>   			break;
>   		case 1:		/* Tdie */
>   			*val = get_raw_temp(data) - data->temp_offset;
> -			if (*val < 0)
> +			if (*val < 0 && !data->disp_negative)
>   				*val = 0;
>   			break;
>   		case 2 ... 13:		/* Tccd{1-12} */
> @@ -405,6 +406,9 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	data->pdev = pdev;
>   	data->show_temp |= BIT(TCTL_BIT);	/* Always show Tctl */
>   
> +	if (boot_cpu_data.x86 == 0x17 && boot_cpu_data.x86_model < 0x8)
> +		data->disp_negative = true;
> +
>   	if (boot_cpu_data.x86 == 0x15 &&
>   	    ((boot_cpu_data.x86_model & 0xf0) == 0x60 ||
>   	     (boot_cpu_data.x86_model & 0xf0) == 0x70)) {

