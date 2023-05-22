Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F42970B7C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjEVIgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjEVIft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:35:49 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB4CED
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:35:47 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d2c865e4eso2615818b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684744546; x=1687336546;
        h=content-transfer-encoding:in-reply-to:references:subject:to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u81+gNqpoMK774yWwCBHKk+pd5Ao3K0ld1AoX7VQD8=;
        b=NLNaXASyCE30Cfo/nFeN62e7oRbOpQAk3mNc5Vux+PxdODqbeBzx/fyJj5pK8jB0wJ
         9fAZQynq/nhXzFv34mcmJFWS+ksIFnkkQl1gdnBcg2aavyP8+tQUAjlZ490n2JYYcNvN
         t4pjqqFUbhb5WwMjjttyQVR9n8z3Im9KFDrGyOfOZM56jDBtjA4xETSHPMogK0MPUcKg
         LsXn+e+kpHBYg5UeYseQLbdjjRg7F1AOtg0hIWopk7UiGRRIrmC/rGBPNCvq4BQOA0gp
         Q87GNmF39jjQkKYVASoHe7jKxKyuJ071ITUFXKzS76SIIDDIMoZ/o6hQ5KjJoL6aa9cJ
         f4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684744546; x=1687336546;
        h=content-transfer-encoding:in-reply-to:references:subject:to:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8u81+gNqpoMK774yWwCBHKk+pd5Ao3K0ld1AoX7VQD8=;
        b=bjCbCSq7fyNevtBKFOLq5Ij4p0c0+51TV6mGWfOmYRr9q/Ao2LLzIVwuIezYAlynTH
         8FWUCY7NIp4H5erPOp3tnVsEEGh9NiWoE/AYtnLxQQsXAbN4RtwB+U7/1D5nR2EBkG24
         hlvaZzGWut4prccWV3qxtYztr3ueQlFr969aCOyCboL9lYO46lsw8GasmiO+88yGQ8+8
         vP/2Mf3zJellYk/nqCpG/w+BQTyPVb8r/4BlmHBhS0GH2sRJ0UonNegJO1juZoLPD9Gz
         /F+q5l/TCjqmQolFCJirodugea/KqyQ24wYW//st6MLpRBGMritWmbr5VoXl7PzweIjW
         O19g==
X-Gm-Message-State: AC+VfDyXPHqtrh9hqsiKbRjz0htb7En2z0/RD+ZJmyS1KdpLOir8r7P3
        DtbbAyX8CzNBvZHaaIojZBLERQ==
X-Google-Smtp-Source: ACHHUZ6MSwGF1WZDtb2DuJRHLwLiWl/saCrKgyrPeuZgMnchUsoJ34hpcutGb5dfceyxYajJ++kA7Q==
X-Received: by 2002:a05:6a21:6d88:b0:104:923b:4d00 with SMTP id wl8-20020a056a216d8800b00104923b4d00mr11247917pzb.36.1684744546529;
        Mon, 22 May 2023 01:35:46 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:d309:883d:817e:8e91:be39? ([2401:4900:1c60:d309:883d:817e:8e91:be39])
        by smtp.gmail.com with ESMTPSA id a22-20020a62bd16000000b0063afb08afeesm707621pff.67.2023.05.22.01.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 01:35:46 -0700 (PDT)
Message-ID: <b2009411-1822-b16e-6da4-44d399c52a19@linaro.org>
Date:   Mon, 22 May 2023 14:05:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   bhupesh.sharma@linaro.org
To:     Anusha Rao <quic_anusha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        thara.gopinath@gmail.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, quic_srichara@quicinc.com,
        quic_gokulsri@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_poovendh@quicinc.com
Subject: Re: [PATCH V3 1/4] dt-bindings: clock: Add crypto clock and reset
 definitions
References: <20230518141105.24741-1-quic_anusha@quicinc.com>
 <20230518141105.24741-2-quic_anusha@quicinc.com>
In-Reply-To: <20230518141105.24741-2-quic_anusha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 5/18/23 7:41 PM, Anusha Rao <quic_anusha@quicinc.com> wrote:
> Add crypto clock and reset ID definitions for ipq9574.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> ---
>   Changes in V3:
> 	- Added GCC prefix to CRYPTO_CLK_SRC.
> 	- Picked up Acked-by tag.
> 
>   include/dt-bindings/clock/qcom,ipq9574-gcc.h | 4 ++++
>   include/dt-bindings/reset/qcom,ipq9574-gcc.h | 1 +
>   2 files changed, 5 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
> index 5a2961bfe893..b32a7aa65349 100644
> --- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
> +++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
> @@ -210,4 +210,8 @@
>   #define GCC_SNOC_PCIE1_1LANE_S_CLK			201
>   #define GCC_SNOC_PCIE2_2LANE_S_CLK			202
>   #define GCC_SNOC_PCIE3_2LANE_S_CLK			203
> +#define GCC_CRYPTO_CLK_SRC				204
> +#define GCC_CRYPTO_CLK					205
> +#define GCC_CRYPTO_AXI_CLK				206
> +#define GCC_CRYPTO_AHB_CLK				207
>   #endif
> diff --git a/include/dt-bindings/reset/qcom,ipq9574-gcc.h b/include/dt-bindings/reset/qcom,ipq9574-gcc.h
> index d01dc6a24cf1..c709d103673d 100644
> --- a/include/dt-bindings/reset/qcom,ipq9574-gcc.h
> +++ b/include/dt-bindings/reset/qcom,ipq9574-gcc.h
> @@ -160,5 +160,6 @@
>   #define GCC_WCSS_Q6_BCR						151
>   #define GCC_WCSS_Q6_TBU_BCR					152
>   #define GCC_TCSR_BCR						153
> +#define GCC_CRYPTO_BCR						154
>   
>   #endif

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks.
