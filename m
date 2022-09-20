Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264F45BE795
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiITNv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiITNvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:51:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2778A43E56
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:51:14 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c11so4347402wrp.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=zRdDzhw5a5ynTYghKQQWj3Myrcf9LCWPiu6p7svaVow=;
        b=EUiRpoNFUN/WpjyuZ1UJ1keXlSOG0zCvvVFA4G2Hmdh0RqkoKkY9ihX6upTCnBnec1
         lTLkgdr9w2OB1ukhlbVaaP/enGXy4xOGbTvg7lNPH6ZVrPgJ0eWvcB19fZeRKq5S4O51
         PJzFW/f7bbyOxcHB0/BIXiZh4eaEk8WKID0uPrttgdf53CcfujwHaJWwWm38FK2IwuWJ
         gTCPEQ89qdrCodpCGn0FlQXaK2asnjTvYJD0LGZwiGfwdHwQSa9k2NZ0NU1LBTjOus38
         yvOF1fBORCtJPXvaORw67SP36EuxRejXey1S1LYYXgv6pjNwP4Ted6qXIJMA5iU9x+QJ
         juxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=zRdDzhw5a5ynTYghKQQWj3Myrcf9LCWPiu6p7svaVow=;
        b=pMTZMwUvJ2FerlbwtDkQJw8HQQAExWRtWMirbmbRmkzISFTZPiwOblFmYMabRGeJLO
         fE/AdsoICbs8N/NtGaV/e83Kz7uvaSR7whUvbqYcxnsfNwpafn0UwgncAfLi3vIZI6LA
         Ot3QEF1C5Yndcsplkm1PSgnqrSYvKj7rwIFw14u9KohcVN2MrF45ZBhmw6o1ZQ8F2485
         +U+kImocW7TJktUCSmDmejJTw101M3dwUhdvRWe5OmNjRBzj8Ue/jDEh+JpBybimAXYL
         gWzrlXDZK7jR2A5T8+BAhyv+TFxq2eXc4Xug3RszlIK5ysiGi28aF4gtWxuZCiK8iAlC
         lmEQ==
X-Gm-Message-State: ACrzQf2j0MyzaiJALWC73LdmjHc5K9IAIT0EhIMCu97i9zXh6XZwufdn
        BOj/mxRWjQ2Z7X9Gw0dB0t5Faw==
