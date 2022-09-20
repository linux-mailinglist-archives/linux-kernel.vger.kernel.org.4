Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400205BE7B0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiITNxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiITNxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:53:07 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615F25D10D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:52:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso1700768wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=AWtjT2u+vp0D/FoUg/ptAKwZasKj7W1btLlubXOxxp0=;
        b=HF/BjM7DpoMddEUiD/69qzOb8J1oET1UVGmHLro4CW5NN4kq6OUcOR6FgzO+dgFaG8
         ad+cwYQbH4TpVdimAHiPAdupwhcKMUwH2gffrvhKgJOxltkf6bxmvPDPxD/ONjAo2DB8
         tLpTz5PGEKW4IbvIilnW+TK5TQwl8M+TBYIpCGVAnLYxLFMMAmETdljIUw3OBtdp/O/1
         qXRSkaXIBu1BAuxfVXoEvPmzBg08ouNV/Gq8BV4tQUQyTC6EmCWr4rhEGNNxLoi75dPD
         nKu8o9hIByc5GDf6KFoaI0Np0fyNBKYAM5vpgKSl3Z8ouFbB1qgYe3yG7DFiNDPJutuA
         D5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=AWtjT2u+vp0D/FoUg/ptAKwZasKj7W1btLlubXOxxp0=;
        b=sLS7yElBMnHlBaoMS6n3vsAi+mtmEGrDoqRm39XPefHP8V+Wz93aakV12qh/bKFdSq
         vBsLIm/lMCvxPopIpp8E7iLPJbC7bFKs75dI7BCbc8yM4izOqzhZtzuhJsstLJw4JFLO
         qrZLLhJZhkLhH3T9PcmoakoniLP6RfsTIkPbm4psaXaB4VQcEC8bS26dngu4AFnmZh7F
         zpJanRpV+3wpfNHMw8hlDTx3RaFa8XGQWhDHJ9WSQNLmK2D8rdCLKzkKiLDuRNWbWlQW
         ssC+i/djxXeyN6ONFUgIOxZkG6PMAn21iYOh9uo2Qb1FmHd/CGPM5E/5eb4nIXsH/ydk
         MUcg==
X-Gm-Message-State: ACrzQf1pK8CNZSCqObd9jyi9EZJehGWloKTPCSWs73W0tYZnKxkG3FbP
        zpgPHX+6PONyaDqZvLx79azcTA==
