Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BC1703C28
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245119AbjEOSMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245092AbjEOSLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:11:54 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACF627FA7
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:09:09 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-55c939fb24dso120941327b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684174111; x=1686766111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ro8tmlMGAw+gcvacmTcSTaJjQF8eWJk6fA6Unv/Jk28=;
        b=ZiF16qVzHpH1+nrMbvksLWNYUu/EwpDqaweGBrTdItutk6MJ5koNhu/n4KBpJirsY7
         rr0nYXeQ8KqGCeAraXCDpI4H93jRoRFQpUbBsT8ksrSR1DsM/YfA4OVtZFgdHHnOMIad
         53STU/PWwGPnCyeRBcCTiFltMl66f3ZLZ+6PTBYeEKm+cYrApG4APn60WgzDta0YH18r
         ZsOPXMNazF/kFRifnVHszo3CqDy3V7XRyFP9LYAO0DWznx1qTon9/9DC+i/r/VDh2XSF
         yg/gKWEB6oDusL/SNmU5T+wqJYQHau//BzlYUXr3xFyxoMF+MclXrfNqQNUgTTvEK10x
         KcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684174111; x=1686766111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ro8tmlMGAw+gcvacmTcSTaJjQF8eWJk6fA6Unv/Jk28=;
        b=TTw3zcLQTxtUcn1qFJDOR310+OcL/gusHwKRSGhLuAyzHja5Om5gwI7jhHFDfIINgc
         ja/kz5BIOQCaO9kLqPyJ8luJgwmiSUqe+n8v4JwSG+iKSma7Xd5WL10SJblISq6tBv0s
         WcjJYidJQ9td9swP4Or9qCT14fzsc1V+ioQWYfCKwQE0EgemfLY3c76C4HGGrMPrvaKL
         T7Mu9No++Z/DkcaxzaDkuP+pGIUG3Xjs3SFgInBNDpQXi/mlldzhOapZ1COqxvoTez8k
         8PRpw9JHxmqj7XuBN5c9ZRvOArtG0KdUutrX1+/lBcVVcRCf5NPcci9rluqE41GBaMPN
         KORA==
X-Gm-Message-State: AC+VfDwxVFuqjiQIUObZbo523WYFTW6t0gA0HmXP/hD1eWOuCxJNhkma
        H09K9rVEiFUdHn0599QndN/Umv15Rvz/gIEhhebU3Q==
X-Google-Smtp-Source: ACHHUZ6Z4HjdtsvLUTBfEEJpcucb/2KcKAXw85OfHM0Szwvs5toBGa3MOzyeUX7rMhZxYpj5F9J4fR4ysvAAMC1yXxQ=
X-Received: by 2002:a81:8a05:0:b0:55a:30f3:119 with SMTP id
 a5-20020a818a05000000b0055a30f30119mr32369437ywg.35.1684174111398; Mon, 15
 May 2023 11:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <1683914423-17612-1-git-send-email-quic_khsieh@quicinc.com>
 <1683914423-17612-6-git-send-email-quic_khsieh@quicinc.com>
 <41243dc6-eb9d-dea6-f945-cb1f6594a2a4@linaro.org> <w6uswjuf7fiorrplqzhrpg3vrjbbdd3bgaxej5l6ez3pebn3d5@ytuxhim25j6q>
 <1fd8fd48-9a0a-774c-1366-ea4c893f3b25@quicinc.com>
In-Reply-To: <1fd8fd48-9a0a-774c-1366-ea4c893f3b25@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 15 May 2023 21:08:20 +0300
Message-ID: <CAA8EJpqKRJ0nqQMDXdcSYEZapsKfxAsevcKnWPcsEVv+9P05fg@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] drm/msm/dpu: add support for DSC encoder v1.2 engine
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 at 20:47, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
>
> On 5/14/2023 2:46 PM, Marijn Suijten wrote:
> > On 2023-05-12 21:19:19, Dmitry Baryshkov wrote:
> > <snip.
> >>> +static inline void dpu_hw_dsc_bind_pingpong_blk_1_2(struct dpu_hw_dsc *hw_dsc,
> >>> +                                               const enum dpu_pingpong pp)
> >>> +{
> >>> +   struct dpu_hw_blk_reg_map *hw;
> >>> +   const struct dpu_dsc_sub_blks *sblk;
> >>> +   int mux_cfg = 0xf; /* Disabled */
> >>> +
> >>> +   hw = &hw_dsc->hw;
> >>> +
> >>> +   sblk = hw_dsc->caps->sblk;
> >>> +
> >>> +   if (pp)
> >>> +           mux_cfg = (pp - PINGPONG_0) & 0x7;
> >> Do we need an unbind support here like we do for the DSC 1.1?
> >>
> >>> +
> >>> +   DPU_REG_WRITE(hw, sblk->ctl.base + DSC_CTL, mux_cfg);
> >>> +}
> > <snip>
> >
> > Friendly request to strip/snip unneeded context (as done in this reply)
> > to make it easier to spot the conversation, and replies to it.
> >
> > - Marijn
>
> Thanks for suggestion.
>
> How can I do that?
>
> just manually delete unneeded context?
>
> Or are they other way (tricks) to do it automatically?

No automation can deduce what is irrelevant to the mail. So we do this manually.

-- 
With best wishes
Dmitry
