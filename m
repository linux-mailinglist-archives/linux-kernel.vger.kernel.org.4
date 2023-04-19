Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993156E83F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjDSVyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjDSVyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:54:00 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F8646AB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:53:58 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52019617020so227640a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681941238; x=1684533238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8iHanY7fwyxMAC+40k2hC5PB13EWng94w0vOBJ90SQ=;
        b=qHXH/QEPdhfNUubovbW2N/tO1b/Cf9V9pOr4tjVtzyoUiD2aJpz58/QOC6orq7L4RS
         KwtQmYBSyAEUEYT/K+noG9KXEodKAYZColxmjFNmASfWWPvr0wwQypJzfTPHlavOuXrR
         e7W20zZl7AZSzBcHLMhaHJcpeEXBVJy/1G4aUlcRkCp9Am0NWRWTpritQjIQeYbsFIdo
         /Y4XLIOIjK0OvPn152AwXWNd7b8doRZWKLgNIcp8ysckM6ry6QdkklWHv7w17qtVwFcG
         GHzJPYuxFai5e6xvaVXT5fO1SMlFJL+a0hQbT64r8ei3PKsZqWpSX3qKaGaZOrmEXMJ2
         gcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681941238; x=1684533238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8iHanY7fwyxMAC+40k2hC5PB13EWng94w0vOBJ90SQ=;
        b=XBMEXETy6MY+K/71a2y5Y89gDKhhMVc60mDjKG1fA1yCGxIxBvkVCUsFsyF63IL4x/
         513OPzTE1ptgCW35P3WPI0puvMjG/74n83He+HNzpF3FzQijsK5kWEcK/XSazgu4CwD2
         gqPfHT+jF1cptUU2RmJe3QPIV6nJO1nk19c1gyuCVArLJwgELMVDYtfLGcRU80v7h5Oe
         BROv6bbDhNK9fmJ4WDv/7iUXdxzv7qrX+Ri2O/X+sioILXGLY+IOCkMHxdciOqTcrlRQ
         Nhbij3GQY+7Xl0pjcHZeFhBLPGqhlj4ff0YJ+hqNYXPGW7DA+vYeTWe1ZZFtzL1su2hm
         JnCw==
X-Gm-Message-State: AAQBX9fkbG66VRCFJDBBQM3jShj2Lpa6ZrbYGQ6QPhkSeLclEEd9Ob2r
        2/HJVtaG+J42jAt3Tmc2LqQ3Kq3ZfF5YtYTbCT3z7g==
X-Google-Smtp-Source: AKy350au7CHiEJh3jH0BOBk7n3u4G+wlWReJVqLi7dJNUMc2sVuxMTkPvY3TekaRVMIqFKa4nmdijy5uBsrs/pUwlaw=
X-Received: by 2002:a17:90a:4307:b0:247:96e0:2ebf with SMTP id
 q7-20020a17090a430700b0024796e02ebfmr4202460pjg.1.1681941237996; Wed, 19 Apr
 2023 14:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <202304081828.zjGcFUyE-lkp@intel.com> <ZD+0DJq1NHmMSSja@gondor.apana.org.au>
 <ZD+1BQd8Phqk3lzv@gondor.apana.org.au>
In-Reply-To: <ZD+1BQd8Phqk3lzv@gondor.apana.org.au>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Apr 2023 14:53:45 -0700
Message-ID: <CAKwvOdmi26QmGKsoZGauj+qBBaqvH7v6ryohQDmwLA_Mht5doA@mail.gmail.com>
Subject: Re: [PATCH] crypto: arm/sha256-neon - Fix clang function cast warnings
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kernel test robot <lkp@intel.com>,
        Robert Elliott <elliott@hpe.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 2:32=E2=80=AFAM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
>
> Instead of casting the function which upsets clang for some reason,
> change the assembly function siganture instead.

Thanks for the patch, same comments as the sha1 patch:
https://lore.kernel.org/oe-kbuild-all/CAKwvOdm2VyCzfmG6707osmtyniV-oL-ism08=
kER49D7p_7x+Rg@mail.gmail.com/
though sha256_block_data_order_neon is defined in
arch/arm/crypto/sha256-armv4.pl and does not have any comments about
the function signature.
Also, I see a few more casts to sha256_block_fn:

arch/arm/crypto/sha256_glue.c
37:                             (sha256_block_fn *)sha256_block_data_order)=
;
44:                             (sha256_block_fn *)sha256_block_data_order)=
;
52:                           (sha256_block_fn *)sha256_block_data_order);

arch/arm/crypto/sha2-ce-glue.c
41:                           (sha256_block_fn *)sha2_ce_transform);
56:                                   (sha256_block_fn *)sha2_ce_transform)=
;
57:     sha256_base_do_finalize(desc, (sha256_block_fn *)sha2_ce_transform)=
;

Can those be cleaned up, too? (Either in this patch or a follow up?)

>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304081828.zjGcFUyE-lkp@int=
el.com/
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/arch/arm/crypto/sha256_neon_glue.c b/arch/arm/crypto/sha256_=
neon_glue.c
> index 701706262ef3..ccdcfff71910 100644
> --- a/arch/arm/crypto/sha256_neon_glue.c
> +++ b/arch/arm/crypto/sha256_neon_glue.c
> @@ -21,8 +21,8 @@
>
>  #include "sha256_glue.h"
>
> -asmlinkage void sha256_block_data_order_neon(u32 *digest, const void *da=
ta,
> -                                            unsigned int num_blks);
> +asmlinkage void sha256_block_data_order_neon(struct sha256_state *digest=
,
> +                                            const u8 *data, int num_blks=
);
>
>  static int crypto_sha256_neon_update(struct shash_desc *desc, const u8 *=
data,
>                                      unsigned int len)
> @@ -34,8 +34,7 @@ static int crypto_sha256_neon_update(struct shash_desc =
*desc, const u8 *data,
>                 return crypto_sha256_arm_update(desc, data, len);
>
>         kernel_neon_begin();
> -       sha256_base_do_update(desc, data, len,
> -                       (sha256_block_fn *)sha256_block_data_order_neon);
> +       sha256_base_do_update(desc, data, len, sha256_block_data_order_ne=
on);
>         kernel_neon_end();
>
>         return 0;
> @@ -50,9 +49,8 @@ static int crypto_sha256_neon_finup(struct shash_desc *=
desc, const u8 *data,
>         kernel_neon_begin();
>         if (len)
>                 sha256_base_do_update(desc, data, len,
> -                       (sha256_block_fn *)sha256_block_data_order_neon);
> -       sha256_base_do_finalize(desc,
> -                       (sha256_block_fn *)sha256_block_data_order_neon);
> +                                     sha256_block_data_order_neon);
> +       sha256_base_do_finalize(desc, sha256_block_data_order_neon);
>         kernel_neon_end();
>
>         return sha256_base_finish(desc, out);
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
>


--=20
Thanks,
~Nick Desaulniers
