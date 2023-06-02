Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F8671FD2F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjFBJKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjFBJJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:09:39 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0162E1729
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:08:05 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2af2db78b38so24770841fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685696883; x=1688288883;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QzUaWnynIThHp3wYMq9RJrcT9lEzhLBhWFn+M0bToOw=;
        b=ZAOEvq4sE8gXzvryPEgB8TuxwcXUVOcc5WNP4MU9pZ7Cm85bTB42QxPJBXBT4QUUM/
         qb32MDwsISGFWjdXkFnjfmMw+P39QAujSCnSI4s/4Wuoz0+xrGzBb+Vq/Zy1dYB94Iye
         ytOXbB8dXBaQq672qdHYQ9L10FE2wBjBwc8CKKeiUdZmSENEUsLWeWC77QsXZT8q8WFv
         WVX69ZUem8W96C3T1sN+Ey2FQOD6Y4VCW4AK6+q7vI/8xBNXjSg4cr+7ro+RCJgWNI/W
         CJ6RKVhdxt06a5CjINrB8QmT32Oeu+0HXkr+D6HPAjX+Q+sV0SDeGWnXrMR1q/9tDiSH
         RvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685696883; x=1688288883;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QzUaWnynIThHp3wYMq9RJrcT9lEzhLBhWFn+M0bToOw=;
        b=GXNNTDk6vTs7D1eA6OxtNtA5Sz2C2UHqqz0ziZUrQpdwXG8Nwe1PzOhlmHMsUbj6Cp
         TZIc4FanMrGkFAcwFPIgKYgksTIiQBRFcyWiUhYCA5Igk1p1p8FJmrQYBKbgHw5cMfUu
         mbzWalL+v6RoUCGkTyI7YNcIqhYmcmzcFNFcpUsGj5hL9ThY5paRekm5CTMCGbCs1ovQ
         +07G8Cu+v1sFbYjtGfDZstR0Qujd8RoXLfb5nEKA2mjBx080dd/1YsuH+FETX/k0zpnL
         8IrITTqB0SAFpW+h+DHFskRe201hveoFUShtaKufbYR+PvhOugTHhVajRIQE2GXoVvH2
         Ijmg==
X-Gm-Message-State: AC+VfDxcT/LtfLgPsaNMhO63S7FqTtR+oikjCNgqoGmGDgoh9Igxpclr
        BdHzMcUZvDtN2Q7yxzAn71DCGQ==
X-Google-Smtp-Source: ACHHUZ6CVTwCKkIVO3jrU3f5xp5gnZ1XgYNwvotAt0SgJIOZpLt/FNEoRI4fgGX7mVnJErOrgqtngA==
X-Received: by 2002:a2e:b018:0:b0:2a8:c82f:2996 with SMTP id y24-20020a2eb018000000b002a8c82f2996mr1316357ljk.43.1685696882943;
        Fri, 02 Jun 2023 02:08:02 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id t2-20020a2e7802000000b002ac87c15fd4sm148889ljc.95.2023.06.02.02.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 02:08:02 -0700 (PDT)
Message-ID: <8f364aac-f9f3-4b85-9718-78f084bdf104@linaro.org>
Date:   Fri, 2 Jun 2023 11:08:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 6/8] pinctrl: qcom: allow true compile testing
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230601152026.1182648-1-krzysztof.kozlowski@linaro.org>
 <20230601152026.1182648-6-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230601152026.1182648-6-krzysztof.kozlowski@linaro.org>
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



On 1.06.2023 17:20, Krzysztof Kozlowski wrote:
> Makefile selected Qualcomm pinctrl drivers only for ARCH_QCOM, making
> any COMPILE_TEST options inside Kconfig ((ARCH_QCOM || COMPILE_TEST) or
> (OF || COMPILE_TEST)) not effective.  Always descent to the qcom
> subdirectory to fix this.  All individual drivers are selected in
> Makefile via dedicated CONFIG entries, thus this should not have
> functional impact except when compile testing.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Should analogous changes be made for all remaining
obj-$(CONFIG_PINCTRL_VENDOR) entries?

Konrad
>  drivers/pinctrl/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index e196c6e324ad..482b391b5deb 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -66,7 +66,7 @@ obj-y				+= nomadik/
>  obj-y				+= nuvoton/
>  obj-y				+= nxp/
>  obj-$(CONFIG_PINCTRL_PXA)	+= pxa/
> -obj-$(CONFIG_ARCH_QCOM)		+= qcom/
> +obj-y				+= qcom/
>  obj-$(CONFIG_PINCTRL_RENESAS)	+= renesas/
>  obj-$(CONFIG_PINCTRL_SAMSUNG)	+= samsung/
>  obj-$(CONFIG_PINCTRL_SPEAR)	+= spear/
