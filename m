Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F036172B1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 00:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiKBXfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 19:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiKBXew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 19:34:52 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D40C6477
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 16:27:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id r12so243891lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 16:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4uyZR2sjXqLyFufMaC3oiMlnZtU+QLNchFZs2tyGbA0=;
        b=kOUNsLx5Y6YNxZXAKN99KHZEhCI9RUxJEK/3X6iMvn23FU+0cKFeOwijjRGO/QrEu7
         POwKgPGYxiHvdu1kXfirnmTS3yhpZ/nNh9/sXsntH50AqVSMgreKHQ0SYFrta4hE1UPP
         9yVZnn9s5lUnuZ/OdkhQZ6oe23jccwLSm8uSmpLMino6Oq0mQwSewujiQPFo7jutvlBb
         kaQ0GMfbN53yBLUD+MZALDhCeAMsgCY2e9Mlo/+Wsxtpf+vSqEdp291/h7YaMfX5mXJg
         e7yOY905/NPJHzDElm7R7qZGTNlA/8i3PqQqq9Gdzm+XY659wB862PHA8dNL1Vgyv0RW
         bI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4uyZR2sjXqLyFufMaC3oiMlnZtU+QLNchFZs2tyGbA0=;
        b=JsCCqRsXDoCXtB6R+rtq3nwy//VE719VC7KxLWSXI5GwgaAM8rtfE+txsr9ohu83/e
         v+GJmNh+R4W0hNh5Ek+hT3mdEaL9gazAbXaTuihcMud3p6RVMUuUt3M+7Nbow8Bw35iv
         z1X/10LTgMYqzYiEqpqGRkIx9FbcYpXa7XrxbqbUc+exQFy/0BKX9m3TKTvIXtis7BXD
         GRTZEyPGOlx33J+QV0u21wT5EjtYPuexCtO456rhlQCb89Q7usthxENvyYm1uQ35IVNJ
         8cLys0cyvUK2Nzy8rs0QhCfMP6jt4nuQO8pe68MUVJ3OxLjcR2kNDiph3uUOVVYC18t8
         dDPA==
X-Gm-Message-State: ACrzQf2z+0/kOy1SOWay+FWyHN1VAR0DWh7NTxHHYU4ivnubWfDJBbux
        tlNTLJDeBakh6GBU8erahOPnKQ==
X-Google-Smtp-Source: AMsMyM7KyTnal/RdmTTT2p5aFTIEEqVQhf0y1ouH5tnV3OgPW/jxPwCYl85ji9r+213jZ0EzyBK+Uw==
X-Received: by 2002:a05:6512:40c:b0:4a0:5b27:76f0 with SMTP id u12-20020a056512040c00b004a05b2776f0mr10913392lfk.358.1667431581912;
        Wed, 02 Nov 2022 16:26:21 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id v4-20020a056512048400b004a240eb0217sm2154391lfq.251.2022.11.02.16.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 16:26:21 -0700 (PDT)
Message-ID: <bf5fb954-c71b-f02f-5300-4e030b10811a@linaro.org>
Date:   Thu, 3 Nov 2022 02:26:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 2/2] drm/msm: Hangcheck progress detection
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221101223319.165493-1-robdclark@gmail.com>
 <20221101223319.165493-3-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221101223319.165493-3-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2022 01:33, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> If the hangcheck timer expires, check if the fw's position in the
> cmdstream has advanced (changed) since last timer expiration, and
> allow it up to three additional "extensions" to it's alotted time.
> The intention is to continue to catch "shader stuck in a loop" type
> hangs quickly, but allow more time for things that are actually
> making forward progress.

Just out of curiosity: wouldn't position also change for a 'shader stuck 
in a loop'?


> Because we need to sample the CP state twice to detect if there has
> not been progress, this also cuts the the timer's duration in half.
> 
> v2: Fix typo (REG_A6XX_CP_CSQ_IB2_STAT), add comment
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>



-- 
With best wishes
Dmitry

