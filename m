Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0BE74AC49
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjGGHv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjGGHvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:51:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1963A2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 00:51:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3143b72c5ffso1786749f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 00:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688716311; x=1691308311;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UC5F0FA71mhMEgXpkNWdObl4xUHsYLbWZcNLdSixP60=;
        b=wZxj4FwJnEuUXQUynRvoqIwtLtG3qgMtWZ6/8COXXEN8Qhl3ctiOhEBl1ncuaOu8/G
         la2v/U/9a0RqxDjSIv5VQD9RN+VzuHF1HICjL2ZPWdPDkmIcPN9KAYpMYNP7S2eIgA1I
         4735860OkAZEY51MYcEfjICwmCON0rBlBs+itbxcWn+kc+kfoYD891WVYnlQmFTkZ26w
         JwkD9/HjxhTkKqHoTMBG7UcTXF1iYMALia43F1ui75i7EcUXko1kho5xriFTKk8ym8Jd
         qgaGQvcHVmB+0ZgbG+ACVF5aPoYnhqZrUV9vGo7tXc6ViIqcQKvGBNeGlTEkgR7J8gTd
         I+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688716311; x=1691308311;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UC5F0FA71mhMEgXpkNWdObl4xUHsYLbWZcNLdSixP60=;
        b=fxTBZ99AzGUhy0+mEQh/j64I2PYOyu3UMVMOu0Xt+FcrH7goT8cbX2rcY2KOauJ6X3
         MnmAo6rW5kWlHlvIZXEg8ZVHas4OIFjHM0tLZfosZ+4JB9Q6FwNoxlNA/HNLGKoLKfQm
         8rIOav0S4q9osvNNeL1K/81o853sz1/NURSCUVPQM7HNubEkXBah7TpHp14+aF5Z+UyI
         E7KfE/RkeEw/HXRA7th11qIKESPXgN92MH8tY62eWK2Rjroezf5aX8/NdwOIdrYvs8fM
         FZXtfCZSEvYi7AL1TCCqRL35HjkqSZGoUkOYER+3CCkQTLMNx2ZkRWIxlqEjSC2cH50M
         ecRA==
X-Gm-Message-State: ABy/qLYMJzn+dRRtNyAF3r+Diviun6ku046JhOgSepxuVBgrqOE62AVF
        Fza/Ue3J0uo+6u5jKBTzReD4Gw==
X-Google-Smtp-Source: APBJJlFs77aJEcKl47rs6zmBGWRedkrw2mAlemkoqQjXu7RZz1IOFErpMhKmP0OOEG2NyGaZi6PVeQ==
X-Received: by 2002:a5d:6045:0:b0:314:52b4:cc38 with SMTP id j5-20020a5d6045000000b0031452b4cc38mr5275076wrt.52.1688716310914;
        Fri, 07 Jul 2023 00:51:50 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id f18-20020adff992000000b003143c532431sm3775318wrr.27.2023.07.07.00.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 00:51:50 -0700 (PDT)
Message-ID: <1f962997-82f9-18e3-f95d-e1b723e636f8@linaro.org>
Date:   Fri, 7 Jul 2023 09:51:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/2] spi: amlogic-spifc-a1: implement adjust_op_size()
Content-Language: en-US
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
References: <20230706110331.19794-1-mmkurbanov@sberdevices.ru>
 <20230706110331.19794-2-mmkurbanov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230706110331.19794-2-mmkurbanov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 06/07/2023 13:03, Martin Kurbanov wrote:
