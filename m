Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765EB72AE49
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 21:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjFJTGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 15:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFJTGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 15:06:49 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250401993;
        Sat, 10 Jun 2023 12:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686424005; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OHtEGfhxaH7dlwyWGD3+FOQMOTSOfE4my4awPjNwaz4BtzrXLriGP1IgAAn7rtV8BL
    K2JdRmEEwsSn7jT/++M/jfm5P+uizeKQJimUugKhqn/qO425Pn9AoPOy+Jw3i1KBhyu2
    LMXr16P+tImQ7860OZkriZQ+asoOiZkjHCm9HKUCRQKEdlEyXQ7J6C6dJRj0QBzuemyS
    d5Hu5+4WsClrFquvMswHz4sxH1Vds9NYCKe4I5UzrmD24YlsjWw+bA9pL9xEgaTwQVMp
    8vha9kJLg3o/Fmxi7wM0rjrL5LBjcV33NyEN/jXXVDKU4UaSFVyDDAwCM45PQOA8kHpQ
    o3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686424005;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=FzAuq4cPp6KntfpN8zuj4B2A1K89KUMHN30ezwh3BfU=;
    b=UAw9oWP/KO5XBTTGQP2Gfr6rAeU+A9q2tU+YwQeAAt5aPuCxFyn+/nFATJRGMy4j/g
    R+JpFf4bYadA/NUaf09TSEvldVbnQzjauZnJ1p+mQdiGl6bepoOsspXDYOU8DJ0dsZQt
    iFp8beeL57SJ+4obBYpeVt6b1EASH7DNjW4ABR45YK1Q/oNZKjqohI9BXM8mOQFJM5Ae
    O/cdK69EMHYFSiSd7u+WrXdNA8Uqe/pM9JSsaMpIRxM3rrbgrIFpriPuWTGWpCWprz2t
    gu9LvqUaqM0zvZU60NcstiCoEFfX1OgUiUaddF7lMm2oW0/te+i2C8CGM0OYgyA9CI3l
    Nuqg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686424005;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=FzAuq4cPp6KntfpN8zuj4B2A1K89KUMHN30ezwh3BfU=;
    b=B1U5IQPEkveNl1eLfa4TSHAPevE34w2+BJHx9EiL9O3BqzQdrnqsduB7Lt+N+4t0mp
    6/D1W++hgjUNobRFpj3/xnylfC8E9xzGTyb0uRlEYC1OZIeOtOG8vKA3jIpZ+r8BL+6X
    Pnrar0J3OroB5jY+T8klmLAT+F8A4jwAYHqX9NnI6L4Jjr26W7hocDhvToXE0fuoQFeK
    UjLClVWv+sNw/Pn1FEM/vIMNTg6WJKHJ2tCLXoi6cccEmXfCVHFgfedeB4rrP/EtZOjV
    YZDcbD8zoCCmoA8jlL67AkpQ/Ap+ne5CBGHAAXHfS3033m92cbI/dCmLS2hbSgoJfFhx
    8kJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686424005;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=FzAuq4cPp6KntfpN8zuj4B2A1K89KUMHN30ezwh3BfU=;
    b=0E2MN4fWvY87RzGQVZs7tflVZTrYs3imbhEzEohYh7Tb24iinXdtMTAjs6Eed+h/Ed
    p7SkdtZv9tj+gZqFZ9Bw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA9J/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5AJ6jQe3
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 10 Jun 2023 21:06:45 +0200 (CEST)
Date:   Sat, 10 Jun 2023 21:06:43 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 22/22] interconnect: qcom: icc-rpm: Fix bandwidth
 calculations
Message-ID: <ZITJw05MYgCjzLFx@gerhold.net>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
 <20230526-topic-smd_icc-v2-22-e5934b07d813@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-topic-smd_icc-v2-22-e5934b07d813@linaro.org>
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

