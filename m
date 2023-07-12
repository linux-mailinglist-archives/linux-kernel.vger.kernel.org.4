Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0EE750B54
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjGLOqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGLOqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:46:33 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F69A1992
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:46:31 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b9e8e5b12dso21522255ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689173190; x=1691765190;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3RJlGEMkrK0JJ4Kxd7hYeKyRhV465TrolA6xg6qfxJ8=;
        b=rkydKRIpQBAKPCJ/OjBL6hiE17WoRL68apriz9iDe8EWclBfKbIdoJm4e9Eq2EPQi0
         ifoCBc/mQNoqKpsVSFjAvU1zwmLLbcz9gOwTfHqUO7t77dBsUyymCe5IRz40Fg6SDToR
         Oc6ao8Q3d3m8mD29bYwG3wr4aNSAhk4NRV8IxVo4QDWs5rInTu/wOy/c/e3gbxq1ux8y
         U2BvPk7NxgGPhtSCzjNCOr4B+wGukwQDT0GS1npIvr9Dq9pIRajUzWQ26doL3oleIJbu
         48U7KoFPYtHT9bJygROE78+SiMVX5rgurr4XvDfj0iyB6n4M4XuWhzc3I/VD3kVmqxoT
         6gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689173190; x=1691765190;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RJlGEMkrK0JJ4Kxd7hYeKyRhV465TrolA6xg6qfxJ8=;
        b=W33Meuk4nKMgQCSqDexn/kyieD2lliFku9yNPjo7TKnnGA1BHDWG6seFRTXckf5Umr
         sXjs28Jx/rVkjoL5v4lRnW+sQeBw6hd8xo7bGS0mPDujnsa1hq1EJgcRYESlz6W3hZr4
         J+AeXPi6oicf1mqrmvQeTqLIOE8fFf1SV9LhkLpIdPY/diJLpxcUp671OREM+mzbgit2
         LAs+eBo1Tord1txo2beX1Cgk1HBeJR4IH7om/8i29388X+du9aNsYC0EFIpohg9ZBzk3
         IYJqrIdNUF5Zhwm3jm/3P2U+j8I/qGGB1gmeRh0bOSVw/KaWcbnsBREZ+NGZ/GDadiJ+
         FcXg==
X-Gm-Message-State: ABy/qLa3YEHMifRissRfwjS1v3o7ZOZFPDCjbdGJ0r6rxRwMJwtQIj22
        mBMeBAl50gvqizotOS91GUwysQ==
X-Google-Smtp-Source: APBJJlHxSmG9jFkJQFDwDAILENgpdtukWjxbKoYhVkmclBMHHMEXiP6I525g1aGIuImZ/nj7vZ2fug==
X-Received: by 2002:a17:902:ecce:b0:1b9:ebe9:5f01 with SMTP id a14-20020a170902ecce00b001b9ebe95f01mr7747418plh.19.1689173190386;
        Wed, 12 Jul 2023 07:46:30 -0700 (PDT)
