Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4194D72AE1D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 20:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjFJS2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 14:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjFJS22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 14:28:28 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184FE30D2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 11:28:26 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1c30a1653so32081121fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 11:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686421704; x=1689013704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TyzR9JQPltEJ2GJHuJYpmnHMC8wOXLunYdfke4NYE4w=;
        b=EcYR44CVGwjd66FBvHukTDKxl9SKdFqCmTFoTRvs9LsX0qV9PssdKNMIlMX8HMFt7S
         ewN0skVU7Ca9dsoon3DQgJBD3+iqV6lu4/jFNdO0t3rmtLiMQfyXe4+Tz8j8KWhDTKGj
         Bodk89xZW4bHOrQghCHnBubuUJRYWv70oTqaBqEh0yucNEmtp/nISbNRXqvW3uhMXrua
         8rU62O9icCL4sWdgVmqtxjniZMc4DsASQ5AKKndhcn9XlLx98FxtQ7Uzo1lMFdzqmnVz
         f0lgt64ugIpFxT0dFUY6emKyOl+jYS12HeosgQPuoFylYLto5PXxxmwPvEdNwbgChCKe
         wUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686421704; x=1689013704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TyzR9JQPltEJ2GJHuJYpmnHMC8wOXLunYdfke4NYE4w=;
        b=dXxaXanwrbCckbrLf/YLDp25LB7fqvW0WjNuC3UjZuzQCXauNWv7l8hd2tluDzw3zU
         bjYH4L0JGVT3dpZ19vnnzLQQStA+GbMyWB95xLT68pncKjvK9NVS7hhe2vXDTspCOU0R
         H47PCgog0iERRIS7rpjxZnufKx7cHkX6ugKcR7G8mPs45zlNxKL5aKNXrGMYt+3NBJLf
         uoc9c9Q1DZb6iICUvK6p2BRg4Lb5hjPWMGHFkUzOJCCnz9Nj2qXk9FuVTuznb0SKr440
         fL9TH3X38/krLper7/9DBjWWU3sE8ZXa2pk/3kwWhzWH3N/uMpd1Mhs3wFZCO1U9NgBr
         x+DQ==
X-Gm-Message-State: AC+VfDzLjh5sjBkNJT8FjGcdFNT7kT/pyxJjNoerEgUDnq+AGFS7pf5B
        VVtC3effdR6vEkgxnXJd7X0DSgIrZ52MhrCuSII=
X-Google-Smtp-Source: ACHHUZ6e+6jU119Cl/DhehI15gLw2xwLhfpwuoyWIygcorio5vPFgUBytS2gZ/w9BUfmJ5qiowAa1A==
X-Received: by 2002:a19:671a:0:b0:4f1:458c:c4c with SMTP id b26-20020a19671a000000b004f1458c0c4cmr1950029lfc.43.1686421704210;
        Sat, 10 Jun 2023 11:28:24 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id u25-20020a056512041900b004f629e7689asm919670lfk.135.2023.06.10.11.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 11:28:23 -0700 (PDT)
Message-ID: <e9855fca-cd90-202f-aab3-caa323c33ec0@linaro.org>
Date:   Sat, 10 Jun 2023 20:28:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 20/22] interconnect: qcom: icc-rpm: Set bandwidth on
 both contexts
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
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
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
 <20230526-topic-smd_icc-v2-20-e5934b07d813@linaro.org>
 <ZIS6LK2lnlnNygX7@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZIS6LK2lnlnNygX7@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.06.2023 20:00, Stephan Gerhold wrote:
> On Fri, Jun 09, 2023 at 10:19:25PM +0200, Konrad Dybcio wrote:
>> Up until now, for some reason we've only been setting bandwidth values
>> on the active-only context. That pretty much meant that RPM could lift
>> all votes when entering sleep mode. Or never sleep at all.
>>
>> That in turn could potentially break things like USB wakeup, as the
>> connection between APSS and SNoC/PNoC would simply be dead.
>>
> 
> Nitpick: Apparently an "active" vote is applied during both active+sleep
> until the first "sleep" vote is sent. It's documented only for
> regulators [1] but I would expect the same applies to the bandwidths.
> This means actual breakage shouldn't have been possible.
..unless some part of the boot chain voted for the sleep set!

I'm not sure whether the regulator comment also holds for bw, but I
also don't really have a great way to check it.. Would you want me to
alter this commit message somehow?

