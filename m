Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24566492E6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 07:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiLKGVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 01:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiLKGUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 01:20:13 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515F013F72
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:18:07 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id w26so502434pfj.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRXGqW6LKv+O98IDnEbymxxSgNQqMDjFc6OS+Rapwyo=;
        b=jlLNrLrdlC6Ecqqm+duNB6r/VLLI9i+rg6zI7FY8RNEjZIJBfF1U9gFEmI7akl9gwY
         Dw+ZskgYryRjOPYOl13S7bkNEfZWWOdadwNi3o4gUM85vJJ04Z1M5qyodZ9o3jXI4FiN
         unHA8vniPyWa5MrQWbHTToX+nQqV7CwLNN0ePFb8ueganhqAUjHYm0xsJOxC0cNz9JXX
         Vbhl56WQU5C3APOi0h9uuWf4E0HU306tY4wX5EMe2lxCSeecf38oLXGCPwbPON9bik9A
         +G06ZrSA9fPc8iwUuFvUD0M+jDQsyjigAuazhy/U1x3HankaoqTXYGFaBip6xMniWUig
         v1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRXGqW6LKv+O98IDnEbymxxSgNQqMDjFc6OS+Rapwyo=;
        b=Yu/4Vo5hnLPBvYG9OgOzR0Ub9DkRViLa5lFr571EASxULkvmiVMzJTSvN9oMfn3mrN
         z2wHHNq0QkVMl1iFiqjDj8Oey4sYYOE7Jk3gcBPnZytNuSsgorXADUSOXMvuFT66atjF
         bXSbrUTMDuaanFn4lRolQS4D0+5MyS17OovjiXp2sqgYo4EQxz9FKEVxRlmsLpeBTBfa
         ugrbd06EgfJmYWAXd7RBlomBhskbyuwBfGbqp6fchUJCQ4ZRgaM2SSWjlsSlizdCfjYF
         /pvflhjTjAOChcJdRzl6BKv1TxzvomcIBoBdlwPxExTeHyvebvTmeJ35VbQ5ly3l0Sav
         Fiow==
X-Gm-Message-State: ANoB5pnUEqyUNQMTPIJPVE+GtO45zbaDJ8NHnZuHlpTxoTKrjQpg34P8
        Xfb0JKjSK1vEd2PdY/C+AersQg==
X-Google-Smtp-Source: AA0mqf5xXR0ca7y5CYmWfIv0Y64a0lOCnPAdEr3gwQpQ1dspMK+bvpmbbDCkg+BOKaSisa6eTE/ILA==
X-Received: by 2002:a05:6a00:194a:b0:56b:e6b9:9338 with SMTP id s10-20020a056a00194a00b0056be6b99338mr15304446pfk.12.1670739479777;
        Sat, 10 Dec 2022 22:17:59 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id w29-20020aa7955d000000b0054ee4b632dasm3501432pfq.169.2022.12.10.22.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:58 -0800 (PST)
