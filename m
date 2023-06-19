Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5157359E3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjFSOmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjFSOm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:42:28 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5592E90
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:42:27 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3EA453F188
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 14:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687185743;
        bh=oVzx6NYhYUEvG3AH2qaIIGghMLVni7wi0TtZ3p4soSE=;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Ae/+RKrmncU9myeHSwFon3FOjr/GFaTPOC1mTLEZfr0DLSXYCwLpmzUeUW+5JM1/P
         67ECXxdxZZaYDiYzGqMygpX6ic7JYE8e0fIPWEsnBs8Id2KEMdis1qOL4/EGhem7fE
         rnsWq9imjssAlh9U3+cQLoE2iR7shVlCraWRO8ZG+ylnM9kSn8cbEhRHI99yjKXH3q
         NQBwpzpnMRqxn1wVnCY09+T452b2X2JosqqAKadiEUH/wYqhRKjNraM1JBYjTw9I2n
         aBo6nIdvSvw2SE0xNFsShuc3dtAO6WLjBkWykE1lVCPwSMxy3ChBCVjc0GPwrSlLbI
         X9NOhGRzHe6jA==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-97542592eb9so212106566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687185742; x=1689777742;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVzx6NYhYUEvG3AH2qaIIGghMLVni7wi0TtZ3p4soSE=;
        b=RBgd+YLpxoLy4HAgvIhl9ZgixZiuzI/dTSM4/t/GvvzTK2KFvfZEnv14obbrv+7yKt
         WpOjkGyKLUbQ1R7xN++DojY1kIAMvQFX8gd9RLgYlxmqpqm2pmNBOv16bdneHWXtlx3z
         BzvTj3P1/BYja+/qHCYmElgMNTdgLV+Ah+KYvIMIeo2t2ROnJY/LoksmtKgZ50TcGL6u
         QUwPDdvlXbmqEZIaCB87AQpxJq1MigL8DMnk8gscEE9RjSiVjwKIY0YZe1ZbnvOncExH
         8AjSlZnKDoBb4j4UuCrQ0cYwbcZGmwmSnvbZlktaWutLyrtyXK0CYmBOMftPB0NLqfcW
         UsWA==
X-Gm-Message-State: AC+VfDx3HV36dSiPV/W8ERlQURW9/Ib5BVIkR1WQqr96P0czsLAztL7i
        JoVRq8kR+Te8eTGf6I73boi2KSQNjPcw+iZHejHrpoqU9n7oEwOMqcP192tZi2pK/NZlKi+otsi
        4sEMql0kC0xE8GTZvhH4jnBAFnXzFLPJGGTxr5fLolA==
X-Received: by 2002:a17:906:4fc5:b0:974:20bd:6e15 with SMTP id i5-20020a1709064fc500b0097420bd6e15mr7712237ejw.4.1687185742788;
        Mon, 19 Jun 2023 07:42:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5uRvfrz4OGRcv0QxkR+P4tDg9wB7UCd8/6nh/dPpJc1WEhB3DIXye/HmnDc/eWXtbGoz8M8Q==
X-Received: by 2002:a17:906:4fc5:b0:974:20bd:6e15 with SMTP id i5-20020a1709064fc500b0097420bd6e15mr7712224ejw.4.1687185742517;
        Mon, 19 Jun 2023 07:42:22 -0700 (PDT)
Received: from gollum ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id bn14-20020a170906c0ce00b0095807ab4b57sm15016341ejb.178.2023.06.19.07.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 07:42:21 -0700 (PDT)
Date:   Mon, 19 Jun 2023 16:42:19 +0200
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Bokun.Zhang@amd.com, lijo.lazar@amd.com,
        linux-kernel@vger.kernel.org, YiPeng.Chai@amd.com,
        mario.limonciello@amd.com, Likun.Gao@amd.com, Hawking.Zhang@amd.com
Subject: Re: [PATCH] drm/amdgpu: Add missing MODULE_FIRMWARE macro
Message-ID: <20230619164219.4ae6a818@gollum>
In-Reply-To: <CADnq5_Nnr=BO2y3O3_x+sX-93CtY7g52m9DHva7WWqeeO5xqMA@mail.gmail.com>
References: <20230616121116.1031336-1-juerg.haefliger@canonical.com>
        <CADnq5_Nnr=BO2y3O3_x+sX-93CtY7g52m9DHva7WWqeeO5xqMA@mail.gmail.com>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VSLr7Uc977O.nGCK=PDUW7X";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VSLr7Uc977O.nGCK=PDUW7X
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Jun 2023 08:53:20 -0400
Alex Deucher <alexdeucher@gmail.com> wrote:

> On Fri, Jun 16, 2023 at 8:11=E2=80=AFAM Juerg Haefliger
> <juerg.haefliger@canonical.com> wrote:
> >
> > Add the missing MODULE_FIRMWARE macro for "amdgpu/fiji_smc.bin".
> >
> > Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 5c7d40873ee2..1f83a939d641 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -92,6 +92,7 @@ MODULE_FIRMWARE("amdgpu/picasso_gpu_info.bin");
> >  MODULE_FIRMWARE("amdgpu/raven2_gpu_info.bin");
> >  MODULE_FIRMWARE("amdgpu/arcturus_gpu_info.bin");
> >  MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
> > +MODULE_FIRMWARE("amdgpu/fiji_smc.bin"); =20
>=20
> This is already specified in smumgr.c.

It sure is. Sorry for the noise :-(

Thanks for looking at it.
..Juerg

=20
> Alex
>=20
> >
> >  #define AMDGPU_RESUME_MS               2000
> >  #define AMDGPU_MAX_RETRY_LIMIT         2
> > --
> > 2.37.2
> > =20


--Sig_/VSLr7Uc977O.nGCK=PDUW7X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmSQaUsACgkQD9OLCQum
QreYUhAAnmXAhO0Tsu0xyykMZZdNzq88fuPv5q6L9CFkZYzPfZouX8irTOMyGuES
vbrn1ZzVf66SzygqILzCkA2nH8sLgGJSF5S7t8yhtjrWsgLBXre88Exe/3RKyl9g
W/zKNzlOlINUo3fm7bfvM+pZl/OKxVtfq2IbgaD/rk5LyFbl17Z1ETTA2TBY9P0m
U4dpQ0KySNknwxEe6l8n3S9oJJzuaw5z0rgd5opwtv5RKFXZQUcQ4i8FcSfNCb89
ciY/SdcRlybfyQ9tlfToOkSLnOkzMlMcmGX9LtiBvZTx6dvKfqd7xqy8p/+8tFTE
sn1icmhV5zvLEyWs8eI51DwwpmK5BlAHbfDsjOfgOjc8r+OsarW5IpF2G8eP93oR
tryuZx+kD1OcBd9jUiEyuJGC4mcYHNndwPniCjxP3OcKWhJsia2V8axHYZ//ddf7
NfWFg6jE+M4j7Nl0C2XWq8KO83ejkSR7N+siPs6pPKUdHTKacJaeO/5ZBm7y0rRx
3C4b335jx/uY74nBrW9WtJr+bOZz2YPTM4GOl6rOqsjy3LmzYt6kpFDYeTUYWoKW
4uj3jRf0257eeaXjCL2kdNS4paQT0Ipil3kaSG1Ea32OyW8+ipqmg7nwuVkEifOx
q4NmF4Rkmx1Q2enwGXRwP+PaXa4a4qe2OuSyzKEYG8IUyxITxFU=
=i1ZT
-----END PGP SIGNATURE-----

--Sig_/VSLr7Uc977O.nGCK=PDUW7X--
