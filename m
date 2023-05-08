Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF616FA0FA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjEHH1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjEHH0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:26:53 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9363A40FE
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:26:51 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f2510b2b98so489431e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 00:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683530810; x=1686122810;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JFLTzjYHc2Wy3NEyiiA6VvE9neb0Ehp30pb4IjLGMHs=;
        b=wruiOd/65aWLE5iIGAms0g5iLixlraLq+GDsKNGd/sNtiPR/9MfqubZCdb0cnWj04T
         5uJT+W99aiG5/RBhlM7UNmSzl3els2hmcIwb7ft08OUd1CT/TjfADuk4fFUkHvLT50VS
         7oGbWswa/I9w9zqjAQz4QfSniKkFWOc56G+9yWysaa1qo+Te59iwxN6Nrp6MQhSGyMZq
         8apBHG7gPFCyzpQREeKPI4G0IxBHnjB/wd6MCOcv9o90QueSz2he4JprJBt2lQO4cq87
         9t9eyrnxiacFpy6vfJy/hBC0cL2Ia8F+SMVG5yoqgHWOTgQfXWziLzKum+np4WXXDzR+
         oTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683530810; x=1686122810;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFLTzjYHc2Wy3NEyiiA6VvE9neb0Ehp30pb4IjLGMHs=;
        b=jx8QCWF0h26IprQlvS1+A4+Wr3J/UaZF7bh/J+d4bP17Ws2OiEku4YsBP95OE03PY3
         R9nz+ZVP2FeHqPAHTtQn4Hx7FxSPmkCTPUbsMapQcvwcHnjS8AgAjdOk6ItQwbv5iCuv
         eJSXM97oWdOVJzdZs4xqjUFlNh/CjuZXX/xUAf8JaC0K0BQu5WepNBg2jnivW2YC3I0K
         Bc4F89jGgzhpSuxS9ImMkUzNvHrYbiOdx6VI7VCQTYmQdbivXHcSs/lnp994t3vnPssi
         2H0c6hAplfQPC9VM7bdUPenCTwoqbW36VqIJpN69q0nJ0+GQIzM8TUNjkr/hFoN7aAuZ
         3Gqw==
X-Gm-Message-State: AC+VfDx0u3Ni86P1z7U80CNh3nLCgXOpVHWgQ7OJRiJUxjN09nep3SNr
        VfJcB5Y+hpiN8YJUqMxGzRfhQw==
X-Google-Smtp-Source: ACHHUZ5owctDJw6gtd5X+hv8xl+nhtwxwTQ1jcUgyseC+4hSXZ4GviWouC12390R6JPONcfOrZLh2g==
X-Received: by 2002:a19:ae0d:0:b0:4f1:2236:6d2a with SMTP id f13-20020a19ae0d000000b004f122366d2amr2413021lfc.53.1683530809851;
        Mon, 08 May 2023 00:26:49 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id c11-20020ac2414b000000b004f12f5d866fsm1208560lfi.10.2023.05.08.00.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 00:26:49 -0700 (PDT)
Message-ID: <8f3db51e-30a0-8550-3775-c49c6c25cac4@linaro.org>
Date:   Mon, 8 May 2023 09:26:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/6] soc: qcom: ocmem: Fix NUM_PORTS & NUM_MACROS macros
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230506-msm8226-ocmem-v1-0-3e24e2724f01@z3ntu.xyz>
 <20230506-msm8226-ocmem-v1-1-3e24e2724f01@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230506-msm8226-ocmem-v1-1-3e24e2724f01@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.05.2023 11:12, Luca Weiss wrote:
> Since we're using these two macros to read a value from a register, we
> need to use the FIELD_GET instead of the FIELD_PREP macro, otherwise
> we're getting wrong values.
> 
> So instead of:
> 
>   [    3.111779] ocmem fdd00000.sram: 2 ports, 1 regions, 512 macros, not interleaved
> 
> we now get the correct value of:
> 
>   [    3.129672] ocmem fdd00000.sram: 2 ports, 1 regions, 2 macros, not interleaved
> 
> Fixes: 88c1e9404f1d ("soc: qcom: add OCMEM driver")
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soc/qcom/ocmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
> index 199fe9872035..c3e78411c637 100644
> --- a/drivers/soc/qcom/ocmem.c
> +++ b/drivers/soc/qcom/ocmem.c
> @@ -76,8 +76,8 @@ struct ocmem {
>  #define OCMEM_REG_GFX_MPU_START			0x00001004
>  #define OCMEM_REG_GFX_MPU_END			0x00001008
>  
> -#define OCMEM_HW_PROFILE_NUM_PORTS(val)		FIELD_PREP(0x0000000f, (val))
> -#define OCMEM_HW_PROFILE_NUM_MACROS(val)	FIELD_PREP(0x00003f00, (val))
> +#define OCMEM_HW_PROFILE_NUM_PORTS(val)		FIELD_GET(0x0000000f, (val))
> +#define OCMEM_HW_PROFILE_NUM_MACROS(val)	FIELD_GET(0x00003f00, (val))
>  
>  #define OCMEM_HW_PROFILE_LAST_REGN_HALFSIZE	0x00010000
>  #define OCMEM_HW_PROFILE_INTERLEAVING		0x00020000
> 
