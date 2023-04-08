Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5396DBC17
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 18:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjDHQGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 12:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDHQGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 12:06:47 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66439745;
        Sat,  8 Apr 2023 09:06:43 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6343fe70a2aso104764b3a.0;
        Sat, 08 Apr 2023 09:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680970003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xz6YJvnk1QAZeeNU3EF1FtxUPt7rc/kW8KB3lvnh+Xk=;
        b=oTUd60ZAmAVPUZRMtW+NY8eqzrFIMcGJFkRKESVUwGP6d0g8i+UQkybG7NuhyRDM6w
         VvuNRvflyumFas+D37eKR20una8ysfTED6S9r24xuQb1FEZ36QkQaQlisFgXfaemLKnE
         AGJqewynIEZ6Bc2RJIXmMK5tTC8ZpPJD2HOFBw1YgXrQ3jrqnKLVUoKXUL60kR2RWBcb
         Q99aV+Ps08zm/lSR9DbdufNOIfob+Cg+mNY+ARs0aIz6fcviM9wTCLZhg6ZsOEo6h14a
         q8JOk314G97U3MV+n/UUe5qbQbRvAu4zlyoAnBbZFRe2tXUXQCYrjfE7F3XfGe4SKlr4
         11NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680970003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xz6YJvnk1QAZeeNU3EF1FtxUPt7rc/kW8KB3lvnh+Xk=;
        b=vWKF8rVh2AG8bIhQnP4fxfwE1yHonBjdUYCKQcWF5ZM2keSCXKhz8nrBC800GtU0x1
         sP2NaRE18Ti6WwdrI7uIwYarxAh5M49QuhoPBxe2vtxvGmZuvxzgHR2n/3Rct+zbLeT5
         AtKxwjnQ9VctOhLev73mACie4DeN08WM3wo7CDwpHoo/3yVjNZt+MpLotdzQxXhdqxuq
         9QSMfVycSB0ABVkKZPMKr/uS7JKHpkk+CvnULzeMSHGiiraGewyMQWIGoT3NbAqfutcx
         Qo6xcEGC830SCXvy9DvqaNwPk2g0qPlsTut62KIN/Ru3H79GnhH+MNxz+4AcRkypqlEe
         uZ8w==
X-Gm-Message-State: AAQBX9eovOshg/Yr32V8kKAn6pSKKzmCqU3bX5AondP7V/+gZXbq7uYz
        VKmxDbPBlrnTntRnEO+j9fuQMUz4O2gUfHAcH8uTZvpqkl7U+mfA
X-Google-Smtp-Source: AKy350bGYz8K7w7t+fCh0R8EQfFoXCTx8a2Agw8MEoIx9217PAmDo+/aDO/w81mSAp69SlaB6NLqPeYQIXDFAgbdCTA=
X-Received: by 2002:a05:6a00:1994:b0:631:9e50:1490 with SMTP id
 d20-20020a056a00199400b006319e501490mr1419323pfl.2.1680970003237; Sat, 08 Apr
 2023 09:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230401164448.1393336-1-mmyangfl@gmail.com> <ZC6Ibor2aGR8D8fR@gondor.apana.org.au>
In-Reply-To: <ZC6Ibor2aGR8D8fR@gondor.apana.org.au>
From:   Yangfl <mmyangfl@gmail.com>
Date:   Sun, 9 Apr 2023 00:06:06 +0800
Message-ID: <CAAXyoMMBWnqQGVWVOsEaKviukQJK1iyx+OAez0AQfKPL5b_UvQ@mail.gmail.com>
Subject: Re: [PATCH v5] crypto: hisilicon/trng - add support for HiSTB TRNG
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> =E4=BA=8E2023=E5=B9=B44=E6=9C=886=
=E6=97=A5=E5=91=A8=E5=9B=9B 16:53=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Apr 02, 2023 at 12:44:40AM +0800, David Yang wrote:
> > HiSTB TRNG are found on some HiSilicon STB SoCs.
> >
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > ---
> > v2: fix typo
> > v3: add option for post process depth, adjust timeout
> > v4: do not case to __iomem, as requested
> > v5: do not use rng->priv at all
> >  drivers/crypto/hisilicon/Kconfig         |   7 +
> >  drivers/crypto/hisilicon/Makefile        |   2 +-
> >  drivers/crypto/hisilicon/trng/Makefile   |   3 +
> >  drivers/crypto/hisilicon/trng/trng-stb.c | 176 +++++++++++++++++++++++
> >  4 files changed, 187 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/crypto/hisilicon/trng/trng-stb.c
>
> Patch applied.  Thanks.
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Thanks for merging this patch. But after considering your former reply
about drivers/char/hw_random , I'm thinking if that is a better place
for this driver. If that is the case I'd like to post a new version of
patch.

Sorry for late reply.
