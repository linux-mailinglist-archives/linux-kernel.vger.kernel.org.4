Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6DE608432
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 06:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJVEPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 00:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJVEPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 00:15:01 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3D03FF3A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 21:14:56 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a25so6279686ljk.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 21:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzRG8DueJFVBMoBP3WLGrZ36/yY2O+ekECOxt59Gcj0=;
        b=mGit/OKfyUTcqGootPlZvse7XEQUFvO23uFrEXaDR5RVDaIlVGo6ZEa5Oat75+yNrt
         uh/9w+hk9w7cgMNJ9Vg946Zvdsg/YcyUfsvog0yB4eKVbtn/Xb/tmHTk6THA5w5jc+b1
         iOFMkUh/xpBzGy37JyyoMhDjAaUDj8n2tinf110KgtA2NCTBhEd2+4jqWc0wFfOp45sr
         LxNiFLkDBd/IM96oF/3p4SPDEFWNxSCgV4FYTtA3A5sFougMfCMfYxER2DunRAh6cILs
         UH38cqcZc3sishuc5Cg4QXgRnP48/x+lR7ejK6KSKMrGMmiLF/c2KaZuI/1B0imqriFf
         2abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzRG8DueJFVBMoBP3WLGrZ36/yY2O+ekECOxt59Gcj0=;
        b=c92JlR8o7FXHH0XOZOYoUKifeuUsmggZdN9wykY1qEV22G9ethDKIKdbjQYAwG3IOH
         TgfqAoq3gorhZHOs0YP3OfGcj51oGdVVe2yVCalqW8aYruLjsxcepNdY45HIqSKgXvI1
         MF33OGylJEV5iruRViTiEoDgnZANZ30YFwCrok9eKsPXdg2vDFiOKK6l5dRAFOCjEiGR
         NYss3pRCoSzCbisoVNj2R1GuVEF5Pvm151is4GZwynnRlUBlwrv+R02L2K5RWPd9WsYW
         z8sq8655SZTvsgOH/xOhONPy9sSONjm1E6GZhC6beI/EdZ08oMg5lzafZchVEKhGgt9E
         xzZQ==
X-Gm-Message-State: ACrzQf1EDkjhI9smBbTMbr979fz1dPT9HFW4nr+ChIbLipZfsJFLQprd
        o5HL/AguNRuyka7qk0M0ptxZYuxDigHbGH5YZ1oDEA==
X-Google-Smtp-Source: AMsMyM6is3k+7+BEm08+a8A6LvnUfO9hY+kI1H+PV7dz0OFzVAoSBGy+rZuwbEe/8Y4w3ywLfIqQulCk8Ffi/ojOdHM=
X-Received: by 2002:a2e:9256:0:b0:26e:197d:3ff6 with SMTP id
 v22-20020a2e9256000000b0026e197d3ff6mr8269040ljg.518.1666412093751; Fri, 21
 Oct 2022 21:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <Y1LBGZPMfCZ8A1bl@FVFF77S0Q05N> <CABCJKuf=OB_3ZR_rwaG3H5kHKmTTDk+sihjJXYmyWgZjUX2yTQ@mail.gmail.com>
In-Reply-To: <CABCJKuf=OB_3ZR_rwaG3H5kHKmTTDk+sihjJXYmyWgZjUX2yTQ@mail.gmail.com>
From:   Fangrui Song <maskray@google.com>
Date:   Fri, 21 Oct 2022 21:14:41 -0700
Message-ID: <CAFP8O3JuC9HL1-G23vGJO=jjN7Tsgz7c8TB1_F6UQ-MqCyGNLQ@mail.gmail.com>
Subject: Re: kCFI && patchable-function-entry=M,N
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Joao Moreira <joao@overdrivepizza.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
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

On Fri, Oct 21, 2022 at 10:39 AM Sami Tolvanen <samitolvanen@google.com> wr=
ote:
>
> On Fri, Oct 21, 2022 at 8:56 AM Mark Rutland <mark.rutland@arm.com> wrote=
:
> >
> > Hi,
> >
> > For arm64, I'd like to use -fatchable-function-entry=3DM,N (where N > 0=
), for our
> > ftrace implementation, which instruments *some* but not all functions.
> > Unfortuntately, this doesn't play nicely with -fsanitize=3Dkcfi, as ins=
trumented
> > and non-instrumented functions don't agree on where the type hash shoul=
d live
> > relative to the function entry point, making them incompatible with one=
 another.
>
> Yes, the current implementation assumes that if prefix nops are used,
> all functions have the same number of them.
>
> > Is there any mechanism today that we could use to solve this, or could =
we
> > extend clang to have some options to control this behaviour?
>
> I don't think there's a mechanism to work around the issue right now,
> but we could just change where the hash is emitted on arm64.
>
> > It would also be helpful to have a symbol before both the hash and pre-=
function
> > NOPs so that we can filter those out of probes patching (I see that x86=
 does
> > this with the __cfi_function symbol).
>
> Adding a symbol before the hash isn't a problem, but if we move the
> hash and want the symbol to be placed before the prefix nops as well,
> we might need a flag to control this. Fangrui, what do you think?
>
> Sami

Since the kcfi code expects the hash to appear in a specific location
so that an instrumented indirect jump can reliably obtain the hash.
For a translation unit `-fpatchable-function-entry=3DN,M` may be
specified or not, and we want both to work. Therefore, I agree that a
consistent hash location will help. This argument favors placing M
nops before the hash. The downside is a restriction on how the M nops
can be used. Previously if M>0, the runtime code needs to check
whether a BTI exists to locate the N-M after-function-entry NOPs. If
the hash appears after the M nops, the runtime code needs to
additionally knows whether the hash exists. My question is how to
reliably detect this.

If there is motivation using M>0, I'd like to know the concrete code
sequence for `-fpatchable-function-entry=3DN,M` and how the runtime code
detects the NOPs with optional hash and optional BTI.


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
