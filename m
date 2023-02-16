Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5014C698A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 03:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBPCXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 21:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBPCXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 21:23:51 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB0431E36
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:23:50 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id s203so572205ybc.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NT9uNCMBWl794fkp+SMakMeJNNkxNGDXw7tBHf8Uvgo=;
        b=wlNPmA17KOY6pK6YSw5++8aMVTR+4h8QzLMUDAs/l/GgEN8eLFJjblVBAL4l+8UMVo
         VTNvpLOPQe0tCs8ZSBaPmCUh9VK2S35jr9LXhVu57g0MVbUxlVvoBO80fVRTxB/I/RIx
         +akHOGbDrVDLObPLO141W2tYDUHhJog0ukTM/eLTBFppp3LXIP16krE2YUTVKv6nVvB5
         DD3wYChintddtUpp8K+Y/2dZp6OviOiV3/Z2H0iulxFADBwcqMao8Um8A8dyZonyUOaN
         VjBCHyPX3eNae7TtWuiXWoU1BLix/mjHbA701x837guejw8xRKnxIaw7zAdnQbzpzTlX
         e+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NT9uNCMBWl794fkp+SMakMeJNNkxNGDXw7tBHf8Uvgo=;
        b=B5VXWfmHX4PITsKWQC+39Q5Zq9a+fMjGrxmwJGjVurjvwIXg5/5pyHk4CUVsfSqzUy
         /CNaQgd8cJMS4CmEhVfBsG0/DX1Uxs1Lgf9uxp9i19r7w62eSbrKbIVk0YIv0gK9zk3e
         XUnP2XEuesSV8/mKZAfctczT8pQBRT3ptFLDRAJBDK2x1GZ9A4Kea5Gy/HqlyKL+LXQc
         oTN1lq15RmcyV6dtU2qIyRFbQ8BOIRhplp3A4+41AwX4s6qy6EZzvRP5gDG/yxb6BPN2
         f4wOkPvhHW9Xt9FW/mqBHCyh8tzBGkVUkb6AuwIxlvVsZKSB6wTwScHCN9KY7w+uxYBb
         DGbA==
X-Gm-Message-State: AO0yUKWG48ul1s94TQLD97ANi7wOl0YPWptDvn54ZkAnbhXSrQh0Xz/1
        zW5iMwftF0S2WoUTk4epE/VQOCyBvmXde0l2HVl9pw==
X-Google-Smtp-Source: AK7set+g5Iz6F+qTqpXxLN+bqfm0nIW/gdEpwcM8ofiNU5qAy9sZmhZSKBYet6qwAIKNsRoqh0H5TZPmCHA79wcHMxk=
X-Received: by 2002:a25:9a49:0:b0:86a:e417:b66e with SMTP id
 r9-20020a259a49000000b0086ae417b66emr520370ybo.382.1676514229770; Wed, 15 Feb
 2023 18:23:49 -0800 (PST)
MIME-Version: 1.0
References: <20230215-sspp-scaler-version-v1-0-416b1500b85b@somainline.org> <20230215-sspp-scaler-version-v1-2-416b1500b85b@somainline.org>
In-Reply-To: <20230215-sspp-scaler-version-v1-2-416b1500b85b@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 16 Feb 2023 04:23:38 +0200
Message-ID: <CAA8EJpr7v4waXaaahuMq3Ti18Gd-sg4HGSSof=yEX5kC7+CKnA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/msm/dpu: Drop unused get_scaler_ver callback from SSPP
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 at 01:02, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> This pointer callback is never used and should be removed.  The helper
> _dpu_hw_sspp_get_scaler3_ver function is retained as it is being used by
> dpu_hw_sspp_init which didn't itself compute _sspp_subblk_offset yet.
>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c | 4 +---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h | 6 ------
>  2 files changed, 1 insertion(+), 9 deletions(-)


-- 
With best wishes
Dmitry
