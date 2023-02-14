Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E71695B45
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjBNHy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjBNHyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:54:11 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D856026B3;
        Mon, 13 Feb 2023 23:54:09 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id fi26so16085977edb.7;
        Mon, 13 Feb 2023 23:54:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZJ6zhgUh/ZKtXL7pKp/OS8n3+HahCHd3UvO2XgOPDY=;
        b=RZ3EcoiZmAo/Ebk36jAkXd9qhnlVZO/so5iOHKlV5SHP38paA/PE9+z7Rkz//ZXSrv
         u1SEpmxRT74YG7SwkZr+WHxx/rr0+XXxxU0UBFS0X8JMTOgTMivG1MM+gLdAcvDcVJW6
         pAjqMLBXviNp9ycE+ovCKOG3bZdUdcEMqssnZK+RdZ8mgNJGOU2rLfNHDBbvgstxqiwh
         krfyfbgvW7iO9QkYbqxGOZq8myl8SH2aRKrakC9Ac2tmHwT+eQE4WJSiCl8Pa8hfqNB6
         vXuKrjpXfPLiv15Dbetfm6A47CzQ4HO/6wFTjWp7N2277kWrqKEDawIUZ2DbyJLCdPzw
         qx6Q==
X-Gm-Message-State: AO0yUKUSYnuaL1xqSQJzxi2yYw1Jtc8zAuHfCdq5XS/dnhicmBUwZ2y5
        zJM7izSWQ44q+zFMkMfgfhU=
X-Google-Smtp-Source: AK7set8faDisTfoodQJEOx+37p7FJghZBFoz5XpndvA4hYgfbEiZR9snHjvcZyRx9QTOSfmm0kDQ5g==
X-Received: by 2002:a50:f69a:0:b0:4ab:db9e:9682 with SMTP id d26-20020a50f69a000000b004abdb9e9682mr1542611edn.34.1676361248442;
        Mon, 13 Feb 2023 23:54:08 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id q24-20020a50cc98000000b004acc7202074sm2563962edi.16.2023.02.13.23.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 23:54:08 -0800 (PST)
Message-ID: <b5dd2505-b087-b521-739b-ad4e97f3cbc5@kernel.org>
Date:   Tue, 14 Feb 2023 08:54:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Florian Eckert <fe@dev.tdt.de>, u.kleine-koenig@pengutronix.de,
        gregkh@linuxfoundation.org, pavel@ucw.cz, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
References: <20230213140638.620206-1-fe@dev.tdt.de>
 <20230213140638.620206-3-fe@dev.tdt.de>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 2/2] leds: trigger: ledtrig-tty: add additional modes
In-Reply-To: <20230213140638.620206-3-fe@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 02. 23, 15:06, Florian Eckert wrote:
> Add additional modes to trigger the selected LED.
> The following modes are supported:
> 
> TD/RD:	Flash LED on data transmission (default)
> CTS:	DCE Ready to accept data from the DTE.
> DSR:	DCE is ready to receive and send data.
> CAR:	DCE is receiving a carrier from a remote DTE.
> RNG:	DCE has detected an incoming ring signal.
> 
> The mode can be changed for example with the following command:
> echo "CTS" /sys/class/leds/<led>/mode

This will emit only:
CTS /sys/class/leds/<led>/mode

