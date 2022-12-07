Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725E364651D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiLGXay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLGXav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:30:51 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA1589308
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 15:30:51 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id h10so22616645ljk.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 15:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cCy2Oynps+usLlSqo5MKgBsH0XBjtXporBPmYeMsTLw=;
        b=LnK3kJU0TS633BxPFn1ZNY1SWTM4AuFmGvDxnA8qwVFmdCTj3MEdmPUKHbESast9XQ
         MKIiRy+cthbV8CcyjLhGzbAPiHFvlem7yorV+z+u9ILLkxAWA8Ah4ZcAh9Mv9Mg/sPir
         7WfUOepVnRXp0s0IiRZq4Z/ZucGERD4vRj5yDeY+Bg42Am+ks1I0vrJywvRXgk/WZmXk
         pVN5XmKYoZgwCVn3GCohyxtKqcJz6okakxCmV7cZqcFau+0ertQwejroFEzjmPUMvLW9
         j2A/F7dbkD7MlzcPRsa3yoMlOOpLh+MdrAd+K1RynWGr+9nBbQ3Y1BWss6tUdoplMzSA
         UUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCy2Oynps+usLlSqo5MKgBsH0XBjtXporBPmYeMsTLw=;
        b=CE/c/D2tMzhmoAAtk+cVqz1Vj6CVFR/aiBA2kkEuFPdHms56JGDN0enKSQo7DbjmDW
         Tbr/lJPq2lYc6ldtbCB7huzFh3y4JfAfjk/ZyljHX26zOm5NIwvjOOWxPW1wdIeEA6cy
         UKdJUNmAS0C4YHOX4aPXT1t8WcCWR3nCIvarGKaYNEEnj5zxZKtkhsrcmpB9uD+0u0A6
         lHZtM+r+z3mCJCIqH/39GFlzP4Z/NCaL8OaeoylSQ15jYwsZSOv3QJim6fhqVny4iVnL
         33Q/dJW5JMY74U+no6orl8BLKboPTkLsA0ZO44W1fTkWU873i4hlcahKlvdO8hqbpthQ
         PdYA==
X-Gm-Message-State: ANoB5pkOyxJJzhPs6NtNrVHblU3F59ThvJ/RUPkL4W/LRpG0nUfm4ubd
        fLg/2SqsV4w1HYPWi8OQ7WxNRw==
X-Google-Smtp-Source: AA0mqf5Hg/AtPjCgCvfnCKNswL/KM0uv8sg7P5kVGrchRPVVGJIYTgKpXDXs4HQY6rXA/qV+AqZ+Bw==
X-Received: by 2002:a2e:9415:0:b0:279:82f1:f858 with SMTP id i21-20020a2e9415000000b0027982f1f858mr18794077ljh.336.1670455849430;
        Wed, 07 Dec 2022 15:30:49 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id 6-20020ac25f06000000b00498fbec3f8asm3074376lfq.129.2022.12.07.15.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 15:30:48 -0800 (PST)
Message-ID: <26d8c71b-d555-be3d-06b6-7bad0f5f6948@linaro.org>
Date:   Thu, 8 Dec 2022 01:30:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 02/12] drm/msm/dpu: Introduce SC8280XP
Content-Language: en-GB
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221207220012.16529-1-quic_bjorande@quicinc.com>
 <20221207220012.16529-3-quic_bjorande@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221207220012.16529-3-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2022 00:00, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> The Qualcomm SC8280XP platform contains DPU version 8.0.0, has 9
> interfaces, 2 DSI controllers and 4 DisplayPort controllers. Extend the
> necessary definitions and describe the DPU in the SC8280XP.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v4:
> - Fix highest_bank_bit, based on downstream
> - Add ubwc_swizzle
> - Use CTL_SC7280_MASK instead of listing the bits directly
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