On Fri, Jun 09, 2023 at 10:19:27PM +0200, Konrad Dybcio wrote:
> Up until now, we've been aggregating the bandwidth values and only
> dividing them by the bus width of the source node. This was completely
> wrong, as different nodes on a given path may (and usually do) have
> varying bus widths.  That in turn, resulted in the calculated clock rates
> being completely bogus - usually they ended up being much higher, as
> NoC_A<->NoC_B links are very wide.
> 
> Since we're not using the aggregate bandwidth value for anything other
> than clock rate calculations, remodel qcom_icc_bus_aggregate() to
> calculate the per-context clock rate for a given provider, taking into
> account the bus width of every individual node.
> 
> Fixes: 30c8fa3ec61a ("interconnect: qcom: Add MSM8916 interconnect provider driver")
> Reported-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 59 ++++++++++++-------------------------
>  1 file changed, 19 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 1508233632f6..d177a76abe2a 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -293,58 +293,44 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>  }
>  
>  /**
> - * qcom_icc_bus_aggregate - aggregate bandwidth by traversing all nodes
> + * qcom_icc_bus_aggregate - calculate bus clock rates by traversing all nodes
>   * @provider: generic interconnect provider
> - * @agg_avg: an array for aggregated average bandwidth of buckets
> - * @agg_peak: an array for aggregated peak bandwidth of buckets
> - * @max_agg_avg: pointer to max value of aggregated average bandwidth
> + * @agg_clk_rate: array containing the aggregated clock rates in kHz
>   */
> -static void qcom_icc_bus_aggregate(struct icc_provider *provider,
> -				   u64 *agg_avg, u64 *agg_peak,
> -				   u64 *max_agg_avg)
> +static void qcom_icc_bus_aggregate(struct icc_provider *provider, u64 *agg_clk_rate)
>  {
> -	struct icc_node *node;
> +	u64 agg_avg_rate, agg_rate;
>  	struct qcom_icc_node *qn;
> -	u64 sum_avg[QCOM_SMD_RPM_STATE_NUM];
> +	struct icc_node *node;
>  	int i;
>  
> -	/* Initialise aggregate values */
> -	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
> -		agg_avg[i] = 0;
> -		agg_peak[i] = 0;
> -	}
> -
> -	*max_agg_avg = 0;
> -
>  	/*
> -	 * Iterate nodes on the interconnect and aggregate bandwidth
> -	 * requests for every bucket.
> +	 * Iterate nodes on the provider, aggregate bandwidth requests for
> +	 * every bucket and convert them into bus clock rates.
>  	 */
>  	list_for_each_entry(node, &provider->nodes, node_list) {
>  		qn = node->data;
>  		for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
>  			if (qn->channels)
> -				sum_avg[i] = div_u64(qn->sum_avg[i], qn->channels);
> +				agg_avg_rate = div_u64(qn->sum_avg[i], qn->channels);
>  			else
> -				sum_avg[i] = qn->sum_avg[i];
> -			agg_avg[i] += sum_avg[i];
> -			agg_peak[i] = max_t(u64, agg_peak[i], qn->max_peak[i]);
> +				agg_avg_rate = qn->sum_avg[i];
> +
> +			agg_rate = max_t(u64, agg_avg_rate, qn->max_peak[i]);
> +			do_div(agg_rate, qn->buswidth);
> +
> +			agg_clk_rate[i] = max_t(u64, agg_clk_rate[i], agg_rate);
>  		}
>  	}
> -
> -	/* Find maximum values across all buckets */
> -	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++)
> -		*max_agg_avg = max_t(u64, *max_agg_avg, agg_avg[i]);
>  }
>  
>  static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>  {
> -	struct qcom_icc_provider *qp;
>  	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL;
> +	u64 agg_clk_rate[QCOM_SMD_RPM_STATE_NUM] = { 0 };
>  	struct icc_provider *provider;
> +	struct qcom_icc_provider *qp;
>  	u64 active_rate, sleep_rate;
> -	u64 agg_avg[QCOM_SMD_RPM_STATE_NUM], agg_peak[QCOM_SMD_RPM_STATE_NUM];
> -	u64 max_agg_avg;
>  	int ret;
>  
>  	src_qn = src->data;
> @@ -353,7 +339,9 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>  	provider = src->provider;
>  	qp = to_qcom_provider(provider);
>  
> -	qcom_icc_bus_aggregate(provider, agg_avg, agg_peak, &max_agg_avg);
> +	qcom_icc_bus_aggregate(provider, agg_clk_rate);
> +	active_rate = agg_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE];
> +	sleep_rate = agg_clk_rate[QCOM_SMD_RPM_SLEEP_STATE];
>  
>  	ret = qcom_icc_rpm_set(src_qn, src_qn->sum_avg);
>  	if (ret)
> @@ -369,15 +357,6 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>  	if (!qp->bus_clk_desc && !qp->bus_clk)
>  		return 0;
>  
> -	/* Intentionally keep the rates in kHz as that's what RPM accepts */

I kind of liked this comment because otherwise it's not obvious why
you're not converting from "ICC units" anywhere.

Anyway:

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

Thanks for going through the giant maze to fix this!

Stephan
