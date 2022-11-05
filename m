Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4710261DD1B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 19:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiKESG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 14:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKESGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 14:06:20 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876A812D09
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 11:06:14 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id x21so5146711qkj.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 11:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QVXj0cLL9VUphH0bgK54o5rYv0DrN8lZjO0Vg0C726g=;
        b=BiWqOqpPR07eLTLe6T5V72Y9xGIsPmkwMbeqbdJI+puK8c9LIXxNrw3cBq8D1NOQuQ
         pJAo1Am+vhs2mPh44VnFCaOf/bPGjWGgUGvIUZGM5ZyxOFAC9ctuTinIwdqjqf8e/+Oh
         zszIk7RIyfcGhJ2qo9t79gizH+wXzLk0Rme42YB++2Np66N+AS1lZh5mWgKCvTL3MXkG
         IroGDXKDgdShBjiGiZjOoQb51+O4x47utL/pDgknyokKrwmVyCvjvq6zXYAtCtqhz/aH
         Ayrr65bsaXYcR6RqK22dn9qNoe8iDNfts2eAAfn9pZJm5cU/ksSijDS3FPNr7M24NIUm
         TXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVXj0cLL9VUphH0bgK54o5rYv0DrN8lZjO0Vg0C726g=;
        b=o5rezjn1t27rLubYEW2jZHVg+9O9EeOgunFPchLtqq/wtjnAnvV+cu1RL0xcEGCqN6
         oyMmfp2rnfPX7nRUbrOHctV/c2/cN6LxPgM28m6vumR0cv49SuVkOt8BC/+Y2kcjKPRN
         16qdvlONlOfVCEDG0xaw7gY4y1nWRV3ntGVbxl6dWJF1cPZJnT5o5TSIV1Qykdu0iA2N
         I7P1bHQcAu6p8Y9so4bYtuOenlol886p2kc9Wcgi8PDukZ8wugn+EWi0OK+fZ+7MOGBz
         Hj1aNAJDjui9AyLRQeenN9ZlOT16WkBHPsRRW1ew2pJct8bFfGxJDx45rV3nDMN6PQzb
         RvPQ==
X-Gm-Message-State: ACrzQf2WfzqyTM/RdXeyVKDVd+ysF7YcXwoUQapnlWkU89n32Nac7JU6
        bcOEdB1omMuFPjdsvDG2YQSSodPdiTg=
X-Google-Smtp-Source: AMsMyM51/YRJi28g0IJJxIu4EhG2p6/5PHmCsPyPmCVN8qRdhJgRrMnEM2GzdFA6Bx66B65uG8s+hQ==
X-Received: by 2002:a05:620a:2587:b0:6cf:7ece:e1f9 with SMTP id x7-20020a05620a258700b006cf7ecee1f9mr29557260qko.182.1667671573510;
        Sat, 05 Nov 2022 11:06:13 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id bw21-20020a05622a099500b003a50b9f099esm2258234qtb.12.2022.11.05.11.06.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 11:06:12 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id e123so4976938ybh.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 11:06:12 -0700 (PDT)
X-Received: by 2002:a25:f89:0:b0:6bc:1488:2f93 with SMTP id
 131-20020a250f89000000b006bc14882f93mr495714ybp.85.1667671572356; Sat, 05 Nov
 2022 11:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221030220203.31210-1-axboe@kernel.dk> <CA+FuTSfj5jn8Wui+az2BrcpDFYF5m5ehwLiswwHMPJ2MK+S_Jw@mail.gmail.com>
 <02e5bf45-f877-719b-6bf8-c4ac577187a8@kernel.dk> <CA+FuTSd-HvtPVwRto0EGExm-Pz7dGpxAt+1sTb51P_QBd-N9KQ@mail.gmail.com>
 <88353f13-d1d8-ef69-bcdc-eb2aa17c7731@kernel.dk> <CA+FuTSdEKsN_47RtW6pOWEnrKkewuDBdsv_qAhR1EyXUr3obrg@mail.gmail.com>
 <46cb04ca-467c-2e33-f221-3e2a2eaabbda@kernel.dk> <fe28e9fa-b57b-8da6-383c-588f6e84f04f@kernel.dk>
In-Reply-To: <fe28e9fa-b57b-8da6-383c-588f6e84f04f@kernel.dk>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 5 Nov 2022 14:05:35 -0400
X-Gmail-Original-Message-ID: <CA+FuTSfEqmx_rHPLaSp+o+tYzqCvF6oSjSOse0KoFvXj9xK9Cw@mail.gmail.com>
Message-ID: <CA+FuTSfEqmx_rHPLaSp+o+tYzqCvF6oSjSOse0KoFvXj9xK9Cw@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Add support for epoll min_wait
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 5, 2022 at 1:39 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> >> FWIW, when adding nsec resolution I initially opted for an init-based
> >> approach, passing a new flag to epoll_create1. Feedback then was that
> >> it was odd to have one syscall affect the behavior of another. The
> >> final version just added a new epoll_pwait2 with timespec.
> >
> > I'm fine with just doing a pure syscall variant too, it was my original
> > plan. Only changed it to allow for easier experimentation and adoption,
> > and based on the fact that most use cases would likely use a fixed value
> > per context anyway.
> >
> > I think it'd be a shame to drop the ctl, unless there's strong arguments
> > against it. I'm quite happy to add a syscall variant too, that's not a
> > big deal and would be a minor addition. Patch 6 should probably cut out
> > the ctl addition and leave that for a patch 7, and then a patch 8 for
> > adding a syscall.
> I split the ctl patch out from the core change, and then took a look at
> doing a syscall variant too. But there are a few complications there...
> It would seem to make the most sense to build this on top of the newest
> epoll wait syscall, epoll_pwait2(). But we're already at the max number
> of arguments there...
>
> Arguably pwait2 should've been converted to use some kind of versioned
> struct instead. I'm going to take a stab at pwait3 with that kind of
> interface.

Don't convert to a syscall approach based solely on my feedback. It
would be good to hear from others.

At a high level, I'm somewhat uncomfortable merging two syscalls for
behavior that already works, just to save half the syscall overhead.
There is no shortage of calls that may make some sense for a workload
to merge. Is the quoted 6-7% cpu cycle reduction due to saving one
SYSENTER/SYSEXIT (as the high resolution timer wake-up will be the
same), or am I missing something more fundamental?
