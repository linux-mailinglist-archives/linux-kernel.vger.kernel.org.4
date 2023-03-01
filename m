Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A15B6A6D08
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCANaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCANaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:30:12 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF8514EBC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 05:30:11 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id u20so7890973pfm.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 05:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBZb9eF0SdnxfyqvLOV1YxJXos0+fQsdrq2uis2Kn2s=;
        b=ESLM9pVcbCtAB17hY6wDpmZiYnWQOVl0P+fBOZsidw+gjzHJdipjSlix1NqfczGkS/
         i1S7PZ2KfG8tGFf5n2G6pIYpPlKFYCstUrAVYze7FQTnO8WtGU5pRmFZl9niYit/XaDK
         6fIREEjm7KBTU6gCV07sPTMGWYPrF2WeomNx514M++L3zJIT5xBgTNm/PxVY06ecrBv8
         1QYOtJQrwFS6U1Krytsf8blj1wrMGTzRMtYs13jhfYoaG4eEonvhGVK8vxCJSpWMsguc
         puYNx0N988xHZooCX7uaty7tRjOb7XbB1LL721dNcJNbRanTwhzqEk/uNIedBLsrR5Sc
         kBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBZb9eF0SdnxfyqvLOV1YxJXos0+fQsdrq2uis2Kn2s=;
        b=7CiWIoNQlxup3zgLCmvjsLeRE/4k1eDvRPWfQXPk2P2tvycjmXdSgfcj4bBQVanJ9V
         2DaRYlVgKrtzqJIKB5Qu7S45UyspfFk24FPYELYKcbVkJCDjTEAGm2QM5o3wXl/zIOpf
         EesLZKBc/mY3bW07CgA1pEAh3z+9jTxRSt6NOA6zk6wvHYqnoldLK3d4On7hnUmltxUe
         lktPo2kS5mYxruoXAjd0Pwnop7AIQ+RMkLptp4UnJ0cc3eHo/r5y9EtJTUQuFTfmpK+q
         YUsmgtIz+Dk3wdS7iARk+ptBbWsr7oM9KrhRnsNUP5GUnLgRYloB0VYJwFHfTHW3aGy9
         MweQ==
X-Gm-Message-State: AO0yUKUaD3ywAix/LplDLKCZxUf+MTMnOt9ia7fY2p88ZpZ3EfDmIxbe
        nEz2O5eMXHeJ4AeCyZAxMrAyA5/zrAB5ivDgjkd2rw==
X-Google-Smtp-Source: AK7set9YJBGCaTFkinZbdjLPo5ygtaraFsyfjeiMaTA4nyQ0QhmjFrjrvPTOW+iQqIxGqtyvOMnTyz2KsAyg7ohr1x0=
X-Received: by 2002:a63:3508:0:b0:4fc:2058:fa2b with SMTP id
 c8-20020a633508000000b004fc2058fa2bmr2153689pga.3.1677677410528; Wed, 01 Mar
 2023 05:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20230222080314.2146-1-xuewen.yan@unisoc.com> <Y/zO8WZV2kvcU78b@hirez.programming.kicks-ass.net>
 <20230227220735.3kaytmtt53uoegq7@airbuntu> <CAB8ipk--trBk-Acsjz7YDb5szPLc93ejPXVXQBJdomZO4OrpGQ@mail.gmail.com>
 <CAKfTPtBdMO6_APib1OBxW+fdAORX8vXdT-W3fWTRffa5-8bGxQ@mail.gmail.com>
 <CAB8ipk96OXJcmp_H5EcagrMUigSFdW_gd4wwGjfjBpyP6hqaTg@mail.gmail.com>
 <CAKfTPtAvuz0SEDX3izcOhZkC+pFddqrSwY+iYO2p7U6N3Z2hRA@mail.gmail.com>
 <20230228133111.6i5tlhvthnfljvmf@airbuntu> <CAKfTPtAsxz7s6W2peoVj+EcNVQp6bpO6qhPPTXgfJxVtXHbaKQ@mail.gmail.com>
 <CAB8ipk83Ofywn0T19dHxjJNXfKcd9DD_EopQupeepjSk-XceRQ@mail.gmail.com>
 <CAKfTPtDfSHnd7=ZG2S-x46kxw0Cc0RSXq+_B8Oe46fa3Fa75BA@mail.gmail.com>
 <CAB8ipk9uPMxwEUHkLWbKXQEO1UkwBPWbZb=NF7AE5JHnG8V6Dw@mail.gmail.com> <43e91964-cd34-2e84-03a3-3903aa94c5e6@arm.com>
In-Reply-To: <43e91964-cd34-2e84-03a3-3903aa94c5e6@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 1 Mar 2023 14:29:59 +0100
Message-ID: <CAKfTPtBMPV_cLck8yTW1hLEKXX6_FFgbq76UK1w4cxtvoUF+Bg@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: update the vruntime to be max vruntime
 when yield
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Xuewen Yan <xuewen.yan94@gmail.com>,
        Qais Yousef <qyousef@layalina.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        zhaoyang.huang@unisoc.com
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

