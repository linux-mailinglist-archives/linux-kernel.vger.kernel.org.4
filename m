Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00A6638C59
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiKYOh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiKYOh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:37:58 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6581BEAE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:37:55 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id g12so7027990wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hrDPugbGkUH8uPiDnvaRZfdEhlUMjCxRails1zWFZdw=;
        b=BMAit6xLhKZyhxy+vup7aqWvO/XCPl4fGAnIWkhlv0cgETv/w+db5BARl8jhd6eLAU
         dDO1qPPALURyqP1cPkZxFjEPAssRnpUEE4pcwh3BTNLDAly4Pzf9g453lA3WyaMoz7/+
         X2+z/+3cPIgf1kkkiAU2EYhEdGvRJAE7zZLe6G6JjBqvdSAWfWmAmo6ENLz7IoI3qcdy
         t73evpDa4mplMnLOpxMPDFnATPbL05dY3aoBoiM4XbLENjYC7fwExRBuqcOHMUHrCXKn
         +BXL/qyZkajAX6R/Ic5oJD7aXRzT0/0uiZ7zFbcnezQU/c434mivDpb5N9V9MR+CcOVk
         wupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hrDPugbGkUH8uPiDnvaRZfdEhlUMjCxRails1zWFZdw=;
        b=iWUq7WvaVB5uYmHlFgSKhieKIcMT9JxRaQ4WAxDjpJvU27VdTkO6C/xB0doKRM6gv1
         TMMpJEvUWFOuBcxMhhdW6YYH7F6RF+43nwaS6rYpy4wiVDdE55bLoFkk70bnLoxfCXeR
         EF/Jn1NUH/i60+FhcgQ0ZHSJ7ChxsWjUFVyADRzyMcLL3qenHVMV+RrpANqz57aZnnZg
         iDkSTlfDx5mMIw5lc9csRH/u7IcFygWN7q+PDDwV7V4FTrbw5GyyJPz+xr/Fm0QdQ+eB
         55iR0CuIyqCdNkYojUgXLjsdj0sGvpT4pXpGRicErW/SR7PDY8U9a2eWHR3wuvoxs2pw
         Vd+w==
X-Gm-Message-State: ANoB5plt+N2fYOLotpfP9kve5IDb2yAdjDFDfJaJ82Y4UK6jNhhsAibB
        fz7XkyVbpgoOXRiavn+7861G0Q==
X-Google-Smtp-Source: AA0mqf6zFC29XjHLwhlQEYJX4yZh6j2JlZhtRxyqGdRVe0Zun9l7ZP3FYrb2zuBfsAUHkGZHKTvnVg==
X-Received: by 2002:a05:6000:1208:b0:236:4838:515d with SMTP id e8-20020a056000120800b002364838515dmr22959604wrx.541.1669387073812;
        Fri, 25 Nov 2022 06:37:53 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id d5-20020a05600c3ac500b003cfe6fd7c60sm5343439wms.8.2022.11.25.06.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 06:37:53 -0800 (PST)
Message-ID: <426d1f07-0a5d-b740-dc93-77c5a8bc6d23@linaro.org>
Date:   Fri, 25 Nov 2022 14:37:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 13/13] tty: serial: qcom-geni-serial: add support for
 serial engine DMA
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20221123110759.1836666-1-brgl@bgdev.pl>
 <20221123110759.1836666-14-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221123110759.1836666-14-brgl@bgdev.pl>
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

Thanks Bartosz for the patch,

