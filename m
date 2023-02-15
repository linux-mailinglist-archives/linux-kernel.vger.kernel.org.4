Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B7B6978F4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbjBOJ0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjBOJ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:26:25 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A483757B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:25:43 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso990161wmo.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lRaz9F2ndu1/Zzg0HAXs4+stqA3VUbDuTuUhJDAoGm0=;
        b=oZDj+NVqsSmEJ5xdIf2TEYmmgUNCK6zQP03WEdPsHXYTmzbEg77rO75MQ1ymaqHtkK
         u8t7eOltDCyuMAndy09UOb2WYFu/beEnNT8JcnvuZUiUFH50NYqbyeP4SOqqPxqLFPtr
         IzWTR0DZderEsuIHzDLvEZcJl2Plcb6Y8URrctPSeIWS4qZ+AuvbiDspjn9Npj8am/dQ
         XhOHi3ZKE/MqOnYhlSMkvRh7MGGJLHmiet+xq6zgt4/rWbSMSRCfpnIiC/48goxqgG7W
         mTYQKQ59JXmjtSzXXr43XG6lAc65VQ7YBm16Qd7peAQDfaI+vhC9OiAiE025LZn5L8fS
         t2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRaz9F2ndu1/Zzg0HAXs4+stqA3VUbDuTuUhJDAoGm0=;
        b=g7QDeswB8p778qTNO3oqcgBJbI/x6p/df91TBtp7F/rrrTwIv64J0eF2oNsjoFpqc7
         JDu7zH8Hw0y3zeLauJdvt4yj7dfE4IIFQVmMF4i0g7VMRP/bYrLnb+hEolNSYDgTtM0J
         cZb7GoSyJ4atQFxqRTaORBcsbH2LCC23pJmKInVh6+BOxRVUF6PVuYJ58JXuA+o/KFrh
         xUSA03sIBBIBiypDjdYYAFE2k8igThfqMTYEYZNNmHUIuHi2F1yib+0NgnKUuJaZKoLl
         Usb2/GhUdogBU7UgM84w+r284YcUR4S6cvirSxGMwos6gfaly6PNKbpha2bajjzgKg+S
         uriw==
X-Gm-Message-State: AO0yUKVokPbhNMPMGkKH4zUczz2xrHapBx4B+I5AA4HWeOQI6Osz2xyX
        A3F+hCDwzFfMMBhKNryLhFuEPoOJGrbaCGAw5Rc=
X-Google-Smtp-Source: AK7set+MPgZiuLq/e8s82IBTD7f+ZJIhVUc3Y4h6gzu5gjWm0PGQysGvJd756SDP8P0/8jSvtDzwcg==
X-Received: by 2002:a05:600c:4d15:b0:3cf:7197:e68a with SMTP id u21-20020a05600c4d1500b003cf7197e68amr1675557wmp.18.1676453139517;
        Wed, 15 Feb 2023 01:25:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:7fda:5fd:df14:bb65? ([2a01:e0a:982:cbb0:7fda:5fd:df14:bb65])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d550f000000b002c55ebe37ddsm5674783wrv.115.2023.02.15.01.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 01:25:38 -0800 (PST)
Message-ID: <f6f81af2-00ec-a75b-0e9e-a1eaf649edf5@linaro.org>
Date:   Wed, 15 Feb 2023 10:25:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] dt-bindings: qcom,pdc: Add compatible for SM8550
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20230127132558.1176730-1-abel.vesa@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230127132558.1176730-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 27/01/2023 14:25, Abel Vesa wrote:
> Document the compatible for SM8550 PDC.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> The v1 is here:
> https://lore.kernel.org/all/20221116114210.2673902-1-abel.vesa@linaro.org/
> 
> Changes since v1:
>   * rebased on next-20230125
>   * added Krzysztof's R-b tag
> 
>   .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
>   1 file changed, 1 insertion(+)

Do you think you can pick it for v6.3 ?

Thanks,
Neil

> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
> index 94791e261c42..5a733bd76b57 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
> @@ -37,6 +37,7 @@ properties:
>             - qcom,sm8250-pdc
>             - qcom,sm8350-pdc
>             - qcom,sm8450-pdc
> +          - qcom,sm8550-pdc
>         - const: qcom,pdc
>   
>     reg:

