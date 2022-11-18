Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D340262F623
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiKRNbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241745AbiKRNbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:31:23 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6055F96
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:31:22 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id z24so6792348ljn.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Y+0FBJhRpRkHWP9VYNCn8CpByxrNXNKR+R5nAPAPPA=;
        b=iCwIMGIM/IGKtrfpBP5RqDq9nSGhvOwD4m2ok5bPC0jqzKqjomWZTT6BBn7LnxMVYb
         EtxH2B84ysBb9yqWSm+4BJmhw3laDXcoeopQLv8zgVY2oslMHJFM8lmGJEl98X9riplO
         KjmftAsG9JLBf+2SapTO7uPdz2MaQckHC8+CR7sRqFO74p2cXDGVcGF7iADir3FsouCZ
         6xM25iT/Do7hIIY+UUI+eiWHdH7B3pox2vyb3BgruvIfB8sW7SdBhTX5WVDXjhBYDKSA
         6KoTZ1JMW5D2Iq2MdH34npFSCOoGeuhige/4wJb5hvS74EAhGPgIXBXB8u1ZlHtSfAdA
         BaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Y+0FBJhRpRkHWP9VYNCn8CpByxrNXNKR+R5nAPAPPA=;
        b=L8uhhnL/oQjAWSrU9ivg0AnVypwB70skm/uK0HH0p7VPgxIinJIelWdZOuProX0288
         if8vr5LrYmEyx7cF8FLO8Q+fMqj46arIHAVx2qOsTaSC8s8zc1qxQ7lKBQe12qbARWij
         6+tZI+8em0J/lstDi/1sldhB5sWaH3fMCcb7DjfxFB3WD4ldCDLw4p4ZcKKe1JJpvx56
         9GRyg4U1cYMM2irLkQg8sEuOEl89fda6A7c4hKvju2ObR78cPho788atP6NMCywnW1fW
         rr/RcQaomn7Zb8jxhpwTMsU/7GZbjQa7r6OwMFtnTytQocRthyoqHuUdBhSQ1bL2Xu0V
         j7pQ==
X-Gm-Message-State: ANoB5plZVvtlSpT3ID6Gp/sAZQ7fYy30rHKN0s8x/zbjY5gSv2dHEkWc
        LjBeX4hEif+NP+YShA6iHBf/EA==
X-Google-Smtp-Source: AA0mqf4TKOWpER95/mJA5icLM4VdiEGnMGzlq/Az+3b+SMLopNdAEWWm4g+TK4bs3Nv76tNrprDiuQ==
X-Received: by 2002:a2e:6a16:0:b0:26e:3c:733b with SMTP id f22-20020a2e6a16000000b0026e003c733bmr2521739ljc.247.1668778280575;
        Fri, 18 Nov 2022 05:31:20 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id q8-20020a056512210800b004979db5aa5bsm659659lfr.223.2022.11.18.05.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:31:19 -0800 (PST)
Message-ID: <767ce717-7b0c-41c9-a53d-dbcbb758117f@linaro.org>
Date:   Fri, 18 Nov 2022 14:31:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 10/15] tty: serial: qcom-geni-serial: use of_device_id
 data
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20221118122539.384993-1-brgl@bgdev.pl>
 <20221118122539.384993-11-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221118122539.384993-11-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/11/2022 13:25, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Instead of checking the device compatible in probe(), assign the