On Wed, 1 Mar 2023 at 12:23, Dietmar Eggemann <dietmar.eggemann@arm.com> wr=
ote:
>
> Hi Xuewen,
>
> On 01/03/2023 09:20, Xuewen Yan wrote:
> > On Wed, Mar 1, 2023 at 4:09=E2=80=AFPM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> >>
> >> On Wed, 1 Mar 2023 at 08:30, Xuewen Yan <xuewen.yan94@gmail.com> wrote=
:
> >>>
> >>> Hi Vincent
> >>>
> >>> I noticed the following patch:
> >>> https://lore.kernel.org/lkml/20230209193107.1432770-1-rkagan@amazon.d=
e/
> >>> And I notice the V2 had merged to mainline:
> >>> https://lore.kernel.org/all/20230130122216.3555094-1-rkagan@amazon.de=
/T/#u
> >>>
> >>> The patch fixed the inversing of the vruntime comparison, and I see
> >>> that in my case, there also are some vruntime is inverted.
> >>> Do you think which patch will work for our scenario? I would be very
> >>> grateful if you could give us some advice.
> >>> I would try this patch in our tree.
> >>
> >> By default use the one that is merged; The difference is mainly a
> >> matter of time range. Also be aware that the case of newly migrated
> >> task is not fully covered by both patches.
> >
> > Okay, Thank you very much!
> >
> >>
> >> This patch fixes a problem with long sleeping entity in the presence
> >> of low weight and always running entities. This doesn't seem to be
> >> aligned with the description of your use case
> >
> > Thanks for the clarification! We would try it first to see whether it
> > could resolve our problem.
>
> Can you not run Vincent's rt-app example on your device and then report
> `cat /sys/kernel/debug/sched/debug` of the CPU?
>
> # rt-app /root/rt-app/cfs_yield.json
>
> # cat /sys/kernel/debug/sched/debug
> ...
> cpu#2
>   .nr_running                    : 4
>   ...
>   .curr->pid                     : 2121
>   ...
>
> cfs_rq[2]:/autogroup-15
>   .exec_clock                    : 0.000000
>   .MIN_vruntime                  : 32428.281204
>   .min_vruntime                  : 32428.281204
>   .max_vruntime                  : 32434.997784
>   ...
>   .nr_running                    : 4
>   .h_nr_running                  : 4
>
> ...
>
>  S            task   PID         tree-key  switches  prio     wait-time  =
           sum-exec        sum-sleep
> -------------------------------------------------------------------------=
------------------------------------
>  S         cpuhp/2    22      1304.405864        13   120         0.00000=
0         0.270000         0.000000         0.000000 0 0 /
>  S     migration/2    23         0.000000         8     0         0.00000=
0         7.460940         0.000000         0.000000 0 0 /
>  S     ksoftirqd/2    24    137721.092326        46   120         0.00000=
0         1.821880         0.000000         0.000000 0 0 /
>  I    kworker/2:0H    26      2116.827393         4   100         0.00000=
0         0.057220         0.000000         0.000000 0 0 /
>  I     kworker/2:1    45    204539.183593       322   120         0.00000=
0       447.975440         0.000000         0.000000 0 0 /
>  I     kworker/2:3    80      1778.668364        33   120         0.00000=
0        16.237320         0.000000         0.000000 0 0 /
>  I    kworker/2:1H   239    199388.093936        74   100         0.00000=
0         1.892300         0.000000         0.000000 0 0 /
>  R         taskA-0  2120     32428.281204       582   120         0.00000=
0      1109.911280         0.000000         0.000000 0 0 /autogroup-15
> >R         taskB-1  2121     32430.693304       265   120         0.00000=
0      1103.527660         0.000000         0.000000 0 0 /autogroup-15
>  R         taskB-2  2122     32432.137084       264   120         0.00000=
0      1105.006760         0.000000         0.000000 0 0 /autogroup-15
>  R         taskB-3  2123     32434.997784       282   120         0.00000=
0      1115.965120         0.000000         0.000000 0 0 /autogroup-15
>
> ...
>
> Not sure how Vincent's rt-app file looks like exactly but I crafted
> something quick here:

it was quite similar to yours below. I have just stopped to call yield
after few seconds to see if the behavior changed

>
> {
>         "tasks" : {
>                 "taskA" : {
>                         "cpus" : [2],
>                         "yield" : "taskA",
>                         "run" : 1000
>                 },
>                 "taskB" : {
>                         "instance" : 3,
>                         "cpus" : [2],
>                         "run" : 1000000
>                 }
>         },
>         "global" : {
>                 "calibration" : 156,
>                 "default_policy" : "SCHED_OTHER",
>                 "duration" : 20
>         }
> }
>
> [...]
