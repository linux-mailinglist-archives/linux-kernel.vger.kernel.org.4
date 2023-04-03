Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA856D4D49
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjDCQMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjDCQML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:12:11 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E53D123
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:12:10 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id e65so35380979ybh.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 09:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680538329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ckRoaRfuFXSxICrM929LhPKiHMEGVxGno6xY+TLvhpw=;
        b=FVhe/9/B5nnJIV+P+o3lR0MP8LctNsUM8vqI6LLpp5pOt9jJiOh9UHqSCQPsQ9Idbx
         PveyIETXxV9OXgvwdBG8WHQZiqo1///a8v4eJZzdQOnew15zDxUkUg3g1+3GN1V8WWm5
         UBIW3hmoHELoAQHoaOrQRZJL3C91NcfwFDS2CXp3wVnxQBOEPfPcYFkZJUszKf4znOGi
         EoY3CoyLXyg21b0tp9g3XgeYo2tzFUjtWPCLP9jRuuwzs9VJLXxFHbjX7r2UUsb9Ovqq
         KCEszdUu1e8jBQ2HJel2Fc9oVXahuP33s6Mr9oxYSXXYoq9e3T2GHwJre1EWKGo6zRmU
         bbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680538329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ckRoaRfuFXSxICrM929LhPKiHMEGVxGno6xY+TLvhpw=;
        b=trALKL2A4IS2H4GSikknfkUfkGotncPPwmtdTGA5vi113nGONlGRtrLI74+2E2mjTV
         zA33Z0dH3McBKVJiwAodjtC/o9Ho9hdD4fgcvH3gYng/yRGTLEBiOVJQuICFt19p3Bw1
         2Vo8cGTgFjgJ29ByvN775d2LKamdoC1bpDBobxrRjcYnd1F10CkbrGybnDGAI0bS9xZm
         lTmN2gU1tABFIvt3IDl0STySTdG8d1VmyWcfFVnfJj+L3tGT64w3HdlaiWfPvugDemrN
         5MWlCQ0R0wiy9CDOreINY5/nUwNQvTZGnCHS2uxAtcMD46nGYuFMJM31BEGAb5w3Fp5a
         4GXg==
X-Gm-Message-State: AAQBX9fqofqaG5FntRDIGnRZE4dKoqkLIiYYs/1193Nnx9Vo+3/7u/59
        7ZnMUK7jIjy9OHHr5EhKlwNeqfMgQSAw/EjM6UWHow==
X-Google-Smtp-Source: AKy350bgZqCXxxXnZWum0y79BB4tNnWGNnYcibSUYJZtBvIrylGXzXDniMPLIwWkuC258xvk77u2JPwshx6cwkUy1ns=
X-Received: by 2002:a05:6902:168d:b0:b6c:2d28:b3e7 with SMTP id
 bx13-20020a056902168d00b00b6c2d28b3e7mr23000047ybb.9.1680538329177; Mon, 03
 Apr 2023 09:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <1680271114-1534-1-git-send-email-quic_vpolimer@quicinc.com>
 <1680271114-1534-4-git-send-email-quic_vpolimer@quicinc.com>
 <CAA8EJppc3LDQy2RgVZbWki4Y-_FOTK67Y8RfK5Bm9gqdfqMjqQ@mail.gmail.com> <BN0PR02MB8173E9FF869F7EEFCE1F5410E4929@BN0PR02MB8173.namprd02.prod.outlook.com>
In-Reply-To: <BN0PR02MB8173E9FF869F7EEFCE1F5410E4929@BN0PR02MB8173.namprd02.prod.outlook.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 3 Apr 2023 19:11:58 +0300
Message-ID: <CAA8EJprj5cmB_STfv45NDCJ_e=aWfwMgaNmGkQBqFa8fQq6gQw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] msm: skip the atomic commit of self refresh while
 PSR running
To:     Vinod Polimera <vpolimer@qti.qualcomm.com>
Cc:     "Vinod Polimera (QUIC)" <quic_vpolimer@quicinc.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "Kalyan Thota (QUIC)" <quic_kalyant@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        "Vishnuvardhan Prodduturi (QUIC)" <quic_vproddut@quicinc.com>,
        "Bjorn Andersson (QUIC)" <quic_bjorande@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 at 15:01, Vinod Polimera <vpolimer@qti.qualcomm.com> wrote:
>
> > On Fri, 31 Mar 2023 at 16:59, Vinod Polimera <quic_vpolimer@quicinc.com>
> > wrote:
> > >
> > > In certain CPU stress conditions, there can be a delay in scheduling commit
> > > work and it was observed that PSR commit from a different work queue
> > was
> > > scheduled. Avoid these commits as display is already in PSR mode.
> > >
> > > Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> > > ---
> > >  drivers/gpu/drm/msm/msm_atomic.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/msm/msm_atomic.c
> > b/drivers/gpu/drm/msm/msm_atomic.c
> > > index 645fe53..f8141bb 100644
> > > --- a/drivers/gpu/drm/msm/msm_atomic.c
> > > +++ b/drivers/gpu/drm/msm/msm_atomic.c
> > > @@ -192,6 +192,9 @@ int msm_atomic_check(struct drm_device *dev,
> > struct drm_atomic_state *state)
> > >                         new_crtc_state->mode_changed = true;
> > >                         state->allow_modeset = true;
> > >                 }
> > > +
> > > +               if (old_crtc_state->self_refresh_active && new_crtc_state-
> > >self_refresh_active)
> > > +                       return -EINVAL;
> >
> > EINVAL here means that atomic_check will fail if both old and new
> > states are in SR mode. For example, there might be a mode set for
> > another CRTC (while keeping this one in SR mode). I don't think this
> > is correct. We should skip/shortcut the commit, that's true. But I
> > doubt that returning an error here is a proper way to do this. Please
> > correct me if I'm wrong.
>
> If there is a modeset on same crtc with a different connector. The new_crtc_state will not have self_refresh_active set.
> Self_refresh_active is set from the helper library, which will duplicate the old_state and just adds self_refresh_active to true and active to false.
> so we can be confident that if we are checking for self_refresh_active status then it should be coming from the library call.
>
> Also the EINVAL is returned to the self_refresh library API and the function will be retired.

Maybe I misunderstand you here. However, in this way EINVAL is
returned to drm_atomic_check_only() and not to the SR code.

> And self_refresh_active is cleared on every commit : https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/drm/drm_atomic_state_helper.c#n158

And this means that this check will not trigger at all, if I'm not
mistaken. You've added code to msm_atomic_check(), so
drm_self_refresh_helper_alter_state() was not called (yet) and thus
new_crtc_state->self_refresh_active is set to false, fresh after
crtc's duplicate_state.

--
With best wishes
Dmitry
