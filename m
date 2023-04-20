Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA23E6E94F8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbjDTMql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjDTMqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:46:37 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215C46595
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:46:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-504fce3d7fbso771516a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681994787; x=1684586787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Pk+Qd6CawbTTrnrThoEZ+rKcvpmzyvfeT2caixMXgc=;
        b=pt4CgUgmnJh+NSe0Sg6CpH3AFJLD0T88/IDOQu6XkDZn8bZKvj3uIUrLI3Gx7MycDA
         vilWwLsIcaDA+6fFiongQoGezPla2uUsq2zaxaBo5b1j2yrm2/ZmpDhgRyJZuIkgtsap
         4Izh8cAANyyV1C8syere6nbtHrDZOTXifwjApfWSH3a5Oxo2saAm6UAK8s7E4wFrJPN9
         qC0MlWSKL4UcNn8XbTWUq4n6Ir+HF///NpF1GDtCYM7kytocFqpzV8qd8e6YBFTcYMHI
         jTBew8BcO6bZuqK6DCTUzToa0NJP/OeTgPiHsoN/nH1oiiMl5fc12m6k0g6eqlRunPE+
         sOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681994787; x=1684586787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Pk+Qd6CawbTTrnrThoEZ+rKcvpmzyvfeT2caixMXgc=;
        b=Gl5bVJX/Nqdspm3XZOq/4wuoVgohJ8Oaq3Bnm9wtCT93FC2zwMYSm1friDCFBUVdx+
         7XQT56GIHuXHyxNszOnpU2bANTUIH1gmQ7R5EupcrOHF/puz0mEHoP15dlJb1/vKH+wq
         BmEKndLfZklB6SJRznGsmVBzz1619JtGs+8eQ7B1NUDwtxrxHkaib+UNAduoUFz6Em5o
         Dl2dNwLETMLock43o67wzAgrBgBXjAlYs+4KjEShFjZ+2OAJkHXm0PgR/lstX5KSBtT+
         1Bn36i1yRTap6SWLf8naeQOzug2GHodqF9cUpEXO1uJ78ob7n2mPAgvR0E3JoTGH9Mxv
         5N1w==
X-Gm-Message-State: AAQBX9dHLjJDxwhnCYbOWgQlmPGoXy3uIiG9y5kGW36/jHlploCKPCyU
        g6NYRfGi4ypuW+/IN+AALw8Xpw==
X-Google-Smtp-Source: AKy350aCSVYHSTuRUbzqbqVKTM/wg1iw4BBaWxYl6hWz5ML/lQxQgFTB3JDFFaFTSk/LwI9FSxHkEA==
X-Received: by 2002:a05:6402:1807:b0:504:8173:ec8c with SMTP id g7-20020a056402180700b005048173ec8cmr1853289edy.13.1681994787577;
        Thu, 20 Apr 2023 05:46:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bcb8:77e6:8f45:4771? ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id r22-20020aa7cb96000000b0050696c2d2f6sm706788edt.88.2023.04.20.05.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 05:46:27 -0700 (PDT)
Message-ID: <73644f38-8165-f041-f9d7-a2f2bdd69f17@linaro.org>
Date:   Thu, 20 Apr 2023 14:46:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add SDX75 pinctrl
 devicetree compatible
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, richardcochran@gmail.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <1681966915-15720-1-git-send-email-quic_rohiagar@quicinc.com>
 <1681966915-15720-2-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1681966915-15720-2-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 07:01, Rohit Agarwal wrote:
> Add device tree binding Documentation details for Qualcomm SDX75
> pinctrl driver.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  .../bindings/pinctrl/qcom,sdx75-tlmm.yaml          | 195 +++++++++++++++++++++
>  1 file changed, 195 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdx75-tlmm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx75-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx75-tlmm.yaml
> new file mode 100644
> index 0000000..1d03f13
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx75-tlmm.yaml
> @@ -0,0 +1,195 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/pinctrl/qcom,sdx75-tlmm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. SDX75 TLMM block
> +
> +maintainers:
> +  - Rohit Agarwal <quic_rohiagar@quicinc.com>
> +
> +description: |
> +  This binding describes the Top Level Mode Multiplexer block and found in
> +  SDX75 platform.

Please start from some existing bindings to avoid all the issues we
fixed. This binding does not look like current ones.

Best regards,
Krzysztof

