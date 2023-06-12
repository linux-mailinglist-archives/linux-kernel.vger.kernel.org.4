Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEDB72D13F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbjFLVBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbjFLVAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:00:44 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7945CE;
        Mon, 12 Jun 2023 13:56:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686603292; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=J0PpVHEyu9LeGS30BZHfqPq5IA2uWWc23WWK1kUp6o94erL/wSiwnORHoMh88EcXxj
    SYRSiM3laOylhzAgxn5HZGIpyeaHhlUDsPVTDgWF1OkXyonGbJQxvMMzfy4wS8b2U2Gq
    kkmV16wKM9kLofuL9fbxV0m7vTZzpiLGvc62oT9I+WroLa5g+EbZCTSorpzmdDHlKxhc
    wriHHqSi5lpiM/2o3L+Rn5wJKHoURUXgNExDq8vMGsr/6k6h9rchuNX3nHRrmbXM8BHT
    6oPkNtyIegmL88b3QVnrzvAjnWF6Vxsx48rD676Cm7LF9VUyWOFL8s74hAwMbmUC1ya0
    nsvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686603292;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=me4jzGqzj11/RcyJdsYdhF7xS2e9mqfjPPXLiPNZyQk=;
    b=Izue4s4/7Bs3zMt+ZVLnOVweIdJIuWiv44sOZDN8zKbh/1TqqgjBf1Wxdsc+PKzN3I
    0bHRnPHMCRFymDWYXP3AZ/U/eaaZ5BSaFVdvmQVWOqNIs8SrVuXm2NrS55hRo4QXSFOU
    pQ0n2qJyPIogqa4WMz5GdYAARURYJYey6CNZAlaODPegctWsJkF2OSuKc73z+OD6CbHT
    R+bZcNrZk8s4YaYOA0Z8AWgny49fztSUIB8v6XmnTynm7HEw2zu0DroFhAoJd36q7JdA
    E8q2wz+I3aYiPh9WVpZS/ftoa3BABO/xNthWnK9nIpvopC/xKbYGpIO0yq+na2kGeTMX
    r8pg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686603292;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=me4jzGqzj11/RcyJdsYdhF7xS2e9mqfjPPXLiPNZyQk=;
    b=SLfGP8WXW4xyrb55sRmL//BRklhDUyYZGuJLRBCaOA0s9b6U7fqLo4X61ujmoFGjrE
    KtYHqrJvzfy9XQZ4xsZmSeKkFj0nc0DYIzesrivaMNMlt9On3124wZYTQdqtMGXbsey1
    QKynGcvVXaIwLA/AsdIUsYlKaWUTfkQ62Ot4jnh4cGz8bCgKluJnn2TXOvsC8xkXLOVk
    heuyHDRRH5ijPbkQaf4Tp9cW9HkwH4JtpwUsrk1fjEYaH/v3nWbiv5KYZeCt+YaCNk2j
    QfAn8X6IOvNPwJG2W3ooTlKCajNt3CanommL46eKpW7cTQzGe5KrXAg1hKZJwmCkx0TV
    qMIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686603292;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=me4jzGqzj11/RcyJdsYdhF7xS2e9mqfjPPXLiPNZyQk=;
    b=8FU6gvPTkzPNG4SA848g4wNr50I7hc8MbITHbuRJT/AbcFGfYBpcllUd5wm2pE6EzS
    I18oxA2xdl5xrc1GVdDA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8peN1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5CKspVzm
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 12 Jun 2023 22:54:51 +0200 (CEST)
Date:   Mon, 12 Jun 2023 22:54:50 +0200
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
Subject: Re: [PATCH v3 18/23] interconnect: qcom: icc-rpm: Control bus rpmcc
 from icc
Message-ID: <ZIeGGn7emge6Xkb0@gerhold.net>
References: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
 <20230526-topic-smd_icc-v3-18-5fb7d39b874f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-topic-smd_icc-v3-18-5fb7d39b874f@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 08:24:35PM +0200, Konrad Dybcio wrote:
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

Would be nice to add a comment here already that you're breaking
compatbility with the qcom,icc.h. It's a bit hidden otherwise.

> ---
>  drivers/interconnect/qcom/icc-rpm.c | 114 ++++++++++++++++++++----------------
>  drivers/interconnect/qcom/icc-rpm.h |  13 ++--
>  drivers/interconnect/qcom/msm8996.c |   1 -
>  drivers/interconnect/qcom/sdm660.c  |   1 -
>  4 files changed, 66 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index b8ecf9538ab9..5ffcf5ca8914 100644
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
> @@ -364,49 +363,54 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
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
> +
> +	if ((active_rate != qp->bus_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE]) ||
> +	    (sleep_rate != qp->bus_clk_rate[QCOM_SMD_RPM_SLEEP_STATE])) {
> +		ret = qcom_icc_rpm_set_bus_rate(qp->bus_clk_desc,
> +						active_rate,
> +						sleep_rate);
> +		if (ret)
>  			return ret;

Hm, do we have to set both rates together in all cases? If cpufreq is
quickly changing frequencies (and therefore active-only ICC bandwidths)
it should be sufficient to make one call into RPM and leave the sleep
rate as-is. Especially because you already cache the two rates
separately.

AFAICT downstream updates the contexts completely separately, so I don't
think it updates both rates at once either. And actually even the old
code before this patch didn't do that :D

Thanks,
Stephan
