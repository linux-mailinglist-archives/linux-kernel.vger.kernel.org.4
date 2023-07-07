Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D33F74A8FC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 04:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjGGC1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 22:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjGGC1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:27:33 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F54F1997
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 19:27:32 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-579de633419so18264077b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 19:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688696851; x=1691288851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWl3GhDMdxfNKqj8LcWp9eBQx6bvP6uUrrwF+noDj3k=;
        b=hSVymDbDY9U5fRX5KdhTaUEhOHxUVgHx9S+Ae0dJIaIQE9FXVr0gCV/K6nNsgiLGFw
         HnPiHh4yqTpt3oWHiqieETmMM4nmK2prRGiwYTb8Ut2KmJzQY5TPQFifxarXVdY/2lPI
         ftxKov5qeMwetNHzGCfw1RlRmCeyNFKxPMr+EyYsrKD308jzV1D5Lx5at7KEkfTVo37S
         UAun91Tn2T1+aRzB2P0HIJxAXiytL5P1janHzfB1R+UoDSFsu669IJWszcuuhERvrh8D
         f5pdC45doWCvGU7Bz/UqLvmKMpO1SsKCxgxprxc32ErYrzaaqTylWoAycJwurNzjtSLv
         H0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688696851; x=1691288851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWl3GhDMdxfNKqj8LcWp9eBQx6bvP6uUrrwF+noDj3k=;
        b=Nmxzyg1HkzjXEo1IIutD95EnQxK88Vq1jhHlXgVUU582qBwo/keETMcnwz/JCtTHnx
         2FFvki6PKivxNCWZ4/BuyL03ztw1iILAs2Fr9hKVXRBXqtQmOiCL8lsqE9Q8zzEW4zpN
         0z8Uim2hwVIcK8TfZm6E5zqerSjBjywGcKl2dDJLQNY4O56tTBBCjr9yOLkaJmId6Q5K
         4uEY5Etz3rOpLWtEjZbspR+78z4ObatUrEclFbILu+ZO4SsuL/d4LIRHNwYidzTxc8pm
         10LDXHGMB0ie+ZcoHgW8H+q05Xj8v8kheTkv3GxMv7flq2jtuV9wpHzECuta4a7ZIjVq
         Xf+A==
X-Gm-Message-State: ABy/qLbg0YZqwMfocHaB+sNLhfBKmddtXrgE4joJiSnVsJPLI2Y2vZwp
        WTlGrVPsEiT2U8pwliDSOHrpZXlbgm2sEMWejMI=
X-Google-Smtp-Source: APBJJlGRaGYs+Qg01P15pbtVk0CpVTDTr1qxzFNZQlfsutXYYrb+QM38ct6lxrAlReP6H9IOD3I0StIqh5x4902t1DE=
X-Received: by 2002:a0d:cd46:0:b0:564:e951:a7cc with SMTP id
 p67-20020a0dcd46000000b00564e951a7ccmr3519250ywd.45.1688696851135; Thu, 06
 Jul 2023 19:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAG-UpRQsdL_Fs9HSEv2pDYXehJC+YXcYjiZKFLvkGBTZkkaTcg@mail.gmail.com>
 <20230706120103.GJ2833176@hirez.programming.kicks-ass.net> <20230706195824.GA2862508@hirez.programming.kicks-ass.net>
In-Reply-To: <20230706195824.GA2862508@hirez.programming.kicks-ass.net>
From:   Henry Wu <triangletrap12@gmail.com>
Date:   Fri, 7 Jul 2023 10:27:20 +0800
Message-ID: <CAG-UpRTJrs70+Wgi1MHzpDKvKq=kA-t74a7e-nVNScDAwKMNBA@mail.gmail.com>
Subject: Re: Possible race in rt_mutex_adjust_prio_chain
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter.

Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2023=E5=B9=B47=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=BA=94 03:58=E5=86=99=E9=81=93=EF=BC=9A
>
> Current notes...
>
> We hold [L] from 5-13; we hold [P1] 1-8 and [P2] 10-13
>
>   P1 - blocked task
>   P2 - lock owner
>
>   7  holds [L]+[P1]
>      modifies the values, which, temporarily, messes up the pi_waiters tr=
ee
>
>   11 holds [L]+[P2]
>      requeues the waiter on pi_waiter, restoring pi_waiters tree
>
> pi_waiters is modified by:
>
>   - rt_mutex_{en,de}queue_pi(); which are used:
>
>    - [11] (holds [L]+[P2])
>    - try_to_wake_rt_mutex() [L]+[P3] ?!? (P3 will be owner,
>                                           but is not yet)
>    - task_blocks_on_rt_mutex() [L]+[P2]
>    - mark_wakeup_next_waiter() [L]+[P2] (current is owner,
>                                          gives up lock)
>    - remove_waiter() [L]+[P2]
>
> pi_waiters is used by:
>
>   - task_top_pi_waiter(), asserts [P], this is used:
>
>     - rt_mutex_adjust_prio(), which asserts [P2] (*), is used:
>
>       - [11] (holds [L])
>       - task_blocks_on_rt_mutex() (holds [L])
>       - mark_wakeup_next_waiter() (holds [L])
>       - remove_waiter() (holds [L])
>
>       (*)(see patch below -- adding more assertions)
>
>     - [3] -- does *NOT* hold [L], does hold [P]
>
>
> Now, [3] doesn't hold [L], but since 'all' modifications are done under
> [L]+[P], just holding [P] should provide a stable read. Except [7], that
> messes up the tree while not holding (the right!) [P].
>
> It's late, I'll have to continue staring at this tomorrow!
>

Your analysis is correct! I try to quote part of my previous reply
with correct format:

CPU0                              CPU1
.........                         ..........
                                  rt_mutex_adjust_prio_chain(C)
rt_mutex_adjust_prio_chain(B)
......
[7] update waiter->prio
(Now A's pi_waiters rbtree is
 corrupted temporarily)
......                            [11] enqueue operation may select
                                  insert position according to corrupted
                                  waiter node CPU0 created.
[11] Even though we fixed
corrupted waiter now, we
are not sure about pi_waiters's
sanity because other cpu may
create new invariant violation
based on our violation.
