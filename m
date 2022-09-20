Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D795BE791
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiITNvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiITNvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:51:08 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B61399F1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:51:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id az6so1974787wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=vwvpH9OCUXie6JCH3Id6Xbj2ycjGgu6cufNjGSnRVxI=;
        b=PXsyjr2YR55AB98TCWIzI1oVJEwxYonA7Mf3TC5hnslTtwwgzwM9Nm3G/InB+w5RA4
         cfCn8JWn8ktZMg4VpAIsGyyejDEW11sSI42B2hnhtdWTedp+OgbXLggikkZptZGkNu0h
         LiDJjWexPyY+j9E9jI2L0viELzQqYn28OYVz1uMrKCo65j10ryulaJ+ZU324ysYpkm5j
         /bpCurXxWukGg3fphNkuD8ic11M+U2+3Ukf5jxYdBSi8R6u0Ku3YE83alMr1UnIWivtw
         qPn6R1KCLgJxCoN8X4yRqyVzJqmhw+W2aYNk/PpcJkoxEx3MijB2BiNWM/BK3XtBrc14
         yZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=vwvpH9OCUXie6JCH3Id6Xbj2ycjGgu6cufNjGSnRVxI=;
        b=ogh+SeZht8JjKRqDUFRtOS9J08U8fcKCfQA84LYiDB9STJG05LGGB807ceMSnv78Mn
         V3DbYIKwiIoI4ttAIn5UlOQy4Ypq8M6XnvI95e2Tm0qffbHwVjpliF9zeNS+wasvHob/
         tYYPz8Ba8xyari2VWFFaXJjkfcn1vja27qFrWAj5yb3IRzf2ik8ExZ+WtLhrRKQY1Ovc
         9TqSXShZ6fBFgvx0/Wr1zm7dDa9pvLJ1lkTFxq2zD05wJBciWTmzqc/m9N4Fv5fkLmYA
         46MY9Z7RwxQ5tcz4THHGUsfGs6mjZdlJ65dlO9TXamt8ZkGf99gxCh5hjBuGZCfciAng
         7/6w==
X-Gm-Message-State: ACrzQf0/9DjL9FLyJRgjRCkPGXX7NB7d6KJSX/k4/I08S1F4AecdEEZB
        i5bXf42bikspllOyXKCmGtz3XA==
X-Google-Smtp-Source: AMsMyM7nVr2E4rDnRhbelfS7us0PH0eK3nVw9E84nraECaQCRgntj+daUZUAzMqKthsGAPklo64f+g==
X-Received: by 2002:a05:600c:221a:b0:3b4:75b8:3f7f with SMTP id z26-20020a05600c221a00b003b475b83f7fmr2450241wml.175.1663681860947;
        Tue, 20 Sep 2022 06:51:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e? ([2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c434a00b003b4868eb71bsm75688wme.25.2022.09.20.06.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:51:00 -0700 (PDT)
Message-ID: <65b66c5f-2f33-903c-ce87-3fb2b23f1b50@linaro.org>
Date:   Tue, 20 Sep 2022 15:50:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 02/17] phy: qcom-qmp-pcie-msm8996: drop unused type from
 config
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220920073826.20811-1-johan+linaro@kernel.org>
 <20220920073826.20811-3-johan+linaro@kernel.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro
In-Reply-To: <20220920073826.20811-3-johan+linaro@kernel.org>
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

On 20/09/2022 09:38, Johan Hovold wrote:
> The configuration PHY type is no longer used since the QMP driver split
> so drop it from the configuration.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> index 245f6dc1710e..20a76b1b23a2 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> @@ -188,8 +188,6 @@ struct qmp_phy;
>   
>   /* struct qmp_phy_cfg - per-PHY initialization config */
>   struct qmp_phy_cfg {
> -	/* phy-type - PCIE/UFS/USB */
> -	unsigned int type;
>   	/* number of lanes provided by phy */
>   	int nlanes;
>   
> @@ -323,7 +321,6 @@ static const char * const qmp_phy_vreg_l[] = {
>   };
>   
>   static const struct qmp_phy_cfg msm8996_pciephy_cfg = {
> -	.type			= PHY_TYPE_PCIE,
>   	.nlanes			= 3,
>   
>   	.serdes_tbl		= msm8996_pcie_serdes_tbl,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
