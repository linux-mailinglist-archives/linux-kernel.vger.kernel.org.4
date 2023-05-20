Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB8D70A453
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 03:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjETBdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 21:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjETBdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 21:33:13 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975FAE47
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 18:33:09 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2af2958db45so9825331fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 18:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684546388; x=1687138388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9m6FYEdyuS34WJpEKNGhiGJw26BbhauPjEFJhVqIy84=;
        b=J2WAtndni5pg8zI01jaEewzpdR8rCPsAoHbZekp+7M7wC2x3R9lV418//z863DW65n
         2lUc3KDyHqYLd/BYBzCb+uiqjLN/9CLt1T1xBY4W326Xz1VlLg27DhrsdUr4KSEGc4e7
         rwLGneMzBtX9uDKXQ2tiw+kMkyTrE3mKeqUvyAOECJqTiUVwCraa9sePU3K9gItlfFUz
         1fccnmpHkpoYH6BPpwxCn/QluiL5NGN+jeyHtyD9ahQjzJaKQvimoTnyv59pD0rWMtt5
         FbuBOuOjbn7d8xA3FKXll6cU3ijggLoMHkMRp8NIQ9Qd7KxbWm3ySAdYBfXjJ8Duwq71
         h4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684546388; x=1687138388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9m6FYEdyuS34WJpEKNGhiGJw26BbhauPjEFJhVqIy84=;
        b=UrdmxedDL2wNYjBNviaM7PKMbXkHxd4nc9zdSKcO2+tWi95pgEptDvxSlTOiDaTEIK
         ri9TqUgMQtXiwgaBAaEo1PpjzkhQhVqcVKaKMmM/orIfW4HGjkkJXEdN2pkPQ11WGkA3
         6fzfFbedrKOIA0PqTlwiWi2AbbplgJBWmMAKci3wgaj0TUw5ZjfJGvy4gNd1U/1am1c7
         MPKFS1gQDDE+jGQWjcKtZGyHQKQCUmTxV8vHz0UAHJhsN4ElhHVbpGM8GvlE2fOBnf66
         2vUoE8+wTNXRJVfJcbtKwObJLFh/3pS2i5szNaocP407zKF6rXe44edsDKYWe3MENfuf
         1Rjg==
X-Gm-Message-State: AC+VfDy6Xau1Q7f8ZyEREOH2mslP0b1rZLVSKCXBFxB6zR/rNCGbhJ01
        xgmWIAK2YC6nXbn3lr4OzoAiyw==
X-Google-Smtp-Source: ACHHUZ7hSJky8D3B+kEQc4AR9VaHMZsAgYX95I/Fi+l7dRlfuSrwNICffM982tuTFljAsF+j/ezRAA==
X-Received: by 2002:a2e:880a:0:b0:2af:20c9:3f8a with SMTP id x10-20020a2e880a000000b002af20c93f8amr1515995ljh.7.1684546387794;
        Fri, 19 May 2023 18:33:07 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id k7-20020ac24567000000b004efe9a169d2sm92819lfm.64.2023.05.19.18.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 18:33:07 -0700 (PDT)
Message-ID: <02e1886f-801e-6100-f977-be407697df29@linaro.org>
Date:   Sat, 20 May 2023 04:33:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 08/12] drm/msm/dpu: Add SM6375 support
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
        Joerg Roedel <joro@8bytes.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <20230411-topic-straitlagoon_mdss-v4-0-68e7e25d70e1@linaro.org>
 <20230411-topic-straitlagoon_mdss-v4-8-68e7e25d70e1@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v4-8-68e7e25d70e1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2023 20:04, Konrad Dybcio wrote:
> Add basic SM6375 support to the DPU1 driver to enable display output.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h | 153 +++++++++++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
>   4 files changed, 156 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

