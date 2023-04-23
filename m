Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BF16EBEC7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 12:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjDWK47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 06:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDWK45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 06:56:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7F710E2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 03:56:55 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-504eccc8fc8so4795822a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 03:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682247413; x=1684839413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3oR2jR/vrQrziFbROxVUT6HuFzazoTPoyzPiYyzPDjw=;
        b=YuU5pZ4rylSTnFHqxKrtxfbLMtRr5pCPOA1Kj8sYWHb1r17/AbhUfdlGILUTToBoPZ
         5hID9s+VuUC92l0M8isB5Wo6q+u16K5iqtrT9WIEkAA9eRICAwSzkTbHjpB1AASC3RvQ
         rngvsUS3Z6r2KMarel6hjcK73KUTQnbQmpp8Rbtz/+Gq9XtEzBo70DIKbApDXlcsy3FC
         wMALGoKC+Es7XLoXSWiPSGn9/s/uvVLyO9ZzHbnWoz6vlCTJ3fHQy7ECVeI9V0CLvUB/
         yQ2epCEdNmSzQ5GXl8e20PFPUpwtwHQ0RYDwoJquMbWp+vWryI78HUBssdoN+Zi1P22A
         LcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682247413; x=1684839413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3oR2jR/vrQrziFbROxVUT6HuFzazoTPoyzPiYyzPDjw=;
        b=BsFDsCX0h4YDfgWbf7eq+H7ESd4ga9vWGMmfW8mL7PU/Bxq6rKCbNX92yhhaB40f5l
         Ddrlf0+/dlU9Z1PL5BxZukWCIRY0mCHmD/tc9xSKkXCmx4bGsf7sek9wHYQisPS+EewR
         UkCzIS+jGFRXPmszPU/hNxa4nQ1anyWAJ1W1FMcm3AjQrmbqybcCLn/JGkHzQuTlKPVy
         lBeXF3vGX30CjUgYlcF2upC6EaEOFaak3jwH/wk6aMNHhy95i0flg9Ey/EnG1ytJg/8O
         bnWxxu5NJMP+oWoHFTz870U3mBKOdCFBAtZBPY9xy2crvrG5t9ToyyHoEQ01YUbqJGs7
         FOvA==
X-Gm-Message-State: AAQBX9crTpK6EnFFz2i44pUb3WWkQn877Txmr9bzOAczTJBTrUd8Qq44
        UiN5n3m4qWRKI39uOQh5VotXPA==
X-Google-Smtp-Source: AKy350YHSpjSlgKIvLCNAnY834ZVNfHVrLLNfGEV0BO2XWtwfYC20rtmNJ0pCR3RvoID5ybuxj2EIQ==
X-Received: by 2002:a17:907:10c2:b0:94e:aa8e:b56e with SMTP id rv2-20020a17090710c200b0094eaa8eb56emr7696516ejb.33.1682247413469;
        Sun, 23 Apr 2023 03:56:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5d52:d466:d57f:118c? ([2a02:810d:15c0:828:5d52:d466:d57f:118c])
        by smtp.gmail.com with ESMTPSA id n20-20020aa7d054000000b004fc01b0aa55sm3677247edo.4.2023.04.23.03.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Apr 2023 03:56:53 -0700 (PDT)
Message-ID: <c0da0e22-eea4-a03b-672e-fd8a52d02f12@linaro.org>
Date:   Sun, 23 Apr 2023 12:56:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: qcom,pmic-gpio: add PM8953
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230421-pm8953-gpio-v1-0-3d33e2de47e3@z3ntu.xyz>
 <20230421-pm8953-gpio-v1-1-3d33e2de47e3@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230421-pm8953-gpio-v1-1-3d33e2de47e3@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2023 23:56, Luca Weiss wrote:
> Document the 8 GPIOs found on PM8953.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

