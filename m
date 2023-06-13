Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB0072E2ED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242265AbjFMM2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241995AbjFMM2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:28:03 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177911BC0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:27:06 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b1fcda0f92so67813771fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686659224; x=1689251224;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnIHsMOer6yxwn2k9SpYfq75p+EkWRLUz3RHm/gg720=;
        b=b18DruWzsZolYaqZznZdkfTu68KIPQsuP2GNFxglUtDVf5AVQfkl09rD/TCiiAPvdj
         4/y7kZfN11uk9XdRfRX65J6bwFCf28k9EtcDIKXKAzhCP4uzN/PcZ52goPSI58Pamupu
         H0wil4DyGC02brKQeBq38RWnC4p4vHELAGn4LqTkzw+sU6TuobpfDdlh/fpHe3GUJrGy
         lss4ZFPB9VFviDZaAsPlERxHlVGNG9BvBjZ/TdKPb8Gn80a1RmiAQcZNnZIiZTwWlBw2
         O1tnCDt7sMg2udiKqgpXVyINwL3GFr1FHyAG7gtxyzKZ9tDzxuzoiHC+CDHZ1NscV+qg
         Cdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686659224; x=1689251224;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EnIHsMOer6yxwn2k9SpYfq75p+EkWRLUz3RHm/gg720=;
        b=eAuHWx1FtF2elbtKueibKvpIIFEKr602HwCiLRgfhsmTerGTftsBWe+4CIyDGyjN4z
         UtAFIpjFLYLSOHL2VJDDgBwc8VCbizAQ7ePaXwT6ydvOpoaZvyyxLJoS+yBcmgGIT4cp
         KNezhE+6Hl0Mh7AuqO8NcZiyasAKI00JdYMSoG18U0e7fn8aKcCN3sgb9z4gC2e7WHY/
         Fais7ep/PADy1oZ3BaUanHbEEfQFOLn4zX2EQL/1z3PaqnuEeOL3p6i9YRAkxz4/XCaN
         MxUBqKirsvURSDbnj9kS94RqzuktUty6atmtmBgP+5Q2LNRjIMxCOidC/2ZU+d+HIptI
         KyBQ==
X-Gm-Message-State: AC+VfDzHIk8Ccq99VuB36bQGmal9YIIsUwlegtRm1ZneiGBxrpiMTFmM
        7XOlrep9pKgvo2WB3pTDmlkZryPgCkrXeWexkwI=
X-Google-Smtp-Source: ACHHUZ5yPxfMBP2bj0B5CauySCl/eaKnaBhn1CKtZiZFvx2XOhZvmtfPlz255MpUQtywzrWG/w9zyw==
X-Received: by 2002:a05:651c:22a:b0:2b1:a874:34c9 with SMTP id z10-20020a05651c022a00b002b1a87434c9mr5328357ljn.22.1686659224045;
        Tue, 13 Jun 2023 05:27:04 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id p26-20020a2ea41a000000b002adbedc9962sm2144582ljn.46.2023.06.13.05.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 05:27:03 -0700 (PDT)
Message-ID: <d39df510-c0d0-97c2-4a35-e28829ddd761@linaro.org>
Date:   Tue, 13 Jun 2023 14:27:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     Praveen Talari <quic_ptalari@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_vnivarth@quicinc.com, quic_arandive@quicinc.com
References: <20230613065229.5619-1-quic_ptalari@quicinc.com>
 <20230613065229.5619-3-quic_ptalari@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 2/2] spi: spi-geni-qcom: Add SPI SLAVE mode support for
 GENI based QuPv3
In-Reply-To: <20230613065229.5619-3-quic_ptalari@quicinc.com>
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



On 13.06.2023 08:52, Praveen Talari wrote:
> Add SPI SLAVE mode support for GENI based QuPv3.
> 
Copying the commit title in the commit message is a bit lackluster for
adding new functionality.

> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
> ---
>  drivers/spi/spi-geni-qcom.c | 55 +++++++++++++++++++++++++++++++++----
>  1 file changed, 49 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 206cc04bb1ed..2e3ae29e79e0 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -12,6 +12,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>  #include <linux/soc/qcom/geni-se.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spinlock.h>
> @@ -52,6 +53,9 @@
>  #define SPI_CS_CLK_DELAY_MSK		GENMASK(19, 10)
>  #define SPI_CS_CLK_DELAY_SHFT		10
>  
> +#define SE_SPI_SLAVE_EN				(0x2BC)
> +#define SPI_SLAVE_EN				BIT(0)
> +
>  /* M_CMD OP codes for SPI */
>  #define SPI_TX_ONLY		1
>  #define SPI_RX_ONLY		2
> @@ -99,6 +103,24 @@ struct spi_geni_master {
>  	int cur_xfer_mode;
>  };
>  
> +static struct spi_master *get_spi_master(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct spi_master *spi = platform_get_drvdata(pdev);
> +
> +	return spi;
> +}
> +
> +static void spi_slv_setup(struct spi_geni_master *mas)
> +{
> +	struct geni_se *se = &mas->se;
> +
> +	writel(SPI_SLAVE_EN, se->base + SE_SPI_SLAVE_EN);
> +	writel(GENI_IO_MUX_0_EN, se->base + GENI_OUTPUT_CTRL);
> +	writel(START_TRIGGER, se->base + SE_GENI_CFG_SEQ_START);
> +	dev_info(mas->dev, "spi slave setup done\n");
dev_dbg

> +}
> +
>  static int get_spi_clk_cfg(unsigned int speed_hz,
>  			struct spi_geni_master *mas,
>  			unsigned int *clk_idx,
> @@ -140,12 +162,18 @@ static void handle_se_timeout(struct spi_master *spi,
>  	const struct spi_transfer *xfer;
>  
>  	spin_lock_irq(&mas->lock);
> -	reinit_completion(&mas->cancel_done);
>  	if (mas->cur_xfer_mode == GENI_SE_FIFO)
>  		writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
>  
>  	xfer = mas->cur_xfer;
>  	mas->cur_xfer = NULL;
> +
> +	if (spi->slave) {
> +		spin_unlock_irq(&mas->lock);
> +		goto unmap_if_dma;
> +	}
> +
> +	reinit_completion(&mas->cancel_done);
Moving reiniting cancel_done after possibly writing the register
for both mas/slv cases sounds like a separate change - is it
necessary?

>  	geni_se_cancel_m_cmd(se);
>  	spin_unlock_irq(&mas->lock);
>  
> @@ -541,6 +569,8 @@ static bool geni_can_dma(struct spi_controller *ctlr,
>  
>  	if (mas->cur_xfer_mode == GENI_GPI_DMA)
>  		return true;
> +	if (ctlr->slave)
> +		return true;
Regardless of the xfer mode?

>  
>  	len = get_xfer_len_in_words(xfer, mas);
>  	fifo_size = mas->tx_fifo_depth * mas->fifo_width_bits / mas->cur_bits_per_word;
> @@ -619,6 +649,7 @@ static void spi_geni_release_dma_chan(struct spi_geni_master *mas)
>  
>  static int spi_geni_init(struct spi_geni_master *mas)
>  {
> +	struct spi_master *spi = get_spi_master(mas->dev);
>  	struct geni_se *se = &mas->se;
>  	unsigned int proto, major, minor, ver;
>  	u32 spi_tx_cfg, fifo_disable;
> @@ -627,7 +658,14 @@ static int spi_geni_init(struct spi_geni_master *mas)
>  	pm_runtime_get_sync(mas->dev);
>  
>  	proto = geni_se_read_proto(se);
> -	if (proto != GENI_SE_SPI) {
> +
> +	if (spi->slave) {
> +		if (proto != GENI_SE_SPI_SLAVE) {
> +			dev_err(mas->dev, "Invalid proto %d\n", proto);
> +			goto out_pm;
> +		}
> +		spi_slv_setup(mas);
> +	} else if (proto != GENI_SE_SPI) {
>  		dev_err(mas->dev, "Invalid proto %d\n", proto);
>  		goto out_pm;
>  	}
> @@ -677,9 +715,11 @@ static int spi_geni_init(struct spi_geni_master *mas)
>  	}
>  
>  	/* We always control CS manually */
> -	spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
> -	spi_tx_cfg &= ~CS_TOGGLE;
> -	writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
> +	if (!spi->slave) {
> +		spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
> +		spi_tx_cfg &= ~CS_TOGGLE;
> +		writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
> +	}
>  
>  out_pm:
>  	pm_runtime_put(mas->dev);
> @@ -1072,6 +1112,9 @@ static int spi_geni_probe(struct platform_device *pdev)
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, 250);
>  	pm_runtime_enable(dev);
>  
> +	if (device_property_read_bool(&pdev->dev, "qcom,slv-ctrl"))
> +		spi->slave = true;
Missing dt-bindings

Konrad
> +
>  	ret = geni_icc_get(&mas->se, NULL);
>  	if (ret)
>  		goto spi_geni_probe_runtime_disable;
> @@ -1092,7 +1135,7 @@ static int spi_geni_probe(struct platform_device *pdev)
>  	 * for dma (gsi) mode, the gsi will set cs based on params passed in
>  	 * TRE
>  	 */
> -	if (mas->cur_xfer_mode == GENI_SE_FIFO)
> +	if (!spi->slave && mas->cur_xfer_mode == GENI_SE_FIFO)`
>  		spi->set_cs = spi_geni_set_cs;
>  
>  	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
