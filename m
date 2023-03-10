Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F299A6B49D0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbjCJPPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbjCJPPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:15:15 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E9B64B0E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:06:33 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id bw19so5304853wrb.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678460740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdcQY2YGeyPPQy3gaq0qhGRWAP9H29xtuBXq8C1jl6M=;
        b=jTYhpaUWOS0KLcMTbjDu9lYUJq2OGSwZfBkhY73vRalTW5os+s5MZL2UzawDfQYL7a
         Hob/yo1F7D4YxP4PJprrIvedfrzca6DSowHQLe8qBOefQJv9ICgYVQLd7L6UMpIjsGZB
         DBopDmlLat19vWY2WJWd3FWbS1TLkG/JE9yaFMWnXcMOnuMYZvlGMvUBzS6B4Ci/7Fmg
         UZVHxaZ9dJZ4nBU9nPepaFFSJ5VwMTnpNu5zwR9uxKRd0s7p0R4dXrAbMJz9C6JYYQnE
         ENWV/gWnueDgvkHScCbV42TnYIfi94wHaKet2mLKVRSgTP6vmJAosg8J033BfpmaJAMn
         4EDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678460740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdcQY2YGeyPPQy3gaq0qhGRWAP9H29xtuBXq8C1jl6M=;
        b=sqLkCpZZvcWC8FMCtUC15nVJdYRCV4V7O3MBvkdhV2jy+nHCcUNNkuqsCaGmPras9s
         Cx6l2+JCT/4XilUSdq+g+MWzyUvfNrMpgIrUS/Q6tFWcNQwFdohJS4nKZ/N3/ClmpY0I
         iBohPjt1OVuIK4FveoUD2TZBprQ2/UESv/slBDMPHvEaJFkL9sqfqJO3cSfc2k8eID8I
         D2dPchGVQQTTtxdKtBRylDtiHLlrUg03SPT7HOz9qt3K6B8no093TIWz+S2VPzCpL87S
         R+R9hREPU7zHs0jmiG1fZWM+ytoAwHcfpGosSUVMn/uwkVC9cY2wmGftn1dA/NKy+pmE
         cSXA==
X-Gm-Message-State: AO0yUKXRbHoc0+2y1U5HkbQEPen0BY3+y2VejH/NagtfIEkG/2+YWKd0
        IPw+o5GIP/F6lW49Myj9T6OA9NXHOHI9IXZ8NQg=
X-Google-Smtp-Source: AK7set9N3trIQyBm2KMQV9Jy+uSYSg+mAaFAV8EfXjLeyi5NBrpk5ACECqHayrpTCwDFHZu1AoPRFw==
X-Received: by 2002:aa7:dcd7:0:b0:4ab:49eb:a8ec with SMTP id w23-20020aa7dcd7000000b004ab49eba8ecmr22958818edu.26.1678459882763;
        Fri, 10 Mar 2023 06:51:22 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:45c4:46be:ec71:4a51? ([2a02:810d:15c0:828:45c4:46be:ec71:4a51])
        by smtp.gmail.com with ESMTPSA id y59-20020a50bb41000000b004f0de6d52fcsm102483ede.74.2023.03.10.06.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 06:51:22 -0800 (PST)
Message-ID: <6b6b5dc2-43ab-5672-099f-505ab4543438@linaro.org>
Date:   Fri, 10 Mar 2023 15:51:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/7] dt-bindings: clock: exynos850: Add tzpc property
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230308233822.31180-1-semen.protsenko@linaro.org>
 <20230308233822.31180-3-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230308233822.31180-3-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 00:38, Sam Protsenko wrote:
> Exynos850 requires extra TZPC handling to keep CMU registers non-secure
> (accessible from the kernel) after PM resume. It's done using a specific
> SMC call to the EL3 monitor.
> 
> Describe "samsung,tzpc" property for Exynos850 clock controller which
> allows one to specify the SMC call address for PD capable CMUs.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  .../bindings/clock/samsung,exynos850-clock.yaml        | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
> index cc1e9173b272..5098dce5caf6 100644
> --- a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
> @@ -60,6 +60,16 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  samsung,tzpc:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The register address in corresponding Trust Zone Protection Control block
> +      for setting the CMU registers access to non-secure. If provided, it'll be
> +      used for issuing SMC calls to EL3 monitor during CMU's PM suspend and
> +      resume operations, ensuring CMU registers are unprotected after waking up.

Do not store register addresses of MMIO in some fields. If this is part
of clock MMIO, then it could be address space in reg. If it is not, you
cannot store someone's else address space here. If this is someone's
else address space, then you either need syscon or phandle to dedicated
device (something like qcom,scm or other secure monitor channel).

> +
> +      This property is optional.

Drop, It's already optional if not required.

Best regards,
Krzysztof

