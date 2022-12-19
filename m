Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CA1650911
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiLSJHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 04:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiLSJHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:07:22 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DC0BF7F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 01:07:20 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id p36so12640710lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 01:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L4tpSk+tjYm0GwOPhGRXLIEBiSIOkO/36qvtptczgjw=;
        b=N3oFLtrcYYoltNNztEkRCstMhmF7L/B1dnooX75CzPsUn+NB8JbGvQdJ++Vql486rF
         sefNxpApu6gMAkVRZOYes5d3WqLsgDYrPWXIykFUNwYYPYntjL7zQN/Yhj84qQ9yoiOq
         za7S99D23KoxgXtbD8tcKKJM6ms0CopXhQBeC/57fZXbvDUvweuKwwtELoDksuGGEnXN
         xMA4hzwsvuWl0iJx4kqAGSdbI2IBE6c3UtHU8lwq8qaa4WXjxWha0/uYfo266NJHaDjJ
         hXNkPR4WAkVmQWhue7F5tmilGwwmT1Qz3/wvZnTpuPGZ8ofXrIqRmnAPPfHGg+Hw1acY
         dv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4tpSk+tjYm0GwOPhGRXLIEBiSIOkO/36qvtptczgjw=;
        b=vLD3VMW5OI8rXcqKlc7gNez2vmqd4izrQ2oY1AI9WbOU1JFTj3lk4DPk2GKR0NvC0U
         o+Espu4nxPTDfZ0/x77zb3spq9gx7ShvmL1CHy2zMg9am8IlivVpqpwLt2qvE5bIwQs6
         lHB2GX3uxl84HG1rLPddcq0LfBrcTu7/am/hYqn59lTqbFaMJZ/74TIfbeJ8PoyX3QFE
         CzkkJ9omntzIlRuWg3Kfd+TjkcHZgd7K0Zs0eXQ8Y2PhSLaPYyhCe1PKnivq50bhsc0M
         gavyNadRZ/PnT+5EQnt7pFF5Ru9aS4C0tDlJRTt/4k0+gR20oTK4kJYOMCTJzbrUj9ZB
         LfeQ==
X-Gm-Message-State: ANoB5pmsqS4lrGiySukfW9aHRpaE8eYYM8l7XeOSaAbNn9Lc5IDCL8e3
        AfirC9ezhtpbt49j2d1nNZGvqQ==
X-Google-Smtp-Source: AA0mqf6yerJKFHzLlNexb6x/HD/ZwWzG43qKAdQsx9Tu5MD1hdnY7UrOWDYeXeOGe3TiRLg+e8ZbFw==
X-Received: by 2002:a05:6512:32cd:b0:4a4:68b7:f87a with SMTP id f13-20020a05651232cd00b004a468b7f87amr20619118lfg.30.1671440839244;
        Mon, 19 Dec 2022 01:07:19 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m16-20020a05651202f000b004b4930d53b5sm1042586lfq.134.2022.12.19.01.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 01:07:18 -0800 (PST)
Message-ID: <306709f8-7d45-9b76-f95b-1b3088d37a78@linaro.org>
Date:   Mon, 19 Dec 2022 10:07:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 1/4] dt-bindings: arm-smmu: Document smmu-500 binding
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20221216215819.1164973-1-marijn.suijten@somainline.org>
 <20221216215819.1164973-2-marijn.suijten@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221216215819.1164973-2-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2022 22:58, Marijn Suijten wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> Document smmu-500 compatibility with the SM6125 SoC.
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