Date:   Sat, 10 Dec 2022 22:17:58 -0800 (PST)
X-Google-Original-Date: Sat, 10 Dec 2022 22:17:17 PST (-0800)
Subject:     Re: [PATCH] riscv: increase boot command line size to 1K
In-Reply-To: <Y4JpmEoKOBIbaVLi@righiandr-XPS-13-7390>
CC:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        emil.renner.berthing@canonical.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     andrea.righi@canonical.com
Message-ID: <mhng-453c777d-2bda-4b15-914b-aeacc4551ff1@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Nov 2022 11:31:36 PST (-0800), andrea.righi@canonical.com wrote:
> On Sat, Nov 26, 2022 at 07:25:01PM +0000, Conor Dooley wrote:
>> On Sat, Nov 26, 2022 at 08:18:43PM +0100, Andrea Righi wrote:
>> > On Sat, Nov 26, 2022 at 06:46:05PM +0000, Conor Dooley wrote:
>> > > Hey Andrea,
>> > >
>> > > On Fri, Nov 25, 2022 at 02:37:13PM +0100, Andrea Righi wrote:
>> > > > Kernel parameters string is limited to 512 characters on riscv (using
>> > > > the default from include/uapi/asm-generic/setup.h).
>> > > >
>> > > > In some testing environments (e.g., qemu with long kernel parameters
>> > > > string) we may exceed this limit, triggering errors like the following:
>> > > >
>> > > > [    3.331893] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
>> > > > [    3.332625] CPU: 2 PID: 1 Comm: sh Not tainted 6.1.0-rc6-kc #1
>> > > > [    3.333233] Hardware name: riscv-virtio,qemu (DT)
>> > > > [    3.333550] Call Trace:
>> > > > [    3.333736] [<ffffffff800062b6>] dump_backtrace+0x1c/0x24
>> > > > [    3.334053] [<ffffffff806e8f54>] show_stack+0x2c/0x38
>> > > > [    3.334260] [<ffffffff806f2d06>] dump_stack_lvl+0x5a/0x7c
>> > > > [    3.334483] [<ffffffff806f2d3c>] dump_stack+0x14/0x1c
>> > > > [    3.334687] [<ffffffff806e92fa>] panic+0x116/0x2d0
>> > > > [    3.334878] [<ffffffff8001b0aa>] do_exit+0x80a/0x810
>> > > > [    3.335079] [<ffffffff8001b1d0>] do_group_exit+0x24/0x70
>> > > > [    3.335287] [<ffffffff8001b234>] __wake_up_parent+0x0/0x20
>> > > > [    3.335502] [<ffffffff80003cee>] ret_from_syscall+0x0/0x2
>> > > > [    3.335857] SMP: stopping secondary CPUs
>> > > > [    3.337561] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000 ]---
>> > > >
>> > > > It seems reasonable enough to increase the default command line size to
>> > > > 1024, like arm, to prevent issues like the one reported above.
>> > >
>> > > error: arch/riscv/include/uapi/asm/setup.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier
>> > >
>> > > Unfortunately this does not build :/
>> > >
>> > > Thanks,
>> > > Conor.
>> >
>> > Oh I see, because it's uapi it needs "WITH Linux-syscall-note",
>> > wondering why I can't reproduce this failure...
>>
>> tuxmake --wrapper ccache --target-arch riscv --directory . \
>> 	--environment=KBUILD_BUILD_TIMESTAMP=@1621270510 \
>> 	--environment=KBUILD_BUILD_USER=tuxmake --environment=KBUILD_BUILD_HOST=tuxmake \
>> 	-o $tmpdir --toolchain llvm -z none -k rv32_defconfig
>>
>> (copy paste from a script)
>> That's what caught it initially & I think should be reproduce able. My
>> own standard build script also runs all of the HDRINST stuff if they've
>> changed since the last time a given toolchain was used so it reproduces
>> locally for me too.
>
> Ah! I'm pretty sure it's HDRINST, I'm just doing make, cross-compiling
> the kernel, and running it directly from the build directory with a
> custom script (that is basically a wrapper to qemu), so I don't need to
> actually install anything. That's why I didn't catch the error.
>
> Thanks for sharing that, I'll make sure to test also a proper install
> next time. :)
>
> -Andrea
>
>>
>> > Anyway, as pointed out by Alexandre, there was already a previous
>> > discussion about this topic:
>> > https://lore.kernel.org/lkml/CACT4Y+YYAfTafFk7DE0B=qQFgkPXS7492AhBdY_CP1WdB8CGfA@mail.gmail.com/T/
>> >
>> > Hopefully this change will be addressed there (and the patch land in
>> > -next at least), otherwise I'll post a v2.

I posted a new version of the asm-generic changes here: 
https://lore.kernel.org/r/20221211061358.28035-1-palmer@rivosinc.com/


>>
>> Yup, I noticed that thread - in fact I was going to link it yesterday
>> before I saw Alex already had ;)
>>
>> Thanks,
>> Conor.
