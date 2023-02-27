Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982EA6A4A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjB0SoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjB0SoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:44:04 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27DD6EBA;
        Mon, 27 Feb 2023 10:44:02 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id a23-20020a4ad5d7000000b005250867d3d9so1144944oot.10;
        Mon, 27 Feb 2023 10:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mesnb1oiHvr7mwr5ss9hBAKLlAyB+4Bo536+J7z5VMo=;
        b=h3B4WFzwYESzlvVnJEVFaRBnfcWdRGdSx2qpI68M5W8FjBX8oKL9P2/eOpC+lVck4E
         6nsVoEhtD74mf4tyHCzDzecwJUXmIzyTunj/hxcEpnQNt8dz9t6pP+QePjRPwVF/xhDs
         yP0VoSMAWsHesDeKTfIfmkY2I4E1UMrY1A7mwLQlAOJKjg+3n2wXD6MxkdeZMbdYN1Aa
         j70QvVa4qunA4DbALJJtiAo8lkhQAzshkMGcaL453bMbMrLfWFe9FQapEKtuMZWqXCRQ
         6z5MpcaCPWCWCvSL+mAEpXYiUifeCmJC5LiIf8OHaH6ewDah1Lv2++Bj9VddwyODpVCb
         /TLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mesnb1oiHvr7mwr5ss9hBAKLlAyB+4Bo536+J7z5VMo=;
        b=AInFVGh7EQwcOlPXJ1Lo0jm1pZxoOu5rIcbwE3QvNbKUAdi0rhY5J0+R8aBt6CEFSL
         Ts+KQQfvH53WjnWoHbADo/XGiGXB+VmmH+qxmTfduqrGvOBPEz9QRk4VBgS9O/nl9ZHC
         x35GsTWUTj/J6wMAGurxmn7j9z7Xgjy3TXSw+EvvfMLLIJMrM0PUCi9eWBpUdPUssCIv
         Zj+BpGMzl5KLkHgkes4k0dvozSR8Oalkg8ke1SZhhDdrS6i6jaNOzvJOps2S/3rjV09C
         FwJJY2lFnRBIBAT9seKTJ1ar+7GMCOzbnpWEdsJhOEi/Kdtoi8H9WdcUpnty6zbicG2F
         RcBQ==
X-Gm-Message-State: AO0yUKUp1uAxFXQfdy1KS/1ZgXLdH9yHFg30MIGc3FmFVnw4KfhyDICw
        AB+OTVWnuaoiR7J9um17RR2rBJKZihLwSYEgPEE=
X-Google-Smtp-Source: AK7set++Us+45LVkFaJLpqZEB2WGemE8aLhOeaWetztSPUq4wNUZ0E9KWs+pjyC7Rz30R7jmPG9m4Y3xGyiWqj/q3Fw=
X-Received: by 2002:a4a:e907:0:b0:524:f77c:5443 with SMTP id
 bx7-20020a4ae907000000b00524f77c5443mr254051oob.1.1677523441815; Mon, 27 Feb
 2023 10:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20230218211608.1630586-1-robdclark@gmail.com> <20230218211608.1630586-7-robdclark@gmail.com>
 <20230220105345.70e46fa5@eldfell> <CAF6AEGv9fLQCD65ytRTGp=EkNB1QoZYH5ArphgGQALV9J08Cmw@mail.gmail.com>
 <cdd5f892-49b9-1e22-4dc1-95a8a733c453@amd.com> <CAF6AEGuMn3FywPkEtfJ7oZ16A0Bk2aiaRvj4si4od1d3wzXkPw@mail.gmail.com>
 <20230222114900.1b6baf95@eldfell> <CAF6AEGs1_75gg+LCBj6=PH8Jn60PXiE+Kx_2636nP-+pajN8Hg@mail.gmail.com>
 <20230223113814.3010cedc@eldfell> <CAF6AEGuE89kuKTjjzwW1xMppcVw-M4-hcrtifed-mvsCA=cshQ@mail.gmail.com>
 <20230224112630.313d7b76@eldfell> <a47e2686-1e35-39a3-0f0c-6c3b9522f8ff@linux.intel.com>
 <20230224122403.6a088da1@eldfell> <CAF6AEGsu666v9iOy2H20-JNkzi4Av0+OtrLBo_3CjRGByUPD0A@mail.gmail.com>
 <20230227113421.6e31b54d@eldfell>
In-Reply-To: <20230227113421.6e31b54d@eldfell>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 27 Feb 2023 10:43:50 -0800
Message-ID: <CAF6AEGsG6QXhiuDo4HA5BcvmWiTkcxsoF0AwPYSdOtYQfYtWuw@mail.gmail.com>
Subject: Re: [PATCH v4 06/14] dma-buf/sync_file: Support (E)POLLPRI
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        freedreno@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>
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

