Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74357350B1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjFSJpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFSJpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:45:11 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B751A4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:45:09 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f849a0e371so3971352e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687167908; x=1689759908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVP/pUDXtLdUgoAxy1tfvAzLhw5MZG/sIJ+AbfxkcTY=;
        b=QGXoqIdMO+enjF727yqG2zusjrFhlifxAoGCITnJJfQhHq35L3YiZD/4qcYnnb99mb
         TlzgStRwvsFoivNO69ub5C/jqDT1WLDTrvNBJFFvgn5ZI0dlLQjGqh+1CqwToXkh+da3
         yirpTpZdjMxtyU29t6y3Jmak3Pgj/+gT66ahxoANPgJcq/s3DmSAx6r82WBrTTLbrgRp
         vq8Up40HiZLO+nACVkyK1eyHT8PDFurHE1tmi/PA8dI5ItNADiEu486Z6x8u/en8wcJX
         L7gDIsf6pZ7dyM+gohfi02O1rtu4W091uAq6hqJx7mjr/JyXNufQiCuSNBiqlXDZjXYX
         wOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687167908; x=1689759908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVP/pUDXtLdUgoAxy1tfvAzLhw5MZG/sIJ+AbfxkcTY=;
        b=ALLXEgZRUxcomyryy3oYWWumc7exuHbf8iRhF0bOn/qkXubImhWJHKOSEweJ/0nuHS
         q3e05JeT9oHkMwnNs30byTbyFxWquR2WLaYekJ51K4+EsAWq/THnJKAzko8G6hCu5WeP
         qIj8KmgFOZmuFyqiw5GwcSCKYTwJjRaWxSlKKuqLc3skPxBsOfDz60DClKr1KD7ep8Hk
         +SzLR2FSCjBQbEkBbe7iaC1mFeQmz89u2jAajmAo7uDgIqPtJW5IL/+TEngFvX34r0uQ
         em7S65T45QjYimTUIYdaY8ELsb0IpBuAN6dxSMN68OLvSZs0lyT1OYRDhpRoAPMsWWi0
         8yCQ==
X-Gm-Message-State: AC+VfDzoZY8IWmBb2zivfo3Zv0bGbwirMFLmEKFZ2vPFnm8Vqdz7uQ3r
        PnQ/9ghb1oiIgJZyorP1ldQr/Q==
X-Google-Smtp-Source: ACHHUZ7mo2jbiTXNbEp1T4Qh05oNT1imtkieFd0Ropw/bbl2lsEraDw4RZ56MIGDHwhiaGdmxwnevw==
X-Received: by 2002:a05:6512:2f4:b0:4f8:57c2:3936 with SMTP id m20-20020a05651202f400b004f857c23936mr4407428lfq.26.1687167907672;
        Mon, 19 Jun 2023 02:45:07 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id b6-20020ac25e86000000b004f842e58d08sm1886506lfq.84.2023.06.19.02.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 02:45:07 -0700 (PDT)
Message-ID: <9e890ca0-396d-fb97-a7d5-db13b8fdbb92@linaro.org>
Date:   Mon, 19 Jun 2023 11:45:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] interconnect: qcom: rpmh: add optional mask to send
 as vote
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v1-0-66663c0aa592@linaro.org>
 <20230619-topic-sm8550-upstream-interconnect-mask-vote-v1-1-66663c0aa592@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v1-1-66663c0aa592@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.06.2023 10:24, Neil Armstrong wrote:
> On the SM8550 SoC, some nodes requires a specific bit mark
> instead of a bandwidth when voting.
> 
> Add an enable_mask variable to be used to vote when a node
> is enabled in an aggregate loop.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Would be nice to mention that it's literally this commit:

https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/commit/2d1573e0206998151b342e6b52a4c0f7234d7e36

For the code:

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
