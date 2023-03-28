Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484296CC662
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjC1PcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjC1Pbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:31:44 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABD71115C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:30:56 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id o20so10063160ljp.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680017454;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f6Z3hi5xZpY0A+xzxH10t/g2IJeJJpC83ZgAnnPr4r8=;
        b=ClmAdxKaO+IvbX7WxxMeckWeSwBLmWZS6VF3VOIhXlPLy0T3H1VzIEW1bVGMtqWN1Y
         I1QUxWfEat758nykrdkLKr5HXj2Vh60Jpk8eas0vs7lW+SQlvmD3Ylnl6BcTIMS/+wnU
         3ryReA+B9YJgzEe7h/UjssBX8pdqHpB6Jp7goWYlUwqJq/KoHqWQUK14+AflgKT+qWYH
         sfzh4BuAORKzWYhu/WVwMS4AgNOytzjEq+PqMGpCrRi04T5mJ1RS5gnGK3oEcIx3lZg4
         IYgN4JfgezD6s461Z8eNyykS1b8LUDQbZt4I853YvlcCoa97VskKGOXlaCimCKYXe2LK
         r8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680017454;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6Z3hi5xZpY0A+xzxH10t/g2IJeJJpC83ZgAnnPr4r8=;
        b=1dUkJXowfubmdMI1z9mwhYO8YAZvGc9XRwv9+e029+VNE1GIosBvJhIqk5QRknICRH
         ZChUny3IXuvw5u2NXTkLEWVHpg/iA9oM9Qz/aa0zCkJ3GtY9JxkjH/VQ6dD22jhHlC/4
         OvGAIGOwAfPS1AtnNulfp1OYo0Qce3AZttifTNfZX48M9R5eA4evRT1wtiif1ITSMh4N
         /vwBHPGii76JpdH1868gKxdLxW8F8ygL89ltPRXe5qjfTgpRviuRyEAWvrxpVpu5gDl9
         DsqiciyeDQJlTQ+gh6IjHMEC57BrSYxL9Ni7ghnvMXm4BL9XcVYY9t+6gv346LJanwy7
         /jYA==
X-Gm-Message-State: AAQBX9eucqJVpEZlVZY3hhYz0+B+NBXWA1KBqd46YNIR8EwdbjOau31k
        0fLtcFxx9qFwXEHqXNIrCeM7DQ==
X-Google-Smtp-Source: AKy350bklgIv21W5yZ/4G5UcuAmEvWzN5s4DIXCp2M2RonQn4ByuJaeNtvsiX9cC+vQau4gr3ZNyUw==
X-Received: by 2002:a2e:7212:0:b0:2a0:4de2:db88 with SMTP id n18-20020a2e7212000000b002a04de2db88mr5008585ljc.44.1680017454043;
        Tue, 28 Mar 2023 08:30:54 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c14-20020a05651c014e00b0029913364649sm5123502ljd.11.2023.03.28.08.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 08:30:53 -0700 (PDT)
Message-ID: <bf424375-6306-35b4-4560-1946695f8fee@linaro.org>
Date:   Tue, 28 Mar 2023 18:30:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 12/14] drm/msm/a6xx: Use adreno_is_aXYZ macros in
 speedbin matching
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20230223-topic-gmuwrapper-v4-0-e987eb79d03f@linaro.org>
 <20230223-topic-gmuwrapper-v4-12-e987eb79d03f@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v4-12-e987eb79d03f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 17:28, Konrad Dybcio wrote:
> Before transitioning to using per-SoC and not per-Adreno speedbin
> fuse values (need another patchset to land elsewhere), a good
> improvement/stopgap solution is to use adreno_is_aXYZ macros in
> place of explicit revision matching. Do so to allow differentiating
> between A619 and A619_holi.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 18 +++++++++---------
>   drivers/gpu/drm/msm/adreno/adreno_gpu.h | 14 ++++++++++++--
>   2 files changed, 21 insertions(+), 11 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

