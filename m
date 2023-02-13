Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343A76945FA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjBMMgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjBMMgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:36:45 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2377813D77
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:36:16 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ml19so31626646ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bd32m7OqwWmfxRntLTXoj2Vvtzxt3MPFU5fN2rFPKBw=;
        b=dvCbycvrc9yub29PKPvPP3eqtBOLpw9aDFAaq2QZ6jAz+qOmEtPSUP3OI3xPaFOrbR
         XC9skBpqQ6xT1N9hqfC4yfYQneJkCh/+jht/j55h6oMNYHYb863j5mw0Ovjwvb5UV9O5
         7W8ZGm0Q/HAsbGpBh3AApzpSjmq7boP2iipM4Vvz911C5PoGw97b+Pd6/6sI+QnSvDsf
         bALmWukNzp7u7+mQzEUvnGKgZ/t7B0BwBnhpoVWJmpRE590zzOvrEQX/BUXZon2KNcIo
         ZJ4xR6TChLGVl/+9Vm6Qspba3eRTMRUX83UKXvApK4Bpibd34XAt2jgL9oxFB3Iijole
         pDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bd32m7OqwWmfxRntLTXoj2Vvtzxt3MPFU5fN2rFPKBw=;
        b=JRLNQjWcHKAfOK+trgRU9EMDjwFSQ0KCVIUyGnqVp46Wi+b7/EDMZ4OCJFS3bMFhKu
         nipTrE8Q3Wdruxjj6l2Up8/i4A+LjMfYlnXbUZ6yOTQyFsQC45lGTvHg2uDTVNEPEkxj
         zZUecnvQrR2bRlrKcNyl6cHtYQ+jEHkodWbeAuErlRfD2bBT9bYVR1iW6WH1YPWtvyhR
         Oe+hZDbEV04lc4ZHW5KlNOj7Cq5Z87xwkmyBJCiJmD83TrT62bnpVww7JsSuY49/wKNE
         2peAwdykA503g7ddsUNF6VqG+nE19ecEKLhk34FMkUYF5BLzeGwCZwaOn6du/70WIeAR
         oiSQ==
X-Gm-Message-State: AO0yUKWhLTGnkz0JHNbe+bfYGy6SozmePCjz2wLSGW0iYHOZkEsTnqH/
        i/11Fbhmt+om6S9uIztG7UNRvA==
X-Google-Smtp-Source: AK7set/aB/+3t2Nr+TF73Bn1Y7gchwJq4+GQRBW//hD8Z0srRwpeZdjF+wk4GzwU6/Z0x+oZHu5Vsw==
X-Received: by 2002:a17:907:3e23:b0:8af:2fa1:2226 with SMTP id hp35-20020a1709073e2300b008af2fa12226mr20533372ejc.6.1676291773137;
        Mon, 13 Feb 2023 04:36:13 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id ot11-20020a170906cccb00b008775b8a5a5fsm6697679ejb.198.2023.02.13.04.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 04:36:12 -0800 (PST)
Message-ID: <4470ef7b-b94d-9e2a-d464-3cfb966bdee4@linaro.org>
Date:   Mon, 13 Feb 2023 14:36:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 6/9] drm/msm/dsi: Switch the QCM2290-specific
 compatible to index autodetection
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Johan Hovold <johan+linaro@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230213121012.1768296-1-konrad.dybcio@linaro.org>
 <20230213121012.1768296-7-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230213121012.1768296-7-konrad.dybcio@linaro.org>
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

On 13/02/2023 14:10, Konrad Dybcio wrote:
> Now that the logic can handle multiple sets of registers, move
> the QCM2290 to the common logic and mark it deprecated. This allows us
> to remove a couple of structs, saving some memory.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/dsi/dsi.c     |  4 +++-
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c | 28 ++--------------------------
>   2 files changed, 5 insertions(+), 27 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

