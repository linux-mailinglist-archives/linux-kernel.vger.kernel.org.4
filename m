Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F7F658DCC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiL2OMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbiL2OMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:12:36 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9C3120B3;
        Thu, 29 Dec 2022 06:12:30 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.97.69]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N95Nf-1onzkq2T2N-0169mQ; Thu, 29 Dec 2022 15:12:03 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 67D7E3C0EF; Thu, 29 Dec 2022 15:11:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1672323119; bh=hzuxaQAbhUIwF1zkKpO8nL6M+av6dJM+H6CWsNdY+Oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hB+5ZRRCVRfqpG6JNyVfnfET0JP/T9msYSpxRAyr0SksprFKDnLeNgLqup5ttWGuw
         pEToc3yd5DTXWwJyey+HRxOm0MmUq7kUXD9R/Km0lfBNIDqkyKw9gENKZ5/teqkR8A
         yd8VTmyPM9EJVhyL460C/Dmjlzn/pU+vMIcLtQfs=
Date:   Thu, 29 Dec 2022 15:11:59 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 2/2] kbuild: add more comments for KBUILD_NOCMDDEP=1
Message-ID: <Y62gL0J8ZfWE+RjS@fjasle.eu>
References: <20221229091501.916296-1-masahiroy@kernel.org>
 <20221229091501.916296-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LEOdX27HsPnABSFD"
Content-Disposition: inline
In-Reply-To: <20221229091501.916296-2-masahiroy@kernel.org>
X-Provags-ID: V03:K1:mot9s2qFIcA7P3M1JHNig54gLKvS4De0SH6oxY7q41Fv8N3Fx7Q
 6BLSpzNB80GKEunsMZNiwi6BBpRp2hoxrtDG1JVVqopsVDmQqTzu0uwQv7OZxWdDDQCm5Hu
 fW7whXkZXBABnWLnPnnA2O/J5GRmUIdzZX3lSII7KIpkQFEopHdTTk7IJ1mtvQgUlZ7GhSd
 536hn8ytefo0xdCjeecSQ==
UI-OutboundReport: notjunk:1;M01:P0:SxiTR0xqFMM=;YmRFZhj6CT4dOJjTFGKurhh3ght
 A5HESlIWFy3iqPXKzyxpLUZv/IByl7sHRNT98/RoAy/4j42kCRaSR8UpaB42F7jMeWQaA+HXc
 /OvHlcdcZEyBjn9ctW2DLc5keqeNPj9339dE+s6MfuTxiadsbw5D2iI7deeimBdVOPtcGSonb
 4jQ4CCd5TObKEwnBi+kJ3Xr8H4GkK2gJC1eg3SIbQeO9PUqlz/7mvf+4ihN1IRlvsprsxT5Rh
 nNnpJwY3MO4/izUTPU37lB3Z3xKqweQD2IoDNg7+W92F2zUVZcdfT1kP6YZOBNemtBqbQsvOY
 r7yKJ/WQfwE7VXIVDLcvxwEbyYO88wrlFqBKCCjZ5hAtqty4/DjH/Fk03hnpMV4F2w3NDzirm
 1YuZ+HJKeHszijeLfqEgLa6b8j2SzvbvukqqCJlRF+kpbhtY0oTcW+DHvnZtz1JxoaEyGsdwO
 75kHIzXw5fYKdshjnkL/un4dE9c+bpjnfShQMlGbOJDgFfIk7sOVj8Bb/pabH0Sh9vcI6BNds
 npdTexpV6kUSS0e16brxHgl7DLuj9p7c2Hm389HZa3NWDCfEUwLVbAQ7DtLI9Csl+9XQk4AzZ
 +vz9jN/2oJzurqIX+0hNINCCpUTCfaoIhP27/HPYGqoNRVMPi0TKNUnYo3qvdlzJvaVgh7nr/
 LOiGEJPfG+MunGe1aSCziHV8iQzspiuRVtySs3892w==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LEOdX27HsPnABSFD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 29, 2022 at 06:15:01PM +0900 Masahiro Yamada wrote:
> The cmd-check for KBUILD_NOCMDDEP=3D1 may not be clear until you see
> commit c4d5ee13984f ("kbuild: make KBUILD_NOCMDDEP=3D1 handle empty
> built-in.o").
>=20
> When a phony target (i.e. FORCE) is the only prerequisite, Kbuild
> uses a tricky way to detect that the target does not exist.
>=20
> Add more comments.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  scripts/Kbuild.include | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>


--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--LEOdX27HsPnABSFD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmOtoC4ACgkQB1IKcBYm
Emle6g//V404GvTeBPxZ3zxcoLxyzz7nwip2QIYmdxq3FhGmjk5KtXYTIAfBUGLR
aEW+oZPgbeN26ialeN/pti1Qkt55wKb1gmyzYDKIaJO1pPTwqQbR5+fztMjCa8Nu
/yUhN4L8izP4BPD8/+bxuUW5YyZpC2yXT3qPiKY2hivzdDiNzGXE8ACzvhlgUwYy
kieg9jq1mc7D/VZvptXHwXcLvqO5jooPzINKPt4baPenVay5HhK5OIvY5gokY5t+
6giiwbNeHPMzdBkZx/Tvx3iaGN+t98RlaNuq7CYMDGRoFo3EZH0jzGWR/cd1QSl6
uVD2qM6Tub6TB/kntEIAsK6qL2IGYiL699+GhZNxuIOIptj/XRyMZW+BjH/dbAur
T5kpgHcF6nECNjju6XS7iPwzq36RKJ04ykIJcwawWLjh9nOoEiug4RTRokUnXa9h
GScNLgpk/yZwv0Y8/unN8XCLvb6/fsAfWXUGcaQ6sDHOzSZlHhhBfcNI2yBDTDS4
ivUCxF+873VAzDd+CEriALYkr2mETbufMpW/uClB/YuH6hZO4QeKLSNJzUO/mmlK
fh86my4kGFuvFGhCBr1o7z1C2Jq4Ajv4VJuAz++LeK7G4qeYBO8Wq0g9SB7GJi1X
buc0hdfv9tSn0r1EttmLyyi5rC65okBhTW39kyZ56Ob7ozMhf24=
=9Ne2
-----END PGP SIGNATURE-----

--LEOdX27HsPnABSFD--
