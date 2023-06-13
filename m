Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D0172EF95
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjFMWkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjFMWkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:40:18 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2133AB5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:40:16 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so7551268e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686696014; x=1689288014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2SJLE4n9hE/ILmBDFAKRk7xeXVExUEd4XwQM6TgQA5M=;
        b=Up6lN2v68+kYZ8sT0l0BahoaWGelgnQhewQZLU3L7Buy4xRbYaAPcBTCRS6movUudf
         CRC+hvqbY1PLoHS7IVrNZ0iIP6AiyzGvO/cLhZqoj+l0Dcb27xqJ2wwxYsTKlPlhgJ+n
         fX03Bw2XFcUjZ8mvMpG87rcQWeeDGlDD2QUZyhnnn4oUSSeuW63KLtl763P72Jk4uMhf
         8FX2RJ1AWXgGyJRbSeoSBjVw5lU/YmWDaXWHcXuVX4yjgLKZr/WStY+d02JozQSR3Jqf
         dpdxg9ZwCip4AdUW9OanCbnS47pPoVEtwhVZRa8ToI5w23Bj9/8VvRb12OVG/bSwZ9Vm
         6ZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686696014; x=1689288014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2SJLE4n9hE/ILmBDFAKRk7xeXVExUEd4XwQM6TgQA5M=;
        b=L7j4aZZr9w4tRmNSE1smUf5e8a/fHYMv7lxLsE2D4M9jHg42dNPWN2tAZwjfRl3moB
         vIKrlWB0zqMeetLoABelQX5MS56dC0jb2GqzEiVJMTOcKp93fu2sVjQoksribnT8cY0F
         VBC5jvS1QZeJOzNiIIucpNTKDcCwANVV/O/WDSw4Kxd8DUz7pLoLvM63epbbDMWb1Rwi
         yTa+uq0JyaYg+s1EbuKj1XkCfDKvjmBbz8pASblfO7HW3O1B1DbU+5U8R5IO10eZ1VcH
         Uk70jvh4KlViISM5ctEeXFOxQz5pTFPUXBRNFuDLfG4uo9hNcrEBu+QqPZBhN1VTl4GM
         VnkQ==
X-Gm-Message-State: AC+VfDz71Chgd1fPRqqblTnrENZNmjFjD6vQ7ZvBIZm2p0JMJyO/SxT9
        D+ucINFxPfjnMfaEwLV5MPRWUw==
X-Google-Smtp-Source: ACHHUZ5+wHRAOkTQe7kfApwRwpoFgapjDD5XJDBtnt5jWThtxMhG0994z4uKrkBq1MWJe3omlwGIyQ==
X-Received: by 2002:a19:9145:0:b0:4f6:4bf6:59a1 with SMTP id y5-20020a199145000000b004f64bf659a1mr6691086lfj.34.1686696013774;
        Tue, 13 Jun 2023 15:40:13 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id k4-20020ac24564000000b004f37aac79f4sm1928103lfm.185.2023.06.13.15.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 15:40:13 -0700 (PDT)
Message-ID: <4417edef-5d4d-e802-69fb-feeeb2304e44@linaro.org>
Date:   Wed, 14 Jun 2023 00:40:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 17/22] interconnect: qcom: icc-rpm: Control bus rpmcc
 from icc
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
References: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
 <20230526-topic-smd_icc-v4-17-5ba82b6fbba2@linaro.org>
 <ZIjTPyOfuVM7S1O1@gerhold.net>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZIjTPyOfuVM7S1O1@gerhold.net>
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



