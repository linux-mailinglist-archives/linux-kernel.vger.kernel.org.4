Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F07B70D57C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbjEWHny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjEWHnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:43:51 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7050E94
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:43:50 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96f818c48fbso745387466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684827822; x=1687419822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3RG61/5+/WSVFHjkPw5mlqbSw7Nb1Tx6G3f5gWMvqU=;
        b=woynQKxV0V7DEFvHt/YXUeibLPUT6n/3Y65yVZSrJ5Sj7NI11Rgsw0h8QquEOqevEl
         cJfCrkRn3V/3F927oJD12/RqSBi0cmpniMpivwm28srOZqcB0rMgQLLeL0rKByYhy+qa
         tPyzvz99LXhLcuk2ViVLJ665rWfGtrSI/FXdAISe9q4knGx4KW59mU7zk1lpmCNa1K1s
         pHWoubjCYAOKUzEQi+I8z86CJ59HGS0YZ2ZAozlHomg6AJZ3kqMJ4SfGdsbGsL30L5DI
         JuILAo1U/pS0g4C+dhed/Q15KzuOpYflckbv4ojHn0dOSNIHHZM/KWBD39DUi8WvAiUH
         yf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684827822; x=1687419822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3RG61/5+/WSVFHjkPw5mlqbSw7Nb1Tx6G3f5gWMvqU=;
        b=kpkOxRTBJohx/FNylPDzTI809wGy2fYEDCdg1KR9fHToWCPfGEuzjp5YF9Mih+cCT2
         THHZe8oOs/ElKwe5gJf2PyoLdA6drzvVQNDsMm1XCq10UOqTtW29/AmmOijCX0oyOXuk
         pGrIDy9R9RDDicaJLiQqFQZm2WhZES5FFVXsG4fTOvQeyAGnxw3lwZXtw1zoVvLFkxdK
         DOxHUflTYXdPr6DThMLP+VY2n02vjDV8W6CcmT0D0URJTP2UxKc4pHXwnOH2/RzVdmoh
         jfFXnMFrqJ2ZBJv0TS/JpZZN4dj4QOUNZ1JxgKwZhw/dZ4qdfCMkAk+4d/+TgKfGsYKA
         5CYA==
X-Gm-Message-State: AC+VfDxdq21CxjsNaH+K/ZTZUZ8lxaA8aqwwce5dap09EyV2P5f7Y3IJ
        Y4UJsA7QkrNNpucO5DXsFmAwq3Vt0R8fJb+0iYA=
X-Google-Smtp-Source: ACHHUZ6HRyf/NCQ88ZSlgqg8T9QJtsOCFVuwQZlk584ddQWpQWfvPDdxbTa3oq+weEAWe7eT4qiSBg==
X-Received: by 2002:a2e:4941:0:b0:2ab:bd1:93da with SMTP id b1-20020a2e4941000000b002ab0bd193damr4648474ljd.10.1684827059258;
        Tue, 23 May 2023 00:30:59 -0700 (PDT)
Received: from [192.168.1.101] (abyk138.neoplus.adsl.tpnet.pl. [83.9.30.138])
        by smtp.gmail.com with ESMTPSA id s16-20020a2e81d0000000b002aecfa8c58bsm1494161ljg.40.2023.05.23.00.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 00:30:58 -0700 (PDT)
Message-ID: <552d20f5-ed3c-2f69-2715-ab64914e131d@linaro.org>
Date:   Tue, 23 May 2023 09:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: clock: qcom: Accept power-domains for GPUCC
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230523010348.63043-1-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230523010348.63043-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.05.2023 03:03, Bjorn Andersson wrote:
> In many designs the power-domains provided by the GPU clock controller
> are powered by some GFX rail, add power-domains as a valid property to
> allow this to be specified.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
You may also wanna add some runtime pm enable calls in the driver

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  Documentation/devicetree/bindings/clock/qcom,gpucc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> index 1e3dc9deded9..a00216b3b15a 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> @@ -50,6 +50,9 @@ properties:
>        - const: gcc_gpu_gpll0_clk_src
>        - const: gcc_gpu_gpll0_div_clk_src
>  
> +  power-domains:
> +    maxItems: 1
> +
>    '#clock-cells':
>      const: 1
>  
