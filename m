Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63345FB442
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJKOIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJKOHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:07:52 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A5B90833
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:07:20 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id bs14so4051111ljb.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4lMQAQ0osJVsDf4eu+zCeSxpXp3q9i6qM/ZobGYZDP0=;
        b=CMKuwegLP2IA7nFX8CQItOqmeovyC55ikLhG6vNewqBfyGpkLghiTw4Zpt2ZQzWKXk
         2ov0Gr9E1jePoUhXHcHg72SxmDcWwbTeZ5cu5G6bsHZZpmVhfmRRfqn+EhDjpAiASGsV
         LnRr8QgZrU0kdvaoeK+P8kdCrwMqaxDf5QO3FN2L7p4RxdKy0w6XPqEg0CnQr63iuDo+
         qasjXootYdCcXjYxyatIg/VhnDbpHmJNsfAMCyg+3/pc3GaHCkkzdLQdE56+zieuv2nm
         FAMBtBaJPEPGvXy3a0VrHwdzvrFwEktESgWDtgbHhMznOZrCRGReKoCNvmIG1ZTpVyHG
         GkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lMQAQ0osJVsDf4eu+zCeSxpXp3q9i6qM/ZobGYZDP0=;
        b=nkt8jxTvKDBFQRp7nAz8veVC9pwisFeLbN+KzeYTDL/gTge2GhEp3x8Cy1RzbjfmXQ
         UWsss4RjrJ4tpL4HYP/blZJ75QXM77oy0jFvej/AOLlh79KlRuWC5s5YzDAssygDojDo
         Ttbg66u+EQ4g1k50PCH8YgwiyUMqO/yyr+7lGGDJHduuqyo/02Kzvyv3sMjyfGC2hFtQ
         ZPgOgpTLZFnCrV+OicSa2zN4cK0e/gNP2LXVgrzL7gjE7irolEg4prYLzNSqEPCMx3e4
         tmQP9RmjOA6G5sQeNmhxTUJQE0M8vClt2Kjh4jt5wqZp/0hZUBIzYyjFFcFM9IyIaFaP
         5KvA==
X-Gm-Message-State: ACrzQf3NcbbhxasUbN+Lm3ZJObzDgXeQqxjt+B6U4LA4ZRmf6uvT3a1N
        uAlGna5fNQkP8BBy2msrlHvywQ==
X-Google-Smtp-Source: AMsMyM73osC13XrVnH4U0OrkJ1yeqkZxc8ODKwVb6djVqA3R/Dg/Nyb+bsUrwsVDf17kvXjOYK8CZQ==
X-Received: by 2002:a2e:9819:0:b0:26e:916f:c49f with SMTP id a25-20020a2e9819000000b0026e916fc49fmr5984631ljj.294.1665497237367;
        Tue, 11 Oct 2022 07:07:17 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d16-20020a05651c089000b0026c5bc6ed1asm2071341ljq.69.2022.10.11.07.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 07:07:17 -0700 (PDT)
Message-ID: <ce6370f9-962c-905b-5188-a9b6ff9e2fd3@linaro.org>
Date:   Tue, 11 Oct 2022 17:07:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 10/13] phy: qcom-qmp-combo: drop sc8280xp power-down delay
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221011131416.2478-1-johan+linaro@kernel.org>
 <20221011131416.2478-11-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221011131416.2478-11-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 16:14, Johan Hovold wrote:
> The SC8280XP combo PHY does not need a delay before starting the USB PHY
> (which is what the has_pwrdn_delay config option really controls) so
> drop the unnecessary delay.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 4 ----
>   1 file changed, 4 deletions(-)

Just an obvious question: 'does not need a delay' comes from your 
experience or from some vendor flag (in ACPI/DT/kernel/wherever)?

> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 84380852ba5b..a8e09333072e 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -1210,10 +1210,6 @@ static const struct qmp_phy_cfg sc8280xp_usb43dp_usb_cfg = {
>   	.start_ctrl		= SERDES_START | PCS_START,
>   	.pwrdn_ctrl		= SW_PWRDN,
>   	.phy_status		= PHYSTATUS,
> -
> -	.has_pwrdn_delay	= true,
> -	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
> -	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
>   };
>   
>   static const struct qmp_phy_cfg sc8280xp_usb43dp_dp_cfg = {

-- 
With best wishes
Dmitry

