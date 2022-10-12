Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0E65FCCFC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiJLVUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiJLVUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:20:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3E84C004
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:20:12 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a29so27601915lfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v4OEYFKZSF+UApl54L519UI2DEdgEqGAeljbcrdT1Pc=;
        b=l0HYEjDTWOkZf9llPVHPgyUCQQ/dQWmQA2e57ofODuv3VfOmJumHZSPoe8MErxdEc8
         3KwRg9UNOJ2FyERYJ97hzCAofqFfU4S+sfRyfS5KICsuVN+/McwUAnTDcSMigSXyEWNZ
         V1Pe8uNgn2OEIb4Yves0AZw0ZK5Zh1Z4BR6dBnZhFgViMkUHFs4SeWUGLvReEgfluuX0
         EFsV+it1REMAO9b6tCxS/BSTa1o7d203qQIjKFOya6IfNqZegx9UdJptCmzsw9tzLAK8
         LbztlioKwrJnsTYneW+Wlfp9PZ/bCn4eBtexLbTenEgkcA6m4AyyfveVQFiExHpDzL+A
         1xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4OEYFKZSF+UApl54L519UI2DEdgEqGAeljbcrdT1Pc=;
        b=lLU92p0TASkEvVEkHibosbVTS0+7qSuY0allkFBB9yKOl/PnmSC5jAZQxM+6sGc9fZ
         2QFLzDR11NhoW5Qtarg6CfMzWfZKSas0GzRtQK+z8f3OSZFlDla9haDuFs1UR4vBhoCW
         n+S8O7+3z6V3rbAQhQIH9YzBNRa5i4ZUVmD4sz78cGxTnJ5h1ducLgwV7E2OoaTQc6PP
         ogWzbNPxadSP8X5Db7JtP+S9fyeJH877E1Fcuum5hUX/z/qF0I2CD4XtNxJkvGgxEaLX
         FFfDNU/C5vou2egYKipSlzJ1ZTLPfVpPTU0S9QWRoigMs/Of2eTTkCvKy2MMoLyC+s/5
         NQgQ==
X-Gm-Message-State: ACrzQf1xE+RXe4DNvyGSRKHD5ScVlcUVOxKKzbeJ8CqCvq2699XG7Xuq
        PpBcfRF0jAp9c2CzDcG/QKE3RSiM84R16Q==
X-Google-Smtp-Source: AMsMyM75LcYxGennfHDMY9K72xPdr7rtGuhwig4ZI2ErGLFdx1ZzBJK1DLqXU3WuixHX7HQnLloq2w==
X-Received: by 2002:ac2:4e04:0:b0:4a2:b966:37ec with SMTP id e4-20020ac24e04000000b004a2b96637ecmr10347841lfr.319.1665609611086;
        Wed, 12 Oct 2022 14:20:11 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m19-20020a056512359300b00490b5f09973sm111680lfr.92.2022.10.12.14.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 14:20:10 -0700 (PDT)
Message-ID: <81632b90-bc8a-7f3b-d2c9-153b4cea16ed@linaro.org>
Date:   Thu, 13 Oct 2022 00:20:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 16/20] phy: qcom-qmp-pcie: drop start-ctrl abstraction
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221012084846.24003-1-johan+linaro@kernel.org>
 <20221012085002.24099-1-johan+linaro@kernel.org>
 <20221012085002.24099-16-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221012085002.24099-16-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2022 11:49, Johan Hovold wrote:
> All PCIe PHYs need to start and stop the SerDes and PCS so drop the
> start-ctrl abstraction which is no longer needed since the QMP driver
> split.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 18 +++---------------
>   1 file changed, 3 insertions(+), 15 deletions(-)

I think it should be possible to also drop the pwrdn_ctrl by replacing 
it with something like no_refclk_drv_dsbl. However I'd like to 
understand why this is not required for SDX55. Is this the peculiarity 
of that platform? Or is it a specifics of the EP mode?
Many, Vinod, do you know the answer by chance?

