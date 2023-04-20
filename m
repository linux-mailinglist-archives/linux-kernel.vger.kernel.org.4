Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641A26E9F68
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjDTWxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDTWw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:52:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B1955AA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:52:53 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ec816c9d03so991292e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682031172; x=1684623172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NoW60Lm7GdjF79mPriJg9iX4x11OKcPemy9MLkVdBxc=;
        b=RB4YYiblAtjEpwZj0VpG1WT20iPmgOgtm07jwS9BRsoa9kYA0r794uyc6pEDrE2EeW
         IbzBcwAQ2wjGR09Ou7aT1vOmXVc1N2In3Ykw0WgC7uM8Q2BK6NBLhB0bKTXV9svxeIIQ
         4Fztrq6poxYy5Kb4lToyyXkbMaN7mRkXPoujcj5ggdaKC/tq2B//x/42WlZ1N4jFJc5G
         7z4wlltyH/IoGg51bPI6nHx7sCJzkUDPjYhkHkaBaU3x6YpM2h9zNNqp9u0VbahrRBxM
         ZTbSwdf6wVp8jBwRM8bPgUC9lg5kTSKEno5P+gnnWHZDBH4qj2PcxuMuYrR81L7+kTwz
         1XIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682031172; x=1684623172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NoW60Lm7GdjF79mPriJg9iX4x11OKcPemy9MLkVdBxc=;
        b=faK+5c1E1kl8SLX0kk/ruHT7ZDh4tsEQOfLWkU1H6Bejxnw6TW9qNcgsH+eu+utE6C
         MCvISE9YxCjA8J5oTacY/Fkkoo+jdh7JfoB0UJp35WRM7p5YaA3mgnFV5jBJnNHhhGpf
         OBAnMV0VyyDybiHxxYQVmPXcl7Qc4cvS+CuujMV6SQigYmYockVfFuouu5wKdXaokf7R
         M+0xw2TgLmsR7boFHD9ZuSp8lrHiLMazOqEi3oKNI8uWdZVmGQur9YcmSMlPjduJa5Ox
         SWo8Ld54NzjPf5xYifJ0NUSqVboWb2mkNgb2AVG93dN9r9QZAAXASay5U6TovG7CYf0o
         gGFg==
X-Gm-Message-State: AAQBX9e53oD4TtD/8dEkOH4vSQpYzTJZgoba2mveKtYLgnZ7jp8vUwXw
        x+ULuChTOtvZ4w/eKIGN2koZ+A==
X-Google-Smtp-Source: AKy350aQqb8y+xF0W6oAo5D5GhlxWVGLI8E9FjmzqZU4jhc4y7WqtCf9P4PO6Z6YJJ/3nnM+xzL/Ng==
X-Received: by 2002:ac2:44ca:0:b0:4eb:2d45:f67f with SMTP id d10-20020ac244ca000000b004eb2d45f67fmr786075lfm.33.1682031171724;
        Thu, 20 Apr 2023 15:52:51 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w3-20020ac254a3000000b004eafa141a12sm360784lfk.9.2023.04.20.15.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 15:52:51 -0700 (PDT)
Message-ID: <353b93c5-27f5-a1a5-760d-5f7ad627a583@linaro.org>
Date:   Fri, 21 Apr 2023 01:52:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 11/13] iommu/arm-smmu-qcom: Add SM6375 DPU compatible
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
 <20230411-topic-straitlagoon_mdss-v2-11-5def73f50980@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v2-11-5def73f50980@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 21/04/2023 01:31, Konrad Dybcio wrote:
> Add the SM6375 DPU compatible to clients compatible list, as it also
> needs the workarounds.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>   1 file changed, 1 insertion(+)

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

