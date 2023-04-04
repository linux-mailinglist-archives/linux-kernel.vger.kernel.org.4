Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CD26D6B27
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbjDDSEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbjDDSDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:03:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7582149C7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:03:45 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g19so30304586lfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680631423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JR7CqJAwvpJxFbciu3o8qyafjr98DA8/rLAPmXVSUts=;
        b=pML5XntacJXTSKhU9ODumSKwOTCz0UW7j64E+EAkqVSzDJA3uwsev/umHCI3zIXNtb
         y+ah7uluB7FDPDQzE4PA8keAWV+bFm/HhfUCnrZzq5mH5XYcwBPTSG8HHOOdQdMMWzXj
         rE1w0Q/eh8emv05TzEkZyghjzP9GNTXiMQOyH1aR6h8FWB2YenyXda/byB1Ybsm1gqLZ
         gqWiehuVCnx4tuapSHwGCN1vYMrV8s6ZOj0A9rubNi31sLmuvSeB8ZvglXnqRF0Bs5iY
         g4REZlDlwrz7bgzKQOAG8bKAs+XtSKga2bwNev58K2Kx7+12zWMIFkqHC3XBlRIuu60P
         lZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680631423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JR7CqJAwvpJxFbciu3o8qyafjr98DA8/rLAPmXVSUts=;
        b=sHP9GbPheZ7g5sF5zW7XRJG2TJUWy4yIBShevDvSZ4PXcBilmuJNVGnlOg+KwjMmFF
         oH9MCm6Dse7lYcyaayjZ4+yIcZyv7dE/g0UUXV8W4W1Vg76M4hmqCVIY2hi2fJzb8IKg
         OisIfjTkRMgPXmRHsJTiM0pwH6+ntrASae7L/enRmc/EjjGx8sx13GOT5tVJ4L5kq8cX
         pmUY1WFCH4Jp+yBSSiOtBwoXMWKyPOF137SSD0LpPzkJq7429+2dZWX3ME6PSXXIibDi
         CubU8W3hbrLEii/XzE9kfRCsz/YZ62o8xJaAgtu2iyM00zWCt+pdv2NRhVA60m8s90yN
         uTQQ==
X-Gm-Message-State: AAQBX9fjQq5ctMlhq67SWwMWMh7MfKsWwV8Ah2gv4ltOA3SoOp5N76Et
        iNoG0+Krd2SYurZi4hK/+eiYzg==
X-Google-Smtp-Source: AKy350Z3GNst68g7AebZ7jv36PnnaXILoR6V2RC/YE70jV8ohG+yAaUbnTUNB4E6N8gZweE9NRgEMA==
X-Received: by 2002:a19:5211:0:b0:4ea:c730:aabe with SMTP id m17-20020a195211000000b004eac730aabemr920209lfb.20.1680631423266;
        Tue, 04 Apr 2023 11:03:43 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id v14-20020ac2560e000000b004e8011cbaa0sm2410412lfd.111.2023.04.04.11.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 11:03:42 -0700 (PDT)
Message-ID: <a4bf52db-21a4-dd92-e7ef-62b9c7d19d26@linaro.org>
Date:   Tue, 4 Apr 2023 20:03:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 3/7] soundwire: qcom: allow 16-bit sample interval for
 ports
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Patrick Lai <quic_plai@quicinc.com>
References: <20230403132503.62090-1-krzysztof.kozlowski@linaro.org>
 <20230403132503.62090-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230403132503.62090-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.04.2023 15:24, Krzysztof Kozlowski wrote:
