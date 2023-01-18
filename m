Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CA66728C6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjARTy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjARTy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:54:56 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617FC58983
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:54:55 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id u19so85833796ejm.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PS/7KuaB+IDJ4czpYZHfKfWWHUA84RHoIsTNfT8XuEU=;
        b=S0yIBmB+f/4oFnfqAxjqm9aQJfCPt643cmPeAJKJPeekK2T3v7n5HehsoVvxSE6bU6
         Y7Bg7s+JENwF9NUn2L7RZFzpVypzZaRMOCFOxolI4MU9wCdSvZYVPSKQnQ3nH05aA/84
         qlu+z0GkLuieC2sDWH54TBMrxtjFX3knmLW7FotnDQns8sYrlNMGNpJrgH6omg5QQ8S4
         W8zcVnI5enQv6Oh9l78bEWs5lAVF8Y7bIaQZgg0WvRZwQFUoMY9yWfcuYfKQI31lvRMW
         t8NxgxIyBXVFwA15TebgbIaBGylGv0Wr/kfDtzyw+peIGIfPEmVeQnc6pnc1LCfqTSS0
         eIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PS/7KuaB+IDJ4czpYZHfKfWWHUA84RHoIsTNfT8XuEU=;
        b=L8bJJ9P0nr/mwwGEZmZJbd5A1N+NiMmnFqMhZ4oSST3M1Ww+qFI7GhZkn7cxx60yQH
         zF4rxLCkt35lJ89ZGMLCWzTJAmSS909zzVdCVFInjv7hfGaU4kQD/W9txJT0nqJ7oRPp
         OhWcpXtudE2tsThb7saWc1/oQKbgSjqamhLAStphEpukvfTq6C98zKoLxBmR1R7EIVGQ
         1mlhX9VJfkDfSSmrssJVnWGnrfsu0CKO58Q1OigRb7KHp3qBgMoq5mv4Sr9wGdrtu8KS
         OZJO50/x/2whE3uzTL+QWmZ4mgxwMzn1GzO23mQrmy1ExFkXp7Sm8HBNJ2VtHzb9ReyR
         hdvA==
X-Gm-Message-State: AFqh2krbN+YmBhPWIBxT6uHy0/iT2kmBb/LEXd7mrioEhEuPQzuF+4TF
        5SDy8+c8TEYp7RfxvZTP6I8ftg==
X-Google-Smtp-Source: AMrXdXsTXO2h6sqsyvxXkLtL0jBXFCsyXKu+HZK+lAdfdFRJ7Z+o+GbGbEHYDji0L9trJsJrB6sDew==
X-Received: by 2002:a17:907:1a46:b0:84c:e89e:bb4c with SMTP id mf6-20020a1709071a4600b0084ce89ebb4cmr4063246ejc.49.1674071694016;
        Wed, 18 Jan 2023 11:54:54 -0800 (PST)
Received: from [192.168.1.101] (abxh150.neoplus.adsl.tpnet.pl. [83.9.1.150])
        by smtp.gmail.com with ESMTPSA id f17-20020a170906495100b0086dd8f20a6asm5923513ejt.77.2023.01.18.11.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 11:54:53 -0800 (PST)
Message-ID: <f07bbbb6-3343-19c7-bd94-c8c239f1cbc8@linaro.org>
Date:   Wed, 18 Jan 2023 20:54:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 8/9] interconnect: qcom: rpm: Add a way to always set
 QoS registers
Content-Language: en-US
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, bryan.odonoghue@linaro.org,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230116132152.405535-1-konrad.dybcio@linaro.org>
 <20230116132152.405535-9-konrad.dybcio@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230116132152.405535-9-konrad.dybcio@linaro.org>
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
> On newer SoCs (there's no clear boundary, but probably "new enough"
> means every interconnect provider is either BIMC or QNoC and there
> are no old-style NoC hosts) we're expected to set QoS registers
> regardless of the ap_owned param. Add a bool in the qcom_icc_provider
> and make the logic assume it's okay to set the registers when it's
> set.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
Argh, I only noticed now that this patch is incomplete,
missing setting the value in qnoc_probe() and adding a
similar struct member to qcom_icc_desc..

Konrad
>  drivers/interconnect/qcom/icc-rpm.c | 2 +-
>  drivers/interconnect/qcom/icc-rpm.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 509cadf398e9..343e6021a93a 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -243,7 +243,7 @@ static int __qcom_icc_set(struct icc_node *n, struct qcom_icc_node *qn,
>  	bool vote_ap, vote_rpm;
>  	int ret;
>  
> -	if (qp->type == QCOM_ICC_QNOC) {
> +	if (qp->type == QCOM_ICC_QNOC || qp->always_set_qos) {
>  		vote_ap = true;
>  		vote_rpm = true;
>  	} else {
> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index 729573f0d9fe..3c8888482a39 100644
> --- a/drivers/interconnect/qcom/icc-rpm.h
> +++ b/drivers/interconnect/qcom/icc-rpm.h
> @@ -28,6 +28,7 @@ enum qcom_icc_type {
>   * @type: the ICC provider type
>   * @regmap: regmap for QoS registers read/write access
>   * @qos_offset: offset to QoS registers
> + * @always_set_qos: whether to always set QoS registers regardless of bus type
>   * @bus_clk_rate: bus clock rate in Hz
>   * @bus_clks: the clk_bulk_data table of bus clocks
>   * @intf_clks: the clk_bulk_data table of interface clocks
> @@ -39,6 +40,7 @@ struct qcom_icc_provider {
>  	enum qcom_icc_type type;
>  	struct regmap *regmap;
>  	unsigned int qos_offset;
> +	bool always_set_qos;
>  	u64 bus_clk_rate[2];
>  	struct clk_bulk_data bus_clks[2];
>  	struct clk_bulk_data intf_clks[];
