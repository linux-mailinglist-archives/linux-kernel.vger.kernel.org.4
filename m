Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2F162CAE8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiKPUd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiKPUd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:33:56 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603885FD9;
        Wed, 16 Nov 2022 12:33:55 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 4so17562145pli.0;
        Wed, 16 Nov 2022 12:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpUbAI4uL54jT1VZCkuoylkPFVjPgLoBwqqkPGEZ5rQ=;
        b=mPoTCyN2tv62LXRH6cDZRrJsNLj2noBCQlryjEuyR0cyrPvYcvmgomQddDwbIVtRPX
         OLdvfZpwr3m26cFqePgEYPhrGhQDAWXHRrN+FGkHk5TuP0o1T8wm09FEKVchKUQIs0tf
         29IkAjLWIZC6qxEdHo1O7BTy6xj77DIQcyp8VBBvGRQ+lgY86VxaHZlkxEAOb0/Uro3l
         5V+5AOJOxR4hEjRZhm3C/B5uapmI40h/F4CAsI72c76gOVs7ysrAz4z4GmrigrBQfDS1
         fnpo394ecuzIKhWpnxSVDVVgEhvq3kD2lvj8fC/DIA8ITmaTQxwDy+bwf7NJ1WLL/nUh
         bkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpUbAI4uL54jT1VZCkuoylkPFVjPgLoBwqqkPGEZ5rQ=;
        b=aOo5b9ygaM7CamfuwRdU8mbUbeyLNFMm84nLf252tH14O07pAmKbB7sfl6H4g0/0ZK
         oasWGffHvHu47y+qYzlgCYfswYOYeU/0C37fNgrVTNPk3TxRycEQvCuCKmAiugE93t5t
         iM05SfmnESIdIywCzCFnFAEztw6MpaizlMnBu9ZqsB60w9e7ZHwy0/jwZsXBAIjEydve
         25T24mlRUx5pt97RzO++OeAqisehqQ+QzHrTE9FWNFkpuuDJnYV2rMjRI0JIBIA5tOuj
         /29Pa42H9VH63saH2Mlz5dLNnpjgPZ6++3GSsPqUxLsnw62/4WikM/oWnm4Zk9W6CNOQ
         TB9w==
X-Gm-Message-State: ANoB5pkigFitMiz8A/tjIrFI22ejikVwQnlPgdKVkXNQROUGxaM4Hj94
        kMynWFnCzG6WyC6TuQgCzeQ=
X-Google-Smtp-Source: AA0mqf6gZEfpw/MZ3nfZ2C+BlmxjQlwMp58NAu8vm7GhmSs74FWFgfhId8ZzbuG8+efKjUNOjgqt6A==
X-Received: by 2002:a17:903:2d0:b0:186:c372:8e09 with SMTP id s16-20020a17090302d000b00186c3728e09mr10634958plk.74.1668630834726;
        Wed, 16 Nov 2022 12:33:54 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:fb51:2ecd:7287:8649])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902c1c200b0017fe9b038fdsm12668992plc.14.2022.11.16.12.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:33:53 -0800 (PST)
Date:   Wed, 16 Nov 2022 12:33:50 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, w.david0@protonmail.com,
        stephan@gerhold.net, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 2/2] Input: msg2638 - Add support for msg2138 key
 events
Message-ID: <Y3VJLtY27h/YrBWa@google.com>
References: <20221116181715.2118436-1-vincent.knecht@mailoo.org>
 <20221116181715.2118436-3-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116181715.2118436-3-vincent.knecht@mailoo.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 07:17:12PM +0100, Vincent Knecht wrote:
