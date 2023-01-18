Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFF4672986
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjARUhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjARUgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:36:48 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8AF60490
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:36:39 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id bk15so203592ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LL1I4GwHYHunE20Z1xOXGvvtulphoBZMPu7mQcoTDjU=;
        b=lVq0ApR7wpNjKYW+Y7W2kWZdE7dAbMEcdxD/z/duwXqDArTknD/x1iMrLDR9BRFywZ
         nTkHZ6C+NL55NZOtp8YnWr5ma4BDNr9E8HXi9IEAgqxKVbbC+O1q0zjy7yTCBS+S6jXh
         FequP/8M+mjc55qCEu97QPr83gLvIJhuGTILnyA4j3BXy3GJRXHgQCvphSDeGIo+RrGG
         w28ez2s3kK1I4xYqIwj+Qj5wvxQqGlBzMv/4Sm6Asqxy/9zj47M2gcWTejQ1oFUVD5sH
         +HzK7QUzb24f6O2RNsGjO99JNtjJl73x5oY+oDSGCLc3FWRXqqgH2iR8e3siPYuv+Mgz
         vWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LL1I4GwHYHunE20Z1xOXGvvtulphoBZMPu7mQcoTDjU=;
        b=jOmxs/QJPZK41J/XIzzdhbGfhT7pnjm7NuqbLLyeN2T5l8BhD2eAShmgrpu7TTQ3KW
         eYWQ3G859nu3SQa5f9RpgyhYcYxjoJOevDrwXGCrWMkk1HwEk4H3Ezd7maImkd1Agwlf
         nO6V6ZnDbKpv9k5zbwxsrijENo4dUk/ZDwkq0gKywBWZVRk/SOYAbGbgP27iDCDGtJxy
         qd2n3aI6a/gTWOeVA+YyCOAQpKN3qx2pypZW/QGKbYlm41a/Xve+8upy8mEWAPy+fbk0
         aoHYEdZeSKnS+PvvhHTbH5oHhED7Mnsn+XUMkVTt+LVcc0NkDXpxG9HxGdQS1FsnjiHk
         J10Q==
X-Gm-Message-State: AFqh2kq02AAz5sNdyfIsR2t9MewyB9mc5XZw9w78sqK7yG+TfwTYPoxH
        KCD9eyLXKrUADQt4IDeecwNpNQ==
X-Google-Smtp-Source: AMrXdXsfUbRWYZbFT1n/j0VlmXtzaOPqFjXEhtYouuqtX8fD8Cyl5LNeGNI5+eJ4j8vqMxFUTaK4eA==
X-Received: by 2002:a17:906:80d:b0:870:d15a:c2e0 with SMTP id e13-20020a170906080d00b00870d15ac2e0mr7826142ejd.51.1674074198540;
        Wed, 18 Jan 2023 12:36:38 -0800 (PST)
Received: from [192.168.1.101] (abxh150.neoplus.adsl.tpnet.pl. [83.9.1.150])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090618aa00b0084d14646fd9sm14993594ejf.165.2023.01.18.12.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 12:36:38 -0800 (PST)
Message-ID: <8673ef49-a37e-2d76-b800-bf9b10875006@linaro.org>
Date:   Wed, 18 Jan 2023 21:36:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/9] interconnect: qcom: rpm: Always set QoS params on
 QNoC
Content-Language: en-US
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, bryan.odonoghue@linaro.org,
        Georgi Djakov <djakov@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
References: <20230116132152.405535-1-konrad.dybcio@linaro.org>
 <20230116132152.405535-3-konrad.dybcio@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230116132152.405535-3-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.01.2023 14:21, Konrad Dybcio wrote:
> On newer SoCs, QoS parameters and RPM bandwidth requests are wholly
> separate. Setting one should only depend on the description of the
> interconnect node and not whether the other is present. If we don't
> vote through RPM, QoS parameters should be set regardless, as we're
> requesting additional bandwidth by setting the interconnect clock
> rates.
> 
> With NoC (the old-SoC bus type), this is not the case and they are
> mutually exclusive (so, the current upstream logic is correct).
> 
> For BIMC however, newer SoCs expect QoS params to be always set
> (like QNoC) whereas older ones (like MSM8998) hang up completely when
> doing so, hence this will be addressed in the next commit.
> 
> The Fixes tag references the commit in which this logic was added, it
> has since been shuffled around to a different file, but it's the one
> where it originates from.
> 
> Fixes: f80a1d414328 ("interconnect: qcom: Add SDM660 interconnect provider driver")
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
Would be very nice if somebody could test this one in particular
on QCM2290 to make sure it does not regress that SoC..

Shawn, Loic?

Konrad
>  drivers/interconnect/qcom/icc-rpm.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 385a67c20956..b1337f90c975 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -239,15 +239,27 @@ static int qcom_icc_rpm_set(int mas_rpm_id, int slv_rpm_id, u64 sum_bw)
>  static int __qcom_icc_set(struct icc_node *n, struct qcom_icc_node *qn,
>  			  u64 sum_bw)
>  {
> +	struct qcom_icc_provider *qp = to_qcom_provider(n->provider);
> +	bool vote_ap, vote_rpm;
>  	int ret;
>  
> -	if (!qn->qos.ap_owned) {
> -		/* send bandwidth request message to the RPM processor */
> +	if (qp->type == QCOM_ICC_QNOC) {
> +		vote_ap = true;
> +		vote_rpm = true;
> +	} else {
> +		vote_ap = qn->qos.ap_owned;
> +		vote_rpm = !vote_ap;
> +	}
> +
> +	if (vote_rpm) {
> +		/* Send bandwidth request message to the RPM processor */
>  		ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
>  		if (ret)
>  			return ret;
> -	} else if (qn->qos.qos_mode != -1) {
> -		/* set bandwidth directly from the AP */
> +	}
> +
> +	if (vote_ap && qn->qos.qos_mode != NOC_QOS_MODE_INVALID) {
> +		/* Set QoS params from the AP */
>  		ret = qcom_icc_qos_set(n, sum_bw);
>  		if (ret)
>  			return ret;
