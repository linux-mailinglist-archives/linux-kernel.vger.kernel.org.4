Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30E6604F3B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiJSR7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiJSR7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:59:01 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878081CD6B1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:59:00 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id f205so10634347yba.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5qHi6nHuKOfTP8VfwA/3L86+MJKtgh8T4LGj4c4RHw=;
        b=RfiBykGYswiG2vh8XMUmoLM74qAx5iJOEWUMd5Wtj8Yp8nrAk8j4By7i2dsHjBxjgb
         tGEEAxp6QuPLXlwbcCsZoscO5zafgPB7CxvCsiVWHoYW230QZSClPC6nC+RC5DaUT346
         W98lfsbJFxh5fLZLY+S0cewDtjJd9ViR16NEzMeO8E2CELEDquTw3JlbpySt+LF9v8xu
         74cL+Jxsrfp8588RAPFJIK5ursfoWQJr8USrp5hmZxy3YEMs2zKU33qLjowdAeouhhHy
         +pphZCXara/jRuW64fh6o0939nY93ikjJmL5P72xDFafy/M5DDpyv7G8X+VxOWqq84VP
         AKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5qHi6nHuKOfTP8VfwA/3L86+MJKtgh8T4LGj4c4RHw=;
        b=E6LH6FUZAjsMznbMcJYuUDfPtlW3+9TzfRhSwzyvXVFX/Mzics0U0Nph+zocTdfuSa
         1c5yrM92I1gb3o5MIJ90in/3IeOKLpzMilaZSH+Yww7qGCszySUvjwGbs8fJ4eLLtP4s
         iPMov0FPcy9jMzcBD+7t3cWLVhuz+NAXVvLSHcJpoTbO197C/18t6EstwlAb/evwk2h3
         Su2wZMRPvtgNC6T2WFrHaZXfC3GkxKmtw9LoSkXaL8l0fExllRaTkJE51oIovPAmmAmt
         SzFTxdrk5u3NTNtyXlXYr5XR1k/PlnfK3I2PxUmaWCu+a8LTiqKBiFQ0io28oHv7oiJ1
         n9Jw==
X-Gm-Message-State: ACrzQf2bSu0dsc8kRSouuQXX5kkSynNlXTAe+1sfzncxIlcIKktmVZw6
        32/zczKt9GyoNnwWfQmRmG4tWMMbOn72v0iUPW1pQA==
X-Google-Smtp-Source: AMsMyM59+L+KMwxfbImKjoRVlkgY8srfuJQpvYqOIm3ItZkiLy2MZkIg8zdS6EYzdbHm3Ex62iXEx47Jxg1tHbxXzc0=
X-Received: by 2002:a05:6902:305:b0:6c3:b4d6:7a04 with SMTP id
 b5-20020a056902030500b006c3b4d67a04mr7524830ybs.93.1666202339610; Wed, 19 Oct
 2022 10:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220915150417.722975-19-glider@google.com> <20221019173620.10167-1-youling257@gmail.com>
 <CAOzgRda_CToTVicwxx86E7YcuhDTcayJR=iQtWQ3jECLLhHzcg@mail.gmail.com>
In-Reply-To: <CAOzgRda_CToTVicwxx86E7YcuhDTcayJR=iQtWQ3jECLLhHzcg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 19 Oct 2022 10:58:23 -0700
Message-ID: <CANpmjNMPKokoJVFr9==-0-+O1ypXmaZnQT3hs4Ys0Y4+o86OVA@mail.gmail.com>
Subject: Re: [PATCH v7 18/43] instrumented.h: add KMSAN support
To:     youling 257 <youling257@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 at 10:37, youling 257 <youling257@gmail.com> wrote:
>
>
>
> ---------- Forwarded message ---------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A youling257 <youling257@gmail.com>
> Date: 2022=E5=B9=B410=E6=9C=8820=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=
=8D=881:36
> Subject: Re: [PATCH v7 18/43] instrumented.h: add KMSAN support
> To: <glider@google.com>
> Cc: <youling257@gmail.com>
>
>
> i using linux kernel 6.1rc1 on android, i use gcc12 build kernel 6.1 for =
android, CONFIG_KMSAN is not set.
> "instrumented.h: add KMSAN support" cause android bluetooth high CPU usag=
e.
> git bisect linux kernel 6.1rc1, "instrumented.h: add KMSAN support" is a =
bad commit for my android.
>
> this is my kernel 6.1,  revert include/linux/instrumented.h fix high cpu =
usage problem.
> https://github.com/youling257/android-mainline/commits/6.1

What arch?
If x86, can you try to revert only the change to
instrument_get_user()? (I wonder if the u64 conversion is causing
issues.)
