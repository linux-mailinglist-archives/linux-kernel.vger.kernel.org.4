Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24936E8679
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjDTA1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjDTA1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:27:41 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D8B5B8A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:27:39 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2a8bbea12d7so1640791fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681950457; x=1684542457;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OU1rCmbsnDfe9dKvPIpfOrN+IqTHtV2jf/biLiJ0fYs=;
        b=G4Mes1dXfAYTPB206qmpfb4Z9sZeeViY1Jf2EJ7v4NUDzzTrA82OOpBVceE3grdo4e
         kRJYtkilz/Eah+ougyY9pWRNXecsUou7rxk8NcShaK2+pAV3LHOTLKnjYOuUHroG0QgY
         af1w4wMSLX7Qq64ocNaQuY3NHY50ml3INARjGyWEbu9ZBCu2LKJDKVx12kYErj4AZ4JU
         UTBzjyLrBQLC0Ag1GeaXyN1JNX4Ez3fBby7VITwrWOUqbRkql9YourX7tcVshakOiw32
         iq908ZTjJrB7gx4vhSCsO+5RSqQDVdpkg+mmfxmGYUj1FRgI0Hh0R9bna62mLBdm/ITt
         FA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681950457; x=1684542457;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OU1rCmbsnDfe9dKvPIpfOrN+IqTHtV2jf/biLiJ0fYs=;
        b=A0jmoojMFWMAbvCMQKco4chEKSkk1AHLwULKffwQ+5j8tpb15EzYsNYSYSn+GG/fpO
         PCiBsOaPxzkntP6M1rWYp9jTZk6FcLzIV+kA9y2l/yt9svN3iI3UHZxT+0lZzmW14x4F
         KstEkkLI1glqLbtQeuMSCzFviCqmsgE+7KCBeUlIouGlS2NwXqyMHZkivi0wdk7J3m3Y
         6lNxcQcFdHqDu2mkXAiZ9dflRgvm06+OG1xlRiyd6Cn4nG+nNi2+uOpg/XlY4hzmp6r2
         08lHepMWoOaHTyzuOJlwGzXtIBirNBrEDnwPwTqfcbQxJGY2x8r1sOecV2L2MPlRHf2p
         hwNA==
X-Gm-Message-State: AAQBX9cD5GQy+Bg33bv3SsOf9M48L7q3aOcvPtzseXcl/P7Xv67CZE6J
        fqJbwi0wMj+lNpfOB3actTkdwA==
X-Google-Smtp-Source: AKy350YdOiukgpi5MS1TnPwjknJUjmT3eL0beMikzCX//Uctsz9WnSPzKL6NA3VmCj2so0rTtRiGpw==
X-Received: by 2002:ac2:5e89:0:b0:4eb:d8d:6c14 with SMTP id b9-20020ac25e89000000b004eb0d8d6c14mr4353732lfq.11.1681950457626;
        Wed, 19 Apr 2023 17:27:37 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id g15-20020a2e938f000000b002a8aadcf15bsm10510ljh.120.2023.04.19.17.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 17:27:37 -0700 (PDT)
Message-ID: <5dcdbd51-d30a-b62a-b231-b416b69af135@linaro.org>
Date:   Thu, 20 Apr 2023 03:27:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/5] drm/msm/mdss: Rename path references to mdp_path
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230417-topic-dpu_regbus-v1-0-06fbdc1643c0@linaro.org>
 <20230417-topic-dpu_regbus-v1-3-06fbdc1643c0@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230417-topic-dpu_regbus-v1-3-06fbdc1643c0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 18:30, Konrad Dybcio wrote:
> The DPU1 driver needs to handle all MDPn<->DDR paths, as well as
> CPU<->SLAVE_DISPLAY_CFG. The former ones share how their values are
> calculated, but the latter one has static predefines spanning all SoCs.
> 
> In preparation for supporting the CPU<->SLAVE_DISPLAY_CFG path, rename
> the path-related struct members to include "mdp_".
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/msm_mdss.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

