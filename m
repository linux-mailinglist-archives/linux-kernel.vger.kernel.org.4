Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D020729D38
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241569AbjFIOrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjFIOq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:46:59 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA592685;
        Fri,  9 Jun 2023 07:46:57 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1a2d06d587eso781536fac.2;
        Fri, 09 Jun 2023 07:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686322016; x=1688914016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdbxKBVcBVIgPeSRn3sb4Td/Dc7pVhPTKzbSHfxRLUA=;
        b=DNZbTLKQPliTfstgbHegNTkVrvFD9wIBWPaL0NFQ1I88MwmBHg+WCO8HWfwtfhFxyL
         qEk9VSMgQ9RCxCAGS83dDGAZiL/6nIGajfqph3NEHHw19OXDeTiSGCrss3O+kph8FksO
         fTgGXiJczEcbuxO0RZ6qBbRq48gTUE9+lau9EdAjDv3V5K0UJ5HHmMCx1jQfGVcMB8L5
         zmbiA+p1jw8kUuAONkOiEzq1acvq1zXWawi4lnVpEw5rfOYYfqlzCTJAysfhnE1gQr1I
         5pWoUZ0a8zXSRpgiRvydhFnUrGeKL464wjAC6XibCEi0I/d816J/dTFSWrjoMG/0nYF2
         9HMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322016; x=1688914016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdbxKBVcBVIgPeSRn3sb4Td/Dc7pVhPTKzbSHfxRLUA=;
        b=ApnyBg71rHtOnqfx8hHip6NF/qVnAOI+8KgeAe3whZFu+bZc0AU8pgBqPGq9pcys0i
         B384hE5KadSC3DyyX1Ez3aeh+FdvgYi/R0Bmy0qJs+dfWVxVrmtvPVon90k+R3FvJsr7
         tV2gyN0f4qUQLini7D3nloYHtyeg4yj6Qz6yO5Xdo5o5fFsJe+mQmMXCn63SI2eeW0Tm
         I9kbR9L4YMrRV4FnlEaDV4kRHfDM4/avzC31euBqQmt5xN4tVI1cyMOTGpLQ0BhfLH5p
         tfcFEYOvBuq5K/UA8O1NPyMCiD+Gqiehr5uZXk7AGYLYwg2qr4GB0TqNKudsByiAVd3j
         p/Uw==
X-Gm-Message-State: AC+VfDwxIfsDqC1I8n3sOu7DhFDoeEJ0G8Ube6dwxKrCS4LYL4xCSHLU
        LNyRVHJQ7utJT0kKVCSq2qyGJ9P/KvENeHGfnsu+B4Ejy4Q=
X-Google-Smtp-Source: ACHHUZ7J0l5veq+z1PgJ9eZh7SJrvdCaZgEm8srFRcMOKIil0mLDwk3fE22sVm0Zt9XOct9JtmMlMOwq65yRGatpAtk=
X-Received: by 2002:a05:6870:42c6:b0:19e:e96a:4cb9 with SMTP id
 z6-20020a05687042c600b0019ee96a4cb9mr1272834oah.23.1686322015525; Fri, 09 Jun
 2023 07:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <ZBGNmXwQoW330Wr8@hovoldconsulting.com> <ZIHh95IeOPBTvB00@hovoldconsulting.com>
 <CAF6AEGv3y3C6nAq7nrkgbv5-9-tVgj+BtY1yU+fXXFFm_N7fcQ@mail.gmail.com> <ZILEBPQgqr1HomUQ@hovoldconsulting.com>
In-Reply-To: <ZILEBPQgqr1HomUQ@hovoldconsulting.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 9 Jun 2023 07:46:44 -0700
Message-ID: <CAF6AEGsHFpGEiOLxEqzxG2VU+i+h0uVQTHcpfD4sbk0GWN2+Vg@mail.gmail.com>
Subject: Re: Adreno devfreq lockdep splat with 6.3-rc2
To:     Johan Hovold <johan@kernel.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 11:17=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Thu, Jun 08, 2023 at 02:17:45PM -0700, Rob Clark wrote:
> > On Thu, Jun 8, 2023 at 7:12=E2=80=AFAM Johan Hovold <johan@kernel.org> =
wrote:
>
> > > Have you had a chance to look at this regression yet? It prevents us
> > > from using lockdep on the X13s as it is disabled as soon as we start
> > > the GPU.
> >
> > Hmm, curious what is different between x13s and sc7180/sc7280 things?
>
> It seems like lockdep needs to hit the tear down path in order to
> detect the circular lock dependency. Perhaps you don't hit that on your
> sc7180/sc7280?
>
> It is due to the fact that the panel is looked up way too late so that
> bind fails unless the panel driver is already loaded when the msm drm
> driver probes.

Oh, this seems likely

> Manually loading the panel driver before msm makes the splat go away.
>
> > Or did lockdep recently get more clever (or more annotation)?
>
> I think this is indeed a new problem related to some of the devfreq work
> you did in 6.3-rc1 (e.g. fadcc3ab1302 ("drm/msm/gpu: Bypass PM QoS
> constraint for idle clamp")).
>
> > I did spend some time a while back trying to bring some sense to
> > devfreq/pm-qos/icc locking:
> > https://patchwork.freedesktop.org/series/115028/
> >
> > but haven't had time to revisit that for a while
>
> That's the series I link to below, but IIRC it did not look directly
> applicable to the splat I see on X13s (e.g. does not involve
> fs_reclaim).

Ahh, right, sorry I've not had time to do more than glance at the
thread.. and yeah, that one is mostly just trying to solve the reclaim
problem by moving allocations out from under the big-pm-qos-lock.

As far as fadcc3ab1302 ("drm/msm/gpu: Bypass PM QoS constraint for
idle clamp"), it should be just taking the lock that
dev_pm_qos_update_request() would have indirectly, although I guess
without some intervening lock?  We can't really avoid taking the
devfreq lock, I don't think.  But I'd have to spend time I don't have
right now digging into it..

BR,
-R

> > > On Wed, Mar 15, 2023 at 10:19:21AM +0100, Johan Hovold wrote:
> > > >
> > > > Since 6.3-rc2 (or possibly -rc1), I'm now seeing the below
> > > > devfreq-related lockdep splat.
> > > >
> > > > I noticed that you posted a fix for something similar here:
> > > >
> > > >       https://lore.kernel.org/r/20230312204150.1353517-9-robdclark@=
gmail.com
> > > >
> > > > but that particular patch makes no difference.
> > > >
> > > > From skimming the calltraces below and qos/devfreq related changes =
in
> > > > 6.3-rc1 it seems like this could be related to:
> > > >
> > > >       fadcc3ab1302 ("drm/msm/gpu: Bypass PM QoS constraint for idle=
 clamp")
>
> Johan
