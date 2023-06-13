Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D24272E15C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbjFMLXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241497AbjFMLXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:23:00 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB8A1FCF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 04:22:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b1ac373c9eso65601241fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 04:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686655332; x=1689247332;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEiBlQtM1KSXPhrQOGJJ3O3U5L5lQAvJZUw1sBa4LaY=;
        b=Q+ddL3nmDNPdTlA6UknAFxrHXmnW+yYVeECzdf0LBsU328rfuQBMTcGZIWDgCtDryB
         Fdlfz97nbC0SKldsxcZK168dY6h5h4U0sN/DaOoO1aSPKRfsNCDx5xkt3JCNx8FJOTKl
         1ly2NkBaSZEa30pZv2CX2uIUHmACtVnW2DQRpk0vZ7BKwRQZWHI8rc1qEjhJubG6YYx7
         auBpou+K2cucsoLG526aZYLhBbCC/EYkiEPPnGyFBaDAt7Wcegr0+q8urmbhhzJXI68P
         bg8QzAo2ZwOx4kLtj5qnZyKAwmv1w3s8Vzn0bwVj83j3h+/CaYR/P+X9ubjjIEYfMKlP
         8WtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686655332; x=1689247332;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KEiBlQtM1KSXPhrQOGJJ3O3U5L5lQAvJZUw1sBa4LaY=;
        b=ZLxLlG1EoW673Ib1dqVDqlInj/xfN4Qc2zG4UKVo+1VyHEYcXmcOi4Ycax1qe3wmBX
         tmePvESsfNpC2lUfpyDX553ecKCSQsyMe97WjrEyOE66e/gGgiLneq8OcEMKGHBKr/im
         hi5Au86sgsH4P4Fo0ZnqDDcksRA2jlEK/pw6oxlyL0+p1ZVhMTfX2e/c4a8DCpWVRkgI
         91RHk8NHd25AWoqt0/KLerl2IAJoJqZOC9jqFhnJl6CEtr+t3yhOw6Cq1v3utX1Suye5
         ImOCbBtx1UHee1qmOzQ63JVU9eZHT+DdJYyRtbZqg0960wyFu5iTXO0x1lGtfjQlozZA
         74Dg==
X-Gm-Message-State: AC+VfDzRuBI0+/MVO0X/SGvapFMYg/aGCYa4voOpXZ0EUUYN22Tpi4uj
        rh9maTWzSiPecRsza/UAlgU4nw==
X-Google-Smtp-Source: ACHHUZ7ef45PANVRG898Mup8KxCLByZBkt0J36XqbeDblWj/cLUyDMmPpoyrU329EgjQKrYm7x1U1w==
X-Received: by 2002:a2e:3801:0:b0:2b2:a6:6132 with SMTP id f1-20020a2e3801000000b002b200a66132mr4627803lja.25.1686655332174;
        Tue, 13 Jun 2023 04:22:12 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id e3-20020a2e8183000000b002adaacdb900sm2113062ljg.42.2023.06.13.04.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 04:22:11 -0700 (PDT)
Message-ID: <88ce120e-dc2e-a07f-3c9f-53073e51a1af@linaro.org>
Date:   Tue, 13 Jun 2023 13:22:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
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
References: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
 <20230526-topic-smd_icc-v3-18-5fb7d39b874f@linaro.org>
 <ZIeGGn7emge6Xkb0@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v3 18/23] interconnect: qcom: icc-rpm: Control bus rpmcc
 from icc
In-Reply-To: <ZIeGGn7emge6Xkb0@gerhold.net>
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



