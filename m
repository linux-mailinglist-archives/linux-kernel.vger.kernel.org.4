Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9615F8D93
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 20:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiJIS45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 14:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiJIS4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 14:56:53 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D18112AE8
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 11:56:52 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q7so8635458ljp.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 11:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4BqFxrrCFx1w9zJ1okwcKdbwVKbwlGalHmaJp/PWKYw=;
        b=ntkBYO3tdwDZG3MUdXCzs2ZAMe21LMDq/e0kJODPoYBqt/AUXkjGAEozcaMjlDI6Sp
         OXyBzIj9WQwwCb5DoyIFrG7wrCfAMtKm+fx6k3B77XeeBQQadqHE9ab1YAO+Bqb4S6ij
         QfJSedWlKIA7zoGyjTHPV483Brzt/K1esjwWaq0tEiKR2Bb8E7rotscMLL6BShQab92O
         JKcGmzCi4dueg0Z2UkDzSKrydX/5EsToLw6ylLOExHTLvi+EIDOATNj59X/dgs9WJg3N
         j06umGPOOMj2G63Gu/ebKb6TdIlyewwF2IoG4YrWD63N7Zlzt5HqbY3ozXLymNiRPN6X
         iWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4BqFxrrCFx1w9zJ1okwcKdbwVKbwlGalHmaJp/PWKYw=;
        b=ObCX5QwgRbFHL1Dd/LEJhq9FBSk5HQmrmhI9t+4SBanXTgeRGDst2LuDPtoy03o6QM
         ZXzgiyfCXrbVvWHfbKjQwWFzccTDfoEL8cPWG2f+LkPH2G4E9hhIg/TxGkq58LYSwLdg
         LvAXHfEKPfIHQYx+IPdr5M3LlRTj2KLtli9U0q+/NYDN5OrxuRNH/AtqSXcHA9ZXhyAr
         yO6FLekMnC+30l9NWEGkMUmbFls461vG3dJyOQCw1GvUW9ryWc4usJZtQ3K1gprOTE3Z
         IylGJsoUrVtF/Z0v6r1LXSoEzO/WkUrBASKzGTe3fHtiDWPm9mMSLUASqsLhdWWIDaWP
         MjZA==
X-Gm-Message-State: ACrzQf0p/TVSRkCaPsExq6336a4tcVI/AoIN00CEECvRBtxdX1k4HmH9
        0g5HP45HlSSH/tydVq8lHYwA8w==
X-Google-Smtp-Source: AMsMyM7Q9mAoQECe/JbTqMM8N5BgPY+HiSdKyCxs5AHW3ie/cE8EAsGCW+RRdE2iXtvNdSEiSw4QCw==
X-Received: by 2002:a2e:b78f:0:b0:26f:a850:8c78 with SMTP id n15-20020a2eb78f000000b0026fa8508c78mr282196ljo.442.1665341810646;
        Sun, 09 Oct 2022 11:56:50 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 13-20020a2eb94d000000b0026ad753448fsm1360880ljs.85.2022.10.09.11.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 11:56:50 -0700 (PDT)
Message-ID: <0ac50b87-326d-c857-41d9-44ec22ce1248@linaro.org>
Date:   Sun, 9 Oct 2022 21:56:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 06/10] drm/msm/dsi: Migrate to
 drm_dsc_compute_rc_parameters()
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221009184824.457416-1-marijn.suijten@somainline.org>
 <20221009184824.457416-7-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221009184824.457416-7-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2022 21:48, Marijn Suijten wrote:
> As per the FIXME this code is entirely duplicate with what is already
> provided inside drm_dsc_compute_rc_parameters(), and it is yet unknown
> why this comment was put in place instead of resolved from the get-go.
> Not only does it save on duplication, it would have also spared certain
> issues.
> 
> For example, this code from downstream assumed dsc->bits_per_pixel to
> contain an integer value, whereas the upstream drm_dsc_config struct has
> it with 4 fractional bits.  drm_dsc_compute_rc_parameters() already
> accounts for this feat, and the sole remaining use of
> dsc->bits_per_pixel inside dsi_populate_dsc_params() will be addressed
> in a separate patch.
> 
> Fixes: b9080324d6ca ("drm/msm/dsi: add support for dsc data")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