On Mon, Feb 27, 2023 at 1:34 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
>
> On Fri, 24 Feb 2023 11:44:53 -0800
> Rob Clark <robdclark@gmail.com> wrote:
>
> > On Fri, Feb 24, 2023 at 2:24 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> > >
> > > On Fri, 24 Feb 2023 09:41:46 +0000
> > > Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:
> > >
> > > > On 24/02/2023 09:26, Pekka Paalanen wrote:
> > > > > On Thu, 23 Feb 2023 10:51:48 -0800
> > > > > Rob Clark <robdclark@gmail.com> wrote:
> > > > >
> > > > >> On Thu, Feb 23, 2023 at 1:38 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> > > > >>>
> > > > >>> On Wed, 22 Feb 2023 07:37:26 -0800
> > > > >>> Rob Clark <robdclark@gmail.com> wrote:
> > > > >>>
> > > > >>>> On Wed, Feb 22, 2023 at 1:49 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> > > > >
> > > > > ...
> > > > >
> > > > >>>>> On another matter, if the application uses SET_DEADLINE with one
> > > > >>>>> timestamp, and the compositor uses SET_DEADLINE on the same thing with
> > > > >>>>> another timestamp, what should happen?
> > > > >>>>
> > > > >>>> The expectation is that many deadline hints can be set on a fence.
> > > > >>>> The fence signaller should track the soonest deadline.
> > > > >>>
> > > > >>> You need to document that as UAPI, since it is observable to userspace.
> > > > >>> It would be bad if drivers or subsystems would differ in behaviour.
> > > > >>>
> > > > >>
> > > > >> It is in the end a hint.  It is about giving the driver more
> > > > >> information so that it can make better choices.  But the driver is
> > > > >> even free to ignore it.  So maybe "expectation" is too strong of a
> > > > >> word.  Rather, any other behavior doesn't really make sense.  But it
> > > > >> could end up being dictated by how the hw and/or fw works.
> > > > >
> > > > > It will stop being a hint once it has been implemented and used in the
> > > > > wild long enough. The kernel userspace regression rules make sure of
> > > > > that.
> > > >
> > > > Yeah, tricky and maybe a gray area in this case. I think we eluded
> > > > elsewhere in the thread that renaming the thing might be an option.
> > > >
> > > > So maybe instead of deadline, which is a very strong word, use something
> > > > along the lines of "present time hint", or "signalled time hint"? Maybe
> > > > reads clumsy. Just throwing some ideas for a start.
> > >
> > > You can try, but I fear that if it ever changes behaviour and
> > > someone notices that, it's labelled as a kernel regression. I don't
> > > think documentation has ever been the authoritative definition of UABI
> > > in Linux, it just guides drivers and userspace towards a common
> > > understanding and common usage patterns.
> > >
> > > So even if the UABI contract is not documented (ugh), you need to be
> > > prepared to set the UABI contract through kernel implementation.
> > >
> > > If you do not document the UABI contract, then different drivers are
> > > likely to implement it differently, leading to differing behaviour.
> > > Also userspace will invent wild ways to abuse the UABI if there is no
> > > documentation guiding it on proper use. If userspace or end users
> > > observe different behaviour, that's bad even if it's not a regression.
> > >
> > > I don't like the situation either, but it is what it is. UABI stability
> > > trumps everything regardless of whether it was documented or not.
> > >
> > > I bet userspace is going to use this as a "make it faster, make it
> > > hotter" button. I would not be surprised if someone wrote a LD_PRELOAD
> > > library that stamps any and all fences with an expired deadline to
> > > just squeeze out a little more through some weird side-effect.
> >
> > Userspace already has various (driver specific) debugfs/sysfs that it
> > can use if it wants to make it hotter and drain batteries faster, so
> > I'm not seeing a strong need to cater to the "turn it up to eleven"
> > crowd here.  And really your point feels like a good reason to _not_
> > document this as anything more than a hint.
>
> My point is that no matter what you say in documentation or leave
> unsaid, people can and will abuse this by the behaviour it provides
> anyway, like every other UABI.
>
> So why not just document what it is supposed to do? It cannot get any
> worse. Maybe you get lucky instead and people don't abuse it that much
> if they read the docs.
>
> E.g. can it affect GPU job scheduling, can it affect GPU clocks, can it
> affect power consumption, and so on.

I expect, potentially, all or any, or none of the above ;-)

I guess I could document it as such, just to preempt potential
complaints about broken spacebar-heater.  The question is, where?  I
could add something about fence deadline hints in dma-buf.rst, which
would I think be useful in general for driver writers.  But there
isn't really any existing documents other than headerdoc comments for
sync_file ioctls, or drm_syncobj related ioctls (the latter are really
just for mesa to use, so maybe that is ok).

>
> > Back in the real world, mobile games are already well aware of the fps
> > vs battery-life (and therefore gameplay) tradeoff.  But what is
> > missing is a way to inform the kernel of userspace's intentions, so
> > that gpu dvfs can make intelligent decisions.  This series is meant to
> > bridge that gap.
>
> Then document that. As long as you document it properly: what you
> expect it to be used for and how.
>
> Or if this is reserved strictly for Mesa drivers, then document that.

I expect the SET_DEADLINE ioctl to be useful to compositors, and maybe
a few other cases.  I'd like to use it in virglrenderer to bridge
guest deadline hints to host kernel, for example.

BR,
-R

> You can also stop CC'ing me if you don't want attention to UABI docs. I
> don't read dri-devel@ unless I'm explicitly CC'd nowadays.
>
>
> Thanks,
> pq
