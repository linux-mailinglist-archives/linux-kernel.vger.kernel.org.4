Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333E35F8D71
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 20:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiJISwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 14:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJISwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 14:52:44 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61D829829
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 11:52:42 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r14so13849699lfm.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pIjqS6gdtTRggpFmsM12g61XiUJqlB1w3Lk7PGDiY4k=;
        b=SQcpo++Aix4dizmqjgzZCFPDhj3ziY+qCd0ihacLAwRIKs5cxTL6R6IFiwqleLXyfT
         ZoaANhOY75dDQTTP2FZZCS7I5A/N/GtWVvDdwEkh9uuwSincRBNQ+SsgPjTAGuMjBjHs
         AuVmzhD3FwSbvERNUzd5SnRMVgElcZ3jOC4P5VcqD2K0iRVGb5DGBwXvBJOhQWF6JS+N
         JpuXjzFv1bwvUq8YqN2QWFG+GH7B+m0P1kGqFm5EnakO6jP8tBTwh6fVS/m43l8rkWWh
         OdpOwxcAdLo79dS/S95QLmIRXlTtpI4eWS/X4mi2waKPAt2/wdAllMAZQZCp7ax7Gvnp
         rBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pIjqS6gdtTRggpFmsM12g61XiUJqlB1w3Lk7PGDiY4k=;
        b=DDSOZfy1jxyrHCK1pbLpSrF4yi/CBThd1kj6ycJPHNul+MOoPHUq2U9Vb+nRXnvEUf
         r/4P9lXKBwQy1StTpBhXkbZzRSmn7iW1n/4lmRWUxM9hfnwn8OmVkU+YJsdSMRJwZYME
         SV+Z7K0LB1qV59sfx0lx5v0N3+DPiLWpbJ9ExVr7krpXfXSA4G/osrU/eDbzeUHmIKgf
         yAK2lJ5x8Fvli2f1+3al2sZpVviL6DM2U/O31brxVTPGwYgErzNfa/nNVpmHDX/UCWQ6
         ykIB6hiu2l3gABqZOietcvFR7LnDkwulC03+s0vI+4obMFVfPz7ZmqlBtJ99anXZuY1U
         LDzQ==
X-Gm-Message-State: ACrzQf1VleN8gJoVGeZEr1/FftbvZQomDGjCBOXo2fxWQgKSiI75NJ6Y
        HjIbyHtSy/ZoW6lzuIEVMKy13g==
X-Google-Smtp-Source: AMsMyM796VexOVGOSvF6wQDt52LNKPg+357XUoXWAH85pGOFs1V4DM5iIN+W/mnB4ZIqI0uNLyioQw==
X-Received: by 2002:ac2:5931:0:b0:4a2:be5d:edac with SMTP id v17-20020ac25931000000b004a2be5dedacmr3273463lfi.332.1665341561243;
        Sun, 09 Oct 2022 11:52:41 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q14-20020a056512210e00b00485caa0f5dfsm1114474lfr.44.2022.10.09.11.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 11:52:40 -0700 (PDT)
Message-ID: <3f5cb79b-f745-8b7b-bacd-f9ea2988baea@linaro.org>
Date:   Sun, 9 Oct 2022 21:52:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 01/10] drm/msm/dsi: Remove useless math in DSC
 calculations
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
 <20221009184824.457416-2-marijn.suijten@somainline.org>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221009184824.457416-2-marijn.suijten@somainline.org>
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
> Multiplying a value by 2 and adding 1 to it always results in a value
> that is uneven, and that 1 gets truncated immediately when performing
> integer division by 2 again.  There is no "rounding" possible here.
> 
> After that target_bpp_x16 is used to store a multiplication of
> bits_per_pixel by 16 which is only ever read to immediately be divided
> by 16 again, and is elided in much the same way.
> 
> Fixes: b9080324d6ca ("drm/msm/dsi: add support for dsc data")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