> This enhancement eliminates the need for a loop in the
> amlogic_spifc_a1_exec_op() function and allows the SPI core to
> dynamically divide transactions into appropriately sized chunks.
> 
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> ---
>   drivers/spi/spi-amlogic-spifc-a1.c | 66 +++++++++++-------------------
>   1 file changed, 25 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/spi/spi-amlogic-spifc-a1.c b/drivers/spi/spi-amlogic-spifc-a1.c
> index 3c4224c38399..a92e4fc23396 100644
> --- a/drivers/spi/spi-amlogic-spifc-a1.c
> +++ b/drivers/spi/spi-amlogic-spifc-a1.c
> @@ -72,7 +72,7 @@
>   
>   #define SPIFC_A1_USER_DBUF_ADDR_REG	0x248
>   
> -#define SPIFC_A1_BUFFER_SIZE		512
> +#define SPIFC_A1_BUFFER_SIZE		512U
>   
>   #define SPIFC_A1_MAX_HZ			200000000
>   #define SPIFC_A1_MIN_HZ			1000000
> @@ -240,61 +240,44 @@ static int amlogic_spifc_a1_exec_op(struct spi_mem *mem,
>   {
>   	struct amlogic_spifc_a1 *spifc =
>   		spi_controller_get_devdata(mem->spi->controller);
> -	size_t off, nbytes = op->data.nbytes;
> -	u32 cmd_cfg, addr_cfg, dummy_cfg, dmode;
> +	size_t data_size = op->data.nbytes;
>   	int ret;
>   
>   	amlogic_spifc_a1_user_init(spifc);
> +	amlogic_spifc_a1_set_cmd(spifc, SPIFC_A1_USER_CMD(op));
>   
> -	cmd_cfg = SPIFC_A1_USER_CMD(op);
> -	amlogic_spifc_a1_set_cmd(spifc, cmd_cfg);
> +	if (op->addr.nbytes)
> +		amlogic_spifc_a1_set_addr(spifc, op->addr.val,
> +					  SPIFC_A1_USER_ADDR(op));
>   
> -	if (op->addr.nbytes) {
> -		addr_cfg = SPIFC_A1_USER_ADDR(op);
> -		amlogic_spifc_a1_set_addr(spifc, op->addr.val, addr_cfg);
> -	}
> -
> -	if (op->dummy.nbytes) {
> -		dummy_cfg = SPIFC_A1_USER_DUMMY(op);
> -		amlogic_spifc_a1_set_dummy(spifc, dummy_cfg);
> -	}
> -
> -	if (!op->data.nbytes)
> -		return amlogic_spifc_a1_request(spifc, false);
> -
> -	dmode = ilog2(op->data.buswidth);
> -	off = 0;
> -
> -	do {
> -		size_t block_size = min_t(size_t, nbytes, SPIFC_A1_BUFFER_SIZE);
> -
> -		amlogic_spifc_a1_set_cmd(spifc, cmd_cfg);
> +	if (op->dummy.nbytes)
> +		amlogic_spifc_a1_set_dummy(spifc, SPIFC_A1_USER_DUMMY(op));
>   
> -		if (op->addr.nbytes)
> -			amlogic_spifc_a1_set_addr(spifc, op->addr.val + off,
> -						  addr_cfg);
> -
> -		if (op->dummy.nbytes)
> -			amlogic_spifc_a1_set_dummy(spifc, dummy_cfg);
> +	if (data_size) {
> +		u32 mode = ilog2(op->data.buswidth);
>   
>   		writel(0, spifc->base + SPIFC_A1_USER_DBUF_ADDR_REG);
>   
>   		if (op->data.dir == SPI_MEM_DATA_IN)
> -			ret = amlogic_spifc_a1_read(spifc,
> -						    op->data.buf.in + off,
> -						    block_size, dmode);
> +			ret = amlogic_spifc_a1_read(spifc, op->data.buf.in,
> +						    data_size, mode);
>   		else
> -			ret = amlogic_spifc_a1_write(spifc,
> -						     op->data.buf.out + off,
> -						     block_size, dmode);
> -
> -		nbytes -= block_size;
> -		off += block_size;
> -	} while (nbytes != 0 && !ret);
> +			ret = amlogic_spifc_a1_write(spifc, op->data.buf.out,
> +						     data_size, mode);
> +	} else {
> +		ret = amlogic_spifc_a1_request(spifc, false);
> +	}
>   
>   	return ret;
>   }
>   
> +static int amlogic_spifc_a1_adjust_op_size(struct spi_mem *mem,
> +					   struct spi_mem_op *op)
> +{
> +	op->data.nbytes = min(op->data.nbytes, SPIFC_A1_BUFFER_SIZE);
> +	return 0;
> +}
> +
>   static void amlogic_spifc_a1_hw_init(struct amlogic_spifc_a1 *spifc)
>   {
>   	u32 regv;
> @@ -314,6 +297,7 @@ static void amlogic_spifc_a1_hw_init(struct amlogic_spifc_a1 *spifc)
>   
>   static const struct spi_controller_mem_ops amlogic_spifc_a1_mem_ops = {
>   	.exec_op = amlogic_spifc_a1_exec_op,
> +	.adjust_op_size = amlogic_spifc_a1_adjust_op_size,
>   };
>   
>   static int amlogic_spifc_a1_probe(struct platform_device *pdev)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
