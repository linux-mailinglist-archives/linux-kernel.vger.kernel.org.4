Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6FF724995
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbjFFQ4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbjFFQ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:56:37 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A8C10C3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 09:56:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f61735676fso5433632e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686070588; x=1688662588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFwK8EwMZfbISMM8sr4s6RoQW2if9Lq5P8SAswp11wQ=;
        b=AE0Pg6ilcmMwKmvdDvzbEO1+VG43VT9U6GXxRjNajH/sYWBtoCBCe1IYSYBfOmPXvE
         m9FYd0u9EuXLWAqHT7egB+nryZZ3J/ldoQiOKYe4M/ub9q5V2HWDmjazmq6v+aXueXEw
         U08NPUq/H+0MGfB7wRcsRXblQcdoSYfvXNKt32TAY5vM/uYKpjIAz6xe+Z0qgGA5C6fn
         kEWBj6ZhbMCtoOkmYIb8eXqoxerPP+MGj1GM+B6GKPFeifkvHH1L5LZa7cR3bGrUxp+s
         LmxYWl1Wp0E9D/2enasdwQMDRu2/PZ7zrLDd7e3IvQwKvmWUEKf/9xxDiU1AhVr2VT1I
         bRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686070588; x=1688662588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFwK8EwMZfbISMM8sr4s6RoQW2if9Lq5P8SAswp11wQ=;
        b=VyrpAFyF/5jvT/JoKWR8FFXNbzyc6/J3trHxtJoj3ToR9P9lX0AVwVTU2+XY57AGHK
         DX1CjmZLy05s5MPkN3m+gxib+SvadTcV0UuUQ9HZ58Xp9sByGVjq7YcIcf6uyOcDGsmy
         PCufbmI/XWRHnQtfHq42a1Xv+WoEjvBow/N1EOrvjNw18GrjW5F9l1n/ev9HrZzTlk6K
         d048a89hCH1J5ZsGlhMgFBmrmExb2iJaLNEG/b0W1K1a3frrHX+pbOHy/nqrY2C6eXUU
         28t7vif36NC7CZ2AfQuwa8D+m/lCx8fdJ8AQkSKs5bDf+BGJb4fLAIErjrg9q5WD8FwL
         Jw0Q==
X-Gm-Message-State: AC+VfDyFEmOnNlUJNaQsKSM7FPdZ5BRrcEE0WZUg4ZrIe8XPkhJVnM26
        zPN0yM3cd2V1P+8U4nmDGITqTA==
X-Google-Smtp-Source: ACHHUZ6a0E3XFI2iCSrdfdaqeDso65bzF2WfaHxy661qLzJv1mDqQ0LyKdd0IUWL+ztOnxQl2h7urQ==
X-Received: by 2002:ac2:44d8:0:b0:4f6:1c08:e9b0 with SMTP id d24-20020ac244d8000000b004f61c08e9b0mr1072876lfm.63.1686070588050;
        Tue, 06 Jun 2023 09:56:28 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id a22-20020ac25216000000b004f42718cbb1sm1497803lfl.292.2023.06.06.09.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 09:56:27 -0700 (PDT)
Message-ID: <9a1cf84c-e48c-f41d-2e2f-5c106fc1fed4@linaro.org>
Date:   Tue, 6 Jun 2023 18:56:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/2] spi: spi-geni-qcom: Do not do DMA map/unmap inside
 driver, use framework instead
Content-Language: en-US
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, broonie@kernel.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, quic_ptalari@quicinc.com
References: <1684325894-30252-1-git-send-email-quic_vnivarth@quicinc.com>
 <1684325894-30252-3-git-send-email-quic_vnivarth@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1684325894-30252-3-git-send-email-quic_vnivarth@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.05.2023 14:18, Vijaya Krishna Nivarthi wrote:
