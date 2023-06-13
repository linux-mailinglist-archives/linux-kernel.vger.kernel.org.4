Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777BF72ED1D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjFMUg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjFMUgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:36:24 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F9F199E;
        Tue, 13 Jun 2023 13:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686688577; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=R3xoC1KxkcHgVEZHcXBZxn2Fynp26ehITwjwmIKx4YtzstGVb5Qf3AvMzQ5rayAO4R
    7/UAaGDYEcDd/ddj14ug2x2PFZ36wGS9CY8awxBWmnyNTZQPX9ty0HGVrK28df3srnVz
    5kRmGxRlGqzR4GU/eTp/LuT9b5oPG/yXHwsPKSgqNdzQw8bqn77G9TsJ9cuKTVcxGQJB
    xrcCJ+z7ED98zKIegn8liaQTJWie7PnTjFLek1s0y56E1ioAmzcZDrr10zllhVT1KLqe
    NrMTf8mb2To5mxEGFylwm9cYAo618c71fye4lg+Yv/+1w2UbR+7yIMk5n1+jQsOpNxT2
    5hKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686688577;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=V0+sJnkGMESsx0NvIT+WUq+urVO42D4j8ULARDoxuXU=;
    b=hu+kKnEtEVHgt+imKbD0VNvGiMXLvcH8OonXX9af/tybOymToMp/JCE6LJTknsTtp2
    15a8UXK/GDUhUdNOEOKA+/DaS3M58OwQ3QTNGwXn8WFQB/6M41TUM+XevkBL/6yFfS6N
    DYb7OReglexeDAGKvPDu4ItWXefnKxYMI6TdBbAUkMdwbbvHzGsEMPn9ZeatNknPJFBZ
    Tzd4yOWlFdBRB15U8nFHJYV0F+6By5Q3DmbDf0NWH+tEYHknz8ydfrU++iD9iYQq153R
    jeJ3vi1DpkcSznUjGCmBG5wIWIl35CeOVsy3msUkmycEDNX6lZZNNGhJRxOtT60z++Rd
    JVWQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686688577;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=V0+sJnkGMESsx0NvIT+WUq+urVO42D4j8ULARDoxuXU=;
    b=ZilnH7DGFG6xq8mUnrRUIM83iRhaPSoXdvRMpXOdOhfIGPrsOyeadh+Zk/wob+Os61
    Flb94Y+Q5gdIegWLM7MfimsFWUjX/YhNADeKoatImx8wPq67AJrBlPk2C4pKQTERn3S6
    0rQd2ydjcJzdpU1sJV+JIiCpgOIm+09DYlC2mCKXv4LvtvEI/B1eljZQ7S3wcFbhMSKR
    dFi+GEKPYjUoHRPPxY0RE9rc3iBwxqF3sKknw0QJqmrfqw/2oTU2xfIDSGshGZ1JpQmV
    aMbN0pYPSD4/LFMz3FCsYEZ0hqhk7kbAnvHmmPK8LDEVDe+2YIMch68xXDgwtJl7fpHz
    b4+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686688577;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=V0+sJnkGMESsx0NvIT+WUq+urVO42D4j8ULARDoxuXU=;
    b=gXiI6QpPFdTD7wHQSu4SKN6IuJH3oDHf1MbhxIARdaGGy3TaEQD18SjRvzyNuvBm7X
    waXf3sqZFDX3k5V6E0Aw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z3h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5DKaGa9e
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 13 Jun 2023 22:36:16 +0200 (CEST)
Date:   Tue, 13 Jun 2023 22:36:15 +0200
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
Subject: Re: [PATCH v4 17/22] interconnect: qcom: icc-rpm: Control bus rpmcc
 from icc
Message-ID: <ZIjTPyOfuVM7S1O1@gerhold.net>
References: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
 <20230526-topic-smd_icc-v4-17-5ba82b6fbba2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-topic-smd_icc-v4-17-5ba82b6fbba2@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 04:03:17PM +0200, Konrad Dybcio wrote:
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
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 119 ++++++++++++++++++++----------------
>  drivers/interconnect/qcom/icc-rpm.h |  13 ++--
>  drivers/interconnect/qcom/msm8996.c |   1 -
>  drivers/interconnect/qcom/sdm660.c  |   1 -
>  4 files changed, 71 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index b8ecf9538ab9..f9d0ecba5631 100644
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
> @@ -364,49 +363,59 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
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
> +	active_rate = min_t(u32, active_rate, INT_MAX);
> +	sleep_rate = min_t(u32, sleep_rate, INT_MAX);

Realized this by coincidence while playing with the code changes for the
comment below: This doesn't work as intended similar to the ARM32 cap
above but it's broken even on ARM64:

Take this example:

	u64 active_rate = 4294967296ULL;
	active_rate = min_t(u32, active_rate, INT_MAX);

This should result into active_rate = INT_MAX.
But it actually results in rate = 0.

Why?

	min_t(u32, rate, INT_MAX)
	= min((u32)rate, (u32)INT_MAX)
	= min((u32)4294967296ULL, (u32)INT_MAX)
	= min(0, INT_MAX)
	= 0

This needs to be min_t(u64 to work properly :)

> +
> +	if (active_rate != qp->bus_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE]) {
> +		ret = qcom_icc_rpm_set_bus_rate(qp->bus_clk_desc, active_rate, true);
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
> +		ret = qcom_icc_rpm_set_bus_rate(qp->bus_clk_desc, sleep_rate, false);
> +		if (ret)
> +			return ret;
> +
> +		/* Cache the rate after we've successfully commited it to RPM */
> +		qp->bus_clk_rate[QCOM_SMD_RPM_SLEEP_STATE] = sleep_rate;
>  	}

With my suggestion on the other patch to pass in the ctx/state number
directly into qcom_icc_rpm_set_bus_rate() I wonder if it would be nicer
to write as loop similar to the all others.

It's a bit shorter, although the line wrapping for the keep_alive is
also more ugly. I leave it up to you :)

Not even compile tested this time!

Thanks,
Stephan

	/*
	 * Downstream checks whether the requested rate is zero, but it makes little sense
	 * to vote for a value that's below the lower threshold, so let's not do so.
	 */
	if (qp->keep_alive)
		agg_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE]
			= max(ICC_BUS_CLK_MIN_RATE, agg_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE]);

	/* Some providers have a non-RPM-owned bus clock - convert kHz->Hz for the CCF */
	if (qp->bus_clk) {
		rate = max_t(u64, agg_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE],
			     agg_clk_rate[QCOM_SMD_RPM_SLEEP_STATE]);
		/* ARM32 caps clk_set_rate arg to u32.. Nothing we can do about that! */
		reate = min_t(u64, 1000ULL * rate, ULONG_MAX);
		return clk_set_rate(qp->bus_clk, rate);
	}

	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
		/* RPM only accepts <=INT_MAX rates */
		rate = min_t(u64, active_rate, INT_MAX);
		if (rate == qp->bus_clk_rate[i])
			continue;

		ret = qcom_icc_rpm_set_bus_rate(qp->bus_clk_desc, rate, i);
		if (ret)
			return ret;

		/* Cache the rate after we've successfully commited it to RPM */
		qp->bus_clk_rate[i] = rate;
	}
