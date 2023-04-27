Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944D66F0774
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243828AbjD0Oao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243893AbjD0OaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:30:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5503C29;
        Thu, 27 Apr 2023 07:29:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-24b29812c42so6169605a91.0;
        Thu, 27 Apr 2023 07:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682605784; x=1685197784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrjVe+GZ/aYuuygp5YMWvVf8Vcfas6AR9IpieFbpkS0=;
        b=cXRvpI9LxCPwg+kylqNX0WHyH+4TIOKTAwHF9DnkYXVQDJ+8rprEmQMiul2qCbscAf
         Af80Tm+ly+BXlUbPXkTb5WYgYcNee2xf2YA9hlvx2sVbOQ5Bi4PCoiNkayUKmRCMMxAG
         c3VISC2KkbS2OsOFIwc3gKPTlfuXT2bzNxBX0ikUxwOVeiFlYzk9QfiQ3bvWgQOWFiCn
         rOVSzP8H/ulCf9x+r3O+awGtcqihKr2UsvANh9XkfZf5pW1lS1ptgwNpiXTOomHl7xcM
         sOYGT3vz+MyFbCTcwu1O/1PnqNM+GaF+a8Ab/p7OgKcSGjm2njHVeRIyN7Qy2tWc1TAJ
         dzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682605784; x=1685197784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrjVe+GZ/aYuuygp5YMWvVf8Vcfas6AR9IpieFbpkS0=;
        b=bBb8yJLW7JDAYgTzie6JFp302jn6CnCbWAXpUe9sIHL/v5pcgeEZNWTxx37up/AbSn
         ihm2oV3/U6SP1E2McxqCICRfjZf2/6cNZu9FmhrQoke+rGd2EInttsDnzjCd3HanTn0D
         /hmQh/EpTw0JS0aDfUu5gIFVY5cTFAeL9zYotqphyUIZaX29j3nYzylgv0zIxtW8dGQ9
         YWOdXGEF8RklnQ9qnKn6QKS5+uHpw415uqkyf5rg/TDeofIGRM0Sy0ebB0v5FTfvHVCf
         +UB7nYxtXd2TLGksj/7eXNHp9KEFNXG1dVoWlZW2Lz+R8FIFw7OsCDcY+idcoFECQoPt
         oUiw==
X-Gm-Message-State: AC+VfDzQQBCZ3rsiVbQCyUe/84rIgAshr5YWdgaePQJHRtOL+G+3JSSX
        ZeNX+cvqUbjFkEgBoKMKI673O7M4V1+ICe/gliz0qV+GKI4awA==
X-Google-Smtp-Source: ACHHUZ6hdTNgQQwv2t44avCCrWR8mbrKKdu0cTf/4gXM14sjtPsKe8xWmsE4xn4ram6UUVNxmfMLcyEIXG1GWQzLnlA=
X-Received: by 2002:a17:90a:d513:b0:247:6edf:e934 with SMTP id
 t19-20020a17090ad51300b002476edfe934mr1886414pju.42.1682605783915; Thu, 27
 Apr 2023 07:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
 <87cz3tylwx.fsf@mail.concordia> <CAABZP2zr=jypD7w_o18o95QEj1nkFugLcNH5sbuSAY-caBQoeQ@mail.gmail.com>
 <CAABZP2xVCQhizytn4H9Co7OU3UCSb_qNJaOszOawUFpeo=qpWQ@mail.gmail.com>
 <87v8hixbql.fsf@mail.concordia> <CAABZP2z=xu+07-y5fqFLidZz1VpSgrSwXa1mFHPb=b3Ezr3OtA@mail.gmail.com>
 <87wn1xquq0.fsf@mail.concordia>
In-Reply-To: <87wn1xquq0.fsf@mail.concordia>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Thu, 27 Apr 2023 22:29:32 +0800
Message-ID: <CAABZP2yS5=ZUwEZQ7iHkV0wDm_HgO8K-TeAhyJrZhavzKDa44Q@mail.gmail.com>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NORMAL_HTTP_TO_IP,
        NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 10:13=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.=
au> wrote:
>
> Zhouyi Zhou <zhouzhouyi@gmail.com> writes:
> > On Thu, Apr 27, 2023 at 11:09=E2=80=AFAM Michael Ellerman <mpe@ellerman=
.id.au> wrote:
> >>
> >> Zhouyi Zhou <zhouzhouyi@gmail.com> writes:
> >> > On Tue, Apr 25, 2023 at 2:01=E2=80=AFPM Zhouyi Zhou <zhouzhouyi@gmai=
l.com> wrote:
> >> >> On Tue, Apr 25, 2023 at 6:07=E2=80=AFAM Michael Ellerman <mpe@eller=
man.id.au> wrote:
> >> ...
> >> >> >
> >> >> > There's 12.2.0 here:
> >> >> >   https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x=
86_64/12.2.0/
> >> >> >   https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/p=
pc64le/12.2.0/
> >>
> >> > powerpc64le-linux-gnu-gcc-12 cross compiler on my Ubuntu 22.04 does
> >> > not seem to have that issue as gcc-10 does
> >>
> >> OK. So so far it's only that GCC 10 that shows the problem.
> >>
> >> If you have time, you could use some of the other versions to narrow
> >> down which versions show the bug:
> >>
> >>   https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/ppc64l=
e/
> >>
> >> There's an 11.0, 11.1 and 11.3 there, as well as 9.5 and so on.
> > GCC test results (Tested on PPC VM of Open Source Lab of Oregon State
> > University)
> > gcc 9.4 (ubuntu native):          positive, show bug
> > gcc 9.5 (download form [1]):   positive, show bug
> > gcc 10.1 (download from [1]): positive, show bug
> > gcc 10.3 (download from [1]): positive, show bug
> > gcc 10.4 (download from [1]): positive, show bug
> >
> > gcc 11.0 (download from [1]): negative, no bug
> > gcc 11.1 (download from [1]): negative, no bug
> > gcc 11.3 (download from [1]): negative, no bug
> > gcc 12.1 (download from [1]): negative, no bug
> > gcc 12.2 (download from [1]): negative, no bug
>
> Awesome work.
Thank you for your encouragement ;-) ;-)
>
> How are you testing for presence/absence of the bug? By running your
> test and seeing if it crashes, or by looking at the generated code?
Both
I use gdb ./vmlinux; gdb)disassemble srcu_gp_start_if_needed to look
up the generated assembly code
and
I use [1] to see if it crashes, if there is a bug, it always crashes
very quickly (within 3 minutes)
[1] http://140.211.169.189/0425/whilebash.sh

Cheers
>
> cheers
