Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1CE6E74E3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjDSIVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjDSIVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:21:12 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DDA7DA2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:21:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sz19so22454648ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681892469; x=1684484469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RqPKWPiQ8+y3+LyUWsBFNDNPzOI/PBWOQwZkMXBI3Es=;
        b=CJ5scG94dQsUIHi9sqRUZJKMVOsTwn1NecluOHiKAbgJykZvznbFd0zpBhnVJY4UcT
         Ove0nf3k7Jiu1jl+r96JzEg/I9WyKDXz7zeIJK4XQchNvByhRm6gW6mkyKWnremO03dx
         aLwkBAtdxAU3cPxEMEf/tSToAi5FodUFrx9RKcRhzoc0bvYazsHc9GuXfqqARvM2mNxO
         sjoGP3EkOA3de7t7Z954LOoRWf6P5ZgRUu+2RCyqW4QRoNWl3XeB2juJVF1pW55jQ6/n
         MrdKSQSJ8QKOMYAH0cv5pS2K1AHLcIBlsFoiIbKZhTaUTvgjQkC5AKQuSljgyE+C2pqf
         d29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681892469; x=1684484469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RqPKWPiQ8+y3+LyUWsBFNDNPzOI/PBWOQwZkMXBI3Es=;
        b=CMgpRBq4I5JUpZ7E2pHBHePDDRpFmHxe5W0VGaoQdzeK5pf3I+tpSCW42lLddY/MNA
         QuZB4PeYrkOGfgifF64UrodPjUO+jzdOytDg6xFKSF6jhyQhavLIm6/6Ga7ZcaVN507B
         YcwEF1sq06IGV8tXsYWOUs+EzOa7E7bbEUu9FkeFBtNplb67tFnO3MH6SCTDQOv9/jbO
         tODG9MCauW8nARJccHKL9iBKjHDUx2nFtltAUxjFoAL7gWNxfhJbjqPi6DzI8z3jFaRj
         1Wv2zJjt+tVWtpTatkiIIgJMYecRtP4pZMbcmxAXja2ijGP1jpTNlZlquax2WKcTgq1v
         rh2A==
X-Gm-Message-State: AAQBX9eoMmIz4hWS8g6uloGk8vX1ZRkMxQOMKfrtUaNgWU3bw6ZzWMMi
        7j8Ujh29O9kseIdkpUqvJ3ccuw==
X-Google-Smtp-Source: AKy350ZBV0waGDxi1JEvFsVajSenAMWdYIAAtiJEIOQ38Iq0E2LTPpkv9e81HyNBnJkmHg0Q0nqrKw==
X-Received: by 2002:a17:906:3e5b:b0:94f:31ee:ba36 with SMTP id t27-20020a1709063e5b00b0094f31eeba36mr11551763eji.37.1681892468650;
        Wed, 19 Apr 2023 01:21:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:62f5:eb43:f726:5fee? ([2a02:810d:15c0:828:62f5:eb43:f726:5fee])
        by smtp.gmail.com with ESMTPSA id hv14-20020a17090760ce00b0095251a3d66fsm2022814ejc.119.2023.04.19.01.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 01:21:08 -0700 (PDT)
Message-ID: <88e74f8f-feee-159a-3048-736a5ffc13cd@linaro.org>
Date:   Wed, 19 Apr 2023 10:21:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 4/4] spi: s3c64xx: support interrupt based pio mode
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
References: <20230419060639.38853-1-jaewon02.kim@samsung.com>
 <CGME20230419062755epcas2p43a1127f4bb28cf1cf3f42e5d3cc597cd@epcas2p4.samsung.com>
 <20230419060639.38853-5-jaewon02.kim@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230419060639.38853-5-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 08:06, Jaewon Kim wrote:
> Interrupt based pio mode is supported to reduce CPU load.
> If transfer size is larger than 32 byte, it is processed using interrupt.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 82 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 67 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index cf3060b2639b..ce1afb9a4ed4 100644
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
> @@ -552,10 +556,11 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
>  }
>  
>  static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
> -				struct spi_transfer *xfer)
> +				struct spi_transfer *xfer, int use_irq)
>  {
>  	void __iomem *regs = sdd->regs;
>  	unsigned long val;
> +	unsigned long time;
>  	u32 status;
>  	int loops;
>  	u32 cpy_len;
> @@ -563,17 +568,24 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
>  	int ms;
>  	u32 tx_time;
>  
> -	/* sleep during signal transfer time */
> -	status = readl(regs + S3C64XX_SPI_STATUS);
> -	if (RX_FIFO_LVL(status, sdd) < xfer->len) {
> -		tx_time = (xfer->len * 8 * 1000 * 1000) / sdd->cur_speed;
> -		usleep_range(tx_time / 2, tx_time);
> -	}

You just added this code. Adding and immediately removing it, suggests
this should be one patch.


Best regards,
Krzysztof

