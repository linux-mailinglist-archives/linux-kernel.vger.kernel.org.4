Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FBA6C5D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCWDP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCWDPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:15:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F392E2F04B;
        Wed, 22 Mar 2023 20:15:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Phr8566jHz4x5Q;
        Thu, 23 Mar 2023 14:15:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679541352;
        bh=XtroiJMPDUMg9vCCpt7+TZZvuww7lTNkLC2sPHQiX2o=;
        h=Date:From:To:Cc:Subject:From;
        b=JFW0TUsbBb4TS0P3o4QXRq0bbjLYx0DxI5RjGHWCl9Z3t4JbhQocig7OmYB8/1YpR
         G/TugoNu+D4vYaFeeSDpw6s8Exa8tpP6CZDUb2vl6JhRqbkHLd09bTF9IS+6PAyibB
         YAmLztFK/Y6/ahYYlp/40h2GVvIL4WriYCjNuyXuAyV6nQpbfSz5+hlTV+cjntyBRo
         W8SuCfaDOezj2sL/U5i15aNBXOTpwsL3hRVofD7iZXtJNmiVgFsbT3ghs+lUAvQwRS
         Symx434JpRflGf6bf0DeorWTjyOqtEP/3zAcRxLSLBXhKe7CK3Lk+3kKWSOnx9+98c
         DsnT1twhG9qNQ==
Date:   Thu, 23 Mar 2023 14:15:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the wireless-next tree
Message-ID: <20230323141548.659479ef@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BWoF9whez0bc.zKARTttO.V";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BWoF9whez0bc.zKARTttO.V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the wireless-next tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/driver-api/80211/mac80211-advanced:214: /home/sfr/next/next/n=
et/mac80211/sta_info.h:628: ERROR: Unexpected indentation.

Introduced by commit

  fe4a6d2db3ba ("wifi: mac80211: implement support for yet another mesh A-M=
SDU format")

--=20
Cheers,
Stephen Rothwell

--Sig_/BWoF9whez0bc.zKARTttO.V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQbxGUACgkQAVBC80lX
0Gy24Qf9HN0uxihxTWMcJbhUg7nN5MlGiVuc5l84QYrFGDX8wPQgjtPFHa0+Zuw/
ft75jN8CFnsoH8RNX4HSHBaVGRAw+xP/Py8FZPnAAb8orLuBC16k3vK1wFZbpAGH
o02T1p6QZEXjbPzf3tSxfIZcMCdg28TdWwfz/6l8AotyRFmy/lh69orY2psjq9gP
Q3OwGedd4RMAPPCgPSTsOiCS1+Ko+IXULdgfNiTUhnePWptxiE+95v45mMagi+DH
/gUCaCOJnfrSmDfRFl9uNVnZVYcLmdjFLVC1Ijr+y5Zzzoy88ZkDhgT2Zx0g8G6G
FL2YlAkrIAHZUGigMt2tHi6SKqsSqw==
=xc27
-----END PGP SIGNATURE-----

--Sig_/BWoF9whez0bc.zKARTttO.V--
