Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CD56673A8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjALNxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjALNxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:53:30 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830EF52764
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:53:24 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id fy8so44804001ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VEgIlBDAlGQZBmVyuD6cEhuOAp963SNPIrPu8S2m7Vk=;
        b=rtr/ms2QeM19t/CC5LQNPz+qCEqjtAZFEBCUJBLkWw8nQ2+upZtbD6lP7G+rjXpXeS
         k4XKYsz6/F9dCNQIGMCryE7fKSbbIR9G3P4AAYV1NbmSM4QoLSd1T+H1lvgmzi3thdtO
         PmorFRYc1zsnRLB6OpljvjgpXHu1d23Vozqg273RWhXuoxira27SeoFoBQ1+gWG5xWUI
         QffkiF1LiZG4v363qfZZXDOHezMb9+SmNiiF8BxTcaRVWC7b75SbCvSyhRO6C7TA08Cg
         SERMlTFT0BSTXkvOhygPmW7RmcZ+Gpj+6ZihUD0Igb91XwayD/wUiL64eP90PA7kSloH
         XFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VEgIlBDAlGQZBmVyuD6cEhuOAp963SNPIrPu8S2m7Vk=;
        b=xlo80HoF4iXmhoqLe4ytK4+E6nM9qCW3hqcFbEHuIQCJlaPiThq9Gxhu2pcVAu7TCC
         YSFxML54lAlaBDtZ8ocasepLPlQkqcdBcSXH4ZzUhFc7fYq0hcNG8ES2NeNizZO5Fiqe
         FxlImuDlqm1hw9iuTGYeElQCZ+IE91Xv3SfZSQ2BpFRcZzW+/dLUVcMsorHMir5GaKiI
         4ndkBQnUu3s2Cbr9Jq8MtHe4XZETTAWEFDcvE5hi9/2j7SrWUC2A9RNGZAC6hSIfwNjj
         zU054tYFk96Hb9f+oPyaXnBGkrl0DjFR3lHcUoMVVDM/CSsRL0Mi234anYEHHo/9unf2
         yymA==
X-Gm-Message-State: AFqh2krrOLR685u1NJJ5T2uYeiBACkPMDW64OTSBnCJrWQcuKZQ36at2
        pMhUPAGKWLLVIy2vNL6Mgr/WDQ==
X-Google-Smtp-Source: AMrXdXuVTphxaYsX3dow/CtVIs2dB9/JyXdySZLqCvXp7Yywmx0bI3apUvs8Y0K/0qYa/fPcz9yLXA==
X-Received: by 2002:a17:906:99d0:b0:84d:43e4:479b with SMTP id s16-20020a17090699d000b0084d43e4479bmr15622650ejn.36.1673531603070;
        Thu, 12 Jan 2023 05:53:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906219100b008536ff0bb44sm3717696eju.109.2023.01.12.05.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 05:53:22 -0800 (PST)
Message-ID: <e2cc612a-7b1f-6c18-7d5b-1403fac77a99@linaro.org>
Date:   Thu, 12 Jan 2023 14:53:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: arm-smmu: disallow clocks when not used
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 10:23, Krzysztof Kozlowski wrote:
> Disallow clocks for variants other than:
> 1. SMMUs with platform-specific compatibles which list explicit clocks
>    and clock-names,
> 2. SMMUs using only generic compatibles, e.g. arm,mmu-500, which have a
>    variable clocks on different implementations.
> 
> This requires such variants with platform-specific compatible, to
> explicitly list the clocks or omit them, making the binding more
> constraint.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Will, Robin, Joerg,

Anyone willing to pick up this patch?

Best regards,
Krzysztof

