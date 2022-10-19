Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232EE6048D8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiJSOLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJSOLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:11:09 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75E319DDBB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:52:54 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id p16so14478279iod.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRKwNz88o4gj17VAi9OZQ8T/l8HaVBhEjUDiBHaMoMs=;
        b=dBAF6WoqBmCqBBYsdLshsaD3yOQN2dbPfkWgywOqejojsaydEifEbTR/Q/DDDNEYAW
         ukRlPtUHwZggrJdxjb4a3fR+a1r5kmldo99WEY6HwmQuafwSjj0LgtBHGhmftKZY7pvQ
         SB+SlW5tJXrWW0tmiyet7d0Y42GypALv4NP6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRKwNz88o4gj17VAi9OZQ8T/l8HaVBhEjUDiBHaMoMs=;
        b=2XFUhwZKR/y8PBtgFA20KX0in81gZTU0u85AhcG9UHjyVtUbvSzpgkL/51Y9yHcOJn
         8avKMHM8LLYiOCgZZfjsSdSh6zbNSReOST6pBiigUcRPgaX3VVdth2VAQDEovzMkVpSq
         KClhNYLjW6juRui1/lHM2yQFiAYLjWk6IOkSVqHxZG86our10R755HABIFvnNOyowe4J
         kZTM5xTuTUyaqAPE1K+Ej+P0ezZY0lOJaI/Ji3kRmeJw4RUe2h2THrfyQ/TrEVJSYTh9
         1/2Ip238EDk0Wisk0g9Of9JG6s9C7HFSpjeRxp9mu6kzwEuQNtZmxMGhVFM98G8XsNxQ
         oNMw==
X-Gm-Message-State: ACrzQf20Fnt/0dGWDZ31G4gUTtDct4kGvSleEh/GPTOU3WN8HzAaq0n+
        U5qEjKcFEsW+Di+4WldDSou3NfB0jCyX4SOesjtcNQ==
X-Google-Smtp-Source: AMsMyM7xo57sjg5CZYmJqt3nYLfznwmRrtPL6O20vHTB5kTxwlkEwufQtVzq7zAT4M7wnPlZSVV6wFh+LP9ZJKc8rnY=
X-Received: by 2002:a05:6638:2393:b0:363:6c5d:9584 with SMTP id
 q19-20020a056638239300b003636c5d9584mr6333427jat.232.1666187494375; Wed, 19
 Oct 2022 06:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221019114357.yipijpetxz7ns5aq@airbuntu> <F9BCD313-15BA-429C-B50C-1391DDC1239B@joelfernandes.org>
 <Y0/+ieCymugrjheC@localhost.localdomain>
In-Reply-To: <Y0/+ieCymugrjheC@localhost.localdomain>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 19 Oct 2022 09:51:24 -0400
Message-ID: <CAEXW_YRAXUmc0zMTo8OowVk2ZNuYfBsvZDXMkVH35aWkpEUo2A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Reviving the Proxy Execution Series
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        "Connor O'Brien" <connoro@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 9:41 AM Juri Lelli <juri.lelli@redhat.com> wrote:
>
> On 19/10/22 08:23, Joel Fernandes wrote:
> >
> >
> > > On Oct 19, 2022, at 7:43 AM, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > =EF=BB=BFOn 10/17/22 02:23, Joel Fernandes wrote:
> > >
> > >> I ran a test to check CFS time sharing. The accounting on top is con=
fusing,
> > >> but ftrace confirms the proxying happening.
> > >>
> > >> Task A - pid 122
> > >> Task B - pid 123
> > >> Task C - pid 121
> > >> Task D - pid 124
> > >>
> > >> Here D and B just spin all the time. C is lock owner (in-kernel mute=
x) and
> > >> spins all the time, while A blocks on the same in-kernel mutex and r=
emains
> > >> blocked.
> > >>
> > >> Then I did "top -H" while the test was running which gives below out=
put.
> > >> The first column is PID, and the third-last column is CPU percentage=
.
> > >>
> > >> Without PE:
> > >>  121 root      20   0   99496   4   0 R  33.6   0.0   0:02.76 t  (ta=
sk C)
> > >>  123 root      20   0   99496   4   0 R  33.2   0.0   0:02.75 t  (ta=
sk B)
> > >>  124 root      20   0   99496   4   0 R  33.2   0.0   0:02.75 t  (ta=
sk D)
> > >>
> > >> With PE:
> > >>  PID
> > >>  122 root      20   0   99496   4   0 D  25.3   0.0   0:22.21 t  (ta=
sk A)
> > >>  121 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (ta=
sk C)
> > >>  123 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (ta=
sk B)
> > >>  124 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (ta=
sk D)
> > >>
> > >> With PE, I was expecting 2 threads with 25% and 1 thread with 50%. I=
nstead I
> > >> get 4 threads with 25% in the top. Ftrace confirms that the D-state =
task is
> > >> in fact not running and proxying to the owner task so everything see=
ms
> > >> working correctly, but the accounting seems confusing, as in, it is =
confusing
> > >> to see the D-state task task taking 25% CPU when it is obviously "sl=
eeping".
> > >>
> > >> Yeah, yeah, I know D is proxying for C (while being in the uninterru=
ptible
> > >> sleep state), so may be it is OK then, but I did want to bring this =
up :-)
> > >
> > > I seem to remember Valentin raised similar issue about how userspace =
view can
> > > get confusing/misleading:
> > >
> > >    https://www.youtube.com/watch?v=3DUQNOT20aCEg&t=3D3h21m41s
> >
> > Thanks for the pointer! Glad to see the consensus was that this is not
> > acceptable.
> >
> > I think we ought to write a patch to fix the accounting, for this
> > series. I propose adding 2 new entries to proc/pid/stat which I think
> > Juri was also sort of was alluding to:
> >
> > 1. Donated time.
> > 2. Proxied time.
>
> Sounds like a useful addition, at least from a debugging point of view.
>
> > User space can then add or subtract this, to calculate things
> > correctly. Or just display them in new columns. I think it will also
> > actually show how much the proxying is happening for a use case.
>
> Guess we'll however need to be backward compatible with old userspace?
> Probably reporting the owner as running while proxied (as in the
> comparison case vs. rtmutexes Valentin showed).

Hi Juri,
Yes I was thinking of leaving the old metrics alone and just providing
the new ones as additional fields in /proc/pid/stats . Then the tools
adjust as needed with the new information. From kernel PoV we provide
the maximum information.

Thanks,

 - Joel
