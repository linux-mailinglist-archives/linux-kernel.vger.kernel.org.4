Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C7D6A5C67
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjB1PwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjB1Pv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:51:58 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72CB311FF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:51:56 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bw19so10229052wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677599515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6A9koUtSxkvOPXoTwoFJv5+lwij6TAhz4sZy3lYRVO8=;
        b=GpQIAc/ysBWf3K/yhn5pvQb6GXC8R2i2cT5wFR1MKp9dJkV+qX8ST2aJ06wabfw169
         7y3lXZ5urh0gqvApa1hZ0g/0UK1pohu3JcNnZd+Vs7hlksKqUI4Hnbklq65GmNqrbV1B
         KemfzosE/fmOc6cbljoGRPb2lmwnQ0UclkqASXNK32ZM14er55WIsZZwYDENj3ROrbox
         qY7tceM8rptBfyDI3H97g8SLUcBBeWWTEgTRqMI0DFef87ek8CB4/qeIqp6q6q14CxoX
         M/HMa46nCAA3xPLTXh1BWl2qKbkvRs/ePHZ0TBmOJubAJhEvJOQWx3c8dMfjJgvYiLDo
         F5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677599515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6A9koUtSxkvOPXoTwoFJv5+lwij6TAhz4sZy3lYRVO8=;
        b=O565UHT41SA6qOfjFoWnnxlpIMct3Z5FnghiTVavC+rhXmSyVcOOgh+QKUV1sWpjMw
         vgJC8ntPZd91S4ecNICyANm2UOnPXZ7NVKv+pkIlbfmxuPSNatLaoFvw5I9hEgflbXx5
         8o2mPV/fA2bbguhq5FOBFCAdY8jsx7aIU9xdv25emYxfEsii++rTozX+cTrSSU3qSOpb
         kGxr+lmdTUnw5L3HewR4TITOVJIW96dCTOojEjAlNzSi+cw6PZvF10BrmGSetM6Pfq3I
         akUEsVoBZcvGrXFsxg7oSGyLBA75dDEQ5zCOQ1eFXJSHPJ/0m6Nzg8+IGO4bgIk3Riuf
         cO1A==
X-Gm-Message-State: AO0yUKXUnl/EaYCuVcsB+xEu0TxjM+gXjWemy9L3yKYKIslszq92wuTi
        UZUd6H4znygqzgVq43P9ejbx1X4aq9+vFIGy
X-Google-Smtp-Source: AK7set+KUj4CCdEC/cxgXOjkd7nViTKY9szj4PwxqUmwpakEG+V+cnw7lLXDrCvvfwOOlFl9bI/Fow==
X-Received: by 2002:adf:e790:0:b0:2cb:c370:77f9 with SMTP id n16-20020adfe790000000b002cbc37077f9mr2830676wrm.9.1677599515350;
        Tue, 28 Feb 2023 07:51:55 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t3-20020a5d49c3000000b002c5804b6afasm10393793wrs.67.2023.02.28.07.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 07:51:54 -0800 (PST)
Message-ID: <f215d875-4871-4d24-84ed-0703a28509d2@linaro.org>
Date:   Tue, 28 Feb 2023 15:51:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 15/18] media: venus: Remap bufreq fields on HFI6XX
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-15-58c2c88384e9@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230228-topic-venus-v1-15-58c2c88384e9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2023 15:24, Konrad Dybcio wrote:
> Similarly to HFI4XX, the fields are remapped on 6XX as well. Fix it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/hfi_helper.h | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
> index d2d6719a2ba4..8d683a6e07af 100644
> --- a/drivers/media/platform/qcom/venus/hfi_helper.h
> +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
> @@ -1152,11 +1152,14 @@ struct hfi_buffer_display_hold_count_actual {
>   
>   /* HFI 4XX reorder the fields, use these macros */
>   #define HFI_BUFREQ_HOLD_COUNT(bufreq, ver)	\
> -	((ver) == HFI_VERSION_4XX ? 0 : (bufreq)->hold_count)
> +	((ver) == HFI_VERSION_4XX || (ver) == HFI_VERSION_6XX \
> +	? 0 : (bufreq)->hold_count)
>   #define HFI_BUFREQ_COUNT_MIN(bufreq, ver)	\
> -	((ver) == HFI_VERSION_4XX ? (bufreq)->hold_count : (bufreq)->count_min)
> +	((ver) == HFI_VERSION_4XX || (ver) == HFI_VERSION_6XX \
> +	? (bufreq)->hold_count : (bufreq)->count_min)
>   #define HFI_BUFREQ_COUNT_MIN_HOST(bufreq, ver)	\
> -	((ver) == HFI_VERSION_4XX ? (bufreq)->count_min : 0)
> +	((ver) == HFI_VERSION_4XX || (ver) == HFI_VERSION_6XX \
> +	? (bufreq)->count_min : 0)
>   
>   struct hfi_buffer_requirements {
>   	u32 type;
> 

Doesn't this need a Fixes ?

---
bod
