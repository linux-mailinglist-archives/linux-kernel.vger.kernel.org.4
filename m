Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FA76B5C8D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 15:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCKOBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 09:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCKOB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 09:01:29 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B21128027
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:01:27 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id s22so10234196lfi.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678543286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gN0iKz6tUQsU3sGbg8zYOt79JfksqemrudWethrYNb4=;
        b=pNybIBwNINYBdE9ZP7uM7/Ilkg1nSC/XPRDRCIPVIi/zyJdbrVoMVhN7OqyfuItMzd
         yoFFtHaHlrNg9349uD3pyTO/OU05Ke2fX4faFi2TvCMEq+ujZwxGGz2dYOuCnkIy+bfG
         yb0YI5CmL2gzZ6PFx4uwNFrKKNiz/gUtuxiGsGkayDlI61Ri7abH/lmcaVJTlcndgsfx
         IiN1JiXtTTVhEmRMCcvUZFGRAK0Tk1ETGZXt6SyR2o+oErUR4s/l8MT5/M86VvT41JRb
         ugwmZd8hKpZbK4iFfQ/48wQ0qLfMR7jXBAQHeg62baxiSdtviYfI4RqN1xEe2dK2Z7wB
         3Icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678543286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gN0iKz6tUQsU3sGbg8zYOt79JfksqemrudWethrYNb4=;
        b=3lffbYj8ATeCwE33xlqU55RNtbu/+IXg+hQ4Hc27AOuLpemyo0XjzOwkCptb1mw1OU
         WXtUQAAJZCURtVT5fizS7G3o9ibVqfx5XUjaWyD8UBjpkvLZQTQ3g53EHk4LiRQjfjl8
         eUqbJtdLPIFwq1QfdrtsV9/LrzwC+kWuwKjyrnB0iYk09ew7tGOImW/PkUBAAGD0N5mb
         9T3Hs26sCc2xifSqkOwEPgue7pYA0+6EKa+7TGy1P5atB7Dv2tvSzvG5PhO5Va1CWpJh
         UEIq2HQanitUH6xa+1gA8/y8JSWgP41b26S/XuvtERLoUk4iUV4JcXcS6Mzp5Bvb6eH+
         gysw==
X-Gm-Message-State: AO0yUKVFHX1BZ9hN15kPexDo0vG3g0DDAVHxigLRCmBYo599+Sr7zLvA
        tdvuqFEtp5ZPl7MXDM/3lnLaUw==
X-Google-Smtp-Source: AK7set/tQaqRMJnP92PVb+Fnj9PUPhIzFPQcusi9dylfhfwduZzBDvt4jyysbaphwlTNkCIiAyj9dw==
X-Received: by 2002:ac2:5142:0:b0:4dd:afb4:26b3 with SMTP id q2-20020ac25142000000b004ddafb426b3mr9504036lfd.16.1678543286066;
        Sat, 11 Mar 2023 06:01:26 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w7-20020a05651204c700b004d8540b947asm329996lfq.56.2023.03.11.06.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 06:01:25 -0800 (PST)
Message-ID: <68a5d81a-5de8-798a-c150-d74c8ad38cb7@linaro.org>
Date:   Sat, 11 Mar 2023 16:01:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 6/9] interconnect: qcom: rpm: Handle interface clocks
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
 <20230228-topic-qos-v7-6-815606092fff@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230228-topic-qos-v7-6-815606092fff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 23:40, Konrad Dybcio wrote:
> Some (but not all) providers (or their specific nodes) require
> specific clocks to be turned on before they can be accessed. Failure
> to ensure that results in a seemingly random system crash (which
> would usually happen at boot with the interconnect driver built-in),
> resulting in the platform not booting up properly.
> 
> Limit the number of bus_clocks to 2 (which is the maximum that SMD
> RPM interconnect supports anyway) and handle non-scaling clocks
> separately. Update MSM8996 and SDM660 drivers to make sure they do
> not regress with this change.
> 
> This unfortunately has to be done in one patch to prevent either
> compile errors or broken bisect.

