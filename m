Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEC96C4491
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjCVIDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCVIDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:03:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424043CE3E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:03:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b20so36357787edd.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1679472228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8B1WSd3k6agA9hbUjCQewmiIRqo/yemisFVgkiSXre4=;
        b=HqCWuQmjp+ZcwN/bECxezMtIF3T8jGl/lbqqN0mWQaf8maktnH+dhnd9ma3E5fqpvg
         I0iWAOJF533Ec/kd42R14mgLmhr2wA6bof7TUTGMVN8456efNpC73F69fuuu+EVAao7N
         acOSeTzuXKmZfbEDwlr3G1S1o3pFGJoMcJOaOEPaQBzw67D7l1xxxD0BI+KiI3ycaMCa
         PCgUBf3slJHw3Q+vbQC0NSl364/tJbFozZtKx0rtUsF53thED/9gshySgiM9eSlyHGor
         HC4QlUrm0snf1XxDDsozbFxQaXDWo1V69V3qh9wSyiSOHqdRFY/8AF73wlH9GVuKr5Ff
         AAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679472228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8B1WSd3k6agA9hbUjCQewmiIRqo/yemisFVgkiSXre4=;
        b=RX0/sNOXtCqsJl7TLAbqA/PG8hTFCbvEckHJCjiCc/GJ6EMw2OFpYQCcDrOV1W7RTD
         0ohsFjCGeUSPhWmNrhnhXAhkqzXlTIzh49oIrgc9+J0uuYc89Cvf6hNDhH2BRdEHzfCg
         2OE0nRsAzszltxmnbqaYGlc4tgWNPb/ZagzjEE9/I1k7AZIk2eO2jyCEXbFu68Y6Fgoc
         7JyeqJy4GkS+rwAb7Qm2EOTNwDaehDBdDoQ1xvDzW8Mqr2PgXyUVM32H4YbvRFTTF4dL
         aJvs8Qa0NFn0wUtK618lO0b4D1Gs1cNKLy8Xc16syF6ntfDNMC3QYcI7lHOGSMoXww+p
         TKMg==
X-Gm-Message-State: AO0yUKVz+8LnMiYs1ArHeE3hmhF6Ext24Sv97Yahjf5rvNJKhO+WX+Ij
        2Fqmcqs0i1NtCYrbX0fhYEZZViwoqKeg0hAF/f4=
X-Google-Smtp-Source: AK7set/tziqBkqV5MUVfuXiEpA1/TgvUj3OA8J9Z0t74heEu+r1qBWrAiad4Ewtgcu4fBrqOVhjvSQ==
X-Received: by 2002:aa7:d04a:0:b0:4ad:5950:3f53 with SMTP id n10-20020aa7d04a000000b004ad59503f53mr5262490edo.7.1679472227769;
        Wed, 22 Mar 2023 01:03:47 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id z21-20020a50cd15000000b004acbda55f6bsm7267260edi.27.2023.03.22.01.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 01:03:47 -0700 (PDT)
Date:   Wed, 22 Mar 2023 09:03:45 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] riscv: export cpu/freq invariant to scheduler
Message-ID: <20230322080345.j4oi7nz2nz4rk6ib@orel>
References: <20230322061856.2774840-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322061856.2774840-1-suagrfillet@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 02:18:56PM +0800, Song Shuai wrote:
> RISC-V now manages CPU topology using arch_topology which provides
> CPU capacity and frequency related interfaces to access the cpu/freq
> invariant in possible heterogeneous or DVFS-enabled platforms.
> 
> Here adds topology.h file to export the arch_topology interfaces for
> replacing the scheduler's constant-based cpu/freq invariant accounting.
> 
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>  arch/riscv/include/asm/topology.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 arch/riscv/include/asm/topology.h
> 
> diff --git a/arch/riscv/include/asm/topology.h b/arch/riscv/include/asm/topology.h
> new file mode 100644
> index 000000000000..14bbd2472af6
> --- /dev/null
> +++ b/arch/riscv/include/asm/topology.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_RISCV_TOPOLOGY_H
> +#define __ASM_RISCV_TOPOLOGY_H

riscv uses a single leading underscore.

> +
> +#include <linux/arch_topology.h>
> +
> +/* Replace task scheduler's default frequency-invariant accounting */
> +#define arch_scale_freq_tick topology_scale_freq_tick
> +#define arch_set_freq_scale topology_set_freq_scale
> +#define arch_scale_freq_capacity topology_get_freq_scale
> +#define arch_scale_freq_invariant topology_scale_freq_invariant
> +
> +/* Replace task scheduler's default cpu-invariant accounting */
> +#define arch_scale_cpu_capacity topology_get_cpu_scale
> +#define arch_update_cpu_topology topology_update_cpu_topology
> +
> +
> +#include <asm-generic/topology.h>
> +#endif /* __ASM_RISCV_TOPOLOGY_H */
> -- 
> 2.20.1
>

This looks reasonable, at least from a "do what arm64 does" type of
perspective. Why the RFC? Is it not tested?

Also, if you repost, could please neaten it up a bit? Aligning all
the defines would help and removing the extra blank line. Finally,
why wasn't the "/* Enable topology flag updates */" comment also
lifted from arm64 like the others?

Thanks,
drew
