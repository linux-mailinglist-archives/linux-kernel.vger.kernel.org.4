Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59C16F0673
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243664AbjD0NNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243389AbjD0NNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:13:44 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DF9449E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 06:13:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-506bfe81303so14311889a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 06:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682601217; x=1685193217;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vscKZXOMHGCxmqepktG+YSo5xCnMNlJ/MCwp2Reoljw=;
        b=XPcOuYGP2galzs2LI1gymjd3fb6dsr6uuwFm0V8eKICAYQ2jllVMmRvlIa8RyNLyTF
         sTB0UsnPJAJRPWYV1nBoTfA3zUCKieRDgjbz+qFi77YJ/LM5aRvraPKcS5cYkYeod1xO
         ik9LHKFOafUuJoDbMvnebgnXDW38rQmuLO1QXao3tpnhQOlMsTIoQZleKEqV+DFdW7u/
         lRWobLoVmRvTwOw7c9BhjtmRpDKew+9pvMaSCkJ1rsN/z4+gtouN9e4l9bSvuk0vzRnY
         JtZvp6qgbF7Q93w/OTqxs2tFMqEprfSeLxOYBE7lH0i0VDBiLpT26m68lzAi9UynsR6b
         wEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682601217; x=1685193217;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vscKZXOMHGCxmqepktG+YSo5xCnMNlJ/MCwp2Reoljw=;
        b=L+hUFNtCvxovATM3tx/VGnDFGfXM6RVbhbLgAEim2MYlodVHtZiGYWezdQ7GKt1Ei3
         uwRPm2I3yulFr8GMUif110N8kTc8uqCCdISD+DB/J/RBZF1i8Z9/0z8mHCWwf1kKLobe
         IogwToyRVTSAgRVwpZ8LwQZPanNmKAhuylqEBUKLFKjjZMbO0VFbOVGKP9xPqbLZfhNb
         D3sVZoqDNz9QEe4fx025xmuC0bMPhbWFes+dfnNmVvc16c74cWAhgcCGJhNV6xzDte1F
         +8NZKmyBAoG/f0XUDXRYhemr76FTKHafk2PSuMSlCezWt1L+pUwBbFb/ir5qPG9NctiC
         fWBA==
X-Gm-Message-State: AC+VfDwk2N9csAfc7eNZy0DUiODJu1D/HnNeQ/Qnjq45mR7qkpMunI04
        D39hCZta3XO8cJxzsFRoWJ6YGQ==
X-Google-Smtp-Source: ACHHUZ4JnlMrgC0TMoqqsfF7YY2UG87RI1R6YRDLKvL4ElcA3jeeoPy9T2TGzODxurp48b8hVADTew==
X-Received: by 2002:a17:907:7ea2:b0:94e:547b:6301 with SMTP id qb34-20020a1709077ea200b0094e547b6301mr1446698ejc.8.1682601217684;
        Thu, 27 Apr 2023 06:13:37 -0700 (PDT)
Received: from [172.23.2.82] ([31.221.30.162])
        by smtp.gmail.com with ESMTPSA id s17-20020a170906285100b0094e597f0e4dsm9541668ejc.121.2023.04.27.06.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 06:13:37 -0700 (PDT)
Message-ID: <e6703585-660b-d0a2-7804-6c2724b2c095@linaro.org>
Date:   Thu, 27 Apr 2023 15:13:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/7] phy: qcom-qmp-combo: Introduce orientation variable
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
 <20230425034010.3789376-4-quic_bjorande@quicinc.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230425034010.3789376-4-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2023 05:40, Bjorn Andersson wrote:
