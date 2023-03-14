Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CB86B86C5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 01:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCNATV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 20:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjCNATS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 20:19:18 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AAC2E80B;
        Mon, 13 Mar 2023 17:19:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PbDfS2kpdz4whr;
        Tue, 14 Mar 2023 11:19:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678753152;
        bh=RvgXDWT0B/3pVtS5a3R9IwdksaQYKBwWnd/n3mYIF6Q=;
        h=Date:From:To:Cc:Subject:From;
        b=VWNibYsrBi0G1m0sPOGtvW+AwNXObOJQ0uUdU8RvEGUiFl2ewoJCzd/6S7yyK2ljX
         eY5vXbAz9qOCHr0eaZFfyWbzvfDWo0SHu3rCrMcwVBc6UZpyaLBYjiGXxy/hfR5S7Z
         2kt9MhmX4E5gWqEePsNJ08pYv85+cTMa0dzwz88bgWSNlM8I92GnwIUo5ZGfOzRK51
         FV+08MoRrQMV17bhOy9NR9yeniFzNp63LdQgx00jWO39CoLDOgBhQlATDcQnkgt+Wh
         YiYYld2IrwSIt4ilwRS3frohJQXyDYVueB/2xYA5ll6MkhlWypAHnbd5L0WzZ8kt4G
         9FAeSOe3nAULQ==
Date:   Tue, 14 Mar 2023 11:19:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Alexandr Sapozhnikov <alsp705@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: linux-next: manual merge of the drm-misc tree with Linus' tree
Message-ID: <20230314111911.62a3e636@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tDg50K40RUE_6_OJTRl_W8o";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tDg50K40RUE_6_OJTRl_W8o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/gpu/drm/tiny/cirrus.c

between commit:

  7245e629dcaa ("drm/cirrus: NULL-check pipe->plane.state->fb in cirrus_pip=
e_update()")

from Linus' tree and commits:

  d99c028941b3 ("drm/cirrus: Convert to regular atomic helpers")
  03e7ac67e743 ("drm/cirrus: Enable damage clipping on primary plane")

from the drm-misc tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/tDg50K40RUE_6_OJTRl_W8o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQPvX8ACgkQAVBC80lX
0GwdJQgAkZ3A5Z1Zy4b6++ltoWXQsioiTemCgR9WcX3GuPntiblvL8xPt0vB6OVj
ba2LPj/xgxI7pGyDks1TvfCVOfsYVuhUo3QEycs/cX3EfV7xvaDoL60K3Gkean3S
FxGRCMPAaFTLOG9URh1drgzaQf6JRxfy+w3IJyyN6uanslhBm1NnmaOodUqNDtTT
zFR/JHPDF1ftGvXYbGXmSHFiN78yKNKskyRnlAKzu3SP8QYD10fHDSv/OF2Po1ZF
1DXLuHEwTlHV3kAOkOcIlFv78yhJ78V3XzlKZPOfdhtQcjnzKdt1SkjaUg6icF4m
zFcdSVE+3hL1z9oS/Vl7VaWtKEbdPA==
=lQRK
-----END PGP SIGNATURE-----

--Sig_/tDg50K40RUE_6_OJTRl_W8o--
