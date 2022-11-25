Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB9063880C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiKYK7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiKYK7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:59:30 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08524A073
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:59:28 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id x17so6205615wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qxVUzuEfs/JtujPMqVzJNV5+NhQvPn6jD1wFfmF5YfM=;
        b=hpWKj9WbiPBqcBWPgY84/bsJo2X8VHHOXSltnPkhVQpzOMblhiXUBP/YApAP4mxw/l
         +iBMNvupOl05n/13RoHoB8ekVUWQ65WEpuirycbVxcERe+lcdgdfpXAqzBSpu0lrwPBf
         ZbfyjyJ1KUGbb46s60vYiBs2tM7LF8/CoEvhTEcSaPMevCew4dF1QFKMhtl5mVfY+AbJ
         rzZgRk1JgmHDlUkSh4UjwF3yP5erCL0w67iZ/NIzZUwOfr7lk3Y0uDlVrTU8FcNa4EbA
         Vx3wiJs0B5m7pOWMFmQlFhR3R2RH5df2WNAkXG14kz21K0PTUbBy53QcCGYCSoeSBCBG
         883A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxVUzuEfs/JtujPMqVzJNV5+NhQvPn6jD1wFfmF5YfM=;
        b=JYvZqlxdlvzu4eh78JygSkJaVNLbQHNi98u4my0jdkWsnxWKl2iXu7kHHGBJZgWs9O
         LCCFLRDswWEigzLxm9Ca5+jyjrzvMQ3Jz1/aDRGxGJ2UAXh0GDUz37mKqZY6IGHstAlc
         hFZN/uZnvMVbxPxELMe+NAFQkbOFL5eKjeTZJdKPb855z/6O8PjQ4kRFvo+BQNKxQtgF
         6woxawAn5tC0Lilq6DnMIJxI1GQUnGF5nTlwnKqCZhcLKPsGocZHlPer4xHdl3xGz5LF
         kZNn8xdTOUR6ADaLAYMEbd7KCGRBK2Qs5+NnsRi8sCyoUy7TlOt8jjT39qBNSBH5XLFC
         JC9Q==
X-Gm-Message-State: ANoB5pm7Q/QSQQjkMHICKdw6ct9kuLUf/I+lqKS0iaCXtACXZ4kA8neM
        cNb7ESpnmtqL+i5w3+NuJkPtgw==
X-Google-Smtp-Source: AA0mqf7br94cM7b4HGSNhekL2RXQdU8X1ZTptG1/XapkSAPoz5vUxC6qAPeIGDWl9OmGApyxNeoTCQ==
X-Received: by 2002:adf:e7c3:0:b0:241:dfce:9bfc with SMTP id e3-20020adfe7c3000000b00241dfce9bfcmr11553565wrn.697.1669373967118;
        Fri, 25 Nov 2022 02:59:27 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id z14-20020a7bc7ce000000b003cf78aafdd7sm4650935wmk.39.2022.11.25.02.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 02:59:26 -0800 (PST)
Message-ID: <eba53dc3-cfc8-1df5-970b-2c87d350dd09@linaro.org>
Date:   Fri, 25 Nov 2022 10:59:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [V2] spi: spi-geni-qcom: Add support for SE DMA mode
Content-Language: en-US
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com, vkoul@kernel.org
References: <1669040373-23605-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1669040373-23605-1-git-send-email-quic_vnivarth@quicinc.com>
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

Thanks for your patch Vijaya,

On 21/11/2022 14:19, Vijaya Krishna Nivarthi wrote:
> SE DMA mode can be used for larger transfers and FIFO mode
> for smaller transfers.

