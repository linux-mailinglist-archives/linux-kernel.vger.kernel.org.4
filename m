Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F656951D4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjBMUZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjBMUZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:25:53 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A735C7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:25:52 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 136so2725051ybf.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/0Ws/YlbYYoxDYDAzi4lHOOroimYy2NYmSbxJOySDP4=;
        b=FtxD+4keDj4WORQa3590d18w1Tgvlh+vZeAuVrxN6og/aSdvNMP1Dk0n3WC5kqOkxN
         qdY2ivrbuuH3zqFaBLo5rI/Rguy/C/JqGn9eKiXAlXI6ZhSs4rcbOTbNEWNvC2+eJn8c
         Rl/J74HQm5QH+/eIFPAjonIKpObtvg2WPjyE1Lfmhu8dAwh9vQn5tNrY12OvbjusI2D7
         oIRihtsZ9OccWOerJflZGAl0Tnx+6wQMDJQFo1ZvYS24EMrJEF4kFbFE1Zye1TfHqtv9
         ra8KahXUSZqA5WGsALtahPuMRATBc1pSk1uJ+BeJiGgRbxcKp8FP+B2Iz7yQbbbT/m2V
         w4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0Ws/YlbYYoxDYDAzi4lHOOroimYy2NYmSbxJOySDP4=;
        b=d9jlCyUUHmCxLQSFvP6v1hSWZilaIZrMPaNQ+zbKQulLfkYMGHFBQOpxKgtHU75cLr
         aResQT5v238eb1bylscGBom7+7j0RCPYCVjSSVrYGUMfKgFgS/MIXWt5FEi+9aL+COVw
         3t8GtQ1g9Ftj2qk6SWMjpPI6kj63cKyDedy93U0weebWQurM1s/X82ztritZgFZpBpwT
         CXP+AkEa0WqTHh3gLarDu05SrJvdFf6+5W17t4uf7mq53Hp9sR4Yulx3neSR0qdBlSmw
         DiRcWi7wOga2y+qq4TncT9a6Tw8IWTKSUCK0k2uH1tckzlQtDXMwL4Xm7aFdD305Fq/q
         WfVQ==
X-Gm-Message-State: AO0yUKWdY3RXoGBLYBXW74k04KVx7hnCRnTgpOvODWJvcUQ6xIHejXGH
        Bt2TFqCSatI09/fj4MBbNi/ZhYGzKw5zYBKVdJMOWQ==
X-Google-Smtp-Source: AK7set/J+/iYGG/w89J6BRAoLZRY7PDAaMX8d4rSeEC+A9phEA8KjwshqjneIfaPRQlFeIYiRbKJH52D151YyS4LfTQ=
X-Received: by 2002:a25:9a49:0:b0:86a:e417:b66e with SMTP id
 r9-20020a259a49000000b0086ae417b66emr13117ybo.382.1676319951658; Mon, 13 Feb
 2023 12:25:51 -0800 (PST)
MIME-Version: 1.0
References: <1676286704-818-1-git-send-email-quic_kalyant@quicinc.com> <CAD=FV=WdMtzHryJXxMgYqXkqtFzowqcdvWYOxn4du8mQwYKvcg@mail.gmail.com>
In-Reply-To: <CAD=FV=WdMtzHryJXxMgYqXkqtFzowqcdvWYOxn4du8mQwYKvcg@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 13 Feb 2023 22:25:40 +0200
Message-ID: <CAA8EJppF-UuoooGaX6ySo7CqfnSPBoJiVYBb9QRdyqvWBYAXEg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Reserve DSPPs based on user request
To:     Doug Anderson <dianders@chromium.org>
Cc:     Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        swboyd@chromium.org, quic_vpolimer@quicinc.com,
        quic_abhinavk@quicinc.com, marijn.suijten@somainline.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023 at 20:12, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Feb 13, 2023 at 3:11 AM Kalyan Thota <quic_kalyant@quicinc.com> wrote:
> >
> > This series will enable color features on sc7280 target which has
> > primary panel as eDP
> >
> > The series removes DSPP allocation based on encoder type and allows
> > the DSPP reservation based on user request via CTM.
> >
> > The series will release/reserve the dpu resources whenever there is
> > a CTM enable/disable change so that DSPPs are allocated appropriately.
> >
> > Kalyan Thota (4):
> >   drm/msm/dpu: clear DSPP reservations in rm release
> >   drm/msm/dpu: add DSPPs into reservation upon a CTM request
> >   drm/msm/dpu: avoid unnecessary check in DPU reservations
> >   drm/msm/dpu: manage DPU resources if CTM is requested
> >
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 38 ++++++++++++-----------------
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      |  2 ++
> >  drivers/gpu/drm/msm/msm_atomic.c            | 18 ++++++++++++++
> >  drivers/gpu/drm/msm/msm_drv.c               |  2 +-
> >  drivers/gpu/drm/msm/msm_drv.h               |  1 +
> >  5 files changed, 38 insertions(+), 23 deletions(-)
>
> For whatever reason when I use "b4 shazam" on your series it yells:
>
> Patch failed at 0002 drm/msm/dpu: add DSPPs into reservation upon a CTM request
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> error: patch failed: drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:573
> error: drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c: patch does not apply
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
>
> ...but then I can apply it with `git am --show-current-patch=diff |
> patch -p1` and it just applies with fuzz. Presumably Abhniav / Dmitry
> can do the same but it would be nice if your patch applied cleanly to
> msm-next.

Hopefully it is not some 'tested on 5.15' story.

> In any case, I tried this patch on both a herobrine (sc7280) and
> trogdor (sc7180) based board running msm-next (including the sc7280
> patch [1]). In both cases the night light on the internal display
> worked fine when using ChromeOS. External night light didn't work on
> either of them (as expected) because we don't have the compositor
> support yet.
>
> I'm happy enough with:
>
> Tested-by: Douglas Anderson <dianders@chromium.org>

Thanks for the testing!


-- 
With best wishes
Dmitry
