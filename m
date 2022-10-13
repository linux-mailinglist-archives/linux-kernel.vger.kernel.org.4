Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACA15FDF15
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJMRez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJMRew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:34:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C3712AD9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:34:46 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o17-20020a17090aac1100b0020d98b0c0f4so4185181pjq.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i39DpSGkp8A10ysnMtqm1kXI7Ca0HoR3xGRlSs67Fps=;
        b=YXn81mHbG8xm3NTs9AYPyPRj1ew4NX+TAeYudXTmcMoYjS8v3ilqkOEaW2ZudxtAkf
         7Rm/34/MOhb4m1mWFeX1ijinGozag51xfloGfyD6oyyq0d0OoroQVAGKTgryBSouOKq3
         /QJk5tb6peghBnxESaMWagIj+UWvHoh3wgxdRD2tE5Ji0eehu69uW7oGsEfPJHuyDJOd
         okrTxt8qypBAQNkZ0Sy7nYYXJWEXle/fBqysIQNlODa0r9RyvrOAUWn36Eko5RTNrE8d
         HPs+abmE2pKf0lGi5fWH2rN9sXcSBBX76zsZNYx6t5qQqmojSmSdJo6zHSIp+7xFdCKM
         2/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i39DpSGkp8A10ysnMtqm1kXI7Ca0HoR3xGRlSs67Fps=;
        b=eF+YZ7f2s8HknqvXY5vppH41DLKkXXDTvpF9ci4RVk7F2Olewqrmm8ATkPuDN0nuNc
         oHY8AFOGqakisCNLOHp8NtUnCVrUO7KqxrzQdi3L+oV56DQg/Awd6+YWJpYXGrRPjGaQ
         sBKdIRmlNPWYi/V2iGOndNaUNMMJpowHs3KYvtgjAzKYsBibFwMxvqp/qj2YflMuLcOB
         pVVfjshpJRsxxPfyVp/U9J5VXzTitdqPKoy5Zp+AVOC3DknldtATxDRx8Ov9O0VhPJAA
         gVO/geelJSxOkIJkphJTyORqQfkeGfA4sLpnOxptTasvGNPXeJEXjUtDfC/9UAVqViQh
         7YvA==
X-Gm-Message-State: ACrzQf2qIfp3sDzxRIWFVi5yjt73cFLr7JfMcQOlh6RP1Ly3loa+xcWk
        LJuwmkxbyAINXhf7A+ykImhWQA==
X-Google-Smtp-Source: AMsMyM7nPsJ/hGKbjnknq8Z3lBs2WUWdwKBt5mW827Ilx/KIiaVgnOCY9zxfPvvaGzpHRx5M+QDNOQ==
X-Received: by 2002:a17:90b:1e0b:b0:20d:85ca:b50e with SMTP id pg11-20020a17090b1e0b00b0020d85cab50emr12120186pjb.82.1665682485835;
        Thu, 13 Oct 2022 10:34:45 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e2-20020a17090ab38200b0020aaa678098sm44499pjr.49.2022.10.13.10.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 10:34:44 -0700 (PDT)
Date:   Thu, 13 Oct 2022 11:34:42 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Cc:     linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_clew@quicinc.com
Subject: Re: [PATCH v4] remoteproc: core: do pm relax when in RPROC_OFFLINE
Message-ID: <20221013173442.GA1279972@p14s>
References: <128dc161-8949-1146-bf8b-310aa33c06a8@quicinc.com>
 <1663312351-28476-1-git-send-email-quic_aiquny@quicinc.com>
 <20221012204344.GA1178915@p14s>
 <792f05fc-995e-9a87-ab7d-bee03f15bc79@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <792f05fc-995e-9a87-ab7d-bee03f15bc79@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 09:40:09AM +0800, Aiqun(Maria) Yu wrote:
