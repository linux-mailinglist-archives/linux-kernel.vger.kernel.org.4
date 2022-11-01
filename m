Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3596152C8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 21:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiKAUL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 16:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKAULx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:11:53 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27771BEAC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 13:11:51 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id l6so8415254ilq.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 13:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mLLx1a78lJLl5l4L2ZdRt+V05DeFH5SG+BbEf9OcZfI=;
        b=yEFW9QmrwZO1asOCR4nbC91yWWwtZNCrZeeaBltP5Jd8lGRPBGBJbnj2Em9IyFMpj1
         m6JDzRcsdTdiCBqKY1ytkmTANGIVONBBvxbWoJL90fra6/wIusv7RAfEzEiJlZqNpFEn
         md0u+0CYXA96KxJKJhqgpZdrpeEUuGUZMB1hOA00MKxyIwoa0C2Orr2MemjyNdn/XEOl
         SOJPmBfxUj7GCeytOkDJKrO8Ev3z9hoXvZyMwwhOjrDjmWt7xGerYTilAbselwkHAkEE
         aZM2Wbv72cEUyYIbMFKgJixosFU6qZW0KSVxn7vykGGCNV8JVH0neu2ahWMiuj24fmSp
         kUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLLx1a78lJLl5l4L2ZdRt+V05DeFH5SG+BbEf9OcZfI=;
        b=aQt/rAHSU7AHk2W/aE4EfwQhZr7c63OC7foAd3NBU6+8j775GPzJL5WMa5okpYNzIS
         iY1xjGnX+C5jTvoYwRjemF2rCuJWiYFnLhgVYbgf6amfKhpCuCzIJ5va1sb3obLd6/+1
         xVmL/sTPpAXVJ2avcNeWZtIkwu9d8Si2YTafjMxUMctUIoZ0wPMEf28Ye8RSXHi5uBQb
         o57dkCaRLRZrAj7PJRDgJsLfdSWi7IGLuAMkM2JQkl/DQk9tA46kdDHx/bWwKLpECFTZ
         aCmAuPWKSu+tr8Ac87mhbW+UT0vyjny7Oj0mXffEPGUCAZTmW7wtPrnkpkSLqqx2mDNf
         aK0w==
X-Gm-Message-State: ACrzQf315K/cZH20uKlbbY5PHkeQiBGkBzn/X0KVz6D3e1nllcjpc+jM
        A+rr5gfJqmQpD0D9MvD/IbetOE3+wLC4E34hOxRN4g==
X-Google-Smtp-Source: AMsMyM7ipR4ZQqgkFKCWS6Wywx49XnCwp5+UYa5nnqVbS8oIjvFTSvFS1KRBcAp4cZ0sVwE63PbOAs66L7XyL7lNyeY=
X-Received: by 2002:a92:cb8c:0:b0:300:7897:1c9e with SMTP id
 z12-20020a92cb8c000000b0030078971c9emr151444ilo.212.1667333511226; Tue, 01
 Nov 2022 13:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <128dc161-8949-1146-bf8b-310aa33c06a8@quicinc.com>
 <1663312351-28476-1-git-send-email-quic_aiquny@quicinc.com>
 <20221012204344.GA1178915@p14s> <792f05fc-995e-9a87-ab7d-bee03f15bc79@quicinc.com>
 <20221013173442.GA1279972@p14s> <20221013180334.GB1279972@p14s>
 <8807a9a6-d93d-aef5-15f4-88648a6ecbe2@quicinc.com> <CANLsYkx8Vcha9FpfRvJEkq2pd+mSYFeZQBXj65YoiSBv+WEY4A@mail.gmail.com>
 <70828854-8427-8ce1-1535-e14261fd122d@quicinc.com> <420faf00-d59e-57c6-55a5-fae08a411517@foss.st.com>
