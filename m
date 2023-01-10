Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5247665006
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjAJXok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjAJXof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:44:35 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F113E846
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:44:33 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j16-20020a05600c1c1000b003d9ef8c274bso6983367wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FL35cw0DN4NCwEaaH0VkgM1rt8C/x8Q1esalPn3+uWA=;
        b=fGMBUDIGdRdL9rrgUn+hQnEvQ2ypYgF+rca0EAGqJddK4v0tcV/YeTbcq0V0mhSsrU
         ZqTTeusJwFTB5YtV07szUtdhyAUWPxfObkpZme8tbgaRdLBrtd9EzP2nlsFDDwMLZgMO
         1wrief+e3z0SLbVD096DRJLd/9lf4/LPvhtKUWde11xzLRnDCTWLfj7QnhEScCsz5Lw+
         0DrgQ+b+lyh2scRVILBuOb/DPN0TcOS5GCAgb2j3iv+0qW96ZFA3jAQ2gdZ2t0hs4K1K
         YAhhB7BiXazkZK1/lmS8S54KdP/Vzd3A4WmiypQKIEr/dVK1Qj9ZUsxFTCAcUhV1pP5z
         a3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FL35cw0DN4NCwEaaH0VkgM1rt8C/x8Q1esalPn3+uWA=;
        b=toFtUbV/kmwmry4+cUkIrWgmpb7jNvcSrdvnHj/EcNiwPJSIRGlRkAX62ifeGiNGjm
         Ct8KpqK0zadm1+rmDaP8uzfx8yWg5+bRhrXmPSvM1TxYLah7gRlCxGVLTbpBjic1CLww
         ++L2CXbOTR3FK/ANhrDOc3A2T/dXqi28kOFVSLnIEog+FszkZlNBeTKUVtNHohbi2bUW
         k2jI45KDiREbeTwhkY5O1NJFja1XGiqSXVnXNUaUZeHELtS79vdtUQ0WCCOd8tOzl0Ag
         NSiAd9n8MTmk2Wrwz3XO9gis7uKCjVGqWz8Z30kCDo6JKdaUJ3kwQAc3PcQh6ZymCjmd
         Gb3w==
X-Gm-Message-State: AFqh2kqyMEQmzaBIcApU9bhboOG04kzm925+EdyVwfydSzcwIS4TYRAY
        Drdcc/ge8e9To7VYjfoVvRKsuQ==
X-Google-Smtp-Source: AMrXdXuxG6pR2hD58eix9Jhmq9DEckiQa5rNfBj1EaeQxG/YjFH4fSfiwp1wezaEgqzoMWL2LiqOhg==
X-Received: by 2002:a05:600c:3caa:b0:3d9:cb4c:af5a with SMTP id bg42-20020a05600c3caa00b003d9cb4caf5amr21316924wmb.33.1673394272344;
        Tue, 10 Jan 2023 15:44:32 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id bh13-20020a05600c3d0d00b003d358beab9dsm16225206wmb.47.2023.01.10.15.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 15:44:32 -0800 (PST)
Message-ID: <4a30931b-ef94-df2f-2e89-1028bf9510ce@linaro.org>
Date:   Tue, 10 Jan 2023 23:44:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 04/10] interconnect: qcom: rpm: Add support for
 specifying channel num
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230110132202.956619-1-konrad.dybcio@linaro.org>
 <20230110132202.956619-5-konrad.dybcio@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230110132202.956619-5-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 13:21, Konrad Dybcio wrote:
> Some nodes, like EBI0 (DDR) or L3/LLCC, may be connected over more than
> one channel. This should be taken into account in bandwidth calcualtion,
calculation

> as we're supposed to feed msmbus with the per-channel bandwidth. Add
> support for specifying that and use it during bandwidth aggregation.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/icc-rpm.c | 7 ++++++-
>   drivers/interconnect/qcom/icc-rpm.h | 2 ++
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 0516b74abdc7..3207b4c99d04 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -336,6 +336,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
>   {
>   	struct icc_node *node;
>   	struct qcom_icc_node *qn;
> +	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
>   	int i;
>   
>   	/* Initialise aggregate values */
> @@ -353,7 +354,11 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
>   	list_for_each_entry(node, &provider->nodes, node_list) {
>   		qn = node->data;
>   		for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
> -			agg_avg[i] += qn->sum_avg[i];
> +			if (qn->channels)

when do you actually populate channels ?

I had a quick scan of your series, I didn't see it..

> +				sum_avg[i] = div_u64(qn->sum_avg[i], qn->channels);
> +			else
> +				sum_avg[i] = qn->sum_avg[i];
> +			agg_avg[i] += sum_avg[i];
>   			agg_peak[i] = max_t(u64, agg_peak[i], qn->max_peak[i]);
>   		}
>   	}
> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index 3762648f9d47..eb51680f890d 100644
> --- a/drivers/interconnect/qcom/icc-rpm.h
> +++ b/drivers/interconnect/qcom/icc-rpm.h
> @@ -66,6 +66,7 @@ struct qcom_icc_qos {
>    * @id: a unique node identifier
>    * @links: an array of nodes where we can go next while traversing
>    * @num_links: the total number of @links
> + * @channels: number of channels at this node (e.g. DDR channels)
>    * @buswidth: width of the interconnect between a node and the bus (bytes)
>    * @sum_avg: current sum aggregate value of all avg bw requests
>    * @max_peak: current max aggregate value of all peak bw requests
> @@ -78,6 +79,7 @@ struct qcom_icc_node {
>   	u16 id;
>   	const u16 *links;
>   	u16 num_links;
> +	u16 channels;
>   	u16 buswidth;
>   	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
>   	u64 max_peak[QCOM_ICC_NUM_BUCKETS];

