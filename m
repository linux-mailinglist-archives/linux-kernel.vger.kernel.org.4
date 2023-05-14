Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5E3701E3A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 18:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjENQZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 12:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjENQZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 12:25:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A721BE2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 09:25:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-965ac4dd11bso2366435966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 09:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684081514; x=1686673514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/4krLSql0Gjrdp6JrkRiPc1flJKbcl3pisqpCHUUFk=;
        b=eSCC+3txcVCaqY1rjjnIVVTa1W38lCxZeD2RkKBUDykUFYSUCk/lQoTxhnWFqG3+Fi
         EGOI0eSjsFz7TlBskVBq8wBUGlhithYPsfzzOPsMc+Jes2dwcsB21Zp0I0Wh0OZ5g5pU
         cxWAqptRMjQtruI16wtNi9KFMgwZz2yNPwfHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684081514; x=1686673514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/4krLSql0Gjrdp6JrkRiPc1flJKbcl3pisqpCHUUFk=;
        b=P6rUTuzSI8WWd9D9+NgYm8F51TV4iH9sFDQTXAn5/qiB3w8rm3sgl9t8+YMyfiQvpp
         9bU0ZKtI92Nj/u0eSUPmiUERTEcvS+i7BXxlb1lq0PwtlpIVlt7nLPZ3xLT6iXR28D9v
         GI5bfluvjMdcUR/UXy6zLhK1458Jn5go+iyJlxqa3frf/4GcDR5BtJBd2UOqV/eej9KN
         mKPHfvIplgSH9kHYXyz8IVIYKgyFr17c2qvlJDhnRbf6cj4OOsQdCFhZyDlR/GTXhFYu
         Brn1xznEYuJfU3SJmKzDgzF0maoUDCrOpQYVWTGLORa7vhPeBpMV8Vl92OMSZOz36JdB
         yvvw==
X-Gm-Message-State: AC+VfDz88CLohHpk6pfaAuU5dt6PS7k/E8wB399EL4kQA9hXoCrEw3S8
        6esFJUnwrLZXdvF/d0m9xMVZ613En7GTyBarQorrrQ==
X-Google-Smtp-Source: ACHHUZ53u0DndPjX2lTQwwMOorxeB3yPZNW27G8+aHb95+Smw4rVhHOsKNxhKfGxDQpC2a9xngtzgg==
X-Received: by 2002:a17:906:fe42:b0:94f:432f:242f with SMTP id wz2-20020a170906fe4200b0094f432f242fmr27524222ejb.67.1684081513763;
        Sun, 14 May 2023 09:25:13 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id ov17-20020a170906fc1100b0096aa0ca9b5fsm3733834ejb.106.2023.05.14.09.25.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 09:25:13 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-965ac4dd11bso2366432566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 09:25:13 -0700 (PDT)
X-Received: by 2002:a17:907:9496:b0:96a:ff7f:692 with SMTP id
 dm22-20020a170907949600b0096aff7f0692mr2228823ejc.68.1684081512884; Sun, 14
 May 2023 09:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <168407416011.74685.9039980276616254723@leemhuis.info>
In-Reply-To: <168407416011.74685.9039980276616254723@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 May 2023 09:24:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjVxkvY0n2ZDv=oMB4WSaz1RxQmL1DxUjwFSbBfNiUFgQ@mail.gmail.com>
Message-ID: <CAHk-=wjVxkvY0n2ZDv=oMB4WSaz1RxQmL1DxUjwFSbBfNiUFgQ@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2023-05-14]
To:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 7:24=E2=80=AFAM Regzbot (on behalf of Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> What I can't see yet though is a pull request from Russell with a fix
> from Ard[2] (in next as 2b951b0efbaa) for boot issues[3] that apparently
> break a lot of arm32 configs, which among others lead to "tons of
> different boot time errors on the syzbot arm32 qemu instance"[4].

I have that. You may not have seen it because rmk just cc's the ARM SoC lis=
t.

We also have some vhost regressions due to the move to user worker
threads (rather than kthreads), they don't seem to be on your list.
They're being worked on.

               Linus
