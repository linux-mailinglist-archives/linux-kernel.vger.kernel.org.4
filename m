Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34835BE7A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiITNwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiITNwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:52:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301895B06E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:51:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso1714329wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=GS8xCUqG0t9AUIgS1AsqigvxUb4zPV78ytM7QDX7zq4=;
        b=qAGojTB3TzqZohOagS2b4f0NiciUWWpLykoYRuzcCPs8dOpGbE3d3gEjd9N5Wt3ncA
         iD2y0maUZFucvo3oY1aIu99GcFrFUKhEJ6uKD/vK+9kzJPgHTs1atSTd8y5rc9CplyrL
         SynYZ839Jn2IhmloVc3PqdIEHSCOmJuMBsi96Yi3yWcrS5rP5fknizvDw5332Rg9XBOl
         jf2AD4zXgA/j1H5XHX/UpMAmT2PO+q2CWbkE3ZDZHw3ipxuNTa3M9qQR1jc2JhDD9B5U
         9/cGZzhT+hV7tmn5Fdb+D9N1U9odjeKFqc9xSA9FL8WUWbK7cafe+yvevGVsQ9QY4/Yp
         PyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=GS8xCUqG0t9AUIgS1AsqigvxUb4zPV78ytM7QDX7zq4=;
        b=1LAPLLUqx5fqGeulucUMROGzdFusCtIHDJC8Hv38+euV5b9V4d8ETJiOQisYOxMZCR
         z7RHRH/e1ergnRQS4mfHYyTaj744r+gqnzyM3oezB3UgSiC1iQ77a0z8t6VpzE6ygW2Q
         oEdmWD/Dj2h3OJ21J+vkew17XjxZ9z0NrZ2mMt3cn2l2VKMBhlPcG26oZjUY3Dq3/xPV
         TK4Q48kTivaMVCWQBSsITk7Oq92OiLv+fT8CYAgWdnUsrKL5NfSHNB+ZsGrd0JfCccc9
         Epy2UAyswPzNTQ8p5qt2zqW1tAhIFe8AL0MYYc/tDgPHJygxI1qkCyYosY/wigG+RWoo
         GVlQ==
X-Gm-Message-State: ACrzQf3MKlm2xJSLLiHUYYnvIkOM5QgPNdMUvMy2Pd9bAijGQyESpEMs
        f3EuabMybG5E+t6s2GDdxT58kQ==
X-Google-Smtp-Source: AMsMyM5h4R1g+4DB6J3HIKjYxzM6ZnYv1jtOwCd+qTb7MSVW0Jlj33YlC9C02kM6+bVY6drXnGK10g==
X-Received: by 2002:a05:600c:2142:b0:3b4:9289:9d4e with SMTP id v2-20020a05600c214200b003b492899d4emr2557770wml.197.1663681917329;
        Tue, 20 Sep 2022 06:51:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e? ([2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e])
        by smtp.gmail.com with ESMTPSA id z10-20020a5d44ca000000b0022add371ed2sm49217wrr.55.2022.09.20.06.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:51:56 -0700 (PDT)
Message-ID: <8fda5b6a-1549-6034-1315-af1c33e6aa04@linaro.org>
Date:   Tue, 20 Sep 2022 15:51:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 12/17] phy: qcom-qmp-pcie: consolidate lane config
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
 <20220920073826.20811-13-johan+linaro@kernel.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro
