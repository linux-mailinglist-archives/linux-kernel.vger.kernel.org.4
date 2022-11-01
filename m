Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6506F61562D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiKAXj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKAXjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:39:52 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DDA1AD8C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 16:39:51 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id k19so22763271lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 16:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XVE8df/LmNSzpfTgJgBEeCPlA2Al+KApjI2VylZLJqw=;
        b=NYNZLq/lb7zvRGRcy311Vi/70AhjYWjIUDwfmocLlD/OX6i1vJfPsL30HUVv77KioE
         ziVq6V2dJT5uaX0Qj8OH+j4Q68D3a4Z7ezEhrxgCikcwAdT73BbDUpZz0Xx4tVa2QTsU
         QQ3beVk+rAoYmyTZNG/Ca4ihfmtU6d4x1uQumv5vl9ktNCqKuLvopmO6CoV9VTolLsWL
         gT5f25lBD0hQtzVv8s7zIMiRV7eCFWrL3Wc3YWDpGmT70rz8qnHYkjDc9ZgIRUCJOUdM
         JNg+OVDNnF5X+fcgQJvuHonHZW8Wmt0UYc8RTXOcpO8jE91WrC0GKnh+KGuCUsFzQh0E
         h39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVE8df/LmNSzpfTgJgBEeCPlA2Al+KApjI2VylZLJqw=;
        b=wCRMwh1iutaewN3kTP86RbRAivKpoqyFKPL9sgVREwGUtO9gMnxMj3Yb/w8q6Q9dSM
         DuwpKT0YyM4OxMZl99nGhwhXz+02LMU86hnuy7V9TUMRURKiClkM5HpmigdGccVnVr8L
         FbrocDxTU7+b4O8RgWOPYn+Fy7sCbhh0c8oPb5Bz4Znd0QfioEA2YUxxQbhjMgwcAeJH
         saV8HeQPSR5FKQ9Se4hduAC/33+mjo94YEUYD9J78jGnjsn5iMmQi/eg4TM+r0nsxg39
         GnYarscy/XA2omk0OtG63/vd7ZhHMHjXs5Yxew+wv2CtTWiCn1TDLRTHRHtWjlpkga+y
         Cafw==
X-Gm-Message-State: ACrzQf3Cf26Sn/1J7HegJ/c7w4i0Ax5FEyLLLkICQUqBu6iWJy6JhGqg
        WRWcF5ou8avOQOLmrQxfXAUZdBv4j/+QWy27oBeVhw==
X-Google-Smtp-Source: AMsMyM7GlNQ9oNlElESY6O5G6stvzHa27GzQi/JydzRL7UIZIcoLTCA3OrTJITVZQCx+644XFDOBzfzn4XI93EfM4To=
X-Received: by 2002:a2e:3e14:0:b0:277:a3b:49dd with SMTP id
 l20-20020a2e3e14000000b002770a3b49ddmr7454438lja.342.1667345989783; Tue, 01
 Nov 2022 16:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221027081630.34081-1-zhouchuyi@bytedance.com>
 <CABk29NtDny9qKZbZZ_i8Brwjtqs5GA0G4_SffzK4HzG3RrXVhQ@mail.gmail.com>
 <64d963b6-2d9c-3f93-d427-a1ff705fb65a@bytedance.com> <CABk29NsbGuMPcA8NJagMfPyHij3864F3DVQ6wpCj3UAo8tbFNQ@mail.gmail.com>
 <5af26ac9-3bdb-32d2-77a7-6cd8feca97aa@bytedance.com> <CABk29Nt38d31LnazbcSVB036jUYemC1KRpR2Dn7YgLmXkp-QBQ@mail.gmail.com>
 <8142b5db-f543-57e6-0f68-f62274c0e379@bytedance.com>
In-Reply-To: <8142b5db-f543-57e6-0f68-f62274c0e379@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 1 Nov 2022 16:39:37 -0700
Message-ID: <CABk29Nsnx=PfeLMEsD0qsnh5-QTHLT4xVB3HmBgGAqqmWnkmvg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: favor non-idle group in tick preemption
To:     Chuyi Zhou <zhouchuyi@bytedance.com>
Cc:     peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
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

> > Some weirdness about this change though, is that if there is a
> > non-idle current entity, and the two next entities on the cfs_rq are
> > idle and non-idle respectively, we'll now take longer to preempt the
> > on-cpu non-idle entity, because the non-idle entity on the cfs_rq is
> > 'hidden' by the idle 'first' entity. Wakeup preemption is different
> > because we're always directly comparing the current entity with the
> > newly woken entity.
> >
> You are right, this can happen with high probability.
> This patch just compared the curr with the first entity in
> the tick, and it seems hard to consider all the other entity
> in cfs_rq.
>
> So, what specific negative effects this situation would cause?
> For example, the "hidden" non-idle entity's latency will be worse
> than before?

As Abel points out in his email, it can push out the time it'll take
to switch to the other non-idle entity. The change might boost some
benchmarks numbers, but I don't think it is conclusive enough to say
it is a generically beneficial improvement that should be integrated.

By the way, I'm curious if you modified any of the sched_idle_cpu()
and related load balancing around idle entities given that you've made
it so that idle entities can have arbitrary weight (since, as I
described in my prior email, this can otherwise cause issues there).
