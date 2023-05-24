Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE65870ED9D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbjEXGHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239633AbjEXGHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:07:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E1B1B5;
        Tue, 23 May 2023 23:07:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QR11T43q8z4x2k;
        Wed, 24 May 2023 16:07:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684908445;
        bh=+DMojRS8ERYc4xfmSSOicH5FBjvNc0IPIb2vZcvbwtQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cmObQyf+t1xqhqrSPHVQuwQtQaC0E82cShNmYfEIiTyCzR5Z3rKG2VjQEPmkmHiRa
         UEL14iRR3h4VgxRIlm4PpZeM2hAUomVOfnoISeAC8+CiG6RWkok46P2MT3Wu33F/BE
         xIf/qmXFqaFTKYJuZ91e6kDaCQGLZDg7inWnoyoidjSv9+t+VlJYFLvBP2yK9tDiSf
         dsfe2TNbAP3D0XJo4EDO2PvRdQGsXgEmoB/T97YzEvrJe4UHrJjaIxzoOB/3XDqY+f
         qU69jGfMrvKCZcdyFsoHi7orpOB/APCQAZFCGip3pTT2j6vyiyquYQWbqKmkYXfOzi
         mZqV76jPdbaog==
Date:   Wed, 24 May 2023 16:07:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Granados <j.granados@samsung.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: bott test warning
Message-ID: <20230524160724.0df28220@canb.auug.org.au>
In-Reply-To: <20230523112001.owwx7sa7qofwuzfd@localhost>
References: <CGME20230523035747eucas1p2f10754f5eb6759d6665a35562c523841@eucas1p2.samsung.com>
        <20230523135739.73068c68@canb.auug.org.au>
        <20230523112001.owwx7sa7qofwuzfd@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wDaosXVAE7L7ju4b./mQPPQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wDaosXVAE7L7ju4b./mQPPQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Joel,

On Tue, 23 May 2023 13:20:01 +0200 Joel Granados <j.granados@samsung.com> w=
rote:
>
> Does the attached patch solve the issue?

Yes, it does.

Tested-by: Stephen Rothwell <sfr@canb.auug.org.au> # ppc boot only
--=20
Cheers,
Stephen Rothwell

--Sig_/wDaosXVAE7L7ju4b./mQPPQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRtqZwACgkQAVBC80lX
0GyVtgf/Rsk672L6GPmL1EEhPFPBt6QrK1Ku1QJUd6Zv3tE6S0ooW9iFSkZg6h+g
XAQnjDPlz7wbu2pBnPfucZ80FmKTfUUpbQVKOh47N+g/PpCL1CY4zVouuNGsue1U
rP/Pfc1fkWvo0Ha1OLeVyEwBUONqKUb7RCIKWFoyIMzX1RfHBNulXBKOwc+2rxCk
A1cWd+61Uv8isahdkvbtn50gi16Lpsx0JhzKXV7jIhrFQZmE/+9kmj4MzMW07AkI
KHQW6c9o6TMyWczwuod7rYWU83iKvwhLRo7beUKEE54s0mMoyd2D5jr6i8UwS5fk
ZFvEg+Al4o4Vj3keyP+EN0EtXcFoQg==
=Jrmd
-----END PGP SIGNATURE-----

--Sig_/wDaosXVAE7L7ju4b./mQPPQ--
