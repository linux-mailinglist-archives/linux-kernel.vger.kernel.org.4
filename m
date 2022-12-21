Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50598652E23
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiLUI5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLUI45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:56:57 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883F81B3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:56:56 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so924523wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yhEt3FU1GHlM/ELNmA6S6/tYz8B4nV7pC8aweoE4sI4=;
        b=QkBCOuS773Vho4G6Y/h9hFVEgOqCREmIMA77L/XA2hNLOcRayKfFbGD5tu9JFb4Tm9
         R7ObvenBoHYWwGa2pbrRmEiTDPko49ncKYPlxJ7B3d/u0DJnIaD9OoXCAmcRZeQG+PeJ
         yTu9fFbGv3SZ8+a+f3G7JXTGUPOo52F1fTy7FdVsjA7iuRENzkPT40MV7C2UsWrfkSCJ
         5YdZoGY+9eB3FYhvrDay0XtNn1hODmB1NYuvWqVh67eYZw2i+BJ2TGTf8FkrmQIUzAH8
         fEloK/x+gbLnGzYSsbYqgeD0tgbk96781tTl6sOKsQgPE+6nEWctF0BpD8St0pO18tmY
         b+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhEt3FU1GHlM/ELNmA6S6/tYz8B4nV7pC8aweoE4sI4=;
        b=h84QqYEP6cMT8AuefsdCKi87Ho5MPXOpmVWku4UR3O70fqF7qbb/KQnSsTzBG3qcbV
         b+S3yXEysYO6Xq5J7K2/XtX5PLurnTPdEDAEv7LTR3mF+35ax9BgkWPevdPol0AvRMpN
         aVCNSs78HcBDxJBYVF0EVJaFcZmauLwj7vepkyWeYp4xF695BsW/yrfokQzAnoDmd/1m
         8QzfSeLDEJeJl20g2mJZsZAMQqyfQesQW9FRocfNtc+tPe1r5rKOvIJl1Gan7OA/BRNM
         jOja6q6ujjZnhdrB2wf6e9YTY9VZERRjwdp/dEexnHcCNxvWxFYVpSqpSqhhelPPbgst
         lFYA==
X-Gm-Message-State: AFqh2kosft+aeIpFY4sLPEhJ5ZZfwplgvFbyeSwCSsH41K0guDbp3kIE
        ZrH+iA7wqENJH7qw1IFqPCg=
X-Google-Smtp-Source: AMrXdXuSZux4153Rq5GjklQKx8IiCPyFPaux/RA3OhYcIvAD2Z0//bD+FwmqwDQm9FjlKusFd9Z3kQ==
X-Received: by 2002:a05:600c:228b:b0:3d2:37a4:222a with SMTP id 11-20020a05600c228b00b003d237a4222amr3813954wmf.38.1671613014888;
        Wed, 21 Dec 2022 00:56:54 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id i83-20020a1c3b56000000b003cf57329221sm1524349wma.14.2022.12.21.00.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 00:56:54 -0800 (PST)
Message-ID: <12f4d25e-fb2e-8f4d-1874-46f7404b05b6@gmail.com>
Date:   Wed, 21 Dec 2022 09:56:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] soc: mediatek: mtk-svs: Enable the IRQ later
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Roger Lu <Roger.Lu@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221127-mtk-svs-v2-0-145b07663ea8@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221127-mtk-svs-v2-0-145b07663ea8@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/12/2022 22:35, Ricardo Ribalda wrote:
> If the system does not come from reset (like when is booted via
> kexec()), the peripheral might triger an IRQ before the data structures
> are initialised.
> 
> Fixes:
> 
> [    0.227710] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000f08
> [    0.227913] Call trace:
> [    0.227918]  svs_isr+0x8c/0x538
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks Ricardo. Roger I'll wait for a Tested-by tag from you to make sure this 
time everything is fine.

Regards,
Matthias

> ---
> To: Matthias Brugger <matthias.bgg@gmail.com>
> To: Roger Lu <Roger.Lu@mediatek.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes in v2:
> - Enable the irq before svs_start, to avoid MT8192 not starting.
> - Link to v1: https://lore.kernel.org/r/20221127-mtk-svs-v1-0-7a5819595838@chromium.org
> ---
>   drivers/soc/mediatek/mtk-svs.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 0469c9dfeb04..75b2f534aa9d 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -2385,14 +2385,6 @@ static int svs_probe(struct platform_device *pdev)
>   		goto svs_probe_free_resource;
>   	}
>   
> -	ret = devm_request_threaded_irq(svsp->dev, svsp_irq, NULL, svs_isr,
> -					IRQF_ONESHOT, svsp->name, svsp);
> -	if (ret) {
> -		dev_err(svsp->dev, "register irq(%d) failed: %d\n",
> -			svsp_irq, ret);
> -		goto svs_probe_free_resource;
> -	}
> -
>   	svsp->main_clk = devm_clk_get(svsp->dev, "main");
>   	if (IS_ERR(svsp->main_clk)) {
>   		dev_err(svsp->dev, "failed to get clock: %ld\n",
> @@ -2414,6 +2406,14 @@ static int svs_probe(struct platform_device *pdev)
>   		goto svs_probe_clk_disable;
>   	}
>   
> +	ret = devm_request_threaded_irq(svsp->dev, svsp_irq, NULL, svs_isr,
> +					IRQF_ONESHOT, svsp->name, svsp);
> +	if (ret) {
> +		dev_err(svsp->dev, "register irq(%d) failed: %d\n",
> +			svsp_irq, ret);
> +		goto svs_probe_iounmap;
> +	}
> +
>   	ret = svs_start(svsp);
>   	if (ret) {
>   		dev_err(svsp->dev, "svs start fail: %d\n", ret);
> 
> ---
> base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
> change-id: 20221127-mtk-svs-add137fbf187
> 
> Best regards,
