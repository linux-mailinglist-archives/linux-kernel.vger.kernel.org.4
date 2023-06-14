Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82373730251
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245629AbjFNOtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245646AbjFNOtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:49:23 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D051F1FC2;
        Wed, 14 Jun 2023 07:49:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686754157; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fvIBSxxxj2EDxf+e+sTrdR+/4/MDQNhuM7+piT1N2q+P7J5WX9RG5ph/SR6lTGR9kP
    lKghLpMxure6ZOmTMWKvH/VJ+k1TcWWyPClaHubBtn+lLfqklhh93A4fbapHKb5BREFo
    exDDHWOFNz3WGNXtHCI+wGVHIiXLO6PHxSF8e82Unt2Os1P0mkbSWt3OWeKg8jqpJq1M
    CvaZ/4TUcB9xsMD/IjfzNiCXUVR4URthR0N2XKk36RE5UYrvlr+DIPAHqgn816te0jlb
    8wME5A2XqhuPZXUsgv9drFdt4cje9LkPUoHE5cFS8WKlCVieIGOa65WGdKX7KuocUICu
    PjQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686754157;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3VEjcJwZYaQpRLDaj4rD56xyaMokkCvkxbhkm14Fypc=;
    b=YtHzobFip2VyN7vVXzxkHaUf2Ric2OxhspA/ahqL1/9lvUKTwLhgF5gtPEuJMj6PeY
    IpnjiHrB+9xtpMh3dQiytGwcJjP65qcbwKk/d4KnpPVxHEO3Fyn7zqqDWNk/EnYXeYMn
    EBwTM4I9Cpr0lWujyDb2xd+SeEOlRAoiqF0CX8eWvDv3viFlIvn62/M7v0ojtjyDAWif
    QUvAWgYy1riE4pftDsKcjXJneqE1s00JuTF9Hk2nytR5chQqfoFOPehHJK6hvaA0eJpN
    0s8D+xPOqkw9LxKUVf91GDma+hcBOa12jg/M95ME1ALZCQIfrfB+3mbAjWiacE/CcRRQ
    woEg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686754157;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3VEjcJwZYaQpRLDaj4rD56xyaMokkCvkxbhkm14Fypc=;
    b=fpwt58Sym8UFZLzDy8lfu1+BRzbyh3m0FLJhGMtG4dRm9hVCVQVHXUKKMjUyMYsfRE
    ht6c9smJKUxVIsHUavtq2X84FnCm3dUQ3io1U4WvBU9H3rw0c9bK/LcfRbbfn3RDNU3k
    8JXnv4ATSD50HXz65XmceydRdFT20MPdj42nAIpsKHhJ6TVZy72hxckAQYITVSox9WsG
    xKMMrQt8Y/2mgL4PyektTZ27TEkivIx1biFpDsMNvAyr4keMXLPVO4mPS7zPmpaRYfxw
    6deWKdnbi7Zmv7qT8818745RMUpgHie5TVv6fKHhjOkvQm9GOtGHGyGW2MP/ePyOC40B
    MGGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686754157;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3VEjcJwZYaQpRLDaj4rD56xyaMokkCvkxbhkm14Fypc=;
    b=7spn25sXlNnI8xvrYx4F3SZppzeaAxwTfRr1czfllAoSGPmoslBignOsMaNzfGffSO
    WRSUWpKjtPScO7aZvNDQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA95nh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5EEnH0GE
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jun 2023 16:49:17 +0200 (CEST)
Date:   Wed, 14 Jun 2023 16:49:16 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 17/22] interconnect: qcom: icc-rpm: Control bus rpmcc
 from icc
Message-ID: <ZInTbLh3AMuvCe3W@gerhold.net>
References: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
 <20230526-topic-smd_icc-v5-17-eeaa09d0082e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-topic-smd_icc-v5-17-eeaa09d0082e@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 12:22:28PM +0200, Konrad Dybcio wrote:
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
> abusing bus clock handles or wrongly using the qcom,icc.h binding,
> but that's a mistake in and of itself).
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

Thanks!