> In multiple places throughout the driver code has been written in
> prepration for handling of orientation switching.
> 
> Introduce a typec_orientation in qmp_combo and fill out the various
> "placeholders" with the associated logic. By initializing the
> orientation to "normal" this change has no functional impact, but
> reduces the size of the upcoming introduction of dynamic orientation
> switching.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 54 +++++++++++++----------
>   1 file changed, 30 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 7280f7141961..6748f31da7a3 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -19,6 +19,7 @@
>   #include <linux/regulator/consumer.h>
>   #include <linux/reset.h>
>   #include <linux/slab.h>
> +#include <linux/usb/typec.h>
>   
>   #include <dt-bindings/phy/phy-qcom-qmp.h>
>   
> @@ -63,6 +64,10 @@
>   /* QPHY_V3_PCS_MISC_CLAMP_ENABLE register bits */
>   #define CLAMP_EN				BIT(0) /* enables i/o clamp_n */
>   
> +/* QPHY_V3_DP_COM_TYPEC_CTRL register bits */
> +#define SW_PORTSELECT_VAL			BIT(0)
> +#define SW_PORTSELECT_MUX			BIT(1)
> +
>   #define PHY_INIT_COMPLETE_TIMEOUT		10000
>   
>   struct qmp_phy_init_tbl {
> @@ -1323,6 +1328,8 @@ struct qmp_combo {
>   	struct clk_fixed_rate pipe_clk_fixed;
>   	struct clk_hw dp_link_hw;
>   	struct clk_hw dp_pixel_hw;
> +
> +	enum typec_orientation orientation;
>   };
>   
>   static void qmp_v3_dp_aux_init(struct qmp_combo *qmp);
> @@ -1955,29 +1962,23 @@ static void qmp_v3_configure_dp_tx(struct qmp_combo *qmp)
>   static bool qmp_combo_configure_dp_mode(struct qmp_combo *qmp)
>   {
>   	u32 val;
> -	bool reverse = false;
> +	bool reverse = qmp->orientation == TYPEC_ORIENTATION_REVERSE;
> +	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
>   
>   	val = DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
>   	      DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN;
>   
> -	/*
> -	 * TODO: Assume orientation is CC1 for now and two lanes, need to
> -	 * use type-c connector to understand orientation and lanes.
> -	 *
> -	 * Otherwise val changes to be like below if this code understood
> -	 * the orientation of the type-c cable.
> -	 *
> -	 * if (lane_cnt == 4 || orientation == ORIENTATION_CC2)
> -	 *	val |= DP_PHY_PD_CTL_LANE_0_1_PWRDN;
> -	 * if (lane_cnt == 4 || orientation == ORIENTATION_CC1)
> -	 *	val |= DP_PHY_PD_CTL_LANE_2_3_PWRDN;
> -	 * if (orientation == ORIENTATION_CC2)
> -	 *	writel(0x4c, qmp->dp_dp_phy + QSERDES_V3_DP_PHY_MODE);
> -	 */
> -	val |= DP_PHY_PD_CTL_LANE_2_3_PWRDN;
> +	if (dp_opts->lanes == 4 || reverse)
> +		val |= DP_PHY_PD_CTL_LANE_0_1_PWRDN;
> +	if (dp_opts->lanes == 4 || !reverse)
> +		val |= DP_PHY_PD_CTL_LANE_2_3_PWRDN;
> +
>   	writel(val, qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
>   
> -	writel(0x5c, qmp->dp_dp_phy + QSERDES_DP_PHY_MODE);
> +	if (reverse)
> +		writel(0x4c, qmp->pcs + QSERDES_DP_PHY_MODE);
> +	else
> +		writel(0x5c, qmp->pcs + QSERDES_DP_PHY_MODE);
>   
>   	return reverse;
>   }
> @@ -2235,7 +2236,7 @@ static int qmp_v4_configure_dp_phy(struct qmp_combo *qmp)
>   {
>   	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
>   	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
> -	bool reverse = false;
> +	bool reverse = qmp->orientation == TYPEC_ORIENTATION_REVERSE;
>   	u32 status;
>   	int ret;
>   
> @@ -2299,7 +2300,7 @@ static int qmp_v5_configure_dp_phy(struct qmp_combo *qmp)
>   {
>   	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
>   	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
> -	bool reverse = false;
> +	bool reverse = qmp->orientation == TYPEC_ORIENTATION_REVERSE;
>   	u32 status;
>   	int ret;
>   
> @@ -2358,7 +2359,7 @@ static int qmp_v6_configure_dp_phy(struct qmp_combo *qmp)
>   {
>   	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
>   	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
> -	bool reverse = false;
> +	bool reverse = qmp->orientation == TYPEC_ORIENTATION_REVERSE;
>   	u32 status;
>   	int ret;
>   
> @@ -2462,6 +2463,7 @@ static int qmp_combo_com_init(struct qmp_combo *qmp)
>   	const struct qmp_phy_cfg *cfg = qmp->cfg;
>   	void __iomem *com = qmp->com;
>   	int ret;
> +	u32 val;
>   
>   	if (qmp->init_count++)
>   		return 0;
> @@ -2495,10 +2497,12 @@ static int qmp_combo_com_init(struct qmp_combo *qmp)
>   			SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
>   			SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
>   
> -	/* Default type-c orientation, i.e CC1 */
> -	qphy_setbits(com, QPHY_V3_DP_COM_TYPEC_CTRL, 0x02);
> -
> -	qphy_setbits(com, QPHY_V3_DP_COM_PHY_MODE_CTRL, USB3_MODE | DP_MODE);
> +	/* Use software based port select and switch on typec orientation */
> +	val = SW_PORTSELECT_MUX;
> +	if (qmp->orientation == TYPEC_ORIENTATION_REVERSE)
> +		val |= SW_PORTSELECT_VAL;
> +	writel(val, com + QPHY_V3_DP_COM_TYPEC_CTRL);
> +	writel(USB3_MODE | DP_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
>   
>   	/* bring both QMP USB and QMP DP PHYs PCS block out of reset */
>   	qphy_clrbits(com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
> @@ -3361,6 +3365,8 @@ static int qmp_combo_probe(struct platform_device *pdev)
>   
>   	qmp->dev = dev;
>   
> +	qmp->orientation = TYPEC_ORIENTATION_NORMAL;
> +
>   	qmp->cfg = of_device_get_match_data(dev);
>   	if (!qmp->cfg)
>   		return -EINVAL;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