> device-specific data to struct of_device_id. We'll use it later when
> providing SE DMA support.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   drivers/tty/serial/qcom_geni_serial.c | 46 ++++++++++++++++++++-------
>   1 file changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 72d0e7b91080..6a9f3f937f29 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -95,6 +95,11 @@
>   /* We always configure 4 bytes per FIFO word */
>   #define BYTES_PER_FIFO_WORD		4
>   
> +struct qcom_geni_device_data {
> +	bool console;
> +	void (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
> +};
> +
>   struct qcom_geni_private_data {
>   	/* NOTE: earlycon port will have NULL here */
>   	struct uart_driver *drv;
> @@ -114,7 +119,6 @@ struct qcom_geni_serial_port {
>   	u32 tx_fifo_width;
>   	u32 rx_fifo_depth;
>   	bool setup;
> -	void (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
>   	unsigned int baud;
>   	void *rx_fifo;
>   	u32 loopback;
> @@ -126,6 +130,7 @@ struct qcom_geni_serial_port {
>   	bool cts_rts_swap;
>   
>   	struct qcom_geni_private_data private_data;
> +	const struct qcom_geni_device_data *dev_data;
>   };
>   
>   static const struct uart_ops qcom_geni_console_pops;
> @@ -637,7 +642,7 @@ static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
>   		total_bytes += last_word_byte_cnt;
>   	else
>   		total_bytes += BYTES_PER_FIFO_WORD;
> -	port->handle_rx(uport, total_bytes, drop);
> +	port->dev_data->handle_rx(uport, total_bytes, drop);
>   }
>   
>   static void qcom_geni_serial_stop_rx(struct uart_port *uport)
> @@ -1348,13 +1353,14 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>   	struct uart_port *uport;
>   	struct resource *res;
>   	int irq;
> -	bool console = false;
>   	struct uart_driver *drv;
> +	const struct qcom_geni_device_data *data;
>   
> -	if (of_device_is_compatible(pdev->dev.of_node, "qcom,geni-debug-uart"))
> -		console = true;
> +	data = of_device_get_match_data(&pdev->dev);
> +	if (!data)
> +		return -EINVAL;
>   
> -	if (console) {
> +	if (data->console) {
>   		drv = &qcom_geni_console_driver;
>   		line = of_alias_get_id(pdev->dev.of_node, "serial");
>   	} else {
> @@ -1364,7 +1370,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>   			line = of_alias_get_id(pdev->dev.of_node, "hsuart");
>   	}
>   
> -	port = get_port_from_line(line, console);
> +	port = get_port_from_line(line, data->console);
>   	if (IS_ERR(port)) {
>   		dev_err(&pdev->dev, "Invalid line %d\n", line);
>   		return PTR_ERR(port);
> @@ -1376,6 +1382,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>   		return -ENODEV;
>   
>   	uport->dev = &pdev->dev;
> +	port->dev_data = data;
>   	port->se.dev = &pdev->dev;
>   	port->se.wrapper = dev_get_drvdata(pdev->dev.parent);
>   	port->se.clk = devm_clk_get(&pdev->dev, "se");
> @@ -1394,7 +1401,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>   	port->rx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
>   	port->tx_fifo_width = DEF_FIFO_WIDTH_BITS;
>   
> -	if (!console) {
> +	if (!data->console) {
>   		port->rx_fifo = devm_kcalloc(uport->dev,
>   			port->rx_fifo_depth, sizeof(u32), GFP_KERNEL);
>   		if (!port->rx_fifo)
> @@ -1424,7 +1431,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>   	uport->irq = irq;
>   	uport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_QCOM_GENI_CONSOLE);
>   
> -	if (!console)
> +	if (!data->console)
>   		port->wakeup_irq = platform_get_irq_optional(pdev, 1);
>   
>   	if (of_property_read_bool(pdev->dev.of_node, "rx-tx-swap"))
> @@ -1446,7 +1453,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>   	port->private_data.drv = drv;
>   	uport->private_data = &port->private_data;
>   	platform_set_drvdata(pdev, port);
> -	port->handle_rx = console ? handle_rx_console : handle_rx_uart;
>   
>   	ret = uart_add_one_port(drv, uport);
>   	if (ret)
> @@ -1526,14 +1532,30 @@ static int __maybe_unused qcom_geni_serial_sys_resume(struct device *dev)
>   	return ret;
>   }
>   
> +static const struct qcom_geni_device_data qcom_geni_console_data = {
> +	.console = true,
> +	.handle_rx = handle_rx_console,
> +};
> +
> +static const struct qcom_geni_device_data qcom_geni_uart_data = {
> +	.console = false,
> +	.handle_rx = handle_rx_uart,
> +};
> +
>   static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
>   	SET_SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_sys_suspend,
>   					qcom_geni_serial_sys_resume)
>   };
>   
>   static const struct of_device_id qcom_geni_serial_match_table[] = {
> -	{ .compatible = "qcom,geni-debug-uart", },
> -	{ .compatible = "qcom,geni-uart", },
> +	{
> +		.compatible = "qcom,geni-debug-uart",
> +		.data = &qcom_geni_console_data,
> +	},
> +	{
> +		.compatible = "qcom,geni-uart",
> +		.data = &qcom_geni_uart_data,
> +	},
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, qcom_geni_serial_match_table);