> ---
>  drivers/interconnect/qcom/icc-rpm.c | 121 ++++++++++++++++++++----------------
>  drivers/interconnect/qcom/icc-rpm.h |  13 ++--
>  drivers/interconnect/qcom/msm8996.c |   1 -
>  drivers/interconnect/qcom/sdm660.c  |   1 -
>  4 files changed, 73 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index b8ecf9538ab9..858880a97d2a 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -49,7 +49,7 @@
>  #define NOC_QOS_MODE_FIXED_VAL		0x0
>  #define NOC_QOS_MODE_BYPASS_VAL		0x2
>  
> -#define ICC_BUS_CLK_MIN_RATE		19200000ULL
> +#define ICC_BUS_CLK_MIN_RATE		19200ULL /* kHz */
>  
>  static int qcom_icc_set_qnoc_qos(struct icc_node *src)
>  {
> @@ -338,11 +338,10 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>  	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL;
>  	struct icc_provider *provider;
>  	u64 sum_bw;
> -	u64 rate;
> +	u64 active_rate, sleep_rate;
>  	u64 agg_avg[QCOM_ICC_NUM_BUCKETS], agg_peak[QCOM_ICC_NUM_BUCKETS];
>  	u64 max_agg_avg;
> -	int ret, i;
> -	int bucket;
> +	int ret;
>  
>  	src_qn = src->data;
>  	if (dst)
> @@ -364,49 +363,61 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>  			return ret;
>  	}
>  
> -	for (i = 0; i < qp->num_bus_clks; i++) {
> -		/*
> -		 * Use WAKE bucket for active clock, otherwise, use SLEEP bucket
> -		 * for other clocks.  If a platform doesn't set interconnect
> -		 * path tags, by default use sleep bucket for all clocks.
> -		 *
> -		 * Note, AMC bucket is not supported yet.
> -		 */
> -		if (!strcmp(qp->bus_clks[i].id, "bus_a"))
> -			bucket = QCOM_ICC_BUCKET_WAKE;
> -		else
> -			bucket = QCOM_ICC_BUCKET_SLEEP;
> -
> -		rate = icc_units_to_bps(max(agg_avg[bucket], agg_peak[bucket]));
> -		do_div(rate, src_qn->buswidth);
> -		rate = min_t(u64, rate, LONG_MAX);
> -
> -		/*
> -		 * Downstream checks whether the requested rate is zero, but it makes little sense
> -		 * to vote for a value that's below the lower threshold, so let's not do so.
> -		 */
> -		if (bucket == QCOM_ICC_BUCKET_WAKE && qp->keep_alive)
> -			rate = max(ICC_BUS_CLK_MIN_RATE, rate);
> -
> -		if (qp->bus_clk_rate[i] == rate)
> -			continue;
> -
> -		ret = clk_set_rate(qp->bus_clks[i].clk, rate);
> -		if (ret) {
> -			pr_err("%s clk_set_rate error: %d\n",
> -			       qp->bus_clks[i].id, ret);
> +	/* Some providers don't have a bus clock to scale */
> +	if (!qp->bus_clk_desc && !qp->bus_clk)
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
> +	if (qp->bus_clk) {
> +		active_rate = max_t(u64, active_rate, sleep_rate);
> +		/* ARM32 caps clk_set_rate arg to u32.. Nothing we can do about that! */
> +		active_rate = min_t(u64, 1000ULL * active_rate, ULONG_MAX);
> +		return clk_set_rate(qp->bus_clk, active_rate);
> +	}
> +
> +	/* RPM only accepts <=INT_MAX rates */
> +	active_rate = min_t(u64, active_rate, INT_MAX);
> +	sleep_rate = min_t(u64, sleep_rate, INT_MAX);
> +
> +	if (active_rate != qp->bus_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE]) {
> +		ret = qcom_icc_rpm_set_bus_rate(qp->bus_clk_desc, QCOM_SMD_RPM_ACTIVE_STATE,
> +						active_rate);
> +		if (ret)
>  			return ret;
> -		}
> -		qp->bus_clk_rate[i] = rate;
> +
> +		/* Cache the rate after we've successfully commited it to RPM */
> +		qp->bus_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE] = active_rate;
> +	}
> +
> +	if (sleep_rate != qp->bus_clk_rate[QCOM_SMD_RPM_SLEEP_STATE]) {
> +		ret = qcom_icc_rpm_set_bus_rate(qp->bus_clk_desc, QCOM_SMD_RPM_SLEEP_STATE,
> +						sleep_rate);
> +		if (ret)
> +			return ret;
> +
> +		/* Cache the rate after we've successfully commited it to RPM */
> +		qp->bus_clk_rate[QCOM_SMD_RPM_SLEEP_STATE] = sleep_rate;
>  	}
>  
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
> @@ -448,6 +459,20 @@ int qnoc_probe(struct platform_device *pdev)
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
> +	} else {
> +		/* Some older SoCs may have a single non-RPM-owned bus clock. */
> +		qp->bus_clk = devm_clk_get_optional(dev, "bus");
> +		if (IS_ERR(qp->bus_clk))
> +			return PTR_ERR(qp->bus_clk);
> +	}
> +
>  	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
>  			    GFP_KERNEL);
>  	if (!data)
> @@ -457,10 +482,6 @@ int qnoc_probe(struct platform_device *pdev)
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
> @@ -490,11 +511,7 @@ int qnoc_probe(struct platform_device *pdev)
>  	}
>  
>  regmap_done:
> -	ret = devm_clk_bulk_get(dev, qp->num_bus_clks, qp->bus_clks);
> -	if (ret)
> -		return ret;
> -
> -	ret = clk_bulk_prepare_enable(qp->num_bus_clks, qp->bus_clks);
> +	ret = clk_prepare_enable(qp->bus_clk);
>  	if (ret)
>  		return ret;
>  
> @@ -566,7 +583,7 @@ int qnoc_probe(struct platform_device *pdev)
>  	icc_provider_deregister(provider);
>  err_remove_nodes:
>  	icc_nodes_remove(provider);
> -	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
> +	clk_disable_unprepare(qp->bus_clk);
>  
>  	return ret;
>  }
> @@ -578,7 +595,7 @@ int qnoc_remove(struct platform_device *pdev)
>  
>  	icc_provider_deregister(&qp->provider);
>  	icc_nodes_remove(&qp->provider);
> -	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
> +	clk_disable_unprepare(qp->bus_clk);
>  
>  	return 0;
>  }
> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index 692d91c248d9..d5da24495d14 100644
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
>   * @qos_offset: offset to QoS registers
>   * @bus_clk_rate: bus clock rate in Hz
> - * @bus_clks: the clk_bulk_data table of bus clocks
> + * @bus_clk_desc: a pointer to a rpm_clk_resource description of bus clocks
> + * @bus_clk: a pointer to a HLOS-owned bus clock
>   * @intf_clks: a clk_bulk_data array of interface clocks
>   * @keep_alive: whether to always keep a minimum vote on the bus clocks
>   * @is_on: whether the bus is powered on
>   */
>  struct qcom_icc_provider {
>  	struct icc_provider provider;
> -	int num_bus_clks;
>  	int num_intf_clks;
>  	enum qcom_icc_type type;
>  	struct regmap *regmap;
>  	unsigned int qos_offset;
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
>  	unsigned int qos_offset;
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
> -- 
> 2.41.0
> 
