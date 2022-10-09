Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F1D5F8D8A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 20:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiJISy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 14:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiJISyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 14:54:53 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D181821B1
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 11:54:50 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id d24so6880640ljl.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 11:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HfHIwCu6ix9Kna+8PuTHr1cR5KLg2VwjNd612N/VBhk=;
        b=icnrUwOEYqqXpM7lGG58XUOx4f2Lfbh+szDyq/Oe6bhXj/POCjjfWnVv56wQN0iwsJ
         E6g1tPHS1qRwPYcYRhrBJ2Yxk1F+p+9FJK3NV/dtSPE05H37fPv7KlBx9pYr5hhzn2i7
         KHh1zgLVPLyORveVb5L0CmFIzIo/GE2OjHF96QOJRzKH7W2E2MgHYhghbtizM+z5Gw50
         Ivz/RRcDmG2BmoELfTXehCmSD6lD5ipKIPLIjVlHHPFpHhJ9b0aLqTwsX858zhDkixxx
         j7kk/FEInm/WizXGsyU3JE1SDukQxNXNxQRM5BGqUGwl3PQYuFBQnzwdoptCVfX40AaS
         R3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HfHIwCu6ix9Kna+8PuTHr1cR5KLg2VwjNd612N/VBhk=;
        b=DoIL0kAABEeVtE2uLl4vOs1hLmT9/j0W3pXEF36liP78sKz+LR8wY4Pc/6tNXsDWeM
         Nd7nUWOhsOb8gvxVoKoS7GMqWLkNEeDS5J52jVgJ+VwST86duqupU2g8+R369kHBfs7j
         ni/2vwv1WEU5oh1kTp+EMrCsiixUNin22exsh4k5pJHirJS1DEekiNrgPekgDGJx/cYE
         F3cUpqefS7HgIkZGstnQQy5HIu6pgNyyvNpS6kzEMwSY7VtTTYpPzYSnMDc4Q6Jh1sM5
         OJSXzZLADoFnMCbQS2Ya8MUHqvwZY7HBSjnRXqn35Wfh6qfxmYn4oLpxQGnVXWIqM8kN
         FYSw==
X-Gm-Message-State: ACrzQf0HPoAKtEIfh2rLYWwwETF5Iu5AwgVioAZBduAzFz9gfd+jKMr7
        1949HjML+U5/8EiQwUNbNhROKA==
X-Google-Smtp-Source: AMsMyM6CRg4uBwxkS7rjTe5Yf0/rhGdcCtjAb5V9AqMemVPwKziC/xVhAt3f7dUbsd0ZGixqPW5KAQ==
X-Received: by 2002:a2e:9f51:0:b0:26c:3db9:3660 with SMTP id v17-20020a2e9f51000000b0026c3db93660mr5559612ljk.528.1665341689141;
        Sun, 09 Oct 2022 11:54:49 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id g3-20020a19ee03000000b00494716e4f23sm1113741lfb.111.2022.10.09.11.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 11:54:48 -0700 (PDT)
Message-ID: <7b72e9bf-9736-59b7-7355-db6b1c643e85@linaro.org>
Date:   Sun, 9 Oct 2022 21:54:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 04/10] drm/msm/dsi: Reuse earlier computed
 dsc->slice_chunk_size
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
 <20221009184824.457416-5-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221009184824.457416-5-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2022 21:48, Marijn Suijten wrote:
> dsi_populate_dsc_params() is called prior to dsi_update_dsc_timing() and
> already computes a value for slice_chunk_size, whose value doesn't need
> to be recomputed and re-set here.
> 
> Fixes: 08802f515c3c ("drm/msm/dsi: Add support for DSC configuration")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

