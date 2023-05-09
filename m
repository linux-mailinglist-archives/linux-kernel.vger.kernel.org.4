Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B25F6FD2AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 00:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbjEIWbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 18:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjEIWbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 18:31:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C41F26A6
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 15:31:18 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f420618d5bso24929895e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 15:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683671476; x=1686263476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H+e/daKX9drvWfcCFRUKynPMFbFB2xNv5pizYcQC/Ps=;
        b=GFKH2bIxWke50r1pk7SF3vM1y+2UUkocKOj6AaVv+BIbIfPb50J4niBeH1qWBCHgYn
         pMhPqIqQDEDD+sPbCSttytseujK0mOooNf2ruJHaG29ec55LjHb0G2J+HEq5FzmvvBp0
         36d7RVt4jcPGXnfNoReBUhTuSBiVFtHWQ5yoGoRTRce32Mfu9+o1ydhhQHD8tlLMkmK3
         4CO3f3u0TLd1Eke1T5U/18ADKLGOZowqrg8mCMirvnC+NslO3BpmNQVi7rNa4vAHzXJ2
         0rrUakHbjlgSUan4I1Om8PTRhYDXNkfSDTSScef8xYGdK9XcxQrVhfmrxBdG9Js19fVk
         Ozkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683671476; x=1686263476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+e/daKX9drvWfcCFRUKynPMFbFB2xNv5pizYcQC/Ps=;
        b=MUPRhs5uV2xSnJwSQZ92+WrgxIAYwQgHZ5eeGTp1TkO2MOCke2MqPawlr15PpMghDj
         X5bpHARM+08nosdyf1d3l+I5HDoqRyiEAQwPaB1gclT/gUfZIEeeVapvElyZOU2Ta4sy
         8Jzek4qIoJXEl8zySAubjOPjxOs7ZOB6L8GGUqbEwoZ4iLYlr/knUC4wI7U5/pEN3g/X
         ZlX3aUCto28AU+9wh7vFUbT+gHyrYmVm5w4/nYUbxPonk0XN/ViGJDYszZkcbPHGPtJo
         wcxkvzunmpQbcDY7+AXv71nhkq9IApNSydsgOYvh3kUA524/d2/HJ77e93TseWXaQgIS
         7MbQ==
X-Gm-Message-State: AC+VfDzGodyazzKDyLsGz1bon7ryIJQ/dVAxpqef/4VnoK4YMcus/fYo
        kLQ0RnYU7w56XVyfXMDLm0tE+g==
X-Google-Smtp-Source: ACHHUZ6si+b8+Ej7zsK3mGDrXpwwIIjfiDltVqOh0t/imBMJJulNtoJoVip+zo8oVrlJXojtlzg4yg==
X-Received: by 2002:a05:600c:29a:b0:3f4:2973:b8c8 with SMTP id 26-20020a05600c029a00b003f42973b8c8mr3730808wmk.26.1683671476656;
        Tue, 09 May 2023 15:31:16 -0700 (PDT)
Received: from [192.168.0.15] (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003f17122587bsm21203561wml.36.2023.05.09.15.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 15:31:16 -0700 (PDT)
Message-ID: <53f6e9c7-26e2-94be-fa02-0c3cbb65372b@linaro.org>
Date:   Tue, 9 May 2023 23:31:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/6] soc: qcom: ocmem: Fix NUM_PORTS & NUM_MACROS macros
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230506-msm8226-ocmem-v1-0-3e24e2724f01@z3ntu.xyz>
 <20230506-msm8226-ocmem-v1-1-3e24e2724f01@z3ntu.xyz>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20230506-msm8226-ocmem-v1-1-3e24e2724f01@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/05/2023 10:12, Luca Weiss wrote:
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

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
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

-- 
Kind Regards,
Caleb (they/them)
