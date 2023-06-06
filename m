Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6F6724988
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbjFFQxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjFFQxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:53:41 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D9E10C2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 09:53:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f122ff663eso7907678e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 09:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686070417; x=1688662417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HgrSnorLuof4G6AWiNG2oMpArjTudY7Y6W05DTsApig=;
        b=xlYnHBX223yxAWf3QUKgvdo/20jkFTi76GToVAAXeONtDtnEr/m+lF7XPyLE3pxmJn
         BezM+LYvmEib1+ZOUbH3X7GrUmCx+F3zA6yy15W8P9oZyQd98YzgsGy0tO1hXcfFwVmR
         sEatc1muSJOpkuBnb7BSoUPpGZJ5hFsUrVZcCFamzw1mM/D8PitRiFSLBdZ3+/Z8DVT7
         5yzZXQ3lsFmMOgq2ZWZYXGlFzscUvjfJX4ZqzmW3OoYidztSvfd7XPweGnhVZJhf/GZl
         JsGbDSZu8b/yt0Po1OXJ8ahrSH2L9E8gI9okNHN9+dm2wQIwStAbrUIqh7JFpib8OVh5
         lVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686070417; x=1688662417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HgrSnorLuof4G6AWiNG2oMpArjTudY7Y6W05DTsApig=;
        b=JqaH/TdVPvbtNU5UKUAAgq9JW9aBGwWOGncrSzGkrpYb4AxbCd1ydoooYmomGbVjlw
         2N6ZdXLNJ7i+IYQHbkGu+mtti9tcMfISluKZKpIXlkjAd+nW6miort+5ebqfYvLwmag5
         Nl3niNTCi9uQ53pUlHLaq3yz+r3DAcQeejIX/uzqM8rbjvFbJF/iAJYv694fLzhH7gpA
         NWp1cWYIfsOaIFE2qIo0hR2wvIGF5fo7Bg84tRVSOFdV+vjxaUy9rgD04jYBGzPjF1ck
         gGFYYaLIQgdmlAF+r3nL6H3vS5vH87e+gam+eUWqb9sizTJmlbWiGrREC98jehX2hjHA
         Zm5w==
X-Gm-Message-State: AC+VfDyA9GTF7OHsuo54w0r0uOvHQzEDkx8fI8SIRJnIWB9NO6U81srp
        UdBWfrUy7X7+vpqimCjH9Ho+wg==
X-Google-Smtp-Source: ACHHUZ4BI66AqOgJkQv4p35BZAutlqUk6dLE91ZpNOeuv2wHjzcHvl0f4NeJSHKMPmxzRpn2zZLqWw==
X-Received: by 2002:a2e:3013:0:b0:2a6:18c0:2b35 with SMTP id w19-20020a2e3013000000b002a618c02b35mr1326583ljw.0.1686070417207;
        Tue, 06 Jun 2023 09:53:37 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id 9-20020a05651c00c900b002aa3ad9014asm1943304ljr.54.2023.06.06.09.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 09:53:36 -0700 (PDT)
Message-ID: <dec20727-bf6f-fdfc-c5fd-2c00a4848987@linaro.org>
Date:   Tue, 6 Jun 2023 18:53:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/2] soc: qcom: geni-se: Add interfaces
 geni_se_tx_init_dma() and geni_se_rx_init_dma()
Content-Language: en-US
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, broonie@kernel.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, quic_ptalari@quicinc.com
References: <1684325894-30252-1-git-send-email-quic_vnivarth@quicinc.com>
 <1684325894-30252-2-git-send-email-quic_vnivarth@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1684325894-30252-2-git-send-email-quic_vnivarth@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.05.2023 14:18, Vijaya Krishna Nivarthi wrote:
