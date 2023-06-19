Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B3D7350C9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjFSJrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjFSJrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:47:16 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B943AE42
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:47:03 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f9b37cd58bso3069985e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687168022; x=1689760022;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F/XqReijeUR7u77F+xNxSXnKlJ8Sk3U/SIuLR8Eb+eg=;
        b=xQtDKwlGdSe8x4Jz/l1Bcp+K3e62KXA3mfaWmVyUDSK0+ggvY63c0AGbwjf9UPqOHi
         wuxc3ZUYjsm1XJ0IX2DHjB+4b+cbkoUWvKYeuRWNRztBRZXLhDpyd1AVgJ9/N2gS3uLZ
         +7O4y2A21PlO4rRCoFeT5n3EnjPE8g80qmzb2TCvnsbPCEQdLj5yfAzwLE2W7WZk38K4
         KIJuIgmN2Wu6HtgFp0MRuBo1Er2t/ZllyIZMX+6xJsE2fasnBv6XiOOexpHwcFJ6YAjf
         +F/aPTU2zlDjJhYSRCHhurHUNboHcjUbk7rn6yG2emi/MUs71kdKK3PqXOT4UfTwNhFl
         fzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687168022; x=1689760022;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/XqReijeUR7u77F+xNxSXnKlJ8Sk3U/SIuLR8Eb+eg=;
        b=Yk49cduJs99ngosZhcGR/2q3uJ7TDp7682o6MkIB/Kn35F+sQPnZR2S7z/G4KQEZZB
         SV//TKnj+TbCtFcKXiNvcL9b9F+z0EsgcmdDBhysjwm4PrVBz8SA6h5MkTyYbBaGLdcz
         JGA0wwkEjP5nz9TLtI4bNmkRxSmihflpCt4KPSAHyaYRRVg1vMPIWE1btWhYBhRBy1BP
         /aCu9MkwlJXpO/uroF3f7hiJ4xQOoLKp+w0LJMbhLMNPxo34Itqbm7e/htqO2j6Rv/sl
         L6mzpwRAQJeTk4kI+MyQrIAssmbtdwq4ruyE1CuDdwG/Ls5AnqcQRd3fX9y34C9YQWl6
         asKw==
X-Gm-Message-State: AC+VfDzDAbMxQjly2+5zCmApHa74OdALxF16fiKymuIuggWVGTzEwC5i
        NALn/woJrIV7ezfk5u2xC3M80A==
X-Google-Smtp-Source: ACHHUZ46nHZHoQQyoNt4lSkFcuT/C3/X5ZfC54XPpGfLLhsSTAjnMLTO90y7Qdhf6ybQJ2+QBuIatQ==
X-Received: by 2002:a7b:ce99:0:b0:3f9:b06a:edb4 with SMTP id q25-20020a7bce99000000b003f9b06aedb4mr1520185wmj.35.1687168022185;
        Mon, 19 Jun 2023 02:47:02 -0700 (PDT)
Received: from [192.168.7.189] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id p6-20020a7bcc86000000b003f7f4dc6d14sm10209707wma.14.2023.06.19.02.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 02:47:01 -0700 (PDT)
Message-ID: <a3a7f840-eb74-dc32-dd8b-5f74a484b765@linaro.org>
Date:   Mon, 19 Jun 2023 11:47:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] interconnect: qcom: rpmh: add optional mask to send
 as vote
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v1-0-66663c0aa592@linaro.org>
 <20230619-topic-sm8550-upstream-interconnect-mask-vote-v1-1-66663c0aa592@linaro.org>
 <9e890ca0-396d-fb97-a7d5-db13b8fdbb92@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <9e890ca0-396d-fb97-a7d5-db13b8fdbb92@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/06/2023 11:45, Konrad Dybcio wrote:
> On 19.06.2023 10:24, Neil Armstrong wrote:
>> On the SM8550 SoC, some nodes requires a specific bit mark
>> instead of a bandwidth when voting.
>>
>> Add an enable_mask variable to be used to vote when a node
>> is enabled in an aggregate loop.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> Would be nice to mention that it's literally this commit:
> 
> https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/commit/2d1573e0206998151b342e6b52a4c0f7234d7e36

Good catch, I just copied the bits but yeah in fine it's the same...

I'll refer to it in a v2.

> 
> For the code:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Thanks,
Neil

> 
> Konrad
>>   drivers/interconnect/qcom/bcm-voter.c | 5 +++++
>>   drivers/interconnect/qcom/icc-rpmh.h  | 2 ++
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
>> index 8f385f9c2dd3..d5f2a6b5376b 100644
>> --- a/drivers/interconnect/qcom/bcm-voter.c
>> +++ b/drivers/interconnect/qcom/bcm-voter.c
>> @@ -83,6 +83,11 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
>>   
>>   		temp = agg_peak[bucket] * bcm->vote_scale;
>>   		bcm->vote_y[bucket] = bcm_div(temp, bcm->aux_data.unit);
>> +
>> +		if (bcm->enable_mask && (bcm->vote_x[bucket] || bcm->vote_y[bucket])) {
>> +			bcm->vote_x[bucket] = 0;
>> +			bcm->vote_y[bucket] = bcm->enable_mask;
>> +		}
>>   	}
>>   
>>   	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
>> diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
>> index 04391c1ba465..7843d8864d6b 100644
>> --- a/drivers/interconnect/qcom/icc-rpmh.h
>> +++ b/drivers/interconnect/qcom/icc-rpmh.h
>> @@ -81,6 +81,7 @@ struct qcom_icc_node {
>>    * @vote_x: aggregated threshold values, represents sum_bw when @type is bw bcm
>>    * @vote_y: aggregated threshold values, represents peak_bw when @type is bw bcm
>>    * @vote_scale: scaling factor for vote_x and vote_y
>> + * @enable_mask: optional mask to send as vote instead of vote_x/vote_y
>>    * @dirty: flag used to indicate whether the bcm needs to be committed
>>    * @keepalive: flag used to indicate whether a keepalive is required
>>    * @aux_data: auxiliary data used when calculating threshold values and
>> @@ -97,6 +98,7 @@ struct qcom_icc_bcm {
>>   	u64 vote_x[QCOM_ICC_NUM_BUCKETS];
>>   	u64 vote_y[QCOM_ICC_NUM_BUCKETS];
>>   	u64 vote_scale;
>> +	u32 enable_mask;
>>   	bool dirty;
>>   	bool keepalive;
>>   	struct bcm_db aux_data;
>>