> This would turn on the LED, when the DTE(modem) signals the DCE that it
> is ready to accept data.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
...
> --- a/drivers/leds/trigger/ledtrig-tty.c
> +++ b/drivers/leds/trigger/ledtrig-tty.c
> @@ -7,6 +7,14 @@
>   #include <linux/tty.h>
>   #include <uapi/linux/serial.h>
>   
> +enum tty_led_mode {
> +	TTY_LED_CNT,
> +	TTY_LED_CTS,
> +	TTY_LED_DSR,
> +	TTY_LED_CAR,
> +	TTY_LED_RNG,
> +};
> +
>   struct ledtrig_tty_data {
>   	struct led_classdev *led_cdev;
>   	struct delayed_work dwork;
> @@ -14,6 +22,15 @@ struct ledtrig_tty_data {
>   	const char *ttyname;
>   	struct tty_struct *tty;
>   	int rx, tx;
> +	unsigned int mode;

Why not the enum then?

> +};
> +
> +static const char * const mode[] = {

This is not a wise name.

> +	[TTY_LED_CNT] = "TD/RD", // Trasmit Data / Receive Data
> +	[TTY_LED_CTS] = "CTS", // CTS Clear To Send
> +	[TTY_LED_DSR] = "DSR", // DSR Data Set Ready
> +	[TTY_LED_CAR] = "CAR", // CAR Data Carrier Detect (DCD)
> +	[TTY_LED_RNG] = "RNG", // RNG Ring Indicator (RI)
>   };
>   
>   static void ledtrig_tty_restart(struct ledtrig_tty_data *trigger_data)
> @@ -21,6 +38,74 @@ static void ledtrig_tty_restart(struct ledtrig_tty_data *trigger_data)
>   	schedule_delayed_work(&trigger_data->dwork, 0);
>   }
>   
> +static ssize_t mode_show(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	struct ledtrig_tty_data *trigger_data = led_trigger_get_drvdata(dev);
> +	enum tty_led_mode tty_mode;
> +
> +	mutex_lock(&trigger_data->mutex);
> +	tty_mode = trigger_data->mode;
> +	mutex_unlock(&trigger_data->mutex);
> +
> +	switch (tty_mode) {
> +	case TTY_LED_CTS:
> +		return sprintf(buf, "%s [%s] %s %s %s\n", mode[TTY_LED_CNT],
> +				mode[TTY_LED_CTS], mode[TTY_LED_DSR],
> +				mode[TTY_LED_CAR], mode[TTY_LED_RNG]);
> +	case TTY_LED_DSR:
> +		return sprintf(buf, "%s %s [%s] %s %s\n", mode[TTY_LED_CNT],
> +				mode[TTY_LED_CTS], mode[TTY_LED_DSR],
> +				mode[TTY_LED_CAR], mode[TTY_LED_RNG]);
> +	case TTY_LED_CAR:
> +		return sprintf(buf, "%s %s %s [%s] %s\n", mode[TTY_LED_CNT],
> +				mode[TTY_LED_CTS], mode[TTY_LED_DSR],
> +				mode[TTY_LED_CAR], mode[TTY_LED_RNG]);
> +	case TTY_LED_RNG:
> +		return sprintf(buf, "%s %s %s %s [%s]\n", mode[TTY_LED_CNT],
> +				mode[TTY_LED_CTS], mode[TTY_LED_DSR],
> +				mode[TTY_LED_CAR], mode[TTY_LED_RNG]);
> +	case TTY_LED_CNT:
> +	default:
> +		return sprintf(buf, "[%s] %s %s %s %s\n", mode[TTY_LED_CNT],
> +				mode[TTY_LED_CTS], mode[TTY_LED_DSR],
> +				mode[TTY_LED_CAR], mode[TTY_LED_RNG]);

Can't we do the above in a loop easier?

> +static ssize_t mode_store(struct device *dev,
> +			  struct device_attribute *attr, const char *buf,
> +			  size_t size)
> +{
> +	struct ledtrig_tty_data *trigger_data = led_trigger_get_drvdata(dev);
> +	ssize_t ret = size;
> +	enum tty_led_mode tty_mode;
> +
> +	/* Check for new line in string*/
> +	if (size > 0 && buf[size - 1] == '\n')
> +		size -= 1;
> +
> +	if (strncmp(buf, mode[TTY_LED_CTS], size) == 0)
> +		tty_mode = TTY_LED_CTS;
> +	else if (strncmp(buf, mode[TTY_LED_DSR], size) == 0)
> +		tty_mode = TTY_LED_DSR;
> +	else if (strncmp(buf, mode[TTY_LED_CAR], size) == 0)
> +		tty_mode = TTY_LED_CAR;
> +	else if (strncmp(buf, mode[TTY_LED_RNG], size) == 0)
> +		tty_mode = TTY_LED_RNG;
> +	else if (strncmp(buf, mode[TTY_LED_CNT], size) == 0)
> +		tty_mode = TTY_LED_CNT;
> +	else
> +		return -EINVAL;

Again, a loop?

> +
> +	mutex_lock(&trigger_data->mutex);
> +	trigger_data->mode = tty_mode;
> +	mutex_unlock(&trigger_data->mutex);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RW(mode);
> +
>   static ssize_t ttyname_show(struct device *dev,
>   			    struct device_attribute *attr, char *buf)
>   {
> @@ -76,6 +161,18 @@ static ssize_t ttyname_store(struct device *dev,
>   }
>   static DEVICE_ATTR_RW(ttyname);
>   
> +static void ledtrig_tty_flags(struct ledtrig_tty_data *trigger_data,
> +		unsigned int flag)
> +{
> +	unsigned int status;
> +
> +	status = tty_get_mget(trigger_data->tty);

So what about negative values = errors?

> +	if (status & flag)

They really might hit here.

> +		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
> +	else
> +		led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
> +}
> +


thanks,
-- 
js
suse labs