X-Google-Smtp-Source: AMsMyM7n/pavtoyKgl/9/d0NKHH8QpSRBO+kZHsIFiUN9oTH2DfQ2z0y02cbyowDfN+fbyOuNhMrcw==
X-Received: by 2002:adf:dd8f:0:b0:22a:84ab:4be3 with SMTP id x15-20020adfdd8f000000b0022a84ab4be3mr13901955wrl.40.1663681872593;
        Tue, 20 Sep 2022 06:51:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e? ([2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c42d200b003b2878b9e0dsm93697wme.20.2022.09.20.06.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:51:12 -0700 (PDT)
Message-ID: <1d34c9bf-24c2-84ea-8a85-7cd15e09d6d0@linaro.org>
Date:   Tue, 20 Sep 2022 15:51:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 04/17] phy: qcom-qmp-usb: drop unused type from config
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
 <20220920073826.20811-5-johan+linaro@kernel.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro
In-Reply-To: <20220920073826.20811-5-johan+linaro@kernel.org>
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
> The configuration PHY type is no longer needed since the QMP driver
> split so drop it from the configuration and suspend callbacks.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 26 -------------------------
>   1 file changed, 26 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> index 93994f1a46e2..03481b6f1c35 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> @@ -1431,8 +1431,6 @@ struct qmp_phy;
>   
>   /* struct qmp_phy_cfg - per-PHY initialization config */
>   struct qmp_phy_cfg {
> -	/* phy-type - PCIE/UFS/USB */
> -	unsigned int type;
>   	/* number of lanes provided by phy */
>   	int nlanes;
>   
> @@ -1609,7 +1607,6 @@ static const char * const qmp_phy_vreg_l[] = {
>   };
>   
>   static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
> -	.type			= PHY_TYPE_USB3,
>   	.nlanes			= 1,
>   
>   	.serdes_tbl		= ipq8074_usb3_serdes_tbl,
> @@ -1634,7 +1631,6 @@ static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg msm8996_usb3phy_cfg = {
> -	.type			= PHY_TYPE_USB3,
>   	.nlanes			= 1,
>   
>   	.serdes_tbl		= msm8996_usb3_serdes_tbl,
> @@ -1659,7 +1655,6 @@ static const struct qmp_phy_cfg msm8996_usb3phy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg qmp_v3_usb3phy_cfg = {
> -	.type			= PHY_TYPE_USB3,
>   	.nlanes			= 1,
>   
>   	.serdes_tbl		= qmp_v3_usb3_serdes_tbl,
> @@ -1691,7 +1686,6 @@ static const struct qmp_phy_cfg qmp_v3_usb3phy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
> -	.type			= PHY_TYPE_USB3,
>   	.nlanes			= 1,
>   
>   	.serdes_tbl		= qmp_v3_usb3_serdes_tbl,
> @@ -1723,7 +1717,6 @@ static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sc8280xp_usb3_uniphy_cfg = {
> -	.type			= PHY_TYPE_USB3,
>   	.nlanes			= 1,
>   
>   	.serdes_tbl		= sc8280xp_usb3_uniphy_serdes_tbl,
> @@ -1752,7 +1745,6 @@ static const struct qmp_phy_cfg sc8280xp_usb3_uniphy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
> -	.type			= PHY_TYPE_USB3,
>   	.nlanes			= 1,
>   
>   	.serdes_tbl		= qmp_v3_usb3_uniphy_serdes_tbl,
> @@ -1781,7 +1773,6 @@ static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
> -	.type                   = PHY_TYPE_USB3,
>   	.nlanes                 = 1,
>   
>   	.serdes_tbl             = msm8998_usb3_serdes_tbl,
> @@ -1808,7 +1799,6 @@ static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
> -	.type			= PHY_TYPE_USB3,
>   	.nlanes			= 1,
>   
>   	.serdes_tbl		= sm8150_usb3_serdes_tbl,
> @@ -1844,7 +1834,6 @@ static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sm8150_usb3_uniphy_cfg = {
> -	.type			= PHY_TYPE_USB3,
>   	.nlanes			= 1,
>   
>   	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
> @@ -1876,7 +1865,6 @@ static const struct qmp_phy_cfg sm8150_usb3_uniphy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
> -	.type			= PHY_TYPE_USB3,
>   	.nlanes			= 1,
>   
>   	.serdes_tbl		= sm8150_usb3_serdes_tbl,
> @@ -1911,7 +1899,6 @@ static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sm8250_usb3_uniphy_cfg = {
> -	.type			= PHY_TYPE_USB3,
>   	.nlanes			= 1,
>   
>   	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
> @@ -1943,7 +1930,6 @@ static const struct qmp_phy_cfg sm8250_usb3_uniphy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sdx55_usb3_uniphy_cfg = {
> -	.type			= PHY_TYPE_USB3,
>   	.nlanes			= 1,
>   
>   	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
> @@ -1975,7 +1961,6 @@ static const struct qmp_phy_cfg sdx55_usb3_uniphy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sdx65_usb3_uniphy_cfg = {
> -	.type			= PHY_TYPE_USB3,
>   	.nlanes			= 1,
>   
>   	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
> @@ -2007,7 +1992,6 @@ static const struct qmp_phy_cfg sdx65_usb3_uniphy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sm8350_usb3phy_cfg = {
> -	.type			= PHY_TYPE_USB3,
>   	.nlanes			= 1,
>   
>   	.serdes_tbl		= sm8150_usb3_serdes_tbl,
> @@ -2042,7 +2026,6 @@ static const struct qmp_phy_cfg sm8350_usb3phy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
> -	.type			= PHY_TYPE_USB3,
>   	.nlanes			= 1,
>   
>   	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
> @@ -2074,7 +2057,6 @@ static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
> -	.type			= PHY_TYPE_USB3,
>   	.nlanes			= 1,
>   
>   	.serdes_tbl		= qcm2290_usb3_serdes_tbl,
> @@ -2432,10 +2414,6 @@ static int __maybe_unused qmp_usb_runtime_suspend(struct device *dev)
>   
>   	dev_vdbg(dev, "Suspending QMP phy, mode:%d\n", qphy->mode);
>   
> -	/* Supported only for USB3 PHY and luckily USB3 is the first phy */
> -	if (cfg->type != PHY_TYPE_USB3)
> -		return 0;
> -
>   	if (!qphy->phy->init_count) {
>   		dev_vdbg(dev, "PHY not initialized, bailing out\n");
>   		return 0;
> @@ -2458,10 +2436,6 @@ static int __maybe_unused qmp_usb_runtime_resume(struct device *dev)
>   
>   	dev_vdbg(dev, "Resuming QMP phy, mode:%d\n", qphy->mode);
>   
> -	/* Supported only for USB3 PHY and luckily USB3 is the first phy */
> -	if (cfg->type != PHY_TYPE_USB3)
> -		return 0;
> -
>   	if (!qphy->phy->init_count) {
>   		dev_vdbg(dev, "PHY not initialized, bailing out\n");
>   		return 0;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
