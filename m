Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FE46F804F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjEEJr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjEEJrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:47:23 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4682D18FD2
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 02:47:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50be17a1eceso2913794a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 02:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683280040; x=1685872040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3YIVNcQdeZiL3e0O4p6IYO2o8zE6ITS/Zjz/otoIFpA=;
        b=Iqijz+WAZAHtO8uFIvMpu/yycYGpQx+/LpXE9Axcv65dAK4e1uQyPg/LQURKrVpV5Q
         /jufmtJZYot++2wbF9B/cJSSUKvnm2LylqPOS9p4bNP2aoUp7PIgNP0WH+pb+Yp3gPXF
         CqPa07bDfGrdfuG+OlH5axVBI9Eb/7Mo6NHKcw429IFhoPnzVJ0jfgOqdm856Web5UOe
         zDOrus4Wjj45fkQy+Xv38TLJBBsuwkhp3EVJIQD8PGLcThIbQa2334tlweMfMXBM/ayB
         VwuwMyjM1zIAzG+lgu0seXRbkqRY/ZHEt8apMngYB3JMSlS94pofzX7TjWmcbVPuKjEn
         0hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683280040; x=1685872040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YIVNcQdeZiL3e0O4p6IYO2o8zE6ITS/Zjz/otoIFpA=;
        b=U8+wPWxeVUDmWPI4c/qEdJ2mVecfT/kK6ldbSKzXsHbd/X5tqX8DwXGCHyF2o1y7dC
         EsaHl9068aJx64UD8w6xAdOXD7OnkjQOh6UXn62kDeV0FdLmaP3264CUS+rZAqXlrakB
         gV9+NNQYDenhHR7ptPY8J7OOIS8wVKq53xyc02fD8y4+RlyqWgViILdkuh+Dd1r5y9b1
         gLMHmDjmmKQZJkFupqzyh7LMyLSHr7z968tyNJenpF2dZcWhGwqIHbdqVX43PSe61kQ/
         n0x0wJHAwILiaGIKaYhbDYZBxfMWNvrV2IQpDE/FhKp1VPu6mUFHWHB87073LFDvcK2z
         QWBA==
X-Gm-Message-State: AC+VfDyGGldTdclPbRNs6i68WJQlOKbVvRXt4NBytb0G3MBY3+K44ahD
        BEcinc2E13lWH8eCH7E/toQYWw==
X-Google-Smtp-Source: ACHHUZ4nixPNDI7H6BBgyh+5/PxYHS2TDRnhCNQLtbEUh6LobLma18kxhzjldRDZdV8OqSSIZPAcwg==
X-Received: by 2002:a17:907:360c:b0:961:800b:3f1e with SMTP id bk12-20020a170907360c00b00961800b3f1emr616756ejc.73.1683280040379;
        Fri, 05 May 2023 02:47:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id v1-20020a170906292100b00953381ea1b7sm721680ejd.90.2023.05.05.02.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 02:47:20 -0700 (PDT)
Message-ID: <53b60eca-e8ab-3ff3-61a4-019ccac6cd65@linaro.org>
Date:   Fri, 5 May 2023 11:47:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 3/3] spi: s3c64xx: support interrupt based pio mode
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
References: <20230502062813.112434-1-jaewon02.kim@samsung.com>
 <CGME20230502065025epcas2p34507ffad60b32e091ff0efeced9bc12f@epcas2p3.samsung.com>
 <20230502062813.112434-4-jaewon02.kim@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230502062813.112434-4-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 08:28, Jaewon Kim wrote:
> Support interrupt based pio mode to optimize cpu usage.
> When transmitting data size is larget than 32 bytes, operates with
> interrupt based pio mode.
> 
> By using the FIFORDY INT, an interrupt can be triggered when
> the desired size of data has been received. Using this, we can support
> interrupt based pio mode.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 66 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 58 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 2a8304678df9..323c6da9730b 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -58,6 +58,8 @@
>  #define S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD	(1<<17)
>  #define S3C64XX_SPI_MODE_BUS_TSZ_WORD		(2<<17)
>  #define S3C64XX_SPI_MODE_BUS_TSZ_MASK		(3<<17)
> +#define S3C64XX_SPI_MODE_RX_RDY_LVL		GENMASK(16, 11)
> +#define S3C64XX_SPI_MODE_RX_RDY_LVL_SHIFT	11
>  #define S3C64XX_SPI_MODE_SELF_LOOPBACK		(1<<3)
>  #define S3C64XX_SPI_MODE_RXDMA_ON		(1<<2)
>  #define S3C64XX_SPI_MODE_TXDMA_ON		(1<<1)
> @@ -114,6 +116,8 @@
>  
>  #define S3C64XX_SPI_TRAILCNT		S3C64XX_SPI_MAX_TRAILCNT
>  
> +#define S3C64XX_SPI_POLLING_SIZE	32
> +
>  #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
>  #define is_polling(x)	(x->cntrlr_info->polling)
>  
> @@ -552,7 +556,7 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
>  }
>  
>  static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
> -				struct spi_transfer *xfer)
> +				struct spi_transfer *xfer, bool use_irq)
>  {
>  	void __iomem *regs = sdd->regs;
>  	unsigned long val;
> @@ -573,6 +577,12 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
>  	if (RX_FIFO_LVL(status, sdd) < xfer->len)
>  		usleep_range(time_us / 2, time_us);
>  
> +	if (use_irq) {
> +		val = msecs_to_jiffies(ms);
> +		if (!wait_for_completion_timeout(&sdd->xfer_completion, val))
> +			return -EIO;
> +	}
> +
>  	val = msecs_to_loops(ms);
>  	do {
>  		status = readl(regs + S3C64XX_SPI_STATUS);
> @@ -735,10 +745,13 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
>  	void *rx_buf = NULL;
>  	int target_len = 0, origin_len = 0;
>  	int use_dma = 0;
> +	bool use_irq = false;
>  	int status;
>  	u32 speed;
>  	u8 bpw;
>  	unsigned long flags;
> +	u32 rdy_lv;
> +	u32 val;
>  
>  	reinit_completion(&sdd->xfer_completion);
>  
> @@ -759,17 +772,46 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
>  	    sdd->rx_dma.ch && sdd->tx_dma.ch) {
>  		use_dma = 1;
>  
> -	} else if (xfer->len > fifo_len) {
> +	} else if (xfer->len >= fifo_len) {

I don't fully understand this. If len equals to fifo_len, everything
would fit into FIFO so no need for all this?

>  		tx_buf = xfer->tx_buf;
>  		rx_buf = xfer->rx_buf;
>  		origin_len = xfer->len;
> -
>  		target_len = xfer->len;
> -		if (xfer->len > fifo_len)
> -			xfer->len = fifo_len;
> +		xfer->len = fifo_len - 1;
>  	}
>  
>  	do {
> +		/* transfer size is greater than 32, change to IRQ mode */
> +		if (xfer->len > S3C64XX_SPI_POLLING_SIZE)
> +			use_irq = true;
> +
> +		if (use_irq) {
> +			reinit_completion(&sdd->xfer_completion);
> +
> +			rdy_lv = xfer->len;

Style is:

/*
 *

> +			/* Setup RDY_FIFO trigger Level
> +			 * RDY_LVL =
> +			 * fifo_lvl up to 64 byte -> N bytes
> +			 *               128 byte -> RDY_LVL * 2 bytes
> +			 *               256 byte -> RDY_LVL * 4 bytes

I don't understand it. Based on this equation for 256 bytes,
RDY_LVL = RDY_LVL * 4?
Didn't you mean xfer->len?


Best regards,
Krzysztof

