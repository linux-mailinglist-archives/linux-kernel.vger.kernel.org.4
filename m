Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB60677289
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 22:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjAVVGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 16:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjAVVGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 16:06:41 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BCB1F5EC;
        Sun, 22 Jan 2023 13:06:40 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P0QlH2l2hz4xyY;
        Mon, 23 Jan 2023 08:06:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674421597;
        bh=B7Zeq6Me9MxVHnA1Aqf/fs0uZqZlqdTaA1IhVPM79E8=;
        h=Date:From:To:Cc:Subject:From;
        b=p7HOUPFPzR2Ye48SR4s4XjO0r9EfUVvps0mHCH8ht51QavLHqcmVGqJxLV5YTu0xq
         fGGqplQZQoXoGBbsRo3wOJy1pZ/HlbzO3CNovxUsZZP2YPa63EdYXBQKrThFFXOQeX
         ZyA/cCmWpD1aJ0kTfVg77FgVq1wegKK2R/Mm6rf/RldZWXurw6rYlwerMAznCfFax+
         /NUDmio//shPOSW+C4UH8l/kmRLAKzAhfCh6+0Pg6cPkTaeTo5pvMbokWR9nRm1POD
         80R23FFt1RFMkUQuZGwd6dnSCbtsxU7uWtuClALRKe/wh/b1EWpjm2Z9aqv2Ou8EEb
         dJjrOWhC3YzAQ==
Date:   Mon, 23 Jan 2023 08:06:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the drm-intel tree
Message-ID: <20230123080633.2279dd52@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VPE/3vaDF41VYhjI7dlMAx4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VPE/3vaDF41VYhjI7dlMAx4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  0fe76b198d48 ("drm/i915/display: Check source height is > 0")

--=20
Cheers,
Stephen Rothwell

--Sig_/VPE/3vaDF41VYhjI7dlMAx4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPNpVoACgkQAVBC80lX
0GwMVwf/Y3bMOlR3dore7xhMZF5XdqlaH2lPaOIU3Bny8VXETBAExqcNhNt7gpDn
oTwIscw4ES7JKhDKgp9xIL/Rae9nlu83vac53ati41UHepCUKX30BE0ms3gtCpyi
tKCbr7P/I0QtNPNI10xLrxLtJtXsWXP/ovsuZvl3dloplWQCoBk3vpKKYtKyqi9z
KMOfVrHe6K5mA6RoiAqastw1moTBRLbZFA72K/gfGSknI7NtNtEeur2Y7f5018Yt
pMpDuhmqv3+KEIU9u5qwe949mTNqGltZ1viVCE2XgzxoNbZr7zpTYaCNyqOnYN9s
kcwWu2MJxn3ZeQSY6597wNo2ZPjSJQ==
=TIJ9
-----END PGP SIGNATURE-----

--Sig_/VPE/3vaDF41VYhjI7dlMAx4--
