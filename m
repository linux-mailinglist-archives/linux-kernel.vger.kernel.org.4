Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E195F450E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJDODB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJDOC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:02:57 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429665D0C5;
        Tue,  4 Oct 2022 07:02:56 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-345528ceb87so136462647b3.11;
        Tue, 04 Oct 2022 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TR5SAJXFGC1nDy2HAPbOzDqZLUl4bxPSNS4KiodXPBA=;
        b=ODABosh2WEoafTy1FxycIrl08tnWb4XcbVBosrmRQRYRk18/f0IJCY53gDOQLgaH1d
         cnzdiQfyy3aOmueHuIBUapQYRBjJqobOaJ2nD9l01GlMpoJRMkUrSN5XaXYplTMGlceW
         YMuNzIgbFT+Uz2PdcrHreKSWLXjLrSWk3YL32wbKIC8W0e8sLtlSV6LBWKeirpeAPrPj
         O2vNGaHi+7KJRHWJ8+0s4G1aaSRkvmPaG24suNyLuXNx/9qAItQwdO+ozuqNVBnGIGDW
         4eyTcupSvwG5l7hA9ct0cH7Dozufzq9fFyOLM7ly6e5GojpXzpnIo+T4iqe2n3foXe70
         En7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TR5SAJXFGC1nDy2HAPbOzDqZLUl4bxPSNS4KiodXPBA=;
        b=2r974264Ggat7GPwuIK238baZEZgFUTF8uNiIkY/lG9tbIJhfrrfmIPrULqnnJxrd+
         cW42k1+i9Chm/069gzkaue6INUEtTTyDMM945I5Oj3UDI11dfvhta8mjWnbQBF3EGifv
         1T8DLQUmdrf6a+ljpa2nJjxQOHDIqBX0n8fPDRAZDvtDFYo8vxutum+/RYWnD0tj1ioC
         neY61bQH3yo5zdjGjZXbneTOXB/sarZtMLVbfcqW6pxsxHJooTA2xXcMZH2g9mVCunJG
         +2Ab4J2i8OFd35pwghI8MURpQNAQsuNF7MMyhjZff4RZpkl7L2NNJ240dk5YXlUeLZrP
         TQ2g==
X-Gm-Message-State: ACrzQf2dV7bh1/ZizcO1kXuyc6bmP+d4z3WUvmmOmGhQpEhHhEcaXQiN
        4uxcOeKfW/+R0HB8hzBH/uC28TxtEA2EBfV58lc=
X-Google-Smtp-Source: AMsMyM6/enW4yMl7nEiPTn3SY2RZwgwa25M+qgpNc51oKtFaV3an6svt2n92gr9f3KXbSyUwg8t9SqdpcULH3fSl+So=
X-Received: by 2002:a81:a087:0:b0:357:3a80:1fca with SMTP id
 x129-20020a81a087000000b003573a801fcamr16479943ywg.481.1664892174802; Tue, 04
 Oct 2022 07:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjwvBc3VQMNtUVUrMBVoMPSPu26OuatZ_+1gZ2m-PmmRA@mail.gmail.com>
 <20221004135301.1420873-1-Jason@zx2c4.com>
In-Reply-To: <20221004135301.1420873-1-Jason@zx2c4.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 4 Oct 2022 16:02:11 +0200
Message-ID: <CAKXUXMyvk6WJr2M09+=D43QocX_igoaU0-qMN-MCwQk++O=vwA@mail.gmail.com>
Subject: Re: [PATCH] alpha: remove osf_{readv,writev}
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 3:53 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> As of 987f20a9dcce ("a.out: Remove the a.out implementation"),
> sys_osf_{readv,writev} is now the same as sys_{readv,writev}. So remove
> the osf indirection, and point the syscall table directly at the generic
> functions, as is done on other platforms.
>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Only compiled and QEMU-booted with no userspace, but seems simple
> enough?
>

This patch looks exactly the same as the patch I sent a few hours ago:

https://lore.kernel.org/lkml/20221004071302.11471-1-lukas.bulwahn@gmail.com/

My patch was completely untested; good that this one is at least
compile tested and went through basic boot tests.

Any of the two patches, the one above or this one, can be picked.

Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>



Lukas

>  arch/alpha/kernel/osf_sys.c            | 12 ------------
>  arch/alpha/kernel/syscalls/syscall.tbl |  4 ++--
>  2 files changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
> index b3ad8c44c971..6c6c4337e201 100644
> --- a/arch/alpha/kernel/osf_sys.c
> +++ b/arch/alpha/kernel/osf_sys.c
> @@ -1278,18 +1278,6 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
>         return addr;
>  }
>
> -SYSCALL_DEFINE3(osf_readv, unsigned long, fd,
> -               const struct iovec __user *, vector, unsigned long, count)
> -{
> -       return sys_readv(fd, vector, count);
> -}
> -
> -SYSCALL_DEFINE3(osf_writev, unsigned long, fd,
> -               const struct iovec __user *, vector, unsigned long, count)
> -{
> -       return sys_writev(fd, vector, count);
> -}
> -
>  SYSCALL_DEFINE2(osf_getpriority, int, which, int, who)
>  {
>         int prio = sys_getpriority(which, who);
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index 3515bc4f16a4..8ebacf37a8cf 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -125,8 +125,8 @@
>  116    common  osf_gettimeofday                sys_osf_gettimeofday
>  117    common  osf_getrusage                   sys_osf_getrusage
>  118    common  getsockopt                      sys_getsockopt
> -120    common  readv                           sys_osf_readv
> -121    common  writev                          sys_osf_writev
> +120    common  readv                           sys_readv
> +121    common  writev                          sys_writev
>  122    common  osf_settimeofday                sys_osf_settimeofday
>  123    common  fchown                          sys_fchown
>  124    common  fchmod                          sys_fchmod
> --
> 2.37.3
>
