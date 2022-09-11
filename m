Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB805B519A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 00:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiIKWv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 18:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiIKWv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 18:51:26 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFAB1F615
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 15:51:25 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id z22-20020a056830129600b0063711f456ceso4747321otp.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 15:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date;
        bh=yf6us0hpX9C+LQcsMl8TWkCbnYmsi9yU4+2aJofZWvw=;
        b=f/VeRCwZVsc2aBLVrdb5X6p45wFZ7LLVVBaei228qrJLXXEfigzM9sj4Gshg4vg1bb
         5rNUz6HxDgfuF0du+GtbgGRgi/3vOC+xwV8qIJ6IFIc4mP0McTqVEKs7vTBsaPKwUDvo
         XOFaF32qNe1Daqp7zvrTEG8FfH3ZBJmc0lkKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yf6us0hpX9C+LQcsMl8TWkCbnYmsi9yU4+2aJofZWvw=;
        b=HO9tUDOXoi508zY7Cfvu0iT52QRPKWhqVsKbHG6M6WKSApqHMtQ/bP/t2ohrzFv4nx
         2OGrBlOJmE3nJf0VpOMABnVJ4+cewrit0lIGGExroL9Euaw8PK6WquV1GOZCV43xsMKQ
         JCeiUiqzIRJrLKk8rAvUec7Ajg1qjzSrr/3K03RKt1ArGa7WOshGO6qUds53lpMeYvNj
         OPKv9B0J7frq/nTh11VB407h8pWEjaWxXJzn9k8s/ipaKb/Gz3UCgw5KukE5cKfXHLyW
         U1U1s/r1cDOVOqvYSbO0d1HEPWkTyeL+zYKig7vaoI76ouUH6DuiEfVIiEs9zHN515gR
         NZng==
X-Gm-Message-State: ACgBeo2+6SXvVsMS+fM/tDtN7FMmYjMmaOBEJBhKVRKxT59+PzmYkD8Z
        1VEU7n9XhX+PsS8ocH3QZh0i7iIC84BKgdo+BeSdOg==
X-Google-Smtp-Source: AA6agR5dthMo/JycUE/0eQ7pE2kMS3cJLcSQDOaW/Qur0qtlVKXNbZbZ3G7tq0yONaPO7sO0TX9z8zeHVfIBJtcrz2w=
X-Received: by 2002:a9d:738c:0:b0:638:9962:8cb6 with SMTP id
 j12-20020a9d738c000000b0063899628cb6mr9426218otk.73.1662936684828; Sun, 11
 Sep 2022 15:51:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 11 Sep 2022 17:51:24 -0500
MIME-Version: 1.0
In-Reply-To: <1662621988-6873-1-git-send-email-quic_kalyant@quicinc.com>
References: <y> <1662621988-6873-1-git-send-email-quic_kalyant@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Sun, 11 Sep 2022 17:51:24 -0500
Message-ID: <CAE-0n51x3um=CZFk0K0k=7XkgbUk7OixtTjr2oqkhOLOz7yzwg@mail.gmail.com>
Subject: Re: [v4] drm/msm/disp/dpu1: add support for dspp sub block flush in sc7280
To:     Kalyan Thota <quic_kalyant@quicinc.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        y@qualcomm.com
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, quic_vpolimer@quicinc.com,
        dmitry.baryshkov@linaro.org, quic_abhinavk@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kalyan Thota (2022-09-08 00:26:28)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> index a35ecb6..bbda09a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> @@ -307,6 +309,31 @@ static void dpu_hw_ctl_update_pending_flush_dspp(struct dpu_hw_ctl *ctx,
>         }
>  }
>
> +static void dpu_hw_ctl_update_pending_flush_dspp_subblocks(
> +       struct dpu_hw_ctl *ctx, enum dpu_dspp dspp, u32 dspp_sub_blk)
> +{
> +       uint32_t flushbits = 0, active;

Please use u32 in the kernel. It's shorter.
