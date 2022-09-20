Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AF15BE7AF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiITNxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiITNx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:53:29 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C7D5E665
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:52:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id e18so1983319wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=1uV1uepVdt/lidIfDtXoLlULIc3m3alhe/jXl+SRp68=;
        b=PDq26ewsnmK/he9qfYqM3VwusLSQLuKwJxrxRdUPxBkl9xCQksQuuM57Gk6No6l5yO
         1NWirVeUR73e2GoXbXiZsst0DuKZCHiGdx/Dt7pryD5rS5CdMUvJEzJ16pgC6YRDAqFl
         DDJLDOQVLiM8N9KI/vE5DMIjzwCg2YFtDZBIMEKuo/a7qg5nwnpibv6TlblOMLZ9mOja
         oWS1bJsMHW53qTU16+0G59uOSs7FDdCboSBgU0jz7Frrog6X4NbjrvFp39LFE2qtE7xJ
         pypIIOPBBlqAjEbRbzBNJSylYYYgFLOp8K44N3MSxWr5MZ1IC2YaIkn2VyBGmqXuMdm9
         KwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=1uV1uepVdt/lidIfDtXoLlULIc3m3alhe/jXl+SRp68=;
        b=xp4VygHW26GqZM3EfdwJdJBLCH4pKtDgvRdM3R1K6v8bzlucJAK5GWwnFtl5Y2mLnT
         Fi981ToPBg/KKlbmKXHSyOzJb3W1HwyjTiHLw3UN7jcAZ565Z1sY7Bwbt0Ae7CIYg5Hx
         6J3DkQyyqPJxsxb3Bf1T1H62u9vIbua+8vaEcWR/wnazMCx/pzgIlUkz6Dx/kFmmA76j
         RbK8RPy12cnThATKWbmOUWKf/MoHjEk4qnlN13Zd04QfKSm95PS9rF/MaZ+2HjwReLNA
         SWstY6mb+BY/WFe7d5u8G+aa7TRlSqnAglx1p8gsPA9bXKqrSw0pjISWz79edgI0PD0X
         y9/w==
X-Gm-Message-State: ACrzQf2QK2OdItVHg9ZIzq9A2Di0J8B9Am1GyLiL9+399nMGqIZOTx+o
        lXoDuWiYWUbkv8LtoXI15r13jkz14pK81whw
X-Google-Smtp-Source: AMsMyM5qSw3B9VmVxkoIAWfjJfoLg0b2DXJ19X6T1sZUYpZhiAdBF2QPmbzPm8vFACB3A8jveMfabQ==
X-Received: by 2002:a05:600c:3546:b0:3b4:b7da:d8e2 with SMTP id i6-20020a05600c354600b003b4b7dad8e2mr2559775wmq.188.1663681945429;
        Tue, 20 Sep 2022 06:52:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e? ([2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e])
        by smtp.gmail.com with ESMTPSA id b14-20020adfe30e000000b00228df23bd51sm24571wrj.82.2022.09.20.06.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:52:24 -0700 (PDT)
Message-ID: <66450c6b-6435-e537-2268-c6fc97d92824@linaro.org>
Date:   Tue, 20 Sep 2022 15:52:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 17/17] phy: qcom-qmp-combo: drop redundant DP config flag
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
 <20220920073826.20811-18-johan+linaro@kernel.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro
In-Reply-To: <20220920073826.20811-18-johan+linaro@kernel.org>
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
> Drop the DP_COM control block flag from the configuration data, which is
> set for all combo PHYs and hence no longer needed since the QMP driver
> split.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 63 +++++++----------------
>   1 file changed, 18 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 417e0fcf1a9f..ad3b0aa22048 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -876,9 +876,6 @@ struct qmp_phy_cfg {
>   	int pwrdn_delay_min;
>   	int pwrdn_delay_max;
>   
> -	/* true, if PHY has a separate DP_COM control block */
> -	bool has_phy_dp_com_ctrl;
> -
>   	/* Offset from PCS to PCS_USB region */
>   	unsigned int pcs_usb_offset;
>   
> @@ -1051,8 +1048,6 @@ static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
>   	.has_pwrdn_delay	= true,
>   	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
>   	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
> -
> -	.has_phy_dp_com_ctrl	= true,
>   };
>   
>   static const struct qmp_phy_cfg sc7180_dpphy_cfg = {
> @@ -1086,8 +1081,6 @@ static const struct qmp_phy_cfg sc7180_dpphy_cfg = {
>   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>   	.regs			= qmp_v3_usb3phy_regs_layout,
>   
> -	.has_phy_dp_com_ctrl	= true,
> -
>   	.dp_aux_init = qcom_qmp_v3_phy_dp_aux_init,
>   	.configure_dp_tx = qcom_qmp_v3_phy_configure_dp_tx,
>   	.configure_dp_phy = qcom_qmp_v3_phy_configure_dp_phy,
> @@ -1126,8 +1119,6 @@ static const struct qmp_phy_cfg sdm845_usb3phy_cfg = {
>   	.has_pwrdn_delay	= true,
>   	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
>   	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
> -
> -	.has_phy_dp_com_ctrl	= true,
>   };
>   
>   static const struct qmp_phy_combo_cfg sdm845_usb3dpphy_cfg = {
> @@ -1166,8 +1157,6 @@ static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
>   	.has_pwrdn_delay	= true,
>   	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
>   	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
> -
> -	.has_phy_dp_com_ctrl	= true,
>   };
>   
>   static const struct qmp_phy_cfg sc8180x_dpphy_cfg = {
> @@ -1201,8 +1190,6 @@ static const struct qmp_phy_cfg sc8180x_dpphy_cfg = {
>   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>   	.regs			= qmp_v3_usb3phy_regs_layout,
>   
> -	.has_phy_dp_com_ctrl	= true,
> -
>   	.dp_aux_init = qcom_qmp_v4_phy_dp_aux_init,
>   	.configure_dp_tx = qcom_qmp_v4_phy_configure_dp_tx,
>   	.configure_dp_phy = qcom_qmp_v4_phy_configure_dp_phy,
> @@ -1242,8 +1229,6 @@ static const struct qmp_phy_cfg sc8280xp_usb43dp_usb_cfg = {
>   	.has_pwrdn_delay	= true,
>   	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
>   	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
> -
> -	.has_phy_dp_com_ctrl	= true,
>   };
>   
>   static const struct qmp_phy_cfg sc8280xp_usb43dp_dp_cfg = {
> @@ -1277,8 +1262,6 @@ static const struct qmp_phy_cfg sc8280xp_usb43dp_dp_cfg = {
>   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>   	.regs			= qmp_v4_usb3phy_regs_layout,
>   
> -	.has_phy_dp_com_ctrl	= true,
> -
>   	.dp_aux_init = qcom_qmp_v4_phy_dp_aux_init,
>   	.configure_dp_tx = qcom_qmp_v4_phy_configure_dp_tx,
>   	.configure_dp_phy = qcom_qmp_v5_phy_configure_dp_phy,
> @@ -1320,8 +1303,6 @@ static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
>   	.has_pwrdn_delay	= true,
>   	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
>   	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
> -
> -	.has_phy_dp_com_ctrl	= true,
>   };
>   
>   static const struct qmp_phy_cfg sm8250_dpphy_cfg = {
> @@ -1355,8 +1336,6 @@ static const struct qmp_phy_cfg sm8250_dpphy_cfg = {
>   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>   	.regs			= qmp_v4_usb3phy_regs_layout,
>   
> -	.has_phy_dp_com_ctrl	= true,
> -
>   	.dp_aux_init = qcom_qmp_v4_phy_dp_aux_init,
>   	.configure_dp_tx = qcom_qmp_v4_phy_configure_dp_tx,
>   	.configure_dp_phy = qcom_qmp_v4_phy_configure_dp_phy,
> @@ -1995,28 +1974,25 @@ static int qmp_combo_com_init(struct qmp_phy *qphy)
>   	if (ret)
>   		goto err_assert_reset;
>   
> -	if (cfg->has_phy_dp_com_ctrl) {
> -		qphy_setbits(dp_com, QPHY_V3_DP_COM_POWER_DOWN_CTRL,
> -			     SW_PWRDN);
> -		/* override hardware control for reset of qmp phy */
> -		qphy_setbits(dp_com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
> -			     SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
> -			     SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
> +	qphy_setbits(dp_com, QPHY_V3_DP_COM_POWER_DOWN_CTRL, SW_PWRDN);
>   
> -		/* Default type-c orientation, i.e CC1 */
> -		qphy_setbits(dp_com, QPHY_V3_DP_COM_TYPEC_CTRL, 0x02);
> +	/* override hardware control for reset of qmp phy */
> +	qphy_setbits(dp_com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
> +			SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
> +			SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
>   
> -		qphy_setbits(dp_com, QPHY_V3_DP_COM_PHY_MODE_CTRL,
> -			     USB3_MODE | DP_MODE);
> +	/* Default type-c orientation, i.e CC1 */
> +	qphy_setbits(dp_com, QPHY_V3_DP_COM_TYPEC_CTRL, 0x02);
>   
> -		/* bring both QMP USB and QMP DP PHYs PCS block out of reset */
> -		qphy_clrbits(dp_com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
> -			     SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
> -			     SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
> +	qphy_setbits(dp_com, QPHY_V3_DP_COM_PHY_MODE_CTRL, USB3_MODE | DP_MODE);
>   
> -		qphy_clrbits(dp_com, QPHY_V3_DP_COM_SWI_CTRL, 0x03);
> -		qphy_clrbits(dp_com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
> -	}
> +	/* bring both QMP USB and QMP DP PHYs PCS block out of reset */
> +	qphy_clrbits(dp_com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
> +			SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
> +			SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
> +
> +	qphy_clrbits(dp_com, QPHY_V3_DP_COM_SWI_CTRL, 0x03);
> +	qphy_clrbits(dp_com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
>   
>   	if (cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL])
>   		qphy_setbits(pcs,
> @@ -2838,12 +2814,9 @@ static int qmp_combo_probe(struct platform_device *pdev)
>   	if (IS_ERR(serdes))
>   		return PTR_ERR(serdes);
>   
> -	/* per PHY dp_com; if PHY has dp_com control block */
> -	if (cfg->has_phy_dp_com_ctrl) {
> -		qmp->dp_com = devm_platform_ioremap_resource(pdev, 1);
> -		if (IS_ERR(qmp->dp_com))
> -			return PTR_ERR(qmp->dp_com);
> -	}
> +	qmp->dp_com = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(qmp->dp_com))
> +		return PTR_ERR(qmp->dp_com);
>   
>   	/* Only two serdes for combo PHY */
>   	dp_serdes = devm_platform_ioremap_resource(pdev, 2);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
