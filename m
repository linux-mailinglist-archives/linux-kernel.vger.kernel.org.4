Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95512626750
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 07:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiKLGLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 01:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKLGLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 01:11:06 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4F525E8B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 22:11:01 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id p8so11232822lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 22:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xgEFrQxF5erS41BXftmnuJVC4f2mIZC62wulZ8QcVq4=;
        b=unfxgYsI+Wp7KKEqj45kLKcOIMODrgTPzgRv5i2bTfxwLtr7a0DLFbTQXnQPBqNL06
         6NTuCi4tbd0qt3IGLJVR6rUNW0G/v+4iISGtfcv104x+PBoqeyzlwVB33K2+Mszhbs81
         90LvzuxvW8A5CNUiCw0ddj2Q7C4SFFovCnZGg4TefYPPQ0Rx84E/I5diXMwcUmhBdAg7
         XMVG5DA3VzLSTwK3Vi3zYWBu7kvKDoo0ovYAoylyBvGzPbg72hdR2QyY1phKwUT9bc1p
         LqLV0lhjrpeLTDbk3oBB7R8qJuHH9PLWlLAYkMx36OVpQWlYbEL7yc6e3M/TJbT1NTyb
         z1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgEFrQxF5erS41BXftmnuJVC4f2mIZC62wulZ8QcVq4=;
        b=Pq063rjcM3ZFBiKex4LDfFGzP7AdS/neDIVnWXIiY0rPdcQvIuqTMtkd1lV0mN7Fdk
         0jdqINpHcKLiyADeE643m7onCy1Y7OIeGZH4s0b4Va7qTA/oFZq/d0TF0iv3FRi4Ie9w
         LyGYigv7h8xgiyX6li7lKucL+qyQCYX6NcMgN1AgD473auUWaZAl0wad0whm6X22159T
         EBKjdM3kL3wOZXbTsnwdzUQLAlKqNYLVHSoAf3RVH0iKR2CeYb/tHhzskqFgr3OwNcX8
         n0ZBUDm10vPtCoJy8BkX9sTIt5IF1KtSPBRciW6ZXl/mnVGOGBvINrlgUAcMMH9N4qeF
         Bx0w==
X-Gm-Message-State: ANoB5plIZ6tJYBzBE2Ppx/hMPzn//zCcn6CK6Lrc/yG+gzdpYY6fzOSN
        FI6+ir9htLeSTFj401xyfHzREg==
X-Google-Smtp-Source: AA0mqf727C/tU8votlwq4Rgzh0ltalzyYBYUm03eCr9mgdImpS0cM3o+T9813EWmFtHd7QrWxGF3Eg==
X-Received: by 2002:a19:dc15:0:b0:4b1:18a2:2fbd with SMTP id t21-20020a19dc15000000b004b118a22fbdmr1598550lfg.564.1668233459632;
        Fri, 11 Nov 2022 22:10:59 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m7-20020a056512358700b004a2c3fd32edsm706433lfr.144.2022.11.11.22.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 22:10:59 -0800 (PST)
Message-ID: <77fe7684-5ac7-a538-80a3-2654e2365a3b@linaro.org>
Date:   Sat, 12 Nov 2022 09:10:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/6] phy: qcom-qmp-combo: fix out-of-bounds clock access
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20221111084255.8963-1-johan+linaro@kernel.org>
 <20221111084255.8963-2-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111084255.8963-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2022 11:42, Johan Hovold wrote:
> The SM8250 only uses three clocks but the DP configuration erroneously
> described four clocks.
> 
> In case the DP part of the PHY is initialised before the USB part, this
> would lead to uninitialised memory beyond the bulk-clocks array to be
> treated as a clock pointer as the clocks are requested based on the USB
> configuration.

... because the num_clks comes from the struct qmp_phy_cfg, not from the 
struct qcom_qmp.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> Fixes: aff188feb5e1 ("phy: qcom-qmp: add support for sm8250-usb3-dp phy")
> Cc: stable@vger.kernel.org	# 5.13
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 5e11b6a1d189..bb38b18258ca 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -1270,8 +1270,8 @@ static const struct qmp_phy_cfg sm8250_dpphy_cfg = {
>   	.swing_hbr3_hbr2	= &qmp_dp_v3_voltage_swing_hbr3_hbr2,
>   	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v3_pre_emphasis_hbr3_hbr2,
>   
> -	.clk_list		= qmp_v4_phy_clk_l,
> -	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
> +	.clk_list		= qmp_v4_sm8250_usbphy_clk_l,
> +	.num_clks		= ARRAY_SIZE(qmp_v4_sm8250_usbphy_clk_l),
>   	.reset_list		= msm8996_usb3phy_reset_l,
>   	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
>   	.vreg_list		= qmp_phy_vreg_l,

-- 
With best wishes
Dmitry

