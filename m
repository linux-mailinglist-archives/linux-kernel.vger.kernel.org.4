Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DE0626906
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 12:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiKLLPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 06:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiKLLPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 06:15:08 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9602625
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:15:07 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id l12so11924091lfp.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BP3HObLwfnQ6Z033Q/+ZsVYc5sgYgaxGGPnUH0Zg5Zg=;
        b=D9CjHXdC2dDtUGwfpFzrppKqh3FCN2xg3+eiugFIqSdPBMtIc/ZqtiQB6wIv+N6xo2
         fZRQ+OuQe7PNEaUQpRysJSHHCAF9tNIaMcmX+ndioHtqTedd10nfELorFV09fVegr3RU
         Z/+e1A3R3yW2kBiCKb4Tmi8nuBdzqHDnryaVBur52TP1G+0Xs3r7LkonykEJrlDdrVAL
         rS7/4nynNZpQZ3Gu710mccDL0ejFyR6otdDdRcdpvyIY7mt6a5yd60qFJvKaI0AUnare
         6PpX+SuzJjr76KOG2SIIU4rpaAZiU1AuwlPQQFanB1+W25Ddi0gfPFdpJr9dJIglvHmm
         F5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BP3HObLwfnQ6Z033Q/+ZsVYc5sgYgaxGGPnUH0Zg5Zg=;
        b=v/r+CDXVIPKUHzSI336A746jUfXFKC89pwzH2nQ6uY5IbXy0TB+RYZ5ViRNOSeGyJv
         ZeyNpNV37oRztFn0IaLmo7qG0p4Ugek18Sz0uW707XU4LwwGYT3SIG0bhIEDolcXGT3E
         7Of5XxOIInfk7PUWu2XSMw5/CLNdeKkS7C36doOt09N0EKr5kumht9+5beD68Nva+Mqo
         2T2/GajuHRezkgbPSReHXnhEgiz7r5hSNOSTKpp1AHtQobMI0kKexlbENSrijF1avDML
         RXLq4Uc80QN4GSaiPC0UfUXgiFB0Ek8FHP+i7Kavf1hMspcnaEvq2vl2K4vnHvkB9s/E
         khKg==
X-Gm-Message-State: ANoB5plsz1uuZ6PRNc1cSuRWBablFLu2oaESzLcYQN2YriT/eTgw076D
        xS5Gs/WKcwKkEYz9f6mCCBZZuPxiabGT06Wf
X-Google-Smtp-Source: AA0mqf63YnUBeua3mL7qR3PkxrkqtWWRHuxK7R+CfBrmhjcm4iJJ/tIaUB+VKUkYN7sx1ncWqJ7fvw==
X-Received: by 2002:a19:5016:0:b0:4ad:5fbb:a5b0 with SMTP id e22-20020a195016000000b004ad5fbba5b0mr1832416lfb.466.1668251705808;
        Sat, 12 Nov 2022 03:15:05 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u19-20020a05651220d300b0049462af8614sm823974lfr.145.2022.11.12.03.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Nov 2022 03:15:05 -0800 (PST)
Message-ID: <9c94f81c-963e-d1a3-6514-f803bb7e05fa@linaro.org>
Date:   Sat, 12 Nov 2022 14:15:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 05/14] phy: qcom-qmp-combo: register clocks sooner
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-6-johan+linaro@kernel.org>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111092457.10546-6-johan+linaro@kernel.org>
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

On 11/11/2022 12:24, Johan Hovold wrote:
> Runtime PM should be enabled before registering the PHYs, but there is
> no reason that the clocks can not be registered before enabling runtime
> PM.

This will have a side effect of DP and pipe clocks not using runtime PM 
during the clocks operations (see the code handling rpm_enabled in 
drivers/clk/clk.c). If this is an intended change, it should be 
described in the commit message.

> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 1bc8567a8605..1a6aa61a12c5 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -2642,6 +2642,14 @@ static int qmp_combo_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto err_node_put;
>   
> +	ret = phy_pipe_clk_register(qmp, usb_np);
> +	if (ret)
> +		goto err_node_put;
> +
> +	ret = phy_dp_clks_register(qmp, dp_np);
> +	if (ret)
> +		goto err_node_put;
> +
>   	pm_runtime_set_active(dev);
>   	ret = devm_pm_runtime_enable(dev);
>   	if (ret)
> @@ -2652,14 +2660,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
>   	 */
>   	pm_runtime_forbid(dev);
>   
> -	ret = phy_pipe_clk_register(qmp, usb_np);
> -	if (ret)
> -		goto err_node_put;
> -
> -	ret = phy_dp_clks_register(qmp, dp_np);
> -	if (ret)
> -		goto err_node_put;
> -
>   	qmp->usb_phy = devm_phy_create(dev, usb_np, &qmp_combo_usb_phy_ops);
>   	if (IS_ERR(qmp->usb_phy)) {
>   		ret = PTR_ERR(qmp->usb_phy);

-- 
With best wishes
Dmitry

