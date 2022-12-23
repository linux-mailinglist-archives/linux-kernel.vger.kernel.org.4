Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9D1654FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 12:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbiLWLvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 06:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235995AbiLWLva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 06:51:30 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238BF6307;
        Fri, 23 Dec 2022 03:51:24 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.99.43]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MCsLo-1ozv8R1iQi-008vs5; Fri, 23 Dec 2022 12:51:03 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 516563C0EF;
        Fri, 23 Dec 2022 12:51:02 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 5F77F751; Fri, 23 Dec 2022 12:50:59 +0100 (CET)
Date:   Fri, 23 Dec 2022 12:50:59 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     masahiroy@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3]  scripts: kconfig: Added static text for search
 information in help menu
Message-ID: <Y6WWI87an9IRmVod@bergen.fjasle.eu>
References: <20221217055148.28914-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QQ/PX5GslodXe0Gc"
Content-Disposition: inline
In-Reply-To: <20221217055148.28914-1-unixbhaskar@gmail.com>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:b2fUXJCdsgsHJt3fstwJIvD1GkZ61v5ytWvq2Tb5fjf/TschsQh
 E0SHU2Zebqf5AzhLcHB6RF0k1a+1pDF3VCeUaEKtOOtbINO/Wdg+ucbJ6HBXSq9H0NJdQ/7
 JDH3xObS+cUvEb6wrgMrx7WcbW99iGMKtj7Fvm4kjW/HghFgbBuLFWaJFHRt1LrjAaxkLQJ
 QEd1zLGvDi1P476c6z/Hw==
UI-OutboundReport: notjunk:1;M01:P0:euL6hABAGFM=;geB4rej9/aP++bm6wOcVyJmo3Hx
 cvdiEsr+QLDs1TCGsMNLlTGrkcdIwaBvlTktuY/PxqX2Ecb37I1F0Y5qvkjsovM+A8mCZMWef
 //CTV3cCEr7Ab4X7k41ESMGlI8iRMRnhorr8NbuqIz4EKwB+MbxB85u8RkWJmmkN7CnUKwwiu
 2ywajiNYu+lHPgTYk6eJCyl7A2bpnxURtHLzc9yao+9Cywg28GuH1j6OxCcbc71RPEWVtsu+4
 QgLfJPat/18xUAZC55tSBwbc3wuXGu2wCV4oX1URXsi36EY0HRIlsZZjbgNRKKwj0EBWWnY3E
 wsuDpULRLj1v55LaMmuIqsftGXNrogWlPGwIwqIBORMCnEfbIr+Moc1nnBmxwtMGTVxmOby5F
 l5ctgd9vZ9VU0j+IUM32SurAgMgsafvDldTmFKLVet7djgbc1raVGm15mGxslnOvO3R/akuxv
 7T8tnrmdqmmhj5WK6X2OcwWlFmwRAjAhPn7sQgME5nfL+fkrmS5YlRh6oSk/SFjZCaRCPaHjA
 xWsCPS3C0cTlSSuByjjhrlMHGJtHdGgOwblE2/yHlc2vecDTRrsjzpzVcP7zNcJjZ3K7iwFlq
 MabS7//2mdWJ2TVClqeRIn66oWUtTc7WktXMB4ckT5yov7uxqcfdEp3FItEmyRFiWIEZYwK9G
 zj5ObXdtxIwE5AlNgJ1Az+D22nj7/lZDAvacmMpWDw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QQ/PX5GslodXe0Gc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 17 Dec 2022 11:21:48 GMT, Bhaskar Chowdhury wrote:
> Reconstructed the sentence for the better readability.
>=20
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

I liked the commit message your v1 much better (minimally changed):
> Add few static text to explain how one can bring up the search dialog box=
 by
> pressing the forward slash key anywhere on this interface.

Would you mind updating it once again?

Kind regards,
Nicolas

--QQ/PX5GslodXe0Gc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmOlliIACgkQB1IKcBYm
EmlQGhAA3th7SKiFM0WMOJEzLw4xIWfU26YN7xeb0TJDoPUieOW3YsVUdFiwJY9I
tkQO+otdIxjuFHkIpMsS7iW4Ug6h1qlPjYFUx1sNk72NckIbamAJheBzCc3QRDG+
2Xmbwtw0aOi1YrAk0xx4cJbgqnN7aN5Usl7xrciEE3prOmLVxKBpGWpCjHIEmZnY
e4uNhvFOzo+VAJsG7tvwSxKMDok87vtNtrCQKhBvLfJ8kyS2W6nQyJFWGUxYMHNN
0+YNsRTNXABys1FrhVi5OAca6vBxe3cBmtPoFZvL2lMi2KAqvigPqCviMT/m7WIy
deSjghbDJQ6dDsGeksBpdvrY2BzAqCMXw/DrAIRc6PG64GjLvRisHvFO3nR3WpqJ
lhp0Zl00l13yZM8PGLqPVmkHZai2PdWaAjfzjsx5WJXfYObJkr/wdPxyH3DAfjOH
2rHj2YNdywi/loyRZemlwrd7brUv/Dm/mflFHP3yJpLC0uvJFdYwUxB3X1rI+3Vx
zvCOD3QJNUlo4L2zUR6PHgbRdlqX+4KM4y2yFX6QRPeKwQXglfB0/EyLSjh/RuAl
OXNFR9WHhIg/oYrDmHxo25dv9g2z+Thj9tFqTpCKqroD3VO44hd1knkFtpskIAEo
N5bstp4kYU/ogM6a8ASuzSJlc7233o7H7beh6Z/0LyAJ82L374Q=
=h9uA
-----END PGP SIGNATURE-----

--QQ/PX5GslodXe0Gc--
