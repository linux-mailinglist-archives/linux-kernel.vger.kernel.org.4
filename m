Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D635EE4D5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiI1TLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbiI1TLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:11:14 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151FD77E89
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:11:13 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s10so15391753ljp.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/gZf36AfrA3hWD/0cvl58ifdsuky8QGAhYN3zOeCaIo=;
        b=faHhIgC9G9GY47c9RFQEDUiqcP/c+1d82TnEsyyAkNe5jX9D+/0H8GnIHR1gVnNA4g
         y10VJ0dfhTpOjl5GJVG5YGNLyWVhSkvLNhaDfy7oSmMH4SqMGho0Bynr9naJpviXydwC
         BagBkj6Q5/PK4Vt4BBEXPdjrjLrJ/fJGs5r3QAMjs3Ka8GdR8F5Tbev7mKHvSobXewpg
         lLyeVHJ1upWV/WQH3waU8jot0MvFviPHZzxbrIw722gRU9cdyR1y5iFtp3eM1eF4/UJc
         tx+pG+YjWeNJ7ZJJMc1srLTbehQXLvTP4SM/h7mqWigx4DqgRq4q24mGj46oR0No6ENE
         s3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/gZf36AfrA3hWD/0cvl58ifdsuky8QGAhYN3zOeCaIo=;
        b=tP5bcoOI0kNpX+1C0kgcznr15E6guFaSqj4r8z5GxGHUISmirgGnTsyTW4uLyr/m1N
         aTDO4WZO/5nEnXrjilVfyQULMbeOXhAx0thRrWO1ETHtcUFzyjUpbixd+v9gMpz51ccX
         4mGHMn7UtycgjO09OIGNpjZ2EHzN1sryKsI/seKrFiSxHUkmor3UdhGl588+bsyydJNc
         vTj8Ar1C4XOXrD3yKrBJY9sVm1L+1LtrbAP/g6iKeXsgvpS6d19AGtZGnuLZnep+gidU
         YCaLgkuZnPs26bxfpIe37dErXTJ+oJoeZZTYHbYu9W5QoRuaTI/Boc85BGOJynbjibSG
         rkmQ==
X-Gm-Message-State: ACrzQf3fDVK83sssqIeBJf+UtnU09TiZdhx7imOfPzV1dCepjtsh+suZ
        Q12EVqG7ZONRiSlBomLRj4FWXw==
X-Google-Smtp-Source: AMsMyM4hpI1q8lH1cn6x1gtWTCHIX/Bo1GOEPemGLdA43LovkM3rJ9HHWH/WhDDtIlyo2rvcBA6Etg==
X-Received: by 2002:a2e:983:0:b0:26c:5b0e:f5e4 with SMTP id 125-20020a2e0983000000b0026c5b0ef5e4mr12162453ljj.502.1664392271455;
        Wed, 28 Sep 2022 12:11:11 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z24-20020a2e9b98000000b0026a92616cd2sm519306lji.35.2022.09.28.12.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 12:11:11 -0700 (PDT)
Message-ID: <f7c29d82-2972-6e42-8a74-ae93227331ae@linaro.org>
Date:   Wed, 28 Sep 2022 22:11:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 05/13] phy: qcom-qmp-pcie: unify sdm845 registers
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220928152822.30687-1-johan+linaro@kernel.org>
 <20220928152822.30687-6-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220928152822.30687-6-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 18:28, Johan Hovold wrote:
> The SDM845 register array is identical to pciephy_regs_layout so drop
> the former.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Same comment as for the patch 04/13.

> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 7b3f7e42edd5..4146545fdf5f 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -92,12 +92,6 @@ static const unsigned int pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
>   	[QPHY_PCS_STATUS]		= 0x174,
>   };
>   
> -static const unsigned int sdm845_qmp_pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
> -	[QPHY_SW_RESET]			= 0x00,
> -	[QPHY_START_CTRL]		= 0x08,
> -	[QPHY_PCS_STATUS]		= 0x174,
> -};
> -
>   static const unsigned int sdm845_qhp_pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
>   	[QPHY_SW_RESET]			= 0x00,
>   	[QPHY_START_CTRL]		= 0x08,
> @@ -1545,7 +1539,7 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
>   	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
>   	.vreg_list		= qmp_phy_vreg_l,
>   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> -	.regs			= sdm845_qmp_pciephy_regs_layout,
> +	.regs			= pciephy_regs_layout,
>   
>   	.start_ctrl		= PCS_START | SERDES_START,
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,

-- 
With best wishes
Dmitry

