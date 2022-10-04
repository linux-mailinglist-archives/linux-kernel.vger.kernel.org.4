Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5925F4513
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJDODV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJDODL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:03:11 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74EF5D11D;
        Tue,  4 Oct 2022 07:03:09 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id r20so8152329qtn.12;
        Tue, 04 Oct 2022 07:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J44FSMQt9hxXyZYK2BIhrM49ThEiIJfUS0tSrCeMHvA=;
        b=1kq9KC9nhIY4T1BEdximrwdpGGZBWW4x41bCmCmrfbmY/2UPYFR4xFZmrviLZuiXFl
         wDNMb7rZ83FMhemCZhRk0ppNdLuYhl0fJ+ThJU49DgswpR6VTXRQHg3Gu6/mI1HxNye6
         M/Fq/ahWXDu8W4NquzyVIDXvzVicvxyWnX/w4FITj/gu4JtGJGvbD7ehcBaAvJplusLQ
         50KSOlD67Gqvmh+hFVRWO+rVAr8P09JohazsvibAHteKb7DsiQqLsIdqJc8jDUucdwDL
         7LyETkOqRhLX7EU9gndTQCYb7/bsC/wcpwxVGyuzcQj6q3I+4UZvq4tEgHQrlED1nbN0
         ojBA==
X-Gm-Message-State: ACrzQf02r+QApr/gUvoWaTtKk3E2MoKV8A25RjnNeyXje8/hBEXu3Rei
        NcaahWQ/vh3o4O5mrD6ZdNegDCSTly47njHmSPw=
X-Google-Smtp-Source: AMsMyM4xDFr0ZTm7UK3Wa4Q62y7QkPCbKXgvi1o/2GRsRrxucTq6HEIWk7DVvHxUyyQZFHygQ5MFyzUr4RS/hFiT/e4=
X-Received: by 2002:a05:622a:11c8:b0:35c:e912:a8ea with SMTP id
 n8-20020a05622a11c800b0035ce912a8eamr19609035qtk.17.1664892188502; Tue, 04
 Oct 2022 07:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220929070526.143907-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220929070526.143907-1-kai.heng.feng@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Oct 2022 16:02:57 +0200
Message-ID: <CAJZ5v0iqoXK-83BPahwHN35Ar8FgUhqPv+Hsz9BY9nAju3sMOw@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 1/2] kernel/reboot: Add SYS_OFF_MODE_RESTART_PREPARE
 mode
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     rafael.j.wysocki@intel.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        tangmeng <tangmeng@uniontech.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 9:06 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Add SYS_OFF_MODE_RESTART_PREPARE callbacks can be invoked before system
> restart.
>
> This is a preparation for next patch.
>
> Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied as 6.1-rc material along with the [2/2], thanks!

> ---
> v4:
>  - Correct typo in comment.
> v3:
>  - New patch.
>
>  include/linux/reboot.h |  8 ++++++++
>  kernel/reboot.c        | 17 +++++++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> index e5d9ef886179c..2b6bb593be5b6 100644
> --- a/include/linux/reboot.h
> +++ b/include/linux/reboot.h
> @@ -105,6 +105,14 @@ enum sys_off_mode {
>          */
>         SYS_OFF_MODE_POWER_OFF,
>
> +       /**
> +        * @SYS_OFF_MODE_RESTART_PREPARE:
> +        *
> +        * Handlers prepare system to be restarted. Handlers are
> +        * allowed to sleep.
> +        */
> +       SYS_OFF_MODE_RESTART_PREPARE,
> +
>         /**
>          * @SYS_OFF_MODE_RESTART:
>          *
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 3c35445bf5ad3..3bba88c7ffc6b 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -243,6 +243,17 @@ void migrate_to_reboot_cpu(void)
>         set_cpus_allowed_ptr(current, cpumask_of(cpu));
>  }
>
> +/*
> + *     Notifier list for kernel code which wants to be called
> + *     to prepare system for restart.
> + */
> +static BLOCKING_NOTIFIER_HEAD(restart_prep_handler_list);
> +
> +static void do_kernel_restart_prepare(void)
> +{
> +       blocking_notifier_call_chain(&restart_prep_handler_list, 0, NULL);
> +}
> +
>  /**
>   *     kernel_restart - reboot the system
>   *     @cmd: pointer to buffer containing command to execute for restart
> @@ -254,6 +265,7 @@ void migrate_to_reboot_cpu(void)
>  void kernel_restart(char *cmd)
>  {
>         kernel_restart_prepare(cmd);
> +       do_kernel_restart_prepare();
>         migrate_to_reboot_cpu();
>         syscore_shutdown();
>         if (!cmd)
> @@ -396,6 +408,11 @@ register_sys_off_handler(enum sys_off_mode mode,
>                 handler->list = &power_off_handler_list;
>                 break;
>
> +       case SYS_OFF_MODE_RESTART_PREPARE:
> +               handler->list = &restart_prep_handler_list;
> +               handler->blocking = true;
> +               break;
> +
>         case SYS_OFF_MODE_RESTART:
>                 handler->list = &restart_handler_list;
>                 break;
> --
> 2.37.2
>
