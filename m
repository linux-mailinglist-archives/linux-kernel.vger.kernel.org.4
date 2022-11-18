Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D52262F5F6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbiKRN2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241210AbiKRN2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:28:15 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5055985A30
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:28:14 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id x21so6733878ljg.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNkQuTkHkcJpXO7x2sVRjZ9xn9Fos+tc+aaL5aSw7Sc=;
        b=vv2hHhjhfRjtcQCEbeHGTAafIQktgBjQGhcYk8P2MMdhuMGJhmR++vUWtSL7mM/v4p
         VrTUNAmQpLxBuovza74nDWq3Zrfuy/D+HbJBkJwT8JN7hJbKKeqNhOwo9csJsMUXuQ9X
         wrUB8ePtuPVSF6gRn0wZamOtQLWxoE6buLZBC8lKtrMvUYe7FvzuEeiwURVPzOS8XmGR
         HDJrkA8lCtklTQG9HlBAO3NktK50f0lsahMgeLCn6u8HoM7a2rVPH9hU2x2bNbNQ+Nd+
         alKmW0ZJiMHwp1m4bQ1NQGBW9XKo8rQdcnpmndu/5KjKbIzYQ8rtXTB4Edp5Ib7Q/4jO
         K5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HNkQuTkHkcJpXO7x2sVRjZ9xn9Fos+tc+aaL5aSw7Sc=;
        b=TPK58GSjbK+1k5+SQMm6jrxge5SMj+5hX2TuN7maMoPuQ453qDPL889ccbPy7HhehH
         o/JMHq4asBJY9xlyIO2TSC4o9UZtS1VP3Lbnl7KMkP7R6N96v6AvFsEfwLVv+H9bda/w
         s/rCCl8zY60q47J2+Xmi0xnX2HrAfoaevBHXPaQYU8Ebpu+mxUFk6XP5Snzs+J0Wd72u
         UxZ5QPBTMhipG/zq7PN87uLelzBK8IYf99AnANIRwCLyCi1WjHhKT8nmN/Tvmn8K/UeR
         /DBd5ziLg1YlEX7wjIrcpMG+55TKRl1Jar8roCnrsWN1QgEwNx7urXEdF+Rt5QDxxVrg
         VdnQ==
X-Gm-Message-State: ANoB5pm3GFmmZgyynZiXmeXZZ3qmAivXlMty8/eZX5unhGrhZvA1NNjY
        ddyaZ3GVTFNFpg9CVNGXLJfL1A==
X-Google-Smtp-Source: AA0mqf43Fg8qEr0j1/rw8VZIt75k+VpSDJMdUlgNkJ90WGzXpvx8pdiGdE/RO+fGzAu+AOMO2YI3GQ==
X-Received: by 2002:a2e:aaa4:0:b0:277:a84:44f5 with SMTP id bj36-20020a2eaaa4000000b002770a8444f5mr2626756ljb.312.1668778092663;
        Fri, 18 Nov 2022 05:28:12 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id dt15-20020a0565122a8f00b0049110ba325asm654873lfb.158.2022.11.18.05.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:28:12 -0800 (PST)
Message-ID: <d9910e0c-4e4b-3c8b-bf6e-dc5196166a49@linaro.org>
Date:   Fri, 18 Nov 2022 14:28:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 09/15] tty: serial: qcom-geni-serial: drop the return
 value from handle_rx
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
 <20221118122539.384993-10-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221118122539.384993-10-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/11/2022 13:25, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The return value of the handle_rx() callback is never checked. Drop it.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   drivers/tty/serial/qcom_geni_serial.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 4b155ca0ac74..72d0e7b91080 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -114,7 +114,7 @@ struct qcom_geni_serial_port {
>   	u32 tx_fifo_width;
>   	u32 rx_fifo_depth;
>   	bool setup;
> -	int (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
> +	void (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
>   	unsigned int baud;
>   	void *rx_fifo;
>   	u32 loopback;
> @@ -499,7 +499,7 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
>   		spin_unlock_irqrestore(&uport->lock, flags);
>   }
>   
> -static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
> +static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
>   {
>   	u32 i;
>   	unsigned char buf[sizeof(u32)];
> @@ -534,16 +534,15 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
>   	}
>   	if (!drop)
>   		tty_flip_buffer_push(tport);
> -	return 0;
>   }
>   #else
> -static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
> +static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
>   {
> -	return -EPERM;
> +
>   }
>   #endif /* CONFIG_SERIAL_QCOM_GENI_CONSOLE */
>   
> -static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
> +static void handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
>   {
>   	struct tty_port *tport;
>   	struct qcom_geni_serial_port *port = to_dev_port(uport);
> @@ -554,7 +553,7 @@ static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
>   	tport = &uport->state->port;
>   	ioread32_rep(uport->membase + SE_GENI_RX_FIFOn, port->rx_fifo, words);
>   	if (drop)
> -		return 0;
> +		return;
>   
>   	ret = tty_insert_flip_string(tport, port->rx_fifo, bytes);
>   	if (ret != bytes) {
> @@ -564,7 +563,6 @@ static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
>   	}
>   	uport->icount.rx += ret;
>   	tty_flip_buffer_push(tport);
> -	return ret;
>   }
>   
>   static unsigned int qcom_geni_serial_tx_empty(struct uart_port *uport)
