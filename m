Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62AF71539C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjE3CY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjE3CY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:24:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C299D;
        Mon, 29 May 2023 19:24:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QVbnx72Z4z4x3g;
        Tue, 30 May 2023 12:24:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685413494;
        bh=jFMvgT+vRVaHGniGrdotfgFb+ufVLyM/9m3Q7wHttJA=;
        h=Date:From:To:Cc:Subject:From;
        b=lNUnPdKxHyhq9CkwQDOr+/ZeTYnbTfrSbx3DRJjVWZnSUSqzjKADtJPWKRFK8uJse
         9Cj/WPiWeTHLJjX5Ji0y+hStXmm5WbX98/P4CtIGIL0n0LBDYmLjSDVpgStE7nWbBR
         tQlc4/QN+fVGtmrejAsS64I2+druiLIusdLo/G+htCNulXuZwOkzzJpwi3Jn1mg+c2
         oVX5BxVyJsaCn8q0R7eqbNiU8KN+gka8iPN3hbWAygbZXGVuEkFl1J96xqj6DIMyIe
         ETFSzitaqu3ADJIYi4WV5K9YRVgHaDS9FpWV2ePrRYQC0Ni053TbafsaKHv0MiiP/y
         mrqGJMdwHUoeA==
Date:   Tue, 30 May 2023 12:24:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the ieee1394 tree
Message-ID: <20230530122450.1603af75@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/28qP/rWwVYB3KIA8M9JXhTs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/28qP/rWwVYB3KIA8M9JXhTs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the ieee1394 tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: missing MODULE_LICENSE() in drivers/firewire/firewire-uapi-=
test.o

Caused by commit

  dc7c51638f46 ("firewire: add KUnit test to check layout of UAPI structure=
s")

I have used the ieee1394 tree from next-20230525 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/28qP/rWwVYB3KIA8M9JXhTs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR1XnIACgkQAVBC80lX
0GwTkwf7BKE3xg+93/PsddiA/k/M9xSnzwmM9/Waau4jYpzSCZHkMqlq6+rihKGH
WuP+N9BkAw1v1JHEh1jt9t5xQorrgM9GAQyOROr2MyhQU7uNQkAokjh5ALgomPiQ
SvFBdv72CslBTS3h0Y6x+IDCuvBuGCfQRAep2bzrNBymID4adIkdtEsuOU9fvqS6
NHu/6YhfaQMRVgDvbK/abIAkf2nXaIFqsnIFWUisvFcAvnsPWgRrnH48sQyMoRhU
HdlYCA0jVpt2oGDokNGnKBHHBwnUSSLGh2uoUbRgA9r7PzVdpiICVhsIdz+LXVds
7KLCT039qOsJKJ7VERMI9Mm/Ce5RRA==
=Fq/8
-----END PGP SIGNATURE-----

--Sig_/28qP/rWwVYB3KIA8M9JXhTs--
