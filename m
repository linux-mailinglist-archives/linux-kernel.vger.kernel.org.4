Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E035C6A9AE3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjCCPnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjCCPnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:43:33 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7F912BF7;
        Fri,  3 Mar 2023 07:43:31 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id bh20so2072615oib.9;
        Fri, 03 Mar 2023 07:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677858210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQxH8ZWizGhpLpVMGBCg+glmrgZwdkg8RYT2oJUwuiw=;
        b=SIS1TIhc+zb2C/l6aPGRZ4hDRWoIWQFGxXdRmasAggox5NmdQ65LymIRkCBSqUqdkF
         LVf/hMHn+k1O1PcYaoU6HAsadpLfo/q1/zD455OpSnrEwIBuoZg0G8xC2rryAFF1H0ZS
         29ExCFQgTjQOIEqe/PC9dS6IF7EtXC1q/QCT9XnBsq2qTZ0hxQ4GOZhUTKZdNbuTqW/b
         wvQDiL8qf+8yv1Emg2y1wneFOItSOsVs0R3B9jpmhOOFzWtuv3muaV23xHXbGuI7CvTl
         ZxDw7LuNWt/LK3M58w6ACdzYekyUtu3zxIQsQ5b3u6bEHyIngPRgMu2vlJ+JbMl7lmE/
         F4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677858210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQxH8ZWizGhpLpVMGBCg+glmrgZwdkg8RYT2oJUwuiw=;
        b=N69qHByyi1lPitQiIAH17TYGRHLMA9xdZ+CxWsw6RUR9vrtwDpaRU8LzMhE8lErF5C
         h+jZ63DQhDxFk7taS9/7YRbqUR1Q6+iHs5N6qreLnzArJ9PwpBL0WfyTKYk0wi2kHEyY
         oGzKwzpfpv/E0wc5NpQfmTCvJpS+eH0hBtFfqi50DbdiHwLvsQmfG9iC7ILtNX7WRhiY
         rf4YKaJENSW6cwcPvgvQm3UixZHUfSpvwoAD1LDT0LCN83yvsjSpoHzvDWHpE5En/JoW
         8KxM7bBK7tImmUiRBW0k4osrd1NZV9ZHSZ5999/syIEvJIyzPeRYBMpz0R766D0Y4e3H
         X+kw==
X-Gm-Message-State: AO0yUKXT43MFo8WZmMA1jR3/vDI2tejKHkSdBfC8u7yPEw2ruemrOQ+L
        RmhjO1SkDi5/fDJPY4pX+y+DRkXk1KgnttrZCts=
X-Google-Smtp-Source: AK7set8WYj13njQ4eDzBoQOY2+mFeBIknWmbCTDY5/hj5Jb/TlKVYgvOi3ICKaHC5TUQE9KdMML0MYqsYHIsEMqs3jI=
X-Received: by 2002:a05:6808:b21:b0:37f:b1ac:6b90 with SMTP id
 t1-20020a0568080b2100b0037fb1ac6b90mr671799oij.0.1677858210555; Fri, 03 Mar
 2023 07:43:30 -0800 (PST)
MIME-Version: 1.0
References: <20230302235356.3148279-1-robdclark@gmail.com> <20230302235356.3148279-16-robdclark@gmail.com>
 <ZAFnqbycMleLmRe9@intel.com> <3bded9d7-9796-4a9b-7c11-aac994d4fdc6@linux.intel.com>
 <CAF6AEGs6QYTESuwB8E9cTbv9LqQX16tz6-geeu9BCyFos9=sOA@mail.gmail.com>
 <ZAILc/fxzBqLv1OF@intel.com> <ZAIQDBD+HPbQA5sr@intel.com>
In-Reply-To: <ZAIQDBD+HPbQA5sr@intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 3 Mar 2023 07:43:19 -0800
Message-ID: <CAF6AEGuvrZs6+9c+bUPaUpZx85Xa-R-oDjFNbC8XRbMd7rvGpA@mail.gmail.com>
Subject: Re: [PATCH v9 15/15] drm/i915: Add deadline based boost support
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Rob Clark <robdclark@chromium.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Matt Turner <mattst88@gmail.com>,
        freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 7:20 AM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Fri, Mar 03, 2023 at 05:00:03PM +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
> > On Fri, Mar 03, 2023 at 06:48:43AM -0800, Rob Clark wrote:
> > > On Fri, Mar 3, 2023 at 1:58 AM Tvrtko Ursulin
> > > <tvrtko.ursulin@linux.intel.com> wrote:
> > > >
> > > >
> > > > On 03/03/2023 03:21, Rodrigo Vivi wrote:
> > > > > On Thu, Mar 02, 2023 at 03:53:37PM -0800, Rob Clark wrote:
> > > > >> From: Rob Clark <robdclark@chromium.org>
> > > > >>
> > > > >
> > > > > missing some wording here...
> > > > >
> > > > >> v2: rebase
> > > > >>
> > > > >> Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > >> ---
> > > > >>   drivers/gpu/drm/i915/i915_request.c | 20 ++++++++++++++++++++
> > > > >>   1 file changed, 20 insertions(+)
> > > > >>
> > > > >> diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/d=
rm/i915/i915_request.c
> > > > >> index 7503dcb9043b..44491e7e214c 100644
> > > > >> --- a/drivers/gpu/drm/i915/i915_request.c
> > > > >> +++ b/drivers/gpu/drm/i915/i915_request.c
> > > > >> @@ -97,6 +97,25 @@ static bool i915_fence_enable_signaling(struc=
t dma_fence *fence)
> > > > >>      return i915_request_enable_breadcrumb(to_request(fence));
> > > > >>   }
> > > > >>
> > > > >> +static void i915_fence_set_deadline(struct dma_fence *fence, kt=
ime_t deadline)
> > > > >> +{
> > > > >> +    struct i915_request *rq =3D to_request(fence);
> > > > >> +
> > > > >> +    if (i915_request_completed(rq))
> > > > >> +            return;
> > > > >> +
> > > > >> +    if (i915_request_started(rq))
> > > > >> +            return;
> > > > >
> > > > > why do we skip the boost if already started?
> > > > > don't we want to boost the freq anyway?
> > > >
> > > > I'd wager Rob is just copying the current i915 wait boost logic.
> > >
> > > Yup, and probably incorrectly.. Matt reported fewer boosts/sec
> > > compared to your RFC, this could be the bug
> >
> > I don't think i915 calls drm_atomic_helper_wait_for_fences()
> > so that could explain something.
>
> Oh, I guess this wasn't even supposed to take over the current
> display boost stuff since you didn't remove the old one.

Right, I didn't try to replace the current thing.. but hopefully at
least make it possible for i915 to use more of the atomic helpers in
the future

BR,
-R

> The current one just boosts after a missed vblank. The deadline
> could use your timer approach I suppose and boost already a bit
> earlier in the hopes of not missing the vblank.
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
