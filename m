Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A8C72A7FD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjFJCBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjFJCA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:00:59 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79003A87;
        Fri,  9 Jun 2023 19:00:57 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-65242634690so1994190b3a.0;
        Fri, 09 Jun 2023 19:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686362457; x=1688954457;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fw0H1q83PsjPvxpRFlkw9IpW27yxVD7J/idNivpC660=;
        b=l2petyFBQTKx6VmQ8gamIsQK1tatnd5zguOfNp6v35oTZ17+ujvwISENOUl7Te7ng0
         vzb2u+KWC+c67GJpxLWFz8LFpZXzM/4xL/lfQHdWrQlijolnmxRM+dENNS6Gi5pwnuiE
         qDUsnbaqtuWnF2FjpVivEtLIHfswHTc3ZD9yfg1YQO/Ofpi0BASlmQ1HoMDCeQzyuRRF
         TmrXCadeOVVPXERx+3p/de4vRHHYQNtIx1I+x/h3tcFwH1cTCho0cymQu1Ct4a8l9Lev
         Fdnn+X/+Yz+NQnkQcXD64jI14TdWxPYV+/H+kmdmVjPYASyhhCAM4OBvwUnpltaC3Ziv
         jpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686362457; x=1688954457;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fw0H1q83PsjPvxpRFlkw9IpW27yxVD7J/idNivpC660=;
        b=Nf8jF+4Ewwl8GL0p8U2gOcw4z5oFuvzm5/1W6OnVD6Dir9r2pVQu0ZrVBGBaQ17jO4
         W+Mblrv4xVUqNW0AJaPldCnu/8yI4SC4sRSFYHGrc7YUvGAXnF3gCJa5B9OfxQRUKyPj
         Wg1XZk4M/k36W8BYakX5wc9WSwRml/0DLzNBJSArFuIADKnQ0V/llgb415c6zSSoDipE
         eV07HyhAB4gTXHr1iZ+pJmHBije+P1afq0nMY9l1pmNCqbYm2c2mGpew21b/qwQLtDb9
         V8NelkGv/7tcC2NYm1ZY7vYqCC/poEls9cuyWxQ3GC689E0KFqP93d2CAJJcatSbD+Xs
         vWLw==
X-Gm-Message-State: AC+VfDx2qlA5+v0MsAV5yUu99Fhdx8o4Zhb4njd3u6eNUi/UlLj4z2Nm
        A4QZ9hrNcfqt8sU3rznU0to=
X-Google-Smtp-Source: ACHHUZ4NIftIgKP0EuZe2Zc3s+LT+MoTmoHVaHTZ6HAdiJULTVKHdOuvtiFyzHPNkjzkvQQSV8NHaA==
X-Received: by 2002:a05:6a00:a13:b0:658:d819:8890 with SMTP id p19-20020a056a000a1300b00658d8198890mr3317543pfh.5.1686362457129;
        Fri, 09 Jun 2023 19:00:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 25-20020aa79159000000b0062bc045bf4fsm3331832pfi.19.2023.06.09.19.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 19:00:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8f009142-61a5-3b26-79f9-f89902d62354@roeck-us.net>
Date:   Fri, 9 Jun 2023 19:00:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Baskaran Kannan <Baski.Kannan@amd.com>, Mario.Limonciello@amd.com,
        babu.moger@amd.com, clemens@ladisch.de, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230609231139.3006-1-Baski.Kannan@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Enable AMD3255 Proc to show negative temperature
In-Reply-To: <20230609231139.3006-1-Baski.Kannan@amd.com>
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

On 6/9/23 16:11, Baskaran Kannan wrote:
> From: Your Name <you@example.com>
> 

Patch description missing here. Also, obviously, as Randy already mentioned,
"Your Name <you@example.com>" isn't acceptable.

> Signed-off-by: Baski Kannan <Baski.Kannan@amd.com>
> ---
>   drivers/hwmon/k10temp.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 489ad0b1bc74..58e4d90de5e3 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -77,6 +77,11 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>   #define ZEN_CUR_TEMP_RANGE_SEL_MASK		BIT(19)
>   #define ZEN_CUR_TEMP_TJ_SEL_MASK		GENMASK(17, 16)
>   
> +/* AMD's Industrial processor 3255 supports temperature from -40 deg to 105 deg Celsius.
> + * Do not round off to zero for negative Tctl or Tdie values
> + */
> +#define AMD_I3255_STR				"3255"
> +
>   struct k10temp_data {
>   	struct pci_dev *pdev;
>   	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
> @@ -86,6 +91,7 @@ struct k10temp_data {
>   	u32 show_temp;
>   	bool is_zen;
>   	u32 ccd_offset;
> +	bool disp_negative; /*Flag set for AMD i3255. Family 17h, Model 0x0-0xf */

Space after '*'

>   };
>   
>   #define TCTL_BIT	0
> @@ -204,9 +210,15 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>   		switch (channel) {
>   		case 0:		/* Tctl */
>   			*val = get_raw_temp(data);
> +			if (*val < 0 && (data->disp_negative == false) ){
> +				*val = 0;
> +			}

It seems like this patch doesn't replace the previous version,
it is applied on top of it. Please don't do that. The previous version
was not accepted. Send a new version instead.

>   			break;
>   		case 1:		/* Tdie */
>   			*val = get_raw_temp(data) - data->temp_offset;
> +			if (*val < 0 && (data->disp_negative == false) ){

This violates Linux kernel style (space before {).
Also, () around the second expression is unnecessary, as is == false.
Please use !data->disp_negative instead. Also, the {} is unnecessary.

> +				*val = 0;
> +			}
>   			break;
>   		case 2 ... 13:		/* Tccd{1-12} */
>   			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
> @@ -401,6 +413,11 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	data->pdev = pdev;
>   	data->show_temp |= BIT(TCTL_BIT);	/* Always show Tctl */
>   
> +	if (boot_cpu_data.x86 == 0x17 &&
> +		strstr(boot_cpu_data.x86_model_id, AMD_I3255_STR)) {

Multi-line alignment seems wrong, and there is no need for {}.
Please make sure that checkpatch --strict is clean.

> +		data->disp_negative = true;
> +	}
> +
>   	if (boot_cpu_data.x86 == 0x15 &&
>   	    ((boot_cpu_data.x86_model & 0xf0) == 0x60 ||
>   	     (boot_cpu_data.x86_model & 0xf0) == 0x70)) {

