Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587596D49AE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjDCOkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbjDCOkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:40:14 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2252A31988
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:40:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i5so118477296eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680532809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeyT0QKLAdfx1wYIp91BBauMDPF4spiSXYLFvc2Jhew=;
        b=DNxFne77gr38mPjKD2skrtdATHJqX38RkSDOtn4x784v77WE3WX4Snr1XrMgN8jfDR
         b1sljIuwWJRMWedD3xC6Zyg5KGjWdIe9N9iefzkL2LJXi7/o+cSu1cAXL/DxMRlPtO4w
         rEOj+c7dEyl4YJaWmGKZrpq6go+QHFa5F9q54ISmVS8VsvD988/p6N/avfnA1pwFVG9w
         BLB9xVniMvXWRhCSxsnYO4fQw4UWpDe6m2cZsKRNaNI9SSDUEUWbvo5XVaOKJ9RvAuM4
         2c7kZ7VLtFiRSP11RXSPgOpSMSW9xl921onVWRPFHl2fhke6llLzcaL/vHWfmt2shENb
         NpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680532809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeyT0QKLAdfx1wYIp91BBauMDPF4spiSXYLFvc2Jhew=;
        b=sURC6t3dP8dFl0aPQWozVPKtVwnQzybKfKNgBJv3FDK78c4xP0U7a5X++1G3ZDDRIb
         dHyAdfp3hHyfUze3HYfG75vkbnYS3KCacv++HdnmtBUAEA9JfV/Rzwfb7DaSOTUqt+HY
         295wDlJWVLYHG517xePLZcnY2hpDRMNxKo1jHfp1o1Sk+x51PzCyHIlU3zoDaRI2dtqs
         4M3BlxwcWIUNKH2cNBHFt6/s+CoXuhvF7R6+I9bneNOskw05wschwTWwiT2ssGwNBYZH
         K4FgFHeBzKxnex6QHQecXzh4i+gAGaou5vsZ6ljmt7yBcWxOCMbqmYjYiGuavOpzgaPs
         Grsg==
X-Gm-Message-State: AAQBX9fgS5l9uVnMh5hF9UwhBdSKdH9xhnZLkKjR4QWVnri9/rJixdAb
        mFMuIv+56EqBIP9RzB8/YV6fhaLZZa4i2TM59ag=
X-Google-Smtp-Source: AKy350YB6/aTny7rowwDsGnFpzK500CdURAqu/f4FzIVYyZ+gYMKzXuMVnbYkRm2sqqQxnruh9G38DpeyQ+ZbHZpFY8=
X-Received: by 2002:a50:9e43:0:b0:502:4459:f2b8 with SMTP id
 z61-20020a509e43000000b005024459f2b8mr12975681ede.8.1680532809061; Mon, 03
 Apr 2023 07:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p3>
 <20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p3> <ZCrMMQt2xnnZIyz6@alley>
In-Reply-To: <ZCrMMQt2xnnZIyz6@alley>
From:   Jaewon Kim <jaewon31.kim@gmail.com>
Date:   Mon, 3 Apr 2023 23:39:58 +0900
Message-ID: <CAJrd-Uvzy18SfjjqbqZCPHjw+ujQXsBpvov4b=bfAwZrj=bCAA@mail.gmail.com>
Subject: Re: [RFC] vsprintf: compile error on %09pK
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        GyeongHwan Hong <gh21.hong@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023=EB=85=84 4=EC=9B=94 3=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 9:53, Pe=
tr Mladek <pmladek@suse.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon 2023-04-03 19:46:17, Jaewon Kim wrote:
> > Hello
> >
> > I've just changed %09lx to %09pK on my driver code to hide the address,=
 but I
> > faced compiler error. The %9pK without 0 worked.
>
> What exactly do you want to achieve, please?

Hello

Thank you for your comment.

I wanted to print phys_addr_t  type value only when kptr_restrict sysctl is
allowed. So I thought I could use %pK for that purpose. And the physical
address is not that long. I wanted to make that length short like 9 hex.

>
> Note that printk() hashes pointers by default. It means that %p does not
> print the value but a hash based on the value.
>
> If you print the same pointer twice, you will see the same hash, so
> you know that the pointer is the same. But you do not see the address
> so that you could not use the value for a security attack.
>
> See Documentation/core-api/printk-formats.rst
>
> Anyway, the main question if it makes sense to print the pointer value
> at all. The address is not useful if it can't be compared with
> other pointers or if the data on the address could not be checked.
>
> > Is there restriction on %pK which does now allow %0 ? I've wondered whe=
ther I
> > did wrong or it is a printk problem.
> >
> > To show easily I tried to add pr_info("%09pK\n", nodemask); in page_all=
oc.c
> > Then here's what I did.
> >
> > $ ARCH=3Dx86 make x86_64_defconfig ; make mm/page_alloc.o
> > #
> > # No change to .config
> > #
> >   CALL    scripts/checksyscalls.sh
> >   DESCEND objtool
> >   INSTALL libsubcmd_headers
> >   CC      mm/page_alloc.o
> > In file included from ./include/asm-generic/bug.h:22:0,
> >                  from ./arch/x86/include/asm/bug.h:87,
> >                  from ./include/linux/bug.h:5,
> >                  from ./include/linux/mmdebug.h:5,
> >                  from ./include/linux/mm.h:6,
> >                  from mm/page_alloc.c:19:
> > mm/page_alloc.c: In function =E2=80=98__alloc_pages=E2=80=99:
> > ./include/linux/kern_levels.h:5:18: error: '0' flag used with =E2=80=98=
%p=E2=80=99 gnu_printf format [-Werror=3Dformat=3D]
> >  #define KERN_SOH "\001"  /* ASCII Start Of Header */
>
> As Sergey already wrote. %p does not support any modification flags.

Okay, then we can't use %09pK. I've just wondered because %9pK works.

BR
Jaewon Kim

>
> Best Regards,
> Petr
