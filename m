Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B4B639828
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 20:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiKZTbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 14:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKZTbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 14:31:42 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B59D18366
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 11:31:40 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6644C3F03D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 19:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669491098;
        bh=2zpd7a1SGgeohkv0SUw3EJvuZe2S1i4FaVDUMzJj/io=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=mf3B5inULZoXmZFW5YNyYXAtufyvHwvR8+BZy9rjd7e9m7mgqN3LAT7ltVP1x9kz4
         B5OD3xG/MO2SmMgL4SIw73x/qNEzLiEDLWgizUbv+pn1Kwo0JDj7ID0r8+x5XJRL7E
         O59opDiuBI128/N4ngH1vdHzxDXDb0E7IoQw4JsiMaSNnMt1BLQ00JvZeN+ry0PDLU
         ui0V1lDwKAS55pFHz/LHJscb56e1y8WxUOeZYL1tzRIs5P6jH0cXCAz1kxj/IXa5qo
         uof2sRWMmmh//IsmJPAdecWZQZLW2M2cf8gYl0cxqnhL01r5TnZlkZq1kfJE1CA5yr
         h9w+GH4cdwPBw==
Received: by mail-ed1-f70.google.com with SMTP id h8-20020a056402280800b0046af59e0986so1019255ede.22
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 11:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zpd7a1SGgeohkv0SUw3EJvuZe2S1i4FaVDUMzJj/io=;
        b=mwm8flCK/9rjwUfKzXcbW6HqWwWb17PRh6Z77fqAjuiWyV8qqzdtTYQRt/j0omr6xK
         yWhbIpXUD6bob4NaaL4yiwqH0dBLugSmbnE0SGtEKuwjArLsaQLagnfKFCKRyuLRWsWB
         kmRbbM0yDQX5XWXLwxs1M57YzWPlKjZnxxcpyNR0/QMzTm/J/0mtDqD/4QSF6GI2fPMg
         kBIrp5i2VtGaKvdkxXE+tCouFOv3JfbaALhLingnPJiXSVcletiGwLSf878UVoHlGBRA
         pLkwolr8f7MSm+w78fLvjVa+ponWAtQgc7a3xNTur264JRi6u6LyZ/BtZoBsIuY+SGdH
         yL1A==
X-Gm-Message-State: ANoB5pkH8KgOk0ZZGFRuGmxmHaA+spyFK+lqoGI2WedkRjNGVQ2LhwTD
        h6ysWE2Y5A8OAG4N2mwQpABC7r5RyxlCwRW5crCVzDFVfLWARKTYaajmEztkCzF1F/IlbGABtUr
        2/Rhqp+rrF1y4BO4UbYsxVonQxj9MVm/eT4MCpD38KA==
X-Received: by 2002:a17:906:3914:b0:7b2:7e90:53e4 with SMTP id f20-20020a170906391400b007b27e9053e4mr19225621eje.645.1669491098054;
        Sat, 26 Nov 2022 11:31:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6+ar2joRyP4lT0A8Cnz1ZF3qCGAADOB6leDxvYPArumSpvtwvdGHBuZ/LUNr/tP2A+qq4DVg==
X-Received: by 2002:a17:906:3914:b0:7b2:7e90:53e4 with SMTP id f20-20020a170906391400b007b27e9053e4mr19225604eje.645.1669491097766;
        Sat, 26 Nov 2022 11:31:37 -0800 (PST)
Received: from localhost ([95.236.177.174])
        by smtp.gmail.com with ESMTPSA id n3-20020a056402514300b0045d59e49acbsm3333844edd.7.2022.11.26.11.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 11:31:37 -0800 (PST)
Date:   Sat, 26 Nov 2022 20:31:36 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: increase boot command line size to 1K
Message-ID: <Y4JpmEoKOBIbaVLi@righiandr-XPS-13-7390>
References: <20221125133713.314796-1-andrea.righi@canonical.com>
 <Y4Je7chN+fQM3NpP@spud>
 <Y4Jmk74enBTwkNcR@righiandr-XPS-13-7390>
 <Y4JoDSXOLepJX8mI@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4JoDSXOLepJX8mI@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 07:25:01PM +0000, Conor Dooley wrote:
