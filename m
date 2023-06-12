Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90EF72D162
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbjFLVEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjFLVEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:04:07 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7963ABA;
        Mon, 12 Jun 2023 14:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686603617; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WLDKkvJRNVu8N8coamiwd2tzciZhWD5yabOKMIsjjM6kXquHnA8C98Qvl8t6i1zEhW
    zb4BrnxYx5ZRzjzuMcqw9uvO5Bv25TY9qwwsCBhQ05T0yaTonLDA+DIi7+uQVgzKXzmN
    9u28WkE4kP94TCvAoJMGDATJnfMbExj3NNOK9aPc1ce+FFZfXGFsHcZ19NhR8eSyYKcL
    OHsgH6nqTLjDqkyAlYc2K4tO2NRS7kfDgGxPVCon54Cy/s2lwD2vUAs5HrbW7BGM2JzL
    IqXBULr5iYpXnkvxMifPDwBoFVMGNfhAgXycKxcKJp41C1I0ZXX+KLS5DK/9H61dxRp4
    X8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686603617;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3kOqOx7nI7SpaP0UiDjapjrm0lXe9fAD4eSGBSG+MAQ=;
    b=jjHuwaF22BDulBwmk/9vQkE2zFS3Xux6MsNgDKRJa0OMkaKz+xAr/7hyGut8w4v5uE
    LZ31/yx0gSNpR9OAcH1MHWyHWZd6XQibUqWWYWoTLzwzoVTNH4YPEuz2+ALuwxRNn7Ih
    LRRDHlXzpBLTuFbeaKazSKDfZCNKnyc4rrfT5hhV+GaL4cZEGLmHRRiW6r4N3LoC3cBf
    yUIdjvyX0MHodlBvSPHD7oMaflBaEErYXycQTiYIMM0OWEMFenAyPHpjxUmqATtfl/qI
    ibmnhZYbYMA1rQEnM/FjnUHmZ5rUkXhFXsE+MUzvOL7Hzkn/Vt3SAIkjN0MOZDKQ1xI5
    w4xQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686603617;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3kOqOx7nI7SpaP0UiDjapjrm0lXe9fAD4eSGBSG+MAQ=;
    b=qZN6kZ5cwuV/Cnx5zrJum33iQ3Tji8+etd/G3bDNbYML4nwfkKziFEYJA5mZlDUx3p
    5RWVFzPeOKxdno3JpmQ2cHFtaCVQ+dpvCSEiFQcnjEzH8oLNZYTSoQhTnKfHLbqHBdeZ
    ZbMoTB3IxvgyH7bqWU8xWD4+DS2MefMY/Z9z47vQk3HaUUHeuZBFxGuT5r8MfoQvjF6d
    HkTzttAPLI/7TBP1Cr6NPy7AlGHE4rdJ3mHXtby3z0T/m2DMKXNqniFPCAX5zdX42MWl
    is3+Imp4dDtjsVW20ibqBz0JKjgmWYyFx2CMfBMhXG4fwc2eW45TvYQwXAYrENW82cYO
    KGYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686603617;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3kOqOx7nI7SpaP0UiDjapjrm0lXe9fAD4eSGBSG+MAQ=;
    b=Ht/VtUIgljwuiC940yUcUnK16BRgqiB0XLDbFWCJRhhb5xo3Cm3YTSONSRwYRkjVz2
    Fjet0suquc9AuCkPyqBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8peN1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5CL0GW06
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 12 Jun 2023 23:00:16 +0200 (CEST)
Date:   Mon, 12 Jun 2023 23:00:15 +0200
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
Subject: Re: [PATCH v3 21/23] interconnect: qcom: icc-rpm: Set bandwidth on
 both contexts
Message-ID: <ZIeHX_-p05MH9Nik@gerhold.net>
References: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
 <20230526-topic-smd_icc-v3-21-5fb7d39b874f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-topic-smd_icc-v3-21-5fb7d39b874f@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 08:24:38PM +0200, Konrad Dybcio wrote:
