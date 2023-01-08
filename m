Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843366612F2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 02:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjAHB66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 20:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHB6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 20:58:55 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DD313D49;
        Sat,  7 Jan 2023 17:58:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NqKxS5Xzhz4xZj;
        Sun,  8 Jan 2023 12:58:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673143133;
        bh=+xs4IsnJmGwDDAxs/tkK8SjyFH4qf8Q5NAmetU2Cthc=;
        h=Date:From:To:Cc:Subject:From;
        b=NwY3ehlt3rZjdtIrTv8IOz3ZphUd9t0nmFMtT2XfTESiInuIFgK6ooQ6cwN98QxWL
         hzv2afqc00NJJkB/s8FC0Y/+Atdh/MUgFn3kajlfRStCrxlkl6qoWG/K4Z8IySVYa8
         bVBfrPwFlLMHAfDGLn2xYJuN/PkCOCPR9wlnODrT6MBy2m4cXO7sPuv/ZSYpl/rutr
         4ir/OqDNIoBz+pRlb98mtW6cbT4fgEpDXx0Db9uv46LWGIGumPCyV/f3HL0kIvHmgf
         AYuK9r3QjxGGP1CpSSX7OhOgkaYrEl1+u1JEqXQlMoiLNGy5W9xErQs37PdR54I/PG
         X/z8DGLKekDow==
Date:   Sun, 8 Jan 2023 12:58:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@redhat.com>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the drm tree
Message-ID: <20230108125851.26687a6f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/myB1/v_beOwHkAy8F8hLWDW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/myB1/v_beOwHkAy8F8hLWDW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  9f1ecfc5dcb4 ("drm/scheduler: Fix lockup in drm_sched_entity_kill()")
  4333472f8d7b ("drm/imx: ipuv3-plane: Fix overlay plane width")

(in fact the first of these is in Linus' tree twice)

--=20
Cheers,
Stephen Rothwell

--Sig_/myB1/v_beOwHkAy8F8hLWDW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO6I1sACgkQAVBC80lX
0GwhvQf/U5OqbPBGPRftiLF9g0PXHBMBTTi/3osLJP1M2y2+SxyDAuiG+3qZbOqX
/LECDhpy73PBXUVQQIh966AZHjWhX7CJEThCn01dOVp6JdulHVtEXxKsGjLPDyPt
Ay+Te9aw1dOjJRVKvT6PpCo9f9sfhS+csWmpFrjFdMM2nHaJWzJOdScSEkMtf2pS
uZplrX841dXp+3O9T+dpNjijqRXE90tkZgC9zXwRls+csXWPGYsQPzJnNW80TsRU
8GNI14inrVwkSzaA5z0GGW4e+lv93F0c1NliEkHFNADMEnRniJQbx8N0aON62pdI
WYIX98cRd9k6YDusO/O6THUU3WyFAw==
=hR3b
-----END PGP SIGNATURE-----

--Sig_/myB1/v_beOwHkAy8F8hLWDW--
