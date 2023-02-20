Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4396869CA23
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjBTLr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjBTLr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:47:26 -0500
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DA01A966;
        Mon, 20 Feb 2023 03:47:25 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id g1so3307731edz.7;
        Mon, 20 Feb 2023 03:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HvsutTANG3cjuLMBWKYQu5HgoJwLQebTSdHXrLXPcM=;
        b=vslTjukZkT/UQQnrn/q6To3YIcnIQe4G/tgmI+3Ty8dRydNiTq6XX5pesvTQwaPpAo
         h8APmssQuJjP3pFJibpVwyPzQuTB5oeP0XHc8cZ6YTiGUC16p7uF5/x+4Cr7OI/oHybo
         LSZV3l5dDiQrqqf5IYf/z2SxCbppiMDt8zKJE9o4FavcVpudeKCI5PzHPjsNl6DaQiMr
         5IXmbVfe6TCHzqzY4UYAuRpMqTRDlksx533vuBUj6y1wSRFs25LiXcmguwSDd2/CDdZy
         SzefX2wZwTQ2JKgkfjBzibK1wgmzwtU8+eJQuzKzGgyh7GHfmVC/dakQVeMbnAGGN9Y0
         FDyQ==
X-Gm-Message-State: AO0yUKVgVcVSFGDYN3PJPmyrcxVwpQHdj5IQQMn/bdfuqIFBrOKfHhoh
        F95gD77iv3kQPNgnAPs7Tyo=
X-Google-Smtp-Source: AK7set9GCdIByppmjb4jggC0khoDJcMB71fwHYywjKBjQXCHiOgnru8Yhlf4TWRBLNTiKe/MxhZDsw==
X-Received: by 2002:a50:e606:0:b0:4ac:bcf9:6d7e with SMTP id y6-20020a50e606000000b004acbcf96d7emr1274149edm.11.1676893643342;
        Mon, 20 Feb 2023 03:47:23 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id t14-20020a508d4e000000b004acb696a0f6sm1257671edt.91.2023.02.20.03.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 03:47:22 -0800 (PST)
Message-ID: <fa21b4df-951d-129e-4c98-de9dd25f10db@kernel.org>
Date:   Mon, 20 Feb 2023 12:47:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Florian Eckert <fe@dev.tdt.de>, u.kleine-koenig@pengutronix.de,
        gregkh@linuxfoundation.org, pavel@ucw.cz, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
References: <20230220093739.320478-1-fe@dev.tdt.de>
 <20230220093739.320478-3-fe@dev.tdt.de>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3 2/2] trigger: ledtrig-tty: add additional modes
In-Reply-To: <20230220093739.320478-3-fe@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 02. 23, 10:37, Florian Eckert wrote:
> Add additional modes to trigger the selected LED.
> The following modes are supported:
> 
> Tx/Rx:	Flash LED on data transmission (default)
> CTS:	DCE Ready to accept data from the DTE.
> DSR:	DCE is ready to receive and send data.
> CAR:	DCE is receiving a carrier from a remote DTE.
> RNG:	DCE has detected an incoming ring signal.
> 
> The mode can be changed for example with the following command:
> echo "CTS" > /sys/class/leds/<led>/mode
> 
> This would turn on the LED, when the DTE(modem) signals the DCE that it
> is ready to accept data.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>

> --- a/drivers/leds/trigger/ledtrig-tty.c
> +++ b/drivers/leds/trigger/ledtrig-tty.c
> @@ -7,6 +7,15 @@
>   #include <linux/tty.h>
>   #include <uapi/linux/serial.h>
>   
> +enum tty_led_mode {
> +	TTY_LED_CNT,
> +	TTY_LED_CTS,
> +	TTY_LED_DSR,
> +	TTY_LED_CAR,
> +	TTY_LED_RNG,

I would do:
  __TTY_LED_LAST = TTY_LED_RNG;

instead of:

> +	__TTY_LED_MAX


> +};
> +
>   struct ledtrig_tty_data {
>   	struct led_classdev *led_cdev;
>   	struct delayed_work dwork;
> @@ -14,6 +23,15 @@ struct ledtrig_tty_data {
>   	const char *ttyname;
>   	struct tty_struct *tty;
>   	int rx, tx;
> +	enum tty_led_mode mode;
> +};
> +
> +static const char * const mode[] = {
> +	[TTY_LED_CNT] = "Tx/Rx", // Trasmit Data / Receive Data
> +	[TTY_LED_CTS] = "CTS", // CTS Clear To Send
> +	[TTY_LED_DSR] = "DSR", // DSR Data Set Ready
> +	[TTY_LED_CAR] = "CAR", // CAR Data Carrier Detect (DCD)
> +	[TTY_LED_RNG] = "RNG", // RNG Ring Indicator (RI)
>   };
>   
>   static void ledtrig_tty_restart(struct ledtrig_tty_data *trigger_data)
> @@ -21,6 +39,71 @@ static void ledtrig_tty_restart(struct ledtrig_tty_data *trigger_data)
>   	schedule_delayed_work(&trigger_data->dwork, 0);
>   }
>   
> +static ssize_t ledtrig_tty_mode_show(char *buf, enum tty_led_mode tty_mode)
> +{
> +	int len = 0;
> +	int i;
> +
> +	for (i = 0; i < __TTY_LED_MAX; i++) {
> +		bool hit;
> +
> +		hit = tty_mode == i;

Both the decl and assignment can be on a single line.

> +		len += sysfs_emit_at(buf, len, "%s%s%s",
> +				  hit ? "[" : "",
> +				  mode[i],
> +				  hit ? "]" : "");
> +
> +		if (i < __TTY_LED_MAX - 1)
> +			len += sysfs_emit_at(buf, len, " ");

And all this could be then:
for (i = 0; i <= __TTY_LED_LAST; i++) {
   bool hit = i == tty_mode;
   bool last = i == __TTY_LED_LAST;

   len += sysfs_emit_at(buf, len, "%s%s%s%s",
				  hit ? "[" : "",
				  mode[i],
				  hit ? "]" : "",
				  last ? "" : " ");
}

> +	}
> +
> +	len += sysfs_emit_at(buf, len, "\n");
> +
> +	return len;
> +}
...
> +static ssize_t tty_led_mode_store(struct device *dev,
> +			  struct device_attribute *attr, const char *buf,
> +			  size_t size)
> +{
> +	struct ledtrig_tty_data *trigger_data = led_trigger_get_drvdata(dev);
> +	ssize_t ret = size;
> +	enum tty_led_mode tty_mode = __TTY_LED_MAX;
> +	int i;
> +
> +	/* Check for new line in string*/
> +	if (size > 0 && buf[size - 1] == '\n')
> +		size -= 1;
> +
> +	for (i = 0; i < __TTY_LED_MAX; i++) {
> +		if (strncmp(buf, mode[i], size) == 0)
> +			tty_mode = i;
> +	}
> +
> +	if (tty_mode == __TTY_LED_MAX)
> +		return -EINVAL;

Ah, you use __TTY_LED_MAX as an extra value. It doesn't look nice. So 
now, what about:

	for (i = 0; i <= __TTY_LED_LAST; i++)
		if (strncmp(buf, mode[i], size) == 0) {
			tty_mode = i;
			break;
		}

	if (i > __TTY_LED_LAST)
		return -EINVAL;

?

thanks,
-- 
js
suse labs

