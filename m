Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EEE5BE353
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiITKfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiITKei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:34:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421D37436B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 03:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663669992; x=1695205992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rLvjKx4Yb1X8lHBkqWwaF6OHYgPt5zI/9dOx67nKFdI=;
  b=eFNIRC3oVTgZQwK30vQuRPNfh9FPqd8Q/uS2MVHvnETfQGHK8LM5bAgi
   cEeXrMNOsM1u2fpmk18naIpSAHLjGCF3jUne5YwifQP4ZTHiVG1iEXUip
   +YSCN9hWgn9w1iyCtaVF6xE0wGYzytXksnJ/zEz+0/SpI2ClG7xiLynxP
   yyxUS5/PBnz7/U1a/bSbprwi5L3itYlwx/KH10Pu18HmhenHkOFrLvpdl
   KGXm698uX7f8AHgc8Wv+XSJV5ZRU/WC5Ls6R74vZswJqOJlEfmzz2yeN3
   YRcixDZx9OpjYVbFidg1O32Jv6EEqG9nDrjkv7bKICQ2mbW0p//3pycxT
   w==;
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="174706509"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Sep 2022 03:32:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 20 Sep 2022 03:32:42 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 20 Sep 2022 03:32:40 -0700
Date:   Tue, 20 Sep 2022 11:32:20 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Binglei Wang <wang.binglei@h3c.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <l3b2w1@gmail.com>
Subject: Re: [PATCH] rethook: add riscv rethook implementation.
Message-ID: <YymWtBokuXK3cGEa@wendy>
References: <20220920093630.32085-1-wang.binglei@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220920093630.32085-1-wang.binglei@h3c.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 05:36:30PM +0800, Binglei Wang wrote:
> From: "wang.binglei" <wang.binglei@h3c.com>
> 
> Most of the code copied from
> arch/riscv/kernel/probes/kprobes_trampoline.S

Hey Wang Binglei,

Please use the commit log to explain the reasons behind the change you
are making:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

> 
> Signed-off-by: wang.binglei <wang.binglei@h3c.com>

Unfortunately I don't know much about Asian naming, but I assume that
the . is not part of your name?

> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> index e6e950b7c..2c1847921 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -345,6 +345,7 @@ int __init arch_populate_kprobe_blacklist(void)
>         return ret;
>  }
> 
> +#ifndef CONFIG_KRETPROBE_ON_RETHOOK

This seems quite unusual, other archs don't seem to have ifdef-ery
using CONFIG_KRETPROBE_ON_RETHOOK in their arch code so why should
RISC-V?

>  void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
>  {
>         return (void *)kretprobe_trampoline_handler(regs, NULL);
> @@ -357,6 +358,12 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
>         ri->fp = NULL;
>         regs->ra = (unsigned long) &__kretprobe_trampoline;
>  }
> +#else
> +void __kprobes *trampoline_probe_handler(struct pt_regs *regs)
> +{
> +       return NULL;
> +}
> +#endif
 

> diff --git a/arch/riscv/kernel/probes/rethook_trampoline.S b/arch/riscv/kernel/probes/rethook_trampoline.S
> new file mode 100644
> index 000000000..aa79630ac
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/rethook_trampoline.S
> @@ -0,0 +1,94 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * rethook trampoline.
> + * Copied from arch/riscv/kernel/probes/kprobes_trampoline.S

Is this a 1:1 copy? If so, could the code be shared?
 
> This e-mail and its attachments contain confidential information from New H3C, which is
> intended only for the person or entity whose address is listed above. Any use of the
> information contained herein in any way (including, but not limited to, total or partial
> disclosure, reproduction, or dissemination) by persons other than the intended
> recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
> by phone or email immediately and delete it!

Uh-oh! You'll have to work with your IT to get this removed before your
patches can be accepted:
https://lore.kernel.org/all/YgEnxmD9ZE4jVhP5@kroah.com/

The patch does not apply to -next for me either..

Thanks,
Conor.

