Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19686315DC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 20:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKTTd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 14:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTTd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 14:33:58 -0500
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9141B9E3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 11:33:56 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 5B748604E6;
        Sun, 20 Nov 2022 20:33:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1668972834; bh=cuWgF00b3mnYrgyBOY0m4pHZVF+nrc6UsOgqVeF01Bg=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=aP+ZdKg4cCEKfGnZqzGtGYNM9D7ZpNYpEDrM8xcYfzRMO+V85NOo6jbXrVapN7sF6
         71YPlp6obwYdMWlug0I6rm4xkZrLUIH4TooFJSA56QIdotk+Y6wPrFEvF7iz2o4o0c
         N8r8fjp62mH58AUL9rONXSYEiATrVvcQEA+VcAHRJeafxSLpHfUbM/7NW5Sj9YV5gH
         UPjA6z6tFjiw9fZBjXgppX1jmKs2t26PCJ1fm/SsFpvuffgWcMid/RhpGFMcE1ei4K
         Pr6rMRVlRow4jF66c+IGwv1WkGK7+VMl2onEpWeoNv0IPbw0Qvj5jwM9UCz4uU2kzM
         Z+0WFJ5kLMjIg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7BExzCu1TOGV; Sun, 20 Nov 2022 20:33:51 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.198.198])
        by domac.alu.hr (Postfix) with ESMTPSA id 1D799604E4;
        Sun, 20 Nov 2022 20:33:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1668972831; bh=cuWgF00b3mnYrgyBOY0m4pHZVF+nrc6UsOgqVeF01Bg=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=faUdwWOfCjD5CO56EsTPPbut/fm5WHBkm2t5VlpDL5LnbXGSL1JAsxc8zL3KIWw8u
         TiXuv1MK5wFA3LkFeqHclX8iVp5gEFwgQ/aaomI2dSG4F7Z9yP59tiZnfUVnOnyeJh
         e8FFTl7+jUrDPZ9Em2IK26B7H4LMyK5hGx1q+oL3FVSUgWW0FlWPAYvcwRk3nZvQuN
         Js46JA+BjAkMbuWn0rRyHV71K9VH6als0XRDjKOvyAdyYt/RenjsIXF2PWoC/FQBZ8
         vfAy+QJfc4NwAlTdy/5kr7naYjT51MmYd2rDZa5UoY4WcS3EDvimhrPaTmBBOhx9Yu
         d6Po5+P+XlNuA==
Message-ID: <ac3d94c2-6ed8-21d1-3ef6-8970bee5262a@alu.unizg.hr>
Date:   Sun, 20 Nov 2022 20:33:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: BUG: BISECTED: in squashfs_xz_uncompress() (Was: RCU stalls in
 squashfs_readahead())
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     paulmck@kernel.org
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>, phillip.lougher@gmail.com,
        Thorsten Leemhuis <regressions@leemhuis.info>, elliott@hpe.com
References: <9697fcf5-4213-3d5e-176a-e82d4bd07870@alu.unizg.hr>
 <eac8af79-8936-f845-c8dd-c63ebf0d5e81@alu.unizg.hr>
 <02877aee-8c05-6534-8a91-94ba366d0276@squashfs.org.uk>
 <20221118155534.GJ4001@paulmck-ThinkPad-P17-Gen-1>
 <dd430080-774b-1cba-1758-2bf92cb1acac@alu.unizg.hr>
 <20221120175016.GC4001@paulmck-ThinkPad-P17-Gen-1>
 <8e62a31f-3ef8-71ec-6181-2afa56eeb5db@alu.unizg.hr>
In-Reply-To: <8e62a31f-3ef8-71ec-6181-2afa56eeb5db@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

P.S.

Sorry, Paul, the patches did not apply on the mainline "master" or "v6.1-rc5" nor "v6.0.9".

Here is the session log:

mtodorov@domac:~/linux/kernel/linux_stable_build_b$ git checkout v6.1-rc5
Note: checking out 'v6.1-rc5'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

   git checkout -b <new-branch-name>