Nevertheless, for this patch:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index d3e7e673114f..5534a4ad0243 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1355,7 +1355,6 @@ struct qmp_phy_cfg {
>   	/* array of registers with different offsets */
>   	const unsigned int *regs;
>   
> -	unsigned int start_ctrl;
>   	unsigned int pwrdn_ctrl;
>   	/* bit offset of PHYSTATUS in QPHY_PCS_STATUS register */
>   	unsigned int phy_status;
> @@ -1491,7 +1490,6 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
>   	.num_vregs		= 0,
>   	.regs			= pciephy_regs_layout,
>   
> -	.start_ctrl		= SERDES_START | PCS_START,
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
>   	.phy_status		= PHYSTATUS,
>   };
> @@ -1517,7 +1515,6 @@ static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
>   	.num_vregs		= 0,
>   	.regs			= ipq_pciephy_gen3_regs_layout,
>   
> -	.start_ctrl		= SERDES_START | PCS_START,
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
>   	.phy_status		= PHYSTATUS,
>   
> @@ -1547,7 +1544,6 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
>   	.num_vregs		= 0,
>   	.regs			= ipq_pciephy_gen3_regs_layout,
>   
> -	.start_ctrl		= SERDES_START | PCS_START,
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
>   	.phy_status		= PHYSTATUS,
>   };
> @@ -1575,7 +1571,6 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
>   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>   	.regs			= sdm845_qmp_pciephy_regs_layout,
>   
> -	.start_ctrl		= PCS_START | SERDES_START,
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
>   	.phy_status		= PHYSTATUS,
>   };
> @@ -1601,7 +1596,6 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
>   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>   	.regs			= sdm845_qhp_pciephy_regs_layout,
>   
> -	.start_ctrl		= PCS_START | SERDES_START,
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
>   	.phy_status		= PHYSTATUS,
>   };
> @@ -1639,7 +1633,6 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
>   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>   	.regs			= sm8250_pcie_regs_layout,
>   
> -	.start_ctrl		= PCS_START | SERDES_START,
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
>   	.phy_status		= PHYSTATUS,
>   };
> @@ -1677,7 +1670,6 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
>   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>   	.regs			= sm8250_pcie_regs_layout,
>   
> -	.start_ctrl		= PCS_START | SERDES_START,
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
>   	.phy_status		= PHYSTATUS,
>   };
> @@ -1703,7 +1695,6 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
>   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>   	.regs			= pciephy_regs_layout,
>   
> -	.start_ctrl             = SERDES_START | PCS_START,
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
>   	.phy_status		= PHYSTATUS,
>   
> @@ -1733,7 +1724,6 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
>   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>   	.regs			= sm8250_pcie_regs_layout,
>   
> -	.start_ctrl		= PCS_START | SERDES_START,
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
>   	.phy_status		= PHYSTATUS,
>   };
> @@ -1761,7 +1751,6 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
>   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>   	.regs			= sm8250_pcie_regs_layout,
>   
> -	.start_ctrl		= PCS_START | SERDES_START,
>   	.pwrdn_ctrl		= SW_PWRDN,
>   	.phy_status		= PHYSTATUS_4_20,
>   };
> @@ -1789,7 +1778,6 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
>   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>   	.regs			= sm8250_pcie_regs_layout,
>   
> -	.start_ctrl             = SERDES_START | PCS_START,
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
>   	.phy_status		= PHYSTATUS,
>   };
> @@ -1832,7 +1820,6 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
>   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>   	.regs			= sm8250_pcie_regs_layout,
>   
> -	.start_ctrl             = SERDES_START | PCS_START,
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
>   	.phy_status		= PHYSTATUS_4_20,
>   };
> @@ -1997,7 +1984,7 @@ static int qmp_pcie_power_on(struct phy *phy)
>   	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
>   
>   	/* start SerDes and Phy-Coding-Sublayer */
> -	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
> +	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START | PCS_START);
>   
>   	if (!cfg->skip_start_delay)
>   		usleep_range(1000, 1200);
> @@ -2030,7 +2017,8 @@ static int qmp_pcie_power_off(struct phy *phy)
>   	qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
>   
>   	/* stop SerDes and Phy-Coding-Sublayer */
> -	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
> +	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL],
> +			SERDES_START | PCS_START);
>   
>   	/* Put PHY into POWER DOWN state: active low */
>   	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],

-- 
With best wishes
Dmitry

