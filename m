Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8A15F163E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiI3Wlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiI3Wlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:41:40 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B89B1A0D02;
        Fri, 30 Sep 2022 15:41:38 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id h5so2992957vkc.5;
        Fri, 30 Sep 2022 15:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=qK+1XpXUeWz7DtUYCbCDJ17OfbroQAjc/ksiMC53YMY=;
        b=Ib8cTz2+ZET/AStcmt1JDQDWqC2XijOXDxP4bIAOCQrn8/TuIAXIFYeEEy1RAF535U
         rSbAuRdlLCj7ZYF4ooB5cWln9pnvaW7e7upPU2JyTrVtFWS+6mrNCFPYXvLIUhNjZkKP
         6ORWDQGpfc2SzOz8g2ovQXe1WK/yFNJMwxm0G//xMSQSKMzPBmoQilLasSct+lvfYxfV
         UJQoVd1qzc+9Jk61CNO3nCgzp2ELHhhpWT8C5ZEkPe+sd9zfVOILUEzR7gRyxVJG0U4x
         XtZKrgDq4mELlSQFFDmbX/XHzZhYdtHC7+kSa0+x3Qhuttka4JFhg/XPDeVMJVOWBPnx
         DODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qK+1XpXUeWz7DtUYCbCDJ17OfbroQAjc/ksiMC53YMY=;
        b=y7LSDmRxDnkC5ZRpIL9CAamJyXtE5/rB5jboNPunKHdGdTuc/LmfeWf8Pts02n8DXy
         XU9nfzCcZpN/e/9+C4qW1aYXRKOMuMq2UGuj32tmZXSQDcCseoAQgHteqOLF9Nivfdzt
         889dEUSCoa8u+lx/DdBelreF3kMtwDz+jP1upKNK+sOq5yPPojI089U3Dfx5DXfl7xIT
         Xw3VYqIGO9GcOGR0xfvx9SwmkkALIQofq7zXc527OeJle3JocichDoIh+x/qj1YTL4Dd
         xLGHjg4t5fBIyZPdKqvpCfG8EJVSD0UdcLcW6sSbF4PY4UiHT+PFixeeICi2g7g2oeSI
         +vAQ==
X-Gm-Message-State: ACrzQf0QSeANPD5wJbLLHmhzXSB50/foFqxdxA+7oOWgWTySQ8rVpuv2
        Yae1NEX3Gk7ZAoypcICK9eU=
X-Google-Smtp-Source: AMsMyM5KPzilcw8oR2MJNhr9bNGTR52EZrlN9/UQwQXn9X6ZItZkWgDMUGK1dkDiNlGG8P3w6xwjaA==
X-Received: by 2002:a05:6122:17a4:b0:3a4:e5ca:dfa with SMTP id o36-20020a05612217a400b003a4e5ca0dfamr5490677vkf.32.1664577697278;
        Fri, 30 Sep 2022 15:41:37 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cc:d13c:46d7:2f3e:5663:520a])
        by smtp.gmail.com with ESMTPSA id t12-20020ab0688c000000b0039f94d9d39fsm2445973uar.6.2022.09.30.15.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 15:41:37 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        "Hans J. Koch" <hjk@hansjkoch.de>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 1/3] uio: uio_dmem_genirq: Fix missing unlock in irq configuration