> Some devices with msg2138 have back/menu/home keys.
> Add support for them.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>  drivers/input/touchscreen/msg2638.c | 57 +++++++++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/msg2638.c b/drivers/input/touchscreen/msg2638.c
> index 95b18563326a..a0f5e1ecd612 100644
> --- a/drivers/input/touchscreen/msg2638.c
> +++ b/drivers/input/touchscreen/msg2638.c
> @@ -21,6 +21,7 @@
>  #include <linux/kernel.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  
> @@ -29,6 +30,8 @@
>  #define MSG2138_MAX_FINGERS		2
>  #define MSG2638_MAX_FINGERS		5
>  
> +#define MAX_BUTTONS			4
> +
>  #define CHIP_ON_DELAY_MS		15
>  #define FIRMWARE_ON_DELAY_MS		50
>  #define RESET_DELAY_MIN_US		10000
> @@ -72,6 +75,8 @@ struct msg2638_ts_data {
>  	struct regulator_bulk_data supplies[2];
>  	struct gpio_desc *reset_gpiod;
>  	int max_fingers;
> +	u32 keycodes[MAX_BUTTONS];
> +	int num_keycodes;
>  };
>  
>  static u8 msg2638_checksum(u8 *data, u32 length)
> @@ -85,6 +90,18 @@ static u8 msg2638_checksum(u8 *data, u32 length)
>  	return (u8)((-sum) & 0xFF);
>  }
>  
> +static void msg2138_report_keys(struct msg2638_ts_data *msg2638, u8 keys)
> +{
> +	int i;
> +
> +	/* keys can be 0x00 or 0xff when all keys have been released */
> +	if (keys == 0xff)
> +		keys = 0;
> +
> +	for (i = 0; i < msg2638->num_keycodes; ++i)
> +		input_report_key(msg2638->input_dev, msg2638->keycodes[i], keys & BIT(i));
> +}
> +
>  static irqreturn_t msg2138_ts_irq_handler(int irq, void *msg2638_handler)
>  {
>  	struct msg2638_ts_data *msg2638 = msg2638_handler;
> @@ -121,9 +138,12 @@ static irqreturn_t msg2138_ts_irq_handler(int irq, void *msg2638_handler)
>  	p0 = &touch_event.pkt[0];
>  	p1 = &touch_event.pkt[1];
>  
> -	/* Ignore non-pressed finger data */
> -	if (p0->xy_hi == 0xFF && p0->x_low == 0xFF && p0->y_low == 0xFF)
> +	/* Ignore non-pressed finger data, but check for key code */
> +	if (p0->xy_hi == 0xFF && p0->x_low == 0xFF && p0->y_low == 0xFF) {
> +		if (p1->xy_hi == 0xFF && p1->y_low == 0xFF)
> +			msg2138_report_keys(msg2638, p1->x_low);
>  		goto report;
> +	}
>  
>  	x = ((p0->xy_hi & 0xF0) << 4) | p0->x_low;
>  	y = ((p0->xy_hi & 0x0F) << 8) | p0->y_low;
> @@ -283,6 +303,7 @@ static int msg2638_init_input_dev(struct msg2638_ts_data *msg2638)
>  	struct device *dev = &msg2638->client->dev;
>  	struct input_dev *input_dev;
>  	int error;
> +	int i;
>  
>  	input_dev = devm_input_allocate_device(dev);
>  	if (!input_dev) {
> @@ -299,6 +320,14 @@ static int msg2638_init_input_dev(struct msg2638_ts_data *msg2638)
>  	input_dev->open = msg2638_input_open;
>  	input_dev->close = msg2638_input_close;
>  
> +	if (msg2638->num_keycodes) {
> +		input_dev->keycode = msg2638->keycodes;
> +		input_dev->keycodemax = msg2638->num_keycodes;
> +		input_dev->keycodesize = sizeof(msg2638->keycodes[0]);
> +		for (i = 0; i < msg2638->num_keycodes; i++)
> +			input_set_capability(input_dev, EV_KEY, msg2638->keycodes[i]);
> +	}
> +
>  	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
>  	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
>  
> @@ -367,9 +396,23 @@ static int msg2638_ts_probe(struct i2c_client *client)
>  		return error;
>  	}
>  
> -	error = msg2638_init_input_dev(msg2638);
> +	msg2638->num_keycodes = fwnode_property_count_u32(dev->fwnode, "linux,keycodes");

Please use device_property_count_u32().

> +	if (msg2638->num_keycodes == -EINVAL) {
> +		msg2638->num_keycodes = 0;
> +	} else if (msg2638->num_keycodes < 0) {
> +		dev_err(dev, "Unable to parse linux,keycodes property: %d\n",
> +			msg2638->num_keycodes);
> +		return msg2638->num_keycodes;
> +	} else if (msg2638->num_keycodes > ARRAY_SIZE(msg2638->keycodes)) {
> +		dev_warn(dev, "Found %d linux,keycodes but max is %ld, ignoring the rest\n",
> +			 msg2638->num_keycodes, ARRAY_SIZE(msg2638->keycodes));

I think you want "%zd" in place of "%ld".

> +		msg2638->num_keycodes = ARRAY_SIZE(msg2638->keycodes);
> +	}
> +
> +	error = fwnode_property_read_u32_array(dev->fwnode, "linux,keycodes",
> +					       msg2638->keycodes, msg2638->num_keycodes);

Please use device_property_read_u32_array().

>  	if (error) {
> -		dev_err(dev, "Failed to initialize input device: %d\n", error);
> +		dev_err(dev, "Unable to read linux,keycodes values: %d\n", error);
>  		return error;
>  	}
>  
> @@ -382,6 +425,12 @@ static int msg2638_ts_probe(struct i2c_client *client)
>  		return error;
>  	}
>  
> +	error = msg2638_init_input_dev(msg2638);
> +	if (error) {
> +		dev_err(dev, "Failed to initialize input device: %d\n", error);
> +		return error;
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.38.1
> 
> 
> 

Thanks.

-- 
Dmitry
