Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1799B72CC5B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbjFLRX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbjFLRXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:23:47 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A84E134;
        Mon, 12 Jun 2023 10:23:46 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-78a57844f42so39373241.2;
        Mon, 12 Jun 2023 10:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1686590625; x=1689182625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rA+ci5q7KngMrgSNRGMsKGeEczzZ7geqfDeJER8xBNU=;
        b=poiTRiRKV+rQUvKEQWPCKkayUJeadCGisamTi5BFtvDxIxlIQLx4UD5tMOwWIKvhOz
         D5gYNrHMuc8+4rTZa38ySlrWG2L150bP+zqM2guNpHEkwHNhX/Oaf/mu9P9z7tb9l0KY
         2jAuuroPKezw3Giu32AUzcXh7QGK/YL+lNF/ckxr80Jj1CS2oF0xcZdUul7blyRoPRfS
         3kv30pCcOsH7alX/S5c+RVbCjSUFLizgOtkdErc5Al4/0Y1Q2HjKUyuukjIigf9USjde
         istDARceJt9S5N4oh+CXI+P+6zb6Y9cl/bhyOFZlYcby6tJAwblUnmCXQt48LQWrD+UO
         4PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686590625; x=1689182625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rA+ci5q7KngMrgSNRGMsKGeEczzZ7geqfDeJER8xBNU=;
        b=d8NAxCGZUsKlmfjYSrh2kmzpwMqKdBJF3TOV13Qtig6zVnX1XTxSIVWmu7fP7yb6iw
         VkrncCJZBmyrrBB9YAV6uJ7HgF7FQZaAtTx1QnOiS0T1udmUEnpVutaJlAuR7w3PPHuF
         F+mTUrAzn/LNbhQvi5PUJEXddiApqAmZkmR9nwviwE1pyocTT/5u4Wcrlsqf6st1XiYj
         Wi+/a8bLz5kYbsEJmXTxhiRa4Ue5/352f8F4wSMwUE7yhv9UWZN+cnVnrmrJUm4JDFiy
         SvpO0DtbQtoHt0DOtjzWLhBXt+5X4KahscFBJfTeAGLh36AGWUi8Y3iI1ILdCHorgVuT
         G7BA==
X-Gm-Message-State: AC+VfDyA8bM5Zw3GKlvgX87Gy1WnU63iSu0f0z8blehrN+QtOnnDsAE1
        BkEckbV+0mo9CuALwnjL36njkBJfrNry/b4vb6Q=
X-Google-Smtp-Source: ACHHUZ5GqQIYYUOyKXLFbfhZ1XIZ3B3rcn4sOPD62BfndrT2VVq1FFCDEUHlCYWMi1ZI+6T+s2zZJ9xGwxJqlzpESdI=
X-Received: by 2002:a67:e893:0:b0:43d:dfb3:5edb with SMTP id
 x19-20020a67e893000000b0043ddfb35edbmr3313502vsn.25.1686590625467; Mon, 12
 Jun 2023 10:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230606111042.96855-1-franziska.naepelt@gmail.com>
 <20230611105331.16570-1-franziska.naepelt@gmail.com> <1c00f4aa-e696-a071-68a7-cdd62d8ba894@infradead.org>
In-Reply-To: <1c00f4aa-e696-a071-68a7-cdd62d8ba894@infradead.org>
From:   =?UTF-8?Q?Franziska_N=C3=A4pelt?= 
        <franziska.naepelt@googlemail.com>
Date:   Mon, 12 Jun 2023 19:23:34 +0200
Message-ID: <CAAUT3iN3fxN3OE5XB5H1C4xNwo91dF9QMmhDiviHmbwaD1KrVQ@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: fcrypt: Fix block comment
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am So., 11. Juni 2023 um 16:56 Uhr schrieb Randy Dunlap <rdunlap@infradead.org>:
>
> Hi--
>
> On 6/11/23 03:53, Franziska Naepelt wrote:
> > Fix the following checkpatch issue:
> > - WARNING: Block comments use a trailing */ on a separate line
> >
> > Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
> > ---
> > v2:
> >  - Revert SPDX change to address only one logical change
> > ---
> >  crypto/fcrypt.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/crypto/fcrypt.c b/crypto/fcrypt.c
> > index 95a16e88899b..e9e119bab784 100644
> > --- a/crypto/fcrypt.c
> > +++ b/crypto/fcrypt.c
> > @@ -303,7 +303,8 @@ static int fcrypt_setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int key
> >
> >  #if BITS_PER_LONG == 64  /* the 64-bit version can also be used for 32-bit
> >                         * kernels - it seems to be faster but the code is
> > -                       * larger */
> > +                       * larger
> > +                       */
>
> The comment doesn't begin with a /* on a line by itself either.
>
> checkpatch isn't always correct.
> Maybe it isn't in this case.
>
> I would either make it a correct multi-line comment or not make a change
> at all here.
>
> >
> >       u64 k;  /* k holds all 56 non-parity bits */
> >
> >
> > base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
>
> --
> ~Randy

Hi Randy,
thanks for the heads up. I'll leave it for now and won't make a change.
Thanks, Franziska
