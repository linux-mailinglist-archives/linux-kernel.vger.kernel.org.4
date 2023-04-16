Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E706E3681
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 11:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjDPJMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 05:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjDPJM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 05:12:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4705E1BD1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 02:12:27 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ud9so56415143ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 02:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681636345; x=1684228345;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwM8RzXXHOEUyCag2xnFM/XLXIGexTVEtmhJCwM3MOw=;
        b=prlpI3x/8BglFmW6LK06SM1lwdhkXve3v2C/KEl+jyvTdBMH3reXhut5a5z3FDIwNK
         IYQjYbXLjddkb/tXaDLEMKNIuRE29TTCJtEg7kM5dDvkFpp8dbTLr1QmyZ0EieU28SAu
         dNmIozVlBKx/cUsF6jydzZaMjWDCpHNbW5x0GtFwTSCg1On+Kd2wjKlJLHxK3mxxUGY9
         9CgXRZ6tZOxLy9NdcePT9Q9T5aNWQjb560tMhXKKQlfQPF8A64/F1TBjXJYPk1e7Uoon
         r+DVGiOvWTmxEQTJfOib9uvTEkOTK5XpDsmEoIj58Ds04rQ3vqCiFYCgdjD97a7V000F
         RI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681636345; x=1684228345;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwM8RzXXHOEUyCag2xnFM/XLXIGexTVEtmhJCwM3MOw=;
        b=d0aUOwJxqYP0H392OxoCXkVM2CrphTLk8XaY4GQndfMRs33U/G+qkQrGPntBoRR4dx
         KTErFnPpHySwBU8xjW2BuBEnyIpu3DXnPHRkyX4ifiJphwzvOWDYYjIjizuM90OrXp/S
         +847wZUmVZ/a2x7lvRxCvIuSFYFV2lYt7Dj3kWDiEbbwzE8QN3pLArNdS42+CaFF/QV/
         cGw38pWD+39223izFwlMXBH1RIlC4Pit2eelrTY+NmY5mnGCqUl7l8vkrzVEw0q1Jgt/
         LSX07ofCRPt7DcZ8TRMl420SzQM82qzSufbc2vCdkgl+SU0uQXYqYLsns9p1yJoE2zgb
         +hlg==
X-Gm-Message-State: AAQBX9cXqh4LkqsImud4b2W/nFwFkBi9JFKWU8iVK7rlJt59fjTaN50p
        vBvwvon5bGR90hDDWW1DrQDxTQ==
X-Google-Smtp-Source: AKy350aAz4/lvUhtDCrVLib6n1uhBytZ37hkMSVT8CnMGYL5w01Yk/CuFGoNLxTvxM6PZ8iKqheCiw==
X-Received: by 2002:a17:906:6992:b0:930:6c71:64eb with SMTP id i18-20020a170906699200b009306c7164ebmr4048092ejr.29.1681636345690;
        Sun, 16 Apr 2023 02:12:25 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id ud7-20020a170907c60700b0094ee700d8e4sm3208048ejc.44.2023.04.16.02.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 02:12:25 -0700 (PDT)
Message-ID: <ce9c90e4-47a1-e5c7-0b71-56ffa7cdd1f7@linaro.org>
Date:   Sun, 16 Apr 2023 11:12:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 5/9] dt-bindings: qcom: Add ipq5018 bindings
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1681468167-11689-1-git-send-email-quic_srichara@quicinc.com>
 <1681468167-11689-6-git-send-email-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1681468167-11689-6-git-send-email-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 12:29, Sricharan Ramabadhran wrote:
> Document the new ipq5018 SOC/board device tree bindings.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [v3] Fixed board name
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).


Best regards,
Krzysztof

