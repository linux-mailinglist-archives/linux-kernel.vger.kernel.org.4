Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616A566D53A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 05:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbjAQECZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 23:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbjAQECV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 23:02:21 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E8D2413D;
        Mon, 16 Jan 2023 20:02:20 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NwwFd1wkYz4xG5;
        Tue, 17 Jan 2023 15:02:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673928138;
        bh=2qpPai3BgTFTEZX1KZ0Zi6XZsGeUp/ttq0RbwfUGf3M=;
        h=Date:From:To:Cc:Subject:From;
        b=kYjpzomioue+iEV3NtalCMmH/3FnOSdNAsrVYrYwHuMC0jnk7bwQhlswVInyEx+mm
         YIcJ/TJ84C6EPtvSnUNVQl4izfXSZsPHpktVxisi31TA8nJamWK1BXAUref1g12lDo
         62J5bXijW2X3pr33PSE5WxZbJtPpQvuW07nDlKS5Z/hE/XoBSmlDC/2K+Znes23d0K
         eS7EME18sPiKCJSjwk1TcumvVFHYhmBiysuP05EGKDwQAPDI+D7HPkRuF3rL6y23gn
         O6x7bSu5ez1iYs13UnUwvB1tgnWJJ+JrIZVSqacEzYZE+0WxbUhcjgqXWjtuMQJUGJ
         BNkTEjhnmQBMg==
Date:   Tue, 17 Jan 2023 15:02:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Karol Herbst <kherbst@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the kspp tree
Message-ID: <20230117150212.3d8ee843@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lMsSSd.Bnty+VoZEgKzKb3T";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lMsSSd.Bnty+VoZEgKzKb3T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the drm-misc tree as a different commit
(but the same patch):

  06b19f46455c ("drm/nouveau/fb/ga102: Replace zero-length array of trailin=
g structs with flex-array")

This is commit

  54d47689c6e3 ("drm/nouveau/fb/ga102: Replace zero-length array of trailin=
g structs with flex-array")

in the drm-misc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/lMsSSd.Bnty+VoZEgKzKb3T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPGHcQACgkQAVBC80lX
0GxjOQf9GO7ydxY4+ty1jB0BbyM2nHdEYNJViyXF2DraiqxraNEJ8Dqo2P5joFN5
SUUEVbHKX6aXhs6EcsZ+nPwangDzZ3/XwmeYzGZUrtbP8qEQyqBlvCoEaNxLUoRY
qt5eg48H2lr0CEPQxg1ZKDwSWVyLNhuXoJwydc7GVdoI5juQtRS0u+LxzbZ9VJ/4
DfzVe0ddRH991YNnpeq/HgIFa3blY8uDNRq4ApbFfCsqDU777xvEp4LBuICDBG/N
dh8Wm55SDjQWyBt/5t4kgivGniMxgLoFcEfgOmbtnX6ssy+PUCSeKgH2UWc4h17p
AuJexnI/tmUpqv/BzjovV1WObOUxLw==
=Wu9q
-----END PGP SIGNATURE-----

--Sig_/lMsSSd.Bnty+VoZEgKzKb3T--
