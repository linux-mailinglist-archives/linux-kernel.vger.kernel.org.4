Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996F06F350B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 19:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjEAR2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 13:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjEAR2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 13:28:07 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC9E1720
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 10:28:06 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-55a64f0053fso12309887b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 10:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682962085; x=1685554085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4J1wW6ZIe1hoHuRYqE7svyxxnPA1ra65cb/MrhmkaE=;
        b=FTRc7sWuNG8eLjLZJERvcy2If+D1/M9Z3ZbGnYEcLYc5kWurCPC4gPknO19bQvB6dR
         RpVb8/LCZFDuihbEQpwS962n1cbMoUECfJO4YdUXPfndif0+WlSBLNCmYnRf9OPzu9M0
         U03vBG8gO+wS4LLNn+I2relwlXA+7uLdS3nPWtBLiJCBWpPMO/Za5lstdB4WVBwxvRDX
         XtI8T+ofxhPsKxSu7jMyla4Mrw7U6yRxKOtkzsj+VD8+VLJyqGOiw3VS0itCnULidYjX
         eaLcerbd5ocg/AGCs93ObyoaEZcRWRShbA0inlkO0JdZtPiC+ivv7Ln9ArJdMNXJan6v
         I2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682962085; x=1685554085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4J1wW6ZIe1hoHuRYqE7svyxxnPA1ra65cb/MrhmkaE=;
        b=ODTPZa9/zDdua6rM/+eYyKxtwbEHzNPlxqph/B1UPTmCFFUUSxK60VLNx2aUUrLAnL
         phP6+s+Y/cduNMnY3o/IbjwgQ3PV57sRVcYU0pFY17Ij2GzTjKIszS0YF8blXd/ZAWuG
         VDPRwegJT4aUIum/Otkd0hPRlFZ4rPwnxYJoXGJmxZupLa7BJBoGafhpTJPrvv4Tn8K5
         eMPPc4k1DRBPFBs1IZpLJuP8FQcDmWUenuiM9zBHtI6vynaXXtT1Ntys69zGzgSniZRB
         Ok+pGBClbTe69BRJcQrVNYEvpuFx1dodQHfBi+KwfMVt890azrXjCh9h39sQ38FTWITm
         xpoA==
X-Gm-Message-State: AC+VfDw6r14Q6xGxKOmA+5T88O0bfFDhaMWeDu3F9L2KP/+Mb36eYxMJ
        R8TrumUsnrb850d7BE7nSL6lvyj3i/h+XiOEHpSOCKTUx/D2p4vsOJ7LQg==
X-Google-Smtp-Source: ACHHUZ6kqU2PwjzY2J/yMoDy54WU0F8kBtv0P35BHGV0x1LGtfyW847NkgLN3cXY31QFPPS86lheBvtvWEXsSvz4Zu4=
X-Received: by 2002:a0d:f881:0:b0:54f:b6b3:b5e5 with SMTP id
 i123-20020a0df881000000b0054fb6b3b5e5mr13729629ywf.18.1682962085319; Mon, 01
 May 2023 10:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com> <7cee0c83225ffd8cf8fd0065bea9348f6db3b12a.1682673543.git.houwenlong.hwl@antgroup.com>
In-Reply-To: <7cee0c83225ffd8cf8fd0065bea9348f6db3b12a.1682673543.git.houwenlong.hwl@antgroup.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 May 2023 10:27:53 -0700
Message-ID: <CAKwvOd=zgjWdg2+_bg3QByh_2hve8yoKzCfEBZ5md+k8ytkqcQ@mail.gmail.com>
Subject: Re: [PATCH RFC 16/43] x86-64: Use per-cpu stack canary if supported
 by compiler
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        x86@kernel.org, Nathan Chancellor <nathan@kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 2:52=E2=80=AFAM Hou Wenlong <houwenlong.hwl@antgrou=
p.com> wrote:
>
> From: Brian Gerst <brgerst@gmail.com>
>
> From: Brian Gerst <brgerst@gmail.com>
>
> If the compiler supports it, use a standard per-cpu variable for the
> stack protector instead of the old fixed location.  Keep the fixed
> location code for compatibility with older compilers.
>
> [Hou Wenlong: Disable it on Clang, adapt new code change and adapt
> missing GS set up path in pvh_start_xen()]
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> Co-developed-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> Cc: Thomas Garnier <thgarnie@chromium.org>
> Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/Kconfig                      | 12 ++++++++++++
>  arch/x86/Makefile                     | 21 ++++++++++++++-------
>  arch/x86/entry/entry_64.S             |  6 +++++-
>  arch/x86/include/asm/processor.h      | 17 ++++++++++++-----
>  arch/x86/include/asm/stackprotector.h | 16 +++++++---------
>  arch/x86/kernel/asm-offsets_64.c      |  2 +-
>  arch/x86/kernel/cpu/common.c          | 15 +++++++--------
>  arch/x86/kernel/head_64.S             | 16 ++++++++++------
>  arch/x86/kernel/vmlinux.lds.S         |  4 +++-
>  arch/x86/platform/pvh/head.S          |  8 ++++++++
>  arch/x86/xen/xen-head.S               | 14 +++++++++-----
>  11 files changed, 88 insertions(+), 43 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 68e5da464b96..55cce8cdf9bd 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -410,6 +410,18 @@ config CC_HAS_SANE_STACKPROTECTOR
>           the compiler produces broken code or if it does not let us cont=
rol
>           the segment on 32-bit kernels.
>
> +config CC_HAS_CUSTOMIZED_STACKPROTECTOR
> +       bool
> +       # Although clang supports -mstack-protector-guard-reg option, it
> +       # would generate GOT reference for __stack_chk_guard even with
> +       # -fno-PIE flag.
> +       default y if (!CC_IS_CLANG && $(cc-option,-mstack-protector-guard=
-reg=3Dgs))

Hi Hou,
I've filed this bug against LLVM and will work with LLVM folks at
Intel to resolve:
https://github.com/llvm/llvm-project/issues/62481
Can you please review that report and let me know here or there if I
missed anything? Would you also mind including a link to that in the
comments in the next version of this patch?

Less relevant issues I filed looking at some related codegen:
https://github.com/llvm/llvm-project/issues/62482
https://github.com/llvm/llvm-project/issues/62480

And we should probably look into:
https://github.com/llvm/llvm-project/issues/22476


--=20
Thanks,
~Nick Desaulniers