> Up until now, for some reason we've only been setting bandwidth values
> on the active-only context. That pretty much meant that RPM could lift
> all votes when entering sleep mode. Or never sleep at all.
> 
> That in turn could potentially break things like USB wakeup, as the
> connection between APSS and SNoC/PNoC would simply be dead.
> 
> Set the values appropriately.
> 
> Fixes: 30c8fa3ec61a ("interconnect: qcom: Add MSM8916 interconnect provider driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

Would be nice to have some caching for that as well so we don't keep
sending pointless requests with the same bandwidths. Not directly
related to your fixes though, it's an optimization that can be done in a
future patch / series.

> ---
>  drivers/interconnect/qcom/icc-rpm.c | 54 +++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 54a9999fe55d..8e4eb0b90905 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -205,34 +205,39 @@ static int qcom_icc_qos_set(struct icc_node *node)
>  	}
>  }
>  
> -static int qcom_icc_rpm_set(struct qcom_icc_node *qn, u64 sum_bw)
> +static int qcom_icc_rpm_set(struct qcom_icc_node *qn, u64 *bw)
>  {
> -	int ret = 0;
> +	int ret, rpm_ctx = 0;
> +	u64 bw_bps;
>  
>  	if (qn->qos.ap_owned)
>  		return 0;
>  
> -	if (qn->mas_rpm_id != -1) {
> -		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
> -					    RPM_BUS_MASTER_REQ,
> -					    qn->mas_rpm_id,
> -					    sum_bw);
> -		if (ret) {
> -			pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
> -			       qn->mas_rpm_id, ret);
> -			return ret;
> +	for (rpm_ctx = 0; rpm_ctx < QCOM_SMD_RPM_STATE_NUM; rpm_ctx++) {
> +		bw_bps = icc_units_to_bps(bw[rpm_ctx]);
> +
> +		if (qn->mas_rpm_id != -1) {
> +			ret = qcom_icc_rpm_smd_send(rpm_ctx,
> +						    RPM_BUS_MASTER_REQ,
> +						    qn->mas_rpm_id,
> +						    bw_bps);
> +			if (ret) {
> +				pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
> +				qn->mas_rpm_id, ret);
> +				return ret;
> +			}
>  		}
> -	}
>  
> -	if (qn->slv_rpm_id != -1) {
> -		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
> -					    RPM_BUS_SLAVE_REQ,
> -					    qn->slv_rpm_id,
> -					    sum_bw);
> -		if (ret) {
> -			pr_err("qcom_icc_rpm_smd_send slv %d error %d\n",
> -			       qn->slv_rpm_id, ret);
> -			return ret;
> +		if (qn->slv_rpm_id != -1) {
> +			ret = qcom_icc_rpm_smd_send(rpm_ctx,
> +						    RPM_BUS_SLAVE_REQ,
> +						    qn->slv_rpm_id,
> +						    bw_bps);
> +			if (ret) {
> +				pr_err("qcom_icc_rpm_smd_send slv %d error %d\n",
> +				qn->slv_rpm_id, ret);
> +				return ret;
> +			}
>  		}
>  	}
>  
> @@ -337,7 +342,6 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>  	struct qcom_icc_provider *qp;
>  	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL;
>  	struct icc_provider *provider;
> -	u64 sum_bw;
>  	u64 active_rate, sleep_rate;
>  	u64 agg_avg[QCOM_SMD_RPM_STATE_NUM], agg_peak[QCOM_SMD_RPM_STATE_NUM];
>  	u64 max_agg_avg;
> @@ -351,14 +355,12 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>  
>  	qcom_icc_bus_aggregate(provider, agg_avg, agg_peak, &max_agg_avg);
>  
> -	sum_bw = icc_units_to_bps(max_agg_avg);
> -
> -	ret = qcom_icc_rpm_set(src_qn, sum_bw);
> +	ret = qcom_icc_rpm_set(src_qn, agg_avg);
>  	if (ret)
>  		return ret;
>  
>  	if (dst_qn) {
> -		ret = qcom_icc_rpm_set(dst_qn, sum_bw);
> +		ret = qcom_icc_rpm_set(dst_qn, agg_avg);
>  		if (ret)
>  			return ret;
>  	}
> 
> -- 
> 2.41.0
> 