> Hi Mathieu,
> 
> On 10/13/2022 4:43 AM, Mathieu Poirier wrote:
> > Please add what has changed from one version to another, either in a cover
> > letter or after the "Signed-off-by".  There are many examples on how to do that
> > on the mailing list.
> > 
> Thx for the information, will take a note and benefit for next time.
> 
> > On Fri, Sep 16, 2022 at 03:12:31PM +0800, Maria Yu wrote:
> > > RPROC_OFFLINE state indicate there is no recovery process
> > > is in progress and no chance to do the pm_relax.
> > > Because when recovering from crash, rproc->lock is held and
> > > state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
> > > and then unlock rproc->lock.
> > 
> > You are correct - because the lock is held rproc->state should be set to RPROC_RUNNING
> > when rproc_trigger_recovery() returns.  If that is not the case then something
> > went wrong.
> > 
> > Function rproc_stop() sets rproc->state to RPROC_OFFLINE just before returning,
> > so we know the remote processor was stopped.  Therefore if rproc->state is set
> > to RPROC_OFFLINE something went wrong in either request_firmware() or
> > rproc_start().  Either way the remote processor is offline and the system probably
> > in an unknown/unstable.  As such I don't see how calling pm_relax() can help
> > things along.
> > 
> PROC_OFFLINE is possible that rproc_shutdown is triggered and successfully
> finished.
> Even if it is multi crash rproc_crash_handler_work contention issue, and
> last rproc_trigger_recovery bailed out with only
> rproc->state==RPROC_OFFLINE, it is still worth to do pm_relax in pair.
> Since the subsystem may still can be recovered with customer's next trigger
> of rproc_start, and we can make each error out path clean with pm resources.
> 
> > I suggest spending time understanding what leads to the failure when recovering
> > from a crash and address that problem(s).
> > 
> In current case, the customer's information is that the issue happened when
> rproc_shutdown is triggered at similar time. So not an issue from error out
> of rproc_trigger_recovery.

That is a very important element to consider and should have been mentioned from
the beginning.  What I see happening is the following:

rproc_report_crash()
        pm_stay_awake()
        queue_work() // current thread is suspended

rproc_shutdown()
        rproc_stop()
                rproc->state = RPROC_OFFLINE;

rproc_crash_handler_work()
        if (rproc->state == RPROC_OFFLINE)
                return // pm_relax() is not called

The right way to fix this is to add a pm_relax() in rproc_shutdown() and
rproc_detach(), along with a very descriptive comment as to why it is needed.


> > Thanks,
> > Mathieu
> > 
> > 
> > > When the state is in RPROC_OFFLINE it means separate request
> > > of rproc_stop was done and no need to hold the wakeup source
> > > in crash handler to recover any more.
> > > 
> > > Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> > > ---
> > >   drivers/remoteproc/remoteproc_core.c | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > index e5279ed9a8d7..6bc7b8b7d01e 100644
> > > --- a/drivers/remoteproc/remoteproc_core.c
> > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > @@ -1956,6 +1956,17 @@ static void rproc_crash_handler_work(struct work_struct *work)
> > >   	if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE) {
> > >   		/* handle only the first crash detected */
> > >   		mutex_unlock(&rproc->lock);
> > > +		/*
> > > +		 * RPROC_OFFLINE state indicate there is no recovery process
> > > +		 * is in progress and no chance to have pm_relax in place.
> > > +		 * Because when recovering from crash, rproc->lock is held and
> > > +		 * state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
> > > +		 * and then unlock rproc->lock.
> > > +		 * RPROC_OFFLINE is only an intermediate state in recovery
> > > +		 * process.
> > > +		 */
> > > +		if (rproc->state == RPROC_OFFLINE)
> > > +			pm_relax(rproc->dev.parent);
> > >   		return;
> > >   	}
> > > -- 
> > > 2.7.4
> > > 
> 
> 
> -- 
> Thx and BRs,
> Aiqun(Maria) Yu