Date:   Fri, 30 Sep 2022 19:40:57 -0300
Message-Id: <20220930224100.816175-2-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930224100.816175-1-rafaelmendsr@gmail.com>
References: <20220930224100.816175-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b74351287d4b ("uio: fix a sleep-in-atomic-context bug in
uio_dmem_genirq_irqcontrol()") started calling disable_irq() without
holding the spinlock because it can sleep. However, that fix introduced
another bug: if interrupt is already disabled and a new disable request
comes in, then the spinlock is not unlocked:

root@localhost:~# printf '\x00\x00\x00\x00' > /dev/uio0
root@localhost:~# printf '\x00\x00\x00\x00' > /dev/uio0
root@localhost:~# [   14.851538] BUG: scheduling while atomic: bash/223/0x00000002
[   14.851991] Modules linked in: uio_dmem_genirq uio myfpga(OE) bochs drm_vram_helper drm_ttm_helper ttm drm_kms_helper drm snd_pcm ppdev joydev psmouse snd_timer snd e1000fb_sys_fops syscopyarea parport sysfillrect soundcore sysimgblt input_leds pcspkr i2c_piix4 serio_raw floppy evbug qemu_fw_cfg mac_hid pata_acpi ip_tables x_tables autofs4 [last unloaded: parport_pc]
[   14.854206] CPU: 0 PID: 223 Comm: bash Tainted: G           OE      6.0.0-rc7 #21
[   14.854786] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   14.855664] Call Trace:
[   14.855861]  <TASK>
[   14.856025]  dump_stack_lvl+0x4d/0x67
[   14.856325]  dump_stack+0x14/0x1a
[   14.856583]  __schedule_bug.cold+0x4b/0x5c
[   14.856915]  __schedule+0xe81/0x13d0
[   14.857199]  ? idr_find+0x13/0x20
[   14.857456]  ? get_work_pool+0x2d/0x50
[   14.857756]  ? __flush_work+0x233/0x280
[   14.858068]  ? __schedule+0xa95/0x13d0
[   14.858307]  ? idr_find+0x13/0x20
[   14.858519]  ? get_work_pool+0x2d/0x50
[   14.858798]  schedule+0x6c/0x100
[   14.859009]  schedule_hrtimeout_range_clock+0xff/0x110
[   14.859335]  ? tty_write_room+0x1f/0x30
[   14.859598]  ? n_tty_poll+0x1ec/0x220
[   14.859830]  ? tty_ldisc_deref+0x1a/0x20
[   14.860090]  schedule_hrtimeout_range+0x17/0x20
[   14.860373]  do_select+0x596/0x840
[   14.860627]  ? __kernel_text_address+0x16/0x50
[   14.860954]  ? poll_freewait+0xb0/0xb0
[   14.861235]  ? poll_freewait+0xb0/0xb0
[   14.861517]  ? rpm_resume+0x49d/0x780
[   14.861798]  ? common_interrupt+0x59/0xa0
[   14.862127]  ? asm_common_interrupt+0x2b/0x40
[   14.862511]  ? __uart_start.isra.0+0x61/0x70
[   14.862902]  ? __check_object_size+0x61/0x280
[   14.863255]  core_sys_select+0x1c6/0x400
[   14.863575]  ? vfs_write+0x1c9/0x3d0
[   14.863853]  ? vfs_write+0x1c9/0x3d0
[   14.864121]  ? _copy_from_user+0x45/0x70
[   14.864526]  do_pselect.constprop.0+0xb3/0xf0
[   14.864893]  ? do_syscall_64+0x6d/0x90
[   14.865228]  ? do_syscall_64+0x6d/0x90
[   14.865556]  __x64_sys_pselect6+0x76/0xa0
[   14.865906]  do_syscall_64+0x60/0x90
[   14.866214]  ? syscall_exit_to_user_mode+0x2a/0x50
[   14.866640]  ? do_syscall_64+0x6d/0x90
[   14.866972]  ? do_syscall_64+0x6d/0x90
[   14.867286]  ? do_syscall_64+0x6d/0x90
[   14.867626]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[...] stripped
[   14.872959]  </TASK>

('myfpga' is a simple 'uio_dmem_genirq' driver I wrote to test this)

The implementation of "uio_dmem_genirq" was based on "uio_pdrv_genirq" and
it is used in a similar manner to the "uio_pdrv_genirq" driver with respect
to interrupt configuration and handling. At the time "uio_dmem_genirq" was
introduced, both had the same implementation of the 'uio_info' handlers
irqcontrol() and handler(). Then commit 34cb27528398 ("UIO: Fix concurrency
issue"), which was only applied to "uio_pdrv_genirq", ended up making them
a little different. That commit, among other things, changed disable_irq()
to disable_irq_nosync() in the implementation of irqcontrol(). The
motivation there was to avoid a deadlock between irqcontrol() and
handler(), since it added a spinlock in the irq handler, and disable_irq()
waits for the completion of the irq handler.

By changing disable_irq() to disable_irq_nosync() in irqcontrol(), we also
avoid the sleeping-while-atomic bug that commit b74351287d4b ("uio: fix a
sleep-in-atomic-context bug in uio_dmem_genirq_irqcontrol()") was trying to
fix. Thus, this fixes the missing unlock in irqcontrol() by importing the
implementation of irqcontrol() handler from the "uio_pdrv_genirq" driver.
In the end, it reverts commit b74351287d4b ("uio: fix a
sleep-in-atomic-context bug in uio_dmem_genirq_irqcontrol()") and change
disable_irq() to disable_irq_nosync().

It is worth noting that this still does not address the concurrency issue
fixed by commit 34cb27528398 ("UIO: Fix concurrency issue"). It will be
addressed separately in the next commits.

Split out from commit 34cb27528398 ("UIO: Fix concurrency issue").

Fixes: b74351287d4b ("uio: fix a sleep-in-atomic-context bug in uio_dmem_genirq_irqcontrol()")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 drivers/uio/uio_dmem_genirq.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index 1106f3376404..cb283ee36eaa 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -132,13 +132,11 @@ static int uio_dmem_genirq_irqcontrol(struct uio_info *dev_info, s32 irq_on)
 	if (irq_on) {
 		if (test_and_clear_bit(0, &priv->flags))
 			enable_irq(dev_info->irq);
-		spin_unlock_irqrestore(&priv->lock, flags);
 	} else {
-		if (!test_and_set_bit(0, &priv->flags)) {
-			spin_unlock_irqrestore(&priv->lock, flags);
-			disable_irq(dev_info->irq);
-		}
+		if (!test_and_set_bit(0, &priv->flags))
+			disable_irq_nosync(dev_info->irq);
 	}
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
 }
-- 
2.34.1

