Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A046D71620A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjE3Ndg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjE3Ndb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:33:31 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22D9F1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:33:28 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f50470d77cso2192796e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685453607; x=1688045607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RzHBG95TGnuOctJprmcZxKQVLqW0mXFHGcxSqa8Y6tE=;
        b=eElyzr0l1zie8bfz9hm+yrXW8zE/H3wW7e6xO9mgy+1plveq5ixht8aHFSSATCMtgf
         VuR6OCNei7yov0sC3+x5wt/x1EQ2VSIRtEPqXzpIbMQkAM80sifoYwwBCYf3dvexVQUU
         i7JPsXq6AJA1WwIYZEHC2IAlbWf1KMr0nsY0/JdbmNEJjftu561KZEQ4EggKy486ARn3
         nffhI3+YoT/yFeZqQogLlCCExqfVrh2uMFIb6mHDdY4ta/+PLAqxihcStSXrIombkwN7
         uLp0yvrrm/YLJKKblnJvxdUv4TSsgGa9mreLhwjYQgbccftVYWcTbm5jFHe+PUiMT2lT
         C4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685453607; x=1688045607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RzHBG95TGnuOctJprmcZxKQVLqW0mXFHGcxSqa8Y6tE=;
        b=CFjtoCcmq4bgpYmJkxNhUqb+jh0yw9J6yO8aBbTK2aaAEYQemxxS+EopTNaC2zZmo+
         E0Ah7/jN6+yIcm0zrlZpJf1svSA2GIpPObaypDQ2t7+u/rMADdwmwsSTQTnRwbmKq4EB
         7gqXGmO7EC/505p10wFEM0+YRA4Fj9ppyOu5KzRMxAhCMXenOc7lNT0d1mC2RJUUiA18
         RIwODSFzNgb7Fq+XWi8oayHRs0J+LRUXEUsqL0xvmAiYd2BlFZ/xP80gc/kcRGcaOEoS
         UT8A2VFlSoN2s6F9sNrmRza1XUawq7ZyCsJwLiBIVT6WWdmnlxRIJDHkvUBv+tzb0GRE
         Z7mA==
X-Gm-Message-State: AC+VfDwwuukT1pujp7hbzLlBP4o8D5+bUd0soYIv772XU+GUGbqoQSW2
        VdjoXCXxcCXBTZd+bQgKc16Sug==
X-Google-Smtp-Source: ACHHUZ585Y2ZZQzJuaFTA3UBjbNnA81bq10HwueOd9+FSOjZNkSokVZM3OTAtLXHkt7YzIUfa74YsQ==
X-Received: by 2002:ac2:4d16:0:b0:4f3:a9fd:8f12 with SMTP id r22-20020ac24d16000000b004f3a9fd8f12mr624640lfi.32.1685453606739;
        Tue, 30 May 2023 06:33:26 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id d30-20020ac25ede000000b004f13eff5375sm345956lfq.45.2023.05.30.06.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 06:33:26 -0700 (PDT)
Message-ID: <c46044a5-cd52-232d-9459-13494b880bb9@linaro.org>
Date:   Tue, 30 May 2023 15:33:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 17/20] interconnect: qcom: icc-rpm: Control bus rpmcc from
 icc
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
 <20230526-topic-smd_icc-v1-17-1bf8e6663c4e@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-17-1bf8e6663c4e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.05.2023 12:20, Konrad Dybcio wrote:
