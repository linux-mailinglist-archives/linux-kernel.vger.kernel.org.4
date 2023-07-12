Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B97E750AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjGLO1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjGLO05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:26:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2271FDE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:26:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31454996e06so6672698f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689171961; x=1691763961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HEPJI/E6yV3CwO+VdDjiz+PSHejgEU2vfzm1SMkxH3A=;
        b=MPvAzmlWoXhxb83qkX6updmUHVNt6xqD+HTUX3IEEzEq6y4XQ+C0QukxCAjG7N7YXh
         6cua3p7y45ZFi364PwWYwwgvSUnceZjZsyza5cxn2+L0Uu/a4N79uOt9Tws84TlpWCsR
         ZUPXVeRtNWmuUoFcDBygdKjchpZCsfVwR2dWAuwhSpQLiB4LSfOCQk/4YaiwLVM+yTir
         rnmUzfyADo1wFalUtneM5cI6Lzsv45IseAFTtWYWtB/eyf4lVn4LfcQTs+j0/TtSJkM+
         8x2CrhLnqZJ0F5BF+o8w1STOgQKI/Fy2moZti7GKs/zAzMY1wdnuHuRl600+6xmbvBe8
         gjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689171961; x=1691763961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEPJI/E6yV3CwO+VdDjiz+PSHejgEU2vfzm1SMkxH3A=;
        b=JNnU7HcjF6wFw1LMCEQ6C+Vo+S/8HiHmtHJux0gg9vmVyA/AtglGrXsnzEPxIAyVXw
         T4O3YhrV6ogeHtCA74muNz2k3cvswvjI95+YMm+E8mpIkEFxUWW7jNi9XiBN/kuWLtDR
         iA5XMF/rHF7KOtgR1gNUBa4fSCNXlhdQrT+8uYwF6easyF3UCp39EV0EvPOavWABKvPh
         A1ukZLL1dGcDBrXSMiNZz5NJKdvGzC7ZRLumluOzHOZCMWIktwtmp9Tf6QP91VyZYlQ4
         YwNwR33CHh5U5UZiYP6WmjS/QAeQ3m3jqkFkrxXoESabUmzoX43qmhmObIxIVCrY1/0k
         x8fw==
X-Gm-Message-State: ABy/qLYIuUAqLF/ALitj2LOfenyMBOAtke3om/yyUxTbBcdWu8/A/o9V
        NtWJ7CxyWf8BcQtG+Cux+jRuTA==
X-Google-Smtp-Source: APBJJlGLXkhnOaeBdMql99Dv42UdfZYy1MTsg1+Orh629ImTzsLh7CydO13AirJ2jx/fTgJiHJvgjg==
X-Received: by 2002:a05:6000:c9:b0:314:25c6:7f6d with SMTP id q9-20020a05600000c900b0031425c67f6dmr17456989wrx.14.1689171960822;
        Wed, 12 Jul 2023 07:26:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id y24-20020a170906471800b00992b71d8f19sm2631576ejq.133.2023.07.12.07.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 07:26:00 -0700 (PDT)
Message-ID: <f31e9ff1-807b-c252-6f7e-146aba844fd9@linaro.org>
Date:   Wed, 12 Jul 2023 16:25:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/5] dt-bindings: thermal: tsens: Add ipq5332
 compatible
Content-Language: en-US
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, amitk@kernel.org,
        thara.gopinath@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com
References: <20230712113539.4029941-1-quic_ipkumar@quicinc.com>
 <20230712113539.4029941-3-quic_ipkumar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230712113539.4029941-3-quic_ipkumar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 13:35, Praveenkumar I wrote:
> IPQ5332 uses TSENS v2.3.3 with combined interrupt. RPM is not
> available in the SoC, hence adding new compatible to have the
> sensor enablement and calibration function.
> 
> This patch also adds nvmem-cell-names for ipq5332
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
> [v2]:
> 	Followed the order for ipq5332 and added nvmem-cell-names.
> 
>  .../devicetree/bindings/thermal/qcom-tsens.yaml      | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 27e9e16e6455..cca115906762 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -69,6 +69,7 @@ properties:
>  
>        - description: v2 of TSENS with combined interrupt
>          enum:
> +          - qcom,ipq5332-tsens
>            - qcom,ipq8074-tsens
>  
>        - description: v2 of TSENS with combined interrupt
> @@ -205,6 +206,15 @@ properties:
>            - const: s9_p2_backup
>            - const: s10_p1_backup
>            - const: s10_p2_backup
> +      - items:
> +          - const: mode
> +          - const: base0
> +          - const: base1
> +          - pattern: '^s[0-9]+$'
> +          - pattern: '^s[0-9]+$'
> +          - pattern: '^s[0-9]+$'
> +          - pattern: '^s[0-9]+$'
> +          - pattern: '^s[0-9]+$'

Previously there were 17 items here. What changed?

Best regards,
Krzysztof

