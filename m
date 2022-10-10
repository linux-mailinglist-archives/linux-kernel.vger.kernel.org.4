Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BD45F9ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiJJMqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiJJMp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:45:58 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D4F6B8F8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:45:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bp15so16397072lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZY3VUGhKW8CmP8tRkiumn3t63ZndWcrOVy3NInH/4F8=;
        b=WfYSNe539shRVw3WcHUUuaSo4y4sxxkTYIo+JJ2wCMAWW2aWI1Eq9mu8QHheZcuj8G
         Ry+T/Jne36cmdNNXoi9BcZpSv156/ok1H3pu5j2RYmnqpyoSvXXrbFNE4kWXCOPq9sEr
         AtLTEKdptRqLIylJUqivtWseFoXqJ+k3xxBSz544xUrjyNEIjMcj8s7dO1Fn/r94zogP
         lYeQzTkfcDqdBWL5FZYMM/6+7yMiLFcqFLtjIBJTEq+ag0t4HbR16ZyChHehVSw80ht5
         gsgJAZeTec8t+Id5zNmQwvcFy+bXBjP075aOy+6RA3QwMn2KLxxicyO6T33ctGR0rOUn
         meMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZY3VUGhKW8CmP8tRkiumn3t63ZndWcrOVy3NInH/4F8=;
        b=2L3nnT/rlXhjWgm2f2hqP/Vno4wTjLp3+ObR4xpovqVpCHwihx7mkp7E2qDs71PCK4
         D6KZmqwmpML4TQc1s3i66vKpzzRJl441hI4gd56ZDCaoQ0P0wN8ngpj9LixMpo+Qz9uH
         Y3r1Jn5SRrWlsYXeHZpQN9Ly5ueI/X4SZ8MQWAH/Dz+QLr2jOSXfyj8rsZcM+OQ7BJkn
         qAwcXEffsLcqS4pY3o55Arezq8ZJLg07ioektezQkNcEP/NM46CwjUDVLdqWaZHFs8QW
         +Lz+cIE5p2LV0BOD6VMSckGhRUwXkzx6aa1QjWMCU6E8JkqxP31eYqlZ5lfNt5uT+12t
         qHoQ==
X-Gm-Message-State: ACrzQf2NWkHc0X+Y8zhOPkJBzkTaFU7cycZBgfr1q5f34F6Vwld35a86
        /hqIAZ2gPZ+9WiiJ46HljsvGTHq4GAkd7u55zc4E6g==
X-Google-Smtp-Source: AMsMyM4qRD8FUFL9wvBdJ8LsE/Kv1B22ucAF/oQm3g2adt2U2w+xc8dH7xAKqzwr2z9qiTKLV1eGAUeC/AE3pzclOfA=
X-Received: by 2002:ac2:5616:0:b0:4a2:61f6:85e9 with SMTP id
 v22-20020ac25616000000b004a261f685e9mr6346865lfd.419.1665405955788; Mon, 10
 Oct 2022 05:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221010122726.2405153-1-heiko@sntech.de> <20221010122726.2405153-2-heiko@sntech.de>
In-Reply-To: <20221010122726.2405153-2-heiko@sntech.de>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 10 Oct 2022 18:15:45 +0530
Message-ID: <CAK9=C2VHPBgL208ZHb78Nab1dQjfF6tZuKTRRT5V=vnvfODEGw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] RISC-V: Cache SBI vendor values
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     atishp@atishpatra.org, anup@brainfault.org, will@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Conor.Dooley@microchip.com,
        ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 5:57 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> sbi_get_mvendorid(), sbi_get_marchid() and sbi_get_mimpid() might get
> called multiple times, though the values of these CSRs should not change
> during the runtime of a specific machine.
>
> So cache the values in the functions and prevent multiple ecalls
> to read these values.
>
> As Andrew Jones noted, at least marchid and mimpid may be negative
> values when viewed as a long, so we use a separate static bool to
> indiciate the cached status.
>
> Suggested-by: Atish Patra <atishp@atishpatra.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/kernel/sbi.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 775d3322b422..cc618aaa9d11 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -625,17 +625,41 @@ static inline long sbi_get_firmware_version(void)
>
>  long sbi_get_mvendorid(void)
>  {
> -       return __sbi_base_ecall(SBI_EXT_BASE_GET_MVENDORID);
> +       static long id;
> +       static bool cached;
> +
> +       if (!cached) {
> +               id = __sbi_base_ecall(SBI_EXT_BASE_GET_MVENDORID);
> +               cached = true;
> +       }
> +
> +       return id;
>  }
>
>  long sbi_get_marchid(void)
>  {
> -       return __sbi_base_ecall(SBI_EXT_BASE_GET_MARCHID);
> +       static long id;
> +       static bool cached;

This breaks for heterogeneous SMP systems (similar to big.LITTLE)
where HARTs will have different marchid even though they belong to
same CPU Vendor.

Due to the above rationale, the patch adding marchid, mvendorid, and
mimpid in /proc/cpuinfo caches these values on a per-CPU basis.

Regards,
Anup

> +
> +       if (!cached) {
> +               id = __sbi_base_ecall(SBI_EXT_BASE_GET_MARCHID);
> +               cached = true;
> +       }
> +
> +       return id;
>  }
>
>  long sbi_get_mimpid(void)
>  {
> -       return __sbi_base_ecall(SBI_EXT_BASE_GET_MIMPID);
> +       static long id;
> +       static bool cached;
> +
> +       if (!cached) {
> +               id = __sbi_base_ecall(SBI_EXT_BASE_GET_MIMPID);
> +               cached = true;
> +       }
> +
> +       return id;
>  }
>
>  static void sbi_send_cpumask_ipi(const struct cpumask *target)
> --
> 2.35.1
>