> The sole purpose of bus clocks that were previously registered with
> rpmcc was to convey the aggregated bandwidth to RPM. There's no good
> reason to keep them outside the interconnect framework, as it only
> adds to the plentiful complexity.
> 
> Add the required code to handle these clocks from within SMD RPM ICC.
> 
> RPM-owned bus clocks are no longer considered a thing, but sadly we
> have to allow for the existence of HLOS-owned bus clocks, as some
> (mostly older) SoCs (ab)use these for bus scaling (e.g. MSM8998 and
> &mmcc AHB_CLK_SRC).
> 
> This in turn is trivially solved with a single *clk, which is filled
> and used iff qp.bus_clk_desc is absent and we have a "bus" clock-names
> entry in the DT node.
> 
> This change should(tm) be fully compatible with all sorts of old
> Device Trees as far as the interconnect functionality goes (modulo
> abusing bus clock handles, but that's a mistake in and of itself).
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
[...]

> +	/* Some providers don't have a bus clock to scale */
> +	if (!qp->bus_clk_desc)
if (!qp->bus_clk_desc && !qp->bus_clk)

Konrad
> +		return 0;
> +
> +	/* Intentionally keep the rates in kHz as that's what RPM accepts */
> +	active_rate = max(agg_avg[QCOM_SMD_RPM_ACTIVE_STATE],
> +			  agg_peak[QCOM_SMD_RPM_ACTIVE_STATE]);
> +	do_div(active_rate, src_qn->buswidth);
> +
> +	sleep_rate = max(agg_avg[QCOM_SMD_RPM_SLEEP_STATE],
> +			 agg_peak[QCOM_SMD_RPM_SLEEP_STATE]);
> +	do_div(sleep_rate, src_qn->buswidth);
> +
> +	/*
> +	 * Downstream checks whether the requested rate is zero, but it makes little sense
> +	 * to vote for a value that's below the lower threshold, so let's not do so.
> +	 */
> +	if (qp->keep_alive)
> +		active_rate = max(ICC_BUS_CLK_MIN_RATE, active_rate);
> +
> +	/* Some providers have a non-RPM-owned bus clock - convert kHz->Hz for the CCF */
> +	if (qp->bus_clk)
> +		return clk_set_rate(qp->bus_clk, 1000ULL * max(active_rate, sleep_rate));
> +
> +	/* RPM only accepts <=INT_MAX rates */
> +	active_rate = min_t(u32, active_rate, INT_MAX);
> +	sleep_rate = min_t(u32, sleep_rate, INT_MAX);
> +
> +	if ((active_rate != qp->bus_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE]) ||
> +	    (sleep_rate != qp->bus_clk_rate[QCOM_SMD_RPM_SLEEP_STATE])) {
> +		ret = qcom_icc_rpm_set_bus_rate(qp->bus_clk_desc,
> +						active_rate,
> +						sleep_rate);
> +		if (ret)
>  			return ret;
> -		}
> -		qp->bus_clk_rate[i] = rate;
>  	}
>  
> +	/* Cache the rate after we've successfully commited it to RPM */
> +	qp->bus_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE] = active_rate;
> +	qp->bus_clk_rate[QCOM_SMD_RPM_SLEEP_STATE] = sleep_rate;
> +
>  	return 0;
>  }
>  
> -static const char * const bus_clocks[] = {
> -	"bus", "bus_a",
> -};
> -
>  int qnoc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -448,6 +448,18 @@ int qnoc_probe(struct platform_device *pdev)
>  	if (!qp->intf_clks)
>  		return -ENOMEM;
>  
> +	if (desc->bus_clk_desc) {
> +		qp->bus_clk_desc = devm_kzalloc(dev, sizeof(*qp->bus_clk_desc),
> +						GFP_KERNEL);
> +		if (!qp->bus_clk_desc)
> +			return -ENOMEM;
> +
> +		qp->bus_clk_desc = desc->bus_clk_desc;
> +	} else if (!IS_ERR(devm_clk_get(dev, "bus"))) {
> +		/* Some older SoCs may have a single non-RPM-owned bus clock. */
> +		qp->bus_clk = devm_clk_get(dev, "bus");
> +	}
> +
>  	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
>  			    GFP_KERNEL);
>  	if (!data)
> @@ -457,10 +469,6 @@ int qnoc_probe(struct platform_device *pdev)
>  	for (i = 0; i < cd_num; i++)
>  		qp->intf_clks[i].id = cds[i];
>  
> -	qp->num_bus_clks = desc->no_clk_scaling ? 0 : NUM_BUS_CLKS;
> -	for (i = 0; i < qp->num_bus_clks; i++)
> -		qp->bus_clks[i].id = bus_clocks[i];
> -
>  	qp->keep_alive = desc->keep_alive;
>  	qp->type = desc->type;
>  	qp->qos_offset = desc->qos_offset;
> @@ -490,13 +498,11 @@ int qnoc_probe(struct platform_device *pdev)
>  	}
>  
>  regmap_done:
> -	ret = devm_clk_bulk_get(dev, qp->num_bus_clks, qp->bus_clks);
> -	if (ret)
> -		return ret;
> -
> -	ret = clk_bulk_prepare_enable(qp->num_bus_clks, qp->bus_clks);
> -	if (ret)
> -		return ret;
> +	if (qp->bus_clk) {
> +		ret = clk_prepare_enable(qp->bus_clk);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	ret = devm_clk_bulk_get(dev, qp->num_intf_clks, qp->intf_clks);
>  	if (ret)
> @@ -566,7 +572,8 @@ int qnoc_probe(struct platform_device *pdev)
>  	icc_provider_deregister(provider);
>  err_remove_nodes:
>  	icc_nodes_remove(provider);
> -	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
> +	if (qp->bus_clk)
> +		clk_disable_unprepare(qp->bus_clk);
>  
>  	return ret;
>  }
> @@ -578,7 +585,8 @@ int qnoc_remove(struct platform_device *pdev)
>  
>  	icc_provider_deregister(&qp->provider);
>  	icc_nodes_remove(&qp->provider);
> -	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
> +	if (qp->bus_clk)
> +		clk_disable_unprepare(qp->bus_clk);
>  
>  	return 0;
>  }
> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index e3df066fd94e..2c8c0399378b 100644
> --- a/drivers/interconnect/qcom/icc-rpm.h
> +++ b/drivers/interconnect/qcom/icc-rpm.h
> @@ -36,32 +36,29 @@ struct rpm_clk_resource {
>  	bool branch;
>  };
>  
> -#define NUM_BUS_CLKS	2
> -
>  /**
>   * struct qcom_icc_provider - Qualcomm specific interconnect provider
>   * @provider: generic interconnect provider
> - * @num_bus_clks: the total number of bus_clks clk_bulk_data entries (0 or 2)
>   * @num_intf_clks: the total number of intf_clks clk_bulk_data entries
>   * @type: the ICC provider type
>   * @regmap: regmap for QoS registers read/write access
>   * @bus_clk_rate: bus clock rate in Hz
> - * @bus_clks: the clk_bulk_data table of bus clocks
> + * @bus_clk_desc: a pointer to a rpm_clk_resource description of bus clocks
>   * @intf_clks: a clk_bulk_data array of interface clocks
> + * @bus_clk: a pointer to a HLOS-owned bus clock
>   * @qos_offset: offset to QoS registers
>   * @keep_alive: whether to always keep a minimum vote on the bus clocks
>   * @is_on: whether the bus is powered on
>   */
>  struct qcom_icc_provider {
>  	struct icc_provider provider;
> -	int num_bus_clks;
>  	int num_intf_clks;
>  	enum qcom_icc_type type;
>  	struct regmap *regmap;
>  	int qos_offset;
> -	u64 bus_clk_rate[NUM_BUS_CLKS];
> -	struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
> +	u32 bus_clk_rate[QCOM_SMD_RPM_STATE_NUM];
>  	const struct rpm_clk_resource *bus_clk_desc;
> +	struct clk *bus_clk;
>  	struct clk_bulk_data *intf_clks;
>  	bool keep_alive;
>  	bool is_on;
> @@ -118,12 +115,10 @@ struct qcom_icc_node {
>  struct qcom_icc_desc {
>  	struct qcom_icc_node * const *nodes;
>  	size_t num_nodes;
> -	const char * const *bus_clocks;
>  	const struct rpm_clk_resource *bus_clk_desc;
>  	const char * const *intf_clocks;
>  	size_t num_intf_clocks;
>  	bool keep_alive;
> -	bool no_clk_scaling;
>  	enum qcom_icc_type type;
>  	const struct regmap_config *regmap_cfg;
>  	int qos_offset;
> diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
> index a596f4035d2e..8081b3cb1025 100644
> --- a/drivers/interconnect/qcom/msm8996.c
> +++ b/drivers/interconnect/qcom/msm8996.c
> @@ -1818,7 +1818,6 @@ static const struct qcom_icc_desc msm8996_a0noc = {
>  	.num_nodes = ARRAY_SIZE(a0noc_nodes),
>  	.intf_clocks = a0noc_intf_clocks,
>  	.num_intf_clocks = ARRAY_SIZE(a0noc_intf_clocks),
> -	.no_clk_scaling = true,
>  	.regmap_cfg = &msm8996_a0noc_regmap_config
>  };
>  
> diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
> index 5743ed680e8e..211fa1fa569c 100644
> --- a/drivers/interconnect/qcom/sdm660.c
> +++ b/drivers/interconnect/qcom/sdm660.c
> @@ -1618,7 +1618,6 @@ static const struct qcom_icc_desc sdm660_gnoc = {
>  	.nodes = sdm660_gnoc_nodes,
>  	.num_nodes = ARRAY_SIZE(sdm660_gnoc_nodes),
>  	.regmap_cfg = &sdm660_gnoc_regmap_config,
> -	.no_clk_scaling = true,
>  };
>  
>  static struct qcom_icc_node * const sdm660_mnoc_nodes[] = {
> 
