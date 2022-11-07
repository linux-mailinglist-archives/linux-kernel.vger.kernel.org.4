Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C582461F295
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiKGML0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiKGMLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:11:24 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C10AB3E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:11:23 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 136so6415313pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 04:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSezs+3A2UldWadIF4Wqf5rdwUtgAB6O0AVEGpwP4bU=;
        b=eFqn82vohSJnCYEnX7t+KONfUzdwQwOMNaA6i7wAcCN0KcyzoEZTXD56LiEER0pv3V
         qcIlOVGDAaXs9qSO9Kiqo9AYboSPuQLRjRe4FbSqJuPmF/icE1CXHrkgxDKKQifDDYEl
         dr+UF2Yk1+Nnf1mrw8o7nESqI7HQDhWPsdOONivWupe6d4aUkzGKzpJd31FvfRtvuNzS
         9IWiGriHMQVI/4f/rFyM+/yayCem6im9Lu/r9XEBlm7Fpk0gCqI8KZqwYkSAaRchioCx
         stlumuHKMxHZj3JNl7r988r1/O5BcgU1dJaqphcWtGdVRMrixXUwNce6ax9zNfSEi2Nh
         u4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bSezs+3A2UldWadIF4Wqf5rdwUtgAB6O0AVEGpwP4bU=;
        b=LVwgf0Xuo1pWfTnysHPPdAL0xXifA36UcyOiDzxZEch5IXIqg/nrrdx8uSYgoJiqk8
         KjYn1tNd9tv/mG0pHETEKdTLmgYawz/glLyORGN99zUMWFlI0GLmACp2Tfxhs7p6sZ3z
         M0DstNRNTrFOGSupMpEq3IjxBEqLHOOv0DMMossfWuMZ7wad2TBOkLi4HUgPLXqwlAgR
         X2bIY+162AyXG3Ouu3FFXj76XOedeNr4+j1b4SNUZUH0FtQSWcB+SaoIC0xHEpmPdVI1
         KI8uu+cbQVBwkR4DP2grYLBDpilByR0u9RuV4WvdsfxJjBP0GFlrFZn9sljXdSuXrGMH
         YURA==
X-Gm-Message-State: ACrzQf00wG9V9vmnjGSgAK7JdVvbYkEHZqSoo7cnnKt8ibEBzTqm9aSB
        PE/pyt6RKqt6AdmWWCx1irg=
X-Google-Smtp-Source: AMsMyM6Mk/ZP3tcF6H/6SZTHGzYLFZ3n+l+XztSuXQMocylV0y8TQ40FNP1gdemC4s3sh/rvPlKiYA==
X-Received: by 2002:aa7:9010:0:b0:562:ebc8:6195 with SMTP id m16-20020aa79010000000b00562ebc86195mr814198pfo.38.1667823083085;
        Mon, 07 Nov 2022 04:11:23 -0800 (PST)
Received: from localhost (203-221-202-134.tpgi.com.au. [203.221.202.134])
        by smtp.gmail.com with ESMTPSA id b14-20020a63d30e000000b00470537b9b0asm3613098pgg.51.2022.11.07.04.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 04:11:22 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 07 Nov 2022 22:11:17 +1000
Message-Id: <CO61XSIISI9G.PHZVHP50ZWUU@bobo>
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Laurent Dufour" <ldufour@linux.ibm.com>, <mpe@ellerman.id.au>,
        <christophe.leroy@csgroup.eu>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] powerpc: export the CPU node count
X-Mailer: aerc 0.11.0
References: <20221028160034.44400-1-ldufour@linux.ibm.com>
 <20221028160034.44400-2-ldufour@linux.ibm.com>
In-Reply-To: <20221028160034.44400-2-ldufour@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Oct 29, 2022 at 2:00 AM AEST, Laurent Dufour wrote:
> At boot time, the FDT is parsed to compute the number of CPUs.
> In addition count the number of CPU nodes and export it.
>
> This is useful when building the FDT for a kexeced kernel since we need t=
o
> take in account the CPU node added since the boot time during CPU hotplug
> operations.

It would be nice if it just realloced memory in this case, but that
looks like a bigger change.

But these patches look okay to me, if you can solve the compile bug.

Thanks,
Nick

>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/kexec_ranges.h | 2 ++
>  arch/powerpc/kernel/prom.c              | 4 ++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/kexec_ranges.h b/arch/powerpc/inclu=
de/asm/kexec_ranges.h
> index f83866a19e87..bf35d00ddd09 100644
> --- a/arch/powerpc/include/asm/kexec_ranges.h
> +++ b/arch/powerpc/include/asm/kexec_ranges.h
> @@ -22,4 +22,6 @@ int add_rtas_mem_range(struct crash_mem **mem_ranges);
>  int add_opal_mem_range(struct crash_mem **mem_ranges);
>  int add_reserved_mem_ranges(struct crash_mem **mem_ranges);
> =20
> +extern unsigned int boot_cpu_node_count;
> +
>  #endif /* _ASM_POWERPC_KEXEC_RANGES_H */
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 1eed87d954ba..d326148fd5a4 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -56,6 +56,7 @@
>  #include <asm/drmem.h>
>  #include <asm/ultravisor.h>
>  #include <asm/prom.h>
> +#include <asm/kexec_ranges.h>
> =20
>  #include <mm/mmu_decl.h>
> =20
> @@ -72,6 +73,7 @@ int __initdata iommu_is_off;
>  int __initdata iommu_force_on;
>  unsigned long tce_alloc_start, tce_alloc_end;
>  u64 ppc64_rma_size;
> +unsigned int boot_cpu_node_count __ro_after_init;
>  #endif
>  static phys_addr_t first_memblock_size;
>  static int __initdata boot_cpu_count;
> @@ -335,6 +337,8 @@ static int __init early_init_dt_scan_cpus(unsigned lo=
ng node,
>  	if (type =3D=3D NULL || strcmp(type, "cpu") !=3D 0)
>  		return 0;
> =20
> +	boot_cpu_node_count++;
> +
>  	/* Get physical cpuid */
>  	intserv =3D of_get_flat_dt_prop(node, "ibm,ppc-interrupt-server#s", &le=
n);
>  	if (!intserv)
> --=20
> 2.38.1

