Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FB66B13A8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCHVUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCHVUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:20:04 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C2F898E2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:20:01 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id k199so8789ybf.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678310400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSIFsDTreEMYqWcBFFFldz/NuhtBdSadwLg4qO3dsHg=;
        b=rO4Jn0Y8Ac4hNa1cvz1yejx0BwU/1MVMCboeLj4QLHe+hkbsRSvlXb7/mMXDeKpE1P
         mKo37lLX9JHQvegWc8xOd0kBtAOdnpDhq58RkfGlNdmLwqnkovHpGPQBaJ+qUbCKy43Y
         JLXSrHYRuB8aHwGZiMo8p8vGt8fWsbZ0qsBVuG0FxFogLxD9SDlETZ80O/85oNqXcJOZ
         ObT4h7ffKmPOTv6RgMfnkRvgUUEiKx1qxAbZqrBR40o8SmHCgLGHEKzSC01OVlRQCRp9
         yYJb8avhxsn92/lzgij4ChE5jJ2BQQUbduL/l14X97cKHbyqttVwsnaaIBY6at4ZabjU
         hZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678310400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSIFsDTreEMYqWcBFFFldz/NuhtBdSadwLg4qO3dsHg=;
        b=HLDyMF6VuKkIWvVWDDIfIXABWzJjHiSNOR2JxcAuIbRTaYgmhqAtcq4fWSLmZREjyR
         hcZ/h7a0qradEsJHvbUM8P424q/ZocIZWzfvqHBa40XC6yYL1ZlOTYUZWollHMwCQ9Jv
         PoiO1MwRNCHgSfzVZsJqRJPYJSeau5ZH0cl7Qrt1qm8wwI4SUxTICJHr29c6zI17oW6f
         nbnOJoeYpE8l2etkxPmR479Py9x2/8WaWZtkT9DoM7CzyopiRUvE6DTFEAPQ+PhRDRFs
         8tqjwxbIW9gpRPKfdJPZRj1GD6Aptk1KqVBnrDAY0Ux2y8Q3VrraDpsu8CGQktD4Aqq5
         OXtw==
X-Gm-Message-State: AO0yUKV0GosJVn/3kQUijaN9RMgvxCMEXrKZBcq9EvEHM/48vH4fQG68
        fS+SXSZ6t37a+A7be6TT7ycFFJhpg+cTU3JRlM/zcw==
X-Google-Smtp-Source: AK7set+grXEhSPe+la+RXfwW6OHLLiBy3oLCvvV+ccPRPmXC4zZYvHHbtIgJYOJjfhNO0i29VmndKFORJELmtcXtc9A=
X-Received: by 2002:a5b:1cb:0:b0:a6b:bc64:a0af with SMTP id
 f11-20020a5b01cb000000b00a6bbc64a0afmr11827487ybp.4.1678310400455; Wed, 08
 Mar 2023 13:20:00 -0800 (PST)
MIME-Version: 1.0
References: <ZAVu/XHbL9IR5D3h@gondor.apana.org.au> <E1pZ2fs-000e27-4H@formenos.hmeau.com>
 <CACRpkdY8iN_ga0VuQ-z=8KUWaJ6=5rh2vZEwcp+oNgcBuPFk=g@mail.gmail.com>
 <ZAcNhtm/+mik1N2m@gondor.apana.org.au> <CACRpkdbcrCa9v82xVWtixWdDPvCu6E6Rkw-3Vg3APisdvYGwqQ@mail.gmail.com>
 <ZAf/rAbc3bMIwBcr@gondor.apana.org.au> <ZAgDku9htWcetafb@gondor.apana.org.au>
 <CACRpkdZ-zPZG4jK-AF2YF0wUFb8qrKBeoa4feb1qJ9SPusjv+Q@mail.gmail.com>
 <ZAhfBmlNHUpGEwW3@gondor.apana.org.au> <ZAhhGch6TtI8LA6x@gondor.apana.org.au>
In-Reply-To: <ZAhhGch6TtI8LA6x@gondor.apana.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Mar 2023 22:19:48 +0100
Message-ID: <CACRpkdabjrpsiVgm=EyGrTK7PGXth6FdvxSp=QULA+LyqtdBgg@mail.gmail.com>
Subject: Re: [v5 PATCH 7/7] crypto: stm32 - Save and restore between each request
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 11:19=E2=80=AFAM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
> On Wed, Mar 08, 2023 at 06:10:14PM +0800, Herbert Xu wrote:
> >
> > If it's just empty messages, which we know are broken with ux500
> > to begin with, then we can simply not do the hash at all (doing
> > it and then throwing it away seems pointless).
>
> Here is a patch to not process empty messages at all.

Hey it works :D

I had to tweak it slightly because we need to set the state right:

@@ -374,9 +387,20 @@ static int stm32_hash_xmit_cpu(struct stm32_hash_dev *=
hdev,
        const u32 *buffer =3D (const u32 *)buf;
        u32 reg;

-       if (final)
+       if (final) {
                hdev->flags |=3D HASH_FLAGS_FINAL;

+               /* Do not process empty messages if hw is buggy. */
+               if (!(hdev->flags & HASH_FLAGS_INIT) && !length &&
+                   hdev->pdata->broken_emptymsg) {
+                       struct stm32_hash_request_ctx *rctx =3D
ahash_request_ctx(hdev->req);
+                       struct stm32_hash_state *state =3D &rctx->state;
+
+                       state->flags |=3D HASH_FLAGS_EMPTY;
+                       return 0;
+               }
+       }
+
        len32 =3D DIV_ROUND_UP(length, sizeof(u32));

        dev_dbg(hdev->dev, "%s: length: %zd, final: %x len32 %i\n",


After this it WORKS!

For the "v5.5" patch and this (and my other patch) folded in:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>

So now the driver is fixed from a Ux500 point of view.

I actually have the STM32MP board, I can try to find some
time to test the final patch set on it as well if it has the same
has as the other STM32 SoCs.

Yours,
Linus Walleij