In-Reply-To: <420faf00-d59e-57c6-55a5-fae08a411517@foss.st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 1 Nov 2022 14:11:39 -0600
Message-ID: <CANLsYkw1Ex0TfmG-tRhHJgn3LsdvNhS_6HjJXn=ogwcCOWbH_A@mail.gmail.com>
Subject: Re: [PATCH v4] remoteproc: core: do pm relax when in RPROC_OFFLINE
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_clew@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 at 09:31, Arnaud POULIQUEN
<arnaud.pouliquen@foss.st.com> wrote:
>
> Hi,
>
> On 10/24/22 05:17, Aiqun(Maria) Yu wrote:
> > On 10/22/2022 3:34 AM, Mathieu Poirier wrote:
> >> On Wed, 19 Oct 2022 at 23:52, Aiqun(Maria) Yu <quic_aiquny@quicinc.com> wrote:
> >>>
> >>> On 10/14/2022 2:03 AM, Mathieu Poirier wrote:
> >>>> On Thu, Oct 13, 2022 at 11:34:42AM -0600, Mathieu Poirier wrote:
> >>>>> On Thu, Oct 13, 2022 at 09:40:09AM +0800, Aiqun(Maria) Yu wrote:
> >>>>>> Hi Mathieu,
> >>>>>>
> >>>>>> On 10/13/2022 4:43 AM, Mathieu Poirier wrote:
> >>>>>>> Please add what has changed from one version to another, either in a cover
> >>>>>>> letter or after the "Signed-off-by".  There are many examples on how to
> >>>>>>> do that
> >>>>>>> on the mailing list.
> >>>>>>>
> >>>>>> Thx for the information, will take a note and benefit for next time.
> >>>>>>
> >>>>>>> On Fri, Sep 16, 2022 at 03:12:31PM +0800, Maria Yu wrote:
> >>>>>>>> RPROC_OFFLINE state indicate there is no recovery process
> >>>>>>>> is in progress and no chance to do the pm_relax.
> >>>>>>>> Because when recovering from crash, rproc->lock is held and
> >>>>>>>> state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
> >>>>>>>> and then unlock rproc->lock.
> >>>>>>>
> >>>>>>> You are correct - because the lock is held rproc->state should be set to
> >>>>>>> RPROC_RUNNING
> >>>>>>> when rproc_trigger_recovery() returns.  If that is not the case then
> >>>>>>> something
> >>>>>>> went wrong.
> >>>>>>>
> >>>>>>> Function rproc_stop() sets rproc->state to RPROC_OFFLINE just before
> >>>>>>> returning,
> >>>>>>> so we know the remote processor was stopped.  Therefore if rproc->state
> >>>>>>> is set
> >>>>>>> to RPROC_OFFLINE something went wrong in either request_firmware() or
> >>>>>>> rproc_start().  Either way the remote processor is offline and the system
> >>>>>>> probably
> >>>>>>> in an unknown/unstable.  As such I don't see how calling pm_relax() can help
> >>>>>>> things along.
> >>>>>>>
> >>>>>> PROC_OFFLINE is possible that rproc_shutdown is triggered and successfully
> >>>>>> finished.
> >>>>>> Even if it is multi crash rproc_crash_handler_work contention issue, and
> >>>>>> last rproc_trigger_recovery bailed out with only
> >>>>>> rproc->state==RPROC_OFFLINE, it is still worth to do pm_relax in pair.
> >>>>>> Since the subsystem may still can be recovered with customer's next trigger
> >>>>>> of rproc_start, and we can make each error out path clean with pm resources.
> >>>>>>
> >>>>>>> I suggest spending time understanding what leads to the failure when
> >>>>>>> recovering
> >>>>>>> from a crash and address that problem(s).
> >>>>>>>
> >>>>>> In current case, the customer's information is that the issue happened when
> >>>>>> rproc_shutdown is triggered at similar time. So not an issue from error out
> >>>>>> of rproc_trigger_recovery.
> >>>>>
> >>>>> That is a very important element to consider and should have been mentioned
> >>>>> from
> >>>>> the beginning.  What I see happening is the following:
> >>>>>
> >>>>> rproc_report_crash()
> >>>>>           pm_stay_awake()
> >>>>>           queue_work() // current thread is suspended
> >>>>>
> >>>>> rproc_shutdown()
> >>>>>           rproc_stop()
> >>>>>                   rproc->state = RPROC_OFFLINE;
> >>>>>
> >>>>> rproc_crash_handler_work()
> >>>>>           if (rproc->state == RPROC_OFFLINE)
> >>>>>                   return // pm_relax() is not called
> >>>>>
> >>>>> The right way to fix this is to add a pm_relax() in rproc_shutdown() and
> >>>>> rproc_detach(), along with a very descriptive comment as to why it is needed.
> >>>>
> >>>> Thinking about this further there are more ramifications to consider.  Please
> >>>> confirm the above scenario is what you are facing.  I will advise on how to
> >>>> move
> >>>> forward if that is the case.
> >>>>
> >>> Not sure if the situation is clear or not. So resend the email again.
> >>>
> >>> The above senario is what customer is facing. crash hanppened while at
> >>> the same time shutdown is triggered.
> >>
> >> Unfortunately this is not enough details to address a problem as
> >> complex as this one.
> >>
> >>> And the device cannto goes to suspend state after that.
> >>> the subsystem can still be start normally after this.
> >>
> >> If the code flow I pasted above reflects the problem at hand, the
> >> current patch will not be sufficient to address the issue.  If Arnaud
> >> confirms my suspicions we will have to think about a better solution.
> >>
> >
> > Hi Mathiew,
> >
> > Could you pls have more details of any side effects other then power issue of
> > the current senario?
> > Why the current patch is not sufficient pls?
> >
> >
> > Have the current senario in details with rproc->lock information in details:
> >
> > | subsystem crashed interrupt issued      | user trigger shutdown
> > | rproc_report_crash()                    |
> > |          pm_stay_awake()                |
> > |          queue_work()                   |
> > |                                         |rproc_shutdown
> > |                                         |mutex_lock(&rproc->lock);
> > |                                         |rproc_stop()
> > |rproc_crash_handler_work()               |rproc->state = RPROC_OFFLINE;
> > |                                         |mutex_unlock(&rproc->lock);
> > |mutex_lock(&rproc->lock);                |
> > |if (rproc->state == RPROC_OFFLINE)       |
> > |return // pm_relax() is not called       |rproc_boot
> > |mutex_unlock(&rproc->lock);              |
> > |                                         |mutex_lock(&rproc->lock);
> > |                                         |rproc_start()
> > |                                         |mutex_unlock(&rproc->lock);
> >
> >
>
> Agree with Mathieu, this is not so simple.
>

