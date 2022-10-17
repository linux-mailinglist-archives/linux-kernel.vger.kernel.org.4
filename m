Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF8C601636
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJQS0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJQS0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:26:16 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BCC7392F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:26:16 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3321c2a8d4cso115812797b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5U1OyyooDcBLibqlBc/BrkxXaQuYm21e5GaBzzXBOAE=;
        b=0EXE4OwBnQHCfdTjZKSyO75Lhq6NTD/7mta51qnPtuwJY6WZVnjR3JgTKQU/9/+w6W
         nasUYnRaG7GQ+aTcvSP7iBVgZTvgqWskeTp7ShtIlvwt+SikFLQlavmbQ4hfwoYKQZAo
         DLXIDk8mTLkWfCadq3COwKYnVC3FetBarkG96Cg6BUNLT200mpeLEH0JBb+jqV6bCjSK
         4mV3BAaUF5e2hRcJ+xfDLpzHWkc3y7tatRDcrnrF9HRllt+ACgZKUf/3l1tKWsrtdHAr
         8F58in6OGdOQtPZf4vSP/tsGbrEiW2/hUn7FPQ90CZypT9JVhLrCPX8DqhxHp1rMLwLo
         7+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5U1OyyooDcBLibqlBc/BrkxXaQuYm21e5GaBzzXBOAE=;
        b=P7RGQI2YelF1kW880uK4cLvq49x80urFyXTtDx6Tm1t8rp4UeR22ziutXzrhHsmzd3
         /czKNv6a2PBFq23obfGd/B59mgVTHox9tXZE8xkBfAFIBJJ98lgS6dVoKDZoFE5vDo2h
         4uVyNfrxUW61GEr89RiRIboo7H11RoyyjvRlOf82T53U5uggiBh2BQ8WT/J0WqlFWRzT
         5aP5kHHZlJSiYxR54z3+NnMBj5uLEcQvV7doX+fUpecIMAcyFZUFVupyD9qyDeFbyBg5
         U+n06ckzgYtx2Y/x9pKmJzL9Zdogrn8sr648lnjLZH7wdykvRTM+kyE8tRPajjBSJrc1
         Qd+Q==
X-Gm-Message-State: ACrzQf0EBjqut8muTsB8ukw6p02zWVPqJqICmCsMBzhx69010czG3XAG
        H3L8NF8+tvQwMeDhuFXsFHLiBUkXjkC7/xWS4RvV
X-Google-Smtp-Source: AMsMyM53sbm2ZVhZE5BhtALEppiY3ukUEoy4iOiE0oRNTFzlvPg60lej8JBWylEJRiwRvPqgxc6Ycn/DtzQRaYlIeQ8=
X-Received: by 2002:a81:a141:0:b0:35f:a727:f27 with SMTP id
 y62-20020a81a141000000b0035fa7270f27mr10634101ywg.205.1666031175121; Mon, 17
 Oct 2022 11:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220927225944.2254360-4-ankur.a.arora@oracle.com>
 <20221007004943.2910736-1-ankur.a.arora@oracle.com> <CAHC9VhSnWZ1ovEeajasBPQA0-_AgNW21K2Ycpc3wvSHw5uQZ9Q@mail.gmail.com>
In-Reply-To: <CAHC9VhSnWZ1ovEeajasBPQA0-_AgNW21K2Ycpc3wvSHw5uQZ9Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Oct 2022 14:26:04 -0400
Message-ID: <CAHC9VhR3Zv7tBhoeyK3b0Rh=KPBaorHjVAJ4uF6MJqitoQB9XQ@mail.gmail.com>
Subject: Re: [PATCH v2] audit: unify audit_filter_{uring(),inode_name(),syscall()}
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-audit@redhat.com, eparis@redhat.com, sgrubb@redhat.com,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 7:11 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Oct 6, 2022 at 8:49 PM Ankur Arora <ankur.a.arora@oracle.com> wrote:
> >
> > audit_filter_uring(), audit_filter_inode_name() are substantially
> > similar to audit_filter_syscall(). Move the core logic to
> > __audit_filter_op() which can be parametrized for all three.
> >
> > On a Skylakex system, getpid() latency (all results aggregated
> > across 12 boot cycles):
> >
> >          Min     Mean    Median   Max      pstdev
> >          (ns)    (ns)    (ns)     (ns)
> >
> >  -    196.63   207.86  206.60  230.98      (+- 3.92%)
> >  +    183.73   196.95  192.31  232.49      (+- 6.04%)
> >
> > Performance counter stats for 'bin/getpid' (3 runs) go from:
> >     cycles               805.58  (  +-  4.11% )
> >     instructions        1654.11  (  +-   .05% )
> >     IPC                    2.06  (  +-  3.39% )
> >     branches             430.02  (  +-   .05% )
> >     branch-misses          1.55  (  +-  7.09% )
> >     L1-dcache-loads      440.01  (  +-   .09% )
> >     L1-dcache-load-misses  9.05  (  +- 74.03% )
> > to:
> >     cycles               765.37  (  +-  6.66% )
> >     instructions        1677.07  (  +-  0.04% )
> >     IPC                    2.20  (  +-  5.90% )
> >     branches             431.10  (  +-  0.04% )
> >     branch-misses          1.60  (  +- 11.25% )
> >     L1-dcache-loads      521.04  (  +-  0.05% )
> >     L1-dcache-load-misses  6.92  (  +- 77.60% )
> >
> > (Both aggregated over 12 boot cycles.)
> >
> > The increased L1-dcache-loads are due to some intermediate values now
> > coming from the stack.
> >
> > The improvement in cycles is due to a slightly denser loop (the list
> > parameter in the list_for_each_entry_rcu() exit check now comes from
> > a register rather than a constant as before.)
> >
> > Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> > ---
> >  kernel/auditsc.c | 76 +++++++++++++++++++++++++-----------------------
> >  1 file changed, 39 insertions(+), 37 deletions(-)
>
> Thanks, this looks good to me.  I'll queue this up for when the merge
> window closes.

This is also merged into audit/next, thanks!

-- 
paul-moore.com
