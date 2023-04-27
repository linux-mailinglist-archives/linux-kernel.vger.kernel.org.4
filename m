Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10196F0345
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243215AbjD0JVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjD0JVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:21:16 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD0EE5;
        Thu, 27 Apr 2023 02:21:14 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a6670671e3so68426785ad.0;
        Thu, 27 Apr 2023 02:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682587274; x=1685179274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uePqlkQGG6AitPdU1LbmX8G4vLuJCgYv5wvbw0sfE8=;
        b=huKAdQhokLIOhHYEIUvNPnvAMpXk+ZX9ZwJtfBiMBKeA/QGLL8VyUTkasIpZpsNUMV
         VvrQbXtBxFIloZGJFBGav/yf6JQHfj+2nXwpZIa/ORD4JuKu51FhOAtK1F9k3sP3Ruj5
         OnN88L0fnG+47QDUb7hDBXi3sfYnEB5NYU6xykBlhFzq5saSJsG+qQJSFImlpjKG5RqK
         ZJSU4O2YJqVtLCsBnF1JjkSdelb8dyOZGyVfl7TnmjFyEimYzQAMcYzav8731eBkFZM7
         ww2EgxGqyxBzgqMTLozBLTFYrDMAIazEoNOjG+q14VJfr4blc5eKme+R5eSrS8qdq5M1
         cZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682587274; x=1685179274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uePqlkQGG6AitPdU1LbmX8G4vLuJCgYv5wvbw0sfE8=;
        b=ioz8MCcQWmnL4vdxsWx6dYny51LJHv+vvcpVl620rSxeILQxH3/lcfgBlV+nAuO2NW
         CxeW8krDnnskoDIHz1v2io7Sb9raIz9ACZ9EkwcFLSIO5yI+30vs7+AkViHS422G8SHS
         eIhKfHLrZR1t/KwOdXq2AHBuuQ/hThTR4YgV1ssdCvbbE0yfgY7rVDzZC5lWskCaF3K0
         rm35lCuRkjl9FragptGWh6mFI3lEsUGuenUy6jrXuZ5wiL8fz4heU9gHBpPuWNdopzyr
         ZgJwSk5MxYM7wiVuNFGnEQyIKEJrqgJB2FF3L5N13AcL6WVN1kqOrLwfjRmmXXWlK4Fo
         QruA==
X-Gm-Message-State: AC+VfDzB7Zu/EIyokGiZRTydeZyNN+HbjOsebd10Q1Lg3GOtzerQwGHz
        QqZYk2fAh2jB9B7EeYhwj5c1ilWB96MvX7y3R+ZGukVVqwA=
X-Google-Smtp-Source: ACHHUZ5sk9omXcS/1gUiy/cbZ1CnepPuNVKYPJaAtmR4NnzQRU685UJOfiBe7o+uMCJF2c4p7lcEzoTKBTZieTO8dMU=
X-Received: by 2002:a17:903:228b:b0:1a6:6d9f:2fc9 with SMTP id
 b11-20020a170903228b00b001a66d9f2fc9mr973492plh.30.1682587274014; Thu, 27 Apr
 2023 02:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
 <87cz3tylwx.fsf@mail.concordia> <CAABZP2zr=jypD7w_o18o95QEj1nkFugLcNH5sbuSAY-caBQoeQ@mail.gmail.com>
 <CAABZP2xVCQhizytn4H9Co7OU3UCSb_qNJaOszOawUFpeo=qpWQ@mail.gmail.com> <87v8hixbql.fsf@mail.concordia>
In-Reply-To: <87v8hixbql.fsf@mail.concordia>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Thu, 27 Apr 2023 17:21:02 +0800
Message-ID: <CAABZP2z=xu+07-y5fqFLidZz1VpSgrSwXa1mFHPb=b3Ezr3OtA@mail.gmail.com>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 11:09=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.=
au> wrote:
>
> Zhouyi Zhou <zhouzhouyi@gmail.com> writes:
> > On Tue, Apr 25, 2023 at 2:01=E2=80=AFPM Zhouyi Zhou <zhouzhouyi@gmail.c=
om> wrote:
> >> On Tue, Apr 25, 2023 at 6:07=E2=80=AFAM Michael Ellerman <mpe@ellerman=
.id.au> wrote:
> ...
> >> >
> >> > There's 12.2.0 here:
> >> >   https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_=
64/12.2.0/
> >> >   https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/ppc6=
4le/12.2.0/
>
> > powerpc64le-linux-gnu-gcc-12 cross compiler on my Ubuntu 22.04 does
> > not seem to have that issue as gcc-10 does
>
> OK. So so far it's only that GCC 10 that shows the problem.
>
> If you have time, you could use some of the other versions to narrow
> down which versions show the bug:
>
>   https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/ppc64le/
>
> There's an 11.0, 11.1 and 11.3 there, as well as 9.5 and so on.
GCC test results (Tested on PPC VM of Open Source Lab of Oregon State
University)
gcc 9.4 (ubuntu native):          positive, show bug
gcc 9.5 (download form [1]):   positive, show bug
gcc 10.1 (download from [1]): positive, show bug
gcc 10.3 (download from [1]): positive, show bug
gcc 10.4 (download from [1]): positive, show bug

gcc 11.0 (download from [1]): negative, no bug
gcc 11.1 (download from [1]): negative, no bug
gcc 11.3 (download from [1]): negative, no bug
gcc 12.1 (download from [1]): negative, no bug
gcc 12.2 (download from [1]): negative, no bug

[1] https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/ppc64le/

I am very happy to cooperate if there is further need ;-)
Cheers
Zhouyi
>
> There's
