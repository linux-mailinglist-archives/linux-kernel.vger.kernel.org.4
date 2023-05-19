Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C65970A131
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjESVFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjESVFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:05:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4E41A5;
        Fri, 19 May 2023 14:05:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5A6A6586C;
        Fri, 19 May 2023 21:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ED6C433EF;
        Fri, 19 May 2023 21:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684530311;
        bh=Mj5v+bpL8vpGksGf9GHZnKOEt24+6uxqfaVWrmt99z8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O9C5sQA1fDVpT+LsSe6nmDSMALaYALFtdGjIibPahT/bWTZ9K/xCEuNlBdPX/AtHx
         3d/exTbXTnvIIrdEdTJp+DNh+eNUTwXqBE/RNAqItKss1L6kdlKgCOC9vXzLxP3blc
         XmfvhhYwEdz9t6V79+qDDEOKbHzZKuEGMD0myTBn3aHA0VNnt4gXaifMKukZRjJwst
         iFm+v3xC35EAVmkv8tdQH6mQmEqpK1x1AHveHnA6SwPOAU8f4BtYnpkBbDZX9/Cigm
         VAi3C9LccQwq+TTvbk2nY2R59V3oEET05a++9ydhgupKTatXvLc1Xa85eDuvutVWKO
         TaA6k5Gv7ibYg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2af0eb50b4aso37010011fa.2;
        Fri, 19 May 2023 14:05:11 -0700 (PDT)
X-Gm-Message-State: AC+VfDxBYiHpam6pEVV3uvUSbZBqqInFqdPmK60RTBlArrrJ4wQF+/YJ
        Z80PGi4q77eBuFPvUhNMb3lJV/T23quoiQYRRgc=
X-Google-Smtp-Source: ACHHUZ4jw1PMyxXnSvxtaMA7rkyc5F4RHCYVII+V34XXlLmUd4u0r/g6rFga4jqR4jMd1MqD1HSrTtcaQA5xaBi/zro=
X-Received: by 2002:a05:651c:10d:b0:2af:1681:2993 with SMTP id
 a13-20020a05651c010d00b002af16812993mr1121072ljb.49.1684530309331; Fri, 19
 May 2023 14:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230517132220.937200-1-arnd@kernel.org>
In-Reply-To: <20230517132220.937200-1-arnd@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 19 May 2023 14:04:57 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5aThPSitkHf+BD_bzsSGitwJt34ZWApT-6MnqaMWmCtg@mail.gmail.com>
Message-ID: <CAPhsuW5aThPSitkHf+BD_bzsSGitwJt34ZWApT-6MnqaMWmCtg@mail.gmail.com>
Subject: Re: [PATCH] raid6: neon: add missing prototypes
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-raid@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 6:22=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The raid6 syndrome functions are generated for different sizes and have
> no generic prototype, while in the inner functions have a prototype
> in a header that cannot be included from the correct file. In both
> cases, the compiler warns about missing prototypes:
>
> lib/raid6/recov_neon_inner.c:27:6: warning: no previous prototype for '__=
raid6_2data_recov_neon' [-Wmissing-prototypes]
> lib/raid6/recov_neon_inner.c:77:6: warning: no previous prototype for '__=
raid6_datap_recov_neon' [-Wmissing-prototypes]
> lib/raid6/neon1.c:56:6: warning: no previous prototype for 'raid6_neon1_g=
en_syndrome_real' [-Wmissing-prototypes]
> lib/raid6/neon1.c:86:6: warning: no previous prototype for 'raid6_neon1_x=
or_syndrome_real' [-Wmissing-prototypes]
> lib/raid6/neon2.c:56:6: warning: no previous prototype for 'raid6_neon2_g=
en_syndrome_real' [-Wmissing-prototypes]
> lib/raid6/neon2.c:97:6: warning: no previous prototype for 'raid6_neon2_x=
or_syndrome_real' [-Wmissing-prototypes]
> lib/raid6/neon4.c:56:6: warning: no previous prototype for 'raid6_neon4_g=
en_syndrome_real' [-Wmissing-prototypes]
> lib/raid6/neon4.c:119:6: warning: no previous prototype for 'raid6_neon4_=
xor_syndrome_real' [-Wmissing-prototypes]
> lib/raid6/neon8.c:56:6: warning: no previous prototype for 'raid6_neon8_g=
en_syndrome_real' [-Wmissing-prototypes]
> lib/raid6/neon8.c:163:6: warning: no previous prototype for 'raid6_neon8_=
xor_syndrome_real' [-Wmissing-prototypes]
>
> Add a new header file that contains the prototypes for both to avoid
> the warnings.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to md-next. Thanks!

