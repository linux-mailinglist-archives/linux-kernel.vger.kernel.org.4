Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99347240E2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbjFFLag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbjFFLad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:30:33 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B52CE79;
        Tue,  6 Jun 2023 04:30:31 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-78a1e095508so569270241.0;
        Tue, 06 Jun 2023 04:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1686051030; x=1688643030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kwvhTgg8R86JQ73/qOc7jk8iamOwTHPyCrVDmBVZ7SE=;
        b=Xb16SBI3OiDSwCgw5tQUMBXPI/5KVfmzDRbnA7TyKwe/g6XpiBMFIpP4zDbEe5/B0c
         d/JFCNNCOxc+hacSFB7DeogcfZ5G0ekDOBrCCzBiHq323jr57ETJLbKGdcVbDLkXw6Vc
         ijzWZ+g8lihe5cDfPBVn3Ao2nKyc+yrOfDqGy+RgoLBV15g/drT11Wyqn9EGZYdP+lEi
         mDBIeVPNTU2yIxpyPTM0hgFizIwBlqX4bauAbu0KM91xgi7ZpqQhLVJiXeO8joxhPqxP
         fY1HIQV9A+fmeggbScu1p9O5eCf40rjk9vOgOdYwwvNh4gMlN7nPdu7qFigVwrr1+cqc
         Vfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686051030; x=1688643030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwvhTgg8R86JQ73/qOc7jk8iamOwTHPyCrVDmBVZ7SE=;
        b=RYLl9P8whLF/at/JpE2R5ROgWOHQ+8gxcOyJd9Z7M4goVJexYYHBpEqEZLXwdTlFYc
         X9KTmMe12j52HC2I7RhTsY3GEfzNpYWiIu1p0QHAFtFeLcsR1OnUESUfZWrZz0zmCfwK
         QQ5vodUDMOx9Wpyze2UtlcPA9yLin1sqqn+DO/vFKyWtrdSsbYA8dkIg+h5O+OkCs+RJ
         s6QmD+jTHoTEr/HcJjV5qvl4uNipFFE5am3AbbNFC8te7QsBvcUKEwlcDKgsLS7u6Qdh
         h+2QAIHJvYy+FrGuMffVcAIJ4UC5fN1TS9o4uA+F89xUpOj+SammGJkD+X0D4uIAJD6m
         dpfQ==
X-Gm-Message-State: AC+VfDz4t6FQaVoTJ3ftowgo90N8nQV7rdTJPLZq+B8Q/R9Wgki04mw/
        OHD/gzg1nLEZEIDoS8BPgjEB38dBS2DqTeCoUts4G/7SIP/MuQ==
X-Google-Smtp-Source: ACHHUZ6j+ejycCqIjh6Kld0LkfV/EQhCloGDlx6c6D2BP9QB/L+dfT4ylnNHisPZZ2tf7BCFt3dMl+rmyjsnZlYyZIA=
X-Received: by 2002:a05:6102:3165:b0:436:57fc:ffa3 with SMTP id
 l5-20020a056102316500b0043657fcffa3mr681994vsm.23.1686051030360; Tue, 06 Jun
 2023 04:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230603142453.92582-1-franziska.naepelt@gmail.com> <ZH7sn7i2t+5IrXXK@gondor.apana.org.au>
In-Reply-To: <ZH7sn7i2t+5IrXXK@gondor.apana.org.au>
From:   =?UTF-8?Q?Franziska_N=C3=A4pelt?= 
        <franziska.naepelt@googlemail.com>
Date:   Tue, 6 Jun 2023 13:30:19 +0200
Message-ID: <CAAUT3iMD=K4GStMVG5YrenBJdDW08biu+jBJ9cPmz_un99o-Ug@mail.gmail.com>
Subject: Re: [PATCH] crypto: Fix checkpatch issues
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di., 6. Juni 2023 um 10:21 Uhr schrieb Herbert Xu
<herbert@gondor.apana.org.au>:
>
> On Sat, Jun 03, 2023 at 04:24:53PM +0200, Franziska Naepelt wrote:
> > crypto/crct10dif_common.c
> > - WARNING: Missing or malformed SPDX-License-Identifier tag
> >
> > crypto/fcrypt.c
> > - WARNING: Missing or malformed SPDX-License-Identifier tag
> > - WARNING: Block comments use a trailing */ on a separate line
> >
> > crypto/hmac.c
> > - WARNING: Missing a blank line after declarations
> >
> > crypto/md4.c
> > - WARNING: Missing or malformed SPDX-License-Identifier tag
> > - ERROR: space required after that ',' (ctx:VxV)
> > - ERROR: space prohibited after that open square bracket '['
> > - WARNING: space prohibited between function name and open parenthesis '('
> > - ERROR: code indent should use tabs where possible
> >
> > not fixed:
> > crypto/md4.c
> > - ERROR: space required after that ',' (ctx:VxV)
> >    Lines 64, 65, 66 have not been fixed due to readability
> >
> > Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
> > ---
> >  crypto/crct10dif_common.c |  1 +
> >  crypto/fcrypt.c           |  4 +++-
> >  crypto/hmac.c             |  1 +
> >  crypto/md4.c              | 11 ++++++-----
> >  4 files changed, 11 insertions(+), 6 deletions(-)
>
> Please split these up into individual patches.
>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Done. Please find the individual patches here:

https://lore.kernel.org/lkml/20230606110322.96290-1-franziska.naepelt@gmail.com/
https://lore.kernel.org/lkml/20230606111042.96855-1-franziska.naepelt@gmail.com/
https://lore.kernel.org/lkml/20230606111749.97469-1-franziska.naepelt@gmail.com/
https://lore.kernel.org/lkml/20230606112610.98149-1-franziska.naepelt@gmail.com/

Thanks,
Franziska
