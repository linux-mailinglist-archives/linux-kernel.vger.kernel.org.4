Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93CC628F19
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 02:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbiKOBRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 20:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbiKOBRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:17:23 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1D31B9F0;
        Mon, 14 Nov 2022 17:17:20 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id j12so11740930plj.5;
        Mon, 14 Nov 2022 17:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BUIpc8OohuRwXXTymHuQYeof5fwY+3ojN2l9M9GcprA=;
        b=oUtVIOmA+hDrwfw6hXBGXEWEiUNMsAHXNCb1DogIAutUo3yWYa8OVEQlDCZYPxMRjL
         p7A9Mt0lsHTpvaTKR7AqJWuOEfJ4MgRFMpwrSYJjR/OOimc0Yd62WEVqiF38mCq9qHFV
         hibrRm2vl1oyYrKZSIUUcv0b2GDP8/lMq6ctyy6BcZ3D+8pytwo+MaqYRpQQtCKELnqb
         KhasTnP8z/67muakDUzLJ6Z7Bm5YiLfBipxYGSaES1pw+pdaz+bBWdUlSpXT3U8Tc0ZI
         b1ccr3lM9Xh527XRmGAJGyyCsKhbPp9HSlkzYwYVjhDDVEkdNq8OCCUXpTOIJD4YzWdo
         I1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUIpc8OohuRwXXTymHuQYeof5fwY+3ojN2l9M9GcprA=;
        b=lZNm25aHROzkkxlWxmn7shOVXXE8OW8Z1yYiKL8xdHQg8ZiNO3krlG0dXDfpHdaaft
         KJrHHPpa9dlZvpSLA5Rl8uqBud9rJgcexX+Yhdl2VhXvbk1bdcv/wFhCQME9aBsQIaGm
         wkr/zM2ZALe1vFchazsj5h7UXmnZbC4hmwlgfButXTSXBwyPUKzP/HcxRZrFmiSH6AQ2
         +9pEmtNNNBBf5hizwW+0XMg/d5Grnn+6CZ6WL1ozx6XC1wXTCEH6BdWuLQvLZwGFUofP
         YJVHNX67z5g+zwarHAO1A4hBS1koH0wOWU82nEvZVZpKiQ4poaA+ym+kLWaNHgSHSi7P
         60QQ==
X-Gm-Message-State: ANoB5pkj8FQ2eCDS7ZYFsFoKZpKgYm6XJ7F4ltMaTfGt3dIHu70SR2i4
        ZLz5VJcE+Fr+zPj+8wXzUkM=
X-Google-Smtp-Source: AA0mqf7AYFxLloZV1/xCKWZzDYS0lMqASczojZNKvBWAniq5L2uJ5HHmbKWbZ+2tWum2MmizzLjblA==
X-Received: by 2002:a17:903:26c1:b0:186:9852:b9e4 with SMTP id jg1-20020a17090326c100b001869852b9e4mr1849835plb.52.1668475040137;
        Mon, 14 Nov 2022 17:17:20 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:718:95ee:2678:497])
        by smtp.gmail.com with ESMTPSA id f88-20020a17090a28e100b002137030f652sm7238569pjd.12.2022.11.14.17.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 17:17:19 -0800 (PST)
Date:   Mon, 14 Nov 2022 17:17:16 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, w.david0@protonmail.com,
        stephan@gerhold.net, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 5/5] Input: msg2638 - Add support for msg2138 key
 events
Message-ID: <Y3LonDibllKkTmPs@google.com>
References: <20221110171952.34207-1-vincent.knecht@mailoo.org>
 <20221110171952.34207-6-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110171952.34207-6-vincent.knecht@mailoo.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 06:19:48PM +0100, Vincent Knecht wrote:
> Some devices with msg2138 have back/menu/home keys.
> Add support for them.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>  drivers/input/touchscreen/msg2638.c | 53 +++++++++++++++++++++++++----
>  1 file changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/msg2638.c b/drivers/input/touchscreen/msg2638.c
> index 73e1b4d550fb..36069b30ab9b 100644
> --- a/drivers/input/touchscreen/msg2638.c
> +++ b/drivers/input/touchscreen/msg2638.c
> @@ -29,6 +29,8 @@
>  #define MSG2138_MAX_FINGERS		2
>  #define MSG2638_MAX_FINGERS		5
>  
> +#define MAX_BUTTONS			4
> +
>  #define CHIP_ON_DELAY_MS		15
>  #define FIRMWARE_ON_DELAY_MS		50
>  #define RESET_DELAY_MIN_US		10000
> @@ -72,6 +74,8 @@ struct msg2638_ts_data {
>  	struct regulator_bulk_data supplies[2];
>  	struct gpio_desc *reset_gpiod;
>  	int max_fingers;
> +	u32 keycodes[MAX_BUTTONS];
> +	int num_keycodes;
>  };
>  
>  static u8 msg2638_checksum(u8 *data, u32 length)
> @@ -85,6 +89,19 @@ static u8 msg2638_checksum(u8 *data, u32 length)
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
> +		input_report_key(msg2638->input_dev, msg2638->keycodes[i],
> +				 !!(keys & BIT(i)));

No need to do double-negation here, input_report_key() does it already.

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
>  	x = (((p0->xy_hi & 0xF0) << 4) | p0->x_low);
>  	y = (((p0->xy_hi & 0x0F) << 8) | p0->y_low);
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
> @@ -367,10 +396,16 @@ static int msg2638_ts_probe(struct i2c_client *client)
>  		return error;
>  	}
>  
> -	error = msg2638_init_input_dev(msg2638);
> -	if (error) {
> -		dev_err(dev, "Failed to initialize input device: %d\n", error);
> -		return error;
> +	msg2638->num_keycodes =
> +		of_property_read_variable_u32_array(dev->of_node, "linux,keycodes",
> +						    msg2638->keycodes, 0,
> +						    ARRAY_SIZE(msg2638->keycodes));

Please do not use OF-specific API, use generic device property API (yes,
you will need 2 calls, one to get the count, and another to actually
fill the array).

Thanks.

-- 
Dmitry