Received: from localhost ([50.38.6.230])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902988d00b001b9e9765d8fsm4027382plp.261.2023.07.12.07.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 07:46:30 -0700 (PDT)
Date:   Wed, 12 Jul 2023 07:46:30 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jul 2023 07:45:43 PDT (-0700)
Subject:     Re: [PATCH 4/4] vgacon, arch/*: remove unused screen_info definitions
In-Reply-To: <20230707095415.1449376-4-arnd@kernel.org>
CC:     tzimmermann@suse.de, javierm@redhat.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, dri-devel@lists.freedesktop.org,
        Ard Biesheuvel <ardb@kernel.org>, deller@gmx.de,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, guoren@kernel.org,
        bcain@quicinc.com, dinguyen@kernel.org, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, davem@davemloft.net,
        chris@zankel.net, jcmvbkbc@gmail.com, masahiroy@kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     arnd@kernel.org
Message-ID: <mhng-099c5770-3367-48d7-a068-25762b837196@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jul 2023 02:52:26 PDT (-0700), arnd@kernel.org wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> A number of architectures either kept the screen_info definition for
> historical purposes as it used to be required by the generic VT code, or
> they copied it from another architecture in order to build the VGA
> console driver in an allmodconfig build.
>
> Now that vgacon no longer builds on these architectures, remove the
> stale definitions.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/csky/kernel/setup.c          | 12 ------------
>  arch/hexagon/kernel/Makefile      |  2 --
>  arch/hexagon/kernel/screen_info.c |  3 ---
>  arch/nios2/kernel/setup.c         |  5 -----
>  arch/sh/kernel/setup.c            |  5 -----
>  arch/sparc/kernel/setup_32.c      | 13 -------------
>  arch/sparc/kernel/setup_64.c      | 13 -------------
>  arch/xtensa/kernel/setup.c        | 12 ------------
>  8 files changed, 65 deletions(-)
>  delete mode 100644 arch/hexagon/kernel/screen_info.c
>
> diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
> index 106fbf0b6f3b4..51012e90780d6 100644
> --- a/arch/csky/kernel/setup.c
> +++ b/arch/csky/kernel/setup.c
> @@ -8,22 +8,10 @@
>  #include <linux/of_fdt.h>
>  #include <linux/start_kernel.h>
>  #include <linux/dma-map-ops.h>
> -#include <linux/screen_info.h>
>  #include <asm/sections.h>
>  #include <asm/mmu_context.h>
>  #include <asm/pgalloc.h>
>
> -#ifdef CONFIG_DUMMY_CONSOLE
> -struct screen_info screen_info = {
> -	.orig_video_lines	= 30,
> -	.orig_video_cols	= 80,
> -	.orig_video_mode	= 0,
> -	.orig_video_ega_bx	= 0,
> -	.orig_video_isVGA	= 1,
> -	.orig_video_points	= 8
> -};
> -#endif
> -
>  static void __init csky_memblock_init(void)
>  {
>  	unsigned long lowmem_size = PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET);
> diff --git a/arch/hexagon/kernel/Makefile b/arch/hexagon/kernel/Makefile
> index e73cb321630ec..3fdf937eb572e 100644
> --- a/arch/hexagon/kernel/Makefile
> +++ b/arch/hexagon/kernel/Makefile
> @@ -17,5 +17,3 @@ obj-y += vm_vectors.o
>  obj-$(CONFIG_HAS_DMA) += dma.o
>
>  obj-$(CONFIG_STACKTRACE) += stacktrace.o
> -
> -obj-$(CONFIG_VGA_CONSOLE) += screen_info.o
> diff --git a/arch/hexagon/kernel/screen_info.c b/arch/hexagon/kernel/screen_info.c
> deleted file mode 100644
> index 1e1ceb18bafe7..0000000000000
> --- a/arch/hexagon/kernel/screen_info.c
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -#include <linux/screen_info.h>
> -
> -struct screen_info screen_info;
> diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
> index 8582ed9658447..da122a5fa43b2 100644
> --- a/arch/nios2/kernel/setup.c
> +++ b/arch/nios2/kernel/setup.c
> @@ -19,7 +19,6 @@
>  #include <linux/memblock.h>
>  #include <linux/initrd.h>
>  #include <linux/of_fdt.h>
> -#include <linux/screen_info.h>
>
>  #include <asm/mmu_context.h>
>  #include <asm/sections.h>
> @@ -36,10 +35,6 @@ static struct pt_regs fake_regs = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>  					0, 0, 0, 0, 0, 0,
>  					0};
>
> -#ifdef CONFIG_VT
> -struct screen_info screen_info;
> -#endif
> -
>  /* Copy a short hook instruction sequence to the exception address */
>  static inline void copy_exception_handler(unsigned int addr)
>  {
> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
> index b3da2757faaf3..3d80515298d26 100644
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -7,7 +7,6 @@
>   *  Copyright (C) 1999  Niibe Yutaka
>   *  Copyright (C) 2002 - 2010 Paul Mundt
>   */
> -#include <linux/screen_info.h>
>  #include <linux/ioport.h>
>  #include <linux/init.h>
>  #include <linux/initrd.h>
> @@ -69,10 +68,6 @@ EXPORT_SYMBOL(cpu_data);
>  struct sh_machine_vector sh_mv = { .mv_name = "generic", };
>  EXPORT_SYMBOL(sh_mv);
>
> -#ifdef CONFIG_VT
> -struct screen_info screen_info;
> -#endif
> -
>  extern int root_mountflags;
>
>  #define RAMDISK_IMAGE_START_MASK	0x07FF
> diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
> index 34ef7febf0d56..e3b72a7b46d37 100644
> --- a/arch/sparc/kernel/setup_32.c
> +++ b/arch/sparc/kernel/setup_32.c
> @@ -17,7 +17,6 @@
>  #include <linux/initrd.h>
>  #include <asm/smp.h>
>  #include <linux/user.h>
> -#include <linux/screen_info.h>
>  #include <linux/delay.h>
>  #include <linux/fs.h>
>  #include <linux/seq_file.h>
> @@ -51,18 +50,6 @@
>
>  #include "kernel.h"
>
> -struct screen_info screen_info = {
> -	0, 0,			/* orig-x, orig-y */
> -	0,			/* unused */
> -	0,			/* orig-video-page */
> -	0,			/* orig-video-mode */
> -	128,			/* orig-video-cols */
> -	0,0,0,			/* ega_ax, ega_bx, ega_cx */
> -	54,			/* orig-video-lines */
> -	0,                      /* orig-video-isVGA */
> -	16                      /* orig-video-points */
> -};
> -
>  /* Typing sync at the prom prompt calls the function pointed to by
>   * romvec->pv_synchook which I set to the following function.
>   * This should sync all filesystems and return, for now it just
> diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
> index 6546ca9d4d3f1..6a4797dec34b4 100644
> --- a/arch/sparc/kernel/setup_64.c
> +++ b/arch/sparc/kernel/setup_64.c
> @@ -15,7 +15,6 @@
>  #include <linux/ptrace.h>
>  #include <asm/smp.h>
>  #include <linux/user.h>
> -#include <linux/screen_info.h>
>  #include <linux/delay.h>
>  #include <linux/fs.h>
>  #include <linux/seq_file.h>
> @@ -68,18 +67,6 @@
>  DEFINE_SPINLOCK(ns87303_lock);
>  EXPORT_SYMBOL(ns87303_lock);
>
> -struct screen_info screen_info = {
> -	0, 0,			/* orig-x, orig-y */
> -	0,			/* unused */
> -	0,			/* orig-video-page */
> -	0,			/* orig-video-mode */
> -	128,			/* orig-video-cols */
> -	0, 0, 0,		/* unused, ega_bx, unused */
> -	54,			/* orig-video-lines */
> -	0,                      /* orig-video-isVGA */
> -	16                      /* orig-video-points */
> -};
> -
>  static void
>  prom_console_write(struct console *con, const char *s, unsigned int n)
>  {
> diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
> index aba3ff4e60d85..3f22d0537818d 100644
> --- a/arch/xtensa/kernel/setup.c
> +++ b/arch/xtensa/kernel/setup.c
> @@ -19,7 +19,6 @@
>  #include <linux/init.h>
>  #include <linux/mm.h>
>  #include <linux/proc_fs.h>
> -#include <linux/screen_info.h>
>  #include <linux/kernel.h>
>  #include <linux/percpu.h>
>  #include <linux/reboot.h>
> @@ -49,17 +48,6 @@
>  #include <asm/timex.h>
>  #include <asm/traps.h>
>
> -#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
> -struct screen_info screen_info = {
> -	.orig_x = 0,
> -	.orig_y = 24,
> -	.orig_video_cols = 80,
> -	.orig_video_lines = 24,
> -	.orig_video_isVGA = 1,
> -	.orig_video_points = 16,
> -};
> -#endif
> -
>  #ifdef CONFIG_BLK_DEV_INITRD
>  extern unsigned long initrd_start;
>  extern unsigned long initrd_end;

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
