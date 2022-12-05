Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D706437FE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiLEWX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbiLEWXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:23:22 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E54E55
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 14:23:21 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z144so4288704iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 14:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xt4Ng4f7DzUWlFKte3qMSDvwTEhhgAP9/m+VDXnbEuM=;
        b=SotciC8kaLwKhrcdt91+e4nXCnaYRZ41wQ3VF1dEHvlyCu+GVPavsc/0Fk4GH5L0wG
         UTqxf2iosDU041ewIB36QI1qFLbPx8VVDEH5z1FVBxq1Q95/oAyF9zm6aR0FvEIsPHrJ
         Lb0IvRmHGADn7QQ3avIlJ3xtkUloyDPwFNeJwBujXeUT51oeT0InhaqG8MSGSr69k24o
         KYCqJ2nyj/aIsdNptDVeEhSg6rRzZ+aPLf+x5p+imJw+ZBoiIxFHglgzxVjb75KtPfiq
         brRseJHlBy0IO3bHnkTyer1DV2QPdcDJOwOGB8TTSFClCXFy2s6OSOHn15gEXyM2qxgf
         HMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xt4Ng4f7DzUWlFKte3qMSDvwTEhhgAP9/m+VDXnbEuM=;
        b=a9RFcv2gyqYOVCl7DRTtqzzltZLE1UhH/m/juHk2oxg7tVKTxoXn5trp/mHLi+u/Zv
         2q/yvoiRbvzWv98X2fC0E0d/NUk/yVxM4ydjQgoHFadqaHHzz6yEsbrudlirGoI6sFw1
         sXcwLBaNOhZCX8LHr3AgR3TVfCjbJZTLv+017v2TkMaiAYXDoPF681hX6QhTO9czTJcD
         VHuvKfm4cD6EAQ5cYBcHy4MLapAoGA/HpPhoNbSKII4bcjyVzsh7SSjXnfiEPxf+8s9q
         pRof376Y/iHD6dFQTuZLBxnVyEdKr7reAkZJl97iPZDcdR5JFVtqRwM6gCoJM/b8z1gl
         x1bw==
X-Gm-Message-State: ANoB5pndhR9ADSm70pOZNzY3kZYzcUgpzhqRaYgxnl7cTG0oatjDpyLC
        sJsm3VC6UMQp0Wff2NY5SszMNc5+vJGosfr8znCnSQ==
X-Google-Smtp-Source: AA0mqf5WyO2XwdGCPmZGrOWPCPZaZSdYZlD4x1P7UmZhXiyB0ZnuiaBhcFEholcy3PLJSmlyUD+SeyKkJyp+TyiNZoM=
X-Received: by 2002:a5d:8f84:0:b0:6d9:56fc:ef25 with SMTP id
 l4-20020a5d8f84000000b006d956fcef25mr29352334iol.56.1670279000948; Mon, 05
 Dec 2022 14:23:20 -0800 (PST)
MIME-Version: 1.0
References: <20221205192304.1957418-1-Liam.Howlett@oracle.com>
 <20221205123250.3fc552d96fcca5dc58be8443@linux-foundation.org>
 <CAG48ez26s0R6DsPKJ1dUomwSwCfhWcpQD6Zb0GU0rbYcFD1hww@mail.gmail.com> <b1b80402-2c90-8006-bcf8-716e6ef719c2@suse.cz>
In-Reply-To: <b1b80402-2c90-8006-bcf8-716e6ef719c2@suse.cz>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 5 Dec 2022 23:22:44 +0100
Message-ID: <CAG48ez2trF-V658GpXC5u2N54omeZ0w_T1XTTcrtg+w0PEMeDw@mail.gmail.com>
Subject: Re: [PATCH v2] mmap: Fix do_brk_flags() modifying obviously incorrect VMAs
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Jason Donenfeld <Jason@zx2c4.com>,
        Matthew Wilcox <willy@infradead.org>,
        SeongJae Park <sj@kernel.org>
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

On Mon, Dec 5, 2022 at 11:13 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> On 12/5/22 22:55, Jann Horn wrote:
> > On Mon, Dec 5, 2022 at 9:32 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >> On Mon, 5 Dec 2022 19:23:17 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> >> > Add more sanity checks to the VMA that do_brk_flags() will expand.
> >> > Ensure the VMA matches basic merge requirements within the function
> >> > before calling can_vma_merge_after().
> >>
> >> I't unclear what's actually being fixed here.
> >>
> >> Why do you feel we need the above changes?
> >>
> >> > Drop the duplicate checks from vm_brk_flags() since they will be
> >> > enforced later.
> >> >
> >> > Fixes: 2e7ce7d354f2 ("mm/mmap: change do_brk_flags() to expand existing VMA and add do_brk_munmap()")
> >>
> >> Fixes in what way?  Removing the duplicate checks?
> >
> > The old code would expand file VMAs on brk(), which is functionally
> > wrong and also dangerous in terms of locking because the brk() path
> > isn't designed for file VMAs and therefore doesn't lock the file
> > mapping. Checking can_vma_merge_after() ensures that new anonymous
> > VMAs can't be merged into file VMAs.
> >
> > See https://lore.kernel.org/linux-mm/CAG48ez1tJZTOjS_FjRZhvtDA-STFmdw8PEizPDwMGFd_ui0Nrw@mail.gmail.com/
> > .
>
> I guess the point is that if we fix it still within 6.1, we don't have to
> devise how exactly this is exploitable,

Yeah, that was sort of my thinking.

> but due to the insufficient locking
> it most likely is, right?

To be honest, I don't really know how bad this is - pretty much the
only thing we're doing here is to change the VMA end. I don't know if
that messes up the address_space's interval tree or something?
I have no clue how that data structure looks.
