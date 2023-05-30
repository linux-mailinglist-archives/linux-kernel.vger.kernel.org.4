Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3143671699A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjE3Qcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjE3Qcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:32:31 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3287CE46
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:32:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f4e71a09a7so5252798e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685464327; x=1688056327;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uh8bp8/N+tK7m/qngGoSnlIckrTNqW73X1nH+GEEZ04=;
        b=I992L0kdjAMvDOU10MyEwZLBJ9kglidWBiS8y95NrZnyENV8f+wdP2Oki6Oiq2k4C7
         kre68MArgwNwvBKLYJKH6HlHS5gYIXZtNx5LK7+dxkZyRYwFY7nC7xR0IjQqEA7CnsRV
         W1eD2kwnVBJKhc8ycVXh53+tPfj81OtFsMewMgro4iGxlUgGK/XgS9aeIbtBXd/rsBdS
         3jpYHAm/v32KxCvvdK4Vn219S+IbrWTrwCVXYZPB6YfCRd5YrRAxCW1oCbr2BnTGFV7t
         94BhxY8DqLsrXsTVA6ZWldtUSyaBFJCC3wd1gMKYZ7zkosF4zW7eR/gDtRIi4ky3SwNJ
         jshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685464327; x=1688056327;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uh8bp8/N+tK7m/qngGoSnlIckrTNqW73X1nH+GEEZ04=;
        b=mIju6ZejvbKWbFo63ozv5hjzpP31c/Mo8ciAgKty8nSKvMB9QJlnI4PVGK0KYOWDYM
         b0e4brAQW9DrnrNsp4p/uGqyNmV40DVX8g9RZ+cEoGW3hngSnsDLa/U9teDW8YwX2Z6j
         n6VY/hfuGSEufa2bXwls2RuYSdLxInnAA9jTfEmPWTCG/nVz9FYtFfAKN0XOfUA68Aa9
         XL5IDQ+ZepJ748BpU4/p6xa7DZKO9wVx6lupkszj27vIFXN8H7186A618Q7IleZeMpuW
         UkwKF4IeINnt9ARl+sIk1dQ45WVsHXVmOfaVkQcM7d3/SXmcslUJVoA+ZS3Fh2Iy1yAr
         pA1A==
X-Gm-Message-State: AC+VfDxlrr69jX8+JuPJs5qtvSmwa18MTHs0EGz3xhO7UuMTbisxx+Nw
        gJfd/+dLzPzI9QyJKTcH8aYmNw==
X-Google-Smtp-Source: ACHHUZ4oCmCBcr/w6q63AE5PHt6atRdVEiJTRNk2+IUqht5cc2lVYIGFEh7FiYS+1l0O4rgLVLUi8A==
X-Received: by 2002:a05:6512:6ca:b0:4f3:a763:ccb7 with SMTP id u10-20020a05651206ca00b004f3a763ccb7mr3626951lff.2.1685464326959;
        Tue, 30 May 2023 09:32:06 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c15-20020ac244af000000b004f4b42e2d7dsm386045lfm.230.2023.05.30.09.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 09:32:06 -0700 (PDT)
Message-ID: <5a26e456-fe45-6def-27f9-26ec00c333e6@linaro.org>
Date:   Tue, 30 May 2023 18:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
 <20230526-topic-smd_icc-v1-20-1bf8e6663c4e@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 20/20] interconnect: qcom: Divide clk rate by src node bus
 width
