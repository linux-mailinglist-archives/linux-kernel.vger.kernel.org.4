Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE206B2161
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjCIK1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjCIK0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:26:48 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ABA62312
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:26:46 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ay14so4891943edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 02:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678357605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7UvRHrlPFNZwTOdTmt50MLtXRI21jvB48iIaZrT4A7E=;
        b=KginEDdZfchTJ5dXVLc0hNfhYS/GGpxPri+/O9+kIUsdO/LmNztwNBwc7ho4WUAhY6
         A3r9loSKmHA3CniNdfULSmQVsYDjv9FV297jbFf29JiNxoQjGkBo8i9iavG+RYdtOZj1
         jF9FyarWmn7ytZNV/O3+5sOMaQgki/iNd3wHr+Fd/EMBTxGXn6x6cCVftSNGGRI6mYZJ
         ZqWRj5oHb8cHEEGmy/m41pxGtOzq4eAFA6mSUEE3/NYX3Fe3bEOa2JBOW7B8jZYHFR5K
         dpxfsB22kmAEcGzGi825wRwPY8Da2HCP/FrKeG65RMBq6HOw22v8hmfQoqpTF35WV/Fw
         cCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678357605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UvRHrlPFNZwTOdTmt50MLtXRI21jvB48iIaZrT4A7E=;
        b=wzEnW7gzGvF2IZm53n6z/uIUqC43EolwFaG7PTOzDDD6P/tESONzz6xgF4I0G1E5ov
         cNPVXhZrL/tehc21Hrc+8KXJV2amV9KyZp/0aYT/NX3uygAdDXn1pBilSyjEH+3+xEN5
         101cqvBoMv2Q/zT9A19hFnDLfIuIzoHzVnJbf3SfSs/M7Yae3zFdrSUD9hyFkuEW4957
         JU6XTD01zyEPyMALMsMY4IcDwaxHP5C9NAmJdsAYGFm7NwshsNhtQFBcIkpPKnYG7ZqD
         Ukm0lKf1k28rLxQdPGRLQymAsOVvZvE7Ns1bXBOa/GA5CC+sz0m0M2OlIPYC+MnfJMBv
         GuOQ==
X-Gm-Message-State: AO0yUKXTFiuhaYjEUYrIZEKvC1yFNx9SYpuxo9xBefp3HqpFAqe2tNmn
        MzzCXjD1NAaqP6ky1+awr6cYDw==
X-Google-Smtp-Source: AK7set+FlVqc46GKO7BW/gCMjD+SaZ7Ha8KNF/gWLOeGf/XR1Yp4ON/p3fCQ+Cz90UPlJgjtTgSoVg==
X-Received: by 2002:a17:907:7f0b:b0:888:7ac8:c0f4 with SMTP id qf11-20020a1709077f0b00b008887ac8c0f4mr21207859ejc.25.1678357605387;
        Thu, 09 Mar 2023 02:26:45 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id ci25-20020a170906c35900b008b23e619960sm8659929ejb.139.2023.03.09.02.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 02:26:45 -0800 (PST)
Message-ID: <c57e4a3a-3787-7058-f271-30f5b9d08e29@linaro.org>
Date:   Thu, 9 Mar 2023 11:26:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v2 2/7] dt-bindings: ufs: qcom: Add ICE phandle and
 drop core clock
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20230308155838.1094920-1-abel.vesa@linaro.org>
 <20230308155838.1094920-3-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230308155838.1094920-3-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 16:58, Abel Vesa wrote:
> The ICE will have its own devicetree node, so drop the ICE core clock
> and add the qcom,ice property instead.



>        properties:
>          clocks:
> -          minItems: 11
> -          maxItems: 11
> +          minItems: 10
> +          maxItems: 10
>          clock-names:
>            items:
>              - const: core_clk_src
> @@ -177,7 +180,6 @@ allOf:
>              - const: iface_clk
>              - const: core_clk_unipro_src
>              - const: core_clk_unipro
> -            - const: core_clk_ice

Order is fixed, you cannot drop entries from the middle.

>              - const: ref_clk
>              - const: tx_lane0_sync_clk
>              - const: rx_lane0_sync_clk

Best regards,
Krzysztof

