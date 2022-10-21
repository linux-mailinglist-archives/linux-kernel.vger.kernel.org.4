Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A47607F18
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJUTfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJUTfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:35:11 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7A87AB08
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:35:06 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id 8so2192445ilj.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ep8tCByFfUT/Tv/jGz8MVhMNgYEEnAHcpfl6q9bgIZA=;
        b=PA0uXBeYg2xBYb490syGqLONmfChuiet5JBStCvpgW6ZCQfH18WDugcBgNE01slET4
         2XYRENSoGcVK1snsnLZOs92zRLz1su6j9BfMLQfB9ps1gqKJSBtGuwFX0yWulUwLL67W
         jn68uvFI0hnZYontatqIDy+nNcbcWqWZv0x+/S/edZK9bXEXmN/LpOfL1iYE21TRwWQ+
         phCp1E1FUGniz5NrMHwQiCPo+5zcsv0UxQiW5QmvO+WzsKg50F+DGFqMZ1+ArO7tHehI
         bqYer/T+rpJgSwQWwJjeOsAw8cn8QWz931haFSQXYb0WbpExAP4DmEbJcAwDXySNKt6r
         6yvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ep8tCByFfUT/Tv/jGz8MVhMNgYEEnAHcpfl6q9bgIZA=;
        b=BkQHKtx55XBes219io2gwFio74byPnOadQOKZXmIYz3WNSKsv3HYIrIEBl0tHddDnP
         lK2J/6JcpgKNkuUlsmgGfd+B8H9PNCPthNsbY7Q4HkdGxRMdKGDkm4Mmwpp39BQvRGL9
         RVgZ8eoRzLetPZ8RTXaZyDuYw11w4GsqlbgKAP7YzvevXZ6X8XXqN+YcdDzZkYD/B+UL
         tCdTAfxsDOqlM0nKPesXerOZvtlAmTxjwSUIlbB82DXvsMt6XgkF7mTWtX3WmnT0eRVK
         aSZV/4kaTeR5gaOUPY2h5BYMplbKxW9wEXdTFnD+6lK62D3dr0DX8Pb6HBRgenluQrO1
         8Gkg==
X-Gm-Message-State: ACrzQf14ZdAobs6VJjjjPGnaW4ckBhjP6SI8cc9DjxtYEaQXq0szRYkB
        eIHpJ36EfTnBAfM2ixWSKcHJndIYITo31Ksekw88hA==
X-Google-Smtp-Source: AMsMyM7vQBW0f5ImtIKiiwTQqhNzMj7P4Hpvoujud9vD2xFA5kKWxBDQkvmb8bQ8jHt8zHuhNTeDPnzASWbfcFPdxPo=
X-Received: by 2002:a05:6e02:1aaa:b0:2fa:542c:7538 with SMTP id
 l10-20020a056e021aaa00b002fa542c7538mr15170376ilv.260.1666380905474; Fri, 21
 Oct 2022 12:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <128dc161-8949-1146-bf8b-310aa33c06a8@quicinc.com>
 <1663312351-28476-1-git-send-email-quic_aiquny@quicinc.com>
 <20221012204344.GA1178915@p14s> <792f05fc-995e-9a87-ab7d-bee03f15bc79@quicinc.com>
 <20221013173442.GA1279972@p14s> <20221013180334.GB1279972@p14s> <8807a9a6-d93d-aef5-15f4-88648a6ecbe2@quicinc.com>