> The spi geni driver in SE DMA mode, unlike GSI DMA, is not making use of
> DMA mapping functionality available in the framework.
> The driver does mapping internally which makes dma buffer fields available
> in spi_transfer struct superfluous while requiring additional members in
> spi_geni_master struct.
> 
> Conform to the design by having framework handle map/unmap and do only
> DMA transfer in the driver; this also simplifies code a bit.
> 
> Fixes: e5f0dfa78ac7 ("spi: spi-geni-qcom: Add support for SE DMA mode")
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
I don't really have a good insight in this code, but these changes
seem sane.

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> v1 -> v2:
> - pass dma address to new geni interfaces instead of pointer
> - set max_dma_len as per HPG
> - remove expendable local variables
> ---
>  drivers/spi/spi-geni-qcom.c | 103 +++++++++++++++++++++-----------------------
>  1 file changed, 50 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index e423efc..206cc04 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -97,8 +97,6 @@ struct spi_geni_master {
>  	struct dma_chan *tx;
>  	struct dma_chan *rx;
>  	int cur_xfer_mode;
> -	dma_addr_t tx_se_dma;
> -	dma_addr_t rx_se_dma;
>  };
>  
>  static int get_spi_clk_cfg(unsigned int speed_hz,
> @@ -174,7 +172,7 @@ static void handle_se_timeout(struct spi_master *spi,
>  unmap_if_dma:
>  	if (mas->cur_xfer_mode == GENI_SE_DMA) {
>  		if (xfer) {
> -			if (xfer->tx_buf && mas->tx_se_dma) {
> +			if (xfer->tx_buf) {
>  				spin_lock_irq(&mas->lock);
>  				reinit_completion(&mas->tx_reset_done);
>  				writel(1, se->base + SE_DMA_TX_FSM_RST);
> @@ -182,9 +180,8 @@ static void handle_se_timeout(struct spi_master *spi,
>  				time_left = wait_for_completion_timeout(&mas->tx_reset_done, HZ);
>  				if (!time_left)
>  					dev_err(mas->dev, "DMA TX RESET failed\n");
> -				geni_se_tx_dma_unprep(se, mas->tx_se_dma, xfer->len);
>  			}
> -			if (xfer->rx_buf && mas->rx_se_dma) {
> +			if (xfer->rx_buf) {
>  				spin_lock_irq(&mas->lock);
>  				reinit_completion(&mas->rx_reset_done);
>  				writel(1, se->base + SE_DMA_RX_FSM_RST);
> @@ -192,7 +189,6 @@ static void handle_se_timeout(struct spi_master *spi,
>  				time_left = wait_for_completion_timeout(&mas->rx_reset_done, HZ);
>  				if (!time_left)
>  					dev_err(mas->dev, "DMA RX RESET failed\n");
> -				geni_se_rx_dma_unprep(se, mas->rx_se_dma, xfer->len);
>  			}
>  		} else {
>  			/*
> @@ -523,17 +519,36 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
>  	return 1;
>  }
>  
> +static u32 get_xfer_len_in_words(struct spi_transfer *xfer,
> +				struct spi_geni_master *mas)
> +{
> +	u32 len;
> +
> +	if (!(mas->cur_bits_per_word % MIN_WORD_LEN))
> +		len = xfer->len * BITS_PER_BYTE / mas->cur_bits_per_word;
> +	else
> +		len = xfer->len / (mas->cur_bits_per_word / BITS_PER_BYTE + 1);
> +	len &= TRANS_LEN_MSK;
> +
> +	return len;
> +}
> +
>  static bool geni_can_dma(struct spi_controller *ctlr,
>  			 struct spi_device *slv, struct spi_transfer *xfer)
>  {
>  	struct spi_geni_master *mas = spi_master_get_devdata(slv->master);
> +	u32 len, fifo_size;
>  
> -	/*
> -	 * Return true if transfer needs to be mapped prior to
> -	 * calling transfer_one which is the case only for GPI_DMA.
> -	 * For SE_DMA mode, map/unmap is done in geni_se_*x_dma_prep.
> -	 */
> -	return mas->cur_xfer_mode == GENI_GPI_DMA;
> +	if (mas->cur_xfer_mode == GENI_GPI_DMA)
> +		return true;
> +
> +	len = get_xfer_len_in_words(xfer, mas);
> +	fifo_size = mas->tx_fifo_depth * mas->fifo_width_bits / mas->cur_bits_per_word;
> +
> +	if (len > fifo_size)
> +		return true;
> +	else
> +		return false;
>  }
>  
>  static int spi_geni_prepare_message(struct spi_master *spi,
> @@ -772,7 +787,7 @@ static int setup_se_xfer(struct spi_transfer *xfer,
>  				u16 mode, struct spi_master *spi)
>  {
>  	u32 m_cmd = 0;
> -	u32 len, fifo_size;
> +	u32 len;
>  	struct geni_se *se = &mas->se;
>  	int ret;
>  
> @@ -804,11 +819,7 @@ static int setup_se_xfer(struct spi_transfer *xfer,
>  	mas->tx_rem_bytes = 0;
>  	mas->rx_rem_bytes = 0;
>  
> -	if (!(mas->cur_bits_per_word % MIN_WORD_LEN))
> -		len = xfer->len * BITS_PER_BYTE / mas->cur_bits_per_word;
> -	else
> -		len = xfer->len / (mas->cur_bits_per_word / BITS_PER_BYTE + 1);
> -	len &= TRANS_LEN_MSK;
> +	len = get_xfer_len_in_words(xfer, mas);
>  
>  	mas->cur_xfer = xfer;
>  	if (xfer->tx_buf) {
> @@ -823,9 +834,20 @@ static int setup_se_xfer(struct spi_transfer *xfer,
>  		mas->rx_rem_bytes = xfer->len;
>  	}
>  
> -	/* Select transfer mode based on transfer length */
> -	fifo_size = mas->tx_fifo_depth * mas->fifo_width_bits / mas->cur_bits_per_word;
> -	mas->cur_xfer_mode = (len <= fifo_size) ? GENI_SE_FIFO : GENI_SE_DMA;
> +	/*
> +	 * Select DMA mode if sgt are present; and with only 1 entry
> +	 * This is not a serious limitation because the xfer buffers are
> +	 * expected to fit into in 1 entry almost always, and if any
> +	 * doesn't for any reason we fall back to FIFO mode anyway
> +	 */
> +	if (!xfer->tx_sg.nents && !xfer->rx_sg.nents)
> +		mas->cur_xfer_mode = GENI_SE_FIFO;
> +	else if (xfer->tx_sg.nents > 1 || xfer->rx_sg.nents > 1) {
> +		dev_warn_once(mas->dev, "Doing FIFO, cannot handle tx_nents-%d, rx_nents-%d\n",
> +			xfer->tx_sg.nents, xfer->rx_sg.nents);
> +		mas->cur_xfer_mode = GENI_SE_FIFO;
> +	} else
> +		mas->cur_xfer_mode = GENI_SE_DMA;
>  	geni_se_select_mode(se, mas->cur_xfer_mode);
>  
>  	/*
> @@ -836,35 +858,17 @@ static int setup_se_xfer(struct spi_transfer *xfer,
>  	geni_se_setup_m_cmd(se, m_cmd, FRAGMENTATION);
>  
>  	if (mas->cur_xfer_mode == GENI_SE_DMA) {
> -		if (m_cmd & SPI_RX_ONLY) {
> -			ret =  geni_se_rx_dma_prep(se, xfer->rx_buf,
> -				xfer->len, &mas->rx_se_dma);
> -			if (ret) {
> -				dev_err(mas->dev, "Failed to setup Rx dma %d\n", ret);
> -				mas->rx_se_dma = 0;
> -				goto unlock_and_return;
> -			}
> -		}
> -		if (m_cmd & SPI_TX_ONLY) {
> -			ret =  geni_se_tx_dma_prep(se, (void *)xfer->tx_buf,
> -				xfer->len, &mas->tx_se_dma);
> -			if (ret) {
> -				dev_err(mas->dev, "Failed to setup Tx dma %d\n", ret);
> -				mas->tx_se_dma = 0;
> -				if (m_cmd & SPI_RX_ONLY) {
> -					/* Unmap rx buffer if duplex transfer */
> -					geni_se_rx_dma_unprep(se, mas->rx_se_dma, xfer->len);
> -					mas->rx_se_dma = 0;
> -				}
> -				goto unlock_and_return;
> -			}
> -		}
> +		if (m_cmd & SPI_RX_ONLY)
> +			geni_se_rx_init_dma(se, sg_dma_address(xfer->rx_sg.sgl),
> +				sg_dma_len(xfer->rx_sg.sgl));
> +		if (m_cmd & SPI_TX_ONLY)
> +			geni_se_tx_init_dma(se, sg_dma_address(xfer->tx_sg.sgl),
> +				sg_dma_len(xfer->tx_sg.sgl));
>  	} else if (m_cmd & SPI_TX_ONLY) {
>  		if (geni_spi_handle_tx(mas))
>  			writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
>  	}
>  
> -unlock_and_return:
>  	spin_unlock_irq(&mas->lock);
>  	return ret;
>  }
> @@ -965,14 +969,6 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
>  		if (dma_rx_status & RX_RESET_DONE)
>  			complete(&mas->rx_reset_done);
>  		if (!mas->tx_rem_bytes && !mas->rx_rem_bytes && xfer) {
> -			if (xfer->tx_buf && mas->tx_se_dma) {
> -				geni_se_tx_dma_unprep(se, mas->tx_se_dma, xfer->len);
> -				mas->tx_se_dma = 0;
> -			}
> -			if (xfer->rx_buf && mas->rx_se_dma) {
> -				geni_se_rx_dma_unprep(se, mas->rx_se_dma, xfer->len);
> -				mas->rx_se_dma = 0;
> -			}
>  			spi_finalize_current_transfer(spi);
>  			mas->cur_xfer = NULL;
>  		}
> @@ -1057,6 +1053,7 @@ static int spi_geni_probe(struct platform_device *pdev)
>  	spi->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
>  	spi->num_chipselect = 4;
>  	spi->max_speed_hz = 50000000;
> +	spi->max_dma_len = 0xffff0; /* 24 bits for tx/rx dma length */
>  	spi->prepare_message = spi_geni_prepare_message;
>  	spi->transfer_one = spi_geni_transfer_one;
>  	spi->can_dma = geni_can_dma;
