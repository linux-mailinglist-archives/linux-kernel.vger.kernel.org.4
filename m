Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9FC6D5B4A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbjDDIzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbjDDIzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:55:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58D61BE6;
        Tue,  4 Apr 2023 01:55:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PrM600G0Hz4wgv;
        Tue,  4 Apr 2023 18:55:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680598504;
        bh=VC5K2z8Xgep68yVp7XJHwwXmzMI3h368uMPpyX8Jh3M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SbWySmgoVUrripRgvLgYccrFoW3EWBB3sKhjrzzc0PwjaobKWEBPmWiEkWLXCsQ4N
         n+tqZ8ns9heUB+OvTXvtMl8wMaohztYqjrJ4oBA/LwT1o5SkPQzmfLcQya0ZFvq2Z5
         lOjXFlyR0yWaj2kqNtHs1cVUJcECkyXbjqRzt7jQjE3hTBTYOQkgF6Gqu9BFKhPvfr
         URBTde7MrcaHsIkp8/6mwe2LnMySyZJzuReA81rQq1PHkM/wd6VR+9pEJs7cNF0yQT
         3C+z3GwkeZOYaMnSSMY/vBjmi50eyg99NdjYLgZoDLEpKoezQ5+gxXRot8pb4f4Fw7
         AGSi7GbeU0tUw==
Date:   Tue, 4 Apr 2023 18:55:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the hid tree
Message-ID: <20230404185500.7953d9d2@canb.auug.org.au>
In-Reply-To: <e1eb90db85ed7adad08bb99054f5cda3cb626794.camel@hadess.net>
References: <20230404154005.449800c3@canb.auug.org.au>
        <20230404154254.6c3be26b@canb.auug.org.au>
        <e1eb90db85ed7adad08bb99054f5cda3cb626794.camel@hadess.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=YoKvMi3e8.pq8XCk/Z_N37";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=YoKvMi3e8.pq8XCk/Z_N37
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, 04 Apr 2023 10:22:35 +0200 Bastien Nocera <hadess@hadess.net> wrote:
>
> On Tue, 2023-04-04 at 15:42 +1000, Stephen Rothwell wrote:
> >=20
> > On Tue, 4 Apr 2023 15:40:05 +1000 Stephen Rothwell
> > <sfr@canb.auug.org.au> wrote: =20
> > >=20
> > > After merging the hid tree, today's linux-next build (htmldocs)
> > > produced
> > > this warning:
> > >=20
> > > drivers/usb/core/message.c:1939: warning: Function parameter or
> > > member 'iface' not described in 'usb_set_wireless_status'
> > > drivers/usb/core/message.c:1939: warning: Excess function parameter
> > > 'dev' description in 'usb_set_wireless_status'
> > >=20
> > > Introduced by commit
> > >=20
> > > =C2=A0 0a4db185f078 ("USB: core: Add API to change the wireless_statu=
s") =20
> >=20
> > Also this:
> >=20
> > include/linux/usb.h:270: warning: Function parameter or member
> > 'wireless_status_work' not described in 'usb_interface'
>=20
> How does one reproduce those warnings?

I just ran "make htmldocs" (see above).  You may need to install some
software - but it will tell you if so.

--=20
Cheers,
Stephen Rothwell

--Sig_/=YoKvMi3e8.pq8XCk/Z_N37
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQr5eQACgkQAVBC80lX
0Gwougf/dELCtU4Kj1seXlKgERQs2QIsXhtE3NKYtV1bUmPBBu3XfmAMpjjQnkck
YNfrrSSxV7c7W5r7Er8kNbS1lgmCRvOU7fDiR5Tqe1kW/UsdrCuWOSQE3FKzdhFJ
EepFfjNOljCfZBr4wE4iIw0LY+AHnainXwVqopSbv93y521OgNQKiFy1A+jeidF4
nNlQS5YMy3L3tHVYNLYt4FwVWeAt8fJPZcfkyz4o/amGHPE0ZgVTcVGkWJEDJRb7
hjGxbj5lZEc4hCHTtFFqEVgBV9vkB5tPlReWdGKtIRKZTEKhxqvEiLy3JTL+44bW
+L3IsQwfxDk+3MJaiBGigZC1xBy0Ow==
=87RW
-----END PGP SIGNATURE-----

--Sig_/=YoKvMi3e8.pq8XCk/Z_N37--
