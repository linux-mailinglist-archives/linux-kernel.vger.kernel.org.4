Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F3D6E8744
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 03:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjDTBMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 21:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjDTBMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 21:12:39 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950D044AC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:12:31 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id z38so961093ljq.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681953149; x=1684545149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=21nptXt3cg+q1Dc02GTtpl0ccYXLvq/yqLo2KDOgpRw=;
        b=fxkJnyU8icPIp/1qZzwMsW4MAEuaR6QIt7EytgE1TnnVWnDpUJ0PgBlPXKAm+cOBgf
         3GQPMpv71Q6pQBakCcemnzr7qLRagEBIA22W9DVCQMa62vwLf+hgaOV/7anvdrw+SKaw
         iLXGJsZyPZ+NPp4lApFtLxZhB2ibaxq2EvcNOY5H2O3HA8KsGpRq5jwDc+fC/iuMEne/
         WUnrsRrMFSphEu2RWxa8k7fH3eXutm4Kuudd8fLaAnEGtydGCtjf8ym3LgrX6cVxfsKX
         B/lPpxI0Ox6B8xv3ekLlr3ZHFCOJ5PeBoaU6VzSFLikDWcbYtEVWafmGq1zRfQKJaBW9
         98Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681953149; x=1684545149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21nptXt3cg+q1Dc02GTtpl0ccYXLvq/yqLo2KDOgpRw=;
        b=f3zMmNgluTM1LRT7W3m+s69LxiXT3r+tqwkVR7AQEXCdRwVaKvrmAxUTRMhBXibyVg
         YewIrXYXkpkgGEFIQiIaN4SOOyNW5K4dWiHRVo2scCszSsy3VL64+9K8o7eRauHFPGCZ
         shAMaLvFFvFKbJLsbm1ituibx1B5luARGg0D3ekPTA14Z9liSTjTIqQ2HkR2M8TTa58N
         9l4sy97/ySTuyVtM/kpKkwvadjtHy31Js15QDA+caCqVAHWCZecbLdwiLANX87SmEprX
         9c5TAM9RxJ9/af/YfGd/CuHxPPFnx3CriU17Yz9BSFIyoaChPTpXTuNffPeoxa3gTwFv
         cgqQ==
X-Gm-Message-State: AAQBX9cZrSXKJ0P9xpRyx4JLfPMeJxjJuJZBKVxQzmhBEob9cTkmhEo/
        /Y8UZ5Uvqb3Z73FYQvYf/6b5FA==
X-Google-Smtp-Source: AKy350bhbY3KYzfzX6sqiAFhHWulaltqj9jFwTi0Bp7JHJbhJdLwQ3z61rWtdQrTn2JY3Vh6XjqsRg==
X-Received: by 2002:a2e:834c:0:b0:29b:6ead:6d92 with SMTP id l12-20020a2e834c000000b0029b6ead6d92mr2381880ljh.23.1681953149392;
        Wed, 19 Apr 2023 18:12:29 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a21-20020a05651c011500b002a8bc2fb3cesm27546ljb.115.2023.04.19.18.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 18:12:28 -0700 (PDT)
Message-ID: <8b3d3379-1217-9f48-b761-06bf13169d0f@linaro.org>
Date:   Thu, 20 Apr 2023 04:12:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Freedreno] [PATCH v2 15/17] drm/msm/dpu: Merge setup_- and
 enable_tearcheck pingpong callbacks
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
Cc:     Archit Taneja <architt@codeaurora.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        freedreno@lists.freedesktop.org,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>
References: <20230411-dpu-intf-te-v2-0-ef76c877eb97@somainline.org>
 <20230411-dpu-intf-te-v2-15-ef76c877eb97@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-dpu-intf-te-v2-15-ef76c877eb97@somainline.org>
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
> These functions are always called consecutively and are best bundled
> together for simplicity, especially when the same structure of callbacks
> will be replicated later on the interface block for INTF TE support.
> The enable_tearcheck(false) case is now replaced with a more obvious
> disable_tearcheck(), encapsulating the original register write with 0.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 10 ++++------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c      | 10 ++++++----
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h      | 11 +++++------
>   3 files changed, 15 insertions(+), 16 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

