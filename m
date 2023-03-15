Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D536BA8F0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjCOHVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjCOHVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:21:18 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4685AB78
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:21:12 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x3so71629045edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678864870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ozR0dnqnJVp0BhWFNtiQ9uNm8JZDF8pkJ8MCkHvyY9o=;
        b=bPtJfDFvUiUczE1oDcphFrtGfzybJ+GtT3roYXYiD7BKtGzqLhKO1dYTGLgQggtBZC
         sf9/zhUnw+InkJoSLs8kicjxpWYRyR1uYuSVRKugyy1rzfVU65DW/b3u5XJZcSyXE05v
         lD6Wh3aBQRPokpSiTxpWx3ajoxSUfKZHkYMRE1tTjCQg4u7goqz8sxJ0FtSA9fS4aTjp
         mVY8YoEOsI9p7kVZLRVgnrUP6CmEnoFYDTyI25CWi3r9NCoq9ewQlT6wO9VNVtNTQUUO
         ha+4tZ4Gl1Alkc84fnMjsBu/7nw9HhnJ0yblQkkIVjnLdaSxsX3bDG79CWHiO2B2mHHU
         dkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678864870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozR0dnqnJVp0BhWFNtiQ9uNm8JZDF8pkJ8MCkHvyY9o=;
        b=u0rnbnBgc0RZI5v2wv5xDGX3RVtGoCRxMH6NzwbKlkSeOXn/Ny+we70MZaHq0IePqa
         brAuRaUNR63mKsC8RNmv2uGfbUJ3jFBQma70YDPZWec72KWhU79bMfalcFNMpucvZG0y
         hVzpJzSFlO5Nl5SRI+bzgd84fw3DsYlxDF0GVMbmQPoXvVnS7pVOazWyWRwSd6FL2dww
         XWCzyjIjNz4FIDThyezWnZphedB4YcE1AXQ7djGe6Ig+rShMRqkvCOMUv2XjB9w+Ryxl
         t/OfsZ5nruCDVzhgcC3Ay3D8iOcrxt3sqOuXJ6Z077IYdqrDpOtnUGfAf5c4Z/gCjjot
         bIVw==
X-Gm-Message-State: AO0yUKVvRN2puEVEutZb/xgd8XgiKPP5VNRa4cQ0/lEAGSzfDdteBf8/
        u1fI2ZDP5f6ZgXBts9reeTGFJQ==
X-Google-Smtp-Source: AK7set+tTTuF2Ln4iUAaub4ZI6VDeCChGk/zyzpT6o0EnVUWmuOlHgrEHzbo4nPYtVK6Xv5L8jB/TA==
X-Received: by 2002:a17:906:8494:b0:87f:89f2:c012 with SMTP id m20-20020a170906849400b0087f89f2c012mr5638543ejx.24.1678864870206;
        Wed, 15 Mar 2023 00:21:10 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id op13-20020a170906bced00b008c607dd7cefsm2093286ejb.79.2023.03.15.00.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:21:09 -0700 (PDT)
Message-ID: <aa7f656c-d022-7b7c-3f30-ce92f219c94e@linaro.org>
Date:   Wed, 15 Mar 2023 08:21:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/7] dt-bindings: interconnect: qcom,msm8998-bwmon:
 Resolve MSM8998 support
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230304-topic-ddr_bwmon-v2-0-04db989db059@linaro.org>
 <20230304-topic-ddr_bwmon-v2-1-04db989db059@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230304-topic-ddr_bwmon-v2-1-04db989db059@linaro.org>
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

On 13/03/2023 12:41, Konrad Dybcio wrote:
> BWMONv4 has two sets of registers: one for handling the monitor itself
> and one called "global" which hosts some sort of a headswitch and an
> interrupt control register. We did not handle that one before, as on
> SoCs starting with SDM845 they have been merged into a single contiguous
> range.
> 
> To make the qcom,msm8998-bwmon less confusing and in preparation for
> actual MSM8998 support, describe the global register space and introduce
> new "qcom,sdm845-cpu-bwmon" compatible while keeping the
> "qcom,sdm845-bwmon" as a fallback for SoCs with this merged register space
> scheme.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