Can we determine somehow if the intf clocks are required for the whole 
NoC or just for a single node? I don't think that clocks like a0noc_ufs 
are requiered to be up for the whole aggre_noc. Instead they probably 
have to be enabled only when UFS makes use of the NoC (in other words 
when is has voted for the bandwidth).

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/icc-rpm.c | 52 ++++++++++++++++++++++++++++++-------
>   drivers/interconnect/qcom/icc-rpm.h | 14 ++++++++--
>   drivers/interconnect/qcom/msm8996.c | 22 +++++++---------
>   drivers/interconnect/qcom/sdm660.c  | 16 +++++-------
>   4 files changed, 70 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index b52f788d8f3d..ca932ed720fb 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -369,6 +369,17 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>   
>   	qcom_icc_bus_aggregate(provider, agg_avg, agg_peak, &max_agg_avg);
>   
> +	/* If we're powering on the bus, ensure the necessary clocks are on */
> +	if (unlikely(!qp->is_on)) {
> +		if (agg_peak[0] || agg_peak[1] || max_agg_avg) {
> +			/* If this fails, bus accesses will crash the platform! */
> +			ret = clk_bulk_prepare_enable(qp->num_intf_clks, qp->intf_clks);
> +			if (ret)
> +				return ret;
> +			qp->is_on = true;
> +		}
> +	}
> +
>   	sum_bw = icc_units_to_bps(max_agg_avg);
>   
>   	ret = __qcom_icc_set(src, src_qn, sum_bw);
> @@ -409,6 +420,14 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>   		qp->bus_clk_rate[i] = rate;
>   	}
>   
> +	/* Turn off the interface clocks if the bus was shut down so as not to leak power */
> +	if (!qp->bus_clk_rate[0] && !qp->bus_clk_rate[1]) {
> +		if (!agg_peak[0] && !agg_peak[1] && !max_agg_avg) {
> +			clk_bulk_disable_unprepare(qp->num_intf_clks, qp->intf_clks);
> +			qp->is_on = false;
> +		}
> +	}
> +
>   	return 0;
>   }
>   
> @@ -441,21 +460,20 @@ int qnoc_probe(struct platform_device *pdev)
>   	qnodes = desc->nodes;
>   	num_nodes = desc->num_nodes;
>   
> -	if (desc->num_bus_clocks) {
> -		cds = desc->bus_clocks;
> -		cd_num = desc->num_bus_clocks;
> +	if (desc->num_intf_clocks) {
> +		cds = desc->intf_clocks;
> +		cd_num = desc->num_intf_clocks;
>   	} else {
> -		cds = bus_clocks;
> -		cd_num = ARRAY_SIZE(bus_clocks);
> +		/* 0 intf clocks is perfectly fine */
> +		cd_num = 0;
>   	}
>   
> -	qp = devm_kzalloc(dev, struct_size(qp, bus_clks, cd_num), GFP_KERNEL);
> +	qp = devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
>   	if (!qp)
>   		return -ENOMEM;
>   
> -	qp->bus_clk_rate = devm_kcalloc(dev, cd_num, sizeof(*qp->bus_clk_rate),
> -					GFP_KERNEL);
> -	if (!qp->bus_clk_rate)
> +	qp->intf_clks = devm_kzalloc(dev, sizeof(qp->intf_clks), GFP_KERNEL);
> +	if (!qp->intf_clks)
>   		return -ENOMEM;
>   
>   	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
> @@ -463,6 +481,18 @@ int qnoc_probe(struct platform_device *pdev)
>   	if (!data)
>   		return -ENOMEM;
>   
> +	qp->num_intf_clks = cd_num;
> +	for (i = 0; i < cd_num; i++)
> +		qp->intf_clks[i].id = cds[i];
> +
> +	if (desc->num_bus_clocks) {
> +		cds = desc->bus_clocks;
> +		cd_num = desc->num_bus_clocks;
> +	} else {
> +		cds = bus_clocks;
> +		cd_num = ARRAY_SIZE(bus_clocks);
> +	}
> +
>   	for (i = 0; i < cd_num; i++)
>   		qp->bus_clks[i].id = cds[i];
>   	qp->num_bus_clks = cd_num;
> @@ -503,6 +533,10 @@ int qnoc_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	ret = devm_clk_bulk_get(dev, qp->num_intf_clks, qp->intf_clks);
> +	if (ret)
> +		return ret;
> +
>   	if (desc->has_bus_pd) {
>   		ret = dev_pm_domain_attach(dev, true);
>   		goto err_disable_clks;
> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index d4401f35f6d2..a4ef45b4a9e0 100644
> --- a/drivers/interconnect/qcom/icc-rpm.h
> +++ b/drivers/interconnect/qcom/icc-rpm.h
> @@ -20,24 +20,32 @@ enum qcom_icc_type {
>   	QCOM_ICC_QNOC,
>   };
>   
> +#define NUM_BUS_CLKS	2
> +
>   /**
>    * struct qcom_icc_provider - Qualcomm specific interconnect provider
>    * @provider: generic interconnect provider
>    * @num_bus_clks: the total number of bus_clks clk_bulk_data entries
> + * @num_intf_clks: the total number of intf_clks clk_bulk_data entries
>    * @type: the ICC provider type
>    * @regmap: regmap for QoS registers read/write access
>    * @qos_offset: offset to QoS registers
>    * @bus_clk_rate: bus clock rate in Hz
>    * @bus_clks: the clk_bulk_data table of bus clocks
> + * @intf_clks: a clk_bulk_data array of interface clocks
> + * @is_on: whether the bus is powered on
>    */
>   struct qcom_icc_provider {
>   	struct icc_provider provider;
>   	int num_bus_clks;
> +	int num_intf_clks;
>   	enum qcom_icc_type type;
>   	struct regmap *regmap;
>   	unsigned int qos_offset;
> -	u64 *bus_clk_rate;
> -	struct clk_bulk_data bus_clks[];
> +	u64 bus_clk_rate[NUM_BUS_CLKS];
> +	struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
> +	struct clk_bulk_data *intf_clks;
> +	bool is_on;
>   };
>   
>   /**
> @@ -93,6 +101,8 @@ struct qcom_icc_desc {
>   	size_t num_nodes;
>   	const char * const *bus_clocks;
>   	size_t num_bus_clocks;
> +	const char * const *intf_clocks;
> +	size_t num_intf_clocks;
>   	bool has_bus_pd;
>   	enum qcom_icc_type type;
>   	const struct regmap_config *regmap_cfg;
> diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
> index 69fc50a6fa5c..1a5e0ad36cc4 100644
> --- a/drivers/interconnect/qcom/msm8996.c
> +++ b/drivers/interconnect/qcom/msm8996.c
> @@ -21,21 +21,17 @@
>   #include "smd-rpm.h"
>   #include "msm8996.h"
>   
> -static const char * const bus_mm_clocks[] = {
> -	"bus",
> -	"bus_a",
> +static const char * const mm_intf_clocks[] = {
>   	"iface"
>   };
>   
> -static const char * const bus_a0noc_clocks[] = {
> +static const char * const a0noc_intf_clocks[] = {
>   	"aggre0_snoc_axi",
>   	"aggre0_cnoc_ahb",
>   	"aggre0_noc_mpu_cfg"
>   };
>   
> -static const char * const bus_a2noc_clocks[] = {
> -	"bus",
> -	"bus_a",
> +static const char * const a2noc_intf_clocks[] = {
>   	"aggre2_ufs_axi",
>   	"ufs_axi"
>   };
> @@ -1821,8 +1817,8 @@ static const struct qcom_icc_desc msm8996_a0noc = {
>   	.type = QCOM_ICC_NOC,
>   	.nodes = a0noc_nodes,
>   	.num_nodes = ARRAY_SIZE(a0noc_nodes),
> -	.bus_clocks = bus_a0noc_clocks,
> -	.num_bus_clocks = ARRAY_SIZE(bus_a0noc_clocks),
> +	.intf_clocks = a0noc_intf_clocks,
> +	.num_intf_clocks = ARRAY_SIZE(a0noc_intf_clocks),
>   	.has_bus_pd = true,
>   	.regmap_cfg = &msm8996_a0noc_regmap_config
>   };
> @@ -1866,8 +1862,8 @@ static const struct qcom_icc_desc msm8996_a2noc = {
>   	.type = QCOM_ICC_NOC,
>   	.nodes = a2noc_nodes,
>   	.num_nodes = ARRAY_SIZE(a2noc_nodes),
> -	.bus_clocks = bus_a2noc_clocks,
> -	.num_bus_clocks = ARRAY_SIZE(bus_a2noc_clocks),
> +	.intf_clocks = a2noc_intf_clocks,
> +	.num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
>   	.regmap_cfg = &msm8996_a2noc_regmap_config
>   };
>   
> @@ -2005,8 +2001,8 @@ static const struct qcom_icc_desc msm8996_mnoc = {
>   	.type = QCOM_ICC_NOC,
>   	.nodes = mnoc_nodes,
>   	.num_nodes = ARRAY_SIZE(mnoc_nodes),
> -	.bus_clocks = bus_mm_clocks,
> -	.num_bus_clocks = ARRAY_SIZE(bus_mm_clocks),
> +	.intf_clocks = mm_intf_clocks,
> +	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
>   	.regmap_cfg = &msm8996_mnoc_regmap_config
>   };
>   
> diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
> index a22ba821efbf..0e8a96f4ce90 100644
> --- a/drivers/interconnect/qcom/sdm660.c
> +++ b/drivers/interconnect/qcom/sdm660.c
> @@ -127,15 +127,11 @@ enum {
>   	SDM660_SNOC,
>   };
>   
> -static const char * const bus_mm_clocks[] = {
> -	"bus",
> -	"bus_a",
> +static const char * const mm_intf_clocks[] = {
>   	"iface",
>   };
>   
> -static const char * const bus_a2noc_clocks[] = {
> -	"bus",
> -	"bus_a",
> +static const char * const a2noc_intf_clocks[] = {
>   	"ipa",
>   	"ufs_axi",
>   	"aggre2_ufs_axi",
> @@ -1516,8 +1512,8 @@ static const struct qcom_icc_desc sdm660_a2noc = {
>   	.type = QCOM_ICC_NOC,
>   	.nodes = sdm660_a2noc_nodes,
>   	.num_nodes = ARRAY_SIZE(sdm660_a2noc_nodes),
> -	.bus_clocks = bus_a2noc_clocks,
> -	.num_bus_clocks = ARRAY_SIZE(bus_a2noc_clocks),
> +	.intf_clocks = a2noc_intf_clocks,
> +	.num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
>   	.regmap_cfg = &sdm660_a2noc_regmap_config,
>   };
>   
> @@ -1659,8 +1655,8 @@ static const struct qcom_icc_desc sdm660_mnoc = {
>   	.type = QCOM_ICC_NOC,
>   	.nodes = sdm660_mnoc_nodes,
>   	.num_nodes = ARRAY_SIZE(sdm660_mnoc_nodes),
> -	.bus_clocks = bus_mm_clocks,
> -	.num_bus_clocks = ARRAY_SIZE(bus_mm_clocks),
> +	.intf_clocks = mm_intf_clocks,
> +	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
>   	.regmap_cfg = &sdm660_mnoc_regmap_config,
>   };
>   
> 

-- 
With best wishes
Dmitry

