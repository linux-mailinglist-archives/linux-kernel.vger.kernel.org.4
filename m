Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7976A738F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjCASh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCAShX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:37:23 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DCC4C6C4;
        Wed,  1 Mar 2023 10:37:18 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id t39so1318709ybi.3;
        Wed, 01 Mar 2023 10:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677695837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXIhVQ/bgM45ZbcNkWGFSNZKutp7wLJbL2UeEMpISOo=;
        b=mpz0Cwy0pNTRyqy9B3uGUkmNxnaUI2XcciZmEMBYZqz2EP8inCItMClzR8JQ/TiC7F
         r7oKwLL1S8UWmQZd+l6fbuc2t208X43PWwp8+b7Lu0DfPUlKAKw/ARlW7PkRaBaEFcUO
         DTxe4n7AU4BdWbofhtPYSUrGbA3SvAx80qWh/OTHeCrqNmVoWCGuRNKqd3pEqpHF4U4c
         SEVD6hEgYLvO7T3s27VJ5gg6Je/YERKItGiuxXTEzZE7Hp7Spw79PovqnYTilKvjHPGe
         iz+KhrgfBaQq4G24lb4d9+rDgU4ngEN8+83IIR/5uqJjdDfkOlRd4f1WNE3qL+UVADdQ
         8jFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677695837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXIhVQ/bgM45ZbcNkWGFSNZKutp7wLJbL2UeEMpISOo=;
        b=BehVZXg4TDMF/4Y4TTmj9x5F2eJFueVhRK4ZElBrgkzQFRw2ZfZPsDEmK6ReZqhH2n
         e1GgEuJdECXxVz2NPFBHvvBVDvRr2fPk2DIKNI4j4jKXBiNLrgoDtFYtHAtbPYyA31e7
         rlrV/xFfoReO94PLJFNG2G2X8Y7p4uwdMk5djb/i+4TRTXUOyWx2PXaUIlyYPFnv4G2k
         xZUJz7UXKriogyi9VgQW8oYJ1hv3niyGBDadbuCL086sNLv4xgKeN6o1AOcQ8BmHbApW
         ndrIUUeukh2XsRcypDIZw3H+5TC/xSUQ9N4xtrUhUsrVa9xmw1saBotgfckBaPfCYyV2
         sd8A==
X-Gm-Message-State: AO0yUKWPziD773xVrMnty6btLsrgjgdrFCJj9PSj4TSmdlgMs7Dx6uxF
        oN8ji2+oudSpaZwrgcsSZBPGqaKq2ihQRGMEDxUrRByDAVpYmA==
X-Google-Smtp-Source: AK7set9UGS0aNGKqz4wtx8MPr8UtA4qmkKoPzp7mwhlnwb+847jMxlnfdsWIZPCxSHK6VcLnkv7GuoiuLJkcQC92Erc=
X-Received: by 2002:a5b:b8d:0:b0:8f3:904a:2305 with SMTP id
 l13-20020a5b0b8d000000b008f3904a2305mr2549187ybq.2.1677695837244; Wed, 01 Mar
 2023 10:37:17 -0800 (PST)
MIME-Version: 1.0
References: <20230228175929.7534-1-ubizjak@gmail.com> <20230228175929.7534-4-ubizjak@gmail.com>
 <20230228164346.0691bb11@gandalf.local.home> <CAFULd4aGx=kGYYUz0BkFJz3abz97WOwDEgFHAOocT8SWT2oX-Q@mail.gmail.com>
 <20230301111850.768f8526@gandalf.local.home> <CAFULd4YePGAqxpq0kJMnNHkqqkL9HEnEz1ud9kNrae5wqpRVbA@mail.gmail.com>
 <20230301131831.6c8d4ff5@gandalf.local.home> <20230301132839.43b51b4e@gandalf.local.home>
In-Reply-To: <20230301132839.43b51b4e@gandalf.local.home>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 1 Mar 2023 19:37:06 +0100
Message-ID: <CAFULd4bu07FnVEtRPB77hAEdm_Qyx9dH26JYx9U8q+3w6BBo8A@mail.gmail.com>
Subject: Re: [PATCH 3/3] ring_buffer: Use try_cmpxchg instead of cmpxchg
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
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

On Wed, Mar 1, 2023 at 7:28=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 1 Mar 2023 13:18:31 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > I am leaning to just taking this, and hope that it doesn't cause proble=
ms.
> > And I would really love to change all the local_cmpxchg() to
> > local_try_cmpxchg(). Hmm, I wonder how much of an effort that would be =
to
> > implement those?
>
> I see that you were the one that added the generic support for
> try_cmpxchg64() and messed with all those generated files. Care to add on=
e
> for local_try_cmpxchg() ;-)

I already have a half-written patch that implements local_try_cmpxchg.
Half-written in the sense that above-mentioned scripts generate
correct locking primitives, but the fallback code for local_cmpxchg is
a bit different that the fallback code for cmpxchg. There is an effort
to unify all cmpxchg stuff (cmpxchg128 will be introduced) and I think
that local_cmpxchg should also be handled in the same way. So, if
there is interest, I can find some time to finish the infrastructure
patch and convert the uses. But this is quite an undertaking that will
take some time.

Uros.
