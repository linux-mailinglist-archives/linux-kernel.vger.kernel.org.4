Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D6B611A02
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiJ1SSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJ1SSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:18:09 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A998642EE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:18:09 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 8so3977325qka.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jg+y5pJXJAf+IzCBhzE1K677QTmOHQ5t2GVhpetBIjQ=;
        b=DVpDLqmrpX7h2ApFtsuwad32KusLtdyYe2rCADXhN4FhRmHK8KGC7pKv879tYEZ7RK
         3bT+7j21M/MKbmZO+ELDT9TH9QaIDMkro+7ES/hnqCV0h8QAWiiSE79meBPnixtluR6m
         G/SCmZNO08uVR+CVcg2Ld+54+Agg8m+erJclrnOr25SDxSZDLlJyztAcXump6zY94V+P
         Q0lfb8XUGDalb6eWwDwNqchuZ+lEYQ0eCF0sQHkel8UZxEw/Kf1MBP/qpENvwwlmGO0u
         1h1nRrOLFMrFHKy+JowzjLMebVVBNmKR8cvU2WmPUNeiYl0HrHN4f2gTQVHBs1h6g659
         7OOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jg+y5pJXJAf+IzCBhzE1K677QTmOHQ5t2GVhpetBIjQ=;
        b=jVRjkXDQbihg+TUMqKN1RRR0BXMWi4NeVKyReiOJ/jU4kKtj++Toh7CfhPR9VgSPn0
         ShD6Do6NwcJrOliQJ0NiGfkYAJAy5NqFo9bE5iw+0n6DDH10pOnhh2AhEBS33/yXGQvQ
         uw7RnXPpBFrVo9YYlq4blmz1Se/KIPEXYJSrBnqvRK6AFsVLegbjo53q56aTSp29SnI4
         9VrPo+IEQo6unKIo8LvAbWh7jo2YZL/DlH17R7XEza6PMfEsSymDioHzAEOQlZZ6Fq2n
         Q8kGSEbHKB4ul9hGsVRbFKsaRtagBBkkeiad/Ux6FnEB0NG8eWDeG6np7Iq0W4ulJKj9
         Uq3A==
X-Gm-Message-State: ACrzQf0Pp9EAImCkxEWuEZucQxoqV7KHp8XdbBkc2MHuItTlnhEp+G94
        3fLNgCVVG9AWafAHb4e5uyZO+Y/mnhpLvY3W6O06sbB9vONhWMni
X-Google-Smtp-Source: AMsMyM6hhYRY/DeQ9ApjbZDeIVz3lq0pMjYCdOI8iPfsPUGNNfgCJBZjsw1ZlaO2aNZ/w6caxjQUeV8WqnSBzVgBpAM=
X-Received: by 2002:a05:620a:22c3:b0:6ec:53bb:d296 with SMTP id
 o3-20020a05620a22c300b006ec53bbd296mr465616qki.158.1666981088311; Fri, 28 Oct
 2022 11:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1666978292.git.tanjubrunostar0@gmail.com> <Y1wbVeLCLZClEQ6L@aschofie-mobl2>
In-Reply-To: <Y1wbVeLCLZClEQ6L@aschofie-mobl2>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Fri, 28 Oct 2022 19:17:56 +0100
Message-ID: <CAHJEyKURpAYT-2a3wA9aqO2=wYRK=4MQ9sq3SBCg5yoSNKFo1Q@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] staging: vt6655: a series of checkpatch fixes on
 the file: rxtx.c
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 7:11 PM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> We know it's a patchset or series, saying so in subject line is
> redundant. Perhaps - 'Checkpatch cleanup in rxtx.c'
>
> On Fri, Oct 28, 2022 at 05:40:52PM +0000, Tanjuate Brunostar wrote:
> > The fixes are similar, mostly long lines splitting. I had to make
> > serveral patches to ease the work of inspectors
>   ^
> Please use a spell checker.
>
> >
> > v2: fixed a compilation error found by the kernel test robot and
> > recompiled the code
>
> Expected to be in reverse order, with latest changes first.
> ie. Here you would start with v8
>
> > v3: tends out the error persisted in the second version. this version is
> > a correction of that
>
> ?
>
> >
> > v4: did some corrections as recommended by Greg KH
>
> State what changed. Do not expect your review to go back
> hunting for past review comments.
>
> Same for all below.
>
> >
> > v5: shortend changelog comments as recommended by Greg KH
> >
> > v6: did some corrections as recommended by Greg KH
> >
> > v7: fixed some errors on my changelog comments
> >
> > v8: fixed some errors pointed out by Philipp Hortmann
> >
> > Tanjuate Brunostar (6):
> >   staging: vt6655: fix lines ending in a '('
>
> Move ( to end of line
>
> >   staging: vt6655: fix long lines of code in s_uGetRTSCTSDuration
>
> This doesn't match what was actually done
>
> >   staging: vt6655: fix long lines of code in s_uFillDataHead
> >   staging: vt6655: fix long lines of code in s_vGenerateTxParamete
> >   staging: vt6655: fix long lines of code in the rest of the file
>
> Each commit msg needs to stand alone. The one above only makes
> sense (still it's a poor message) when viewed in this patchset.
> Once the patches are applied, it must stand alone.
>
> The commit msg should read like a directive. Fix is too general.
> Commit msg states what you did, commit log states why you did it.
>
> I see you took 'refactoring' out of the commit messages, but left it
> in the commit logs. It doesn't belong in the logs. As another
> reviewer pointed out, this is not a refactor.
>
> Alison
The commit logs I changed  too but they did not show in the
patches when I sent them. I don't get how that happened.
Thanks for the corrections. like i said, I will be sticking with single patches
for now.
Thanks,
Tanju
> >
> >  drivers/staging/vt6655/rxtx.c | 542 ++++++++++++++++++++--------------
> >  1 file changed, 324 insertions(+), 218 deletions(-)
> >
> > --
> > 2.34.1
> >
> >
>
