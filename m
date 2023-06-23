Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B242973B902
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjFWNqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjFWNqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:46:13 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CFB296C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:45:46 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f122ff663eso822808e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687527943; x=1690119943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CG/L5fCcL7PugjOiD8VAGfzqZ5AV8spPcF/+MHEpizc=;
        b=JgnrBgJTH8r9UwKtq/t9/7Oi9fcEDKiRWPJoksmFlGffyYpNBC+4PpUlxI5wutnRMR
         oF2NJbXJBiUxqWUG1/Ut3T02e2R4x9QCVJHRT3B1eRVn7fj7GhMef6JU/uYPKbptl1KA
         5d1HYQjTZYnL/G/pgBLh8mIUfJqmzTxNm2fL195TyYKXPNrS8rhgGVHKI3DDrsEPsOP+
         n/J4BF+aVuwo0UWpA/VQKeGTFgDqqGzMSLYYnZ0MWH36/icuTWu7d/cXyidUIYt3WiML
         Z+ypYsAp6EBf7hj6SCuFf7gtZfxHDroviFaIKAhO2RoHs6u6z2Q1u2gUBv24sFvz36i5
         Dnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687527943; x=1690119943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CG/L5fCcL7PugjOiD8VAGfzqZ5AV8spPcF/+MHEpizc=;
        b=cU8NtUTjPS7cfG2LM9zT//3bIh4rX2vh/DO42IChLRz0LEvupcWDQIsa9EOakV9wds
         l5b0Xl/T5ZxD9qeNtFq9i1/g6Yjs5xKXpRv7V1+WkA+aid1qNY6iG6Qh2KNVyOZZPR2/
         EAL7GV4mGTF+LLIcbbvjnlMysJUVGApJ/GUm6kLezXPvpHP9AQlGLmd6/4RGa/2flSSC
         pDOPVkY4Kyz4Ut3i4hiK/TEtxDbnFp0X9N8gfTRzwnKuB1r3a2gnAe5CbdW0xuuWxBto
         /zXSBg/xsPUpcpE39egpsSgMHEeMfLC8/nlPueid4foFVB3O+LlLz3REFxyEuyb40zHd
         PUuA==
X-Gm-Message-State: AC+VfDxi7+A89q4AhRR338raRqiRcs9MTrMEw5cgPgw9M3vX2aFDZrHm
        ZC+rU780qvdQXInIInExEJ/cRw==
X-Google-Smtp-Source: ACHHUZ40Rmt0bQ6tFBgxMHDz3EIeoFE2P2zGcudX3YjsMnKPoegGaAcdTpd5fvMVdW+M2iYNeBFdZQ==
X-Received: by 2002:a05:6512:2205:b0:4f9:69b8:1e6d with SMTP id h5-20020a056512220500b004f969b81e6dmr3371663lfu.3.1687527943566;
        Fri, 23 Jun 2023 06:45:43 -0700 (PDT)
Received: from [192.168.1.101] (abyk30.neoplus.adsl.tpnet.pl. [83.9.30.30])
        by smtp.gmail.com with ESMTPSA id q30-20020ac2515e000000b004f1383d57ecsm1437980lfd.202.2023.06.23.06.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 06:45:43 -0700 (PDT)
Message-ID: <e1e82967-f2d5-48f9-80ba-2dafbac554c9@linaro.org>
Date:   Fri, 23 Jun 2023 15:45:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/4] interconnect: qcom: Add support for mask-based
 BCMs
Content-Language: en-US
To:     neil.armstrong@linaro.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Tipton <mdtipton@codeaurora.org>
References: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-0-709474b151cc@linaro.org>
 <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-1-709474b151cc@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-1-709474b151cc@linaro.org>
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

On 23.06.2023 14:50, neil.armstrong@linaro.org wrote:
> From: Mike Tipton <mdtipton@codeaurora.org>
> 
> Some BCMs aren't directly associated with the data path (i.e. ACV) and
> therefore don't communicate using BW. Instead, they are simply
> enabled/disabled with a simple bit mask. Add support for these.
> 
> Origin commit retrieved from:
> https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/commit/2d1573e0206998151b342e6b52a4c0f7234d7e36
> 
> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
> [narmstrong: removed copyright change from original commit]
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/interconnect/qcom/bcm-voter.c | 5 +++++
>  drivers/interconnect/qcom/icc-rpmh.h  | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
> index 8f385f9c2dd3..d5f2a6b5376b 100644
> --- a/drivers/interconnect/qcom/bcm-voter.c
> +++ b/drivers/interconnect/qcom/bcm-voter.c
> @@ -83,6 +83,11 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
>  
>  		temp = agg_peak[bucket] * bcm->vote_scale;
>  		bcm->vote_y[bucket] = bcm_div(temp, bcm->aux_data.unit);
> +
> +		if (bcm->enable_mask && (bcm->vote_x[bucket] || bcm->vote_y[bucket])) {
> +			bcm->vote_x[bucket] = 0;
> +			bcm->vote_y[bucket] = bcm->enable_mask;
> +		}
>  	}
>  
>  	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
> diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
> index 04391c1ba465..7843d8864d6b 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.h
> +++ b/drivers/interconnect/qcom/icc-rpmh.h
> @@ -81,6 +81,7 @@ struct qcom_icc_node {
>   * @vote_x: aggregated threshold values, represents sum_bw when @type is bw bcm
>   * @vote_y: aggregated threshold values, represents peak_bw when @type is bw bcm
>   * @vote_scale: scaling factor for vote_x and vote_y
> + * @enable_mask: optional mask to send as vote instead of vote_x/vote_y
>   * @dirty: flag used to indicate whether the bcm needs to be committed
>   * @keepalive: flag used to indicate whether a keepalive is required
>   * @aux_data: auxiliary data used when calculating threshold values and
> @@ -97,6 +98,7 @@ struct qcom_icc_bcm {
>  	u64 vote_x[QCOM_ICC_NUM_BUCKETS];
>  	u64 vote_y[QCOM_ICC_NUM_BUCKETS];
>  	u64 vote_scale;
> +	u32 enable_mask;
>  	bool dirty;
>  	bool keepalive;
>  	struct bcm_db aux_data;
> 