HEAD is now at 094226ad94f4 Linux 6.1-rc5
mtodorov@domac:~/linux/kernel/linux_stable_build_b$ git apply ../remove-android.patch
error: patch failed: drivers/Makefile:176
error: drivers/Makefile: patch does not apply
error: patch failed: drivers/android/Kconfig:1
error: drivers/android/Kconfig: patch does not apply
error: patch failed: kernel/configs/android-base.config:7
error: kernel/configs/android-base.config: patch does not apply
error: patch failed: kernel/rcu/Kconfig.debug:86
error: kernel/rcu/Kconfig.debug: patch does not apply
error: patch failed: tools/testing/selftests/filesystems/binderfs/config:1
error: tools/testing/selftests/filesystems/binderfs/config: patch does not apply
error: patch failed: tools/testing/selftests/sync/config:1
error: tools/testing/selftests/sync/config: patch does not apply
mtodorov@domac:~/linux/kernel/linux_stable_build_b$ git apply ../introduce-rcu-stall-timeout.patch
error: patch failed: Documentation/admin-guide/kernel-parameters.txt:4893
error: Documentation/admin-guide/kernel-parameters.txt: patch does not apply
error: patch failed: kernel/rcu/Kconfig.debug:91
error: kernel/rcu/Kconfig.debug: patch does not apply
error: patch failed: kernel/rcu/rcu.h:210
error: kernel/rcu/rcu.h: patch does not apply
error: patch failed: kernel/rcu/tree_exp.h:496
error: kernel/rcu/tree_exp.h: patch does not apply
error: patch failed: kernel/rcu/tree_stall.h:25
error: kernel/rcu/tree_stall.h: patch does not apply
error: patch failed: kernel/rcu/update.c:506
error: kernel/rcu/update.c: patch does not apply
mtodorov@domac:~/linux/kernel/linux_stable_build_b$ git checkout v6.0.9
Checking out files: 100% (12048/12048), done.
Previous HEAD position was 094226ad94f4 Linux 6.1-rc5
HEAD is now at be8b93b5cc7d Linux 6.0.9
You have mail in /var/mail/mtodorov
mtodorov@domac:~/linux/kernel/linux_stable_build_b$ git apply ../remove-android.patch
error: patch failed: drivers/Makefile:176
error: drivers/Makefile: patch does not apply
error: patch failed: drivers/android/Kconfig:1
error: drivers/android/Kconfig: patch does not apply
error: patch failed: kernel/configs/android-base.config:7
error: kernel/configs/android-base.config: patch does not apply
error: patch failed: kernel/rcu/Kconfig.debug:86
error: kernel/rcu/Kconfig.debug: patch does not apply
error: patch failed: tools/testing/selftests/filesystems/binderfs/config:1
error: tools/testing/selftests/filesystems/binderfs/config: patch does not apply
error: patch failed: tools/testing/selftests/sync/config:1
error: tools/testing/selftests/sync/config: patch does not apply
mtodorov@domac:~/linux/kernel/linux_stable_build_b$ git apply ../introduce-rcu-stall-timeout.patch
error: patch failed: Documentation/admin-guide/kernel-parameters.txt:4893
error: Documentation/admin-guide/kernel-parameters.txt: patch does not apply
error: patch failed: kernel/rcu/Kconfig.debug:91
error: kernel/rcu/Kconfig.debug: patch does not apply
error: patch failed: kernel/rcu/rcu.h:210
error: kernel/rcu/rcu.h: patch does not apply
error: patch failed: kernel/rcu/tree_exp.h:496
error: kernel/rcu/tree_exp.h: patch does not apply
error: patch failed: kernel/rcu/tree_stall.h:25
error: kernel/rcu/tree_stall.h: patch does not apply
error: patch failed: kernel/rcu/update.c:506
error: kernel/rcu/update.c: patch does not apply
mtodorov@domac:~/linux/kernel/linux_stable_build_b$

Now I really got to try to catch some sleep because I work my day job in the morning.

I must admit that I am not enthusiastic about these patches for I think they only mask
the problem of stalls: removing reports from the logs, but cores will still lock up.

Besides, I also hoped to develop multimedia for Android devices, too, as a part of our
research, to academically justify my work on the Linux kernel bug bisection and learning
about the kernel proper.

I still need to figure out a way to present my results to the academic community, to
have it justified and to have our University more visible and ranked on the world list. ;-)

Thanks,
Mirsad

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