X-Google-Smtp-Source: AMsMyM4JNk7/pJsx20bjdm+c21jjvi1p0yC9YAQo1xAcwhpqb+VR/GBioEJ35NH8WH2Mgw61Oh5Qiw==
X-Received: by 2002:a7b:c7d8:0:b0:3b4:5c41:6a6c with SMTP id z24-20020a7bc7d8000000b003b45c416a6cmr2445865wmk.139.1663681936861;
        Tue, 20 Sep 2022 06:52:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e? ([2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c155200b003b4931eb435sm114211wmg.26.2022.09.20.06.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:52:16 -0700 (PDT)
Message-ID: <603b436d-e6d7-da4c-bea9-7211b82654dd@linaro.org>
Date:   Tue, 20 Sep 2022 15:52:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 15/17] phy: qcom-qmp-ufs: consolidate lane config
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
 <20220920073826.20811-16-johan+linaro@kernel.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro
In-Reply-To: <20220920073826.20811-16-johan+linaro@kernel.org>
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
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 31 ++++++++-----------------
>   1 file changed, 10 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index ca9a42250556..d21b977850b3 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -533,8 +533,7 @@ static const struct qmp_phy_init_tbl sm8350_ufsphy_pcs_tbl[] = {
>   
>   /* struct qmp_phy_cfg - per-PHY initialization config */
>   struct qmp_phy_cfg {
> -	/* number of lanes provided by phy */
> -	int nlanes;
> +	int lanes;
>   
>   	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
>   	const struct qmp_phy_init_tbl *serdes_tbl;
> @@ -561,9 +560,6 @@ struct qmp_phy_cfg {
>   	/* bit offset of PHYSTATUS in QPHY_PCS_STATUS register */
>   	unsigned int phy_status;
>   
> -	/* true, if PHY has secondary tx/rx lanes to be configured */
> -	bool is_dual_lane_phy;
> -
>   	/* true, if PCS block has no separate SW_RESET register */
>   	bool no_pcs_sw_reset;
>   };
> @@ -662,7 +658,7 @@ static const char * const qmp_phy_vreg_l[] = {
>   };
>   
>   static const struct qmp_phy_cfg msm8996_ufs_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 1,
>   
>   	.serdes_tbl		= msm8996_ufs_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(msm8996_ufs_serdes_tbl),
> @@ -687,7 +683,7 @@ static const struct qmp_phy_cfg msm8996_ufs_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
> -	.nlanes			= 2,
> +	.lanes			= 2,
>   
>   	.serdes_tbl		= sdm845_ufsphy_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_serdes_tbl),
> @@ -707,12 +703,11 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
>   	.pwrdn_ctrl		= SW_PWRDN,
>   	.phy_status		= PHYSTATUS,
>   
> -	.is_dual_lane_phy	= true,
>   	.no_pcs_sw_reset	= true,
>   };
>   
>   static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
> -	.nlanes			= 1,
> +	.lanes			= 1,
>   
>   	.serdes_tbl		= sm6115_ufsphy_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_serdes_tbl),
> @@ -735,7 +730,7 @@ static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
> -	.nlanes			= 2,
> +	.lanes			= 2,
>   
>   	.serdes_tbl		= sm8150_ufsphy_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_serdes_tbl),
> @@ -754,12 +749,10 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
>   	.start_ctrl		= SERDES_START,
>   	.pwrdn_ctrl		= SW_PWRDN,
>   	.phy_status		= PHYSTATUS,
> -
> -	.is_dual_lane_phy	= true,
>   };
>   
>   static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
> -	.nlanes			= 2,
> +	.lanes			= 2,
>   
>   	.serdes_tbl		= sm8350_ufsphy_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_serdes_tbl),
> @@ -778,12 +771,10 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
>   	.start_ctrl		= SERDES_START,
>   	.pwrdn_ctrl		= SW_PWRDN,
>   	.phy_status		= PHYSTATUS,
> -
> -	.is_dual_lane_phy	= true,
>   };
>   
>   static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
> -	.nlanes			= 2,
> +	.lanes			= 2,
>   
>   	.serdes_tbl		= sm8350_ufsphy_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_serdes_tbl),
> @@ -802,8 +793,6 @@ static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
>   	.start_ctrl		= SERDES_START,
>   	.pwrdn_ctrl		= SW_PWRDN,
>   	.phy_status		= PHYSTATUS,
> -
> -	.is_dual_lane_phy	= true,
>   };
>   
>   static void qmp_ufs_configure_lane(void __iomem *base,
> @@ -956,14 +945,14 @@ static int qmp_ufs_power_on(struct phy *phy)
>   	/* Tx, Rx, and PCS configurations */
>   	qmp_ufs_configure_lane(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num, 1);
>   
> -	if (cfg->is_dual_lane_phy) {
> +	if (cfg->lanes >= 2) {
>   		qmp_ufs_configure_lane(qphy->tx2, cfg->regs,
>   					cfg->tx_tbl, cfg->tx_tbl_num, 2);
>   	}
>   
>   	qmp_ufs_configure_lane(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num, 1);
>   
> -	if (cfg->is_dual_lane_phy) {
> +	if (cfg->lanes >= 2) {
>   		qmp_ufs_configure_lane(qphy->rx2, cfg->regs,
>   					cfg->rx_tbl, cfg->rx_tbl_num, 2);
>   	}
> @@ -1122,7 +1111,7 @@ static int qmp_ufs_create(struct device *dev, struct device_node *np, int id,
>   	if (IS_ERR(qphy->pcs))
>   		return PTR_ERR(qphy->pcs);
>   
> -	if (cfg->is_dual_lane_phy) {
> +	if (cfg->lanes >= 2) {
>   		qphy->tx2 = devm_of_iomap(dev, np, 3, NULL);
>   		if (IS_ERR(qphy->tx2))
>   			return PTR_ERR(qphy->tx2);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
