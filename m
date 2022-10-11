Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAFC5FBC20
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiJKUfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiJKUe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:34:57 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858DDB860
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:34:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h12so7754209pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PTbWVXLIN1b6HbFAVFkEqMwwHS3zVwHlY2drFLxGoLg=;
        b=o+Bp92d8U9IeEnBkS0Z1i9ryaMDET3isngOzJ4EcKfV2O2TQauCy6hypPz4oiOa55F
         0Xmeg/1n9Xud7HFz871iXBLNsCS+2PNfYvqmVDP5huXQTcfztJSaRqh/2dYaBPHK96sk
         j7oFvVh7Q9v6rhdo2VzhzUMulsWF2mN+jER4PxXhS5ZDgKSi4p1kkc5oNvmixzLLnOwf
         kWF0hrSjQL15Oy+AZXe9lqhI0IkSzGb9iUt614GV7U+qwumizxLpx+ltMWgCd55kXmi7
         5ht4TyF2NUibWetksITA/5ENHjDRzdITqN3mQ9xjh/q6etDmd2NAM/VLIJN5YnR5jYVI
         HWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTbWVXLIN1b6HbFAVFkEqMwwHS3zVwHlY2drFLxGoLg=;
        b=uJEDpm3eXeuZjKQLv6UGWFKtgwBccpgBr2ZqPKRd35oE/YVLFhqnxvbxb5YIbAv42B
         v+jO016Tl5tG8O+oRwUOtsxUJ+ljpAIJGLEYrv16lgHLBSnR20h3VS8rbMegNWKpxith
         bx5kS6bfvR17bqR87g/CFws5PJJ5D6EIHOkCK9Tmxg1ZTwpFj4adffPHPdR5ieh0kTeJ
         ToyjYRZqIc1e6h2k1O2ElxXA6DCCm1bhfdyIZ1eYPl7fsMYX2JWJkxCIXA+QsOBsXAt8
         BzERHhjdf2ygKmanqskuvOVdEg05f6JbV3w9fzFuvdaHE+ayxZ7h0HAWJAQHoUN+xsxn
         RbhQ==
X-Gm-Message-State: ACrzQf2Dnv074Jihzor5Kna1pAuIIaUew6dbrQbVtB2IkQTIuzEmTuq/
        eCgQitxwbUrakBt+p6ziF0MNgbQWwns1ECjRsfGCiA==
X-Google-Smtp-Source: AMsMyM4OgyVn6oWkRWJzsx5ZmJ1iLdep7BqJmP/vTlKH6MkCP5Hv7iJHLNDobooF7Blmg+fdszART4fHQNyJNqMNKIQ=
X-Received: by 2002:a17:902:b210:b0:17d:c3ca:4a4f with SMTP id
 t16-20020a170902b21000b0017dc3ca4a4fmr25348875plr.33.1665520495825; Tue, 11
 Oct 2022 13:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <a10e25f13205cb96e1ad63f1b1371a76f37af549.1665515051.git.quic_gurus@quicinc.com>
In-Reply-To: <a10e25f13205cb96e1ad63f1b1371a76f37af549.1665515051.git.quic_gurus@quicinc.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Oct 2022 13:34:44 -0700
Message-ID: <CAKwvOdmsjxB_i=9Qy6L+4AH+CwOYa0EsRBPFUTj9vwxJ6vNPSg@mail.gmail.com>
Subject: Re: [PATCH 1/1] scripts/clang-tools: Convert clang-tidy args to list
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        John Moon <quic_johmoo@quicinc.com>, llvm@lists.linux.dev,
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

On Tue, Oct 11, 2022 at 12:06 PM Guru Das Srinagesh
<quic_gurus@quicinc.com> wrote:
>
> Convert list of clang-tidy arguments to a list for ease of adding to
> them and extending them as required.
>
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Masahiro, would you please be able to carry this up through the kbuild tree?

> ---
>  scripts/clang-tools/run-clang-tools.py | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
> index bb78c9b..56f2ec8 100755
> --- a/scripts/clang-tools/run-clang-tools.py
> +++ b/scripts/clang-tools/run-clang-tools.py
> @@ -45,13 +45,14 @@ def init(l, a):
>
>  def run_analysis(entry):
>      # Disable all checks, then re-enable the ones we want
> -    checks = "-checks=-*,"
> +    checks = []
> +    checks.append("-checks=-*")
>      if args.type == "clang-tidy":
> -        checks += "linuxkernel-*"
> +        checks.append("linuxkernel-*")
>      else:
> -        checks += "clang-analyzer-*"
> -        checks += ",-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling"
> -    p = subprocess.run(["clang-tidy", "-p", args.path, checks, entry["file"]],
> +        checks.append("clang-analyzer-*")
> +        checks.append("-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling")
> +    p = subprocess.run(["clang-tidy", "-p", args.path, ",".join(checks), entry["file"]],
>                         stdout=subprocess.PIPE,
>                         stderr=subprocess.STDOUT,
>                         cwd=entry["directory"])
> --
> 2.7.4
>


-- 
Thanks,
~Nick Desaulniers
