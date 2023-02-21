Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9223069E917
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBUUoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBUUoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:44:32 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1D8DBD2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:44:31 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id 76so2645978iou.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49jaS/AoSPvQMwYGklpLYAUlZviDdzb1WWfRNr+yMgk=;
        b=TiW6dYtn3K777+JOBrVQT5giuhxe9NEzMr9OlXgXryxTH/e+GodtHhRXpHs6cGuj13
         GYNwFVOvFc3XYD0mhC6djWiz4FP2IrJ+ff7pv1EYoo+gvcJIu98SEZRrEPc0I380Z4uu
         h0f5XpW9dmpOsKofkV20IHDPewuoH9HrykCrvEopHGdJj2xBjIw2YF7r7dsj9X8KaMYZ
         Bz9e31IwZ1NXgcmICMvoDC8iSf78f5m87hSvXUtaHw5MPndaWCBlx3pB1XhgL3KioyAr
         g2wbIyDDzBBaZT8QM39vDNL0ikAZLnP6aJqT3EeXtiZTRTpN13UccN7FoYb0eKIT8F34
         F/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49jaS/AoSPvQMwYGklpLYAUlZviDdzb1WWfRNr+yMgk=;
        b=HmmUK0mnYp4iZz7H5U5n6kbpiboMiWCjKq8cPq/+mZJjNa2d7fuJDTS5UNVfe/TnQ5
         8ITj0BWbgO3DWL+5SqhQXxHZSaO3tT3zXjWJ9jjGoQRQa1XVeIew+jqjtAbFdcIOwcI8
         11rDnRI526BqQz3SIYV9P0ang/ABYsqX7ksA7FV3EzxtSlNy21dzSYYEapx4WyUmCKOK
         Vy5XF7FecHpnrWl4LxPlX2sZs7FTQfcMjpuRjraSd5r5stXRmB+Sa6OwODdjvI5+EbHK
         PUtypRrtNGpFIYgtmy+dJCc+WBXusBN6X/7HcrsT9HF/H3o6hzK1gokW3g349mUa3Vts
         Dtwg==
X-Gm-Message-State: AO0yUKVO4uvHsDSXLRZqHeNrCIbNDEeIcFp+ssDwB6HJ23SNKk7nu6vI
        Vr98IKng5+yoaFqYXWZCG2HVEKMZ61PwZzZJSnU=
X-Google-Smtp-Source: AK7set9W25tIgR49lWpRHuKJM7verQSDd5z12u/1YC2H1N1xsBFfZkTqFM1FKHmfAivHbyiMhrIycA==
X-Received: by 2002:a5e:da41:0:b0:73a:6d8e:9e34 with SMTP id o1-20020a5eda41000000b0073a6d8e9e34mr4221940iop.1.1677012270750;
        Tue, 21 Feb 2023 12:44:30 -0800 (PST)
Received: from [172.16.32.78] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id y3-20020a6bc403000000b007407e365832sm728702ioa.23.2023.02.21.12.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 12:44:30 -0800 (PST)
Message-ID: <749b6e7c-244e-fdfb-b95c-1803678b8bdc@landley.net>
Date:   Tue, 21 Feb 2023 14:57:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: [PATCH 3/5] Wire up CONFIG_DEVTMPFS_MOUNT to initramfs.
Content-Language: en-US
From:   Rob Landley <rob@landley.net>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Li Zhe <lizhe.67@bytedance.com>
In-Reply-To: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel has had CONFIG_DEVTMPFS_MOUNT for years, but it only applied to
fallback ROOT= not initramfs/initmpfs. As long as the config option exists,
it might as well work.

I use this for board bringup: populating a chdir and calling cpio as a
normal user often leaves /dev empty (because mknod requires root access),
meaning no /dev/console for init/main.c to open, meaning init runs without
stdin/stdout/stderr and has to mount devtmpfs and redirect the filehandles
blind with no error output if something goes wrong.

Signed-off-by: Rob Landley <rob@landley.net>
Previously: https://lkml.org/lkml/2017/9/13/651
---
 init/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index e1c3911d7c70..eca7ba2c2764 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1636,7 +1636,6 @@ static noinline void __init kernel_init_freeable(void)
 	kunit_run_all_tests();
 
 	wait_for_initramfs();
-	console_on_rootfs();
 
 	/*
 	 * check if there is an early userspace init.  If yes, let it do all
@@ -1645,7 +1644,11 @@ static noinline void __init kernel_init_freeable(void)
 	if (init_eaccess(ramdisk_execute_command) != 0) {
 		ramdisk_execute_command = NULL;
 		prepare_namespace();
+	} else if (IS_ENABLED(CONFIG_DEVTMPFS_MOUNT)) {
+		init_mkdir("/dev", 0755);
+		devtmpfs_mount();
 	}
+	console_on_rootfs();
 
 	/*
 	 * Ok, we have completed the initial bootup, and
