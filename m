Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31F06CC678
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjC1PfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjC1PfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:35:15 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCF4A8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:35:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h11so9387381lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680017711;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3N8h1DChvaLnm2TUkq7RCFOUn72LEkPBuvQVgji2prc=;
        b=MWTvY67pF8MEgiGs0jD2F1Vba+LhJPWz/XGiFuofZNJLlEA3NardYys19LQAJ2Nutk
         m0Fo1FrI6Hi+fJuGrEHQ+pTH1mPbkH11n2Poeu7kSgO6C1LbRjccfRcMXT61KZUorXQe
         AmuQnfQHrzT2QoYg91RCtwoqwkCgFVd3st/0qc28pr8D04tbsuDjbWUFdABzBDZFoJ0p
         k4x21jaRhb7KwdYmVywi5vlO/jlQgqOGHQiJzsSwCkOYO10V3g1/BRKivvz0L52A7gM1
         zJSYmHOo+yIicNDz6RQFY1UmNKvO71ygggA9+Aj8sGVBFeyY6guMH8GWq3Ba3KTpnHi2
         E6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680017711;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3N8h1DChvaLnm2TUkq7RCFOUn72LEkPBuvQVgji2prc=;
        b=77UGilX0lSBuP6WdvDPqm0DGFqoWaxMSSNHzn2IeMBi7m9NUGHXDH/phQE4a3zbhyX
         pwzd+Ayc0b2II1Twmphh2lwZgpOfshIjxB3VW9FfBlEMZQviQNzbxT3PeAtNtOzHbR9h
         zcyxm0mSrAbeTLkM94r0mUrczXpXjzBKXQ/Cpmtv4um+veeKJgptZscZTNPLT7bRkDKd
         t7Ltu2pLayPw9Sg5C2fuYKtpl14dApdXkWWrlsoozcu4sPoYhSLXFnPl1Akx7xaVsoar
         x8wDR/vLS+HTqsz4OQUlI6JiLpyDq2da8F9YtpwHZCAmyrcvinvDlp0TqtAMp7yHxUFO
         ZKAg==
X-Gm-Message-State: AAQBX9e6rWnYncuLr/smKxvmGIAqEfTYjIS3xdu4CrmwCj1g6NGskGpu
        pCD+dIZKslMceHjkXnI30bxzEA==
X-Google-Smtp-Source: AKy350aVn3vQwYsmxvtq+7/O1t34Z5xIpUuSNYCnORBUR752Ec2avam/4Q48gjVlzD+IBjLDYgwZ7w==
X-Received: by 2002:ac2:51a1:0:b0:4df:830d:4a3a with SMTP id f1-20020ac251a1000000b004df830d4a3amr5009867lfk.23.1680017711678;
        Tue, 28 Mar 2023 08:35:11 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id m10-20020ac2428a000000b004b6f00832cesm5086017lfh.166.2023.03.28.08.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 08:35:11 -0700 (PDT)
Message-ID: <2b0506b7-1a3a-b45a-8514-42066231d2ea@linaro.org>
Date:   Tue, 28 Mar 2023 18:35:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 06/14] drm/msm/a6xx: Remove both GBIF and RBBM GBIF
 halt on hw init
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
 <20230223-topic-gmuwrapper-v4-6-e987eb79d03f@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v4-6-e987eb79d03f@linaro.org>
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
> Currently we're only deasserting REG_A6XX_RBBM_GBIF_HALT, but we also
> need REG_A6XX_GBIF_HALT to be set to 0. For GMU-equipped GPUs this is
> done in a6xx_bus_clear_pending_transactions(), but for the GMU-less
> ones we have to do it *somewhere*. Unhalting both side by side sounds
> like a good plan and it won't cause any issues if it's unnecessary.
> 
> Also, add a memory barrier to ensure it's gone through.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