> The geni_se_xx_dma_prep() interfaces necessarily do DMA mapping before
> initiating DMA transfers. This is not suitable for spi where framework
> is expected to handle map/unmap.
> 
> Expose new interfaces geni_se_xx_init_dma() which do only DMA transfer.
> 
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> v1 -> v2:
> - interfaces to take dma address as argument instead of its pointer
> ---
>  drivers/soc/qcom/qcom-geni-se.c  | 67 +++++++++++++++++++++++++++++-----------
>  include/linux/soc/qcom/geni-se.h |  4 +++
>  2 files changed, 53 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 795a2e1..dd50a25 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -682,6 +682,30 @@ EXPORT_SYMBOL(geni_se_clk_freq_match);
>  #define GENI_SE_DMA_EOT_EN BIT(1)
>  #define GENI_SE_DMA_AHB_ERR_EN BIT(2)
>  #define GENI_SE_DMA_EOT_BUF BIT(0)
> +
> +/**
> + * geni_se_tx_init_dma() - Initiate TX DMA transfer on the serial engine
> + * @se:			Pointer to the concerned serial engine.
> + * @iova:		Mapped DMA address.
> + * @len:		Length of the TX buffer.
> + *
> + * This function is used to initiate DMA TX transfer.
> + */
> +void geni_se_tx_init_dma(struct geni_se *se, dma_addr_t iova, size_t len)
> +{
> +	u32 val;
> +
> +	val = GENI_SE_DMA_DONE_EN;
> +	val |= GENI_SE_DMA_EOT_EN;
> +	val |= GENI_SE_DMA_AHB_ERR_EN;
> +	writel_relaxed(val, se->base + SE_DMA_TX_IRQ_EN_SET);
> +	writel_relaxed(lower_32_bits(iova), se->base + SE_DMA_TX_PTR_L);
> +	writel_relaxed(upper_32_bits(iova), se->base + SE_DMA_TX_PTR_H);
> +	writel_relaxed(GENI_SE_DMA_EOT_BUF, se->base + SE_DMA_TX_ATTR);
> +	writel(len, se->base + SE_DMA_TX_LEN);
> +}
> +EXPORT_SYMBOL(geni_se_tx_init_dma);
> +
>  /**
>   * geni_se_tx_dma_prep() - Prepare the serial engine for TX DMA transfer
>   * @se:			Pointer to the concerned serial engine.
> @@ -697,7 +721,6 @@ int geni_se_tx_dma_prep(struct geni_se *se, void *buf, size_t len,
>  			dma_addr_t *iova)
>  {
>  	struct geni_wrapper *wrapper = se->wrapper;
> -	u32 val;
>  
>  	if (!wrapper)
>  		return -EINVAL;
> @@ -706,17 +729,34 @@ int geni_se_tx_dma_prep(struct geni_se *se, void *buf, size_t len,
>  	if (dma_mapping_error(wrapper->dev, *iova))
>  		return -EIO;
>  
> +	geni_se_tx_init_dma(se, *iova, len);
> +	return 0;
> +}
> +EXPORT_SYMBOL(geni_se_tx_dma_prep);
> +
> +/**
> + * geni_se_rx_init_dma() - Initiate RX DMA transfer on the serial engine
> + * @se:			Pointer to the concerned serial engine.
> + * @iova:		Mapped DMA address.
> + * @len:		Length of the RX buffer.
> + *
> + * This function is used to initiate DMA RX transfer.
> + */
> +void geni_se_rx_init_dma(struct geni_se *se, dma_addr_t iova, size_t len)
> +{
> +	u32 val;
> +
>  	val = GENI_SE_DMA_DONE_EN;
>  	val |= GENI_SE_DMA_EOT_EN;
>  	val |= GENI_SE_DMA_AHB_ERR_EN;
> -	writel_relaxed(val, se->base + SE_DMA_TX_IRQ_EN_SET);
> -	writel_relaxed(lower_32_bits(*iova), se->base + SE_DMA_TX_PTR_L);
> -	writel_relaxed(upper_32_bits(*iova), se->base + SE_DMA_TX_PTR_H);
> -	writel_relaxed(GENI_SE_DMA_EOT_BUF, se->base + SE_DMA_TX_ATTR);
> -	writel(len, se->base + SE_DMA_TX_LEN);
> -	return 0;
> +	writel_relaxed(val, se->base + SE_DMA_RX_IRQ_EN_SET);
> +	writel_relaxed(lower_32_bits(iova), se->base + SE_DMA_RX_PTR_L);
> +	writel_relaxed(upper_32_bits(iova), se->base + SE_DMA_RX_PTR_H);
> +	/* RX does not have EOT buffer type bit. So just reset RX_ATTR */
> +	writel_relaxed(0, se->base + SE_DMA_RX_ATTR);
> +	writel(len, se->base + SE_DMA_RX_LEN);
>  }
> -EXPORT_SYMBOL(geni_se_tx_dma_prep);
> +EXPORT_SYMBOL(geni_se_rx_init_dma);
>  
>  /**
>   * geni_se_rx_dma_prep() - Prepare the serial engine for RX DMA transfer
> @@ -733,7 +773,6 @@ int geni_se_rx_dma_prep(struct geni_se *se, void *buf, size_t len,
>  			dma_addr_t *iova)
>  {
>  	struct geni_wrapper *wrapper = se->wrapper;
> -	u32 val;
>  
>  	if (!wrapper)
>  		return -EINVAL;
> @@ -742,15 +781,7 @@ int geni_se_rx_dma_prep(struct geni_se *se, void *buf, size_t len,
>  	if (dma_mapping_error(wrapper->dev, *iova))
>  		return -EIO;
>  
> -	val = GENI_SE_DMA_DONE_EN;
> -	val |= GENI_SE_DMA_EOT_EN;
> -	val |= GENI_SE_DMA_AHB_ERR_EN;
> -	writel_relaxed(val, se->base + SE_DMA_RX_IRQ_EN_SET);
> -	writel_relaxed(lower_32_bits(*iova), se->base + SE_DMA_RX_PTR_L);
> -	writel_relaxed(upper_32_bits(*iova), se->base + SE_DMA_RX_PTR_H);
> -	/* RX does not have EOT buffer type bit. So just reset RX_ATTR */
> -	writel_relaxed(0, se->base + SE_DMA_RX_ATTR);
> -	writel(len, se->base + SE_DMA_RX_LEN);
> +	geni_se_rx_init_dma(se, *iova, len);
>  	return 0;
>  }
>  EXPORT_SYMBOL(geni_se_rx_dma_prep);
> diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
> index c55a0bc..821a191 100644
> --- a/include/linux/soc/qcom/geni-se.h
> +++ b/include/linux/soc/qcom/geni-se.h
> @@ -490,9 +490,13 @@ int geni_se_clk_freq_match(struct geni_se *se, unsigned long req_freq,
>  			   unsigned int *index, unsigned long *res_freq,
>  			   bool exact);
>  
> +void geni_se_tx_init_dma(struct geni_se *se, dma_addr_t iova, size_t len);
> +
>  int geni_se_tx_dma_prep(struct geni_se *se, void *buf, size_t len,
>  			dma_addr_t *iova);
>  
> +void geni_se_rx_init_dma(struct geni_se *se, dma_addr_t iova, size_t len);
> +
>  int geni_se_rx_dma_prep(struct geni_se *se, void *buf, size_t len,
>  			dma_addr_t *iova);
>  