In-Reply-To: <20230526-topic-smd_icc-v1-20-1bf8e6663c4e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.05.2023 12:20, Konrad Dybcio wrote:
> Ever since the introduction of SMD RPM ICC, we've been dividing the
> clock rate by the wrong bus width. This has resulted in:
> 
> - setting wrong (mostly too low) rates, affecting performance
>   - most often /2 or /4
>   - things like DDR never hit their full potential
>   - the rates were only correct if src bus width == dst bus width
>     for all src, dst pairs on a given bus
> 
> - Qualcomm using the same wrong logic in their BSP driver in msm-5.x
>   that ships in production devices today
> 
> - me losing my sanity trying to find this
> 
> Resolve it by using dst_qn, if it exists.
> 
> Fixes: 5e4e6c4d3ae0 ("interconnect: qcom: Add QCS404 interconnect provider driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
The problem is deeper.

Chatting with Stephan (+CC), we tackled a few issues (that I will send
fixes for in v2):

1. qcom_icc_rpm_set() should take per-node (src_qn->sum_avg, dst_qn->sum_avg)
   and NOT aggregated bw (unless you want ALL of your nodes on a given provider
   to "go very fast")

2. the aggregate bw/clk rate calculation should use the node-specific bus widths
   and not only the bus width of the src/dst node, otherwise the average bw
   values will be utterly meaningless

3. thanks to (1) and (2) qcom_icc_bus_aggregate() can be remodeled to instead
   calculate the clock rates for the two rpm contexts, which we can then max()
   and pass on to the ratesetting call


----8<---- Cutting off Stephan's seal of approval, this is my thinking ----

4. I *think* Qualcomm really made a mistake in their msm-5.4 driver where they
   took most of the logic from the current -next state and should have been
   setting the rate based on the *DST* provider, or at least that's my
   understanding trying to read the "known good" msm-4.19 driver
   (which remembers msm-3.0 lol).. Or maybe we should keep src but ensure there's
   also a final (dst, dst) vote cast:

provider->inter_set = false // current state upstream

setting apps_proc<->slv_bimc_snoc
setting mas_bimc_snoc<->slv_snoc_cnoc
setting mas_snoc_cnoc<->qhs_sdc2


provider->inter_set = true // I don't think there's effectively a difference?

setting apps_proc<->slv_bimc_snoc
setting slv_bimc_snoc<->mas_bimc_snoc
setting mas_bimc_snoc<->slv_snoc_cnoc
setting slv_snoc_cnoc<->mas_snoc_cnoc
setting mas_snoc_cnoc<->qhs_sdc2

all the (mas|slv)_bus1_bus2 are very wide whereas the target nodes are usually
4-, 8- or 16-wide, which without this patch or something equivalent decimates
(or actually 2^n-ates) the calculated rates..

Konrad


>  drivers/interconnect/qcom/icc-rpm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 59be704364bb..58e2a8b1b7c3 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -340,7 +340,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
>  static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>  {
>  	struct qcom_icc_provider *qp;
> -	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL;
> +	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL, *qn = NULL;
>  	struct icc_provider *provider;
>  	u64 active_rate, sleep_rate;
>  	u64 agg_avg[QCOM_SMD_RPM_STATE_NUM], agg_peak[QCOM_SMD_RPM_STATE_NUM];
> @@ -353,6 +353,8 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>  	provider = src->provider;
>  	qp = to_qcom_provider(provider);
>  
> +	qn = dst_qn ? dst_qn : src_qn;
> +
>  	qcom_icc_bus_aggregate(provider, agg_avg, agg_peak, &max_agg_avg);
>  
>  	ret = qcom_icc_rpm_set(src_qn, agg_avg);
> @@ -372,11 +374,11 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>  	/* Intentionally keep the rates in kHz as that's what RPM accepts */
>  	active_rate = max(agg_avg[QCOM_SMD_RPM_ACTIVE_STATE],
>  			  agg_peak[QCOM_SMD_RPM_ACTIVE_STATE]);
> -	do_div(active_rate, src_qn->buswidth);
> +	do_div(active_rate, qn->buswidth);
>  
>  	sleep_rate = max(agg_avg[QCOM_SMD_RPM_SLEEP_STATE],
>  			 agg_peak[QCOM_SMD_RPM_SLEEP_STATE]);
> -	do_div(sleep_rate, src_qn->buswidth);
> +	do_div(sleep_rate, qn->buswidth);
>  
>  	/*
>  	 * Downstream checks whether the requested rate is zero, but it makes little sense
> 
