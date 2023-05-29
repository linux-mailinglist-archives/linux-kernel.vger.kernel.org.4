Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E881971470E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjE2J3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2J3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:29:02 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D714AF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:29:00 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f3bb61f860so3450613e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685352539; x=1687944539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wc6mACSfG6egkgCurAB6rV3RkuRUKyRFtI0D6QkUn4o=;
        b=YM7OxAsmPsA67H6ESrY6NVZtXkKKX3PKsu598Yr5y87nPyt0ReLNsPgX7AooSpKkGn
         tkDzLJsVDLNxOGbiSZoqmN7/R5DO7gl/0dFRFtPabM+L4U42hSffBDjw9KpUGOD1qWvK
         w3rEWbaSwivehrM9B3oK0OmDYqujM+oq7YKcPpUQuSf7XAhzPm/JorqeIlQqY6VR4EIv
         y9TxQggQrFB0a2wi1GAR3vVwa+YiPSQNNSikXd3/JPgc9ZS63kOmqXfqz8wIXH7+Ee/g
         89PqGLtjJNev/9njc2EntSo3Lt19ekzrUY/Oxgkjwky4iuw/oL+NBgaFfn00Vw7h/Dda
         lSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685352539; x=1687944539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wc6mACSfG6egkgCurAB6rV3RkuRUKyRFtI0D6QkUn4o=;
        b=jclTKkOiQRkVpkbSooMjMzpIQ/RbmLEYqQ5QQohzYrpSO2ek2+UFFdziku79rhIHr6
         bea+FpXDeBn+qB+U8rZYCbkltelMyhemJCB1UPmik8WO2vb91auK3p0Zq+t3A+8ZXKno
         GobwBW/SnIdTuqVhqXFfmW3tLcudY7o9kdKz74XRXIj/xcH47PAc4j9n64jrM1xrBB/B
         vR8NCslsRBXjJvpJdnpIVcX3QLsil9BumRx422m4BtNzX7E9KfnDSk5XxMUkYhEqyI2f
         FOo7bImcrUwvM7mCBydz2MkGGSe/yFbsgFCnvbPcY+trLS/HPUq4VHHtgDBxWEeYV8jb
         bl3g==
X-Gm-Message-State: AC+VfDyntulnr5VGadyBDaBLmGW3xOtoqIIz3GXBWc2eNl9fbmgAtb/D
        KtgyQFKzPTxO2/ocEcu9F6edxA==
X-Google-Smtp-Source: ACHHUZ6QFpHE3DaA+u6O/gKlLJ5c6fKsBif5MFyqY4I3c0jfyeC3Tvc/5Vn3P3W7D3gJTASz1y4rMA==
X-Received: by 2002:ac2:5d24:0:b0:4f3:a051:58e1 with SMTP id i4-20020ac25d24000000b004f3a05158e1mr2912329lfb.56.1685352538765;
        Mon, 29 May 2023 02:28:58 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id p15-20020a05651238cf00b004db3900da02sm1919344lft.73.2023.05.29.02.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 02:28:58 -0700 (PDT)
Message-ID: <dd2f0360-bcc0-61a6-09ec-316d8fc51da2@linaro.org>
Date:   Mon, 29 May 2023 11:28:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3] soc: qcom: ocmem: Add OCMEM hardware version print
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Brian Masney <masneyb@onstation.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230509-ocmem-hwver-v3-1-e51f3488e0f4@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230509-ocmem-hwver-v3-1-e51f3488e0f4@z3ntu.xyz>
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



On 29.05.2023 10:41, Luca Weiss wrote:
> It might be useful to know what hardware version of the OCMEM block the
> SoC contains. Add a debug print for that.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> This patch is depends on [0] but could also be applied in the other
> order, if conflicts are resolved.
> 
> [0] https://lore.kernel.org/linux-arm-msm/20230506-msm8226-ocmem-v1-1-3e24e2724f01@z3ntu.xyz/
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> Changes in v3:
> - Use %lu instead of %ld for print (Konrad)
> - Re-wrap lines so reading is easier (Konrad)
> - Link to v2: https://lore.kernel.org/r/20230509-ocmem-hwver-v2-1-8c8793a07dfc@z3ntu.xyz
> 
> Changes in v2:
> - Use FIELD_GET macros for getting correct bits from register (take
>   wording from mdp5: major, minor, step which hopefully is sort of
>   accurate)
> - Link to v1: https://lore.kernel.org/r/20230509-ocmem-hwver-v1-1-b83ece3f2168@z3ntu.xyz
> ---
>  drivers/soc/qcom/ocmem.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
> index c3e78411c637..ef7c1748242a 100644
> --- a/drivers/soc/qcom/ocmem.c
> +++ b/drivers/soc/qcom/ocmem.c
> @@ -76,6 +76,10 @@ struct ocmem {
>  #define OCMEM_REG_GFX_MPU_START			0x00001004
>  #define OCMEM_REG_GFX_MPU_END			0x00001008
>  
> +#define OCMEM_HW_VERSION_MAJOR(val)		FIELD_GET(GENMASK(31, 28), val)
> +#define OCMEM_HW_VERSION_MINOR(val)		FIELD_GET(GENMASK(27, 16), val)
> +#define OCMEM_HW_VERSION_STEP(val)		FIELD_GET(GENMASK(15, 0), val)
> +
>  #define OCMEM_HW_PROFILE_NUM_PORTS(val)		FIELD_GET(0x0000000f, (val))
>  #define OCMEM_HW_PROFILE_NUM_MACROS(val)	FIELD_GET(0x00003f00, (val))
>  
> @@ -355,6 +359,12 @@ static int ocmem_dev_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	reg = ocmem_read(ocmem, OCMEM_REG_HW_VERSION);
> +	dev_dbg(dev, "OCMEM hardware version: %lu.%lu.%lu\n",
> +		OCMEM_HW_VERSION_MAJOR(reg),
> +		OCMEM_HW_VERSION_MINOR(reg),
> +		OCMEM_HW_VERSION_STEP(reg));
> +
>  	reg = ocmem_read(ocmem, OCMEM_REG_HW_PROFILE);
>  	ocmem->num_ports = OCMEM_HW_PROFILE_NUM_PORTS(reg);
>  	ocmem->num_macros = OCMEM_HW_PROFILE_NUM_MACROS(reg);
> 
> ---
> base-commit: 8705151771af822ac794b44504cd72eebc423499
> change-id: 20230509-ocmem-hwver-99bcb33b028b
> 
> Best regards,
