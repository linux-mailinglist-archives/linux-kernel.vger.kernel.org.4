Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422835FA290
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJJRQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJJRQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:16:29 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292F41E3E3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:16:28 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n7so10975705plp.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BN2BBjIG9zgvtnK5eGnUzK+S+KfwlGKwZqzD4HQLmGc=;
        b=p1wbnrSwuiCSeyPsFZGhXObnTivR9L9GH3dLg4z9E/vjpJ5yXMZebAY+zGjLHaS9y6
         XHi2ym+SgYMOI6HATyeFV8QJCVFTjKc/IzqC/A5944EbO1MSxyo3vKznl0UyYcVVq023
         adLtnIsDkQDwOQ/bOj3lShJ04Gn0j1QjedHVYFUV6ZRbXYsLEfQAYViKlq9oaJh+OZNn
         p0h6+iVQmXVBfVMon4bfrpn7Z2Xex+4KGOgB1AQLBscBBSXfmSPHpg6fdUElBZrANzFt
         Lq15ArkvE0lKagCmkY80cZHnff+kLf5k+nDOL3OqWf74pwAoQjLG7gdaIHNrESsbvWpm
         wvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BN2BBjIG9zgvtnK5eGnUzK+S+KfwlGKwZqzD4HQLmGc=;
        b=f+ADDiqqpJNV/rntCLYAxoaId/f8FhLqw7vrUUnCPiZWSRVxMsBvgMlTyfnp98EcYL
         rk4/d/aXF6U4RIb5asH+CeIZQXLZAnGP8f45eAzqsCIQP01S/e9FpH0PtSZ5txJ63heB
         3S0CgAQj7Ulf30OARloTO+wMy17ahxRfzMEJ2tEkMGO/94RT3Y5tAe1OMFbCcG7jBHJ3
         Sko7Z9X8Kw84YRod/dW8lkdNpJdECgVzz6gbDbDcy59Qt6Uz0NPKVsYxtypV9QRaHLN0
         mEPkUkilG4sBSb4C4l6kZWt6YvJ+eSk28zjeOWs2Si+IHmBNB8aF4TknxskOz5w2bi5H
         pBFw==
X-Gm-Message-State: ACrzQf0NyOt+gO+Du1FGBsfoVgj3FWDe2ESObgp0Lzu0dBlsapraYC+3
        r46qgYOpTTAqOZQ5x6mPggjCGr1z3heZHKbaVH6lwA==
X-Google-Smtp-Source: AMsMyM4qNu5PTYW/Lcc64zQyr2T94Q8oi+4FnkYY7RhGzfcgHDctbmqYluZw4xZwZ1kGBk7Mf6wXqO2hQBrukPfed7o=
X-Received: by 2002:a17:90b:33c3:b0:20a:ebc3:6514 with SMTP id
 lk3-20020a17090b33c300b0020aebc36514mr31204821pjb.147.1665422187452; Mon, 10
 Oct 2022 10:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <5a10dda2a06b92f040ec7a18876db4c8107b4989.1665026261.git.quic_gurus@quicinc.com>
In-Reply-To: <5a10dda2a06b92f040ec7a18876db4c8107b4989.1665026261.git.quic_gurus@quicinc.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 10 Oct 2022 10:16:16 -0700
Message-ID: <CAKwvOdmFsdn_QLCM6R88YYqAh43G3nT4tjJQ0_=sucQoX+EjjQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] scripts/clang-tools: Create array of checks to exclude
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        Elliot Berman <quic_eberman@quicinc.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Oct 5, 2022 at 8:24 PM Guru Das Srinagesh
<quic_gurus@quicinc.com> wrote:
>
> Create array of clang-analyzer checks to exclude for ease of adding
> more. This is per the suggestion in an earlier discussion [1].
>
> [1] https://lore.kernel.org/lkml/CAKwvOdnbMs-pLRfo4O-MHOF=9=kAvDuktkeeeX7bkmnLi8LWnw@mail.gmail.com/
>
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> ---
>  scripts/clang-tools/run-clang-tools.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
> index bb78c9b..a72c4c7 100755
> --- a/scripts/clang-tools/run-clang-tools.py
> +++ b/scripts/clang-tools/run-clang-tools.py
> @@ -50,7 +50,12 @@ def run_analysis(entry):
>          checks += "linuxkernel-*"
>      else:
>          checks += "clang-analyzer-*"
> -        checks += ",-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling"
> +
> +        # List of checks to be excluded
> +        exclude = []
> +        exclude.append("-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling")
> +
> +        checks += ''.join(["," + e for e in exclude])

Thanks for the patch.  I think it's more canonical Python to do:

checks += ",".join(exclude)

However, let's just make `checks` a list to start with? Then join it
at the very end?

Even for clang-tidy, we would have a comma separated list:
`"-check=-*,linuxkernel-*"`

>      p = subprocess.run(["clang-tidy", "-p", args.path, checks, entry["file"]],

^ so then this could be:

p = subprocess.run(["clang-tidy", "-p", args.path, ",".join(checks), ...

>                         stdout=subprocess.PIPE,
>                         stderr=subprocess.STDOUT,
> --
> 2.7.4
>


-- 
Thanks,
~Nick Desaulniers