In-Reply-To: <8807a9a6-d93d-aef5-15f4-88648a6ecbe2@quicinc.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 21 Oct 2022 13:34:54 -0600
Message-ID: <CANLsYkx8Vcha9FpfRvJEkq2pd+mSYFeZQBXj65YoiSBv+WEY4A@mail.gmail.com>
Subject: Re: [PATCH v4] remoteproc: core: do pm relax when in RPROC_OFFLINE
To:     "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_clew@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 at 23:52, Aiqun(Maria) Yu <quic_aiquny@quicinc.com> wrote:
>
> On 10/14/2022 2:03 AM, Mathieu Poirier wrote:
> > On Thu, Oct 13, 2022 at 11:34:42AM -0600, Mathieu Poirier wrote:
> >> On Thu, Oct 13, 2022 at 09:40:09AM +0800, Aiqun(Maria) Yu wrote:
> >>> Hi Mathieu,
> >>>
> >>> On 10/13/2022 4:43 AM, Mathieu Poirier wrote:
> >>>> Please add what has changed from one version to another, either in a cover
> >>>> letter or after the "Signed-off-by".  There are many examples on how to do that
> >>>> on the mailing list.
> >>>>
> >>> Thx for the information, will take a note and benefit for next time.
> >>>
> >>>> On Fri, Sep 16, 2022 at 03:12:31PM +0800, Maria Yu wrote:
> >>>>> RPROC_OFFLINE state indicate there is no recovery process
> >>>>> is in progress and no chance to do the pm_relax.
> >>>>> Because when recovering from crash, rproc->lock is held and
> >>>>> state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
> >>>>> and then unlock rproc->lock.
> >>>>
> >>>> You are correct - because the lock is held rproc->state should be set to RPROC_RUNNING
> >>>> when rproc_trigger_recovery() returns.  If that is not the case then something
> >>>> went wrong.
> >>>>
> >>>> Function rproc_stop() sets rproc->state to RPROC_OFFLINE just before returning,
> >>>> so we know the remote processor was stopped.  Therefore if rproc->state is set
> >>>> to RPROC_OFFLINE something went wrong in either request_firmware() or
> >>>> rproc_start().  Either way the remote processor is offline and the system probably
> >>>> in an unknown/unstable.  As such I don't see how calling pm_relax() can help
> >>>> things along.
> >>>>
> >>> PROC_OFFLINE is possible that rproc_shutdown is triggered and successfully
> >>> finished.
> >>> Even if it is multi crash rproc_crash_handler_work contention issue, and
> >>> last rproc_trigger_recovery bailed out with only
> >>> rproc->state==RPROC_OFFLINE, it is still worth to do pm_relax in pair.
> >>> Since the subsystem may still can be recovered with customer's next trigger
> >>> of rproc_start, and we can make each error out path clean with pm resources.
> >>>
> >>>> I suggest spending time understanding what leads to the failure when recovering
> >>>> from a crash and address that problem(s).
> >>>>
> >>> In current case, the customer's information is that the issue happened when
> >>> rproc_shutdown is triggered at similar time. So not an issue from error out
> >>> of rproc_trigger_recovery.
> >>
> >> That is a very important element to consider and should have been mentioned from
> >> the beginning.  What I see happening is the following:
> >>
> >> rproc_report_crash()
> >>          pm_stay_awake()
> >>          queue_work() // current thread is suspended
> >>
> >> rproc_shutdown()
> >>          rproc_stop()
> >>                  rproc->state = RPROC_OFFLINE;
> >>
> >> rproc_crash_handler_work()
> >>          if (rproc->state == RPROC_OFFLINE)
> >>                  return // pm_relax() is not called
> >>
> >> The right way to fix this is to add a pm_relax() in rproc_shutdown() and
> >> rproc_detach(), along with a very descriptive comment as to why it is needed.
> >
> > Thinking about this further there are more ramifications to consider.  Please
> > confirm the above scenario is what you are facing.  I will advise on how to move
> > forward if that is the case.
> >
> Not sure if the situation is clear or not. So resend the email again.
>
> The above senario is what customer is facing. crash hanppened while at
> the same time shutdown is triggered.

Unfortunately this is not enough details to address a problem as
complex as this one.

> And the device cannto goes to suspend state after that.
> the subsystem can still be start normally after this.

If the code flow I pasted above reflects the problem at hand, the
current patch will not be sufficient to address the issue.  If Arnaud
confirms my suspicions we will have to think about a better solution.

>
> >>
> >>
> >>>> Thanks,
> >>>> Mathieu
> >>>>
> >>>>
> >>>>> When the state is in RPROC_OFFLINE it means separate request
> >>>>> of rproc_stop was done and no need to hold the wakeup source
> >>>>> in crash handler to recover any more.
> >>>>>
> >>>>> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> >>>>> ---
> >>>>>    drivers/remoteproc/remoteproc_core.c | 11 +++++++++++
> >>>>>    1 file changed, 11 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> >>>>> index e5279ed9a8d7..6bc7b8b7d01e 100644
> >>>>> --- a/drivers/remoteproc/remoteproc_core.c
> >>>>> +++ b/drivers/remoteproc/remoteproc_core.c
> >>>>> @@ -1956,6 +1956,17 @@ static void rproc_crash_handler_work(struct work_struct *work)
> >>>>>           if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE) {
> >>>>>                   /* handle only the first crash detected */
> >>>>>                   mutex_unlock(&rproc->lock);
> >>>>> +         /*
> >>>>> +          * RPROC_OFFLINE state indicate there is no recovery process
> >>>>> +          * is in progress and no chance to have pm_relax in place.
> >>>>> +          * Because when recovering from crash, rproc->lock is held and
> >>>>> +          * state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
> >>>>> +          * and then unlock rproc->lock.
> >>>>> +          * RPROC_OFFLINE is only an intermediate state in recovery
> >>>>> +          * process.
> >>>>> +          */
> >>>>> +         if (rproc->state == RPROC_OFFLINE)
> >>>>> +                 pm_relax(rproc->dev.parent);
> >>>>>                   return;
> >>>>>           }
> >>>>> --
> >>>>> 2.7.4
> >>>>>
> >>>
> >>>
> >>> --
> >>> Thx and BRs,
> >>> Aiqun(Maria) Yu
>
>
> --
> Thx and BRs,
> Aiqun(Maria) Yu
