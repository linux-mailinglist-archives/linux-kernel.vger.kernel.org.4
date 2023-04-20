Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010D56E9F38
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjDTWnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjDTWnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:43:21 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A1A2696
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:43:19 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ec9ccab8bbso927530e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682030598; x=1684622598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdc4rmGvOVsqp5oe4XQe+KMb4W3JpUy4TYDZwsnYsZQ=;
        b=iMmU/ProsZloeDlfszZLM1UhnrSEWbJjuwhbsBIkQ9sbpVonSjhRG+FPE88rZVcOyN
         r5kw6tiLsdoUm4DGrcoZ+oOUk7IZqJQt696BorzzlAb52lkEefX4GwwceABeIF/arWVL
         s2nECak0R/jv9VibAoSWpbroteMwMy22iQPfGTYwhVEIc4eJhKD98KqflXXh0DH9FQKD
         fRgMLcwnUgpahJMyrndXa60iY6a+BTYiAnjtW95phSgoNud9SK5n4u4XD7faHhu+Lo/C
         1iPGPuM14dkyASscMUoPk2rgUxR6YWDW4pK+Mv8Nh4nMuN6wb48vBZ98eyMsk7ePUifD
         8qNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682030598; x=1684622598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdc4rmGvOVsqp5oe4XQe+KMb4W3JpUy4TYDZwsnYsZQ=;
        b=hVCTKRfrFQo04eBBjgkZEAaTLnypwGKoG0i+aUo6j8rYcOdasiaGLNHe20AL5WYraK
         ebZL3fm2tIak4dc5zJGnrlX0gcACkAz3BfxrQ/pX1C5MIQv4R2FCsvUoJUjpgbjS+iL8
         WqjmHdFmIyOquj9w8ku42cPDdUhOrmL/OcYlHx0ynr1Fy1tGWuo3qhfug0B8zyZGLldO
         CgEg2JbqqPD7Ru1HzB7izZWr2uBS3acFRYhMHlUg0MUkA7RxJ05vM//PhSpKHgQKok5v
         icNq+YITqGxASNE4nAtx+Ki9Nmp0GHlYNP8hm0YvkKIi6z81PoL3UHO6esfLZzNeAaIR
         dXtQ==
X-Gm-Message-State: AAQBX9ck/kUG1Hu+unPtRRpkukG6Gwy+gVeQWoqI/4AFuk6eoJHD9+pK
        tKb734Vq0UteJBEoFOaaq6iE+w==
X-Google-Smtp-Source: AKy350ZVF4cIUxwuhl1z55nPu1K7EKpo+nQCFX/oqhNnKdROTunmg2Y4/61DtVtV2y6p7vSA1kX/iw==
X-Received: by 2002:ac2:4427:0:b0:4eb:d8d:6c14 with SMTP id w7-20020ac24427000000b004eb0d8d6c14mr727331lfl.11.1682030597782;
        Thu, 20 Apr 2023 15:43:17 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id l14-20020a2e868e000000b002a775f96ef4sm402576lji.30.2023.04.20.15.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 15:43:17 -0700 (PDT)
Message-ID: <ae811f1e-1376-f3d4-e297-6dc2f984b4ac@linaro.org>
Date:   Fri, 21 Apr 2023 01:43:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 08/13] drm/msm: mdss: Add SM6350 support
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
 <20230411-topic-straitlagoon_mdss-v2-8-5def73f50980@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v2-8-5def73f50980@linaro.org>
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
> Add support for MDSS on SM6350.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/msm_mdss.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

