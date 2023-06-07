Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5CB7253C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjFGF7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjFGF7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:59:14 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CC483;
        Tue,  6 Jun 2023 22:59:13 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b280319df5so2175636a34.3;
        Tue, 06 Jun 2023 22:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686117552; x=1688709552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MHwu0cTQLA+Gs80P8q7mAMoeqaTRKAruuL8J1pfaeIQ=;
        b=P2+rCoKsn2k15rzZS9tWaCJ0rIkFDX/+57ugz16YrIQxuTXGG/5NQprdCpUOL+FGcc
         zeFnuZFFxKjjhGApXEXoTnsA4/4mTiVbZE3o+9eWK6Eji59GCJWs9upTMH3weWih8pjm
         qfhZDSoEUHHRM8S8lTJf5waQVQQYGEwU6hJc9F4rC1Fle+Y/z/nVB7WXgvaIi5uEQ3s2
         pWgy8E8knPl504bCQ5jsGD1UrvH2JYBEkzUdtd1RFrZ7fmuk/OEfDlyItgbowCKOI/cg
         UGUU1QB7CO85bG0vRKaod8dw1xSKAm0KZjcK8WdFjvzM+QjmOMiksPMGRRrho6ps9pxs
         48JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686117552; x=1688709552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHwu0cTQLA+Gs80P8q7mAMoeqaTRKAruuL8J1pfaeIQ=;
        b=LG0D7c8161beXxdh11VAPFvg0R73rV8u9WOsro4NJYohdoMMn7QalFIACQPz+Ahb95
         +a22Zf4QG5/uB2+ZQmjM+huCLXCSrPa0HHu128utOnbsjJrS/6IYSLDSNrn4e1CvyRz1
         mcp+gyzC8VS29WrcGBtXtZXro86+6qCWI0PK1EjQlo/Jb7vjDzeIBFeOElQZkCVG8IT/
         vmXwA43xpX945F7iEaW5Jsn7jkPSyJVStP4aHsHZzftD1XW9HML1CXQZHB62cL0i7cdx
         v+yWvJxGmynu+YD4kZMEKaKnkq0iQ91RkUItkQayocHyMq8KCzipvTP5b6P5RSSbGcGL
         MQHg==
X-Gm-Message-State: AC+VfDyl7xCLQYAEVYJZVmBIaJNO8LDC1cN4dKwciKOWMlV0aBQjnJDs
        BnYXAgbnVKJk9FZ97NpBx561FzMVsJI=
X-Google-Smtp-Source: ACHHUZ6vX87B4iU6ZRZ7wFa6TiUwaBVH7rCa6xiJiNGWmitzcntRDnaMmvAF6SpLeqn9d6zTI9bIxw==
X-Received: by 2002:a05:6830:1183:b0:6aa:f826:5bc4 with SMTP id u3-20020a056830118300b006aaf8265bc4mr4391947otq.19.1686117552224;
        Tue, 06 Jun 2023 22:59:12 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-58.three.co.id. [116.206.12.58])
        by smtp.gmail.com with ESMTPSA id b10-20020a63cf4a000000b0050a0227a4bcsm8391643pgj.57.2023.06.06.22.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 22:59:11 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 911FB1069B8; Wed,  7 Jun 2023 12:59:08 +0700 (WIB)
Date:   Wed, 7 Jun 2023 12:59:08 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Franziska Naepelt <franziska.naepelt@googlemail.com>
Cc:     davem@davemloft.net, franziska.naepelt@gmail.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH v2] crypto: crct10dif_common Add SPDX-License-Identifier
 tag
Message-ID: <ZIAcrKAsBZk8mYOg@debian.me>
References: <ZH8ntoGLJHQpZriL@debian.me>
 <20230606180713.99460-1-franziska.naepelt@gmail.com>
 <ZH_-c_WHg2jz0W1R@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8pW1sZOkG8WdTcSu"
Content-Disposition: inline
In-Reply-To: <ZH_-c_WHg2jz0W1R@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8pW1sZOkG8WdTcSu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 10:50:11AM +0700, Bagas Sanjaya wrote:
> On Tue, Jun 06, 2023 at 08:07:13PM +0200, Franziska Naepelt wrote:
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> >  /*
> >   * Cryptographic API.
> >   *
> > @@ -7,21 +8,6 @@
> >   * Written by Martin K. Petersen <martin.petersen@oracle.com>
> >   * Copyright (C) 2013 Intel Corporation
> >   * Author: Tim Chen <tim.c.chen@linux.intel.com>
> > - *
> > - * This program is free software; you can redistribute it and/or modif=
y it
> > - * under the terms of the GNU General Public License as published by t=
he Free
> > - * Software Foundation; either version 2 of the License, or (at your o=
ption)
> > - * any later version.
> > - *
> > - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> > - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> > - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> > - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> > - * SOFTWARE.
> > - *
> >   */
>=20
> LGTM but I'll send a SPDX conversion series for crypto/ instead soon.
>=20

OK, here's the series [1].

[1]: https://lore.kernel.org/lkml/20230607053940.39078-10-bagasdotme@gmail.=
com/

--=20
An old man doll... just what I always wanted! - Clara

--8pW1sZOkG8WdTcSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZIAcqQAKCRD2uYlJVVFO
o74OAQDhYUayI3X8Tu+hpDTLDmuPNvd17mychR4/1HP87fxRMQD/VlfeJnPP57DF
ArZ04OgIbjp5P9QVc0pgxf1QUO3xdgg=
=MNDY
-----END PGP SIGNATURE-----

--8pW1sZOkG8WdTcSu--
