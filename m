Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE88372AEE7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 22:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjFJU7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 16:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFJU7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 16:59:00 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28DD2D46;
        Sat, 10 Jun 2023 13:58:59 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-651f2f38634so3168385b3a.0;
        Sat, 10 Jun 2023 13:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686430739; x=1689022739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kWcf7ZBHuk0EEqI7PijW395FiqPrO6B3dowhTTIT158=;
        b=TNkeCXcM+od+txE0GwKaPJnHOwLtS/yj2QdrG8aOGCWUFu3OqR9CQYs6130tKvqiUA
         qn3tLnE1s8KY1MTtjIv2vXI0o8KMtGWyr2K3HwHeMHTuIsMOSoV258kIap0LOkK/Jd+4
         oWsynKauzrdI+uGwca9uyDiZuOoKXemjCGSkWcH6IVhLx0WHpoys5FLqgwmmbkVbo+ME
         EjNrSK06OjOHkzPyaidTSPNqj49ybByBIsr0Pi7HEoUOsJXZfDI8kgbIe9Y+hMLVvXOK
         ddgowFoCVWx+norrwP2iFwnMraJZkhJPGV8yMCUXO2O42K455rrZyAbw52ItS1AQFhhE
         iLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686430739; x=1689022739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWcf7ZBHuk0EEqI7PijW395FiqPrO6B3dowhTTIT158=;
        b=QXJdNGRBQBcBIDTAHcgogMIfEecvkYiQQwZbBI2h4yn+60URn51QiPt0CE/qhb9WX4
         a6AFWRf11Bq3094saFAHpMzEBdg+vp1h+du+udquS3rqc353X8imQ3FCWlrZAvv8O+OQ
         L5TPlctpbc451JAyDbwJZSGct+9zVj1oPRvhsKblaW8iwWWwp4vwsaTi3u8SEFzoD9R2
         LRll2PmrI4P8AJBT8nY+2yLdop9qgjS0t5sELue3xjSYvCPzHforimtDpCwMWZ6xaVi8
         izmuMgNVV/wPYTArfbKbdcZbs7rbvmVE56UFnIAqxYUSLvwQDYlg39UXiaOwPa0o4vrv
         jHZg==
X-Gm-Message-State: AC+VfDw+Jhr+hGIM5RYNvd6opOUpasezMYqHrDez2rhnJgBEKL664BMv
        dmHFgV/8JwhkseKO0zbtzPzKOMx/kag=
X-Google-Smtp-Source: ACHHUZ71tdiUZXVsGHbSTjKiTipZjizehiUyLpIQ98xtd0wPxVoVaJPplvIdJWHcr+DpN7zQGX8QAw==
X-Received: by 2002:a05:6a00:2488:b0:660:ec6d:56af with SMTP id c8-20020a056a00248800b00660ec6d56afmr6983596pfv.24.1686430739143;
        Sat, 10 Jun 2023 13:58:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w15-20020aa7858f000000b0064ca1fa8442sm4625247pfn.178.2023.06.10.13.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 13:58:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <797319c5-9b03-704d-2e32-fadcec924019@roeck-us.net>
Date:   Sat, 10 Jun 2023 13:58:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Enable AMD3255 Proc to show negative temperature
Content-Language: en-US
To:     Baskaran Kannan <Baski.Kannan@amd.com>, Mario.Limonciello@amd.com,
        babu.moger@amd.com, clemens@ladisch.de, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Baskaran Kannan <bakannan@amd.com>
References: <20230610205357.5658-1-Baski.Kannan@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230610205357.5658-1-Baski.Kannan@amd.com>
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

On 6/10/23 13:53, Baskaran Kannan wrote:
> From: Baskaran Kannan <bakannan@amd.com>
> 
> Signed-off-by: Baskaran Kannan <Baski.Kannan@amd.com>

Please resubmit and either make the changes you were asked to make,
or explain why you did not follow them.

Guenter

> ---
>   drivers/hwmon/k10temp.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 489ad0b1bc74..a79aac0596e5 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -77,6 +77,12 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>   #define ZEN_CUR_TEMP_RANGE_SEL_MASK		BIT(19)
>   #define ZEN_CUR_TEMP_TJ_SEL_MASK		GENMASK(17, 16)
>   
> +/*
> + * AMD's Industrial processor 3255 supports temperature from -40 deg to 105 deg Celsius.
> + * Do not round off to zero for negative Tctl or Tdie values.
> + */
> +#define AMD_I3255_STR				"3255"
> +
>   struct k10temp_data {
>   	struct pci_dev *pdev;
>   	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
> @@ -86,6 +92,7 @@ struct k10temp_data {
>   	u32 show_temp;
>   	bool is_zen;
>   	u32 ccd_offset;
> +	bool disp_negative; /*Flag set for AMD i3255. Family 17h, Model 0x0-0xf */
>   };
>   
>   #define TCTL_BIT	0
> @@ -204,9 +211,15 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>   		switch (channel) {
>   		case 0:		/* Tctl */
>   			*val = get_raw_temp(data);
> +			if (*val < 0 && (data->disp_negative == false) ){
> +				*val = 0;
> +			}
>   			break;
>   		case 1:		/* Tdie */
>   			*val = get_raw_temp(data) - data->temp_offset;
> +			if (*val < 0 && (data->disp_negative == false) ){
> +				*val = 0;
> +			}
>   			break;
>   		case 2 ... 13:		/* Tccd{1-12} */
>   			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
> @@ -401,6 +414,11 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	data->pdev = pdev;
>   	data->show_temp |= BIT(TCTL_BIT);	/* Always show Tctl */
>   
> +	if (boot_cpu_data.x86 == 0x17 &&
> +		strstr(boot_cpu_data.x86_model_id, AMD_I3255_STR)) {
> +		data->disp_negative = true;
> +	}
> +
>   	if (boot_cpu_data.x86 == 0x15 &&
>   	    ((boot_cpu_data.x86_model & 0xf0) == 0x60 ||
>   	     (boot_cpu_data.x86_model & 0xf0) == 0x70)) {

