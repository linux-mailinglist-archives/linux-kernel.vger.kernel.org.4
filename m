Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609FA5F741C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 08:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJGGIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJGGIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:08:50 -0400
Received: from forward500j.mail.yandex.net (forward500j.mail.yandex.net [5.45.198.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552F2B2772
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 23:08:47 -0700 (PDT)
Received: from sas1-78334f65778a.qloud-c.yandex.net (sas1-78334f65778a.qloud-c.yandex.net [IPv6:2a02:6b8:c08:b21f:0:640:7833:4f65])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 065F76CB6733;
        Fri,  7 Oct 2022 09:08:46 +0300 (MSK)
Received: by sas1-78334f65778a.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id gnALNBxKrX-8gi0sD8f;
        Fri, 07 Oct 2022 09:08:44 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1665122925;
        bh=/dZOB0OZJ5ewGOYu6Vfqo3dohgfS+f5k8XzKDbToPI0=;
        h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
        b=iRCL76I/Z5mJWT4zaddxYfALWpgqZn2sHdNjdOuO/IP5PzDvVxEcsgiKDEuKMl29I
         DSnX1ikLFGBDZBU9qGlr5A0yGMRzjZXRmh7Fghn7MazWYgaw77in7dHvQLLLizxlaa
         td9mpUR0go+l/s8gTdV06Bgb3ipi06Spsx+Zg48E=
Authentication-Results: sas1-78334f65778a.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Date:   Fri, 7 Oct 2022 09:08:42 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     linux@yadro.com, Nikita Shubin <n.shubin@yadro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Yury Norov <yury.norov@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: fix multi-letter extension compare
Message-ID: <20221007090842.69272c4a@redslave.neermore.group>
In-Reply-To: <20221006070257.11632-1-nikita.shubin@maquefel.me>
References: <20221006070257.11632-1-nikita.shubin@maquefel.me>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Atish,

My bad, i somehow decided that 'sscofpmf' should
be 'zsscofpmf' in device tree, but it's 'Sscofpmf' actually.

Sorry for noise please ignore this patch.

On Thu,  6 Oct 2022 10:02:56 +0300
Nikita Shubin <nikita.shubin@maquefel.me> wrote:

> From: Nikita Shubin <n.shubin@yadro.com>
> 
> Increment ext pointer to match letters after 'z' character, so it
> points to actual extension name.
> 
> Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
> ---
> Hello Atish,
> 
> Sorry to blame you, but i double checked this and i don't see a way 
> how extensions from device tree could be successfully matched with 
> encoded ones without incrementing the ext pointer or prepending 
> the encoded extensions with 'z' letter.
> 
> I have no idea how this could slip through review - am i missing
> something ? ---
>  arch/riscv/kernel/cpufeature.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c
> b/arch/riscv/kernel/cpufeature.c index 3b5583db9d80..031546052dc0
> 100644 --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -199,6 +199,7 @@ void __init riscv_fill_hwcap(void)
>  				this_hwcap |= isa2hwcap[(unsigned
> char)(*ext)]; set_bit(*ext - 'a', this_isa);
>  			} else {
> +				ext++;
>  				SET_ISA_EXT_MAP("sscofpmf",
> RISCV_ISA_EXT_SSCOFPMF); SET_ISA_EXT_MAP("svpbmt",
> RISCV_ISA_EXT_SVPBMT); SET_ISA_EXT_MAP("zicbom",
> RISCV_ISA_EXT_ZICBOM);