Thanks for looking into this.

> Here is my view  hoping I haven't missed a point in your discussion or
> an other corner cases.
>
> I tried to analyze the issues (in what follows, the term "condition" means
> the "if" condition in which Aiqun proposes to add the fix) :
>
> I can see 4 use cases with race condition
>
> 1) crash report while already one is treated (rproc_boot_recovery called)
>      => not a real use case as if the remote processor is crashed we
>               should not have a second crash report
>

That part is of great concern to me.  *Theoretically* we should not
get a new crash report while one has already been dispatched but the
current code accounts for this scenario and as such the possibility
can't be dismissed.  Therefore we need to expect rproc_report_crash()
to be called multiple times before a single instance of
rproc_boot_recovery() is scheduled.

> 2) rproc_stop executed between the queuing of the crash work and the call of
>   rproc_crash_handler_work
>    => rproc->state = RPROC_OFFLINE
>    => we enter in the "condition" and the pm_relax has to be called
>    => This commit fix should solve this use case
>
> 3) rproc_detach executed between the queue of the crash work and the call of
>   rproc_crash_handler_work
>    => rproc->state = RPROC_DETACHED;
>    => we don't go in "the condition" and issue because the recovery reattach
>       to the remote processor
>    => but pm_relax is called
>    => probably need an extra fix to avoid to re-attach
>
> 4) crash report while already one is treated (rproc_attach_recovery called)
>    this one corresponds to an auto reboot of the remote processor, with a
>    new crash
>    => rproc->state = RPROC_CRASHED or rproc->state = RPROC_DETACHED;
>    4)a) rproc->state = RPROC_CRASHED if rproc->recovery_disabled = true
>         => should call pm_relax if rproc->recovery_disabled = true
>         => commit does not work for this use case
>
>    4)b) rproc->state = RPROC_DETACHED if recovery fails
>        => error case with an unstable state
>        => how to differentiate it from the use case 3) ?
>        => introduce a RPROC_RECOVERY_FAIL state?
>

