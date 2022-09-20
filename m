Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4146A5BE7AE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiITNxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiITNxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:53:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867995E33A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:52:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id y5so4445160wrh.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=XPhaGsczge3N/UI55awhMjt+l/2/p3CHP++Ik36lB8U=;
        b=bg4WmHgjn1E4uts7mLg4Z7Nc11HORYAsjiBz9+sxThXo0NEkEBww4re87mK2sHgxi2
         /k8XJ8czk2eijC2YuEhfsWTM5H3eSZnJA6C2O5nUx9wEAtRr51Ywol5ZSrsjU00taf0D
         piHIO7uorWeSqLdoOLHvThrHawLaaJxb8WF9AjnOQByJ+89erWpjkWAnmWvDCK433FWf
         cmmmwZsU15zj7Ok0cxn4hkBoaJRvHKdUf4lssr3A5xWACpKbu1o6f2sfDwpA4YQY+Sac
         PG1fBnyiHxxJoqHzS8pqIFkZf8BhSs7GcEkkOrVyCuSJ5NQsSU2x5uzhOG5x0sfvHNbO
         DCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=XPhaGsczge3N/UI55awhMjt+l/2/p3CHP++Ik36lB8U=;
        b=KM9SOPnEQv1AmoUJYTs4VQhbS/ebvJRw1Xpmart639tEEYEeiojVh+xg9g44EXUUAM
         nwXSoGEtZQHh6kvTRMlEwwiXVjUYCKW4nkTzJS/ElsyYjnQrZZPJzPivuH2Ppcy9xWsQ
         gUjJDt/Ufuy1djr3O0xGm/7VLeqPWmoIg+nv/5XyLyJBQ+tQIt6voIakvCk/J+IRq/hq
         E01n4oMf0k2mGpqv2wrxB+E6OJ7Qltc1CEw74N/pvaz6RcB5eLZdaY4SzoY03QGPIT76
         pzYm1NGXa3T1+KEnit1EsRWyMBO72UW7WsUeSCJCUzqc73BkwClhuIBpsWq8GplYHqQn
         evZA==
X-Gm-Message-State: ACrzQf1VWyqQSbbC/ZDiVS0+IG1/AKx2zjaV6fPFtbdje7ZvAKJ0np6n
        lopSa2Xlgja8P3nd/sAXT+TNEg==
X-Google-Smtp-Source: AMsMyM4XrfqKk2rLzju7GMygIm7VfQ0/yNIb/liX1LgtMn85PpY3CNgsxamBRvv5R1VYKQ8uueUiBw==
X-Received: by 2002:a05:6000:168c:b0:226:f4c2:d6db with SMTP id y12-20020a056000168c00b00226f4c2d6dbmr13897466wrd.659.1663681940815;
        Tue, 20 Sep 2022 06:52:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e? ([2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e])
        by smtp.gmail.com with ESMTPSA id p3-20020a7bcc83000000b003b4ac05a8a4sm122593wma.27.2022.09.20.06.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:52:20 -0700 (PDT)
Message-ID: <d0de9feb-fce8-fdf1-cf4f-2a454cd06cc6@linaro.org>
Date:   Tue, 20 Sep 2022 15:52:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 16/17] phy: qcom-qmp-usb: consolidate lane config
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
 <20220920073826.20811-17-johan+linaro@kernel.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro
