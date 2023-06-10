Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC0872AE01
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 20:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjFJSAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 14:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjFJSAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 14:00:24 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEA52139;
        Sat, 10 Jun 2023 11:00:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686420019; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ft8TKOyfWr+1mxL+0hE724XhUeldayVl8pWzYQoTJFh3BlXNe7DrvoMuLBX1TmBPoB
    TxLprjb1GrtMHdu2aDzrKtgM6maskPhSxRSz5RWcmaYQWarzaGy857hhifB3CJGuLZA1
    x1PcrgArGUDdvnjASe2XpWBDSsLEwmgyfCJE5WfTtqkdzYcveEfEWVF+S4IYhACX3y61
    qaaBxoQbIaWTwenGAnFcJy5HxkZ69ky2u+9zUcTtgL8l3SRES5WCQzyttJF8ho9LYE//
    6HELDeLj1YO6gXtQAxDsMke99SW2UevigeqJkJN5O0v4J6uA9vdWp2tqDGSUGXzseiSs
    MpQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686420019;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=u7eUmst56pJrsDCscDOFMUfohDv9/Xau2rtOzk4iSUY=;
    b=UemUla0zEl4VogswoOAX4nDf2BTKlIHMyC+r3HcAJ9NwTgVdlcg1X+TdFENKwHLg9m
    M1q+JanuTcxQEE1eK8ZwoSJqfNUzHguan7yRehzvALn8ZCQuZmCPOpDwXEEmLG3u9auU
    9cQ/ncpVAS+mm4Jg6P8dELWNcqfNw8wwL71FNSptNCsdRpGLB/tuEqdb/DTAuL+y8lpU
    4llvdo2prz5K5g8bw/Axt32VjlDE4Fookg2IoLgjcg6WxjwGytB9H19Klkq5C9a65Gd4
    SvsJsy/Ajw3SrnGUbrdLfO3OjbbXWp/qCNgnEFkI98xog5ZNFz+k1KZCCOysHVQlJb+n
    fwtg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686420019;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=u7eUmst56pJrsDCscDOFMUfohDv9/Xau2rtOzk4iSUY=;
    b=LvJlgNzZViTMt9PhKs1PluQKie2U4y6ymbD8WCAnz0ohcCUVUCghOsGXKIiZjdC9AD
    lRBpd4nyRUVDFrsng/+DefCt/UgQdSTdUDBEjqRL7ItGGv/bLYbeMRW2b3Fl9f4NaFte
    +U9rVmRy0Fhw8F9Ng8biS03m6Z50eijpA7uI5GI0UvaegVhDrWig9105JaRa9v2axkth
    ajbv686AUDIR75y66auGvCCcptf86FQccnmocTI1vEks+dGrcOUUiBi+PEu5lhN9+9c9
    Nk94CPBWeS+rl0+8xEUNq3b7DEy2lVfN+ykiRQwSC+VTpwfq55/lsJoZY15V7x1cUx1E
    Ss/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686420019;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=u7eUmst56pJrsDCscDOFMUfohDv9/Xau2rtOzk4iSUY=;
    b=BOhZKbkr1YDCuu0gDqKMKfk7xgSS2evyy/sn+Ajz6tg/le4zuL7Nzo4eJq3e9URBke
    zYyMUsoiVWUFwfYQ08DA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA9J/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5AI0JQb0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 10 Jun 2023 20:00:19 +0200 (CEST)
Date:   Sat, 10 Jun 2023 20:00:12 +0200
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
Subject: Re: [PATCH v2 20/22] interconnect: qcom: icc-rpm: Set bandwidth on
 both contexts
Message-ID: <ZIS6LK2lnlnNygX7@gerhold.net>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
 <20230526-topic-smd_icc-v2-20-e5934b07d813@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-topic-smd_icc-v2-20-e5934b07d813@linaro.org>
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

On Fri, Jun 09, 2023 at 10:19:25PM +0200, Konrad Dybcio wrote:
> Up until now, for some reason we've only been setting bandwidth values
> on the active-only context. That pretty much meant that RPM could lift
> all votes when entering sleep mode. Or never sleep at all.
> 
> That in turn could potentially break things like USB wakeup, as the
> connection between APSS and SNoC/PNoC would simply be dead.
> 

Nitpick: Apparently an "active" vote is applied during both active+sleep
until the first "sleep" vote is sent. It's documented only for
regulators [1] but I would expect the same applies to the bandwidths.
This means actual breakage shouldn't have been possible.

The patch itself is still the right thing to do to have the sleep state
correct during deep cpuidle/suspend.

[1]: https://git.codelinaro.org/clo/la/kernel/msm-3.10/-/blob/LA.BR.1.2.9.c26-04700-8x09.0/drivers/regulator/rpm-smd-regulator.c#L199-209

> Set the values appropriately.
> 
> Fixes: 30c8fa3ec61a ("interconnect: qcom: Add MSM8916 interconnect provider driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 54 +++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 3ac47b818afe..ac719013077e 100644
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
