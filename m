Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53436836C3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjAaToU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjAaToR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:44:17 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE89521F4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:44:15 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z11so15542822ede.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CS03WOAw5jiLnF7HH1Oc8lq1GoJJAvN3Db4EtSuhGg0=;
        b=HmqhrinZ3M4v+ECot/+M8m42OsHsJhYf72Ze0/87kHJC4SbGzKZu1LnCJVDuWsr+oO
         JbiX6Vb9eg3R2GJE5ZBi4KeEjQGm+v7/qUYodvrDN8ITLuZy/Y5rhGz7E/xIRunDg25h
         ZZXOyWhUqMaAhg+GEYHr6J4TGO67kExbRgct9NAzmTiKzvzQKCg1QsMTFGignERdPjp9
         KA9QiQYoJczNiVWQ3dzQiCti+vM7TyGwDRuno+kg84uCXxolqHKEubiMMPJlsEI1uCWp
         Nw0bGh0iBM2yazHZIPRlfcQcdZg/NG2WtbzOB2Uk2sArVCYfuy8zDUPz/lyzhvjWLzy+
         4fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CS03WOAw5jiLnF7HH1Oc8lq1GoJJAvN3Db4EtSuhGg0=;
        b=A/CYDzCS7sx5D7SuxJrkNH/GaPWCxibleauvKEDwWiXNitEFuZIMvkLPuTCe13Ccpi
         SZQS8WfW9dmsBMNCBuN0drHQC2xjQ8Ke/himM+1FoAgosad6y/AxQXSBiXD758REPMe4
         7/Rpcbu3p9mHpJjk2RGl2+L9C6mGJ5Q8X+jRSgYaW2CaFoGyS47V4xxeG+Fe1uGM1ZS5
         HDcl4hrqQJQKlrs03zodSzuT1VdQaSaN4jZdH7b7XwkB1bonQ7yeZHL2iEFhNEFb78CB
         6qaH6EZE7b6lCBhh3glTGZybivUxTcFNGoTQEGqmabAhlveqq5wZxEKoY/Ap4pCdGwkY
         3nPQ==
X-Gm-Message-State: AFqh2krRsTavv15NRJe9U95dQqGtZLYUB/4rdi7YaFQiF45CCX1j1Y5e
        mxrYGoCjE18HtY9nMEDunRnhkA==
X-Google-Smtp-Source: AMrXdXvx3fgqPD05B0PPx+Li7lihLOEw4CdHu7RnpL2kf/m0J+K4FL5c0ssQT1xnbtFhuWKpBiyW+w==
X-Received: by 2002:aa7:cd89:0:b0:49d:14cf:5f4a with SMTP id x9-20020aa7cd89000000b0049d14cf5f4amr57926940edv.39.1675194254341;
        Tue, 31 Jan 2023 11:44:14 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7d046000000b004a245d70f17sm3770697edo.54.2023.01.31.11.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 11:44:13 -0800 (PST)
Message-ID: <50550a80-6422-e4b7-c137-15374f22bf9e@linaro.org>
Date:   Tue, 31 Jan 2023 20:44:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] arm64: Add a couple of missing part numbers
Content-Language: en-US
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        James Morse <james.morse@arm.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Linu Cherian <lcherian@marvell.com>,
        Michal Orzel <michal.orzel@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230131191940.2903908-1-konrad.dybcio@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230131191940.2903908-1-konrad.dybcio@linaro.org>
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



On 31.01.2023 20:19, Konrad Dybcio wrote:
> Add Cortex X1C and add/clarify various recent Qualcomm Kryo cores,
> which almost exclusively mimic ARM IDs nowadays.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/include/asm/cputype.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 683ca3af4084..4b79a0d44c65 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -84,6 +84,7 @@
>  #define ARM_CPU_PART_CORTEX_X2		0xD48
>  #define ARM_CPU_PART_NEOVERSE_N2	0xD49
>  #define ARM_CPU_PART_CORTEX_A78C	0xD4B
> +#define ARM_CPU_PART_CORTEX_X1C		0xD4C
>  
>  #define APM_CPU_PART_POTENZA		0x000
>  
> @@ -107,9 +108,17 @@
>  #define QCOM_CPU_PART_KRYO		0x200
>  #define QCOM_CPU_PART_KRYO_2XX_GOLD	0x800
>  #define QCOM_CPU_PART_KRYO_2XX_SILVER	0x801
> +#define QCOM_CPU_PART_KRYO_3XX_GOLD	0x802
>  #define QCOM_CPU_PART_KRYO_3XX_SILVER	0x803
>  #define QCOM_CPU_PART_KRYO_4XX_GOLD	0x804

> -#define QCOM_CPU_PART_KRYO_4XX_SILVER	0x805
> +#define QCOM_CPU_PART_KRYO_4XX_SILVER_V2	0x805
This should not have been here, will fix..

Konrad
> +#define QCOM_CPU_PART_KRYO_5XX_GOLD	ARM_CPU_PART_CORTEX_A77
> +#define QCOM_CPU_PART_KRYO_6XX_GOLD	ARM_CPU_PART_CORTEX_A78
> +#define QCOM_CPU_PART_KRYO_6XX_GOLDPLUS	ARM_CPU_PART_CORTEX_X1
> +#define QCOM_CPU_PART_KRYO_6XX_SILVER_V1	ARM_CPU_PART_CORTEX_A55
> +#define QCOM_CPU_PART_KRYO_7XX_GOLD	ARM_CPU_PART_CORTEX_A710
> +#define QCOM_CPU_PART_KRYO_7XX_GOLDPLUS	ARM_CPU_PART_CORTEX_X2
> +#define QCOM_CPU_PART_KRYO_7XX_SILVER	ARM_CPU_PART_CORTEX_A510
>  
>  #define NVIDIA_CPU_PART_DENVER		0x003
>  #define NVIDIA_CPU_PART_CARMEL		0x004
