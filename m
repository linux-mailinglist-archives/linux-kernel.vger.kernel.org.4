Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9196A6E9F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjDTWtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjDTWtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:49:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B103C34
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:49:05 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ec94eb6dcaso971588e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682030944; x=1684622944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fdP8MC3XaEqA32rWPdIckKxRCI4GJxh3IXEDH13XKh4=;
        b=Uo5s2ZVJ8f0YtJNR2V/QAw9DClxjdNn9cqFYEbfOZQUbcrDWvI3kZIG/ZvuvSdVhU7
         pfh5B5a9RphGrqWEwNIRlbMY45cfKU38pWY1e0FY61FUJh0Jb1svYJ9R0LJakfx9tu3m
         nbekIr7F6ZW68EnD6s+zO6qcATzgxFBHn6w9fyAO0JcooAsehyLQcDBDOcntPm0NyGoN
         Oifnhlo7c89uxuHM+wDtJ0RnSGZNiKDCUdarMsAhcx8sziEmaqPjUGiTtCmM0BS8tN6v
         sj4Ln9lcUStQlwf/nzgnSZ0qMbfnh5CtcwwFPN++psWNdyfLRUKvJWy/6+3gbGTZVDBk
         ty5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682030944; x=1684622944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdP8MC3XaEqA32rWPdIckKxRCI4GJxh3IXEDH13XKh4=;
        b=gUSqyzUv1ZgRKu847KK8F+tKwTR7FPWepPvbIWmG9Xtko3VumU1m7C658INqxIt8nh
         pdIZcVAo+6rvoPfDh7aMpTRgigSxlZRLeco8wgC7FnhZ788OxeqPj4j6KU4MBgjT8u3v
         QDGF2+vnb/evnspigB0eLRlvMvY3KBzZkoWakm8jY1FRerWFXNOjwLqH/U+h21IwpRnz
         UfMVtgDy6pkCwDO4wcp9oLOJsprVYUA2rvMU9pqJlJbvN3bWeJjK/hdlSzTXBIEUUIiq
         Cy9y89t7QT8DPPJri0rKz61kEK8EwI33DhdkmGrzXEVYYEVmxYmxYto0xwz1ra4+v8do
         ZQFw==
X-Gm-Message-State: AAQBX9fXZhToLR/ecgUzN4Neu7DEBWuYwQ8S9jSJH5XNp7FnT4LW6298
        F9ZIlhP639XmOzxVugXpKRnD3w==
X-Google-Smtp-Source: AKy350ZInjPaVxyUTYhwDYw+L3xY8vOz8c952eS4vzPQ6cipzNOj58Pw/XifVqqdE8XeIyyL0HzukA==
X-Received: by 2002:ac2:4905:0:b0:4ed:c9b0:6a42 with SMTP id n5-20020ac24905000000b004edc9b06a42mr780084lfi.12.1682030944156;
        Thu, 20 Apr 2023 15:49:04 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id x13-20020ac2488d000000b004ef11b30a17sm94609lfc.91.2023.04.20.15.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 15:49:03 -0700 (PDT)
Message-ID: <d2b6ebad-dd38-0bb3-7c98-27cda45c7ed9@linaro.org>
Date:   Fri, 21 Apr 2023 01:49:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 10/13] drm/msm: mdss: Add SM6375 support
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
 <20230411-topic-straitlagoon_mdss-v2-10-5def73f50980@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v2-10-5def73f50980@linaro.org>
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
> Add support for MDSS on SM6375.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/msm_mdss.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

