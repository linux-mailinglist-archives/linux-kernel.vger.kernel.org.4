Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796D16EA2A7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 06:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjDUEVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 00:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDUEVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 00:21:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3094F525C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 21:21:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a6862e47b1so20393115ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 21:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682050862; x=1684642862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TxBdc/PRX4p+DsSRUiF0vdFJbl++QpQEOpL7JwVgYcY=;
        b=SWEaEBksyKx7gxjES2P61dY4k5teoEKck/LRwNV5ftXraREO8rSvwesqV9XWR4+wJP
         URo3XJOWIvpBLHjgpGBf8lNj4DNY7VDshFi6+xlR3mvaKfa+y+1e3pzWl1BaqQvR53Bw
         MtB1Vr+Ohi2VDK7hjq/IJMMCVUg6ZMPWxQa/f366pNKbBezK4T00swhEN3VWohQhDb+9
         PBnMjxwDayWa+qXIGd9D3T9B7MXjdiXnWrdtNfitjvdjM8NvPPDhV994RxWq0E7bVsh6
         hXH0EFymiMoQz2iAL5L09PEtywy5Qn+8EqIIgLP4dA4EsL0gXHDvxqmZ3DoLr4bvbcUL
         uu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682050862; x=1684642862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxBdc/PRX4p+DsSRUiF0vdFJbl++QpQEOpL7JwVgYcY=;
        b=Honq+Q7Oh8KqmovBPYpX606mwbDjseaj7o1D61BJtuW9kED/JwwcFyWW9cWvWvRO8w
         qM+egljBuUsct6vfm0ZAE+25UbpDUuUwYBJ3yMTGW7MgkQWxmmjw50FQw3NnuuJqLBgU
         SFtL8HeDUKZJ9p9DYqOEpT+2pMDDgnzg7f8vd74fXqb3D20ri5I+1QQ7XLEaFeu7J56u
         6KesyjC7d76vr53NRZHrpXCEVs69GMOtWARw8lFkglvv/4tvOfCgLx9To6EBZvfiLDiA
         bU5UR3cCm+OzC6+adTEHtZKKVEGWAuumacnNSAU6wSR8opF7j42qa0USUude9Uvty6Av
         6C2A==
X-Gm-Message-State: AAQBX9fFn13FGnrWb99dAdVbu6fMpdX8QTSi3v8lSFP0GmoLa6qn20KL
        X4wYY4KMN6dD/WFSY5cKnyQ=
X-Google-Smtp-Source: AKy350bFHFTuoEpUJBX0H3NG2lSHihuB7T5W/Dp6+XyRJYjQpepGO9CALNTod8G2AwN9d/MAN0g90g==
X-Received: by 2002:a17:902:c78a:b0:19c:d309:4612 with SMTP id w10-20020a170902c78a00b0019cd3094612mr3354823pla.6.1682050862500;
        Thu, 20 Apr 2023 21:21:02 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-78.three.co.id. [180.214.232.78])
        by smtp.gmail.com with ESMTPSA id g4-20020a1709026b4400b0019a6cce2060sm1831511plt.57.2023.04.20.21.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 21:21:01 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id F05E21067D5; Fri, 21 Apr 2023 11:20:58 +0700 (WIB)
Date:   Fri, 21 Apr 2023 11:20:58 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     =?utf-8?B?QW5kcsOp?= Coelho <andrealbergaria@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: strings
Message-ID: <ZEIPKhKNz7LnhM/q@debian.me>
References: <8de1912e-8009-3c85-ece5-7ca7f03be42a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6RTX+Scp426zjo9r"
Content-Disposition: inline
In-Reply-To: <8de1912e-8009-3c85-ece5-7ca7f03be42a@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6RTX+Scp426zjo9r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2023 at 03:58:47AM +0100, Andr=C3=A9 Coelho wrote:
> greeting...if youre interessed in string algorihtm check
>=20
> https://andrealbergaria.github.io/
>=20

Looks like above link is about hex arithmetic implemented using strings,
right?

And the licensing is similar to Qt: it is opensource (GPLed), but there is
a commercial offering for proprietary projects.

Also, on what use cases can your idea fit the kernel context? Or doesn't the
kernel already have the implementation yet? Perhaps better implement as
userspace library? If it is the case, I'd like to see actual patch series
implementing your idea (see Documentation/process/submitting-patches.rst for
how to submit your patch).

Thanks!

--=20
An old man doll... just what I always wanted! - Clara

--6RTX+Scp426zjo9r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZEIPJAAKCRD2uYlJVVFO
o8uRAP9T0kSMR+HnUlNw9lXuk5ShNttkExe7Pi87sqddcYmUUwEAippazfiDhPKu
2aQJLNVsEbK3kqsriZmoCvBNPOzqUwk=
=qYS2
-----END PGP SIGNATURE-----

--6RTX+Scp426zjo9r--
