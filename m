Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A21064B3ED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiLMLNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbiLMLMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:12:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B971D666;
        Tue, 13 Dec 2022 03:12:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97DDB6146F;
        Tue, 13 Dec 2022 11:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7F0C433F0;
        Tue, 13 Dec 2022 11:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670929920;
        bh=LEkWK/4ZmDJI2/GtcZ99bFJXIRxh31/egdcumv08eJo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GJRUQVKoaP9Ke/N2JlXTJCBZ7Ur7IzUJ19VHlEPEdn7w3VO8MYqcyGoNiLyF2v18F
         GmkMasO7CgiOKpBVb3KKdxZ98IY4wN4TRkeuPYb2/hYWXRtEpEU/PuHkYR3VHdI/+a
         1mg2TjL1ogJ48iS48qmKUQ+dY9OiWWLQHhKnxjWC292LegsVa+L01HhsGNPQb04tuH
         ub6T8R8fLYCt1d5OO3klLOjUMIR0cOjpuFm5t8gcTEg+d3wkfqJJKV3yjixXAhh/d/
         OjzcGVaRLYAMcRMif7D5Va6a1L+LVJ28dajnK2UstU+Mwo3HdKZDE+jZjs0bYu1PZs
         Yn3FfKwuivh5Q==
Received: by mail-lj1-f180.google.com with SMTP id f16so2925486ljc.8;
        Tue, 13 Dec 2022 03:12:00 -0800 (PST)
X-Gm-Message-State: ANoB5plMFz4OHBhObPA84srdB0b984y1XL23Hj1aP4DSu0weOi3m1WAI
        pUgt0f1gScWSAmvMmZXp9GObgySt/QZq8Oxu9rQ=
X-Google-Smtp-Source: AA0mqf7aNUkkChpYsUEwXX1+Hsz+cSEpZYdGRqO1cG2EFp8r8MD57SDM6qU9zRGyoBrhvwuhi36sPm/QSwFe+uIYXZw=
X-Received: by 2002:a05:651c:b14:b0:277:7eef:1d97 with SMTP id
 b20-20020a05651c0b1400b002777eef1d97mr26599009ljr.516.1670929918790; Tue, 13
 Dec 2022 03:11:58 -0800 (PST)
MIME-Version: 1.0
References: <202211041904.f9S5gAGL-lkp@intel.com> <Y5FvChDBD/+uaFy8@gondor.apana.org.au>
 <CAMj1kXGkdp_cwOWeX_49Y5xTCH8Y7X-LnM8pJufCH3yw7anBWQ@mail.gmail.com> <Y5hXUlvSmHrP8PTN@gondor.apana.org.au>
In-Reply-To: <Y5hXUlvSmHrP8PTN@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 13 Dec 2022 12:11:47 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHrPb+cNbnAC5u=6s7HF_osEbu0WPeDV6+69nUSe2evMA@mail.gmail.com>
Message-ID: <CAMj1kXHrPb+cNbnAC5u=6s7HF_osEbu0WPeDV6+69nUSe2evMA@mail.gmail.com>
Subject: Re: [PATCH] crypto: arm/sha1 - Fix clang function cast warnings
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kernel test robot <lkp@intel.com>,
        Robert Elliott <elliott@hpe.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 at 11:43, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, Dec 08, 2022 at 07:05:45PM +0100, Ard Biesheuvel wrote:
> >
> > We can, as the BUILD_BUG() will catch it if struct sha1_state gets
> > modified in an incompatible way.
>
> Thanks for confirming!
>
> ---8<---
> Instead of casting the function which upsets clang for some reason,
> change the assembly function siganture instead.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

>
> diff --git a/arch/arm/crypto/sha1_glue.c b/arch/arm/crypto/sha1_glue.c
> index 6c2b849e459d..95a727bcd664 100644
> --- a/arch/arm/crypto/sha1_glue.c
> +++ b/arch/arm/crypto/sha1_glue.c
> @@ -21,31 +21,29 @@
>
>  #include "sha1.h"
>
> -asmlinkage void sha1_block_data_order(u32 *digest,
> -               const unsigned char *data, unsigned int rounds);
> +asmlinkage void sha1_block_data_order(struct sha1_state *digest,
> +               const u8 *data, int rounds);
>
>  int sha1_update_arm(struct shash_desc *desc, const u8 *data,
>                     unsigned int len)
>  {
> -       /* make sure casting to sha1_block_fn() is safe */
> +       /* make sure signature matches sha1_block_fn() */
>         BUILD_BUG_ON(offsetof(struct sha1_state, state) != 0);
>
> -       return sha1_base_do_update(desc, data, len,
> -                                  (sha1_block_fn *)sha1_block_data_order);
> +       return sha1_base_do_update(desc, data, len, sha1_block_data_order);
>  }
>  EXPORT_SYMBOL_GPL(sha1_update_arm);
>
>  static int sha1_final(struct shash_desc *desc, u8 *out)
>  {
> -       sha1_base_do_finalize(desc, (sha1_block_fn *)sha1_block_data_order);
> +       sha1_base_do_finalize(desc, sha1_block_data_order);
>         return sha1_base_finish(desc, out);
>  }
>
>  int sha1_finup_arm(struct shash_desc *desc, const u8 *data,
>                    unsigned int len, u8 *out)
>  {
> -       sha1_base_do_update(desc, data, len,
> -                           (sha1_block_fn *)sha1_block_data_order);
> +       sha1_base_do_update(desc, data, len, sha1_block_data_order);
>         return sha1_final(desc, out);
>  }
>  EXPORT_SYMBOL_GPL(sha1_finup_arm);
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
