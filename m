Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAB46A3870
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 03:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjB0CUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 21:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjB0CUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 21:20:13 -0500
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106345FD2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 18:16:01 -0800 (PST)
Received: by mail-pl1-f171.google.com with SMTP id n6so3840093plf.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 18:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EL7MuJSDTGevv/5NshB4YJDYr1z5Pg/OiTSz3dYlut0=;
        b=QaqU4DEaPYkI3jbBEvsdldSOgP64djE29YpRXOkqDO9Rny8cCSqM3/pxl6wwAxHy7h
         cxoDKUQlJxVG+Ihl6FApuki1fJY+F4/qagDr5CCYmEkwpHnThEJ+uoWRnCaoVYXgYMie
         zVGSy2SPY2vXmtclQ0U4+GYrh5wW5G9Nlzsdl/VxpuCMh2qhKCGY8d/BpDo7oqVnTF4c
         ocfFEHvI+wdd6cDqBoaBRZbRqVmBLXFnhyTX1D/kBsckewx4RxptmGErH0oJtK+aYXkV
         YyNi3DPCSvQ0GuyOpiJsk8TILWStkJYUgP8sLDRob0/IMVUlu1WLcHu4W8FQkA49KwX3
         QDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EL7MuJSDTGevv/5NshB4YJDYr1z5Pg/OiTSz3dYlut0=;
        b=V7p1KFtb2sJGANbbJrekYWQZXe6+3qUTU5ZIoxQ6Axjzh1V8fmgGA6XA1UH+I+tIiR
         PL0EAbzvr2Ecqk8h7OC7b/2adPD9qAqNy9esyr8HcMK8+OdAbbD78gMSndg8rPlwBkNc
         qXP62H8sxwSyS/RUH+4+FVPgBzAouMDLRg+YXv4+jZrR7xPwpf19Eub5NNC85hT48JQp
         LB5UlsjnuXoGCDDy7S3ZNAh70dt++RSDq92Jqka8zN6IVfz3Mbfk5IQVi5Yr8SqezmjN
         wvLlVNyRcw98Xk/4Ve9+Uc00MfNwqsBfYP+xw2G0JfH9FlZ212LAKJ97xO8iOrHaM/lE
         kJjg==
X-Gm-Message-State: AO0yUKVwbGlofZfSfgMNJFUsjeZx/nvaHkHLpDXNHDLEd10mkbk5Osqe
        OjwXZD4hzh/xvpPG4C5PjgUDhfLhse/KjsZ86h3/mjheZVH+SQ==
X-Google-Smtp-Source: AK7set/0s/lvC/FcPoyrtLQpsWGAGqLg6Is1B0ZyjonRu58vFYRpXwwHAkvSAGjzbIn0r2RBb5JbAQaKQPHNAyhEgeM=
X-Received: by 2002:a17:90a:17ec:b0:237:30ef:e252 with SMTP id
 q99-20020a17090a17ec00b0023730efe252mr4002230pja.9.1677464036839; Sun, 26 Feb
 2023 18:13:56 -0800 (PST)
MIME-Version: 1.0
References: <20230209031159.2337445-1-ouyangweizhao@zeku.com>
 <CACT4Y+Zrz4KOU82jjEperYOM0sEp6TCmgse4XVMPkwAkS+dXrA@mail.gmail.com>
 <93b94f59016145adbb1e01311a1103f8@zeku.com> <CACT4Y+a=BaMNUf=_suQ5or9=ZksX2ht9gX8=XBSDEgHogyy3mg@mail.gmail.com>
 <CA+fCnZf3k-rsaOeti0Q7rqkmvsqDb2XxgxOq6V5Gqp6FGLH7Yg@mail.gmail.com>
 <b058a424e46d4f94a1f2fdc61292606b@zeku.com> <2b57491a9fab4ce9a643bd0922e03e73@zeku.com>
In-Reply-To: <2b57491a9fab4ce9a643bd0922e03e73@zeku.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 27 Feb 2023 03:13:45 +0100
Message-ID: <CA+fCnZcirNwdA=oaLLiDN+NxBPNcA75agPV1sRsKuZ0Wz6w_hQ@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: fix deadlock in start_report()
To:     =?UTF-8?B?6KKB5biFKFNodWFpIFl1YW4p?= <yuanshuai@zeku.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 2:22 PM =E8=A2=81=E5=B8=85(Shuai Yuan) <yuanshuai@z=
eku.com> wrote:
>
> I have got valid information to clarify the problem and solutions. I made
> a few changes to the code to do this.
>
> a) I was testing on a device that had hardware issues with MTE,
>     and the memory tag sometimes changed randomly.

Ah, I see. Faulty hardware explains the problem. Thank you!

> f) From the above log, you can see that the system tried to call kasan_re=
port() twice,
>    because we visit tag address by kmem_cache and this tag have change..
>    Normally this doesn't happen easily. So I think we can add kasan_reset=
_tag() to handle
>    the kmem_cache address.
>
>    For example, the following changes are used for the latest kernel vers=
ion.
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -412,7 +412,7 @@ static void complete_report_info(struct kasan_report_=
info *info)
>         slab =3D kasan_addr_to_slab(addr);
>         if (slab) {
> -               info->cache =3D slab->slab_cache;
> +               info->cache =3D kasan_reset_tag(slab->slab_cache);

This fixes the problem for accesses to slab_cache, but KASAN reporting
code also accesses stack depot memory and calls other routines that
might access (faulty) tagged memory. And the accessed addresses aren't
exposed to KASAN code, so we can't use kasan_reset_tag for those.

I wonder what would be a good solution here. I really don't want to
use kasan_depth or some other global/per-cpu flag here, as it would be
too good of a target for attackers wishing to bypass MTE. Perhaps,
disabling MTE once reporting started would be a better option: calling
the disabling routine would arguably be a harder task for an attacker
than overwriting a flag.

+Catalin, would it be acceptable to implement a routine that disables
in-kernel MTE tag checking (until the next
mte_enable_kernel_sync/async/asymm call)? In a similar way an MTE
fault does this, but without the fault itself. I.e., expose the part
of do_tag_recovery functionality without report_tag_fault?

TL;DR on the problem: Besides relying on CPU tag checks, KASAN also
does explicit tag checks to detect double-frees and similar problems,
see the calls to kasan_report_invalid_free. Thus, when e.g. a
double-free report is printed, MTE checking is still on. This results
in a deadlock in case invalid memory is accessed during KASAN
reporting.

Thanks!
