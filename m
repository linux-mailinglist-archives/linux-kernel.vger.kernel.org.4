Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580776DE2B6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDKRhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDKRhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:37:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1385FFA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:37:31 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94a39f6e8caso213441466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681234650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e67OsrA9U7cNgwhSbSkMjvtmDyw6VsiFX86RzKi5f8Y=;
        b=QVHjkeWsh4Yg8ah0fHhi8JaLOgDmKiCYyETDUHjbA3d1CUf5Xum4mC5O/fBT8rfRb8
         vVifvyTwFffiwjKRFdFU3nSNFCyHTDT51IxHOJxvox/Hu3XM0PkKqGxlcQeb7yfHZsro
         aLSspmmbpsv15cOzbjeTC0WFW6lQrFjd71+zpv7h/nuPb7gqa4I/NG+y6sc0aBDJ4n9n
         ApH6Gh11aE0tbMzD0rZkyU8aW2E6MUiGZlOVykUMxt0i9VPNKFVdelWSrnEsJPaa34dE
         nHaNZz5Ds1m+WF4jEVGM2aZRlZX3duKlyGod4RlmUWD2rhQmAh59nzxmio/24Nb6zb9T
         Ll3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681234650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e67OsrA9U7cNgwhSbSkMjvtmDyw6VsiFX86RzKi5f8Y=;
        b=pmyHV9+tsMPYcASo8GUlzGJKFbcoI6FRZQdXb9WCuYOv13/K4ML8pct/9qKN72ff5g
         +L6pFhOMaYAA0OB68n+82PyOOJcp6UoAW+q+15W/1KRMYHjxygB/rNfTIQC0V6jJHpJw
         GgvsSDl0Zj1Y52TbmWM7VU53Gs6+zPkZ6t7mUqRirVm9TohnsuqYF/fkPWCtJiamtBBD
         s8N3k6qhKQDv6KzmkfbOgcLwDpn7jTtRwAGOIRxeyP1k+AuSlf3ipJVQJAprcTu8d6BA
         2ZpEUIXeC3oYbkXF9XnDFwJonpnkxT/MLAQrhmlWqUGCajzmLxsWOxDTVfKOJ//Ql3To
         +91A==
X-Gm-Message-State: AAQBX9dYV2a/UUc04Zg9kwReDktfQ49X7yv4/M5QGPKbcQ4n5wqCBnDW
        tu6leGaqYv7s8nLo0CRcg9qjFg==
X-Google-Smtp-Source: AKy350aCNa8PaJaXlZDqiO1amhq7ZH2fusJyFHDanpTvcAqTuWnv9TyCA4AnR/a2nBWV3hLkkd/d7g==
X-Received: by 2002:a50:ec94:0:b0:4fd:2b0e:ce87 with SMTP id e20-20020a50ec94000000b004fd2b0ece87mr9084703edr.24.1681234649741;
        Tue, 11 Apr 2023 10:37:29 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f1da:c117:3657:c8a? ([2a02:810d:15c0:828:f1da:c117:3657:c8a])
        by smtp.gmail.com with ESMTPSA id q11-20020a50aa8b000000b00504706aa54esm5665407edc.57.2023.04.11.10.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 10:37:29 -0700 (PDT)
Message-ID: <f12d50a2-a9b0-5659-4224-2b7039ba058e@linaro.org>
Date:   Tue, 11 Apr 2023 19:37:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/3] dt-bindings: power: qcom,rpmpd: Add SA8155P
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
References: <20230411-topic-hanaau-v2-0-fd3d70844b31@linaro.org>
 <20230411-topic-hanaau-v2-1-fd3d70844b31@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230411-topic-hanaau-v2-1-fd3d70844b31@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2023 15:47, Konrad Dybcio wrote:
> Add a compatible for SA8155P platforms and relevant defines to the
> include file.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>  include/dt-bindings/power/qcom-rpmpd.h                  | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> index afad3135ed67..f9c211a9a938 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> @@ -29,6 +29,7 @@ properties:
>        - qcom,qcm2290-rpmpd
>        - qcom,qcs404-rpmpd
>        - qcom,qdu1000-rpmhpd
> +      - qcom,sa8155p-rpmhpd
>        - qcom,sa8540p-rpmhpd
>        - qcom,sa8775p-rpmhpd
>        - qcom,sdm660-rpmpd
> diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
> index 1bf8e87ecd7e..867b18e041ea 100644
> --- a/include/dt-bindings/power/qcom-rpmpd.h
> +++ b/include/dt-bindings/power/qcom-rpmpd.h
> @@ -90,6 +90,15 @@
>  #define SM8150_MMCX	9
>  #define SM8150_MMCX_AO	10
>  
> +/* SA8155P is a special case, kept for backwards compatibility */

This is a new binding, thus I don't understand what is here backwards
compatible?

> +#define SA8155P_CX	SM8150_CX
> +#define SA8155P_CX_AO	SM8150_CX_AO
> +#define SA8155P_EBI	SM8150_EBI
> +#define SA8155P_GFX	SM8150_GFX
> +#define SA8155P_MSS	SM8150_MSS
> +#define SA8155P_MX	SM8150_MX
> +#define SA8155P_MX_AO	SM8150_MX_AO
> +

Best regards,
Krzysztof

