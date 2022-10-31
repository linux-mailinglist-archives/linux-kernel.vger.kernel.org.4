Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E6F613D53
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiJaS2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiJaS2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:28:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00A3F5C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:28:38 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f16-20020a05600c491000b003cf66a2e7c0so3912153wmp.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESah86fGc7L+Xbl/WXQlaeWbmtq7glSFyBOHkEwRjqA=;
        b=OKiMbfMlnlrjIVC7hqN1GYU7bYVxo8PqmAJSpyszeI5Kr351mcEpP4ZUPw15jrTSkM
         fTuiEXLF3N5/7rw4RmrUH3y50sidwjoYGEFpgufEQfpiOouV7t7LkdWWNiHgea9LAH2I
         oqflhu6Ld3hywlOJ/UCfWhSfKMhuN98oTFdbszWK1RnkM+kT7g9ZhwOA21eqYihSMLWd
         xIKeE1wNvcKXkzADTSZN66Yn0kOtdIg0M6SPxG8NJRAr0yMw/FWAyvopenK4WTDm5RQ5
         9INbzv8vy5tEzrvOle7+Q48OryUwgB1TN+q16HWwrpoN/NplcwcQgnrp6i5eaqg2XLtv
         hFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESah86fGc7L+Xbl/WXQlaeWbmtq7glSFyBOHkEwRjqA=;
        b=WxKdGTS3RPJsNE725POTwDcczgrRq+lPgNhgF5BH6wmh/iHxOb9xWiiPOuSoejiFdP
         BM5v/XiK5rNksHVlPGqt8Thss0fvIrWf+57xI62U1vtAp8YRYRYHzD89LlC8WkBG6pOP
         AO9txON/gHnXEFCqfNQInJTDRqdmXma0XhuyrKQw5k9ca2Be3MWfQJfktiqX3F1D0H23
         ie8SOLMRoq4WWcGSRgQzbwpESoVrHwi0AFvvjSytOpp3NOzWNua4pa+WIAgFKMGyg8U4
         vPeyDxrC1ow1N9av8EOnhATEIcgkQHTZdzmVaKH0UgsZFmtGmomh7lQPL6b/dvIOmHZi
         ObzQ==
X-Gm-Message-State: ACrzQf0p9B4ngTH0Of/89UEV45qcEdc2zsxMYOBFjUXBmb3laBsBTtZQ
        r1KG4coekW2s0hlHzpz4B2T9F/EKSudooQ==
X-Google-Smtp-Source: AMsMyM6LZLbegfSTuGAx7nz+anwW1Np5zaqnxyRYWtVfOMGGgUCeTnXu7wrpu2A1gpL3YkX0uRa8BA==
X-Received: by 2002:a05:600c:1694:b0:3cf:56a9:fe64 with SMTP id k20-20020a05600c169400b003cf56a9fe64mr14035284wmn.112.1667240917252;
        Mon, 31 Oct 2022 11:28:37 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id bx7-20020a5d5b07000000b00228cbac7a25sm7795160wrb.64.2022.10.31.11.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 11:28:36 -0700 (PDT)
Message-ID: <addac524-a168-16ba-c736-5b116b6e98af@linaro.org>
Date:   Mon, 31 Oct 2022 18:28:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH -next] slimbus: qcom-ngd: Fix build error when
 CONFIG_SLIM_QCOM_NGD_CTRL=y && CONFIG_QCOM_RPROC_COMMON=m
Content-Language: en-US
To:     Zheng Bin <zhengbin13@huawei.com>, gregkh@linuxfoundation.org,
        krzysztof.kozlowski@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20221027095904.3388959-1-zhengbin13@huawei.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221027095904.3388959-1-zhengbin13@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/10/2022 10:59, Zheng Bin wrote:
> If CONFIG_SLIM_QCOM_NGD_CTRL=y, CONFIG_QCOM_RPROC_COMMON=m, COMPILE_TEST=y,
> bulding fails:
> 
> drivers/slimbus/qcom-ngd-ctrl.o: In function `qcom_slim_ngd_ctrl_probe':
> qcom-ngd-ctrl.c:(.text+0x330): undefined reference to `qcom_register_ssr_notifier'
> qcom-ngd-ctrl.c:(.text+0x5fc): undefined reference to `qcom_unregister_ssr_notifier'
> drivers/slimbus/qcom-ngd-ctrl.o: In function `qcom_slim_ngd_remove':
> qcom-ngd-ctrl.c:(.text+0x90c): undefined reference to `qcom_unregister_ssr_notifier'
> 
> Make SLIM_QCOM_NGD_CTRL depends on QCOM_RPROC_COMMON || (COMPILE_TEST && !QCOM_RPROC_COMMON) to fix this.
> 
> Fixes: e291691c6977 ("slimbus: qcom-ngd-ctrl: allow compile testing without QCOM_RPROC_COMMON")
> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
> ---

Applied thanks,

--srini
>   drivers/slimbus/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
> index 2ed821f75816..a0fdf9d792cb 100644
> --- a/drivers/slimbus/Kconfig
> +++ b/drivers/slimbus/Kconfig
> @@ -23,7 +23,7 @@ config SLIM_QCOM_CTRL
>   config SLIM_QCOM_NGD_CTRL
>   	tristate "Qualcomm SLIMbus Satellite Non-Generic Device Component"
>   	depends on HAS_IOMEM && DMA_ENGINE && NET
> -	depends on QCOM_RPROC_COMMON || COMPILE_TEST
> +	depends on QCOM_RPROC_COMMON || (COMPILE_TEST && !QCOM_RPROC_COMMON)
>   	depends on ARCH_QCOM || COMPILE_TEST
>   	select QCOM_QMI_HELPERS
>   	select QCOM_PDR_HELPERS
> --
> 2.31.1
> 
