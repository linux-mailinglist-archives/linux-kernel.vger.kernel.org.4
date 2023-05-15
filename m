Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9548702BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241490AbjEOLni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240335AbjEOLlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:41:36 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C008271E;
        Mon, 15 May 2023 04:36:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QKclF6Qt6z4x5d;
        Mon, 15 May 2023 21:36:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684150586;
        bh=QFbdw2qc13oq3/vRpBrSRQL7kCJSMc8q2j1r+/HoGaE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PZ08KYCzTSuWT8yi8qGueGAE2qXrFdLyGF63+npyfdDvxnepFC7UnkaG01KhPmU9B
         Pj27HZD7+8jaac2TtlWBiC9qAMcEt/B080hzmgGF2qsL9abT5S4rEvfWAbEvA9RLNy
         c5J9Nm+4qckLkoIvqDvDuhpp85PzdrFQMMP9E+CjO3uqkHNoxHcmkcSY/CaoxQXH9a
         uU+2xOLT5A9TgQUFnwErTYAGIUAX4QXFzxizgTUJD01ZmrCFJFoByxOMueQVx7TJp3
         HZExiBuzezrXXHAqpGVdj76nBSTTocgxc6h4Tbe6uYsRUfElTD4i3t/q0v4d+UMAHv
         s6zzSdQQtYfkQ==
Date:   Mon, 15 May 2023 21:36:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Greg KH <greg@kroah.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <20230515213615.779669de@canb.auug.org.au>
In-Reply-To: <5082d743-54b1-7b4c-432c-dfdce1bb772a@kernel.org>
References: <20230515123524.74e7bda3@canb.auug.org.au>
        <5082d743-54b1-7b4c-432c-dfdce1bb772a@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6=f.8R0W+PPDGPI5BZF7PsR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6=f.8R0W+PPDGPI5BZF7PsR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Roger,

On Mon, 15 May 2023 14:01:08 +0300 Roger Quadros <rogerq@kernel.org> wrote:
>
> >  +	dwc3_core_soft_reset(dwc); =20
>=20
> Please drop above call to dwc3_core_soft_reset().
>=20
> > ++	ret =3D dwc3_core_soft_reset(dwc);
> > ++	if (ret)
> > ++		return ret;

Thanks, fixed for tomorrow.

--=20
Cheers,
Stephen Rothwell

--Sig_/6=f.8R0W+PPDGPI5BZF7PsR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRiGS8ACgkQAVBC80lX
0Gxhegf/QBFLrGjbqgCAb9wXawjKoGCZgXkhkTwS/ivxenT79wnZKH4O7CsBXg/5
yfAUoBJ3R1FBuB9BhYBW0faZ1J1M6knazuTOzy1341MFShPx4cXdS9/pOl7AL5pF
wxAzZJ2f3f4UV5rxvWq6jjPFhGHHZuy+xBRO0+iSV+njcX0VQ/WK0BhoHXvkwyQu
L2zHWo26p+wgijHWRfynTElGYs7MuZf9UjrXK2x8MRWY+fcWVvO5AQVOV4UU8sd+
WCvX/RNwJklSMaJaUge6Y7v41Z0bzRkOzDJ7wFTnfW6EFIGhfAxde7unSoppQcT7
USYZrxUb8vL/F4F1ROzSEUyAyA4bxA==
=iOko
-----END PGP SIGNATURE-----

--Sig_/6=f.8R0W+PPDGPI5BZF7PsR--
