Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547DE6A2109
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjBXSAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBXSAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:00:11 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1030D1ACED;
        Fri, 24 Feb 2023 10:00:10 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id a14-20020a056830100e00b00690ed91749aso78639otp.7;
        Fri, 24 Feb 2023 10:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kyu+xR8UZP+pOviljY2ZOXLy8SmJsrO7tgRJDWszETo=;
        b=SjkHNAwszKfPoMDG+UlfHPNkKG/Ix2fPcqp4jdnqUVpKt434wwURMEDTFjSHECCAKr
         hgyW7x+gqG7f0SqT40AcMmzxf9xuFm66q1kP/HlfhYPjw3rJRqgisiv6i7hgRj7VAsfO
         bZlgrYV1hdX6WBOLMt5Xtxj2dvW94xZEXtaFowimRxQWYiItf80r4qt/EYhspbG/ahC4
         Z/12+jwZtAXxHN5SxToOxmr2EBdirSTR2gOxkVvkhnomly5yQRO+RAxA0L8Red8Uzdio
         CTV6VdbZBJ+pE3KeflvWBKGzB6tISHg8RsM1oXiyEhSDJn5A45HHmVIephVDE+ywBboV
         nNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kyu+xR8UZP+pOviljY2ZOXLy8SmJsrO7tgRJDWszETo=;
        b=naq6ZHdDYXG6beT4X5zD2EI+NY+dOeJmxnL6Ilrhvx4mBv1SOfgK5ma6h6JA3V9ONB
         W5MgQzqjNrAaiqLfNy9QfESYq6ElqtBMRTMqcHNqphnJo298DWdah4y7eA9H/VG864iy
         wPges5GMpvqhUiXqAj8nSWemYQuGjkL5tiqNsGOcmhmU2eJIuJkKX5ZHFQAbkzR4CxD8
         iaVyzgGyY8MM++J9NEl/avPT32P2mefG/ed3+N/DWZt6U/WiawupLyEDcSnZbCAtVDlz
         ALKikCtWP5YxhUN61xFIP9dnAJMCo4X9qUnpoMlkMWq+RrX2aMi74Mj8RE/dTUKsY+b5
         yyHg==
X-Gm-Message-State: AO0yUKVnweioepokq3w/lCRTF2DBQVqUcHxq0FTicJRuM88ZbvK6JxOh
        A2/v/9JXen+WCyNuy1XX4KBMWDOKXEfGdechyqs=
X-Google-Smtp-Source: AK7set/JASt1oqojAXHiDhzXv1JCruI6Psc4ZHESabSlzQPay6v7I4cBgdEY84cuTEJJufR1eLUuocfmK1PT5xVUn28=
X-Received: by 2002:a05:6830:3359:b0:688:cf52:71c4 with SMTP id
 l25-20020a056830335900b00688cf5271c4mr1780766ott.4.1677261609208; Fri, 24 Feb
 2023 10:00:09 -0800 (PST)
MIME-Version: 1.0
References: <20230218211608.1630586-1-robdclark@gmail.com> <20230218211608.1630586-7-robdclark@gmail.com>
 <20230220105345.70e46fa5@eldfell> <CAF6AEGv9fLQCD65ytRTGp=EkNB1QoZYH5ArphgGQALV9J08Cmw@mail.gmail.com>
 <cdd5f892-49b9-1e22-4dc1-95a8a733c453@amd.com> <CAF6AEGuMn3FywPkEtfJ7oZ16A0Bk2aiaRvj4si4od1d3wzXkPw@mail.gmail.com>
 <20230222114900.1b6baf95@eldfell> <CAF6AEGs1_75gg+LCBj6=PH8Jn60PXiE+Kx_2636nP-+pajN8Hg@mail.gmail.com>
 <20230223113814.3010cedc@eldfell> <CAF6AEGuE89kuKTjjzwW1xMppcVw-M4-hcrtifed-mvsCA=cshQ@mail.gmail.com>
 <20230224112630.313d7b76@eldfell> <a47e2686-1e35-39a3-0f0c-6c3b9522f8ff@linux.intel.com>
 <20230224122403.6a088da1@eldfell> <582a9b92-d246-fce2-cf39-539d9a2db17f@linux.intel.com>
 <20230224130053.3f8939e2@eldfell> <c5d046d6-ab8e-2bc7-5110-dba78b91348b@linux.intel.com>
 <74e409dc-b642-779e-a755-b793c378e43a@amd.com>
