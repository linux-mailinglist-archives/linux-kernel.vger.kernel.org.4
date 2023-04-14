Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956576E196E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDNBL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNBL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:11:27 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5AD30E5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 18:11:26 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i20so21058862ybg.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 18:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1681434685; x=1684026685;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7e9/bDdYQAc83BC4MHDH3UDjIiFTqWrXhp7UGil91Hk=;
        b=m0I1OAhWKDHDBZQTvnG6xsnO8mMGI98gmBYjuyRMurhRwBnzUlYwgnKaAFqkss5g6o
         fBZH1Buv3LgFfK2v4g/v/+d0hkF6wnnrsBVD0RoTbW8svuo/yQQ3mwtzeUZ/pycBU11g
         X/wQyVR92Y0GAu1dNqKtQp9jmySHLDnLsSMxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681434685; x=1684026685;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7e9/bDdYQAc83BC4MHDH3UDjIiFTqWrXhp7UGil91Hk=;
        b=iT4xsUvCpO3j8aIW+RBMM7kFKSrYNmlWHyMqYwnNOxEa2DxCYzEk4rN7rCtcv6nuc3
         cAVIBKAmudDIBMXi/7H4CivGy3J7UBBBnJgc5/HwmiLHxeUZvUfk+v0CifKpe160YZ3G
         JuGJN174OOKY6Y91gVwRHEd9QzapWdBsSTit7jRZYVI/2j60JOZtX6gKdUAkBwrkJP7u
         qtAGrn2qFNMUI2vjppQyP7XqBCMSJieKaisW4pWv5ojgExdmr3Ru9zaH0LSL3qI2vGDj
         HDP7l8LxGZ1+7scPdLH3ifXAGcn72Wol3TYjkO04dxYIuPzkeljj9moGXDhCZoQelFzG
         xM7w==
X-Gm-Message-State: AAQBX9flM5y3IX5/mT9rvzIEcKUN0Bs8x41HqXFP2Zzgj9t51CgR4SQq
        ZVNgdeUrLY96BmUo4uoS8llYGjjyZmJfAlZEEPXU0w==
X-Google-Smtp-Source: AKy350YPjhOs/a0tAHLcIqdFYyG6No7a5BIJAJagNLInoVfFY0LHcLiTAtVRduj956RTfEfpx+pbyV5ufn1zwDDaOEw=
X-Received: by 2002:a25:d08d:0:b0:b8f:5492:852f with SMTP id
 h135-20020a25d08d000000b00b8f5492852fmr2637618ybg.2.1681434685270; Thu, 13
 Apr 2023 18:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230414005309.GA2198310@google.com>
In-Reply-To: <20230414005309.GA2198310@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 13 Apr 2023 21:11:14 -0400
Message-ID: <CAEXW_YRm62XHtpw4Ubp7x3n9jZJNGezRp0ymOGbQ3e62mysz1w@mail.gmail.com>
Subject: Re: clangd cannot handle tree_nocb.h
To:     rcu@vger.kernel.org, ndesaulniers@google.com, nathan@kernel.org,
        trix@redhat.com, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

One way to fix this could be to add this to the beginning of tree_nocb.h

/* Make clangd understand tree_nocb.h */
+#ifdef CLANGD_PARSER_ACTIVE
+#define TREE_NOCB_H_CLANGD
+#include "tree.c"
+#endif

And then at the end of tree.c, do this to prevent recursion:
+#ifndef TREE_NOCB_H_CLANGD
 #include "tree_nocb.h"
-#include "tree_plugin.h"
+#endif
+#include "tree_plugin.h"

Then in scripts/clang-tools/gen_compile_commands.py, we can just make
it add "-DCLANGD_PARSER_ACTIVE" to all compile command entries in the
JSON file.

Would that be an acceptable solution? Let me know your opinion (both
Paul and clangd people :)) so I can work on a patch to do this.

 - Joel



On Thu, Apr 13, 2023 at 8:53=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> Hello!
>
> I have been trying to get clangd working properly with tree_nocb.h. clang=
d
> trips quite badly when trying to build tree_nocb.h to generate ASTs.
>
> I get something like this in the clangd logs showing it 'infers' how to b=
uild
> tree_nocb.h because it could not find a command in compile_commands.json:
>
> ASTWorker building file [..]/tree_nocb.h version 9 with command inferred =
from
> [..]/kernel/rcu/tree.c
>
> This leads to all hell breaking lose with complaints about missing rcu_da=
ta
> struct definition and so forth.
>
> So far I came up with a workaround as follows, but is there a better way?
>
> 1. Open compile_commands.json and add a new entry as follows, with a
> definition "-DNOCB_H_CLANGD_PARSE". Otherwise the entry is indentical to =
how
> tree.c is built.
>
>   {
>     "arguments": [
>       "/usr/bin/clang",
>       "-Wp,-MMD,kernel/rcu/.treenocb.o.d",
>       "-nostdinc",
>       "-I./arch/x86/include",
>       "-I./arch/x86/include/generated",
>       "-I./include",
>       "-I./arch/x86/include/uapi",
> [...]
>       "-Wformat-zero-length",
>       "-Wnonnull",
>       "-Wformat-insufficient-args",
>       "-Wno-sign-compare",
>       "-Wno-pointer-to-enum-cast",
>       "-Wno-tautological-constant-out-of-range-compare",
>       "-Wno-unaligned-access",
>       "-DKBUILD_MODFILE=3D\"kernel/rcu/tree\"",
>       "-DKBUILD_BASENAME=3D\"tree\"",
>       "-DKBUILD_MODNAME=3D\"tree\"",
>       "-D__KBUILD_MODNAME=3Dkmod_tree",
>       "-DNOCB_H_CLANGD_PARSE",
>       "-c",
>       "-I",
>       "/s/",
>       "-I",
>       "/s/",
>       "-o",
>       "kernel/rcu/tree_nocb.h.o",
>       "kernel/rcu/tree_nocb.h"
>     ],
>     "directory": "/usr/local/google/home/joelaf/repo/linux-master",
>     "file": "/usr/local/google/home/joelaf/repo/linux-master/kernel/rcu/t=
ree_nocb.h",
>     "output": "/usr/local/google/home/joelaf/repo/linux-master/kernel/rcu=
/tree_nocb.h.o"
>   },
>
> 2.
> Then in kernel/tree/tree_nocb.h, I do the following right in the beginnin=
g.
> (Thanks to paulmck@ for this idea).
>
> #ifdef NOCB_H_CLANGD_PARSE
> #include "tree.c"
> #endif
>
> 3. To prevent the above inclusion of tree.c from recursively including
> tree_nocb.h, I do the following at the end of tree.c
>
> +#ifndef NOCB_H_CLANGD_PARSE
>  #include "tree_nocb.h"
> -#include "tree_plugin.h"
> +#endif
> +#include "tree_plugin.h"
>
> With that it works, but if I ever generate compile_commands.json again, t=
hen
> I'll have to again modify compile_commands.json manually to make my edito=
r
> work again with clangd.
>
> So I guess my questions are:
>
> 1. Is there a 'standard' procedure to solve something like this?
>
> 2. How do we fix this the right way?
>    One way would be for scripts/clang-tools/gen_compile_commands.py to pa=
rse
>    header files and generate suitable compile_commands.json based on
>    meta-data in the header file.
>
> 3. How do we fix this for other header files in general? Do we have to ma=
ke hacks like
>    above (sad face) or can we come up with a standard way to make it work=
 for kernel
>    sources?
>
> Thank you!
>
>  - Joel
>
>
>
>
>
>