In-Reply-To: <20220920073826.20811-17-johan+linaro@kernel.org>
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
> For legacy reasons, there are two configuration parameters that appear
> to describe the number of lanes a PHY has, even if "nlanes" was actually
> used for a different purpose.
> 
> Replace them both with a new field simply named "lanes".
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 52 ++++++++++---------------
>   1 file changed, 20 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> index a34320738f60..f01b3022a10d 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> @@ -1429,8 +1429,7 @@ static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_pcs_tbl[] = {
>   
>   /* struct qmp_phy_cfg - per-PHY initialization config */
>   struct qmp_phy_cfg {
> -	/* number of lanes provided by phy */
> -	int nlanes;
> +	int lanes;
>   
>   	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
>   	const struct qmp_phy_init_tbl *serdes_tbl;
> @@ -1470,8 +1469,6 @@ struct qmp_phy_cfg {
>   
>   	/* true, if PHY has a separate DP_COM control block */
>   	bool has_phy_dp_com_ctrl;
> -	/* true, if PHY has secondary tx/rx lanes to be configured */
> -	bool is_dual_lane_phy;
>   
>   	/* Offset from PCS to PCS_USB region */
>   	unsigned int pcs_usb_offset;
> @@ -1603,7 +1600,7 @@ static const char * const qmp_phy_vreg_l[] = {
>   };
>   
>   static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 1,
>   
>   	.serdes_tbl		= ipq8074_usb3_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_usb3_serdes_tbl),
> @@ -1627,7 +1624,7 @@ static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg msm8996_usb3phy_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 1,
>   
>   	.serdes_tbl		= msm8996_usb3_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(msm8996_usb3_serdes_tbl),
> @@ -1651,7 +1648,7 @@ static const struct qmp_phy_cfg msm8996_usb3phy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg qmp_v3_usb3phy_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 2,
>   
>   	.serdes_tbl		= qmp_v3_usb3_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_serdes_tbl),
> @@ -1678,11 +1675,10 @@ static const struct qmp_phy_cfg qmp_v3_usb3phy_cfg = {
>   	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
>   
>   	.has_phy_dp_com_ctrl	= true,
> -	.is_dual_lane_phy	= true,
>   };
>   
>   static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 2,
>   
>   	.serdes_tbl		= qmp_v3_usb3_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_serdes_tbl),
> @@ -1709,11 +1705,10 @@ static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
>   	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
>   
>   	.has_phy_dp_com_ctrl	= true,
> -	.is_dual_lane_phy	= true,
>   };
>   
>   static const struct qmp_phy_cfg sc8280xp_usb3_uniphy_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 1,
>   
>   	.serdes_tbl		= sc8280xp_usb3_uniphy_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_serdes_tbl),
> @@ -1741,7 +1736,7 @@ static const struct qmp_phy_cfg sc8280xp_usb3_uniphy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 1,
>   
>   	.serdes_tbl		= qmp_v3_usb3_uniphy_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_uniphy_serdes_tbl),
> @@ -1769,7 +1764,7 @@ static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
> -	.nlanes                 = 1,
> +	.lanes			= 2,
>   
>   	.serdes_tbl             = msm8998_usb3_serdes_tbl,
>   	.serdes_tbl_num         = ARRAY_SIZE(msm8998_usb3_serdes_tbl),
> @@ -1790,12 +1785,10 @@ static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
>   	.start_ctrl             = SERDES_START | PCS_START,
>   	.pwrdn_ctrl             = SW_PWRDN,
>   	.phy_status		= PHYSTATUS,
> -
> -	.is_dual_lane_phy       = true,
>   };
>   
>   static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 2,
>   
>   	.serdes_tbl		= sm8150_usb3_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_serdes_tbl),
> @@ -1826,11 +1819,10 @@ static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
>   	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
>   
>   	.has_phy_dp_com_ctrl	= true,
> -	.is_dual_lane_phy	= true,
>   };
>   
>   static const struct qmp_phy_cfg sm8150_usb3_uniphy_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 1,
>   
>   	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
> @@ -1861,7 +1853,7 @@ static const struct qmp_phy_cfg sm8150_usb3_uniphy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 2,
>   
>   	.serdes_tbl		= sm8150_usb3_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_serdes_tbl),
> @@ -1891,11 +1883,10 @@ static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
>   	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
>   
>   	.has_phy_dp_com_ctrl	= true,
> -	.is_dual_lane_phy	= true,
>   };
>   
>   static const struct qmp_phy_cfg sm8250_usb3_uniphy_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 1,
>   
>   	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
> @@ -1926,7 +1917,7 @@ static const struct qmp_phy_cfg sm8250_usb3_uniphy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sdx55_usb3_uniphy_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 1,
>   
>   	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
> @@ -1957,7 +1948,7 @@ static const struct qmp_phy_cfg sdx55_usb3_uniphy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sdx65_usb3_uniphy_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 1,
>   
>   	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
> @@ -1988,7 +1979,7 @@ static const struct qmp_phy_cfg sdx65_usb3_uniphy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sm8350_usb3phy_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 2,
>   
>   	.serdes_tbl		= sm8150_usb3_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_serdes_tbl),
> @@ -2018,11 +2009,10 @@ static const struct qmp_phy_cfg sm8350_usb3phy_cfg = {
>   	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
>   
>   	.has_phy_dp_com_ctrl	= true,
> -	.is_dual_lane_phy	= true,
>   };
>   
>   static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 1,
>   
>   	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
> @@ -2053,7 +2043,7 @@ static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 2,
>   
>   	.serdes_tbl		= qcm2290_usb3_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(qcm2290_usb3_serdes_tbl),
> @@ -2074,8 +2064,6 @@ static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
>   	.start_ctrl		= SERDES_START | PCS_START,
>   	.pwrdn_ctrl		= SW_PWRDN,
>   	.phy_status		= PHYSTATUS,
> -
> -	.is_dual_lane_phy	= true,
>   };
>   
>   static void qmp_usb_configure_lane(void __iomem *base,
> @@ -2232,14 +2220,14 @@ static int qmp_usb_power_on(struct phy *phy)
>   	/* Tx, Rx, and PCS configurations */
>   	qmp_usb_configure_lane(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num, 1);
>   
> -	if (cfg->is_dual_lane_phy) {
> +	if (cfg->lanes >= 2) {
>   		qmp_usb_configure_lane(qphy->tx2, cfg->regs,
>   					cfg->tx_tbl, cfg->tx_tbl_num, 2);
>   	}
>   
>   	qmp_usb_configure_lane(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num, 1);
>   
> -	if (cfg->is_dual_lane_phy) {
> +	if (cfg->lanes >= 2) {
>   		qmp_usb_configure_lane(qphy->rx2, cfg->regs,
>   					cfg->rx_tbl, cfg->rx_tbl_num, 2);
>   	}
> @@ -2613,7 +2601,7 @@ int qmp_usb_create(struct device *dev, struct device_node *np, int id,
>   	if (cfg->pcs_usb_offset)
>   		qphy->pcs_usb = qphy->pcs + cfg->pcs_usb_offset;
>   
> -	if (cfg->is_dual_lane_phy) {
> +	if (cfg->lanes >= 2) {
>   		qphy->tx2 = devm_of_iomap(dev, np, 3, NULL);
>   		if (IS_ERR(qphy->tx2))
>   			return PTR_ERR(qphy->tx2);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
