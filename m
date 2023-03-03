Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879BC6A9E59
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjCCSUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjCCSUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:20:51 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D88EC79;
        Fri,  3 Mar 2023 10:20:49 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id z5so2251479ilq.0;
        Fri, 03 Mar 2023 10:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axdACOpDgX4dqbHNbIgw6l/7ldg/vQEmMI8fQauJgl8=;
        b=QczMEiEgQw99JTo6idDjCmdUY+sExwLtJY3/KxeKkvYdy0yKmdUEPD0dgjI7WTlutJ
         tdoXP8gPcHCyv03Mt3F59SccC5tXpCy4xMbgV/Va1gbe1xpd7QRnEuJeCjvKLDCVnxiy
         GTAst35/hfaVx/jtfzPmqmH2i3H7VA6+h6eACYF+gFiKRcy6SHcNGVuCKb632mAE5FFD
         jyMD/rneQS2DLsvlGqrApDw2hWb5Wei9gvmhqogPv1qmFtOkgQ/Wsze9U8yuRtejB+l+
         Al2mUiQ0CI6j6QyECn0Tmf0ZM/+uervRLoZ9A7RtA3ORLXu8ei5N1WedxMbhvS36QH8Q
         2FCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axdACOpDgX4dqbHNbIgw6l/7ldg/vQEmMI8fQauJgl8=;
        b=volTYS2s52JX9k841D/3xL34NI9/077AJKsUZDbW1xUOU8DapPPnAGYpfNvE+J1EI5
         HYP2ieyMj9L6MZ7jdsetUMpQTaMmk5Q4BdsYkBYOQqO2UuvyGIxGDSxKbV5p9fWn39bp
         2M8+Qiqstbs5Hh/b/DV2ihopV4k5mMO3m3Xno8RjlT/LNMZEh/GZYfCDSZVX1sVurneH
         euaOvUa7gxzD/C47QKCaAR1/9xto0qKATA110cDl1zds2kiESSCwh0knktl6FAxTHUE6
         g1rqf59NEPTxL4EyK298EluJB5h8gKwkU0A37r4kjUEvqQCedZDD/iLc7Zwam0b+/RU/
         jVtw==
X-Gm-Message-State: AO0yUKXnMrYddHQ+l5eTLxk6gmAQb62bH4jJPgEPEkEeb9jPuNr8TtJ/
        WzsK21Eoiyw6VfSYXJr8O19lurFJP+/9EDP1L0s=
X-Google-Smtp-Source: AK7set8Qed7nPAs7RH0XEMozjccCh754nLRwreSB3nR6IUtV2hYZym8/5UTUtz+kyz5kn3EXFUYQKPVWknxcgmIQOPA=
X-Received: by 2002:a05:6e02:130f:b0:315:9761:6965 with SMTP id
 g15-20020a056e02130f00b0031597616965mr1232665ilr.5.1677867649207; Fri, 03 Mar
 2023 10:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20230302235356.3148279-1-robdclark@gmail.com> <20230302235356.3148279-16-robdclark@gmail.com>
 <ZAFnqbycMleLmRe9@intel.com> <3bded9d7-9796-4a9b-7c11-aac994d4fdc6@linux.intel.com>
 <CAF6AEGs6QYTESuwB8E9cTbv9LqQX16tz6-geeu9BCyFos9=sOA@mail.gmail.com> <a5ced581-4060-0fa2-d2fc-d18beee6fdb5@linux.intel.com>
In-Reply-To: <a5ced581-4060-0fa2-d2fc-d18beee6fdb5@linux.intel.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Fri, 3 Mar 2023 13:20:38 -0500
Message-ID: <CAEdQ38FLf0jX6oWCkmx+xwgF8YAH8xSwhw5RUGC3xwdDBr7NVQ@mail.gmail.com>
Subject: Re: [PATCH v9 15/15] drm/i915: Add deadline based boost support
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        intel-gfx@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 10:08=E2=80=AFAM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> On 03/03/2023 14:48, Rob Clark wrote:
> > On Fri, Mar 3, 2023 at 1:58 AM Tvrtko Ursulin
> > <tvrtko.ursulin@linux.intel.com> wrote:
> >>
> >>
> >> On 03/03/2023 03:21, Rodrigo Vivi wrote:
> >>> On Thu, Mar 02, 2023 at 03:53:37PM -0800, Rob Clark wrote:
> >>>> From: Rob Clark <robdclark@chromium.org>
> >>>>
> >>>
> >>> missing some wording here...
> >>>
> >>>> v2: rebase
> >>>>
> >>>> Signed-off-by: Rob Clark <robdclark@chromium.org>
> >>>> ---
> >>>>    drivers/gpu/drm/i915/i915_request.c | 20 ++++++++++++++++++++
> >>>>    1 file changed, 20 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i=
915/i915_request.c
> >>>> index 7503dcb9043b..44491e7e214c 100644
> >>>> --- a/drivers/gpu/drm/i915/i915_request.c
> >>>> +++ b/drivers/gpu/drm/i915/i915_request.c
> >>>> @@ -97,6 +97,25 @@ static bool i915_fence_enable_signaling(struct dm=
a_fence *fence)
> >>>>       return i915_request_enable_breadcrumb(to_request(fence));
> >>>>    }
> >>>>
> >>>> +static void i915_fence_set_deadline(struct dma_fence *fence, ktime_=
t deadline)
> >>>> +{
> >>>> +    struct i915_request *rq =3D to_request(fence);
> >>>> +
> >>>> +    if (i915_request_completed(rq))
> >>>> +            return;
> >>>> +
> >>>> +    if (i915_request_started(rq))
> >>>> +            return;
> >>>
> >>> why do we skip the boost if already started?
> >>> don't we want to boost the freq anyway?
> >>
> >> I'd wager Rob is just copying the current i915 wait boost logic.
> >
> > Yup, and probably incorrectly.. Matt reported fewer boosts/sec
> > compared to your RFC, this could be the bug
>
> Hm, there I have preserved this same !i915_request_started logic.
>
> Presumably it's not just fewer boosts but lower performance. How is he
> setting the deadline? Somehow from clFlush or so?
>
> Regards,
>
> Tvrtko
>
> P.S. Take note that I did not post the latest version of my RFC. The one
> where I fix the fence chain and array misses you pointed out. I did not
> think it would be worthwhile given no universal love for it, but if
> people are testing with it more widely that I was aware perhaps I should.

Yep, that would be great. We're interested in it for ChromeOS. Please
Cc me on the series when you send it.
