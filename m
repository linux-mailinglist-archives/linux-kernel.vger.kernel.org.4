Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DCD74ADCF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjGGJbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjGGJbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:31:18 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548EB1FEE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 02:31:08 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.98.39]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M3UEW-1qH9YK1WR0-000dcP; Fri, 07 Jul 2023 11:29:50 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 992013E7EB; Fri,  7 Jul 2023 11:29:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1688722186; bh=tCQ6HrnYZ/FGc+RkZTXZUlGBozAP7H6M0nYG/YXQEKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=3WIw/LXB6vdjJrH7rsNWzQUPj+aItETbSEUBeCCE5+tFSttHNWNlguptKP/ekbITl
         ejYYS697XK91aoKy7i/jnbLOXybsGpr1GHkU4PIToIvvOC1lPIn5wIZRQRH/q6ovAU
         5MH/KlHKRT3eHE0S+Rp2KhVptm7LC/RfCtOhp0GA=
Date:   Fri, 7 Jul 2023 11:29:46 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Thomas Huth <thuth@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Remove the arch_calc_vm_prot_bits() macro from the
 uapi
Message-ID: <ZKfbCqiiMcUF2qeZ@fjasle.eu>
References: <20230706190217.371721-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230706190217.371721-1-thuth@redhat.com>
X-Provags-ID: V03:K1:0/+r3K2elFy/AStcbUMDJZzFiPdvBMt49zrIRuNrCVat+Xsj8XG
 toEmDLrDjTi5Owv4hjHzgh7xx/QD8aiQPL+2WRLJUYeztZiLEpEEowrSISLTcLLAO38rSyP
 6kCpYQU/ZeSmPEDXg1MIYCKIBFohjn9rYZCmqeDo6OKTo6c9FdQprurpxX+/HCWyVbSpdHe
 xoRo688nMpt+Z9CaCxgxA==
UI-OutboundReport: notjunk:1;M01:P0:ivbDZpvZmLw=;LRwQ3wKoxbiqPojrczcPaEvna/U
 +/8hrHqCBoY6dgWJBgE0X3axkec4/7x2CZ9z/ukGfpZFMKZzZpJ9jcF9N8BrEuGxXiS/bM5pu
 UUifWU4gZebeypJXx8OFOFw+wJLsj7UFF4zRlNBVI/MlCbEuXhtJRzcI5w4aaSroKyzTVa/Wd
 fBPfnSzLUswQt99DoeeIeT0fB2vp9rVYe1QVzWZ6GX/JLzU8+sgYE8W0syD+llrBMpiqN6kUZ
 0qTgPUOHBO7hM8Le2tuBzkTWyKWydnaHPgYJy2rPq/U+hWVlrJohiDUU467y4FpTsJBZp/xci
 DQoAQhHJW0J7EUsnt4OPN/RAURFmEXS9GJl6wco4pkD8E+jbiEOO8ZR0wtPDkBDkqa1JYOWT4
 GHT5gRt17FtZQn8APuEmG1TrM5wNoWN8YGcfBgOasj9Lr2wm4ygsBBSfAyff3+LU77MRtlD/Y
 u3cr+zlsjZsOq0EjaSuI94MGQV0bigdQF5r95yazFPb94FTIegpPI2lZWUc/wihKEii2KUoCu
 5bglh04s/gra1b3Qsnkjr0+31b+LhIe3dUTyUpYdx9J50Bn9j3ZTxaH3XtUix7SZ3MDZtakh0
 BKVKOVEv3BUxTe729WnjcdE+la0laDMDVAl6gbKXZeD8GcEHQq3o/Xm+L7a1KqcTrsg3AAU1r
 VoozNES3Xy/dB1u1EyIkVTkDmx52zmkqvAP8yJVjlQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 09:02:17PM +0200 Thomas Huth wrote:
> The arch_calc_vm_prot_bits() macro uses VM_PKEY_BIT0 etc. which are
> not part of the uapi, so the macro is completely useless for userspace.
> It is also hidden behind the CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
> config switch which we shouldn't expose to userspace. Thus let's move
> this macro into a new internal header instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Thanks for fixing this config leakage.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>


>  arch/x86/include/asm/mman.h      | 15 +++++++++++++++
>  arch/x86/include/uapi/asm/mman.h |  8 --------
>  scripts/headers_install.sh       |  1 -
>  3 files changed, 15 insertions(+), 9 deletions(-)
>  create mode 100644 arch/x86/include/asm/mman.h
> 
> diff --git a/arch/x86/include/asm/mman.h b/arch/x86/include/asm/mman.h
> new file mode 100644
> index 0000000000000..12b820259b9f3
> --- /dev/null
> +++ b/arch/x86/include/asm/mman.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_MMAN_H__
> +#define __ASM_MMAN_H__
> +
> +#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
> +#define arch_calc_vm_prot_bits(prot, key) (		\
> +		((key) & 0x1 ? VM_PKEY_BIT0 : 0) |      \
> +		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
> +		((key) & 0x4 ? VM_PKEY_BIT2 : 0) |      \
> +		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
> +#endif
> +
> +#include <uapi/asm/mman.h>
> +
> +#endif /* __ASM_MMAN_H__ */
> diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
> index 775dbd3aff736..a72e4f3e13b17 100644
> --- a/arch/x86/include/uapi/asm/mman.h
> +++ b/arch/x86/include/uapi/asm/mman.h
> @@ -4,14 +4,6 @@
>  
>  #define MAP_32BIT	0x40		/* only give out 32bit addresses */
>  
> -#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
> -#define arch_calc_vm_prot_bits(prot, key) (		\
> -		((key) & 0x1 ? VM_PKEY_BIT0 : 0) |      \
> -		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
> -		((key) & 0x4 ? VM_PKEY_BIT2 : 0) |      \
> -		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
> -#endif
> -
>  #include <asm-generic/mman.h>
>  
>  #endif /* _ASM_X86_MMAN_H */
> diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
> index afdddc82f02b3..56d3c338d91d7 100755
> --- a/scripts/headers_install.sh
> +++ b/scripts/headers_install.sh
> @@ -81,7 +81,6 @@ arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_NO
>  arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_SUPPORT
>  arch/x86/include/uapi/asm/auxvec.h:CONFIG_IA32_EMULATION
>  arch/x86/include/uapi/asm/auxvec.h:CONFIG_X86_64
> -arch/x86/include/uapi/asm/mman.h:CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
>  "
>  
>  for c in $configs
> -- 
> 2.39.3

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
