Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D896EFFD9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 05:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242760AbjD0DdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 23:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241612AbjD0DdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 23:33:00 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368A43AAA;
        Wed, 26 Apr 2023 20:32:59 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64115eef620so1948941b3a.1;
        Wed, 26 Apr 2023 20:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682566378; x=1685158378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0CJhWXjc9Fv4hAAFKH+ld0zLVP5ytWUnCfEaPqRDTc=;
        b=lvtBaUxMiigxyaMzmTBJnxw0odGQPTQH5URJbY0FrLC72eK8drm5Muv+pCT0WFogBW
         s0QUclaPKXSYDBOC4HxsIUdnBFHeAp2byxf4VX9E697YgpJYlvcKmLITZtjxOUG/jVAT
         im/W57TjVRduCYWPHtm7A/zPBYDy9kliec4595d6+mBQJyGYpYX9tqqsisVacokrErJJ
         6NbbUM+L9zho8DvQzamVn8TOzZ2UxmNBrncw3aUymrdWNoLQV8KgI9urRuNZy1Gqt4u7
         eAyLRoK5X9WLCEp+UBnJvVaITMpd2q3Hel58md2Nh7eWAq5qdRHQxbo0pjmEgNCekLSj
         7O4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682566378; x=1685158378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0CJhWXjc9Fv4hAAFKH+ld0zLVP5ytWUnCfEaPqRDTc=;
        b=DmP3AeLC6tNxcxsGbhuKB6Y+9PjcUJRUJ9TWe4TH47hQ9hGsTlDhB9xd39iqndWKkp
         W6KCz12mLiloGn0SJETGmWs6/XYNEEDTbfJeYKe8jUCBZx/7tzEXi98i+qQDGxEN8JDS
         3x48DQXB9qiS600/4Nb57NlyFhaecGfNuUXAjxMf1ooeA/q41n19vaZ/K2WMLVw56GyB
         BXxJAdy2mqcY+Ek4WV1BSXk9dn/IIkBY4zY6sJRAAgGOqvA8Vre0UsvvPLnF8932alfA
         NG0JGPO4Kfk/KAGaQs8CYa/I7JRByaliORKjtaJFVu6ouo6KDhsQF38XIBxH0N1tjmgA
         8XyA==
X-Gm-Message-State: AC+VfDzf3yJJ7U7jgecC3hg6QbhnFUYMS3gXQxxYX5vMKA3WLTT14vNC
        Ri3GkeEvKVky2Jgw8E7QHFLFHyjxgtzqRGxkBHqaeeyx4A/Zxw==
X-Google-Smtp-Source: ACHHUZ6Nc+jBcba8+mTDSK/3QCstZKna56TJ/d+4XLaIPQLWhXpOo0RnjOFs3Av2doMu8xXjjIbRuPnyW/KudXQIFQs=
X-Received: by 2002:a17:902:f688:b0:1a6:4c2b:9e7f with SMTP id
 l8-20020a170902f68800b001a64c2b9e7fmr5530219plg.1.1682566378493; Wed, 26 Apr
 2023 20:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
 <87cz3tylwx.fsf@mail.concordia> <CAABZP2zr=jypD7w_o18o95QEj1nkFugLcNH5sbuSAY-caBQoeQ@mail.gmail.com>
 <CAABZP2xVCQhizytn4H9Co7OU3UCSb_qNJaOszOawUFpeo=qpWQ@mail.gmail.com> <87v8hixbql.fsf@mail.concordia>
In-Reply-To: <87v8hixbql.fsf@mail.concordia>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Thu, 27 Apr 2023 11:32:47 +0800
Message-ID: <CAABZP2x4SiDHOCweNcanxj6v-KYmVct9E8PVUr1pxFvR4gPGqQ@mail.gmail.com>
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
The default gcc version 9.4.0 in ubuntu 20.04 (in VM of Oregon State
University) also shows the problem.
>
> If you have time, you could use some of the other versions to narrow
> down which versions show the bug:
>
>   https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/ppc64le/
>
> There's an 11.0, 11.1 and 11.3 there, as well as 9.5 and so on.
I have time ;-), and am very glad to try the above versions to narrow
down which version shows the bug ;-)

Cheers
Zhouyi
>
> There's
