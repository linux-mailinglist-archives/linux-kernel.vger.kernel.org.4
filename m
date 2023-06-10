Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3B272AB44
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 13:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjFJL6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 07:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjFJL6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 07:58:44 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B6A26B2;
        Sat, 10 Jun 2023 04:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686398320; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZuOvu58Ao0jzrlv2fZ27qBJaelH2eWzfvIP41z0l7xK/FgstuXK4jX9MJB7YLYPZko
    Csjmu/DC53lLPfxrGCSOXPZ8AZ2yqmk+NjSU6yCKfHZv/uC8RKpUHwewjbLPmHs2KGiE
    H0WbR2alwg0amB8kYQOeT6g09CDFD7zp7aN+0vSefom7qXlbD0aNfbnxJvsBtQOR6ltX
    e5vCTppgU1h6+zdU5iLzcYO11uh2NrTGffIJQNKcrYK/6yN1FXCr6m7nBmKNdWRDzZxO
    GoQfZclPXX4PU4iHVPxHaQ3xp6R/JsSSVZZ8hrM8FliUGeAT78VY70LcdfIqD92HEZC6
    h0ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686398320;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=kTSb4VgNfKJxcHdVBzLF5HYwpgArnYykpI5cWhr4QCo=;
    b=jqIUFlHyNeymdmRDMAE5j/FwRwuNiEKBR06qCYcT59aOLDtSzU6IO5Rd0wPjpLFey5
    jsCBZkeRa+HM7zPF0vN5EgYhR4R4jfIrzo31j+ih/zR/xotMurAu+57+FB72O6GTxxmL
    kjn929Y3RNMdfz+arEv/YzLrlVNuNu5PWmc/hpmj20jUXfAPoTrxQE3UUmpcpmrHgGmg
    EkCClBzpwN08am3VVG36NXaiRVNWnN3oFAF8dUkItKSq/fFy1YGwEusFR4ArBRZaVoSI
    iaU4BvTas1RtuvbX0lpCkQWqvS/ZdNvedJnZQeJq/XgBPH3WxQiM7CthDmdN+NWfYCWD
    8azw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686398320;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=kTSb4VgNfKJxcHdVBzLF5HYwpgArnYykpI5cWhr4QCo=;
    b=U55HB3H9amJF8Ovk8dcXLavj0M90rAZ12YEs1l/fuz+wA7YgrOvi2hI1RGf0hkvxMB
    MBU9u6bgdZDwXPMuru3y31ccFocqtq3K5xTWRt/gPQuW7BSVA7PBViRJSIDUm7nA/PGY
    8OV3SzHYsERU/GQ3M227dcNTPFnXoVEnbWNP9+0OapJGtYw7ZLd0D762k95uOPRk7dMl
    59ECmaVbSLZRrch7cfw4Efc5KGvaF/SlR1popVyDUJIrJJeuac7Y2m2J9eH9rTJRaK+J
    29EpA9iMtFtiljj+4QXHfnW6L7bitOmbh0oTOhbXMzOOIl8Cus3Ot6C9M6cJw9y46gDM
    Hmvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686398320;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=kTSb4VgNfKJxcHdVBzLF5HYwpgArnYykpI5cWhr4QCo=;
    b=r1c9h2NT3sVeF7stUm//hBkKxgSIfjOwJErPtWnHLOZOMe9pZNrecmy/80RFx1/Ncj
    TidwmNg30oonLRwP/NDw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA9J/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5ABwdQFs
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 10 Jun 2023 13:58:39 +0200 (CEST)
Date:   Sat, 10 Jun 2023 13:58:38 +0200
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
Subject: Re: [PATCH v2 17/22] interconnect: qcom: icc-rpm: Control bus rpmcc
 from icc
Message-ID: <ZIRlbi_BXyuUWs-8@gerhold.net>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
 <20230526-topic-smd_icc-v2-17-e5934b07d813@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-topic-smd_icc-v2-17-e5934b07d813@linaro.org>
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

On Fri, Jun 09, 2023 at 10:19:22PM +0200, Konrad Dybcio wrote:
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
>  drivers/interconnect/qcom/icc-rpm.c | 116 +++++++++++++++++++-----------------
>  drivers/interconnect/qcom/icc-rpm.h |  13 ++--
>  drivers/interconnect/qcom/msm8996.c |   1 -
>  drivers/interconnect/qcom/sdm660.c  |   1 -
>  4 files changed, 66 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index b8ecf9538ab9..6d40815c5401 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> [...]
> @@ -364,49 +363,50 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
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

^

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
> +	if (qp->bus_clk)
> +		return clk_set_rate(qp->bus_clk, 1000ULL * max(active_rate, sleep_rate));

Something like the min_t(u64, rate, LONG_MAX)* that was there in the old
code is still needed for the clk_set_rate(). The reason is that the rate
parameter in clk_set_rate() is unsigned long (32-bit on ARM32) while you
do the calculation in fixed u64. This can easily overflow and then the
higher bits will just be cut off.

Consider the following on ARM32:

	u64 rate = 1ULL << 32 = 4294967296ULL;
	clk_set_rate(clk, rate);

This actually does clk_set_rate(clk, 0) because the upper 32-bit will
just be truncated. So the min() is needed to ensure that we really set
the highest possible.

Also see commit a7d9436a6c85 ("interconnect: qcom: rpm: Prevent integer
overflow in rate") [1].

* I'm not sure why I used LONG_MAX instead of ULONG_MAX back then.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a7d9436a6c85fcb8843c910fd323dcd7f839bf63

> [...]
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

Hm, looks like you're requesting the clock twice? devm_clk_get()
allocates memory internally so that's not ideal. It would be better to
call it just once and store the result. Or do you actually want
devm_clk_get_optional(dev, "bus") maybe? The error handling is a bit
weird here.

> [...]
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

I guess we need dt-binding updates so we can drop the clocks from the
device tree? They're not valid anymore after you remove them from
clk-smd-rpm.c so it would be good to drop them from the DTs to avoid
confusion.

> +	if (qp->bus_clk) {
> +		ret = clk_prepare_enable(qp->bus_clk);
> +		if (ret)
> +			return ret;
> +	}

The clk_* APIs have internal NULL checks for optional clocks so you
could also omit the if statement and call it unconditionally.

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

Same here.

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

And here.

Thanks,
Stephan
