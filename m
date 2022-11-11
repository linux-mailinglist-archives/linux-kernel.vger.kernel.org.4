Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB016261C6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 20:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiKKTPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 14:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiKKTPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 14:15:09 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF85476F8E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 11:15:08 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id r12so9685653lfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 11:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UOdAKhHafAc6H/C5u0Vtx45EoJ/F5U2sFzByQ8Q0zC4=;
        b=CzBbfewUK5QODTB3SSXYBjRqHlYGlRuzG4xNGa+1E7DxBQFt3Qz6LBDMtMtT4D7aAv
         cKS7zjVYwEE74p0c/QWfZU6hu1C4TOBHh4/xgUZ2Y/tMfuPTb/JBUSe0ri+q+jNO9Ttw
         tqVdVxuIWnx/bgQ+cl1nuDI/zwV5WZxPRjCgovjlLxe6IOEOoTsJADxZKYS19KNX82bp
         LVql6MiYKOLUMdMf17b4kyVDWPae7yWNopBfSzulI4mBtTdBZHSHm5JVxAqmV8TSGcZd
         uqQ23W9JTKRxd3p9oFEEgi1elMYIrNzXJDZsYwWZv2V6Ll2VoA/qHsB+yjE6iB5chY79
         gVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UOdAKhHafAc6H/C5u0Vtx45EoJ/F5U2sFzByQ8Q0zC4=;
        b=JLxoIfBNYs4PTqf6LcA2+BO75oqHsjnweqnzqk0OFu2gVO2h8Cl0sRj/PTBsicczW2
         Uj4FX1sbdr473T4YltSEnv3Ol1wX5+9Uw2zBPmFXYmQQ8LhWadPl4jD0/GM9qqn6Ljns
         48EZ6bHDqzHzrUG60l+DfEu2yNiEqRaRXvowyx7v4oGIKOX3KnnoH2BeeQuRnQSRLWc0
         /jsDL/8Kz0OjD5GSLO7cR5bskrbhOfFqj6LcJhEAMCruJbSV0lLdU/TXdHAO16rUQVDZ
         fF1Pydf1FCUFyfyml6D6S0XQV5t+GhiWSoZHA54GO8VK8/4W3s5yO0tLaYMec/UtkmBs
         iQ8Q==
X-Gm-Message-State: ANoB5pndEpXTGscK27nRJPoS03LxLxTrmJSNep0Q8IfLjupf6aZBCRFn
        IrJ9QThLpdmc/DuVp8kq1f054SZyDTU6o5dQJpZN0w==
X-Google-Smtp-Source: AA0mqf51QCbfFL7l9lOfyp7uqTrjLiBwHJjsa9+RKJXfmiaexTrhvCMyt6/xE+u4Y+ZiV/qaOkhCRn9zRAz62TCJAso=
X-Received: by 2002:a19:e601:0:b0:4a8:e955:77e7 with SMTP id
 d1-20020a19e601000000b004a8e95577e7mr1151954lfh.573.1668194106768; Fri, 11
 Nov 2022 11:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20221027081630.34081-1-zhouchuyi@bytedance.com>
 <CABk29NtDny9qKZbZZ_i8Brwjtqs5GA0G4_SffzK4HzG3RrXVhQ@mail.gmail.com>
 <64d963b6-2d9c-3f93-d427-a1ff705fb65a@bytedance.com> <CABk29NsbGuMPcA8NJagMfPyHij3864F3DVQ6wpCj3UAo8tbFNQ@mail.gmail.com>
 <5af26ac9-3bdb-32d2-77a7-6cd8feca97aa@bytedance.com> <CABk29Nt38d31LnazbcSVB036jUYemC1KRpR2Dn7YgLmXkp-QBQ@mail.gmail.com>
 <8142b5db-f543-57e6-0f68-f62274c0e379@bytedance.com> <CABk29Nsnx=PfeLMEsD0qsnh5-QTHLT4xVB3HmBgGAqqmWnkmvg@mail.gmail.com>
 <0796b344-4c4d-5163-d3f2-c6bbf875b129@bytedance.com>
In-Reply-To: <0796b344-4c4d-5163-d3f2-c6bbf875b129@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 11 Nov 2022 11:14:54 -0800
Message-ID: <CABk29NtwCi0Jwti2XR=J4gPcnN-udV2aP_A9i4bbWmYHfwrHjA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: favor non-idle group in tick preemption
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Chuyi Zhou <zhouchuyi@bytedance.com>, peterz@infradead.org,
        juri.lelli@redhat.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 7:50 PM Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> > By the way, I'm curious if you modified any of the sched_idle_cpu()
> > and related load balancing around idle entities given that you've made
> > it so that idle entities can have arbitrary weight (since, as I
> > described in my prior email, this can otherwise cause issues there).
>
> Being able to change idle entities' weight can bring nothing but
> convenience, because it can also be achieved by modifying all their
> siblings' weight. Which seems not a strong reason to get merged.
>
> And I'm also thinking that, although rare, a non-idle group can also
> have a weight close or even equal to 3. I guess some users who made
> this kind of setting might only want to benefit from the preemption
> at wakeup? Nevertheless this setting is supported now :)

Strongly disagree with this; part of the semantics for idle relies on
the minimum weight value. It is true that this behavior gets a little
weirder if siblings also have close to min weight, but this is an
artifact of the fact that SCHED_IDLE is built into CFS rather than
being a separate scheduling class. The minimum weight in general is
assumed by load balance, etc. for the purpose of placing non-idle
entities.

For consistency with the per-task SCHED_IDLE behavior, which
effectively makes idle tasks have the max nice value, we also need to
match the cgroup idle behavior.

I think the use case you're describing would honestly be better served
by extending SCHED_BATCH with the preemption properties and using
that, rather than try to overload SCHED_IDLE here. There's a
difference between non-interactive entities that are ok getting
aggressively preempted, vs "idle" entities that should really only be
soaking the remaining cycles on the machine.

Best,
Josh