Konrad
> 
> The patch itself is still the right thing to do to have the sleep state
> correct during deep cpuidle/suspend.
> 
> [1]: https://git.codelinaro.org/clo/la/kernel/msm-3.10/-/blob/LA.BR.1.2.9.c26-04700-8x09.0/drivers/regulator/rpm-smd-regulator.c#L199-209
> 
>> Set the values appropriately.
>>
>> Fixes: 30c8fa3ec61a ("interconnect: qcom: Add MSM8916 interconnect provider driver")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/interconnect/qcom/icc-rpm.c | 54 +++++++++++++++++++------------------
>>  1 file changed, 28 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>> index 3ac47b818afe..ac719013077e 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.c
>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>> @@ -205,34 +205,39 @@ static int qcom_icc_qos_set(struct icc_node *node)
>>  	}
>>  }
>>  
>> -static int qcom_icc_rpm_set(struct qcom_icc_node *qn, u64 sum_bw)
>> +static int qcom_icc_rpm_set(struct qcom_icc_node *qn, u64 *bw)
>>  {
>> -	int ret = 0;
>> +	int ret, rpm_ctx = 0;
>> +	u64 bw_bps;
>>  
>>  	if (qn->qos.ap_owned)
>>  		return 0;
>>  
>> -	if (qn->mas_rpm_id != -1) {
>> -		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
>> -					    RPM_BUS_MASTER_REQ,
>> -					    qn->mas_rpm_id,
>> -					    sum_bw);
>> -		if (ret) {
>> -			pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
>> -			       qn->mas_rpm_id, ret);
>> -			return ret;
>> +	for (rpm_ctx = 0; rpm_ctx < QCOM_SMD_RPM_STATE_NUM; rpm_ctx++) {
>> +		bw_bps = icc_units_to_bps(bw[rpm_ctx]);
>> +
>> +		if (qn->mas_rpm_id != -1) {
>> +			ret = qcom_icc_rpm_smd_send(rpm_ctx,
>> +						    RPM_BUS_MASTER_REQ,
>> +						    qn->mas_rpm_id,
>> +						    bw_bps);
>> +			if (ret) {
>> +				pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
>> +				qn->mas_rpm_id, ret);
>> +				return ret;
>> +			}
>>  		}
>> -	}
>>  
>> -	if (qn->slv_rpm_id != -1) {
>> -		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
>> -					    RPM_BUS_SLAVE_REQ,
>> -					    qn->slv_rpm_id,
>> -					    sum_bw);
>> -		if (ret) {
>> -			pr_err("qcom_icc_rpm_smd_send slv %d error %d\n",
>> -			       qn->slv_rpm_id, ret);
>> -			return ret;
>> +		if (qn->slv_rpm_id != -1) {
>> +			ret = qcom_icc_rpm_smd_send(rpm_ctx,
>> +						    RPM_BUS_SLAVE_REQ,
>> +						    qn->slv_rpm_id,
>> +						    bw_bps);
>> +			if (ret) {
>> +				pr_err("qcom_icc_rpm_smd_send slv %d error %d\n",
>> +				qn->slv_rpm_id, ret);
>> +				return ret;
>> +			}
>>  		}
>>  	}
>>  
>> @@ -337,7 +342,6 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>>  	struct qcom_icc_provider *qp;
>>  	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL;
>>  	struct icc_provider *provider;
>> -	u64 sum_bw;
>>  	u64 active_rate, sleep_rate;
>>  	u64 agg_avg[QCOM_SMD_RPM_STATE_NUM], agg_peak[QCOM_SMD_RPM_STATE_NUM];
>>  	u64 max_agg_avg;
>> @@ -351,14 +355,12 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>>  
>>  	qcom_icc_bus_aggregate(provider, agg_avg, agg_peak, &max_agg_avg);
>>  
>> -	sum_bw = icc_units_to_bps(max_agg_avg);
>> -
>> -	ret = qcom_icc_rpm_set(src_qn, sum_bw);
>> +	ret = qcom_icc_rpm_set(src_qn, agg_avg);
>>  	if (ret)
>>  		return ret;
>>  
>>  	if (dst_qn) {
>> -		ret = qcom_icc_rpm_set(dst_qn, sum_bw);
>> +		ret = qcom_icc_rpm_set(dst_qn, agg_avg);
>>  		if (ret)
>>  			return ret;
>>  	}
>>
>> -- 
>> 2.41.0
>>