The case where a recovery fails needs to be considered and is the
reason the original patch doesn't work.  Right now in
rproc_crash_handler_work(), it is not possible to differentiate
between a legitimate shutdown request (scenario #2 above) and a
recovery that went wrong.  I think introducing RPROC_RECOVERY_FAIL
would greatly simplify things.

My initial evaluation had not considered the attach/detach scenarios -
thanks for adding that in the mix.

Aiqun, please send a new patchset that adds a new remote processor
state, i.e RPROC_RECOVERY_FAIL.  There should also be another patch in
that set that takes attach/detach scenarios into account.  The code
between the v6.0 and v6.1 cycle has changed a lot in that area so make
sure to properly rebase.

>
> Then pm_stay_awake is called when the crash work is queued.
> It seems to me coherent to call the pm_relax in the work handler.
>
>
>
> Here is a quick and dirty patch (not tested) that should take into account the
> main use cases ( except 1) and 4)b) )
>
> @@ -2009,8 +2009,18 @@ static void rproc_crash_handler_work(struct work_struct *work)
>
>         mutex_lock(&rproc->lock);
>
> -       if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE) {
> +       if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE ||
> +           rproc->state == RPROC_DETACHED) {
>                 /* handle only the first crash detected */
> +
> +               /*
> +                * call pm-relax in following use cases:
> +                * - the remote processor has been stopped by the user
> +                * - the remote processor is detached
> +                + - the remote proc has an autonomous reset but recovery_disabled is true.
> +                */
> +               if(rproc->state != RPROC_CRASHED || rproc->recovery_disabled)
> +                       pm_relax(rproc->dev.parent);
>                 mutex_unlock(&rproc->lock);
>                 return;
>         }
>
> Regards,
> Arnaud
>
> >>>
> >>>>>
> >>>>>
> >>>>>>> Thanks,
> >>>>>>> Mathieu
> >>>>>>>
> >>>>>>>
> >>>>>>>> When the state is in RPROC_OFFLINE it means separate request
> >>>>>>>> of rproc_stop was done and no need to hold the wakeup source
> >>>>>>>> in crash handler to recover any more.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> >>>>>>>> ---
> >>>>>>>>     drivers/remoteproc/remoteproc_core.c | 11 +++++++++++
> >>>>>>>>     1 file changed, 11 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/remoteproc/remoteproc_core.c
> >>>>>>>> b/drivers/remoteproc/remoteproc_core.c
> >>>>>>>> index e5279ed9a8d7..6bc7b8b7d01e 100644
> >>>>>>>> --- a/drivers/remoteproc/remoteproc_core.c
> >>>>>>>> +++ b/drivers/remoteproc/remoteproc_core.c
> >>>>>>>> @@ -1956,6 +1956,17 @@ static void rproc_crash_handler_work(struct
> >>>>>>>> work_struct *work)
> >>>>>>>>            if (rproc->state == RPROC_CRASHED || rproc->state ==
> >>>>>>>> RPROC_OFFLINE) {
> >>>>>>>>                    /* handle only the first crash detected */
> >>>>>>>>                    mutex_unlock(&rproc->lock);
> >>>>>>>> +         /*
> >>>>>>>> +          * RPROC_OFFLINE state indicate there is no recovery process
> >>>>>>>> +          * is in progress and no chance to have pm_relax in place.
> >>>>>>>> +          * Because when recovering from crash, rproc->lock is held and
> >>>>>>>> +          * state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
> >>>>>>>> +          * and then unlock rproc->lock.
> >>>>>>>> +          * RPROC_OFFLINE is only an intermediate state in recovery
> >>>>>>>> +          * process.
> >>>>>>>> +          */
> >>>>>>>> +         if (rproc->state == RPROC_OFFLINE)
> >>>>>>>> +                 pm_relax(rproc->dev.parent);
> >>>>>>>>                    return;
> >>>>>>>>            }
> >>>>>>>> --
> >>>>>>>> 2.7.4
> >>>>>>>>
> >>>>>>
> >>>>>>
> >>>>>> --
> >>>>>> Thx and BRs,
> >>>>>> Aiqun(Maria) Yu
> >>>
> >>>
> >>> --
> >>> Thx and BRs,
> >>> Aiqun(Maria) Yu
> >
> >
