Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393676FF9B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbjEKTCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238502AbjEKTCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:02:44 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C9830E7
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 12:02:42 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f42397f41fso215585e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 12:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683831761; x=1686423761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRtr65hf9ccqynjXPIiNojbvPdO5ozceM8RcS1ysWrc=;
        b=ovDltNBSrtnPvOFyWQzOYXTGlTtE+TOG9cKwFIL5AdP69UNcoYy5wLhZ/5uq8JhWjt
         wqaayeZLt0bd3vl25p1Bre8bkvv+cx225RlJe4dvL/1fcYJmD2NVvLblW2G3v5klZ3Qo
         Oz+WPQ6wI6V2cqEici32aQJtT44Zq7NUsOHa0xAcOamhxIHQm6XyoU/abiCCLT54cnXr
         0B4G0xPk/KZdFYZoyESm7BKJDiBxPy1rsqe0gnWwHGX/p9nwRS8oMW0XCNArXDYGLE+2
         U/GGopoV4e8XOWHxOWmikbak5JG0Vt6k5knpIr+REfP46AlSKy0WqO9+kgZ8Yj6dDkrB
         uMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683831761; x=1686423761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRtr65hf9ccqynjXPIiNojbvPdO5ozceM8RcS1ysWrc=;
        b=cjhbudxCChFl4M/48CB4In5hjmoZIQjhRfq8gPMh2LmQs+eqHIVXXnWHIUQEmdh/Gy
         0PaZaA+LDfg1v6almoG59Jkn7WKiYJ8BjLu10MZ874jqC69CNL2q2hYJRE1gyvq/aChd
         Z5BpGZ1EergOxtuMNp0MXHfvDL+EBkn4zJzam507/Dp/rrGttlddCU1tsPuyi4Z/EdDy
         PnQmC1RWlYhzstKoC7Hs4H3l/2Rnnxe1/+JM+jsQfq1Ln3kLHtasc0yeHToFJVkYo44r
         h27Gslc2Zpha+jZbMbAHKpa/WxVxsfPgV9PRNLt/8qmf2NZ/TPnvEFa7TiBlP6P+M6TL
         xt1Q==
X-Gm-Message-State: AC+VfDy/3CM8+dYJBLcVd2rTvi8NMPTVwJHS5mvOb4mMNhjwBe6ji3KN
        s3NPVWI0Val0DpsL2CnvQu19BvgjOLBJfYDV3gcRTg==
X-Google-Smtp-Source: ACHHUZ6EwkB6TpSsKUGSeGR7/PBzBofH+A6xbPaLmP7AOuMFn9l2HC3PcKPvMaY8gM8wc456ZjAzGYgborz6n+SaqBc=
X-Received: by 2002:a05:600c:3b18:b0:3f1:9a3d:4f7f with SMTP id
 m24-20020a05600c3b1800b003f19a3d4f7fmr25701wms.1.1683831760922; Thu, 11 May
 2023 12:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230329140642.2186644-1-heiko.stuebner@vrull.eu>
 <20230329140642.2186644-5-heiko.stuebner@vrull.eu> <CAJkfWY63E7x-OQ2yTKJ03Sd7P2AuLruan_41EXzYcTZpNnLPzw@mail.gmail.com>
 <3540048.LM0AJKV5NW@diego>
In-Reply-To: <3540048.LM0AJKV5NW@diego>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Thu, 11 May 2023 12:02:00 -0700
Message-ID: <CAJkfWY524YtCXebG1Nj1=wGjGJpwRMCyOQyXk4fpg3BvPM17zw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] RISC-V: crypto: add accelerated GCM GHASH implementation
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 3:30=E2=80=AFAM Heiko St=C3=BCbner <heiko@sntech.de=
> wrote:
>
> Hi Nathan,
>
> Am Dienstag, 11. April 2023, 17:00:00 CEST schrieb Nathan Huckleberry:
> > On Wed, Mar 29, 2023 at 7:08=E2=80=AFAM Heiko Stuebner <heiko@sntech.de=
> wrote:
> > > +struct riscv64_ghash_ctx {
> > > +       void (*ghash_func)(u64 Xi[2], const u128 Htable[16],
> > > +                          const u8 *inp, size_t len);
> > > +
> > > +       /* key used by vector asm */
> > > +       u128 htable[16];
> >
> > This field looks too big. The assembly only loads the first 128-byte
> > value from this table.
>
> OpenSSL defines the Htable field handed to the init- and the other
> functions as this "u128 Htable[16]"    [0] . As I really like the concept
> of keeping in sync with openSSL, I guess I'd rather not change that.
>
> [0] https://github.com/openssl/openssl/blob/master/crypto/modes/gcm128.c#=
L88
>
>
> > Is this copied from another implementation? There's an optimization
> > where you precompute the first N powers of H so that you can perform 1
> > finite field reduction for every N multiplications, but it doesn't
> > look like that's being used here.
>
> The whole crypto-specific code comes from openSSL itself, so for now I
> guess I'd like to try keeping things the same.
>
>
> > > +#define RISCV64_ZBC_SETKEY(VARIANT, GHASH)                          =
   \
> > > +void gcm_init_rv64i_ ## VARIANT(u128 Htable[16], const u64 Xi[2]);  =
   \
> > > +static int riscv64_zbc_ghash_setkey_ ## VARIANT(struct crypto_shash =
*tfm,      \
> > > +                                          const u8 *key,            =
   \
> > > +                                          unsigned int keylen)      =
   \
