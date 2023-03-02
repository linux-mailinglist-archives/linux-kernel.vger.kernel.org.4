Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A156A87BE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjCBRTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjCBRTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:19:30 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6245B6E8B;
        Thu,  2 Mar 2023 09:19:29 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 82so4270708ybn.6;
        Thu, 02 Mar 2023 09:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677777568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uit9vXQN5dUsgYieCjn7laYXQPsqA8YR/x9Zxms4wJE=;
        b=pI+LgniKKi36tZwoGnshSJXnnSrErIqYS61kZx3CdEp+v8NSKvDhRPt6a5hghfztqs
         Exb96trUnaf40fDCIDeblbgUYW9XMmXLR2Sp/jbjF98oSo5WMB29LIRqXryFGvhu+ZhC
         83hmmIa29wXivsbMKfGu015i8Cl+rPvOAW5zjAK5dES3OtCY6Jpwljw8nAuEr2U7YDSY
         Oobi9Bi+2cjtuJTbQYsd109s2K7HcncMNo/NJwhk1uoQerJd1VbgLbd8BmB08ebHuxbM
         xDXOUhIRpubjhhsERXkfqyg3oRCQbjeiYAdYr6rbtbvoD+QAMKji+7PN161b6b+Mytmp
         hARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677777568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uit9vXQN5dUsgYieCjn7laYXQPsqA8YR/x9Zxms4wJE=;
        b=04a6asOu9Jb6bH+nv4H1GiexYDTA/vK9/YBWIuJ6vkzUbgCTaTqdHr2xVEKmwtv1QU
         MehaqqqZFaug4NN3QENM7mMMBGxazahjLMJ6KyhmIdgBvN6iysttqG09fyDp1QnTIWhh
         1+VLI+e2oFSWgdZAeP0zG+7OPUIvNBb+uym/iGguMSGXbQh7JQimuYFzvz5ZFrUi/Z2V
         0sOSlEZkdITvincz3y9qKAf8TPO7zCn/prW6LrDU1uHUbiU1SZNneO7hV5s02IeuErR3
         RCjAh977x3c2Du/Br08TIpPwb506FR3lWog7m4XXtTyQxKS7aMthSI4I4nHoIXGsrNbC
         ABvw==
X-Gm-Message-State: AO0yUKW2no+sZZaA2j8imxqfIYxTtuBIDugrGPtWesReMapQ3o+9Xuqf
        8TkVPehH00DOkJ+V3VhgvCeaR7o8qMFN4sgymv0iHGGHefYh9Q==
X-Google-Smtp-Source: AK7set/hNqUOCRdsVB9sYdNOfDCdQlGLUIwPFoPFBIRH3epUIEIT2aXlninuryMFbjQKgc2AltMjJK9K3vOw4UfM0/M=
X-Received: by 2002:a5b:892:0:b0:9fe:195a:ce0d with SMTP id
 e18-20020a5b0892000000b009fe195ace0dmr3934270ybq.10.1677777568205; Thu, 02
 Mar 2023 09:19:28 -0800 (PST)
MIME-Version: 1.0
References: <20230302164129.4862-1-ubizjak@gmail.com>
In-Reply-To: <20230302164129.4862-1-ubizjak@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 2 Mar 2023 18:19:16 +0100
Message-ID: <CAFULd4bw3sa01_bZ1YhtSYEdbcxvsjVraH5bdQ4-djoYnpy8Sg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Improve trace/ring_buffer.c
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
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

On Thu, Mar 2, 2023 at 5:41=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> *** BLURB HERE ***

Eh...

Here should read:

This series improves ring_buffer.c by changing the type of some
static functions to void or bool and uses try_cmpxchg instead of
cmpxchg (*ptr, old, new) =3D=3D old where appropriate.

v2: Convert only loops with cmpxchg.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>

> Uros Bizjak (3):
>   ring_buffer: Change some static functions to void
>   ring_buffer: Change some static functions to bool
>   ring_buffer: Use try_cmpxchg instead of cmpxchg
>
>  kernel/trace/ring_buffer.c | 77 ++++++++++++++++----------------------
>  1 file changed, 33 insertions(+), 44 deletions(-)
>
> --
> 2.39.2
>
