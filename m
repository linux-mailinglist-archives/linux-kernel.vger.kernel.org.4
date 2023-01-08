Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB04661AF7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 00:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjAHXJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 18:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjAHXJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 18:09:48 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D5AB7C6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 15:09:47 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id v25so10409033lfe.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 15:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rn0bwN8yDcIT0lq2Fmec3De7HDRgeeGbPNJSwOLemFo=;
        b=A1y3WFehyxxU8f3zh+QqiYgKTpAXOWGYXAwbZOznVwASFCEOP2Hnodbu3s/2rWafH9
         uL26igjX+Z+4AxxL+mDg6DZ50NKCHSaI2llvazdAHfBVq5YLssodozSc5YEHpVdlGlqJ
         BMCmfonq+Kx0c8nvTx73nV+GUWB6JuO5XCOXXtCZk0dtu4mFMDlKEfl4wXk2W/JyKjYb
         zj0ZKGbI2aiA6EX8FyyO1i8a7Uh0sKE8R3bTpN8vOA5pLiDCtRtvUozuECQDPxfSYl/x
         GG4NMyj1sF4Cbwgy6jzMEhXt06q5Pmb0dmIPhTWh297tq6pd6Qb8UV2iTqpTvrX+QKyx
         9Xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rn0bwN8yDcIT0lq2Fmec3De7HDRgeeGbPNJSwOLemFo=;
        b=mesqLAzF8A6mGL/xg4ofeoOZG0CMD84gcaqQXwW4PjsRAGRASt+6vSiFSvdoHNz5Mc
         UEqwfyqlypIac2KUZQmGJ2hZl6S4wHmEc8n7HsdCBUyi0UK+2GV2TEhpELc3V4ykOMqi
         QojBR4RA0t8LbULVauooXf6AnNwA7vWt2YHcPfCmbo5kRU+zWk0be4wJq98NsDIsOGsl
         J5G+56pS2sZA4wcj7fPXwir9yJfc4Vbkz0IAf6ziB0l0sQHxb8BcqJ9goZx52wYh/x6i
         CafJvxi9TEUZzZVMMyf+CGsjB01kmwkdPUglTNAlgs1RhGQqztUYbLLgO0LAYFgNHrXP
         bBzg==
X-Gm-Message-State: AFqh2kpqpVceEhDz7mGsyKs6qr9vySV33CDHbzo4/6bpmqFx5NBcKntb
        nDeE0BEKO5znP/BbGPz4Wp+vSw==
X-Google-Smtp-Source: AMrXdXsFW3LC6GHKCdz3f4T7+t42NVf17ohnnVOjbAVNQOjf9syNJiY3u6/WneKjems3OXAmxOTr5g==
X-Received: by 2002:a05:6512:25a0:b0:4b5:5dea:85ad with SMTP id bf32-20020a05651225a000b004b55dea85admr17633881lfb.12.1673219386068;
        Sun, 08 Jan 2023 15:09:46 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id m14-20020a056512358e00b004cb14fa604csm1270554lfr.262.2023.01.08.15.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 15:09:45 -0800 (PST)
Message-ID: <334d18d4-42c6-07b1-8f38-dc9dd0d609c0@linaro.org>
Date:   Mon, 9 Jan 2023 01:09:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/6] drm/msm: add support for SM8450
Content-Language: en-GB
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230103-topic-sm8550-upstream-mdss-dsi-v1-0-9ccd7e652fcd@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230103-topic-sm8550-upstream-mdss-dsi-v1-0-9ccd7e652fcd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2023 11:08, Neil Armstrong wrote:
> This adds support for the MDSS/DPU/DSI on the Qualcomm SM8550 platform.

Nit: please change the subject for v2. It's 8550, not 8450.

> 
> This patchset is based on the SM8450 display support serie at [1].
> 
> In order to work, the following patchsets are required:
> - PM8550 LDO fix at [2]
> - DISPCC driver at [3]
> 
> + the DT changes.
> 
> [1] https://lore.kernel.org/all/20221207012231.112059-1-dmitry.baryshkov@linaro.org/
> [2] https://lore.kernel.org/all/20230102-topic-sm8550-upstream-fixes-reg-l11b-nldo-v1-1-d97def246338@linaro.org/
> [3] https://lore.kernel.org/all/20230103-topic-sm8550-upstream-dispcc-v1-0-81bfcc26b2dc@linaro.org/
> 
> To: Rob Clark <robdclark@gmail.com>
> To: Abhinav Kumar <quic_abhinavk@quicinc.com>
> To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> To: Sean Paul <sean@poorly.run>
> To: David Airlie <airlied@gmail.com>
> To: Daniel Vetter <daniel@ffwll.ch>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Jonathan Marek <jonathan@marek.ca>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> ---
> Neil Armstrong (6):
>        dt-bindings: display/msm: document the SM8550 DSI PHY
>        dt-bindings: display/msm: document the display hardware for SM8550
>        drm/msm/dpu: add support for SM8550
>        drm/msm: mdss: add support for SM8550
>        drm/msm/dsi: add support for DSI-PHY on SM8550
>        drm/msm/dsi: add support for DSI 2.7.0
> 
>   .../bindings/display/msm/dsi-phy-7nm.yaml          |   1 +
>   .../bindings/display/msm/qcom,sm8550-dpu.yaml      | 134 +++++++++
>   .../bindings/display/msm/qcom,sm8550-mdss.yaml     | 331 +++++++++++++++++++++
>   drivers/gpu/drm/msm/Kconfig                        |   4 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     | 197 ++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |   2 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c                  |  16 +
>   drivers/gpu/drm/msm/dsi/dsi_cfg.h                  |   1 +
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   2 +
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy.h              |   1 +
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          | 102 +++++--
>   drivers/gpu/drm/msm/msm_mdss.c                     |   2 +
>   14 files changed, 775 insertions(+), 20 deletions(-)
> ---
> base-commit: d862fd95b9c924bd0a257f7708a6e3868d39ff43
> change-id: 20230103-topic-sm8550-upstream-mdss-dsi-35ca8acea529
> 
> Best regards,

-- 
With best wishes
Dmitry

