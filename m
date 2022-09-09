Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC015B33E7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiIIJ25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiIIJ17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:27:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F782117795
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:26:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id k10so1701071lfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JjJ2bXHWNy1h23bWYiukTnz4zT7qJyO8e7mPmA7xDqw=;
        b=okowFfxwkVz+T51v63z85m1dbtbd+lvWkXHquv2G6Pf1OfM7+VVVn8XYPkY9btaZJd
         /PO4lpqgAmAsoU+CeIqde3VoemznHwCHfPAexRT2lkuzMxU9dLdyTwIDQuNnXo5C56xs
         17aaMcCog/sUD3EyDhUNFOJ+eqgVkH1SFI1TJ4pcruje6kbs9t/qpS/d7Mpjfnp1XUG9
         QHfuutZTuJqHjNCFfDz0I4EOaGB4BBZWiExicxJLvVjJ1fHndBnZLeIISx6vweLSLs+Z
         uhjzbBX9tH9lRNMvYs0VzEpn0CnPiYFUX+3wy39Q1oCyE9dbpDFfKWirRPcbgqeq2Zfi
         f2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JjJ2bXHWNy1h23bWYiukTnz4zT7qJyO8e7mPmA7xDqw=;
        b=nX3QApMP9CIUJr9mtX/ATZW266tzk1c5UuSdmwKAKRCsUFR1joD/OCXGLahprxkAPB
         WrVJxpCVC+xAVrjehBC4pI/QwuwvzW4+NgDvAtliYNYDozMIi+ujA4JoKSGKR0aMqupX
         6n0a8p4i+pt3E848asCPiL+4/X55MhBoTYqUoD0FaqadCM1UujzB77qQlGPJX4uIYyXQ
         MrGOyBvLT18gm4Vdr8AFPYPBpnrRe/ZlxtlRSCvoMO8ANbTGSfVHdwmTveCicT3cjOVA
         iZcdx4SoRel2zAqQUGBWAWAQyTzDgL12g28V4X/22+w1n0KHKKqxlfH7WSFw+9plA55W
         ebuQ==
X-Gm-Message-State: ACgBeo3/ap93ygqz2P/PqRch2cObcMq2IcxnUQiAWcDh+q+HF6MnaeQI
        mVCZx9uU1NjlyL89Q4FiSvRpPw==
X-Google-Smtp-Source: AA6agR5Y1MFRwzKmNwuArQtFnCj2umTMcyMQc2YMMzOZ5vT1WO0wVcRNIHCDqKKHxXoM0jlN5/X5Pw==
X-Received: by 2002:a05:6512:903:b0:494:a3b9:8022 with SMTP id e3-20020a056512090300b00494a3b98022mr3882789lft.288.1662715591530;
        Fri, 09 Sep 2022 02:26:31 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z17-20020a2e4c11000000b002682754293fsm10833lja.1.2022.09.09.02.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 02:26:31 -0700 (PDT)
Message-ID: <167201e9-b9dc-5dca-ac37-b0593974ebc8@linaro.org>
Date:   Fri, 9 Sep 2022 12:26:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 01/16] phy: qcom-qmp-combo: disable runtime PM on unbind
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220907110728.19092-1-johan+linaro@kernel.org>
 <20220907110728.19092-2-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220907110728.19092-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 14:07, Johan Hovold wrote:
> Make sure to disable runtime PM also on driver unbind.

Nit: technically the subject is misleading: you switched the code to use 
devres- helpers rather than manually disabling the runtime PM.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> Fixes: ac0d239936bd ("phy: qcom-qmp: Add support for runtime PM").
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index af608c4dc869..9ce2ab56be4c 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -2930,7 +2930,9 @@ static int qcom_qmp_phy_combo_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	pm_runtime_set_active(dev);
> -	pm_runtime_enable(dev);
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;
>   	/*
>   	 * Prevent runtime pm from being ON by default. Users can enable
>   	 * it using power/control in sysfs.
> @@ -2987,13 +2989,10 @@ static int qcom_qmp_phy_combo_probe(struct platform_device *pdev)
>   	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>   	if (!IS_ERR(phy_provider))
>   		dev_info(dev, "Registered Qcom-QMP phy\n");
> -	else
> -		pm_runtime_disable(dev);
>   
>   	return PTR_ERR_OR_ZERO(phy_provider);
>   
>   err_node_put:
> -	pm_runtime_disable(dev);
>   	of_node_put(child);
>   	return ret;
>   }

-- 
With best wishes
Dmitry

