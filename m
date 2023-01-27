Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CAB67DC87
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 04:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjA0DIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 22:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjA0DIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 22:08:05 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752CA227A1;
        Thu, 26 Jan 2023 19:08:03 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-16346330067so4931662fac.3;
        Thu, 26 Jan 2023 19:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eWVjgWC+CRaiVU6jf3be0WvlqWbyqa4cbGUte3LE0QY=;
        b=SvGlwWDC+KblJS2mqQCluTm269HgIQaXn+HLtXa7cMZkrTaP7lnJrOIR33mFaXXtH/
         8cL8KrnTBBZBGVXsgQ1DKAHWIM1+EKPpFW4p8IgxhR84Xbv3LigkPTByRA4kMaEdj6TU
         k7Kv1PNhnRA8GIoxbImSjJVcnIGMd9W4vnrh7KM6GtdcdB294Ly2ExbAI4DPIRsycidq
         ebpds6vqjuZg4C56lG2puV681tfO6LsMOE0MJ0KcEX5tTtzSLpp1IujIkVVhugeAFgp9
         cvAJNHs9DU6/eY5NWUZIL8O6Ph//ikJT+Lk7G/rojhpgq5p2I7AuJy6bEG+5t5c459tI
         xUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWVjgWC+CRaiVU6jf3be0WvlqWbyqa4cbGUte3LE0QY=;
        b=osUSeku/sP88UW/fmIhl0IgJ5hEaMz7tsq4ANNqgk4hTplAKS8QMG8uTA69E1EIZ8f
         lcAhQsEhme9lnsx6jmJRNv5ue+xI4Z2VFf5AfV1gG4Ta2doUhhmfvEMDxcdcqV2OM74N
         1UM6X9MInzTNkoJ3xePre6Ffm6ooNrGNxHOLg6Imm8lFb1wB2SP2abJT52v36/1tH3x4
         LFNPOa6MAUxfTYyjr0UTSzqVO/v1mBnF9N27ZDMA8i1/FUbx5WvHwg0tLzQd5GD54iPw
         tro+IxOIfFrjfVzArNZp8PUspW2IvRyOnhCPOdf9+FmUAyKfHUKwcClsrkviA/z0Fmqc
         UMnA==
X-Gm-Message-State: AFqh2koVJAGiwEyHBWif0QmVpLDqz6XG5Pd+QMz370sZHKKEyFU5eP/c
        727sKVSxlvq7+4xcXoAlEXgQ+k22K3QEfB4VtpU=
X-Google-Smtp-Source: AMrXdXtwNNbWR+EBpOWIEthHcrNWHYhATjGinf4U7RAj7/ORzz2dj7jhO7LE+yBhT7G/zMVkJANBNpaCoJ1m0UeBexw=
X-Received: by 2002:a05:6870:44d0:b0:15b:96b8:e2be with SMTP id
 t16-20020a05687044d000b0015b96b8e2bemr2351141oai.38.1674788882705; Thu, 26
 Jan 2023 19:08:02 -0800 (PST)
MIME-Version: 1.0
References: <20230123153745.3185032-1-robdclark@gmail.com> <20230125040403epcms1p1646e9668b87df3e9c344ad58d39b6eb6@epcms1p1>
 <CGME20230123153745epcas1p17e57cf83ed371e86258139473befc615@epcms1p3>
 <CAF6AEGud-ESF=VgcaSFzKsWas0H5eSXZDdZGcnd8Ju=pr-W2EQ@mail.gmail.com> <20230125054626epcms1p38d34dc65cbc9cb29dd707a4b2cac8fb4@epcms1p3>
In-Reply-To: <20230125054626epcms1p38d34dc65cbc9cb29dd707a4b2cac8fb4@epcms1p3>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 26 Jan 2023 19:08:01 -0800
Message-ID: <CAF6AEGvkepf4eLKqXYkadOvtu_7ehCzmgoiq3_s7qvJXi_n3sw@mail.gmail.com>
Subject: Re: Re: [PATCH] PM / devfreq: Fix build issues with devfreq disabled
To:     myungjoo.ham@samsung.com
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 9:46 PM MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>
> >On Tue, Jan 24, 2023 at 8:04 PM MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
> >>
> >> >Sender : Rob Clark <robdclark@gmail.com>
> >> >Date : 2023-01-24 00:37 (GMT+9)
> >> >Title : [PATCH] PM / devfreq: Fix build issues with devfreq disabled
> >> >
> >> >From: Rob Clark <robdclark@chromium.org>
> >> >
> >> >The existing no-op shims for when PM_DEVFREQ (or an individual governor)
> >> >only do half the job.  The governor specific config/tuning structs need
> >> >to be available to avoid compile errors in drivers using devfreq.
> >> >
> >> >Fixes: 6563f60f14cb ("drm/msm/gpu: Add devfreq tuning debugfs")
> >> >Signed-off-by: Rob Clark <robdclark@chromium.org>
> >>
> >> Doesn't this imply that DRM_MSM should depend on PM_DEVFREQ ?
> >>
> >> It appears that gpu/drm/msm/DRM_MSM uses PM_DEVFREQ without actually
> >> declaring the dependency on PM_DEVFREQ.
> >> You cannot use SIMPLE_ONDEMAND without DEVFREQ.
> >
> >Possibly that would resolve some issues, and that might have been my
> >mistake in assuming that depending on SIMPLE_ONDEMAND implied a
> >dependency on DEFREQ (which seems like a reasonable assumption, IMHO)
> >
> >But AFAICT some kernel configs that could otherwise use DRM_MSM don't
> >support PM_DEVFREQ.. either way, lets solve this properly and remove
> >needless dependencies on devfreq.
> >
> >BR,
> >-R
>
> Ok. You are enabling struct and enum only and that looks harmless.
>
> PTAL, Chanwoo.
>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Thanks, if possible, an ack to land this via msm-next would avoid
build break headaches with COMPILE_TEST=y and other more obscure
setups

BR,
-R
