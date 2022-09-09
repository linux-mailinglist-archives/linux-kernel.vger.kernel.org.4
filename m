Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4445B33B6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiIIJWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiIIJWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:22:17 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C279E136CD5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:21:26 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w8so1635190lft.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=5C5lLPWXo2PEugtUTd2/amAX/cOIrsmkGvZKcxLNXv8=;
        b=FjVvfjC4Qeanl9HJy1Wx0CDHchT64ls67ctXS3tW53xX37jJcTi0bJ0T8efnLOgred
         dC15271al2nKmj0OGleXVqNIEwnGhWfh7YLZYvONOCHBX1yTnlntuymCC/6jd6WcSYtc
         FHMsbFGKU/mpAINtvgEPyY++uCrQW47hJ75Sgl206LvZPHbtsmqhOONUoqZmOcE2Cqgk
         8/C28GxQMxs7S3CMX8zSlWeADy5SNwGkiMMLfHB51glfXKmoL0UDtXw5njLAS/qJWBGG
         iBCZxpw1Gwf4/zv5RK90wWztLUuvjKfdRwEWLde6spzua/n3Eqz2e6VwAhPmupfNSC8R
         UL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5C5lLPWXo2PEugtUTd2/amAX/cOIrsmkGvZKcxLNXv8=;
        b=dRThmPLzAd7rEJkknoUnPLQmBJEeiQ90tv0z1Sc2lPGj3z6B1qfdTwf5LtoFemlfTL
         ZeudTpB4aPehn05Qj1s3MZIHKyWyV0qe99cexG2PCEU6JIioFfrD+6fpYlyX3C6oYMjt
         KDxuSLuBRyGkyySF8+GoCFnsqEG4eBEEH2hpIx/WshMfp87avK3fB784ArIj8gAUGays
         aJl5xqlY9r2NdUZ2ZoYv3RsCHxzkOZQniMIR2SNZ/Q/EsI+MUe/tyX6Uz2q7yIt2+h9D
         L5nzfbTHadelled8dN50+0U0qyL8aoTw86QFuhQYp1MHtv9NLYr53zo7+WjtgKvgg2lv
         98HQ==
X-Gm-Message-State: ACgBeo096gUElajnpOeSiDVdRpz4v3HZZdnfCLfZb5rOa847w8h2Pz8c
        Cfblcz9enzyjJblrV/m6O+5opw==
X-Google-Smtp-Source: AA6agR4yyCDK3ccYh+WDpIf9g7K8b0E/jVJyesR/aOpi2YHy8mnAnvD5r6xvAlgzq4ZTZOOdwrtHWQ==
X-Received: by 2002:a05:6512:1694:b0:48a:9d45:763f with SMTP id bu20-20020a056512169400b0048a9d45763fmr3886463lfb.662.1662715273122;
        Fri, 09 Sep 2022 02:21:13 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u23-20020a05651c131700b0026ac8c94022sm207044lja.119.2022.09.09.02.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 02:21:12 -0700 (PDT)
Message-ID: <7370ba1d-472c-b036-4155-f86ca13f9824@linaro.org>
Date:   Fri, 9 Sep 2022 12:21:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 02/16] phy: qcom-qmp-combo: drop unused defines
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
 <20220907110728.19092-3-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220907110728.19092-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 14:07, Johan Hovold wrote:
> Drop defines and enums that are unused since the QMP driver split.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 15 ---------------
>   1 file changed, 15 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 9ce2ab56be4c..838f7e328b55 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -28,16 +28,11 @@
>   #define SW_RESET				BIT(0)
>   /* QPHY_POWER_DOWN_CONTROL */
>   #define SW_PWRDN				BIT(0)
> -#define REFCLK_DRV_DSBL				BIT(1)
>   /* QPHY_START_CONTROL bits */
>   #define SERDES_START				BIT(0)
>   #define PCS_START				BIT(1)
> -#define PLL_READY_GATE_EN			BIT(3)
>   /* QPHY_PCS_STATUS bit */
>   #define PHYSTATUS				BIT(6)
> -#define PHYSTATUS_4_20				BIT(7)
> -/* QPHY_PCS_READY_STATUS & QPHY_COM_PCS_READY_STATUS bit */
> -#define PCS_READY				BIT(0)

I think these defines, describing registers and bits, can go to the 
common header instead.

For the rest of the patch:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>   
>   /* QPHY_V3_DP_COM_RESET_OVRD_CTRL register bits */
>   /* DP PHY soft reset */
> @@ -71,8 +66,6 @@
>   #define POWER_DOWN_DELAY_US_MIN			10
>   #define POWER_DOWN_DELAY_US_MAX			11
>   
> -#define MAX_PROP_NAME				32
> -
>   /* Define the assumed distance between lanes for underspecified device trees. */
>   #define QMP_PHY_LEGACY_LANE_STRIDE		0x400
>   
> @@ -115,22 +108,14 @@ struct qmp_phy_init_tbl {
>   
>   /* set of registers with offsets different per-PHY */
>   enum qphy_reg_layout {
> -	/* Common block control registers */
> -	QPHY_COM_SW_RESET,
> -	QPHY_COM_POWER_DOWN_CONTROL,
> -	QPHY_COM_START_CONTROL,
> -	QPHY_COM_PCS_READY_STATUS,
>   	/* PCS registers */
>   	QPHY_SW_RESET,
>   	QPHY_START_CTRL,
> -	QPHY_PCS_READY_STATUS,
>   	QPHY_PCS_STATUS,
>   	QPHY_PCS_AUTONOMOUS_MODE_CTRL,
>   	QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR,
>   	QPHY_PCS_LFPS_RXTERM_IRQ_STATUS,
>   	QPHY_PCS_POWER_DOWN_CONTROL,
> -	/* PCS_MISC registers */
> -	QPHY_PCS_MISC_TYPEC_CTRL,
>   	/* Keep last to ensure regs_layout arrays are properly initialized */
>   	QPHY_LAYOUT_SIZE
>   };

-- 
With best wishes
Dmitry