> On Sat, Nov 26, 2022 at 08:18:43PM +0100, Andrea Righi wrote:
> > On Sat, Nov 26, 2022 at 06:46:05PM +0000, Conor Dooley wrote:
> > > Hey Andrea,
> > > 
> > > On Fri, Nov 25, 2022 at 02:37:13PM +0100, Andrea Righi wrote:
> > > > Kernel parameters string is limited to 512 characters on riscv (using
> > > > the default from include/uapi/asm-generic/setup.h).
> > > > 
> > > > In some testing environments (e.g., qemu with long kernel parameters
> > > > string) we may exceed this limit, triggering errors like the following:
> > > > 
> > > > [    3.331893] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
> > > > [    3.332625] CPU: 2 PID: 1 Comm: sh Not tainted 6.1.0-rc6-kc #1
> > > > [    3.333233] Hardware name: riscv-virtio,qemu (DT)
> > > > [    3.333550] Call Trace:
> > > > [    3.333736] [<ffffffff800062b6>] dump_backtrace+0x1c/0x24
> > > > [    3.334053] [<ffffffff806e8f54>] show_stack+0x2c/0x38
> > > > [    3.334260] [<ffffffff806f2d06>] dump_stack_lvl+0x5a/0x7c
> > > > [    3.334483] [<ffffffff806f2d3c>] dump_stack+0x14/0x1c
> > > > [    3.334687] [<ffffffff806e92fa>] panic+0x116/0x2d0
> > > > [    3.334878] [<ffffffff8001b0aa>] do_exit+0x80a/0x810
> > > > [    3.335079] [<ffffffff8001b1d0>] do_group_exit+0x24/0x70
> > > > [    3.335287] [<ffffffff8001b234>] __wake_up_parent+0x0/0x20
> > > > [    3.335502] [<ffffffff80003cee>] ret_from_syscall+0x0/0x2
> > > > [    3.335857] SMP: stopping secondary CPUs
> > > > [    3.337561] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000 ]---
> > > > 
> > > > It seems reasonable enough to increase the default command line size to
> > > > 1024, like arm, to prevent issues like the one reported above.
> > > 
> > > error: arch/riscv/include/uapi/asm/setup.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier
> > > 
> > > Unfortunately this does not build :/
> > > 
> > > Thanks,
> > > Conor.
> > 
> > Oh I see, because it's uapi it needs "WITH Linux-syscall-note",
> > wondering why I can't reproduce this failure...
> 
> tuxmake --wrapper ccache --target-arch riscv --directory . \
> 	--environment=KBUILD_BUILD_TIMESTAMP=@1621270510 \
> 	--environment=KBUILD_BUILD_USER=tuxmake --environment=KBUILD_BUILD_HOST=tuxmake \
> 	-o $tmpdir --toolchain llvm -z none -k rv32_defconfig
> 
> (copy paste from a script)
> That's what caught it initially & I think should be reproduce able. My
> own standard build script also runs all of the HDRINST stuff if they've
> changed since the last time a given toolchain was used so it reproduces
> locally for me too.

Ah! I'm pretty sure it's HDRINST, I'm just doing make, cross-compiling
the kernel, and running it directly from the build directory with a
custom script (that is basically a wrapper to qemu), so I don't need to
actually install anything. That's why I didn't catch the error.

Thanks for sharing that, I'll make sure to test also a proper install
next time. :)

-Andrea

> 
> > Anyway, as pointed out by Alexandre, there was already a previous
> > discussion about this topic:
> > https://lore.kernel.org/lkml/CACT4Y+YYAfTafFk7DE0B=qQFgkPXS7492AhBdY_CP1WdB8CGfA@mail.gmail.com/T/
> > 
> > Hopefully this change will be addressed there (and the patch land in
> > -next at least), otherwise I'll post a v2.
> 
> Yup, I noticed that thread - in fact I was going to link it yesterday
> before I saw Alex already had ;)
> 
> Thanks,
> Conor.
