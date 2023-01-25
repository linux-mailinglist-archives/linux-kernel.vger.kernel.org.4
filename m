Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CED667A99A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 05:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjAYEWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 23:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjAYEW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 23:22:26 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0F65355E;
        Tue, 24 Jan 2023 20:22:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P1rK166bzz4xwp;
        Wed, 25 Jan 2023 15:22:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674620534;
        bh=DPH5lJV96Brvn1wOWQhDreSd7R+VLZ677jTSVSzWHOA=;
        h=Date:From:To:Cc:Subject:From;
        b=nGv3ijhHGl/1vcaD7zBG806tMsE07mMpoxro2OAJifIYilCKJZv7CkoGYU0gVZ/OY
         4cTmrMweIYHm5+sjAUYSsqorOyWiJu19cqDZV5wYTBFAmgg4p9bNaaKVM01alfx2g3
         6Ro2rtTMKeDEwwMBKozDcmFFo7VtoShh/7YxNTrgnLmnqpIYmKZzmtZ+Il+AbKpe5+
         wybkTCiFihgk9q7d/5aWbTJzCwj+x7PivOkWVukOZlNVZAzbQ7zbguH/5TgJmZ+6uO
         K1RTFMIVtTSYbaZwyFyy6srOrCoTV/09HjYwor6yjkZM0/9sWuS+I6+hFGL6NJBZ76
         lwX/A9M2ktYEg==
Date:   Wed, 25 Jan 2023 15:22:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Martin Wilck <mwilck@suse.com>, Petr Pavlu <petr.pavlu@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the modules tree
Message-ID: <20230125152212.51164f0e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=hvSuc2NA_ZSx5tbd.v8Q=r";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=hvSuc2NA_ZSx5tbd.v8Q=r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  7ea5b24deb65 ("module: Don't wait for GOING modules")

This is commit

  0254127ab977 ("module: Don't wait for GOING modules")

In Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/=hvSuc2NA_ZSx5tbd.v8Q=r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPQrnQACgkQAVBC80lX
0GyRvgf/f1BWZ8Sv3PWEXakuWdXL7Cg3KwORcnvNodFoWzITPvTDsUiyv7Fi8DlW
XgsFHfsUkdoZSAIjfMU2FezqBWgZ1WfszdC02WLvgLQy4JQcOv95YSHYMz3qrApo
9XzYjTG07lj794CBriMlHr7XweX5ETHMfDvXu9n5+R38RDjN4nfMjWbE6nRZBBE8
LzLMinV0iUek0o932GBow5xBUx+Pp3CZPXXc81n63Wk8OIK9HEix91TZtlxgSiCM
FsWlGjg2KO1aOL7+L6nG6Ina0mw2qdtUuUi3tgGxg2gBc9YimwSXReeUM1yliKZD
sRKU4kIiMQ7zsvCA+uhoxCJo5PYIhg==
=2YB5
-----END PGP SIGNATURE-----

--Sig_/=hvSuc2NA_ZSx5tbd.v8Q=r--
