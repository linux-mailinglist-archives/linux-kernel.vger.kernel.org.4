Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36FB6AC508
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCFPa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjCFPat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:30:49 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F16132525;
        Mon,  6 Mar 2023 07:30:26 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-176eae36feaso1032430fac.6;
        Mon, 06 Mar 2023 07:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678116623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tXyraA7EBUjlMHKpI1NEMzO/jRBVc3H8mcteDRxdbrM=;
        b=FKKZ4r4cCRi9Y/rvT7x32ysvrf6bxbbCC5YeMO3gbX8VzEmJgE6VIKAtju9BQDT2Sv
         dIc+dO7ZezSX8SmKgZQqqlzlvjv0lI9/vkyxxXgzB/cy55R8VL5dFhHV2TuNf0Y8nROq
         Kiiie9JSNRWQijpk7KYreVeoO/r4/zsikw6DOkCHff0JkdhebXEDLW6w51INUcKoRQKO
         cKxp0LSophAzdjyinAP4uOaOIoxTzwy565JeJo47SuUthW95U8/9qhWmeCESRUiztyWC
         S92SaaYXGtWGRMdS6z9m8fnxwjeUo+32CW/y3kR/oVwg5rDjTbNt47iej0LAmqBxF9bO
         /ALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXyraA7EBUjlMHKpI1NEMzO/jRBVc3H8mcteDRxdbrM=;
        b=CWvfjh5p6bzbucAH5goHuPkFGwiLfLcbO027PFmEZSFkfZ47yM0UyRsQESTF0ncsgL
         9btONo4H0LPO3HQQ858HCSo4OyRqEU+eHmhf/a1QZQP/SaJ7T2MbV9NDVE8prw1Wkn4z
         MWQp1wldQIMt1NUwd71GZy8P6opXAZGVNnX6aYgEl6S47dvTSQziC5/zStL2JMJBKDF6
         P81SpKWLIYwjx7SQPTYTQgC47qVmTA4GBrmEOwjylm+IwOzv23WZ4Jf7j6TDL3rBErsJ
         4GMah9oczNBcth2Y8fYnHfUopGdc1xoPA/N5y5akS3sEZyt/evc0H3fqF7QPLyq6U1fK
         YfcA==
X-Gm-Message-State: AO0yUKWbGd8qCzP6ss90bo5qV+XVkq3iLFvcLMRJUMEJrgCpq0nbn1pM
        /4yGVHoIu0WB4KMqHc3Flbg=
X-Google-Smtp-Source: AK7set+Ws+hL2nePfJEaCTizVbAREjWqpt7NTr0ziC8UEzrqsGEM77rHplKx+EWuy6KbavlcRNn3AQ==
X-Received: by 2002:a05:6870:3928:b0:176:3fc6:f199 with SMTP id b40-20020a056870392800b001763fc6f199mr7375716oap.37.1678116622758;
        Mon, 06 Mar 2023 07:30:22 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c22-20020a056870a59600b0017197629658sm4013147oam.56.2023.03.06.07.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 07:30:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <41828531-0115-2097-4c73-5cf431cb5686@roeck-us.net>
Date:   Mon, 6 Mar 2023 07:30:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/4] hwmon: pmbus: Use devm_krealloc_array
Content-Language: en-US
To:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Jean Delvare <jdelvare@suse.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
References: <20230306152723.3090195-1-james.clark@arm.com>
 <20230306152723.3090195-3-james.clark@arm.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230306152723.3090195-3-james.clark@arm.com>
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

On 3/6/23 07:27, James Clark wrote:
> Now that it exists, use it instead of doing the multiplication manually.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/pmbus/pmbus_core.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 95e95783972a..e7bee25a3706 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -1190,9 +1190,9 @@ static int pmbus_add_attribute(struct pmbus_data *data, struct attribute *attr)
>   {
>   	if (data->num_attributes >= data->max_attributes - 1) {
>   		int new_max_attrs = data->max_attributes + PMBUS_ATTR_ALLOC_SIZE;
> -		void *new_attrs = devm_krealloc(data->dev, data->group.attrs,
> -						new_max_attrs * sizeof(void *),
> -						GFP_KERNEL);
> +		void *new_attrs = devm_krealloc_array(data->dev, data->group.attrs,
> +						      new_max_attrs, sizeof(void *),
> +						      GFP_KERNEL);
>   		if (!new_attrs)
>   			return -ENOMEM;
>   		data->group.attrs = new_attrs;

