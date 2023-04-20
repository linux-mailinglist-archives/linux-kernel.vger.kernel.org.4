Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39486E870B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjDTA4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjDTAz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:55:58 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8929D10E2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:55:55 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h4so1025111ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681952154; x=1684544154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mj/IZ8/q3LWYaJuZh+m8gKrrpGLIcx9rD0SuhtK3tA0=;
        b=wKv2MHhswPxaQN1cvJymcq+PHFU2en0Au7w8Jlszz54MzG8ur11HQ1j14KwjUWi0WR
         sXqW8pubQhjY7cNDvhgNa/JeBQAHY/7Bctniz5vtabJGRW06+Vem9xbxOOY8yX5c7mdX
         sDaP+2BtiDlNzGe7uyFEYyXw97yB8igo4TggW0NikQWyehzbuqaG/llskyNC0VodlkW8
         kn7z26NUfdRo6h7E9o14ZBbT9fb816KEbifHA1LBJSz+vt3W7dmxCS2QpSxE0+Yx7idY
         B0Q2skq9z1kOdMTExgJUJA82nKI+mhWVaYd0SKHjHXC6TzvJ1GcWRiiZnGtP5q88trSP
         r0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681952154; x=1684544154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mj/IZ8/q3LWYaJuZh+m8gKrrpGLIcx9rD0SuhtK3tA0=;
        b=UbBM5fE8V/13rlWBVGBWikkh430OcXQMiMkPJqCkDd7D6QGVFcSPh2wxp8HF9ulvUg
         OjfyHe+pJddqD5yDKkDyp4Hk2mV/yhNrJiz08rlogWIGuodYVeQeDGjUPok01TrBoH/Z
         de/8ei9cWzIkKK/GFrRpL//Al0EP6DHzHOwxLa9nMwC2RLciFUgE1n0yvXqb6GmNqj/n
         6vqNBI/vbc9n1kdP9Su9clPFXDng5xdik0KIaM8uBQYQPVt1LNcRH3oUP5HPWkB52DOH
         Vw1kYGqxi5xfa3oeTRw0LNnDCLy8GoacJmQWyGOofgqlYGHEJJ+X3VhABRp4R63lpAIu
         jpqA==
X-Gm-Message-State: AAQBX9dh8RHJm3Rodcv1yfLDj+ymRyViauCJjN/ptL694ahwRHKovHVQ
        kxAEr/zxzXXlDgE+3zj6AW4Z+w==
X-Google-Smtp-Source: AKy350aBjbBI2fnSI78CYPlvQ6MQ6S6ZIkXziORI8Lxrfejc+O5akyG1vq476JVPJqKUPfd4c0EzpQ==
X-Received: by 2002:a2e:8217:0:b0:2a8:b7e6:b622 with SMTP id w23-20020a2e8217000000b002a8b7e6b622mr2067402ljg.46.1681952153810;
        Wed, 19 Apr 2023 17:55:53 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e7812000000b002a77e01c3a0sm21056ljc.23.2023.04.19.17.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 17:55:53 -0700 (PDT)
Message-ID: <4bba553e-8fd0-6727-695b-452fbd69ea61@linaro.org>
Date:   Thu, 20 Apr 2023 03:55:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 10/17] drm/msm/dpu: Disable pingpong TE on DPU 5.0.0
 and above
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
 <20230411-dpu-intf-te-v2-10-ef76c877eb97@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-dpu-intf-te-v2-10-ef76c877eb97@somainline.org>
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
> Since hardware revision 5.0.0 the TE configuration moved out of the
> PINGPONG block into the INTF block.  Writing these registers has no
> effect, and is omitted downstream via the DPU/SDE_PINGPONG_TE feature
> flag.  This flag is only added to PINGPONG blocks used by hardware prior
> to 5.0.0.
> 
> The existing PP_BLK_TE macro has been removed in favour of directly
> passing this feature flag, which has thus far been the only difference
> with PP_BLK.  PP_BLK_DITHER has been left in place as its embedded
> feature flag already excludes this DPU_PINGPONG_TE bit and differs by
> setting the block length to zero, as it only contains a DITHER subblock.
> 
> The code that writes to these registers in the INTF block will follow in
> subsequent patches.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   .../drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h    |  8 +++----
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h |  8 +++----
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h | 12 +++++------
>   .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    | 12 +++++------
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h | 12 +++++------
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h |  4 ++--
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h |  2 +-
>   .../drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h    |  2 +-
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h | 12 +++++------
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h |  8 +++----
>   .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   | 24 ++++++++++-----------
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h | 16 +++++++-------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     | 25 ++++++++++------------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c    | 12 ++++++-----
>   14 files changed, 78 insertions(+), 79 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

