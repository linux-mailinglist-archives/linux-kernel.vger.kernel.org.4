Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1AE6913C3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjBIWyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBIWyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:54:36 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EC92E831
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 14:54:35 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so3772194pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 14:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdJbx8cUbzo0up0IR5lEzRMt6aSIhKf92x7ZKJB7vEo=;
        b=G/FznRNObgVkQXLBPohkbpuy+Vo3zgOTN1k9wT6w62lk4JC/1LrHh+T2XUb/NvZmH9
         sDMIWW/wpMD0wG1f83vfj6CpRRoGaNbzw5buebe/e2B7EBdyQCChWA559Akzg2Kws4D3
         h6HozfsFOX0WeDdPM0KgCsV5QxDIRIBtbITs5JE7N3MpY3NQOhnW6gfpQgBCeGAQ9ao/
         35A19tpKtVrbHyiJFfcl9pJoV3bvvfbrGofBIoNpfqBi+ohkXfj/IQWOpXIJE636nsAF
         iYG3KtVfhFvhiAy2+O41XpIYANOobom8/RI3HTyNMeyabHfgzYFmoW9BZ7HQVB8XulMw
         ORoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdJbx8cUbzo0up0IR5lEzRMt6aSIhKf92x7ZKJB7vEo=;
        b=iWlvjMPg7zTsD15Nvoryk6Pha2e9VlGkF9Ei5lMNwA24Dvg+jZ6ElA1FZ3MNxWvrUI
         qOCxVMkMarESTS4np6AK0cHwRCn0X33Y+KaKXq5OZD46Kq8pIqEXa/pisEPJGfFiMX53
         BgKkq43AOjaEYgHts/oe4yxuCvwranb0TCc9y+DZInctQgatACSOlsVEn79T1Yi3tv1C
         ZLjm5Avi2cVf4dBZQ7q9kMpNc5T5+b6Do4ca7APnnRr1mtDQCuk8yaLFVN0KSKR+hfyU
         hvrJhbMAhuzOpgqiYtLcTCMvRa20rhItxSk55YiYS8HjRxGn+mfERoSHa0F38v90v2JT
         3A+g==
X-Gm-Message-State: AO0yUKXBDdfJntV3z/sZ+SLQYmBfba7o/uqTgm24diH9/D+/ZGkX2Yby
        FEUd/phB3r+ZQGpPe2Td3/9s7WoMBsCeHupeQY8=
X-Google-Smtp-Source: AK7set9BmOFXeMFgWuYqsMw64603eTyj8QckPEuvDG0+7W0AEhRV/p749AsDYf+uFJJ6rqHxdBb8BEMlTMnjg9BbfMM=
X-Received: by 2002:a17:903:22c1:b0:196:6319:a029 with SMTP id
 y1-20020a17090322c100b001966319a029mr3302057plg.12.1675983275394; Thu, 09 Feb
 2023 14:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20230209031159.2337445-1-ouyangweizhao@zeku.com>
 <CACT4Y+Zrz4KOU82jjEperYOM0sEp6TCmgse4XVMPkwAkS+dXrA@mail.gmail.com>
 <93b94f59016145adbb1e01311a1103f8@zeku.com> <CACT4Y+a=BaMNUf=_suQ5or9=ZksX2ht9gX8=XBSDEgHogyy3mg@mail.gmail.com>
In-Reply-To: <CACT4Y+a=BaMNUf=_suQ5or9=ZksX2ht9gX8=XBSDEgHogyy3mg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 9 Feb 2023 23:54:24 +0100
Message-ID: <CA+fCnZf3k-rsaOeti0Q7rqkmvsqDb2XxgxOq6V5Gqp6FGLH7Yg@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: fix deadlock in start_report()
To:     Dmitry Vyukov <dvyukov@google.com>,
        =?UTF-8?B?6KKB5biFKFNodWFpIFl1YW4p?= <yuanshuai@zeku.com>
Cc:     =?UTF-8?B?5qyn6Ziz54Kc6ZKKKFdlaXpoYW8gT3V5YW5nKQ==?= 
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

On Thu, Feb 9, 2023 at 11:44 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
>  On Thu, 9 Feb 2023 at 10:19, =E8=A2=81=E5=B8=85(Shuai Yuan) <yuanshuai@z=
eku.com> wrote:
> >
> > Hi Dmitry Vyukov
> >
> > Thanks, I see that your means.
> >
> > Currently, report_suppressed() seem not work in Kasan-HW mode, it alway=
s return false.
> > Do you think should change the report_suppressed function?
> > I don't know why CONFIG_KASAN_HW_TAGS was blocked separately before.
>
> That logic was added by Andrey in:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dc068664c97c7cf
>
> Andrey, can we make report_enabled() check current->kasan_depth and
> remove report_suppressed()?

I decided to not use kasan_depth for HW_TAGS, as we can always use a
match-all tag to make "invalid" memory accesses.

I think we can fix the reporting code to do exactly that so that it
doesn't cause MTE faults.

Shuai, could you clarify, at which point due kasan_report_invalid_free
an MTE exception is raised in your tests?

> Then we can also remove the comment in kasan_report_invalid_free().
>
> It looks like kasan_disable_current() in kmemleak needs to affect
> HW_TAGS mode as well:
> https://elixir.bootlin.com/linux/v6.2-rc7/source/mm/kmemleak.c#L301

It uses kasan_reset_tag, so it should work properly with HW_TAGS.
