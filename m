Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4374A6821D1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjAaCDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjAaCDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:03:41 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A1A5BAD;
        Mon, 30 Jan 2023 18:03:39 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P5SyC5PCSz4xwq;
        Tue, 31 Jan 2023 13:03:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675130613;
        bh=wMaAeKI0zF7GwzSps0H7CB6N6KHHwOabGNIZQ95HWBg=;
        h=Date:From:To:Cc:Subject:From;
        b=BVKQ98PvgZqHBLO2kR3gbz02EFoXyRvgJn7RDLChli+kDiMtRPGgobJWGfKsFhTc+
         tnVDdnFuw6ENs0lKFT6rghKG60ufhvd2OKPyysZvQvLus5kDvxX2/MtY21iGB3DC5a
         +RwKyJMApMj6umiLScqmyMqitWFnVfKMV/Mr+V7F8ZUva7d5h7tYt1u1F0lx/lzvY2
         Bt78VMJd4pxHH0oeYkRcAj0TeibDVxcIdDVI8oZrGVJJasodXGHC0pp7S3zxRi1LoZ
         kHRaD8F1fLb9PL8Ddvci328VeguR2xfRw7mw1Gx/JtMmkFhdfAiYjzMoCUf8DIRBfa
         X77dipw83qBYg==
Date:   Tue, 31 Jan 2023 13:03:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Harrison <John.C.Harrison@Intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the usb tree with the drm-intel-fixes
 tree
Message-ID: <20230131130305.019029ff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dTmyzOU1EnNXR2Sh6q=MHTo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dTmyzOU1EnNXR2Sh6q=MHTo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  drivers/gpu/drm/i915/gt/intel_engine_cs.c

between commit:

  5bc4b43d5c6c ("drm/i915: Fix up locking around dumping requests lists")

from the drm-intel-fixes tree and commit:

  4d70c74659d9 ("i915: Move list_count() to list.h as list_count_nodes() fo=
r broader use")

from the usb tree.

I fixed it up (the former removed the code changed by the latter) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/dTmyzOU1EnNXR2Sh6q=MHTo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPYdtkACgkQAVBC80lX
0GzxOwf9H9KgKNxnEkcMqyn6HV7TCodkrJAi9nEvNMBrRRottaKd5N7bsouPLC/X
f0WfJlwSxldmWxwLCDfsjJwI62sXjaaSIaYDIYt5rXxChJvOD/URZMGK0bcwBCzV
ZGfWW0+zH7Qp8xYImST9wr2tuRn8SGivLr17oXd+Fj9Y24JRsWSPF22/Vpzu883e
LBiKJTJycDze69CBhu6LpAxmCv+H2RtrKdso2XKUFT9O70nCA0qoR525fZidU/P4
HUICvWbzPcBOGjdtmPIWiYssx/OsbFSW6bz/D1vjch5Bz8IKBwdF0HJoWh66cG6y
Vq5TGBAdcw9JnFEgYPqMQbt0bnDrNw==
=uMpd
-----END PGP SIGNATURE-----

--Sig_/dTmyzOU1EnNXR2Sh6q=MHTo--
