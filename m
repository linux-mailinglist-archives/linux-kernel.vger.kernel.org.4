Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4DF7240D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbjFFL2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjFFL2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:28:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A43F4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:28:31 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-977c88c9021so474254966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 04:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686050910; x=1688642910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=utFeka+9yLICmbetZMFezs6Zq+yNbOQcRunr7yjZBJQ=;
        b=Qdhs0Hl2+JaE3/asNnbSTqPp+raEcB3hNpariCCxePYPH3jQL/cmWUP5KxdBCjhSR8
         YNFZeP+hdKbQYlOoDbrfKuPSLaK5iqm3HerePEuC1fJ+Di40rOfG5hSZzMCtixTBqSWU
         yhoD2ZIWh6kH5qEv1+0RbidtMiQoIwdZyYsQ3G+GfBMjgzmWINoCGBszGT4o2ZgbwHEu
         /l4y62c+X1D1y5hCITw+Qpx9R2iSkz3Oh+Bwt+IUleXEeIkZRNbGOj3bnMZeynuI2dTK
         bSJthP70JAglhPW5mujPg0R1dofyGmeD4lwMLK6nqQEcbe8JLgc0yrLhuD0uxuxCcOll
         BcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686050910; x=1688642910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=utFeka+9yLICmbetZMFezs6Zq+yNbOQcRunr7yjZBJQ=;
        b=g5ezp0SYdZ3rGP+E3bBCf0I8ircw+Qh5Lxvp9pS+R7IxyqtPr6MThSKnCLTd+9/lLF
         oNK/ZbFX5PrvYBvIQvucfLxJrYIAJxygrlSGFlORDmcff972Fmhz+B8PYnEaWUmcwmly
         LX04Z/eE4EG5tTiimBSH+ObPYDZRz6kMoNj1WDw27FrhEtKH23Fg/brw3l/MLw4ZWjqo
         5AArp7Mma46K9X6ycMwZYgTBu+CWqptIP/+IfaArhQtip3xc6YBNYKlkPVI3H7947DNh
         LqgIp92+LJusS5w9bCOROsgMSp/QbDGT38RgAkejRuTXpN+eRF44fVNNpgENm56OSebj
         mfKw==
X-Gm-Message-State: AC+VfDxo79XQN7am3d3ZRprbKm1dp1bMbGyte44mQDwpmVDC/syoqbhJ
        bDH0yWhw7z3z3Miom9rPET5MWA==
X-Google-Smtp-Source: ACHHUZ4btnhep2dxOX+EtQzTSaJyfXbSiLkcT4PdQhg9liSwnoIRQowJatIOkGMVy3mo17MPq2w+sA==
X-Received: by 2002:a17:906:fe0d:b0:96f:1f79:c0a6 with SMTP id wy13-20020a170906fe0d00b0096f1f79c0a6mr2058936ejb.70.1686050909851;
        Tue, 06 Jun 2023 04:28:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m19-20020a170906235300b00967a18df1easm5454195eja.117.2023.06.06.04.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 04:28:29 -0700 (PDT)
Message-ID: <d4970017-86b5-884f-fe67-6fede30469b4@linaro.org>
Date:   Tue, 6 Jun 2023 13:28:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: document MI04.1 board based
 on IPQ5332 family
Content-Language: en-US
To:     Hariharan K <quic_harihk@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com
References: <20230606095732.12884-1-quic_harihk@quicinc.com>
 <20230606095732.12884-2-quic_harihk@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230606095732.12884-2-quic_harihk@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2023 11:57, Hariharan K wrote:
> Document the MI04.1 (Reference Design Platform 446) board based on IPQ5332
> family of SoCs.
> 
> Signed-off-by: Hariharan K <quic_harihk@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 8302d1ee280d..165a815337f7 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -93,6 +93,7 @@ description: |
>          ap-mi01.2
>          ap-mi01.3
>          ap-mi01.6
> +        ap-mi04.1

I think we need to stop adding them here... This was supposed to be
limited list for Qualcomm bootloader. Are you sure Qualcomm bootloader
requires such names with versions?

Best regards,
Krzysztof

