Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73386DFAFF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDLQPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjDLQPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:15:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044371993;
        Wed, 12 Apr 2023 09:15:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93E76636DB;
        Wed, 12 Apr 2023 16:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47877C433EF;
        Wed, 12 Apr 2023 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681316103;
        bh=1PY7+OsGBN+uCgRUYtBU8jXFz852lXmdaStSRrPi68o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bDDdDbgMIwY2ntwzM2O1KIrFMCN78ube1lhT9aPdwSVOjJDN4h3EF3Dh0h78su7gH
         GSjafhtiYaeEDKi43zNOEkJOTmHsSrQ0pFRHORK8UmEE3WrQztxAB4jmNEaEMKdfZz
         3LUb8tJzkhMiUoFdSoibSSc1Puu/W7HJxZd2sa46/NO8YypOiTvzik6Ety/QV5kpDB
         pdCmF+WZory6u5bHriS3UXxQaMfaFEwZMnpLIbjOVSKJttMczq/7af8W+A4ceBhJXW
         hekeuiqX3w14iwLreNQ/ZlcZXL4vzPMfdYJ63ISpWHqKlhj4eoxJ2BUt9OWYZ7uXbW
         olDwBLDUJjD1A==
Date:   Wed, 12 Apr 2023 21:44:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 3/5] phy: qualcomm: phy-qcom-qmp-ufs: add definitions
 for sa8775p
Message-ID: <ZDbZA3AnbTTylFdb@matsya>
References: <20230411130446.401440-1-brgl@bgdev.pl>
 <20230411130446.401440-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411130446.401440-4-brgl@bgdev.pl>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-04-23, 15:04, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add QMP PHY config for sa8775p and add support for the new compatible.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 38 +++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index d58822049211..5612282eb378 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -853,6 +853,41 @@ static const struct qmp_phy_cfg msm8996_ufsphy_cfg = {
>  	.no_pcs_sw_reset	= true,
>  };
>  
> +

There was already an empty line, this didnt make sense. Please run
checkpatch to avoid missing these style issues

I have fixed it up and applied

> +static const struct qmp_phy_cfg sa8775p_ufsphy_cfg = {
> +	.lanes			= 2,
> +
> +	.offsets		= &qmp_ufs_offsets,
> +
> +	.tbls = {
> +		.serdes		= sm8350_ufsphy_serdes,
> +		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_serdes),
> +		.tx		= sm8350_ufsphy_tx,
> +		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_tx),
> +		.rx		= sm8350_ufsphy_rx,
> +		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_rx),
> +		.pcs		= sm8350_ufsphy_pcs,
> +		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_pcs),
> +	},
> +	.tbls_hs_b = {
> +		.serdes		= sm8350_ufsphy_hs_b_serdes,
> +		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
> +	},
> +	.tbls_hs_g4 = {
> +		.tx		= sm8350_ufsphy_g4_tx,
> +		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_tx),
> +		.rx		= sm8350_ufsphy_g4_rx,
> +		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_rx),
> +		.pcs		= sm8350_ufsphy_g4_pcs,
> +		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
> +	},
> +	.clk_list		= sm8450_ufs_phy_clk_l,
> +	.num_clks		= ARRAY_SIZE(sm8450_ufs_phy_clk_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= ufsphy_v5_regs_layout,
> +};
> +
>  static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
>  	.lanes			= 2,
>  
> @@ -1600,6 +1635,9 @@ static const struct of_device_id qmp_ufs_of_match_table[] = {
>  	}, {
>  		.compatible = "qcom,msm8998-qmp-ufs-phy",
>  		.data = &sdm845_ufsphy_cfg,
> +	}, {
> +		.compatible = "qcom,sa8775p-qmp-ufs-phy",
> +		.data = &sa8775p_ufsphy_cfg,
>  	}, {
>  		.compatible = "qcom,sc8180x-qmp-ufs-phy",
>  		.data = &sm8150_ufsphy_cfg,
> -- 
> 2.37.2

-- 
~Vinod
