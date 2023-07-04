Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197377470A1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjGDMNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjGDMNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:13:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3B510C1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:12:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc244d39dso72920855e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 05:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688472769; x=1691064769;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LhKrYRWaKadZinHNjk4IjxV4XB16+8Bcs0W8RkZyZfw=;
        b=hRg9xQ86UTETw+vimhaWGpKVW/q6p9fdF5zB1ZvVG5JemfAMh8HcOmqShqdMyeNtsg
         zY6N2rpcD+PHCml7jUOldharNXZmXQFQrTaTJgHNODjhjVA/0ryMosxz8XGCwkCJZAhX
         WAGh07QPaPddLCGwn+ZrVHi4J/v+GOX8g07WePNLM9jSVU47rgIRtX6JHQY8rGR2Mu1Q
         GnjaMgVMWXbZ7AVsfsGrfLaoJdOl91brTvRHEvjUiJDyylF52aAT8BK++xh0ikiiopxj
         7ATBO9vnwL+rcyFwMQvAuo4ygOqAfmVr18pNL4CDubqDEPVf9Ovbazvhyw9l3us0BE5a
         F8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688472769; x=1691064769;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhKrYRWaKadZinHNjk4IjxV4XB16+8Bcs0W8RkZyZfw=;
        b=ap77M5it0KTrJs64Eyn5qNjWlTHSYO4Ask2nVHvUXBl+PwdhESgVhFogstR7viaoEu
         JRUmcHER/FYihwSA+4p6Jc6BFGl0LvpR6/Cnhgl5xEkDooTp+jv9tEnrC7ymJJ5TYGTZ
         DXx96U2xY3LUKPI/AmRi4qqo08QPo9LWPqOiNP0HlMW/xrLbdFeb5UahPfnsXOfnqoc0
         uIghkwSDQdVdo7G6bnzfQcZJrbWUie7TtWh3SyJls+ZHFN+5O3tal3mU6EzDjVW0nlMW
         lQHiTT+Np395i03PfkulEpL5m76I1qy+rV2jMCbALjZ/UpT8V3SEi2q7/jt49xD5uQRT
         kVvA==
X-Gm-Message-State: AC+VfDz1gk2dlh5P35mzarFsidRDDEOPgjkdaX4KK3uW6G1mfkhA07D9
        YdwEmhpQ6adji6Er8m5hgV6LiQ==
X-Google-Smtp-Source: ACHHUZ7EwEWsy9m15nLEYSLtXvQCNPfOglovegeNcg9TvJO0iQGw8ybbV6xToc1WUY3fMRQ1m7KlQw==
X-Received: by 2002:a1c:e909:0:b0:3fb:b05d:f274 with SMTP id q9-20020a1ce909000000b003fbb05df274mr17669372wmc.4.1688472769013;
        Tue, 04 Jul 2023 05:12:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:106:cd85:84ae:7b? ([2a01:e0a:982:cbb0:106:cd85:84ae:7b])
        by smtp.gmail.com with ESMTPSA id d11-20020a1c730b000000b003fb416d732csm22395302wmb.6.2023.07.04.05.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 05:12:48 -0700 (PDT)
Message-ID: <c6d4daa1-d58a-2a29-3121-e1405c3ccc15@linaro.org>
Date:   Tue, 4 Jul 2023 14:12:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/7] reset: meson-audio-arb: Convert to
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230704120211.38122-1-frank.li@vivo.com>
 <20230704120211.38122-2-frank.li@vivo.com>
Organization: Linaro Developer Services
In-Reply-To: <20230704120211.38122-2-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2023 14:02, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   drivers/reset/reset-meson-audio-arb.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/reset/reset-meson-audio-arb.c b/drivers/reset/reset-meson-audio-arb.c
> index 6a3f6a6a3bbf..355e041214bd 100644
> --- a/drivers/reset/reset-meson-audio-arb.c
> +++ b/drivers/reset/reset-meson-audio-arb.c
> @@ -138,7 +138,6 @@ static int meson_audio_arb_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	const struct meson_audio_arb_match_data *data;
>   	struct meson_audio_arb_data *arb;
> -	struct resource *res;
>   	int ret;
>   
>   	data = of_device_get_match_data(dev);
> @@ -154,8 +153,7 @@ static int meson_audio_arb_probe(struct platform_device *pdev)
>   	if (IS_ERR(arb->clk))
>   		return dev_err_probe(dev, PTR_ERR(arb->clk), "failed to get clock\n");
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	arb->regs = devm_ioremap_resource(dev, res);
> +	arb->regs = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(arb->regs))
>   		return PTR_ERR(arb->regs);
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