In-Reply-To: <74e409dc-b642-779e-a755-b793c378e43a@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 24 Feb 2023 09:59:57 -0800
Message-ID: <CAF6AEGs_yzEj81yNP3KhmVP9Yo3rwTc5vntEVrm9tHw6+w1G_g@mail.gmail.com>
Subject: Re: [PATCH v4 06/14] dma-buf/sync_file: Support (E)POLLPRI
To:     Luben Tuikov <luben.tuikov@amd.com>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
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

On Fri, Feb 24, 2023 at 7:27 AM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> On 2023-02-24 06:37, Tvrtko Ursulin wrote:
> >
> > On 24/02/2023 11:00, Pekka Paalanen wrote:
> >> On Fri, 24 Feb 2023 10:50:51 +0000
> >> Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:
> >>
> >>> On 24/02/2023 10:24, Pekka Paalanen wrote:
> >>>> On Fri, 24 Feb 2023 09:41:46 +0000
> >>>> Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:
> >>>>
> >>>>> On 24/02/2023 09:26, Pekka Paalanen wrote:
> >>>>>> On Thu, 23 Feb 2023 10:51:48 -0800
> >>>>>> Rob Clark <robdclark@gmail.com> wrote:
> >>>>>>
> >>>>>>> On Thu, Feb 23, 2023 at 1:38 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> >>>>>>>>
> >>>>>>>> On Wed, 22 Feb 2023 07:37:26 -0800
> >>>>>>>> Rob Clark <robdclark@gmail.com> wrote:
> >>>>>>>>
> >>>>>>>>> On Wed, Feb 22, 2023 at 1:49 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> >>>>>>
> >>>>>> ...
> >>>>>>
> >>>>>>>>>> On another matter, if the application uses SET_DEADLINE with one
> >>>>>>>>>> timestamp, and the compositor uses SET_DEADLINE on the same thing with
> >>>>>>>>>> another timestamp, what should happen?
> >>>>>>>>>
> >>>>>>>>> The expectation is that many deadline hints can be set on a fence.
> >>>>>>>>> The fence signaller should track the soonest deadline.
> >>>>>>>>
> >>>>>>>> You need to document that as UAPI, since it is observable to userspace.
> >>>>>>>> It would be bad if drivers or subsystems would differ in behaviour.
> >>>>>>>>
> >>>>>>>
> >>>>>>> It is in the end a hint.  It is about giving the driver more
> >>>>>>> information so that it can make better choices.  But the driver is
> >>>>>>> even free to ignore it.  So maybe "expectation" is too strong of a
> >>>>>>> word.  Rather, any other behavior doesn't really make sense.  But it
> >>>>>>> could end up being dictated by how the hw and/or fw works.
> >>>>>>
> >>>>>> It will stop being a hint once it has been implemented and used in the
> >>>>>> wild long enough. The kernel userspace regression rules make sure of
> >>>>>> that.
> >>>>>
> >>>>> Yeah, tricky and maybe a gray area in this case. I think we eluded
> >>>>> elsewhere in the thread that renaming the thing might be an option.
> >>>>>
> >>>>> So maybe instead of deadline, which is a very strong word, use something
> >>>>> along the lines of "present time hint", or "signalled time hint"? Maybe
> >>>>> reads clumsy. Just throwing some ideas for a start.
> >>>>
> >>>> You can try, but I fear that if it ever changes behaviour and
> >>>> someone notices that, it's labelled as a kernel regression. I don't
> >>>> think documentation has ever been the authoritative definition of UABI
> >>>> in Linux, it just guides drivers and userspace towards a common
> >>>> understanding and common usage patterns.
> >>>>
> >>>> So even if the UABI contract is not documented (ugh), you need to be
> >>>> prepared to set the UABI contract through kernel implementation.
> >>>
> >>> To be the devil's advocate it probably wouldn't be an ABI regression but
> >>> just an regression. Same way as what nice(2) priorities mean hasn't
> >>> always been the same over the years, I don't think there is a strict
> >>> contract.
> >>>
> >>> Having said that, it may be different with latency sensitive stuff such
> >>> as UIs though since it is very observable and can be very painful to users.
> >>>
> >>>> If you do not document the UABI contract, then different drivers are
> >>>> likely to implement it differently, leading to differing behaviour.
> >>>> Also userspace will invent wild ways to abuse the UABI if there is no
> >>>> documentation guiding it on proper use. If userspace or end users
> >>>> observe different behaviour, that's bad even if it's not a regression.
> >>>>
> >>>> I don't like the situation either, but it is what it is. UABI stability
> >>>> trumps everything regardless of whether it was documented or not.
> >>>>
> >>>> I bet userspace is going to use this as a "make it faster, make it
> >>>> hotter" button. I would not be surprised if someone wrote a LD_PRELOAD
> >>>> library that stamps any and all fences with an expired deadline to
> >>>> just squeeze out a little more through some weird side-effect.
> >>>>
> >>>> Well, that's hopefully overboard in scaring, but in the end, I would
> >>>> like to see UABI documented so I can have a feeling of what it is for
> >>>> and how it was intended to be used. That's all.
> >>>
> >>> We share the same concern. If you read elsewhere in these threads you
> >>> will notice I have been calling this an "arms race". If the ability to
> >>> make yourself go faster does not required additional privilege I also
> >>> worry everyone will do it at which point it becomes pointless. So yes, I
> >>> do share this concern about exposing any of this as an unprivileged uapi.
> >>>
> >>> Is it possible to limit access to only compositors in some sane way?
> >>> Sounds tricky when dma-fence should be disconnected from DRM..
> >>
> >> Maybe it's not that bad in this particular case, because we are talking
> >> only about boosting GPU clocks which benefits everyone (except
> >> battery life) and it does not penalize other programs like e.g.
> >> job priorities do.
> >
> > Apart from efficiency that you mentioned, which does not always favor
> > higher clocks, sometimes thermal budget is also shared between CPU and
> > GPU. So more GPU clocks can mean fewer CPU clocks. It's really hard to
> > make optimal choices without the full coordination between both schedulers.
> >
> > But that is even not the main point, which is that if everyone sets the
> > immediate deadline then having the deadline API is a bit pointless. For
> > instance there is a reason negative nice needs CAP_SYS_ADMIN.
> >
> > However Rob has also pointed out the existence of uclamp.min via
> > sched_setattr which is unprivileged and can influence frequency
> > selection in the CPU world, so I conceded on that point. If CPU world
> > has accepted it so can we I guess.
> >
> > So IMO we are back to whether we can agree defining it is a hint is good
> > enough, be in via the name of the ioctl/flag itself or via documentation.
> >
> >> Drivers are not going to use the deadline for scheduling priorities,
> >> right? I don't recall seeing any mention of that.
> >>
> >> ...right?
> >
> > I wouldn't have thought it would be beneficial to preclude that, or
> > assume what drivers would do with the info to begin with.
> >
> > For instance in i915 we almost had a deadline based scheduler which was
> > much fairer than the current priority sorted fifo and in an ideal world
> > we would either revive or re-implement that idea. In which case
> > considering the fence deadline would naturally slot in and give true
> > integration with compositor deadlines (not just boost clocks and pray it
> > helps).
> How is user-space to decide whether to use ioctl(SET_DEADLINE) or
> poll(POLLPRI)?

Implementation of blocking gl/vk/cl APIs, like glFinish() would use
poll(POLLPRI).  It could also set an immediate deadline and then call
poll() without POLLPRI.

Other than compositors which do frame-pacing I expect the main usage
of either of these is mesa.

BR,
-R

> --
> Regards,
> Luben
>