On 23/11/2022 11:07, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The qcom-geni-serial driver currently only works in SE FIFO mode. This
> limits the UART speed to around 180 kB/s. In order to achieve higher
> speeds we need to use SE DMA mode.
> 
> Keep the console port working in FIFO mode but extend the code to use DMA
> for the high-speed port.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/tty/serial/qcom_geni_serial.c | 289 ++++++++++++++++++++++----
>   1 file changed, 247 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 82242a40a95a..0f4ba909c792 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -70,6 +70,8 @@
>   #define UART_START_TX			0x1
>   /* UART S_CMD OP codes */
>   #define UART_START_READ			0x1
> +#define UART_PARAM			0x1
> +#define UART_PARAM_RFR_OPEN		BIT(7)
>   
>   #define UART_OVERSAMPLING		32
>   #define STALE_TIMEOUT			16
> @@ -95,9 +97,11 @@
>   /* We always configure 4 bytes per FIFO word */
>   #define BYTES_PER_FIFO_WORD		4
>   
> +#define DMA_RX_BUF_SIZE		2048
> +
>   struct qcom_geni_device_data {
>   	bool console;
> -	void (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
> +	enum geni_se_xfer_mode mode;
>   };
>   
>   struct qcom_geni_private_data {
> @@ -118,9 +122,11 @@ struct qcom_geni_serial_port {
>   	u32 tx_fifo_depth;
>   	u32 tx_fifo_width;
>   	u32 rx_fifo_depth;
> +	dma_addr_t tx_dma_addr;
> +	dma_addr_t rx_dma_addr;
>   	bool setup;
>   	unsigned int baud;
> -	void *rx_fifo;
> +	void *rx_buf;
>   	u32 loopback;
>   	bool brk;
>   
> @@ -552,18 +558,11 @@ static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
>   
>   static void handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
>   {
> -	struct tty_port *tport;
>   	struct qcom_geni_serial_port *port = to_dev_port(uport);
> -	u32 num_bytes_pw = port->tx_fifo_width / BITS_PER_BYTE;
> -	u32 words = ALIGN(bytes, num_bytes_pw) / num_bytes_pw;
> +	struct tty_port *tport = &uport->state->port;
>   	int ret;
>   
> -	tport = &uport->state->port;
> -	ioread32_rep(uport->membase + SE_GENI_RX_FIFOn, port->rx_fifo, words);
> -	if (drop)
> -		return;
> -

Are we removing FIFO support for uart?

It it not a overhead to use dma for small transfers that are less than 
fifo size?


> -	ret = tty_insert_flip_string(tport, port->rx_fifo, bytes);
> +	ret = tty_insert_flip_string(tport, port->rx_buf, bytes);
>   	if (ret != bytes) {
>   		dev_err(uport->dev, "%s:Unable to push data ret %d_bytes %d\n",
>   				__func__, ret, bytes);
> @@ -578,7 +577,70 @@ static unsigned int qcom_geni_serial_tx_empty(struct uart_port *uport)
>   	return !readl(uport->membase + SE_GENI_TX_FIFO_STATUS);
>   }
>   
> -static void qcom_geni_serial_start_tx(struct uart_port *uport)
> +static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
> +{
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
> +	bool done;

-->
> +	u32 status;
...
> +
> +	status = readl(uport->membase + SE_GENI_STATUS);
> +	if (!(status & M_GENI_CMD_ACTIVE))
> +		return;
<---

this code snippet is repeating more than few times in the patches, looks 
like it could be made to a inline helper.


> +
> +	if (port->rx_dma_addr) {
> +		geni_se_tx_dma_unprep(&port->se, port->tx_dma_addr,
> +				      port->tx_remaining);
> +		port->tx_dma_addr = (dma_addr_t)NULL;
> +		port->tx_remaining = 0;
> +	}
> +
> +	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
> +	writel(m_irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> +	geni_se_cancel_m_cmd(&port->se);
> +
> +	done = qcom_geni_serial_poll_bit(uport, SE_GENI_S_IRQ_STATUS,
> +					 S_CMD_CANCEL_EN, true);
> +	if (!done) {
> +		geni_se_abort_m_cmd(&port->se);
> +		qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> +					  M_CMD_ABORT_EN, true);

return is not checked, there are few more such instances in the patch.

> +		writel(M_CMD_ABORT_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
> +	}
> +
> +	writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
> +}
> +
> +static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
> +{
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
> +	struct circ_buf *xmit = &uport->state->xmit;
> +	unsigned int xmit_size;
> +	int ret;
> +
> +	if (port->tx_dma_addr)
> +		return;
Is this condition actually possible?


> +
> +	xmit_size = uart_circ_chars_pending(xmit);
> +	if (xmit_size < WAKEUP_CHARS)
> +		uart_write_wakeup(uport);
> +
> +	xmit_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
> +
> +	qcom_geni_serial_setup_tx(uport, xmit_size);
> +
> +	ret = geni_se_tx_dma_prep(&port->se, &xmit->buf[xmit->tail],
> +				  xmit_size, &port->tx_dma_addr);
> +	if (ret) {
> +		dev_err(uport->dev, "unable to start TX SE DMA: %d\n", ret);
> +		qcom_geni_serial_stop_tx_dma(uport);
> +		return;
> +	}
> +
> +	port->tx_remaining = xmit_size;
> +}
> +

...