Song

> ---
>  lib/raid6/neon.h             | 22 ++++++++++++++++++++++
>  lib/raid6/neon.uc            |  1 +
>  lib/raid6/recov_neon.c       |  8 +-------
>  lib/raid6/recov_neon_inner.c |  1 +
>  4 files changed, 25 insertions(+), 7 deletions(-)
>  create mode 100644 lib/raid6/neon.h
>
> diff --git a/lib/raid6/neon.h b/lib/raid6/neon.h
> new file mode 100644
> index 000000000000..2ca41ee9b499
> --- /dev/null
> +++ b/lib/raid6/neon.h
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +void raid6_neon1_gen_syndrome_real(int disks, unsigned long bytes, void =
**ptrs);
> +void raid6_neon1_xor_syndrome_real(int disks, int start, int stop,
> +                                   unsigned long bytes, void **ptrs);
> +void raid6_neon2_gen_syndrome_real(int disks, unsigned long bytes, void =
**ptrs);
> +void raid6_neon2_xor_syndrome_real(int disks, int start, int stop,
> +                                   unsigned long bytes, void **ptrs);
> +void raid6_neon4_gen_syndrome_real(int disks, unsigned long bytes, void =
**ptrs);
> +void raid6_neon4_xor_syndrome_real(int disks, int start, int stop,
> +                                   unsigned long bytes, void **ptrs);
> +void raid6_neon8_gen_syndrome_real(int disks, unsigned long bytes, void =
**ptrs);
> +void raid6_neon8_xor_syndrome_real(int disks, int start, int stop,
> +                                   unsigned long bytes, void **ptrs);
> +void __raid6_2data_recov_neon(int bytes, uint8_t *p, uint8_t *q, uint8_t=
 *dp,
> +                             uint8_t *dq, const uint8_t *pbmul,
> +                             const uint8_t *qmul);
> +
> +void __raid6_datap_recov_neon(int bytes, uint8_t *p, uint8_t *q, uint8_t=
 *dq,
> +                             const uint8_t *qmul);
> +
> +
> diff --git a/lib/raid6/neon.uc b/lib/raid6/neon.uc
> index b7c68030da4f..355270af0cd6 100644
> --- a/lib/raid6/neon.uc
> +++ b/lib/raid6/neon.uc
> @@ -25,6 +25,7 @@
>   */
>
>  #include <arm_neon.h>
> +#include "neon.h"
>
>  typedef uint8x16_t unative_t;
>
> diff --git a/lib/raid6/recov_neon.c b/lib/raid6/recov_neon.c
> index d6fba8bf8c0a..1bfc14174d4d 100644
> --- a/lib/raid6/recov_neon.c
> +++ b/lib/raid6/recov_neon.c
> @@ -8,6 +8,7 @@
>
>  #ifdef __KERNEL__
>  #include <asm/neon.h>
> +#include "neon.h"
>  #else
>  #define kernel_neon_begin()
>  #define kernel_neon_end()
> @@ -19,13 +20,6 @@ static int raid6_has_neon(void)
>         return cpu_has_neon();
>  }
>
> -void __raid6_2data_recov_neon(int bytes, uint8_t *p, uint8_t *q, uint8_t=
 *dp,
> -                             uint8_t *dq, const uint8_t *pbmul,
> -                             const uint8_t *qmul);
> -
> -void __raid6_datap_recov_neon(int bytes, uint8_t *p, uint8_t *q, uint8_t=
 *dq,
> -                             const uint8_t *qmul);
> -
>  static void raid6_2data_recov_neon(int disks, size_t bytes, int faila,
>                 int failb, void **ptrs)
>  {
> diff --git a/lib/raid6/recov_neon_inner.c b/lib/raid6/recov_neon_inner.c
> index 90eb80d43790..f9e7e8f5a151 100644
> --- a/lib/raid6/recov_neon_inner.c
> +++ b/lib/raid6/recov_neon_inner.c
> @@ -5,6 +5,7 @@
>   */
>
>  #include <arm_neon.h>
> +#include "neon.h"
>
>  #ifdef CONFIG_ARM
>  /*
> --
> 2.39.2
>
