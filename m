Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADEC6B3E8B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjCJMAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCJL7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:59:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D6BB53EF;
        Fri, 10 Mar 2023 03:59:50 -0800 (PST)
Received: from [192.168.0.125] (unknown [82.76.24.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7B0D16603063;
        Fri, 10 Mar 2023 11:59:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678449589;
        bh=X+2GU15dgjZBCJgDufxmS9vuGsGDwXfzkJqm3/NwF1M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VM33XIZwtXDAhCcTirpf1o5QjInKrSlfR7hooM9uMccArPBbSzQaTmQpNhBYHzZUw
         TPtJOzWTfHEu7f4j2kHFxL9O8bTX5/M5xwBVkdcc2V8KjrmU8N1KOeY4fwgb5LBvDT
         n+MU5Y9vlyoXmuOFF11nYQHuL4KB6+iR1DzmV15h7LPOnp3MJvQX0HwI9BzZLGPtBF
         FP+7/JnMPeXBUSPBFhNDSNRie0GoNhC+5R2K8gn02/0NnppbsoelGctBzSIXl4SY4k
         z1Tr60ClDN+57pBN8UuXmecRlyoB5CJhwzxZCFE+Wt92AOYvLbspc5QU7VreWB/eA6
         EXp80VLlvVWLA==
Message-ID: <6738136f-d9e6-b23d-675c-9259b929b95a@collabora.com>
Date:   Fri, 10 Mar 2023 13:59:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] drivers: iio: remove dead code in at91_adc_probe
Content-Language: en-US
To:     Cheng Ziqiu <chengziqiu@hust.edu.cn>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230310113158.428940-1-chengziqiu@hust.edu.cn>
From:   Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20230310113158.428940-1-chengziqiu@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 13:31, Cheng Ziqiu wrote:
>  From the comment of platform_get_irq, it only returns non-zero IRQ
> number and negative error number, other than zero.
> 
> Fix this by removing the if condition.
> 
> Signed-off-by: Cheng Ziqiu <chengziqiu@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>

Hi and thank you for the patch,

Can you try to make the subject adhere to
subsystem: area: driver: change

e.g.
iio: adc: at91-sama5d2_adc: remove dead code...

Eugen


> ---
> v1->v2: Change commit message from SoB to Reviewed-by.
>   drivers/iio/adc/at91-sama5d2_adc.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 50d02e5fc6fc..168399092590 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -2400,12 +2400,8 @@ static int at91_adc_probe(struct platform_device *pdev)
>   	st->dma_st.phys_addr = res->start;
>   
>   	st->irq = platform_get_irq(pdev, 0);
> -	if (st->irq <= 0) {
> -		if (!st->irq)
> -			st->irq = -ENXIO;
> -
> +	if (st->irq < 0)
>   		return st->irq;
> -	}
>   
>   	st->per_clk = devm_clk_get(&pdev->dev, "adc_clk");
>   	if (IS_ERR(st->per_clk))

