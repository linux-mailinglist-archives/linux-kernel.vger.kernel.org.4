Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72876E86B5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjDTApF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjDTApD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:45:03 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F172685
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:45:01 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id c3so953969ljf.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681951500; x=1684543500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Uw7JNGYT4uLh3etMMP74RoMDPM5hJGwdSfCgrMMVoM=;
        b=mGKF03/4oZsNGaaGShd+QEVSq9NZb+b/aSYbYemAfcxB0OljlSufOAaVRPtuIk8fjk
         IsUWSPJPbKDOzGPpJCT+W5WzgPv1scbSvfzSiYTJRmWPSTTDnee6JEbWNQHrnYDiR5JV
         b7tDJyPbuydSddMmz/mhoRpZLBmECi2o/4M+j9b21LEeJUlXmQAtMTvFoBJ2ReVgnohX
         FULXv+EJG+ka/q4W9CgIsnVuwmmIk1bI4pUwmpFFNuR9bikhOOupApqX0sn/SS5suNVj
         mw4UJmXwHZnW/I30MZAMNfPpgKh214rZiexYF5nhD09XXaVTs2g9Ka0t4pf+AZLZVJtQ
         aT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681951500; x=1684543500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Uw7JNGYT4uLh3etMMP74RoMDPM5hJGwdSfCgrMMVoM=;
        b=e68la5S6LOb81H62/zCodmlPbE+y1xxkrKk99cIgql6fHjSjllYEcmtCNCLH42fah4
         z46qBOK6IeUd0lBetA9r7kZDaBb35jj4UQBzo1w3QSCuj6JS1fEkppLrRI45VrsmhJdY
         lO0oHRsMpXg7rqxQw+WrbRQQwDpat2TFWlUjzvmhdApEDVSt6mpp3SKNBzjoQl1xiYCs
         PG0XBLBPb95eNU2SsEqToHfhjRxJCvz08qd99EiTjcGlkvTCamIexjOXk+IhVZO1y6Ug
         6n+2ijO9xaXhF1w9cSd1QWv9nOAq9MWqU0sQBCsWYWr8bqEPQibFWlKLR2wKl24GJZQy
         Q7DQ==
X-Gm-Message-State: AAQBX9fmD3ObwiIgN6hzb3hOeeyyUrs5Z1HHNIYoOeEV6gYlTAZq0PMz
        wygUDwuu7Nvsd6RtuRI/Vl0yAg==
X-Google-Smtp-Source: AKy350ZBTBfKAQ0fZHgjW5NeO1pdUq3DqqyNPbaUxvwgl2B1P9ChdTakjvNEhN4imLkvEb7Wp/45eA==
X-Received: by 2002:a2e:9a95:0:b0:2a8:aadc:f162 with SMTP id p21-20020a2e9a95000000b002a8aadcf162mr2474093lji.51.1681951499837;
        Wed, 19 Apr 2023 17:44:59 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id z4-20020a2e8e84000000b002a8bbd919f8sm16726ljk.6.2023.04.19.17.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 17:44:59 -0700 (PDT)
Message-ID: <0eb8eaf7-7649-13a1-edc4-049fd0f51dcb@linaro.org>
Date:   Thu, 20 Apr 2023 03:44:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 02/17] drm/msm/dpu: Remove TE2 block and feature from
 DPU >= 7.0.0 hardware
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Adam Skladowski <a39.skl@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Archit Taneja <architt@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>
References: <20230411-dpu-intf-te-v2-0-ef76c877eb97@somainline.org>
 <20230411-dpu-intf-te-v2-2-ef76c877eb97@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-dpu-intf-te-v2-2-ef76c877eb97@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 23:21, Marijn Suijten wrote:
> No hardware beyond kona (sm8250) defines the TE2 PINGPONG sub-block
> offset downstream.  Even though neither downstream nor upstream utilizes
> these registers in any way, remove the erroneous specification for
> SC8280XP, SM8350 and SM8450 to prevent confusion.
> 
> Note that downstream enables the PPSPLIT (split-FIFO) topology (single
> LM for 2 PP and 2 INTF) based on the presence of a TE2 block.
> 
> Fixes: f0a1bdf64dd7 ("drm/msm/dpu: Introduce SC8280XP")
> Fixes: 0a72f23f6ef8 ("drm/msm/dpu: Add SM8350 to hw catalog")
> Fixes: 8cbbc3396065 ("drm/msm/dpu: add support for SM8450")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h   |  4 ++--
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h | 12 ++++++------
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h   |  4 ++--
>   3 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

