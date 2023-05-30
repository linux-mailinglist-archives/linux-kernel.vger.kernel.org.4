Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79C9715EC7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjE3MQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjE3MQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:16:36 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45850F1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:16:30 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f3b9e54338so5009492e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685448988; x=1688040988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5uD3+suOcpbgdqFW0GkZogqfSEcYKxt6e0zHCfxECmw=;
        b=ohYB0D566NjRxX69H7xtKhz+iJYxu/BY3KPkHmrLerOmX1LD9eNiMaP25GIX5MtoYL
         c5nYyGwieNiS0xryV4M77yzPPLXUD5Z36v1q0cbmW1mXhi7I10m0ymgZLa65vrb3M2yV
         BWBTmpavyt9XFbiIjGz/N/pL501nqIdt85denSxKP/KVyYSydL+kLxqZ7EtcM644bhDN
         B1EDVjCjAjnr6h2J5rNlppthY7iCGzQ21xfGkO9CWwCaZNmMLLDE7hY2bupycclQl5NP
         U+aU/D+lX643viWDe6RM5E9FIRyHk7i7XAoumRShkST+neoZFPh5gjJkjHu2+uQfLPh+
         TCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685448988; x=1688040988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uD3+suOcpbgdqFW0GkZogqfSEcYKxt6e0zHCfxECmw=;
        b=T2ujZpHMdOEY1cU3AZyvqe3VckDkVh9FLU943rqefU9om1pLeKm2rGL8weWeSCXbEd
         67EVw9Qub7gJ2VFewKEghcQCyLaiU/pYLcnOYTbKwSi7mBX+KqoHSJT7x5frWG3vro/f
         kEbpEbpS7oZafcdViBgdbl2fdORyQJf+LTKVtxXi+9f6hKaOcMf9FpuWQQ6g7edSYESn
         4y4y/8oIiu2Yey+HG+o0S5AuSFaRZJ8dZ1rZZOYhlymPtGlPmIa2jA/85Gv8j8JcvIOq
         5B4jv+SRKoGWN9nwtobDpa6lAQqfJ/jOCQRSxA76DE7d9uRSjUHPPOvMY1PVtiR7eETp
         k60A==
X-Gm-Message-State: AC+VfDyWI0VwkYiJXir9hTlpUDJEmVQieyAweQwwtvuYJD/kj7nTSJt8
        tOCC7m7rnCIHeSp/xzMODE9ooA==
X-Google-Smtp-Source: ACHHUZ6Ww0h+GaMyC1dkoIaj9nYT0oX8YdJ01HzwsJyaD9FCIelgw3F49GrnRv0+ct/oXUCi81jKUA==
X-Received: by 2002:ac2:4473:0:b0:4f4:c32f:2a86 with SMTP id y19-20020ac24473000000b004f4c32f2a86mr671461lfl.33.1685448988344;
        Tue, 30 May 2023 05:16:28 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id u11-20020ac243cb000000b004efedad4604sm328571lfl.18.2023.05.30.05.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 05:16:27 -0700 (PDT)
Message-ID: <e1a38af8-2b48-1e47-e400-3cd9d17efa3b@linaro.org>
Date:   Tue, 30 May 2023 14:16:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 20/20] interconnect: qcom: Divide clk rate by src node bus
 width
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
 <20230526-topic-smd_icc-v1-20-1bf8e6663c4e@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-20-1bf8e6663c4e@linaro.org>
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

Note: the commit title is wrong (src -> dst obviously).
Thanks Stephan for spotting this.

Konrad

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