In-Reply-To: <20220920073826.20811-13-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 09:38, Johan Hovold wrote:
> For legacy reasons, there are two configuration parameters that describe
> the number of lanes a PHY has.
> 
> Replace them both with a new field simply named "lanes".
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 39 ++++++++++--------------
>   1 file changed, 16 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 387abed33727..dde398105f03 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1302,8 +1302,7 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
>   
>   /* struct qmp_phy_cfg - per-PHY initialization config */
>   struct qmp_phy_cfg {
> -	/* number of lanes provided by phy */
> -	int nlanes;
> +	int lanes;
>   
>   	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
>   	const struct qmp_phy_init_tbl *serdes_tbl;
> @@ -1351,9 +1350,6 @@ struct qmp_phy_cfg {
>   	int pwrdn_delay_min;
>   	int pwrdn_delay_max;
>   
> -	/* true, if PHY has secondary tx/rx lanes to be configured */
> -	bool is_dual_lane_phy;
> -
>   	/* QMP PHY pipe clock interface rate */
>   	unsigned long pipe_clock_rate;
>   };
> @@ -1461,7 +1457,7 @@ static const char * const sdm845_pciephy_reset_l[] = {
>   };
>   
>   static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 1,
>   
>   	.serdes_tbl		= ipq8074_pcie_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_pcie_serdes_tbl),
> @@ -1489,7 +1485,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 1,
>   
>   	.serdes_tbl		= ipq8074_pcie_gen3_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_pcie_gen3_serdes_tbl),
> @@ -1518,7 +1514,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 1,
>   
>   	.serdes_tbl		= ipq6018_pcie_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(ipq6018_pcie_serdes_tbl),
> @@ -1547,7 +1543,7 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
> -	.nlanes = 1,
> +	.lanes			= 1,
>   
>   	.serdes_tbl		= sdm845_qmp_pcie_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sdm845_qmp_pcie_serdes_tbl),
> @@ -1577,7 +1573,7 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
> -	.nlanes = 1,
> +	.lanes			= 1,
>   
>   	.serdes_tbl		= sdm845_qhp_pcie_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sdm845_qhp_pcie_serdes_tbl),
> @@ -1605,7 +1601,7 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
> -	.nlanes = 1,
> +	.lanes			= 1,
>   
>   	.serdes_tbl		= sm8250_qmp_pcie_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_serdes_tbl),
> @@ -1643,7 +1639,7 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
> -	.nlanes = 2,
> +	.lanes			= 2,
>   
>   	.serdes_tbl		= sm8250_qmp_pcie_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_serdes_tbl),
> @@ -1675,14 +1671,13 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
>   	.phy_status		= PHYSTATUS,
>   
> -	.is_dual_lane_phy	= true,
>   	.has_pwrdn_delay	= true,
>   	.pwrdn_delay_min	= 995,		/* us */
>   	.pwrdn_delay_max	= 1005,		/* us */
>   };
>   
>   static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 1,
>   
>   	.serdes_tbl		= msm8998_pcie_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(msm8998_pcie_serdes_tbl),
> @@ -1706,7 +1701,7 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
> -	.nlanes = 1,
> +	.lanes			= 1,
>   
>   	.serdes_tbl		= sc8180x_qmp_pcie_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sc8180x_qmp_pcie_serdes_tbl),
> @@ -1735,7 +1730,7 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
> -	.nlanes = 2,
> +	.lanes			= 2,
>   
>   	.serdes_tbl		= sdx55_qmp_pcie_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sdx55_qmp_pcie_serdes_tbl),
> @@ -1759,14 +1754,13 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
>   	.pwrdn_ctrl		= SW_PWRDN,
>   	.phy_status		= PHYSTATUS_4_20,
>   
> -	.is_dual_lane_phy	= true,
>   	.has_pwrdn_delay	= true,
>   	.pwrdn_delay_min	= 995,		/* us */
>   	.pwrdn_delay_max	= 1005,		/* us */
>   };
>   
>   static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
> -	.nlanes = 1,
> +	.lanes			= 1,
>   
>   	.serdes_tbl		= sm8450_qmp_gen3x1_pcie_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_serdes_tbl),
> @@ -1796,7 +1790,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
> -	.nlanes = 2,
> +	.lanes			= 2,
>   
>   	.serdes_tbl		= sm8450_qmp_gen4x2_pcie_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_serdes_tbl),
> @@ -1820,7 +1814,6 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
>   	.phy_status		= PHYSTATUS_4_20,
>   
> -	.is_dual_lane_phy	= true,
>   	.has_pwrdn_delay	= true,
>   	.pwrdn_delay_min	= 995,		/* us */
>   	.pwrdn_delay_max	= 1005,		/* us */
> @@ -1959,7 +1952,7 @@ static int qmp_pcie_power_on(struct phy *phy)
>   	qmp_pcie_configure_lane(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num, 1);
>   	qmp_pcie_configure_lane(tx, cfg->regs, cfg->tx_tbl_sec, cfg->tx_tbl_num_sec, 1);
>   
> -	if (cfg->is_dual_lane_phy) {
> +	if (cfg->lanes >= 2) {
>   		qmp_pcie_configure_lane(qphy->tx2, cfg->regs, cfg->tx_tbl,
>   					cfg->tx_tbl_num, 2);
>   		qmp_pcie_configure_lane(qphy->tx2, cfg->regs, cfg->tx_tbl_sec,
> @@ -1969,7 +1962,7 @@ static int qmp_pcie_power_on(struct phy *phy)
>   	qmp_pcie_configure_lane(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num, 1);
>   	qmp_pcie_configure_lane(rx, cfg->regs, cfg->rx_tbl_sec, cfg->rx_tbl_num_sec, 1);
>   
> -	if (cfg->is_dual_lane_phy) {
> +	if (cfg->lanes >= 2) {
>   		qmp_pcie_configure_lane(qphy->rx2, cfg->regs, cfg->rx_tbl,
>   					cfg->rx_tbl_num, 2);
>   		qmp_pcie_configure_lane(qphy->rx2, cfg->regs, cfg->rx_tbl_sec,
> @@ -2225,7 +2218,7 @@ static int qmp_pcie_create(struct device *dev, struct device_node *np, int id,
>   	if (IS_ERR(qphy->pcs))
>   		return PTR_ERR(qphy->pcs);
>   
> -	if (cfg->is_dual_lane_phy) {
> +	if (cfg->lanes >= 2) {
>   		qphy->tx2 = devm_of_iomap(dev, np, 3, NULL);
>   		if (IS_ERR(qphy->tx2))
>   			return PTR_ERR(qphy->tx2);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
