Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576235F899C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 08:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJIGPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 02:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJIGPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 02:15:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D9D2B619
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 23:15:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E99BBB80C74
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 06:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF75AC43142
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 06:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665296136;
        bh=FXMIi4X/yLKllQTQawao9abCe7Z+/qcgFVtJRXh+Q6w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ugmSW59EkGNtQPaGv+m8tLRYNpRz/M/F+bTWjcUh2OpRnH6WJiI7IovegMkB0PQky
         tGMc1q3+ns1AT7rjo+c7t5AQUiCB7NnrnJGa7bSHb3OEwiqCgE5duQ2HX5p/NSJSYh
         DyCcN18sY9jkJPVvDAjCZ8T0vTlRDvogVw17QHRtpAf0zi7aVj995MsX1pPUwZq0zZ
         XyyveacWb6HSJefARt321crIV/SAm7R9Tyvmfxg65679By3tCjr0GWYDOEHtOBGSFk
         UF68frUz7GyzbMuRm3Ml3BzSGzfgwFzKtoRYhY3nwBlU2jaLQiS994HNEIALqysxpM
         DuI/iJ4MfcgGg==
Received: by mail-ed1-f52.google.com with SMTP id s30so12050651eds.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 23:15:36 -0700 (PDT)
X-Gm-Message-State: ACrzQf2u8kScXvcAd14JTDBa0T7czVQgiqyl2ffCZxjqBx+HgXmeGfh+
        JwBgN/tlhnFkTFuXN9bohZdY8E9rfsp26BYgLFc=
X-Google-Smtp-Source: AMsMyM4Yjw/zx7cxOFT+P1VBQW2FA2Yvg9l2Iud5hBYeYyKSQazuLQiFgqafd6jQYFrO171zZPWuWVorWsM6/1OtlUM=
X-Received: by 2002:a05:6402:c81:b0:458:c428:173a with SMTP id
 cm1-20020a0564020c8100b00458c428173amr12031575edb.298.1665296134980; Sat, 08
 Oct 2022 23:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <1665278582-16038-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1665278582-16038-1-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 9 Oct 2022 14:15:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6nT5AMrgWa-FPO_cbvQbSajeoUvDskKGVys9-hsNcGvg@mail.gmail.com>
Message-ID: <CAAhV-H6nT5AMrgWa-FPO_cbvQbSajeoUvDskKGVys9-hsNcGvg@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Do not create sysfs control file for io
 master CPUs
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued for loongarch-next, thanks.

Huacai

On Sun, Oct 9, 2022 at 9:23 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> Now io master CPUs are not hotpluggable on LoongArch, in the current code,
> only /sys/devices/system/cpu/cpu0/online is not created, let us set the
> hotpluggable field of all the io master CPUs as 0, then prevent to create
> sysfs control file for the other io master CPUs which confuses some user
> space tools. This is similar with commit 9cce844abf07 ("MIPS: CPU#0 is not
> hotpluggable").
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/include/asm/bootinfo.h | 5 +++++
>  arch/loongarch/kernel/smp.c           | 5 -----
>  arch/loongarch/kernel/topology.c      | 3 ++-
>  3 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/include/asm/bootinfo.h
> index 8e5881b..ed0910e 100644
> --- a/arch/loongarch/include/asm/bootinfo.h
> +++ b/arch/loongarch/include/asm/bootinfo.h
> @@ -40,4 +40,9 @@ extern unsigned long fw_arg0, fw_arg1, fw_arg2;
>  extern struct loongson_board_info b_info;
>  extern struct loongson_system_configuration loongson_sysconf;
>
> +static inline bool io_master(int cpu)
> +{
> +       return test_bit(cpu, &loongson_sysconf.cores_io_master);
> +}
> +
>  #endif /* _ASM_BOOTINFO_H */
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index b5fab30..781a4d4 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -240,11 +240,6 @@ void loongson3_smp_finish(void)
>
>  #ifdef CONFIG_HOTPLUG_CPU
>
> -static bool io_master(int cpu)
> -{
> -       return test_bit(cpu, &loongson_sysconf.cores_io_master);
> -}
> -
>  int loongson3_cpu_disable(void)
>  {
>         unsigned long flags;
> diff --git a/arch/loongarch/kernel/topology.c b/arch/loongarch/kernel/topology.c
> index ab1a75c..caa7cd8 100644
> --- a/arch/loongarch/kernel/topology.c
> +++ b/arch/loongarch/kernel/topology.c
> @@ -5,6 +5,7 @@
>  #include <linux/node.h>
>  #include <linux/nodemask.h>
>  #include <linux/percpu.h>
> +#include <asm/bootinfo.h>
>
>  static DEFINE_PER_CPU(struct cpu, cpu_devices);
>
> @@ -40,7 +41,7 @@ static int __init topology_init(void)
>         for_each_present_cpu(i) {
>                 struct cpu *c = &per_cpu(cpu_devices, i);
>
> -               c->hotpluggable = !!i;
> +               c->hotpluggable = !io_master(i);
>                 ret = register_cpu(c, i);
>                 if (ret < 0)
>                         pr_warn("topology_init: register_cpu %d failed (%d)\n", i, ret);
> --
> 2.1.0
>
