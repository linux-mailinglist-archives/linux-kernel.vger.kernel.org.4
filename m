Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7BD5BE71E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiITNah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiITNae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:30:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B42D4B497
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:30:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n12so4268084wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=XLxjCK1UrYCEX7pcRlMkQ0jqY8Ny3pjRnQ4MiYRMmGc=;
        b=NK2Oy+tzNmW0Z0DQa5UKF/e2pj9fFX9OGHvrWk7x696wpkkn2l2T1KbCkWux41Zkco
         GCKNjtyNmTq+jrWWpZ0+/nRAjHICJ/12WhhToJoctEKsZ8iRXz/SrOte8WIYZ9QV/OuV
         RA2/XT85gYr0p89WonCHF1uuQoQd0iQFBD0/4Z71HFIx7baxKce+lVlxzF6MaajfTh/T
         u53scWLTA9g1eAlhOl7Hf7dGqGE3TRTr3XiKLQ6QV5HPhKijceuzphGZZMHNaHpOuccL
         wm6Q35jLqNE3vsLBOJCvmU0rClqWQMpDwUhmOT2C16rNsykgtZw0qwRehDDJ0mIUHw1b
         MuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=XLxjCK1UrYCEX7pcRlMkQ0jqY8Ny3pjRnQ4MiYRMmGc=;
        b=NEGYYLST5U8aF4dmi5vruobL+UxfGSFFL5icxntjG+ifxDXT4gAjaXB2H6EbwJvMFq
         aIV7ZpPxP8JOj/5XOAqui/6LXY0SELSNYjSArO7cYr49YnXdrDfy6X4Jv2earKd6T9N9
         mmt/LZGexy8pTurx5EgJegNKi6YLaGaIWLy2XkwL0T2qOTcCtf/0u+2uk5OKflBl+bc6
         K/u+XSPeHpUiQ9HoaQUoIfGpi9An6CG3+TyAim/y1zBfMDpF2cHXxuo4nOm85fgBQ0JN
         ewbCsJxufEOr0caP77hcnYmVRUQP41CzgzC/XpMnaMVum/Psvq7XAgt666I/KF8ak8W7
         QacA==
X-Gm-Message-State: ACrzQf2TMcXRyS6JVhTh9IW+AMbJX5OWitvzuDRbcba32xjn+AGb7l+S
        28VSCh7hCeIrQuZC4NtvHeWzBw==
X-Google-Smtp-Source: AMsMyM4rDJ9Ph6SYonLeoLqOVQkjtcIXLs9X97QpO0G9E4099LrQwE+woqtN527kN7WDVD9ZZDoZoA==
X-Received: by 2002:a05:6000:982:b0:229:79e5:6a96 with SMTP id by2-20020a056000098200b0022979e56a96mr13814135wrb.469.1663680631063;
        Tue, 20 Sep 2022 06:30:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e? ([2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e])
        by smtp.gmail.com with ESMTPSA id j26-20020adfa55a000000b0022afddab5dfsm70082wrb.7.2022.09.20.06.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:30:30 -0700 (PDT)
Message-ID: <5a10b8b7-3881-2f31-5a79-ddef9798184d@linaro.org>
Date:   Tue, 20 Sep 2022 15:30:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] phy: qualcomm: call clk_disable_unprepare in the error
 handling
Content-Language: en-US
To:     Dongliang Mu <dzm91@hust.edu.cn>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220914051334.69282-1-dzm91@hust.edu.cn>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro
In-Reply-To: <20220914051334.69282-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2022 07:13, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> Smatch reports the following error:
> 
> drivers/phy/qualcomm/phy-qcom-usb-hsic.c:82 qcom_usb_hsic_phy_power_on()
> warn: 'uphy->cal_clk' from clk_prepare_enable() not released on lines:
> 58.
> drivers/phy/qualcomm/phy-qcom-usb-hsic.c:82 qcom_usb_hsic_phy_power_on()
> warn: 'uphy->cal_sleep_clk' from clk_prepare_enable() not released on
> lines: 58.
> drivers/phy/qualcomm/phy-qcom-usb-hsic.c:82 qcom_usb_hsic_phy_power_on()
> warn: 'uphy->phy_clk' from clk_prepare_enable() not released on lines:
> 58.
> 
> Fix this by calling proper clk_disable_unprepare calls.
> 
> Fixes: 0b56e9a7e835 ("phy: Group vendor specific phy drivers")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>   drivers/phy/qualcomm/phy-qcom-usb-hsic.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-usb-hsic.c b/drivers/phy/qualcomm/phy-qcom-usb-hsic.c
> index 716a77748ed8..20f6dd37c7c1 100644
> --- a/drivers/phy/qualcomm/phy-qcom-usb-hsic.c
> +++ b/drivers/phy/qualcomm/phy-qcom-usb-hsic.c
> @@ -54,8 +54,10 @@ static int qcom_usb_hsic_phy_power_on(struct phy *phy)
>   
>   	/* Configure pins for HSIC functionality */
>   	pins_default = pinctrl_lookup_state(uphy->pctl, PINCTRL_STATE_DEFAULT);
> -	if (IS_ERR(pins_default))
> -		return PTR_ERR(pins_default);
> +	if (IS_ERR(pins_default)) {
> +		ret = PTR_ERR(pins_default);
> +		goto err_ulpi;
> +	}
>   
>   	ret = pinctrl_select_state(uphy->pctl, pins_default);
>   	if (ret)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