> > > +{                                                                   =
   \
> > > +       struct riscv64_ghash_ctx *ctx =3D crypto_tfm_ctx(crypto_shash=
_tfm(tfm)); \
> > > +       const u64 k[2] =3D { cpu_to_be64(((const u64 *)key)[0]),     =
     \
> > > +                          cpu_to_be64(((const u64 *)key)[1]) };     =
   \
> > > +                                                                    =
   \
> > > +       if (keylen !=3D GHASH_BLOCK_SIZE)                            =
     \
> > > +               return -EINVAL;                                      =
   \
> > > +                                                                    =
   \
> > > +       memcpy(&ctx->key, key, GHASH_BLOCK_SIZE);                    =
   \
> > > +       gcm_init_rv64i_ ## VARIANT(ctx->htable, k);                  =
   \
> > > +                                                                    =
   \
> > > +       ctx->ghash_func =3D gcm_ghash_rv64i_ ## GHASH;               =
     \
> > > +                                                                    =
   \
> > > +       return 0;                                                    =
   \
> > > +}
> >
> > I'd prefer three identical functions over a macro here. Code searching
> > tools and compiler warnings are significantly worse with macros.
>
> done :-)
>
>
> > > +
> > > +static int riscv64_zbc_ghash_update(struct shash_desc *desc,
> > > +                          const u8 *src, unsigned int srclen)
> > > +{
> > > +       unsigned int len;
> > > +       struct riscv64_ghash_ctx *ctx =3D crypto_tfm_ctx(crypto_shash=
_tfm(desc->tfm));
> > > +       struct riscv64_ghash_desc_ctx *dctx =3D shash_desc_ctx(desc);
> > > +
> > > +       if (dctx->bytes) {
> > > +               if (dctx->bytes + srclen < GHASH_DIGEST_SIZE) {
> > > +                       memcpy(dctx->buffer + dctx->bytes, src,
> > > +                               srclen);
> > > +                       dctx->bytes +=3D srclen;
> > > +                       return 0;
> > > +               }
> > > +               memcpy(dctx->buffer + dctx->bytes, src,
> > > +                       GHASH_DIGEST_SIZE - dctx->bytes);
> > > +
> > > +               ctx->ghash_func(dctx->shash, ctx->htable,
> > > +                               dctx->buffer, GHASH_DIGEST_SIZE);
> > > +
> > > +               src +=3D GHASH_DIGEST_SIZE - dctx->bytes;
> > > +               srclen -=3D GHASH_DIGEST_SIZE - dctx->bytes;
> > > +               dctx->bytes =3D 0;
> > > +       }
> > > +       len =3D srclen & ~(GHASH_DIGEST_SIZE - 1);
> > > +
> > > +       if (len) {
> > > +               gcm_ghash_rv64i_zbc(dctx->shash, ctx->htable,
> > > +                               src, len);
> > > +               src +=3D len;
> > > +               srclen -=3D len;
> > > +       }
> > > +
> > > +       if (srclen) {
> > > +               memcpy(dctx->buffer, src, srclen);
> > > +               dctx->bytes =3D srclen;
> > > +       }
> > > +       return 0;
> > > +}
> > > +
> > > +static int riscv64_zbc_ghash_final(struct shash_desc *desc, u8 *out)
> > > +{
> > > +       int i;
> > > +       struct riscv64_ghash_ctx *ctx =3D crypto_tfm_ctx(crypto_shash=
_tfm(desc->tfm));
> > > +       struct riscv64_ghash_desc_ctx *dctx =3D shash_desc_ctx(desc);
> > > +
> > > +       if (dctx->bytes) {
> > > +               for (i =3D dctx->bytes; i < GHASH_DIGEST_SIZE; i++)
> > > +                       dctx->buffer[i] =3D 0;
> > > +               ctx->ghash_func(dctx->shash, ctx->htable,
> > > +                               dctx->buffer, GHASH_DIGEST_SIZE);
> >
> > Can we do this without an indirect call?
>
> hmm, the indirect call is in both riscv64_zbc_ghash_update() and
> riscv64_zbc_ghash_final() . And I found a missing one at the bottom
> of riscv64_zbc_ghash_update(), where gcm_ghash_rv64i_zbc() is
> called right now.
>
> Getting rid of the indirect call would mean duplicating both of these
> functions for all instances. Especially with the slightly higher
> complexity of the update this somehow seems not the best way to go.

Indirect calls are quite expensive. They are an issue for things like
disk/filesystem encryption because it introduces a ton of latency per
block.

I think this is a candidate for static calls. It looks like static
call support hasn't been accepted for riscv yet. Maybe just add a TODO
for now?

See:
https://lwn.net/Articles/771209/
https://lore.kernel.org/all/tencent_A8A256967B654625AEE1DB222514B0613B07@qq=
.com/

>
>
> Thanks for your pointers
> Heiko
>
>

Thanks,
Huck
