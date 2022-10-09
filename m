Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421255F8DA9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 21:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiJITOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 15:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiJITOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 15:14:19 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF30C13F59
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 12:14:18 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id r22so9827729ljn.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 12:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eLmKWVTMUSHqEP9DIVkRM+ZnS7XRFcavZfbEdhp8mMc=;
        b=D3znIKzXKwQaxB7Ox3lpizhW7NS6r19zfvTiJftlw02OF9QCPjt9kbEIllwQSDwAZm
         bbQd6AGAx4o2TTHo7hE884uCEcGqpp6G4Ny7jvmIBpXYmT2rwz0rUyxYHHYb6xXZLDHc
         E/DV8n9stU9dLyYaAgvDlJFsbnUibYlnZ3lQiZYIXY6gD7JTWs4L3E2890nEcjUZGl/p
         uegdz2Z11CjMAJ7dwVkfNE9BlNRrCClWYLW6o+2UaccXyf4zJIrbSLQt8/GNaAY2oQap
         k8xV2eGWsUXni6SEBMXVz/OEX8Xxc0HYD+ZcLhdkj1uBQdTp3VrXeNoO6jBsfp9PWNDD
         kUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eLmKWVTMUSHqEP9DIVkRM+ZnS7XRFcavZfbEdhp8mMc=;
        b=vWwUvmx2RE+uK+sbfCgC0fNoh0TmEznzLl+9H8fAFJnRfxK5sIQ2y4lb0J/jVfPjgO
         nUaSs2cXmI1PVUYfNBwLgVG1toOnFeu2hkm8z3hM87HqzIcp9KbNvIE7t31cFtqqWTSV
         LobtCTf0YM0gVyByGrtTgEQJfqIhtZdR7KoSID2HvqtcqM3tQeSlbK36+Z97and7Z0r3
         TgjQ4PaOvsWgP2zwSiFONiEVTa/mggazIMqCCxQUV5lj9q7P4OKLLL90YNv+j57kN7qW
         IAfWpbyjha/hRfW5+ALaQZJHj9JA1g+awO5+02NRgfQ8/brBLnAGarL8P9yVD0XTRuts
         a0Zg==
X-Gm-Message-State: ACrzQf2CqQsTmoQriMICJ9nJepHBYf15FKXxTqRhNlYPeE9nGQA1UEda
        k9CFVLCdIwcCjxNX+FKQeG0xgw==
X-Google-Smtp-Source: AMsMyM4a9wjRAHNMLggg3ZrR/45pdnYmZIpeoXCdgpM946/5KOUGeLQrsUAwlMweZbXSn4hMmZKK0g==
X-Received: by 2002:a2e:a54b:0:b0:26c:72ed:b758 with SMTP id e11-20020a2ea54b000000b0026c72edb758mr5535281ljn.245.1665342857092;
        Sun, 09 Oct 2022 12:14:17 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d14-20020a056512368e00b004946c3cf53fsm1117170lfs.59.2022.10.09.12.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 12:14:16 -0700 (PDT)
Message-ID: <408bf6a2-47fe-3eaf-7235-578d33a576c9@linaro.org>
Date:   Sun, 9 Oct 2022 22:14:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 10/10] drm/msm/dsi: Prevent signed BPG offsets from
 bleeding into adjacent bits
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221009184824.457416-1-marijn.suijten@somainline.org>
 <20221009185316.462522-3-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221009185316.462522-3-marijn.suijten@somainline.org>
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

On 09/10/2022 21:53, Marijn Suijten wrote:
> The bpg_offset array contains negative BPG offsets which fill the full 8
> bits of a char thanks to two's complement: this however results in those
> bits bleeding into the next field when the value is packed into DSC PPS
> by the drm_dsc_helper function, which only expects range_bpg_offset to
> contain 6-bit wide values.  As a consequence random slices appear
> corrupted on-screen (tested on a Sony Tama Akatsuki device with sdm845).
> 
> Use AND operators to limit these two's complement values to 6 bits,
> similar to the AMD and i915 drivers.
> 
> Fixes: b9080324d6ca ("drm/msm/dsi: add support for dsc data")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Side note: the DSC params tables are more or less common between amd, 
i916 and msm drivers. It might be worth moving them to the DSC helpers 
from the individual drivers. This would mean such masks handling can go 
into the helper too.

-- 
With best wishes
Dmitry

