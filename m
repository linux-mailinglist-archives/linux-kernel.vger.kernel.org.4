Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E59168BEFA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjBFN4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjBFN4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:56:38 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227C9298ED
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:55:31 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id e22so5071050ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ftQZlgoEMVbz2ozED6ouzD0QP+nnGxzIrrofPtlIppA=;
        b=g3eRcwxDqdoeitS/KvL5d1OBL9MzWua2F56kXWXjzTYF2A2rl36Zg7bs4MikB3LqhG
         JvnNb5SrK6xwn17OHs6su18ILCwEyF/e1yNCw/ddQcvoRDupXMNuBHAb0nNvdD/HRnk7
         ZlzlFwocxyLHfR6vtMS46SZ8CuTV12wjKxw/RFBuSsWUvjuskxdDH4Gr6iN8ZSeJukpD
         AIMCTRd/+LN4/4bs3vlo5H5uJKdaLo87wqXdGFTsTiFpqCuU4A8CxOjDYASIfDJgvwdk
         DYPidgmNUlsYH/TAEOzZ/l4El6pXX0CJ9KNqM8DHbdA37SGgeHRekQIEvYxNqtrsZ4g9
         5LJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftQZlgoEMVbz2ozED6ouzD0QP+nnGxzIrrofPtlIppA=;
        b=2ib4JCDn1j0rBPQzY4hnkOk8iug9Ogd0WZnsUE2Fl2gQqAV2EEvrqxwAzvgQMPzw99
         SiWV3Fsz75sZs+5OIOknlXupRdlp6atJ+BjHslZb4Q5CUr9Bm7PaIsquS7QWivjxfzb1
         Xo+chvpVPWl0+CNl6y/xsvRk+igmcZDzVZmK9Z59JvJbIu1vaunP3H1wjEk/MAabO7jW
         ckyGJdEbV4I167bkB78fBXyxiMBVaeOPab+k4QGFHfAxgz2fe5e+tYLo3n/X9croqcrl
         tIF8ddqazQ15WTTV8lnH6reSzrlkXLmnxvCHi8IVZEL0qUm7tv6RoaKALUAeHBHcms+Q
         wZxQ==
X-Gm-Message-State: AO0yUKVSqtSFanbYuXP0SgMLJk1QzQyI7yU2wD4SR3/fHtfwETxMkNKh
        zqqCZybkHCfyvo1I9K/LBAqQVg==
X-Google-Smtp-Source: AK7set9nBLFYEWeRIN2ZPFcwgnJVZxtVtBBz2bqfMvIXFYnhsfwfN7OZ7hZHBbUGjSNaWjTheuhNxw==
X-Received: by 2002:a17:906:b817:b0:86d:f880:5193 with SMTP id dv23-20020a170906b81700b0086df8805193mr22483107ejb.38.1675691665975;
        Mon, 06 Feb 2023 05:54:25 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id z20-20020a1709060ad400b0085d6bfc6201sm5490277ejf.86.2023.02.06.05.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 05:54:25 -0800 (PST)
Message-ID: <48ac2e20-d80c-c842-3766-b5df30053270@linaro.org>
Date:   Mon, 6 Feb 2023 14:54:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] remoteproc: qcom_q6v5_pas: enable sm8550 adsp & cdsp
 autoboot
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230206-topic-sm8550-upstream-fix-remoteproc-autoboot-v1-1-11445a0c27c6@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230206-topic-sm8550-upstream-fix-remoteproc-autoboot-v1-1-11445a0c27c6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.02.2023 14:53, Neil Armstrong wrote:
> Set the SM8550 adsp & cdsp auto_boot to true to match the behavior
> of the previous platforms.
> 
> Fixes: 7eddedc97563 ("remoteproc: qcom_q6v5_pas: add sm8550 adsp, cdsp & mpss compatible & data")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/remoteproc/qcom_q6v5_pas.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 4e1d9b08def4..90c5612a3045 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -1108,7 +1108,7 @@ static const struct adsp_data sm8550_adsp_resource = {
>  	.pas_id = 1,
>  	.dtb_pas_id = 0x24,
>  	.minidump_id = 5,
> -	.auto_boot = false,
> +	.auto_boot = true,
>  	.proxy_pd_names = (char*[]){
>  		"lcx",
>  		"lmx",
> @@ -1127,7 +1127,7 @@ static const struct adsp_data sm8550_cdsp_resource = {
>  	.pas_id = 18,
>  	.dtb_pas_id = 0x25,
>  	.minidump_id = 7,
> -	.auto_boot = false,
> +	.auto_boot = true,
>  	.proxy_pd_names = (char*[]){
>  		"cx",
>  		"mxc",
> 
> ---
> base-commit: ea4dabbb4ad7eb52632a2ca0b8f89f0ea7c55dcf
> change-id: 20230206-topic-sm8550-upstream-fix-remoteproc-autoboot-5c7effcf197c
P.S not sure if you wanted to send that to lkml
> 
> Best regards,
