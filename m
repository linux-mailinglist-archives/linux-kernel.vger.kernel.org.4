Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9D5709F89
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjESTEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjESTEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:04:06 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2188E43;
        Fri, 19 May 2023 12:04:05 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-25332422531so921837a91.0;
        Fri, 19 May 2023 12:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684523045; x=1687115045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfXrnsFbDXzdjb7qVOuxa9oqHZXkdudlA04RuxH6kHU=;
        b=Obzgb1d1YO8Ma5ayrIqbqB+itqTi4kP0eZaBh1HA1gMENpv9Lt6Ud3XKkHHNEpdfuK
         5gjzq4aFIcrNj0dRIxiAZFE0Em8BbhFgOxsQsndjCNv5a3aSklxq9KWVFKLw88hmGSFL
         4J+kWhvONNHVrEjlaDdxGA2xbaCmVD/T7myymgBqjmRnAnFrTjby8QQOPyb0bfLkZvWJ
         IyTUgOzV7VIGo3A4F34PhycAl2Dq1YLrTt5YhmkrBKfq8fSbtGu+U5WuonRBIap5ZqNA
         b2Nrcp9fkTn3SCZEcEjpyyFBCAQ/+Ff4OJq4g5azZu5TgzFJ0QNkNt1BGEA7JPrggQNG
         1zyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684523045; x=1687115045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfXrnsFbDXzdjb7qVOuxa9oqHZXkdudlA04RuxH6kHU=;
        b=h8QufKdw4gLic3dtjjMB30hwLq8F/7CFVv4061JNDNaQy1wZCFNFht09hXsT8xTnr8
         wdqGyhRYZkWAgQ9GspyZquKbEMyiGJH8PEgVTO7rSu8/3GiZKI1g6sPH3kHJ16EykUQg
         caIhYUlxhrHgEgyTJLe2OdX6xKvrLkhSiByZxDcpom4hrj1tvF8cGZorG+bwyABZrg0a
         quOxUc7l7X3CCR83AllZpqPdhMn9bR9m89+C43H99A95v3iKDcHA8T31Rn9ARZvdbtwe
         2KsvcnR6sQHrA8kUls0CKe+NiJGCg+w8YQYQ8IGBxnYNkSlMKFc97b+UeUFjXLn4l46d
         Q7/A==
X-Gm-Message-State: AC+VfDzeciNBYTjZSx12lpGjh8zrBxiFwwx6yGxgpDwS4sgsKzW8VvEb
        GZlcvsOTlL8AcaoozJ25n9sEqBDDxiJdciI4YMc=
X-Google-Smtp-Source: ACHHUZ7/g9smq23s1GWkIcfuQWHgi04Ume0EYORX2B+tWQFnpHrqjHZUkp5I4/ogpznh/+RN3lo4ylL5K/KA/cpvAnI=
X-Received: by 2002:a17:90a:c692:b0:24d:f113:2e2c with SMTP id
 n18-20020a17090ac69200b0024df1132e2cmr3661479pjt.16.1684523045036; Fri, 19
 May 2023 12:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230513074339.266879-1-mmyangfl@gmail.com> <20230513074339.266879-3-mmyangfl@gmail.com>
 <ZGc2m5dJh79y3pxO@gondor.apana.org.au>
In-Reply-To: <ZGc2m5dJh79y3pxO@gondor.apana.org.au>
From:   Yangfl <mmyangfl@gmail.com>
Date:   Sat, 20 May 2023 03:03:27 +0800
Message-ID: <CAAXyoMM7WisnMKTHrfx0WdMY9Xa492caaeCNrjKOdMsS0QBXhA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] crypto: hisilicon/advca - Add SHA support
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> =E4=BA=8E2023=E5=B9=B45=E6=9C=8819=
=E6=97=A5=E5=91=A8=E4=BA=94 16:43=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, May 13, 2023 at 03:43:22PM +0800, David Yang wrote:
> >
> > +static int hica_sha_export(const struct hica_sha_priv *priv, void *out=
,
> > +                        unsigned int digestsize)
> > +{
> > +     if (hica_sha_wait(priv, SHA_RECORD_READY))
> > +             return -ETIMEDOUT;
> > +
> > +     for (unsigned int i =3D 0; i < digestsize; i +=3D sizeof(u32))
> > +             *(u32 *) (out + i) =3D
> > +                     be32_to_cpu(readl_relaxed(priv->base + SHA_OUT0 +=
 i));
> > +
> > +     return 0;
> > +}
>
> Can you please explain what this is doing? Is this exporting
> the finalized hash, or the intermediate state?
>
> If it's exporting the intermediate state, why aren't you implementing
> an import function?
>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

The intermediate state. Importing is done by hica_sha_init, since if I
got it right, crypto hash api are required to handle multiple requests
simultaneously, thus there will be no sense to set ctrl and state
separately.