On 13.06.2023 22:36, Stephan Gerhold wrote:
> On Tue, Jun 13, 2023 at 04:03:17PM +0200, Konrad Dybcio wrote:
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
>> abusing bus clock handles or wrongly using the qcom,icc.h binding,
>> but that's a mistake in and of itself).
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/interconnect/qcom/icc-rpm.c | 119 ++++++++++++++++++++----------------
>>  drivers/interconnect/qcom/icc-rpm.h |  13 ++--
>>  drivers/interconnect/qcom/msm8996.c |   1 -
>>  drivers/interconnect/qcom/sdm660.c  |   1 -
>>  4 files changed, 71 insertions(+), 63 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>> index b8ecf9538ab9..f9d0ecba5631 100644
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
>> @@ -364,49 +363,59 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
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
> 
> Realized this by coincidence while playing with the code changes for the
> comment below: This doesn't work as intended similar to the ARM32 cap
> above but it's broken even on ARM64:
> 
> Take this example:
> 
> 	u64 active_rate = 4294967296ULL;
> 	active_rate = min_t(u32, active_rate, INT_MAX);
> 
> This should result into active_rate = INT_MAX.
> But it actually results in rate = 0.
> 
> Why?
> 
> 	min_t(u32, rate, INT_MAX)
> 	= min((u32)rate, (u32)INT_MAX)
> 	= min((u32)4294967296ULL, (u32)INT_MAX)
> 	= min(0, INT_MAX)
> 	= 0
> 
> This needs to be min_t(u64 to work properly :)
Yikes, right!

> 
>> +
>> +	if (active_rate != qp->bus_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE]) {
>> +		ret = qcom_icc_rpm_set_bus_rate(qp->bus_clk_desc, active_rate, true);
>> +		if (ret)
>>  			return ret;
>> -		}
>> -		qp->bus_clk_rate[i] = rate;
>> +
>> +		/* Cache the rate after we've successfully commited it to RPM */
>> +		qp->bus_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE] = active_rate;
>> +	}
>> +
>> +	if (sleep_rate != qp->bus_clk_rate[QCOM_SMD_RPM_SLEEP_STATE]) {
>> +		ret = qcom_icc_rpm_set_bus_rate(qp->bus_clk_desc, sleep_rate, false);
>> +		if (ret)
>> +			return ret;
>> +
>> +		/* Cache the rate after we've successfully commited it to RPM */
>> +		qp->bus_clk_rate[QCOM_SMD_RPM_SLEEP_STATE] = sleep_rate;
>>  	}
> 
> With my suggestion on the other patch to pass in the ctx/state number
> directly into qcom_icc_rpm_set_bus_rate() I wonder if it would be nicer
> to write as loop similar to the all others.
> 
> It's a bit shorter, although the line wrapping for the keep_alive is
> also more ugly. I leave it up to you :)
> 
> Not even compile tested this time!
I think it's more obvious when it's explicit for just two contexts.

Konrad
> 
> Thanks,
> Stephan
> 
> 	/*
> 	 * Downstream checks whether the requested rate is zero, but it makes little sense
> 	 * to vote for a value that's below the lower threshold, so let's not do so.
> 	 */
> 	if (qp->keep_alive)
> 		agg_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE]
> 			= max(ICC_BUS_CLK_MIN_RATE, agg_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE]);
> 
> 	/* Some providers have a non-RPM-owned bus clock - convert kHz->Hz for the CCF */
> 	if (qp->bus_clk) {
> 		rate = max_t(u64, agg_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE],
> 			     agg_clk_rate[QCOM_SMD_RPM_SLEEP_STATE]);
> 		/* ARM32 caps clk_set_rate arg to u32.. Nothing we can do about that! */
> 		reate = min_t(u64, 1000ULL * rate, ULONG_MAX);
> 		return clk_set_rate(qp->bus_clk, rate);
> 	}
> 
> 	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
> 		/* RPM only accepts <=INT_MAX rates */
> 		rate = min_t(u64, active_rate, INT_MAX);
> 		if (rate == qp->bus_clk_rate[i])
> 			continue;
> 
> 		ret = qcom_icc_rpm_set_bus_rate(qp->bus_clk_desc, rate, i);
> 		if (ret)
> 			return ret;
> 
> 		/* Cache the rate after we've successfully commited it to RPM */
> 		qp->bus_clk_rate[i] = rate;
> 	}
