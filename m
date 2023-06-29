Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35510741FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 07:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjF2F13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 01:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjF2F1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 01:27:24 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14B2130;
        Wed, 28 Jun 2023 22:27:23 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fa96fd79feso2858725e9.2;
        Wed, 28 Jun 2023 22:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688016442; x=1690608442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nb/+8NCfArg6/OwRXIZUX1VK339Vjv02yByiLdkLvRg=;
        b=PUc8Qi4u7Oo46LKO39gqUKMO5LrO64Dsj0KdWXCwVfpxRwNvUnKVNwbuKHBT+dRfh9
         pKCd7gl31l2PN7tShO+Gy5Y+5/+rooWbT8PN8r2vommJU0JXMjolLfJLj1G7YbN83EUB
         j1dlvz3/qN6HmBMrjE8Z/Z5sxD/jmQq6mXtrwBmFCJRoaq4qfBMUIwaoFYpoiuixAAkF
         05jOxnA7uvHGbppiJzNMgedK7CSVF9jCJM/P2i52tg72KTUW1auQ0VMZuk4unZvcq1ZP
         qRMAsKR3F3BzlKsPnqqAYWoRj7Fp8mHg6pBe5X7ACP6Sut/YNku1+CnQrB2EATvt1/pF
         0qUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688016442; x=1690608442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nb/+8NCfArg6/OwRXIZUX1VK339Vjv02yByiLdkLvRg=;
        b=MAOb0CtAUXsaCVhsNGJpEATANNtuHXOwZNR5idgc3uw3zvS7vZeCuE/yCmIZeMrG8s
         hDewWB0sakh4jCgQsMw2IFLcifW4+i43yfCwhM30PDlM/q6eBGqvJTcFwMnxqa131vI2
         Tje+AEarI595Pp78RKiKmktJct2O4Is6G2/1ql0lysjKZ51RJ6wuWEzj2JRCFH91gIaX
         RgX5kRF5ozOM/dNPhQUqVeNtTP6LdX4QsVYsNuUS7NsVfI6TKV4AXwl5EMwYwmrc5vgH
         zdnzQMaL4csbynWmHrYObCZMqLqJSLB1RRGj8KBxSEO4iOnAWkQfVisg9p4hNIofoh3w
         YgGw==
X-Gm-Message-State: AC+VfDyyVH4U67v+3iADthnSg1thcqAxEiR1QIsdFvdup9dMjGWGOoRU
        tyO7VUjAzLYzl/kyiuDm7BwiE6ow9Rua29kXDqQ=
X-Google-Smtp-Source: ACHHUZ4UxRmU0P/5PcDI8m58YC9isQGEt5VjGcvo9lvB5/BdrHGyCBJigss3lgQ8gPqn0WPZclGexfie1jotYHhLer0=
X-Received: by 2002:a1c:791a:0:b0:3fa:76e2:e6d5 with SMTP id
 l26-20020a1c791a000000b003fa76e2e6d5mr15859506wme.37.1688016441784; Wed, 28
 Jun 2023 22:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230629124055.7edf4493@canb.auug.org.au>
In-Reply-To: <20230629124055.7edf4493@canb.auug.org.au>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Wed, 28 Jun 2023 22:27:09 -0700
Message-ID: <CANaxB-z0gLxOU-EVnag=pi3cC164stbOVOMmaGMwNs_g43z9_w@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the seccomp tree
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrei Vagin <avagin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
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

On Wed, Jun 28, 2023 at 7:50=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> After merging the seccomp tree, today's linux-next build (native perf)
> failed like this:
>
> make[3]: *** No rule to make target '/home/sfr/next/perf/bench/sched-secc=
omp-notify.o', needed by '/home/sfr/next/perf/bench/perf-in.o'.  Stop.
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [/home/sfr/next/next/tools/build/Makefile.build:140: bench] =
Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [Makefile.perf:682: /home/sfr/next/perf/perf-in.o] Error 2
> make: *** [Makefile.perf:242: sub-make] Error 2
> Command exited with non-zero status 2
>
> Presumably caused by commit
>
>   df614e369b5c ("perf/benchmark: add a new benchmark for seccom_unotify")

tools/perf/bench/sched-seccomp-notify.c should be in this commit too.
Probably something went wrong when the patch was applied. I've checked
that the patch contains this file:

https://patchew.org/linux/20230308073201.3102738-1-avagin@google.com/202303=
08073201.3102738-7-avagin@google.com/

Kees, could you take a look at this?

>
> This is a native build of perf on a PowerPC 46 bit LE host.
>
> I have used the seccomp tree from next-20230628 for today.
>
> --
> Cheers,
> Stephen Rothwell