> The port sample interval was always 16-bit, split into low and high
> bytes.  This split was unnecessary, although harmless for older devices
> because all of them used only lower byte (so values < 0xff).  With
> support for Soundwire controller on Qualcomm SM8550 and its devices,
> both bytes will be used, thus add a new 'qcom,ports-sinterval' property
> to allow 16-bit sample intervals.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
I have little insight in this code, but the changes look
logical, so..

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v1:
> 1. Drop unneeded semicolon.
> ---
>  drivers/soundwire/qcom.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index c296e0bf897b..faa091e7472a 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -95,6 +95,7 @@
>  #define SWRM_DP_BLOCK_CTRL2_BANK(n, m)	(0x1130 + 0x100 * (n - 1) + 0x40 * m)
>  #define SWRM_DP_PORT_HCTRL_BANK(n, m)	(0x1134 + 0x100 * (n - 1) + 0x40 * m)
>  #define SWRM_DP_BLOCK_CTRL3_BANK(n, m)	(0x1138 + 0x100 * (n - 1) + 0x40 * m)
> +#define SWRM_DP_SAMPLECTRL2_BANK(n, m)	(0x113C + 0x100 * (n - 1) + 0x40 * m)
>  #define SWRM_DIN_DPn_PCM_PORT_CTRL(n)	(0x1054 + 0x100 * (n - 1))
>  #define SWR_MSTR_MAX_REG_ADDR		(0x1740)
>  
> @@ -131,7 +132,7 @@ enum {
>  };
>  
>  struct qcom_swrm_port_config {
> -	u8 si;
> +	u32 si;
>  	u8 off1;
>  	u8 off2;
>  	u8 bp_mode;
> @@ -806,12 +807,20 @@ static int qcom_swrm_transport_params(struct sdw_bus *bus,
>  
>  	value = pcfg->off1 << SWRM_DP_PORT_CTRL_OFFSET1_SHFT;
>  	value |= pcfg->off2 << SWRM_DP_PORT_CTRL_OFFSET2_SHFT;
> -	value |= pcfg->si;
> +	value |= pcfg->si & 0xff;
>  
>  	ret = ctrl->reg_write(ctrl, reg, value);
>  	if (ret)
>  		goto err;
>  
> +	if (pcfg->si > 0xff) {
> +		value = (pcfg->si >> 8) & 0xff;
> +		reg = SWRM_DP_SAMPLECTRL2_BANK(params->port_num, bank);
> +		ret = ctrl->reg_write(ctrl, reg, value);
> +		if (ret)
> +			goto err;
> +	}
> +
>  	if (pcfg->lane_control != SWR_INVALID_PARAM) {
>  		reg = SWRM_DP_PORT_CTRL_2_BANK(params->port_num, bank);
>  		value = pcfg->lane_control;
> @@ -1185,7 +1194,7 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>  	struct device_node *np = ctrl->dev->of_node;
>  	u8 off1[QCOM_SDW_MAX_PORTS];
>  	u8 off2[QCOM_SDW_MAX_PORTS];
> -	u8 si[QCOM_SDW_MAX_PORTS];
> +	u32 si[QCOM_SDW_MAX_PORTS];
>  	u8 bp_mode[QCOM_SDW_MAX_PORTS] = { 0, };
>  	u8 hstart[QCOM_SDW_MAX_PORTS];
>  	u8 hstop[QCOM_SDW_MAX_PORTS];
> @@ -1193,6 +1202,7 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>  	u8 blk_group_count[QCOM_SDW_MAX_PORTS];
>  	u8 lane_control[QCOM_SDW_MAX_PORTS];
>  	int i, ret, nports, val;
> +	bool si_32 = false;
>  
>  	ctrl->reg_read(ctrl, SWRM_COMP_PARAMS, &val);
>  
> @@ -1236,9 +1246,14 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>  		return ret;
>  
>  	ret = of_property_read_u8_array(np, "qcom,ports-sinterval-low",
> -					si, nports);
> -	if (ret)
> -		return ret;
> +					(u8 *)si, nports);
> +	if (ret) {
> +		ret = of_property_read_u32_array(np, "qcom,ports-sinterval",
> +						 si, nports);
> +		if (ret)
> +			return ret;
> +		si_32 = true;
> +	}
>  
>  	ret = of_property_read_u8_array(np, "qcom,ports-block-pack-mode",
>  					bp_mode, nports);
> @@ -1266,7 +1281,10 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>  
>  	for (i = 0; i < nports; i++) {
>  		/* Valid port number range is from 1-14 */
> -		ctrl->pconfig[i + 1].si = si[i];
> +		if (si_32)
> +			ctrl->pconfig[i + 1].si = si[i];
> +		else
> +			ctrl->pconfig[i + 1].si = ((u8 *)si)[i];
>  		ctrl->pconfig[i + 1].off1 = off1[i];
>  		ctrl->pconfig[i + 1].off2 = off2[i];
>  		ctrl->pconfig[i + 1].bp_mode = bp_mode[i];
