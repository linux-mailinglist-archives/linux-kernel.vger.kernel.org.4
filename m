Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4297A6B55D4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjCJXmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjCJXmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:42:39 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C007214B034
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:42:31 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id a9so7265065plh.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678491751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wv3F+wk4tZoGruUyDBY8Tbrsyth/dVYvCaYEldiyh3Q=;
        b=Ox7KVgJBLb9rm6JsETuakuJHSMU4Mye5N60VAL63b35LCFpVCrZ47RZ0YdDZoYyHas
         9YzjOVH9kE0nUEmlXwchoURKM1YdQliIP/EIjmxVJdBKhNGiR7X1dCRALCWX7rRukyYL
         flT+6syTcuWzDCYeZWxfRg2ILWqpMcg/qW77ZFx8xRsLrx2nEb2rQgTV22a4Jd4bYmKz
         11MKl2YV5qc2bYvsFFtgBCuy4gMyQgp7UVANzzkhprmkUra2ihlfT1K1Jo5pKaHFFhWe
         jdNlxfBqSIGSSK9s+eLNAEpJhKeys66ZyqvJ9xMPMzOVlg35+1xgnAUzQLnnnixVIZu9
         uoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678491751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wv3F+wk4tZoGruUyDBY8Tbrsyth/dVYvCaYEldiyh3Q=;
        b=KnGgG8L68Xi+yKlUW1WGctwDLui9oHMw2vvd5lQai1eVVAjeNL1a90Pgm63SIAsRvN
         yRf8ySIl9raut38+x5vxXapt8Nx5qlnuC5pVkFoJ3GBb63fvO92chkqVE4I18pViZoyq
         Bf+U9KLzKiLk480vIFiyLl2fEopF5fSXsDg7rHBZj2p1BhTyzbzNHYqo8Cxd8z+6vkLZ
         VsSNtNVLIAnfMw/imzWUPWwtH+IXPMlLpOjfoMHsJFDULwBmHYUkto/AElttiIw5qXT8
         8xL8ZpC/8KZh1wnintIhyTMBtUhEpU18S4n+aFp8bBJRQ0za95kwkJeSCdFS3Fb0GnVW
         pZsg==
X-Gm-Message-State: AO0yUKVBCvBclsWgQcnrZV7cI2TVFFd4h2C/KkBrDNdx+Dc0GUnLd182
        AmudF3JvxO9Y6/rSA4GFA7GvOVQPaSEzNnTiGcU=
X-Google-Smtp-Source: AK7set+hMsDT01qnTcZNSkZv8IN+Geb7gdC+irQyVitodhIBGuYBI+MPnGGTeTlyBp1qcNpZQf2s3JgHZXtwQ7n4hVU=
X-Received: by 2002:a17:903:2581:b0:19a:8bc7:d814 with SMTP id
 jb1-20020a170903258100b0019a8bc7d814mr10009307plb.13.1678491751206; Fri, 10
 Mar 2023 15:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20230209031159.2337445-1-ouyangweizhao@zeku.com>
 <CACT4Y+Zrz4KOU82jjEperYOM0sEp6TCmgse4XVMPkwAkS+dXrA@mail.gmail.com>
 <93b94f59016145adbb1e01311a1103f8@zeku.com> <CACT4Y+a=BaMNUf=_suQ5or9=ZksX2ht9gX8=XBSDEgHogyy3mg@mail.gmail.com>
 <CA+fCnZf3k-rsaOeti0Q7rqkmvsqDb2XxgxOq6V5Gqp6FGLH7Yg@mail.gmail.com>
 <b058a424e46d4f94a1f2fdc61292606b@zeku.com> <2b57491a9fab4ce9a643bd0922e03e73@zeku.com>
 <CA+fCnZcirNwdA=oaLLiDN+NxBPNcA75agPV1sRsKuZ0Wz6w_hQ@mail.gmail.com>
 <Y/4nJEHeUAEBsj6y@arm.com> <CA+fCnZcFaOAGYic-x7848TMom2Rt5-Bm5SpYd-uxdT3im8PHvg@mail.gmail.com>
 <Y/+Ei5boQh+TFj7Q@arm.com>
In-Reply-To: <Y/+Ei5boQh+TFj7Q@arm.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sat, 11 Mar 2023 00:42:20 +0100
Message-ID: <CA+fCnZdFZ0w33GcUWRfWhNmYkhszQ0gwVKGeY0uSOzBEJJe27A@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: fix deadlock in start_report()
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>
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
        =?UTF-8?B?5Lu756uL6bmPKFBlbmcgUmVuKQ==?= <renlipeng@zeku.com>
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

On Wed, Mar 1, 2023 at 6:00=E2=80=AFPM Catalin Marinas <catalin.marinas@arm=
.com> wrote:
>
> Yes. I'm including Vincenzo's patch below (part of fixing some potential
> strscpy() faults with its unaligned accesses eager reading; we'll get to
> posting that eventually). You can add some arch_kasan_enable/disable()
> macros on top and feel free to include the patch below.

Ah, perfect! I'll send a patchset soon. Thanks!

> Now, I wonder whether we should link those into kasan_disable_current().
> These functions only deal with the depth for KASAN_SW_TAGS but it would
> make sense for KASAN_HW_TAGS to enable tag-check-override so that we
> don't need to bother with a match-all tags on pointer dereferencing.

Using these TCO routines requires having (at least) migration disabled, rig=
ht?

It's not a problem for KASAN reporting code, as it already disables
preemption anyway.

The question is with the other kasan_disable/enable_current() call
sites. But as within all of them, the code does either a single access
or a memcpy or something similar, I think we can disable preemption
for that duration.

On a related note, I recalled that we also have a bug about using
supporting no_sanitize_address for HW_TAGS KASAN. And Peter suggested
using TCO entry/exit instrumentation to resolve it [2]. However, we
will also need to disable preemption for the duration of
no_sanitize_address-annotated functions, and I'm not sure if it's a
good idea to do that via compiler instrumentation.

Any thoughts?

In the mean time, I'll send a simpler patchset without converting all
kasan_disable/enable_current().

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D212513
[2] https://bugzilla.kernel.org/show_bug.cgi?id=3D212513#c2