On 12.06.2023 22:54, Stephan Gerhold wrote:
> On Mon, Jun 12, 2023 at 08:24:35PM +0200, Konrad Dybcio wrote:
>> The sole purpose of bus clocks that were previously registered with
>> rpmcc was to convey the aggregated bandwidth to RPM. There's no good
>> reason to keep them outside the interconnect framework, as it only
>> adds to the plentiful complexity.
>>
>> Add the required code to handle these clocks from within SMD RPM ICC.
>>
>> RPM-owned bus clocks are no longer considered a thing, but sadly we
>> have to allow for the existence of HLOS-owned bus clocks, as some
>> (mostly older) SoCs (ab)use these for bus scaling (e.g. MSM8998 and
>> &mmcc AHB_CLK_SRC).
>>
>> This in turn is trivially solved with a single *clk, which is filled
>> and used iff qp.bus_clk_desc is absent and we have a "bus" clock-names
>> entry in the DT node.
>>
>> This change should(tm) be fully compatible with all sorts of old
>> Device Trees as far as the interconnect functionality goes (modulo
>> abusing bus clock handles, but that's a mistake in and of itself).
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Would be nice to add a comment here already that you're breaking
> compatbility with the qcom,icc.h. It's a bit hidden otherwise.
Right, wouldn't hurt..

> 
>> ---
>>  drivers/interconnect/qcom/icc-rpm.c | 114 ++++++++++++++++++++----------------
>>  drivers/interconnect/qcom/icc-rpm.h |  13 ++--
>>  drivers/interconnect/qcom/msm8996.c |   1 -
>>  drivers/interconnect/qcom/sdm660.c  |   1 -
>>  4 files changed, 66 insertions(+), 63 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>> index b8ecf9538ab9..5ffcf5ca8914 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.c
>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>> @@ -49,7 +49,7 @@
>>  #define NOC_QOS_MODE_FIXED_VAL		0x0
>>  #define NOC_QOS_MODE_BYPASS_VAL		0x2
>>  
>> -#define ICC_BUS_CLK_MIN_RATE		19200000ULL
>> +#define ICC_BUS_CLK_MIN_RATE		19200ULL /* kHz */
>>  
>>  static int qcom_icc_set_qnoc_qos(struct icc_node *src)
>>  {
>> @@ -338,11 +338,10 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>>  	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL;
>>  	struct icc_provider *provider;
>>  	u64 sum_bw;
>> -	u64 rate;
>> +	u64 active_rate, sleep_rate;
>>  	u64 agg_avg[QCOM_ICC_NUM_BUCKETS], agg_peak[QCOM_ICC_NUM_BUCKETS];
>>  	u64 max_agg_avg;
>> -	int ret, i;
>> -	int bucket;
>> +	int ret;
>>  
>>  	src_qn = src->data;
>>  	if (dst)
>> @@ -364,49 +363,54 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>>  			return ret;
>>  	}
>>  
>> -	for (i = 0; i < qp->num_bus_clks; i++) {
>> -		/*
>> -		 * Use WAKE bucket for active clock, otherwise, use SLEEP bucket
>> -		 * for other clocks.  If a platform doesn't set interconnect
>> -		 * path tags, by default use sleep bucket for all clocks.
>> -		 *
>> -		 * Note, AMC bucket is not supported yet.
>> -		 */
>> -		if (!strcmp(qp->bus_clks[i].id, "bus_a"))
>> -			bucket = QCOM_ICC_BUCKET_WAKE;
>> -		else
>> -			bucket = QCOM_ICC_BUCKET_SLEEP;
>> -
>> -		rate = icc_units_to_bps(max(agg_avg[bucket], agg_peak[bucket]));
>> -		do_div(rate, src_qn->buswidth);
>> -		rate = min_t(u64, rate, LONG_MAX);
>> -
>> -		/*
>> -		 * Downstream checks whether the requested rate is zero, but it makes little sense
>> -		 * to vote for a value that's below the lower threshold, so let's not do so.
>> -		 */
>> -		if (bucket == QCOM_ICC_BUCKET_WAKE && qp->keep_alive)
>> -			rate = max(ICC_BUS_CLK_MIN_RATE, rate);
>> -
>> -		if (qp->bus_clk_rate[i] == rate)
>> -			continue;
>> -
>> -		ret = clk_set_rate(qp->bus_clks[i].clk, rate);
>> -		if (ret) {
>> -			pr_err("%s clk_set_rate error: %d\n",
>> -			       qp->bus_clks[i].id, ret);
>> +	/* Some providers don't have a bus clock to scale */
>> +	if (!qp->bus_clk_desc && !qp->bus_clk)
>> +		return 0;
>> +
>> +	/* Intentionally keep the rates in kHz as that's what RPM accepts */
>> +	active_rate = max(agg_avg[QCOM_SMD_RPM_ACTIVE_STATE],
>> +			  agg_peak[QCOM_SMD_RPM_ACTIVE_STATE]);
>> +	do_div(active_rate, src_qn->buswidth);
>> +
>> +	sleep_rate = max(agg_avg[QCOM_SMD_RPM_SLEEP_STATE],
>> +			 agg_peak[QCOM_SMD_RPM_SLEEP_STATE]);
>> +	do_div(sleep_rate, src_qn->buswidth);
>> +
>> +	/*
>> +	 * Downstream checks whether the requested rate is zero, but it makes little sense
>> +	 * to vote for a value that's below the lower threshold, so let's not do so.
>> +	 */
>> +	if (qp->keep_alive)
>> +		active_rate = max(ICC_BUS_CLK_MIN_RATE, active_rate);
>> +
>> +	/* Some providers have a non-RPM-owned bus clock - convert kHz->Hz for the CCF */
>> +	if (qp->bus_clk) {
>> +		active_rate = max_t(u64, active_rate, sleep_rate);
>> +		/* ARM32 caps clk_set_rate arg to u32.. Nothing we can do about that! */
>> +		active_rate = min_t(u64, 1000ULL * active_rate, ULONG_MAX);
>> +		return clk_set_rate(qp->bus_clk, active_rate);
>> +	}
>> +
>> +	/* RPM only accepts <=INT_MAX rates */
>> +	active_rate = min_t(u32, active_rate, INT_MAX);
>> +	sleep_rate = min_t(u32, sleep_rate, INT_MAX);
>> +
>> +	if ((active_rate != qp->bus_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE]) ||
>> +	    (sleep_rate != qp->bus_clk_rate[QCOM_SMD_RPM_SLEEP_STATE])) {
>> +		ret = qcom_icc_rpm_set_bus_rate(qp->bus_clk_desc,
>> +						active_rate,
>> +						sleep_rate);
>> +		if (ret)
>>  			return ret;
> 
> Hm, do we have to set both rates together in all cases? If cpufreq is
> quickly changing frequencies (and therefore active-only ICC bandwidths)
> it should be sufficient to make one call into RPM and leave the sleep
> rate as-is. Especially because you already cache the two rates
> separately.
> 
> AFAICT downstream updates the contexts completely separately, so I don't
> think it updates both rates at once either. And actually even the old
> code before this patch didn't do that :D
Right, I can trivially solve that by making qcom_icc_rpm_set_bus_rate
accept an is_active parameter..

Konrad 
> 
> Thanks,
> Stephan
