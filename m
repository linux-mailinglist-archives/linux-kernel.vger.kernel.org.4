Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A09C67AD37
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjAYJDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbjAYJDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:03:07 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AA4CC0E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:02:47 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qx13so45649637ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CXeCYzMZdHlOowH7OuNx8RgAvuvHYBPsScMx04fOpZg=;
        b=vcIv9Y64XEGo09bA0mU16yRuI5X4hqMPGY6isbMqJYiu/V5vXZmjYg02OL4H+H9adS
         ao0kZ4CdLjh9kK5BPqinueGq8+HYhu5z93koSDzdiTFhki3GofPfDcZxq6qbzV0WLqlV
         f4bD5+CC3jRTGb+i7H3wjtgq+W1beaAgztTdJ0nrjcdCrWfoN3BRpdZ69g4cjuPNY2Oz
         i5HkcMts5uXEW4I4VYV24ABD+bp3Vh0St2sFTOH1a2cOHJoaHi/CLZy+Gm4Ri0JrbZdE
         zFWF/9gya7ufTHemculuN5lL2KGju1PaQXNjGb1FAOOAe5GA3fs3dauZogVpCwFMxW2f
         aTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXeCYzMZdHlOowH7OuNx8RgAvuvHYBPsScMx04fOpZg=;
        b=BA0K0UuCx3d6d6KTF3qOMq/PXFoewmfffmrv/cKFDs3p82qrXzrdjizxDu6nmfzGHX
         pmUE2nTiqMIiKvlD0IyzNrh0nE8Di6jp7q4h4ymDkrh2p9Q6mt1gzcodEVT2fhayNbjp
         mHGYH2iV9izccvJpjOReCqlbtZ2b7/eGRjCVFfnDcFEoxGPLpCShXqLdUK+dJxz8ZisT
         WtOjWTs+rba//b+JBUW0LfxEnAdklCSSy7yr5vtFRug8NbD1NDs7iBhOKX1FB8JX1j41
         i561MNQyqu9VC8iklLhVXF1xErvL7SLXBul1aC7J56wa+kpHfcK4eSZm+kXpgpUiNBAd
         aAEA==
X-Gm-Message-State: AFqh2kpwLNXJBlhoE/dGYG4B1nXQXd8XRbrMIshUYR6nuJ8gumrTLYrq
        pEP8oKgvXyWIzqflHth/8AUk5w==
X-Google-Smtp-Source: AMrXdXur1bTvNUgeXSfPs6pIk27Hd+iLD/aXSmGQ5xjftXsdD/iogZQazZe/hBxa8lVmhjoTv31i+Q==
X-Received: by 2002:a17:906:2c49:b0:7c0:fd1e:972e with SMTP id f9-20020a1709062c4900b007c0fd1e972emr35089828ejh.46.1674637366198;
        Wed, 25 Jan 2023 01:02:46 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id t17-20020a170906949100b0073022b796a7sm2101711ejx.93.2023.01.25.01.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 01:02:45 -0800 (PST)
Message-ID: <32f36ec1-3f40-d12c-43e4-69862cd37606@linaro.org>
Date:   Wed, 25 Jan 2023 11:02:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/7] soc: qcom: rpmpd: Remove SoC names from RPMPD names
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, linux-kernel@vger.kernel.org
References: <20230125032728.611640-1-konrad.dybcio@linaro.org>
 <20230125032728.611640-5-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230125032728.611640-5-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 05:27, Konrad Dybcio wrote:
> SoC names were used only to distinguish between defines. That made
> reusing them messy and often times, the same RPM power domains were
> defined multiple times. Assign descriptive, SoC-independent names to
> each RPMPD description struct and remove duplicate definitions.
> 
> Bloat-o-meter results:
> Total: Before=133713, After=74201, chg -44.51%
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/soc/qcom/rpmpd.c | 763 +++++++++++----------------------------
>   1 file changed, 205 insertions(+), 558 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
> index a69182618b76..9fff40527f9e 100644
> --- a/drivers/soc/qcom/rpmpd.c
> +++ b/drivers/soc/qcom/rpmpd.c
> @@ -69,50 +69,50 @@ struct rpmpd_desc {
>   static DEFINE_MUTEX(rpmpd_lock);
>   
>   /* mdm9607 RPM Power Domains */
> -static struct rpmpd mdm9607_vddcx_ao;
> -static struct rpmpd mdm9607_vddcx = {
> +static struct rpmpd cx_s3a_lvl_ao;
> +static struct rpmpd cx_s3a_lvl = {
>   	.pd = { .name = "vddcx", },
> -	.peer = &mdm9607_vddcx_ao,
> +	.peer = &cx_s3a_lvl_ao,
>   	.res_type = RPMPD_SMPA,
>   	.res_id = 3,
>   	.key = KEY_LEVEL,
>   };
>   
> -static struct rpmpd mdm9607_vddcx_ao = {
> +static struct rpmpd cx_s3a_lvl_ao = {
>   	.pd = { .name = "vddcx_ao", },
> -	.peer = &mdm9607_vddcx,
> +	.peer = &cx_s3a_lvl,
>   	.active_only = true,
>   	.res_type = RPMPD_SMPA,
>   	.res_id = 3,
>   	.key = KEY_LEVEL,
>   };
>   
> -static struct rpmpd mdm9607_vddcx_vfl = {
> +static struct rpmpd cx_s3a_lvl_vfl = {

As you are already adding _lvl to the name, _lvl_floor might be betther 
than _lvl_vfl.

>   	.pd = { .name = "vddcx_vfl", },
>   	.res_type = RPMPD_SMPA,
>   	.res_id = 3,
>   	.key = KEY_FLOOR_LEVEL,
>   };

[skipped]

-- 
With best wishes
Dmitry

