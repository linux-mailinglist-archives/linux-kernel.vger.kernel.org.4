Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006C76975CE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 06:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjBOFWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 00:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbjBOFW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 00:22:29 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72A53402A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 21:22:25 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id n2so11841735pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 21:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tV+nl5/6nbPk/6HA5pQX/rHuTHF5S4E9f4KJMF/h5x0=;
        b=fhWxOvSg47bnqh1vlUb0tg8U7zRfENd11uhGOf5Jsz/ZocWHFEI68pLXo5d9vBVXvT
         wSDFNO3/CV6QVriW/uJf7uSjBsTIo2nfhwr90ljf0Mtrv3l+ZNz03APZ/NoeYJxIi8AS
         eT1BnG6scYkTL0mRsKAhicVLLfSox5xFSJlK+m4CcZ2f/19AZeBmn0TeLDNpHHUJ+j//
         pNGe52xRL7NHFqYuRqi8NBAMhHiUAqm3krXcV9gB6lQ+ZUL8htkaq+hcUOto2vJWmQ/P
         1t61ly6hek8z31+cUX+0shb1PAvYlU/KvbO9KdB05jwbmNe1/Zq0XZpFJiImeu8sqMJC
         uFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tV+nl5/6nbPk/6HA5pQX/rHuTHF5S4E9f4KJMF/h5x0=;
        b=2kZAUMjWImdPo0XZe4dIXpI8S0ivoh7UygwiO8XKFEmYANgJlEZHiy98FHI0iBruKw
         KjmJOyFTnoVmhs3wSseACGSb1IJFvqwucChxegl8GiJf7TbZtrrCjGLcP2D7Nsp7BX5b
         09M2UEZBS+Dp0WL5ZuFm0KxH5MilOw0ggGFkTRlmzJlV6PrTF/h+teuVL8CVAYA2900X
         rEo5bM1SzoWKYS8GegyjdTuuRJOZPMmw3mccwWoixU2SAOkUxNm1Y0c4cUmNJfa/VDEm
         fDOijjdL8EIK2F2v+f8r2h8kbWkPg6kyGOd45mf3yw2cyduSrVNinbVTTn4ikZ0I/RNZ
         H3og==
X-Gm-Message-State: AO0yUKU14lXFStA94vOIf+GaybpYFoHD3SX7XMobvbCMrLrpxNh94Ugk
        RtzEk6pRYWL7rEbM3GULZKJhzQ==
X-Google-Smtp-Source: AK7set/rdrNLm8tItidqjsvagDbtl5rYMULe1MueAmQXNPzlIf4+Jxy35EVuWqAlcqe6sRrK/ndqkQ==
X-Received: by 2002:aa7:9f85:0:b0:577:272f:fdb with SMTP id z5-20020aa79f85000000b00577272f0fdbmr600755pfr.29.1676438545117;
        Tue, 14 Feb 2023 21:22:25 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id n14-20020aa78a4e000000b005a8d396ae27sm2788868pfa.8.2023.02.14.21.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 21:22:24 -0800 (PST)
Date:   Tue, 14 Feb 2023 21:22:24 -0800 (PST)
X-Google-Original-Date: Tue, 14 Feb 2023 21:22:11 PST (-0800)
Subject:     Re: [PATCH 13/19] arch/riscv: rename internal name __xchg to __arch_xchg
In-Reply-To: <20221222114635.1251934-14-andrzej.hajda@intel.com>
CC:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, andrzej.hajda@intel.com,
        Arnd Bergmann <arnd@arndb.de>, rodrigo.vivi@intel.com,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        peterz@infradead.org, boqun.feng@gmail.com, mark.rutland@arm.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     andrzej.hajda@intel.com
Message-ID: <mhng-e75808d7-21de-4ef8-a606-b7c652a1f38e@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2022 03:46:29 PST (-0800), andrzej.hajda@intel.com wrote:
> __xchg will be used for non-atomic xchg macro.
>
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> ---
>  arch/riscv/include/asm/atomic.h  | 2 +-
>  arch/riscv/include/asm/cmpxchg.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> index 0dfe9d857a762b..bba472928b5393 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -261,7 +261,7 @@ c_t arch_atomic##prefix##_xchg_release(atomic##prefix##_t *v, c_t n)	\
>  static __always_inline							\
>  c_t arch_atomic##prefix##_xchg(atomic##prefix##_t *v, c_t n)		\
>  {									\
> -	return __xchg(&(v->counter), n, size);				\
> +	return __arch_xchg(&(v->counter), n, size);			\
>  }									\
>  static __always_inline							\
>  c_t arch_atomic##prefix##_cmpxchg_relaxed(atomic##prefix##_t *v,	\
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index 12debce235e52d..2f4726d3cfcc25 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -114,7 +114,7 @@
>  					    _x_, sizeof(*(ptr)));	\
>  })
>
> -#define __xchg(ptr, new, size)						\
> +#define __arch_xchg(ptr, new, size)					\
>  ({									\
>  	__typeof__(ptr) __ptr = (ptr);					\
>  	__typeof__(new) __new = (new);					\
> @@ -143,7 +143,7 @@
>  #define arch_xchg(ptr, x)						\
>  ({									\
>  	__typeof__(*(ptr)) _x_ = (x);					\
> -	(__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr)));	\
> +	(__typeof__(*(ptr))) __arch_xchg((ptr), _x_, sizeof(*(ptr)));	\
>  })
>
>  #define xchg32(ptr, x)							\

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