Over all the patch looks good, but with few minor nits around coding 
conventions.
> 
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>   drivers/spi/spi-geni-qcom.c | 211 ++++++++++++++++++++++++++++++++++----------
>   1 file changed, 165 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 4e83cc5..102529a 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -87,6 +87,8 @@ struct spi_geni_master {
>   	struct completion cs_done;
>   	struct completion cancel_done;
>   	struct completion abort_done;
> +	struct completion tx_reset_done;
> +	struct completion rx_reset_done;
>   	unsigned int oversampling;
>   	spinlock_t lock;
>   	int irq;
> @@ -95,6 +97,7 @@ struct spi_geni_master {
>   	struct dma_chan *tx;
>   	struct dma_chan *rx;
>   	int cur_xfer_mode;
> +	u32 cur_m_cmd;
>   };
>   
>   static int get_spi_clk_cfg(unsigned int speed_hz,
> @@ -129,23 +132,26 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
>   	return ret;
>   }
>   
> -static void handle_fifo_timeout(struct spi_master *spi,
> +static void handle_se_timeout(struct spi_master *spi,
>   				struct spi_message *msg)
indentation looks off.


>   {
>   	struct spi_geni_master *mas = spi_master_get_devdata(spi);
>   	unsigned long time_left;
>   	struct geni_se *se = &mas->se;
> +	const struct spi_transfer *xfer;
>   
>   	spin_lock_irq(&mas->lock);
>   	reinit_completion(&mas->cancel_done);
> -	writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
> +	if (mas->cur_xfer_mode == GENI_SE_FIFO)
> +		writel(0, se->base + SE_GENI_TX_WATERMARK_REG);

empty line here would make the code more readable.

> +	xfer = mas->cur_xfer;
>   	mas->cur_xfer = NULL;
>   	geni_se_cancel_m_cmd(se);
>   	spin_unlock_irq(&mas->lock);
>   
>   	time_left = wait_for_completion_timeout(&mas->cancel_done, HZ);
>   	if (time_left)
> -		return;
> +		goto unmap_if_dma;
>   
>   	spin_lock_irq(&mas->lock);
>   	reinit_completion(&mas->abort_done);
> @@ -162,6 +168,45 @@ static void handle_fifo_timeout(struct spi_master *spi,
>   		 */
>   		mas->abort_failed = true;
>   	}
> +
> +unmap_if_dma:
> +	if (mas->cur_xfer_mode == GENI_SE_DMA) {
> +		if (mas->cur_m_cmd & SPI_TX_ONLY) {
> +			spin_lock_irq(&mas->lock);
> +			reinit_completion(&mas->tx_reset_done);
> +			writel(1, se->base + SE_DMA_TX_FSM_RST);
> +			spin_unlock_irq(&mas->lock);
> +			time_left = wait_for_completion_timeout(&mas->tx_reset_done, HZ);
> +			if (!time_left)
> +				dev_err(mas->dev, "DMA TX RESET failed\n");
> +		}
> +		if (mas->cur_m_cmd & SPI_RX_ONLY) {
> +			spin_lock_irq(&mas->lock);
> +			reinit_completion(&mas->rx_reset_done);
> +			writel(1, se->base + SE_DMA_RX_FSM_RST);
> +			spin_unlock_irq(&mas->lock);
> +			time_left = wait_for_completion_timeout(&mas->rx_reset_done, HZ);
> +			if (!time_left)
> +				dev_err(mas->dev, "DMA RX RESET failed\n");
> +		}
> +
> +		if (xfer) {
> +			if (xfer->tx_buf && xfer->tx_dma)
> +				geni_se_tx_dma_unprep(se, xfer->tx_dma, xfer->len);
> +			if (xfer->rx_buf && xfer->rx_dma)
> +				geni_se_rx_dma_unprep(se, xfer->rx_dma, xfer->len);
> +		} else {
> +			/*
> +			 * This can happen if a timeout happened and we had to wait
> +			 * for lock in this function because isr was holding the lock
> +			 * and handling transfer completion at that time.
> +			 * isr will set cur_xfer to NULL when done.
> +			 * Unnecessary error but cannot be helped.
> +			 * Only do reset, dma_unprep is already done by isr.
> +			 */
> +			dev_err(mas->dev, "Cancel/Abort on completed SPI transfer\n");
> +		}
> +	}
>   }
>   
>   static void handle_gpi_timeout(struct spi_master *spi, struct spi_message *msg)
> @@ -178,7 +223,8 @@ static void spi_geni_handle_err(struct spi_master *spi, struct spi_message *msg)
>   
>   	switch (mas->cur_xfer_mode) {
>   	case GENI_SE_FIFO:
> -		handle_fifo_timeout(spi, msg);
> +	case GENI_SE_DMA:
> +		handle_se_timeout(spi, msg);
>   		break;
>   	case GENI_GPI_DMA:
>   		handle_gpi_timeout(spi, msg);
> @@ -260,7 +306,7 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
>   	time_left = wait_for_completion_timeout(&mas->cs_done, HZ);
>   	if (!time_left) {
>   		dev_warn(mas->dev, "Timeout setting chip select\n");
> -		handle_fifo_timeout(spi, NULL);
> +		handle_se_timeout(spi, NULL);
>   	}
>   
>   exit:
> @@ -482,8 +528,12 @@ static bool geni_can_dma(struct spi_controller *ctlr,
>   {
>   	struct spi_geni_master *mas = spi_master_get_devdata(slv->master);
>   
> -	/* check if dma is supported */
> -	return mas->cur_xfer_mode != GENI_SE_FIFO;
> +	/*
> +	 * Return true if transfer needs to be mapped prior to
> +	 * calling transfer_one which is the case only for GPI_DMA.
> +	 * For SE_DMA mode, map/unmap is done in geni_se_*x_dma_prep.
> +	 */
> +	return mas->cur_xfer_mode == GENI_GPI_DMA;
>   }
>   
>   static int spi_geni_prepare_message(struct spi_master *spi,
> @@ -494,6 +544,7 @@ static int spi_geni_prepare_message(struct spi_master *spi,
>   
>   	switch (mas->cur_xfer_mode) {
>   	case GENI_SE_FIFO:
> +	case GENI_SE_DMA:
>   		if (spi_geni_is_abort_still_pending(mas))
>   			return -EBUSY;
>   		ret = setup_fifo_params(spi_msg->spi, spi);
> @@ -597,7 +648,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
>   			break;
>   		}
>   		/*
> -		 * in case of failure to get dma channel, we can still do the
> +		 * in case of failure to get gpi dma channel, we can still do the
>   		 * FIFO mode, so fallthrough
>   		 */
>   		dev_warn(mas->dev, "FIFO mode disabled, but couldn't get DMA, fall back to FIFO mode\n");
> @@ -716,12 +767,12 @@ static void geni_spi_handle_rx(struct spi_geni_master *mas)
>   	mas->rx_rem_bytes -= rx_bytes;
>   }
>   
> -static void setup_fifo_xfer(struct spi_transfer *xfer,
> +static int setup_se_xfer(struct spi_transfer *xfer,
>   				struct spi_geni_master *mas,
>   				u16 mode, struct spi_master *spi)

consider adjusting the tabs once you change the function name.
>   {
>   	u32 m_cmd = 0;
> -	u32 len;
> +	u32 len, fifo_size;
>   	struct geni_se *se = &mas->se;
>   	int ret;
>   
> @@ -748,7 +799,7 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>   	/* Speed and bits per word can be overridden per transfer */
>   	ret = geni_spi_set_clock_and_bw(mas, xfer->speed_hz);
>   	if (ret)
> -		return;
> +		return ret;
>   
>   	mas->tx_rem_bytes = 0;
>   	mas->rx_rem_bytes = 0;xxxxxxx
> @@ -771,6 +822,13 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>   		writel(len, se->base + SE_SPI_RX_TRANS_LEN);
>   		mas->rx_rem_bytes = xfer->len;
>   	}
> +	mas->cur_m_cmd = m_cmd;
> +
> +	/* Select transfer mode based on transfer length */
> +	fifo_size =
> +		mas->tx_fifo_depth * mas->fifo_width_bits / mas->cur_bits_per_word;

line can go up to 100 chars


> +	mas->cur_xfer_mode = (len <= fifo_size) ? GENI_SE_FIFO : GENI_SE_DMA;

I do not see any protection for cur_xfer_mode? Isn't it true that it 
could be modified here while an interrupt handler is using this?


> +	geni_se_select_mode(se, mas->cur_xfer_mode);
>   
>   	/*
>   	 * Lock around right before we start the transfer since our
> @@ -778,11 +836,39 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>   	 */
>   	spin_lock_irq(&mas->lock);
>   	geni_se_setup_m_cmd(se, m_cmd, FRAGMENTATION);
> -	if (m_cmd & SPI_TX_ONLY) {
> +
> +	if (mas->cur_xfer_mode == GENI_SE_DMA) {
> +		if (m_cmd & SPI_RX_ONLY) {
> +			ret =  geni_se_rx_dma_prep(se, xfer->rx_buf,
> +				xfer->len, &xfer->rx_dma);
> +			if (ret) {
> +				dev_err(mas->dev, "Failed to setup Rx dma %d\n", ret);
> +				xfer->rx_dma = 0;
> +				goto unlock_and_return;
> +			}
> +		}
> +		if (m_cmd & SPI_TX_ONLY) {
> +			ret =  geni_se_tx_dma_prep(se, (void *)xfer->tx_buf,
> +				xfer->len, &xfer->tx_dma);
> +			if (ret) {
> +				dev_err(mas->dev, "Failed to setup Tx dma %d\n", ret);
> +				xfer->tx_dma = 0;
> +				if (m_cmd & SPI_RX_ONLY && xfer->rx_dma) {
> +					/* Unmap rx buffer if duplex transfer */
> +					geni_se_rx_dma_unprep(se, xfer->rx_dma, xfer->len);
> +					xfer->rx_dma = 0;
> +				}
> +				goto unlock_and_return;
> +			}
> +		}
> +	} else if (m_cmd & SPI_TX_ONLY) {
>   		if (geni_spi_handle_tx(mas))
>   			writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
>   	}
> +
> +unlock_and_return:
>   	spin_unlock_irq(&mas->lock);
> +	return ret;
>   }
>   
>   static int spi_geni_transfer_one(struct spi_master *spi,
> @@ -790,6 +876,7 @@ static int spi_geni_transfer_one(struct spi_master *spi,
>   				struct spi_transfer *xfer)
>   {
>   	struct spi_geni_master *mas = spi_master_get_devdata(spi);
> +	int ret;
>   
>   	if (spi_geni_is_abort_still_pending(mas))
>   		return -EBUSY;
> @@ -798,9 +885,12 @@ static int spi_geni_transfer_one(struct spi_master *spi,
>   	if (!xfer->len)
>   		return 0;
>   
> -	if (mas->cur_xfer_mode == GENI_SE_FIFO) {
> -		setup_fifo_xfer(xfer, mas, slv->mode, spi);
> -		return 1;
> +	if (mas->cur_xfer_mode == GENI_SE_FIFO || mas->cur_xfer_mode == GENI_SE_DMA) {
> +		ret = setup_se_xfer(xfer, mas, slv->mode, spi);
> +		/* SPI framework expects +ve ret code to wait for transfer complete */
> +		if (!ret)
> +			ret = 1;
> +		return ret;
>   	}
>   	return setup_gsi_xfer(xfer, mas, slv, spi);
>   }
> @@ -823,39 +913,66 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
>   
>   	spin_lock(&mas->lock);
>   
> -	if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_EN))
> -		geni_spi_handle_rx(mas);
> -
> -	if (m_irq & M_TX_FIFO_WATERMARK_EN)
> -		geni_spi_handle_tx(mas);
> -
> -	if (m_irq & M_CMD_DONE_EN) {
> -		if (mas->cur_xfer) {
> +	if (mas->cur_xfer_mode == GENI_SE_FIFO) {

Switch case?

...

> +		}
> +	} else if (mas->cur_xfer_mode == GENI_SE_DMA) {
> +		const struct spi_transfer *xfer = mas->cur_xfer;


--srini
