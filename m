Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24353698ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 03:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBPC6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 21:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjBPC6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 21:58:14 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAE828867
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:58:08 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id s203so641820ybc.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YyMZCQmaOL1xm4zqLG+BHh0sREN8jgVyVG/p8ktPj+c=;
        b=mBTcMWPuiflyd2oc/5m7tNXF9fuV2y8N6d1q0h1Qj8DIsihq+Rx5Zu3ZxARHaYmuHh
         TyHa1FOKITLUVKOuB4LkvJux8vM8KYSjlSMBMfL3fUwUO4/TxidApfDlRXmyKRYoNp3+
         HKpJIthTDoyScFvmhFvfHnwdn0UcnY7NvkNQVo4vahQFg8AnociLC+3ysCCwm9mvYF+L
         m5Rr4uFetZBqVNS28SPcAR/GLaVUY0eeylDf7gjpVYajIEAYe0a0JeodButx/u7eTcY2
         hZXhgUOMJtBJDE8GCUPktK/RabH20AFq/8/5F0b1OydzjVIye8RX+8T/24MPQ3wjn6IR
         HeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YyMZCQmaOL1xm4zqLG+BHh0sREN8jgVyVG/p8ktPj+c=;
        b=w7MUAa/2wvPWB9P6abjXCLhIDOOgaEeQjcPFFZ4KtfXlPlW/SPVS/asgganNIiKZFo
         ikRKTParR106zXZgTmikHp/K/8nL9Y7+ZDpDzAHPiIMm2vOglIbZOXYh451AcSwwf2Y/
         yLM+Y/DaYw04Bhwh3SjwzTdJTupbVxkqr7l0xV9DsHh91f6G8p3+4ydpcFjoIJdiEi32
         +sergBOvEUpxw6WE0uTHJf2EndYFfqekz+pdHDYJ2WNYzgziAkObV5aJnkPZgW5J53SX
         7qTf6IxczPDiWtCeRzw2LE5prVWSSI1QGJZ6dNN1wpuZlhPncoe/xck0JbtlUs8GAwj5
         X/zA==
X-Gm-Message-State: AO0yUKV9j50A3yKnBYiVE/jbriYv/Ng0ZZY68/lG6SzsgI2Z7dgfKOkw
        yfwvybkLAsg9naPPFl+0Yn52oS3YPuIbW9CAd4p3pg==
X-Google-Smtp-Source: AK7set+nmSebDjAkALV0PNZZFrn4v5zED6xwiCkXHS5ZJibfE5G7fjdWSQOZ3GW6NWl5csCf9dRiUjSqbi/Ly8p7fAo=
X-Received: by 2002:a25:9a49:0:b0:86a:e417:b66e with SMTP id
 r9-20020a259a49000000b0086ae417b66emr531070ybo.382.1676516287570; Wed, 15 Feb
 2023 18:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20230215-sspp-scaler-version-v1-0-416b1500b85b@somainline.org> <20230215-sspp-scaler-version-v1-3-416b1500b85b@somainline.org>
In-Reply-To: <20230215-sspp-scaler-version-v1-3-416b1500b85b@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 16 Feb 2023 04:57:56 +0200
Message-ID: <CAA8EJpqeVkYyk-RxkODt2wyXy0fhvTgjs-5Ay8R3TV7ddU4zOw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/msm/dpu: Drop unused qseed_type from catalog dpu_caps
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
> The SSPP scaler subblk is responsible for reporting its version (via the
> .id field, feature bits on the parent SSPP block, and since recently
> also from reading a register to supersede a read-but-unset version field
> in the catalog), leaving this global qseed_type field logically unused.
> Remove this dead code to lighten the catalog and bringup-overhead.
>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 12 ------------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h |  2 --
>  2 files changed, 14 deletions(-)

-- 
With best wishes
Dmitry
