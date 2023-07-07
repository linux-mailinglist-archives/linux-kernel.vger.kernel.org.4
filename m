Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158B774AC4B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjGGHwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjGGHv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:51:58 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC309E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 00:51:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so17214185e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 00:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688716315; x=1691308315;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fNjkrmHlVFVreNzwzaKJvD6JsSUBJp+mLtd6ewiqgXQ=;
        b=sWEH5WwI7bhnW/i/z8rWRazBTtRWAFrJJo0dkgILYH6YOicm2QmFZi8o+uCxrp0glq
         4soNB8RNtfI907MoOU4CWJDc/pSkVhzdHcoX438KWZ0RXpMBQqnU10rYnQ2EKyTI9RLW
         nvVTZjaHdOgKF9KjjzquiPMIGEHbXih3qzuOFrOnOUDgiQcdaNs/s2XshxXS+FL1pxzn
         Uo58f6Lj8t8PPDBpRZXwXuNTDBBTP8Fkd3isks81T9OUdVxfcgS09JmFJ4+vyjoqqVui
         uu+2IXHQJoWHSmPiJOdm+XdkGLpbbv+1Eo2s91QCOGWiqMRG1LzMY9DA8UhT0H8rjZrJ
         AXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688716315; x=1691308315;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNjkrmHlVFVreNzwzaKJvD6JsSUBJp+mLtd6ewiqgXQ=;
        b=augFIFsHxML75xKQVJ8nYGR88SrXZUaD/ecO+et9S0vEc9gozCfbqnCWfYnFvVWGs6
         JHoNSbjV0Tz5attK7GuIACcOZ+0yn5waHeD4TACG/oEedmt8dee8QvgdyG6BjxjQs4Da
         GT8LQgvpUShnQBupGHiVDA7M3n1U8HwEABcx+JSbtxCBqqqozE5OWpz3zfRGSNXGRIBr
         LJo7cv7pUWN8oJjqqsIfp0vYTnwkBfCICBtwjz3wP+NddeKMlTOyvsAkuWHDbyHWdoj+
         mVQkwQSXjNklE4BqN1+V323x3R4pOfafS8O3/7K904x1mozYGGNW1hLgHigoYgCgCXx0
         XdgA==
X-Gm-Message-State: ABy/qLZCkZOxKWyahmlpxVHumS3d1mbxYabvR4fZTvm+PklG0Y1tovKR
        G8AFF0gF7FEtDIEdlcdM/4sERA==
X-Google-Smtp-Source: APBJJlGUGxXsBpTAc6TQLncOqANnfeX8QE1aA12YKms/Zgz+2Sm5TxR7hq055te3JAWT1/YWJNmuKw==
X-Received: by 2002:a5d:452f:0:b0:313:df08:7b7e with SMTP id j15-20020a5d452f000000b00313df087b7emr1554524wra.14.1688716315590;
        Fri, 07 Jul 2023 00:51:55 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id o5-20020a056000010500b0030c4d8930b1sm3762071wrx.91.2023.07.07.00.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 00:51:55 -0700 (PDT)
Message-ID: <f5ffd795-bc09-e146-6d77-a631bdc6500e@linaro.org>
Date:   Fri, 7 Jul 2023 09:51:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/2] spi: amlogic-spifc-a1: add support for
 max_speed_hz
Content-Language: en-US
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
References: <20230706110331.19794-1-mmkurbanov@sberdevices.ru>
 <20230706110331.19794-3-mmkurbanov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230706110331.19794-3-mmkurbanov@sberdevices.ru>
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
> This patch sets the clock rate (spi_transfer->max_speed_hz) from the
> amlogic_spifc_a1_exec_op().
> 
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> ---
>   drivers/spi/spi-amlogic-spifc-a1.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/spi/spi-amlogic-spifc-a1.c b/drivers/spi/spi-amlogic-spifc-a1.c
> index a92e4fc23396..605e9e40455c 100644
> --- a/drivers/spi/spi-amlogic-spifc-a1.c
> +++ b/drivers/spi/spi-amlogic-spifc-a1.c
> @@ -107,6 +107,7 @@ struct amlogic_spifc_a1 {
>   	struct clk *clk;
>   	struct device *dev;
>   	void __iomem *base;
> +	u32 curr_speed_hz;
>   };
>   
>   static int amlogic_spifc_a1_request(struct amlogic_spifc_a1 *spifc, bool read)
> @@ -235,6 +236,21 @@ static int amlogic_spifc_a1_write(struct amlogic_spifc_a1 *spifc,
>   	return amlogic_spifc_a1_request(spifc, false);
>   }
>   
> +static int amlogic_spifc_a1_set_freq(struct amlogic_spifc_a1 *spifc, u32 freq)
> +{
> +	int ret;
> +
> +	if (freq == spifc->curr_speed_hz)
> +		return 0;
> +
> +	ret = clk_set_rate(spifc->clk, freq);
> +	if (ret)
> +		return ret;
> +
> +	spifc->curr_speed_hz = freq;
> +	return 0;
> +}
> +
>   static int amlogic_spifc_a1_exec_op(struct spi_mem *mem,
>   				    const struct spi_mem_op *op)
>   {
> @@ -243,6 +259,10 @@ static int amlogic_spifc_a1_exec_op(struct spi_mem *mem,
>   	size_t data_size = op->data.nbytes;
>   	int ret;
>   
> +	ret = amlogic_spifc_a1_set_freq(spifc, mem->spi->max_speed_hz);
> +	if (ret)
> +		return ret;
> +
>   	amlogic_spifc_a1_user_init(spifc);
>   	amlogic_spifc_a1_set_cmd(spifc, SPIFC_A1_USER_CMD(op));
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
