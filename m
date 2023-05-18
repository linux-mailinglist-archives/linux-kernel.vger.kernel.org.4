Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB08F707C28
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjERIhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjERIhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:37:11 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13E4198B
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:37:08 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-76fd0036c7fso575857241.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684399028; x=1686991028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJlrBazb5W6pvqAkGpSmYAQfm9m/AW9wlnqOl8N63jA=;
        b=aUqQAYgqVLTDsX91gOAdoeg2c7O+sQtrXK0F3DicTqkElYHBH1hFeJ+UvtNUxL5RGx
         GAX1pyIyWp6fiEqyj4wBOzLpGQsvntdgNk3bwbKu+lyb3hix47Ds/eEcsremHR/WgBfx
         NI/xZocGbp+47aWh3VzVI84kVMfcUM5kTT3QMfh59P40S/AlZvbj1NlL1lbQQz3lqcmc
         f2JuGWDtcNS677keV+s4gvF2SgigYrQDC3j0z8u2Y0EqCFF5Co22j2fJ+EppWujJ1H5G
         frsm+0hjwsQ8iY7FY0biJqcXaXKS1/d7XxOr5jGwe9JBAoM6RQ2RghRyJ4XPWb6EqIdF
         EMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684399028; x=1686991028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJlrBazb5W6pvqAkGpSmYAQfm9m/AW9wlnqOl8N63jA=;
        b=YQRymgVDVSg9vksVmQo7pfBXXVmhVdvCh2YcrSRtXwE8/BZ6qitLJcPM3Bg3IvVAPl
         JU/VC6ke0fD4FFYzEgCopLL+DDxHN9say0Iz5MSZ5XLQouIinim6MjLJaRKBY53H/rzA
         sdR4Jjj4SbwW4l9bjBlMnwtVNgHekDLYiFL9bFizHc4lHQ1/5l4uB1cd8AitF8niR4fU
         klHu3XqCoofrosfX6lI2rY6IdFtNvltII3gRW1WBMzSrU6bafBBCy/3nHqkF7S/dtmQL
         WKKzXm/rqbzBM0o8+edaZONuV+u1NHjksQkNodpv5n3C5BodQ2gDec5eYey2XlQab509
         1vSw==
X-Gm-Message-State: AC+VfDw8k7dFN6Q+1Xkq3X0ljdTOZb9FEjIrfZA6aS7kWtrEPw5dPzp1
        CnoXhyjXesB2H9CMbBpoXWihMcdFtWsVJUDhCb/OPQ==
X-Google-Smtp-Source: ACHHUZ7ig3VpQaX40XgZXm3kBYaMBK/V4oJELCdhBzUkMK83KsDIFfcv84Lfhmefn0IR/eyuHjpbdZSk6tJT2wdRQYA=
X-Received: by 2002:a67:fac8:0:b0:42e:6185:8c94 with SMTP id
 g8-20020a67fac8000000b0042e61858c94mr213833vsq.29.1684399027714; Thu, 18 May
 2023 01:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvhPgoP57ip1cW5TaWJfkbkHA2SZqd5fFoTJ7rDGA138w@mail.gmail.com>
 <CAKwvOdkABkajMqBS=xcHxXUTQGXbTN3tj1GcPqpGgGkmAGLkDA@mail.gmail.com>
In-Reply-To: <CAKwvOdkABkajMqBS=xcHxXUTQGXbTN3tj1GcPqpGgGkmAGLkDA@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 18 May 2023 14:06:56 +0530
Message-ID: <CA+G9fYvVN2XwG1ouX75aihO727j6=YGVf5g3mbfBcjs1o87DJA@mail.gmail.com>
Subject: Re: next: i386-boot: clang-nightly: failed - intermittently - BUG:
 unable to handle page fault for address: 000024c0
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     x86@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 at 23:42, Nick Desaulniers <ndesaulniers@google.com> wr=
ote:
>
> On Wed, May 17, 2023 at 8:21=E2=80=AFAM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > Linux next-20230517 build with clang nightly for i386 boot fails interm=
ittently.
>
> Keyword: intermittently. That will make tracking this down fun.
>
> Our CI also hit a boot failure on tip/master with the same splat:
> https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/4=
998374271/jobs/8957285746
> Though the CI pulled down a SHA
> 0932447780e1f9a43bf68ef7fe3d9b41b46d58fc
> which looks weird on
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=3D=
0932447780e1f9a43bf68ef7fe3d9b41b46d58fc
> >> Notice: this object is not reachable from any branch.
>
> That this failed in -next and -tip in the same way makes me wonder if
> something affecting this is coming in via -tip? Maybe the splat looks
> familiar to x86 folks?
>
> I haven't been able to reproduce locally when my machine is relatively
> load-less.  If I do a kernel build in the background, I was able to
> get QEMU to hang, but without any splat. That was using tip/master @
> f81d8f759e7f.
>
> Naresh, when you say "intermittent" do you have any data on the
> relative frequency of this boot failure? (Also, please make sure to
> use llvm@lists.linux.dev in the future; we moved mailing lists years
> ago).

Noted:
It is reproducible only 3 times out of 100 runs.

>
> Looks like our CI report linked above has an additional splat though
> via apply_alternatives and optimize_nops.
>
> >> [ 0.166742] Code: Unable to access opcode bytes at 0x36.
>
> Peter, that smells like perhaps either:
> commit b6c881b248ef ("x86/alternative: Complicate optimize_nops() some mo=
re")
> commit 6c480f222128 ("x86/alternative: Rewrite optimize_nops() some")
>
> Looks like BP committed them May 11; maybe just recently they were
> merged into tip/master?
>
>
> >   - i386: boot/clang-nightly-lkftconfig - failed
> >

- Naresh
