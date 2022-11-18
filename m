Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F66D62FF09
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiKRU53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiKRU50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:57:26 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57178F3F2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:57:25 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id c1so10128303lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G94qeilfNy6ydk7dHARL8hYFWRE3rBfYAcibgzPUoAM=;
        b=XBenWYVH5DbOIxrQDW33iVDzwNuG7w2QbBeUG5foqnbFpO+aW7BvELeIaX2DS8GqBI
         SVbZ0u5AGgnPg4HrPR87RctuowuPrbYxkIKzDM5xNBVQGmX3cQvUBirzJhinSn31c9PV
         YiOTawiv0bjx/BYTR6UskrrBH3/uxkRyT4bqJJfsAa0tt6bp8O39XtwFrb17Iw87z33K
         jmqaF/fws/8V/JHx5i/BxJ3z06dFOJmiX/QDliylFIjJYfOwzOrv1jcPTwsQdHg3Pb4/
         esUD9d5vlrbn/UKdIG9M1++9pA1ephms9++6rH3hc79WCVQtHq2iUUZezaPA+wXmdOp/
         MkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G94qeilfNy6ydk7dHARL8hYFWRE3rBfYAcibgzPUoAM=;
        b=0IXgCMBChNdGkVrY7XIzpYmbPFsuXlqlt6jkqZ9ypNUPGhxvrVBmgSf77LTme2fTPE
         NZJUWLrLFnH9ObpInn68rChGGrZsNZHQ6BDv5p0E/QqXq9TXUX7gXBk6JJqql5LmTXqF
         rva5V/4WEPjDeFF4og/2/ac6rsC+PLXuPOFeuEjEjDUGybNUjXX4Us6ME61LSe81moad
         GQnEewqYhe6a7Y9y0hXFHBosj4e4ZsexDOKeuKgcI6YOYPlzj8pi8SKY+EWfj+jHIsqI
         7ym4S6DyYkJIFcAa6xpb8u4yPA1FtV/+Ym4Rq9THiK2t26H4Zc7uanw7MsCbWv7Nyes2
         RMqQ==
X-Gm-Message-State: ANoB5pnCG++dzPVA5Ja3UJkYQtv0sIUlkn5AsNfAzrRvKiwSBI1ht3RE
        QlYuFTKCe2FjukKEhYI1Yi0=
X-Google-Smtp-Source: AA0mqf6W+VtMWEX1H23APQyEFSt+dLdxxwdn0evkdr8mxu2DQ6AVbFyyaCaKAKhhyYTGYApXRh+Kzg==
X-Received: by 2002:ac2:43b0:0:b0:4a4:719a:19ed with SMTP id t16-20020ac243b0000000b004a4719a19edmr3322535lfl.356.1668805043876;
        Fri, 18 Nov 2022 12:57:23 -0800 (PST)
Received: from curiosity ([5.188.167.245])
        by smtp.gmail.com with ESMTPSA id m13-20020a056512014d00b0048ad4c718f3sm806348lfo.30.2022.11.18.12.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 12:57:22 -0800 (PST)
Date:   Fri, 18 Nov 2022 23:57:21 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     guoren@kernel.org
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de,
        philipp.tomsich@vrull.eu, alex@ghiti.fr, hch@lst.de,
        ajones@ventanamicro.com, gary@garyguo.net, jszhang@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH V3] riscv: asid: Fixup stale TLB entry cause application
 crash
Message-ID: <Y3fxsWPLPlKGfMBj@curiosity>
References: <20221111075902.798571-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111075902.798571-1-guoren@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo Ren,


> After use_asid_allocator is enabled, the userspace application will
> crash by stale TLB entries. Because only using cpumask_clear_cpu without
> local_flush_tlb_all couldn't guarantee CPU's TLB entries were fresh.
> Then set_mm_asid would cause the user space application to get a stale
> value by stale TLB entry, but set_mm_noasid is okay.

... [snip]

> +	/*
> +	 * The mm_cpumask indicates which harts' TLBs contain the virtual
> +	 * address mapping of the mm. Compared to noasid, using asid
> +	 * can't guarantee that stale TLB entries are invalidated because
> +	 * the asid mechanism wouldn't flush TLB for every switch_mm for
> +	 * performance. So when using asid, keep all CPUs footmarks in
> +	 * cpumask() until mm reset.
> +	 */
> +	cpumask_set_cpu(cpu, mm_cpumask(next));
> +	if (static_branch_unlikely(&use_asid_allocator)) {
> +		set_mm_asid(next, cpu);
> +	} else {
> +		cpumask_clear_cpu(cpu, mm_cpumask(prev));
> +		set_mm_noasid(next);
> +	}
>  }

I observe similar user-space crashes on my SMP systems with enabled ASID.
My attempt to fix the issue was a bit different, see the following patch:

https://lore.kernel.org/linux-riscv/20220829205219.283543-1-geomatsi@gmail.com/

In brief, the idea was borrowed from flush_icache_mm handling:
- keep track of CPUs not running the task
- perform per-ASID TLB flush on such CPUs only if the task is switched there

Your patch also works fine in my tests fixing those crashes. I have a
question though, regarding removed cpumask_clear_cpu. How CPUs no more
running the task are removed from its mm_cpumask ? If they are not
removed, then flush_tlb_mm/flush_tlb_page will broadcast unnecessary
TLB flushes to those CPUs when ASID is enabled.

Regards,
Sergey
