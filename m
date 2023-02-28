Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077E76A61BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjB1VvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjB1Vu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:50:59 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53754A261
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:50:58 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso4330237pjr.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677621058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LVmFrLrm92phvm/Baac+5/XWBy/z8f4Ods8WhgeHYw=;
        b=B9/smwhj4zsVD/lCX+bhR3gCU1Gu4DTdwrPwXDX6K69uiYX9tNrGeiqDe505xH2fg9
         YvYqZIMlRJH/f/e3/SkzZioafxBvpOXsALJHppQZ5NIvfLIMTlTXp9bHMWjx/c3Cdmck
         OeXttEXHOyVZvk/HF0V1MjDsIl1QnsJYmgad+rYgV5CP0xbDtFtvdzu2AYvDodhTWc88
         K4Wdm/Xc21noqInI79H+hy2ZIUNJm8v8bRMsfOBhNI1+ejT8lwF5t86Ig1XJWnucXLzq
         lL6BpBqGp5/Ti+nX5HJmaN2no3BR4VIpdWBJNccVuL/y1N/rtBMPxd4dLeaWK+iUGDfL
         1EQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677621058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LVmFrLrm92phvm/Baac+5/XWBy/z8f4Ods8WhgeHYw=;
        b=E76GIt0sKHJbR9R6IynT9TOIESDnLbXfjOf2d00vbFNTF+MldKkpSd+aN13P6yhATu
         e0pEgS2KXk3Oz1Ee9SI6jLpt+tm2NjUsuTYFFFPeG/kfvueUwMb1W3u0RLi2hCTDoHiM
         EGbiSD7TfQuqWaYDNtfAX1uO0jYiqETSF/PEFs1SYVq9b6YW23nesVT0deTBhx+vK0Ej
         wKFzh+aNox4aPIMuqz45qPrQ+m3xVupvogbDXJL/5wg+O2PAck26ahrtkXB4N3ndXyy1
         55POT9Czp+ORkpMLNsLGBwQfCuK2SC39JMZffVD4j+Nn7Gk2g4tg5gXA6LyeHdnZwqoq
         DgtQ==
X-Gm-Message-State: AO0yUKW77jd79zk2PBuvf1KPCPXuTyf9v2t2KGdxgWCYakYrYBZ7z5ri
        Fse03Ic5TEhibCiNQtKzCOLtfZJUOkxBDySuyZE=
X-Google-Smtp-Source: AK7set+w7RP/NpegjU9GETWFHpC2DBpWEKPKqo1OqR3wtJ9Pu2cQKMZF8467qIYKiwyZOtkrADDNxWopMyjWIaHTeIk=
X-Received: by 2002:a17:903:2591:b0:19a:8bc7:d814 with SMTP id
 jb17-20020a170903259100b0019a8bc7d814mr1498018plb.13.1677621057764; Tue, 28
 Feb 2023 13:50:57 -0800 (PST)
MIME-Version: 1.0
References: <20230209031159.2337445-1-ouyangweizhao@zeku.com>
 <CACT4Y+Zrz4KOU82jjEperYOM0sEp6TCmgse4XVMPkwAkS+dXrA@mail.gmail.com>
 <93b94f59016145adbb1e01311a1103f8@zeku.com> <CACT4Y+a=BaMNUf=_suQ5or9=ZksX2ht9gX8=XBSDEgHogyy3mg@mail.gmail.com>
 <CA+fCnZf3k-rsaOeti0Q7rqkmvsqDb2XxgxOq6V5Gqp6FGLH7Yg@mail.gmail.com>
 <b058a424e46d4f94a1f2fdc61292606b@zeku.com> <2b57491a9fab4ce9a643bd0922e03e73@zeku.com>
 <CA+fCnZcirNwdA=oaLLiDN+NxBPNcA75agPV1sRsKuZ0Wz6w_hQ@mail.gmail.com> <Y/4nJEHeUAEBsj6y@arm.com>
In-Reply-To: <Y/4nJEHeUAEBsj6y@arm.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 28 Feb 2023 22:50:46 +0100
Message-ID: <CA+fCnZcFaOAGYic-x7848TMom2Rt5-Bm5SpYd-uxdT3im8PHvg@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: fix deadlock in start_report()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     =?UTF-8?B?6KKB5biFKFNodWFpIFl1YW4p?= <yuanshuai@zeku.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        =?UTF-8?B?5qyn6Ziz54Kc6ZKKKFdlaXpoYW8gT3V5YW5nKQ==?= 
        <ouyangweizhao@zeku.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Weizhao Ouyang <o451686892@gmail.com>,
        =?UTF-8?B?5Lu756uL6bmPKFBlbmcgUmVuKQ==?= <renlipeng@zeku.com>,
        Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 5:09=E2=80=AFPM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> On Mon, Feb 27, 2023 at 03:13:45AM +0100, Andrey Konovalov wrote:
> > +Catalin, would it be acceptable to implement a routine that disables
> > in-kernel MTE tag checking (until the next
> > mte_enable_kernel_sync/async/asymm call)? In a similar way an MTE
> > fault does this, but without the fault itself. I.e., expose the part
> > of do_tag_recovery functionality without report_tag_fault?
>
> I don't think we ever re-enable MTE after do_tag_recovery(). The
> mte_enable_kernel_*() are called at boot. We do call
> kasan_enable_tagging() explicitly in the kunit tests but that's a
> controlled fault environment.

Right, but here we don't want to re-enable MTE after a fault, we want
to suppress faults when printing an error report.

> IIUC, the problem is that the kernel already got an MTE fault, so at
> that point the error is not really recoverable.

No, the problem is with the following sequence of events:

1. KASAN detects a memory corruption and starts printing a report
_without getting an MTE fault_. This happens when e.g. KASAN sees a
free of an invalid address.

2. During error reporting, an MTE fault is triggered by the error
reporting code. E.g. while collecting information about the accessed
slab object.

3. KASAN tries to print another report while printing a report and
goes into a deadlock.

If we could avoid MTE faults being triggered during error reporting,
this would solve the problem.

> If we want to avoid a
> fault in the first place, we could do something like
> __uaccess_enable_tco() (Vincenzo has some patches to generalise these
> routines)

Ah, this looks exactly like what we need. Adding
__uaccess_en/disable_tco to kasan_report_invalid_free solves the
problem.

Do you think it would be possible to expose these routines to KASAN?

> but if an MTE fault already triggered and MTE is to stay
> disabled after the reporting anyway, I don't think it's worth it.

No MTE fault is triggered yet in the described sequence of events.

> So I wonder whether it's easier to just disable MTE before calling
> report_tag_fault() so that it won't trigger additional faults:

This will only help in case the first error report is caused by an MTE
fault. However, this won't help with the discussed problem: KASAN can
detect a memory corruption and print a report without getting an MTE
fault.

Nevertheless, this change makes sense to avoid a similar scenario
involving 2 MTE faults.
