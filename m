Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663D1654D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 09:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiLWIV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 03:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiLWIVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:21:23 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A22A34D13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:21:22 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bf43so6192857lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+a3E/WsPht2OzFwjCL5xU/bureLMTsu06UItSpCOeI=;
        b=gYlcHa7/P3MqkCaku/u5VWO4JjTkTe9UtThg5QFuKr2GukWCj2kAhaiMiOvCBBBd6f
         GLaOq8uYxKuBRsK4y925kG6ZXRH1fKjLbYikSenfrZgpm9owLK3V037Px1tfarNcoGkr
         HORH/xHQGZe4Lpyjq0q5YBthSvhm4p9Wz4OAK3wdmSqWJ8/xpW6UIHeF/M7AFt8gTyf6
         oRpuXKBSmcGvzK7Bbts5PfVWG5b1WRXCWu3QhvSmxA4K3mbkbtTq3O2tqmaTVgmK5v7T
         mWJITwgEKNx/rBpJzAGHr/v+Of+QoWGwjcJWbAUw+SWcsJvfUZzubfIxdeib+j/sRCFV
         6dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+a3E/WsPht2OzFwjCL5xU/bureLMTsu06UItSpCOeI=;
        b=PavgpVS2GjZB1Ya4Xtu1dvJJwlMbTDxARWvSB6ncDjuK0hprpGuPAg6qojEhD8tAaK
         nF7DVG4eNmBMQdw5+xSZAJlKOTKv37j6COvlwAoVaMCrrBSR+SMCI/Ml4VWwfaYJmeVL
         CpkiAU/1GUeDsK/As3OzMcfqvPuFqtgRTbGVBu2UsHHBHLgfXbZhrxQDSdErHFUSgXIz
         RCCObLCBndTZYfydQfSx+ObAGunzXbeW74M/vl11vlms1n4Km0td0E3MnkMJcWIYGZA4
         wtrtIw6j7aIuCfMYcZmWTEi4MCqdYPBW5z3tbBWK6nHRIc8PsB/ATMVnoN9/83D4Ypnt
         SKRA==
X-Gm-Message-State: AFqh2kr0pxzUxJKcvG14UiBZ/Y8i7MTjqvzkJusJINwPvdQwa1ubCFLk
        ibc5Yr/HEie81Iy9fxQJKgNFTw==
X-Google-Smtp-Source: AMrXdXvwJCJKbgnY/TzJ7r09IRwavsCP0pYsBXAK2+HyDem66Dnw9GndXvejtz8/3+6YZjtrTmyKsQ==
X-Received: by 2002:ac2:59da:0:b0:4b6:ea42:de0d with SMTP id x26-20020ac259da000000b004b6ea42de0dmr1948549lfn.39.1671783680552;
        Fri, 23 Dec 2022 00:21:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e29-20020a19675d000000b004b5812207dbsm426219lfj.201.2022.12.23.00.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 00:21:19 -0800 (PST)
Message-ID: <089247cb-9723-6834-bc6c-cd795ada87c6@linaro.org>
Date:   Fri, 23 Dec 2022 09:21:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 1/4] dt-bindings: arm-smmu: Document smmu-500 binding
 for SM6125
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20221222193254.126925-1-marijn.suijten@somainline.org>
 <20221222193254.126925-2-marijn.suijten@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221222193254.126925-2-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 20:32, Marijn Suijten wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> Document smmu-500 compatibility with the SM6125 SoC.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> [Marijn: Move compatible to the new, generic, qcom,smmu-500 list]
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

