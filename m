Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E774F73CF8B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 10:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjFYIzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 04:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFYIzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 04:55:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE5E127
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 01:55:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE2B960B6E
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501E7C433C9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687683348;
        bh=7+eC0aDwuKf5vEOSJD3dDWwPcpDgJ9eNDlolNBZud0s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZqYxRokqcPdbl4OEHzhz0oIvp5jmu6PeoiQYaAFAP52iEHc14zGU1z361AAMqLQ3o
         OmV0Bp9AIs0QjOW+XVAAQNo/4Cr3eAVeucbe0gGBCGJOor4La518v+9nbPSGGjTcww
         n80RD4Eaclhy/ZSUeky5AaY4gmC+K3Ool0VICpnheR+NVv2gT/mrT982XkJyc8tS/R
         csKdq5Uo8ExxwikHUSa0oe+P33NDKDuI0L+bQzYG68+p9wvmQ+D6jaVqTkWXOAu/JX
         C/TklPc6A98nO8aN9JQg6bYsH0FkSKRKx/8guO/PIBLFeRwRa9Nczm9jyBGa8+EoUy
         hwnK/t665U2Wg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51d7d0dbec8so1429776a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 01:55:48 -0700 (PDT)
X-Gm-Message-State: AC+VfDz80Fy3Haa2TVTZB1nidXchPFZDS4tOXUD8wlhNhPltNLE69kyx
        pAk0Fy7Xtq1C+H8nMFHEx+qZulk5omIBfy8bmg4=
X-Google-Smtp-Source: ACHHUZ4vNnea3bswnH820+GwW88RfKD4sBM3CnwZoBp8A6sQ6g4Gt1aYDc6+SNTnLt4kJY9CZxYa/P+881LBFDMVoJ0=
X-Received: by 2002:aa7:d851:0:b0:51d:8a53:d1f with SMTP id
 f17-20020aa7d851000000b0051d8a530d1fmr1330030eds.8.1687683346457; Sun, 25 Jun
 2023 01:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230615121016.3731983-1-chenhuacai@loongson.cn>
In-Reply-To: <20230615121016.3731983-1-chenhuacai@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 25 Jun 2023 16:55:33 +0800
X-Gmail-Original-Message-ID: <CAAhV-H49AyrG-sH2SXLNg_cX-Wv8vS4Qno_2N4v6ccGGciv-+A@mail.gmail.com>
Message-ID: <CAAhV-H49AyrG-sH2SXLNg_cX-Wv8vS4Qno_2N4v6ccGGciv-+A@mail.gmail.com>
Subject: Re: [PATCH] kthread: Rename user_mode_thread() to kmuser_thread()
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping?

Huacai

On Thu, Jun 15, 2023 at 8:10=E2=80=AFPM Huacai Chen <chenhuacai@loongson.cn=
> wrote:
>
> Commit 343f4c49f2438d8 ("kthread: Don't allocate kthread_struct for init
> and umh") introduces a new function user_mode_thread() for init and umh.
>
> init and umh are different from typical kernel threads since the don't
> need a "kthread" struct and they will finally become user processes by
> calling kernel_execve(), but on the other hand, they are also different
> from typical user mode threads (they have no "mm" structs at creation
> time, which is traditionally used to distinguish a user thread and a
> kernel thread).
>
> In a former patch I treat init and umh as "special kernel threads" and
> unify kernel_thread() and user_mode_thread() to kernel_thread() again.
> However, the patch has been nacked because init and umh are essentially
> "special user threads".
>
> Nevertheless, I still agree with Andrews' comment "But the naming isn't
> very good anyway. They should have been usermode_thread/kernel_thread or
> user_thread/kernel_thread.".
>
> Since Eric describes init and umh as "user threads run in kernel mode",
> in this patch I rename user_mode_thread() as kmuser_thread(), which is
> a little better than just user_thread().
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  include/linux/sched/task.h | 2 +-
>  init/main.c                | 2 +-
>  kernel/fork.c              | 4 ++--
>  kernel/umh.c               | 4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index e0f5ac90a228..c774d604b0a3 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -98,7 +98,7 @@ struct task_struct *create_io_thread(int (*fn)(void *),=
 void *arg, int node);
>  struct task_struct *fork_idle(int);
>  extern pid_t kernel_thread(int (*fn)(void *), void *arg, const char *nam=
e,
>                             unsigned long flags);
> -extern pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned lon=
g flags);
> +extern pid_t kmuser_thread(int (*fn)(void *), void *arg, unsigned long f=
lags);
>  extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
>  int kernel_wait(pid_t pid, int *stat);
>
> diff --git a/init/main.c b/init/main.c
> index af50044deed5..362ba90d6f73 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -697,7 +697,7 @@ noinline void __ref __noreturn rest_init(void)
>          * the init task will end up wanting to create kthreads, which, i=
f
>          * we schedule it before we create kthreadd, will OOPS.
>          */
> -       pid =3D user_mode_thread(kernel_init, NULL, CLONE_FS);
> +       pid =3D kmuser_thread(kernel_init, NULL, CLONE_FS);
>         /*
>          * Pin init on the boot CPU. Task migration is not properly worki=
ng
>          * until sched_init_smp() has been run. It will set the allowed
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 41c964104b58..57d5c8c1766e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2978,9 +2978,9 @@ pid_t kernel_thread(int (*fn)(void *), void *arg, c=
onst char *name,
>  }
>
>  /*
> - * Create a user mode thread.
> + * Create a kernel mode user thread.
>   */
> -pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags=
)
> +pid_t kmuser_thread(int (*fn)(void *), void *arg, unsigned long flags)
>  {
>         struct kernel_clone_args args =3D {
>                 .flags          =3D ((lower_32_bits(flags) | CLONE_VM |
> diff --git a/kernel/umh.c b/kernel/umh.c
> index 60aa9e764a38..28c0cf0da7be 100644
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -130,7 +130,7 @@ static void call_usermodehelper_exec_sync(struct subp=
rocess_info *sub_info)
>
>         /* If SIGCLD is ignored do_wait won't populate the status. */
>         kernel_sigaction(SIGCHLD, SIG_DFL);
> -       pid =3D user_mode_thread(call_usermodehelper_exec_async, sub_info=
, SIGCHLD);
> +       pid =3D kmuser_thread(call_usermodehelper_exec_async, sub_info, S=
IGCHLD);
>         if (pid < 0)
>                 sub_info->retval =3D pid;
>         else
> @@ -169,7 +169,7 @@ static void call_usermodehelper_exec_work(struct work=
_struct *work)
>                  * want to pollute current->children, and we need a paren=
t
>                  * that always ignores SIGCHLD to ensure auto-reaping.
>                  */
> -               pid =3D user_mode_thread(call_usermodehelper_exec_async, =
sub_info,
> +               pid =3D kmuser_thread(call_usermodehelper_exec_async, sub=
_info,
>                                        CLONE_PARENT | SIGCHLD);
>                 if (pid < 0) {
>                         sub_info->retval =3D pid;
> --
> 2.39.3
>
