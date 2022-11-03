Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A9D61763B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiKCFiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKCFiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:38:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA562DE4;
        Wed,  2 Nov 2022 22:37:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N2swk2fs3z4xP9;
        Thu,  3 Nov 2022 16:37:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667453878;
        bh=FNYmxgIkNSWN5NQQMV3yQPmQJmWGtWG9QK3nm8/y/RU=;
        h=Date:From:To:Cc:Subject:From;
        b=TfPjM+0RlKXndU8ODniDEBb+6WJ4DQvhW1vQVAh0NsKUzS6UvgbN2cYonP7Ys9YDd
         2X3URh1kroXHKnXlk9PKn3uhHmo7O8QWQUFlHJDw7w6O81KGhjnSHCNThiX2/mSAFy
         j3T6JfuPAppuuWaHRUMBhBWqwwsPeRoNK3exHTo/zmrVUK+gQN8hjsNHhxJLvO/Nyf
         RHpolSdVTRyxCP2ctLuvyeSWUgod2LxdIQrrnBYUC5/y8G6h7gZPx7x8mGKikDLlOc
         tB1DfKhPtnGyZbzlgOGAM19MvCBmhTWGQy//Lcc7IOS9tb3SQgqPvzFMKdL8sxZ/oJ
         6XIC6AxcQw01w==
Date:   Thu, 3 Nov 2022 16:37:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the aspeed tree
Message-ID: <20221103163757.1b6219a9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e7IVy5M_L9LZoUIrD0mX70n";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e7IVy5M_L9LZoUIrD0mX70n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  e5bf0d36698a ("soc: nuvoton: Add SoC info driver for WPCM450")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/e7IVy5M_L9LZoUIrD0mX70n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNjU7UACgkQAVBC80lX
0GwBeggAjzH6RQZT3k0nBNHCU70T3BU/lN4mvt6cRIt/FHGUHARTeSbGfu5MiyJj
qDjI9SAGbJAIQoPpIkq4HrAUlNgYX3fFhmDWzQvRNNOXKupYVcBXBe0IAJ8zTVnh
DPHU69lXf1bgAih2qo5hXa2PtwyRvqVL6i1xoPNA+7uZNTuW2FHRyRCYpc9n/9s9
muxlVFRFSYZ2B2fJVxXEsyZNK7S9ENUzDXMIsxcxSVms/qUpGny1oZ8eR5PeCb3h
3fYpxeSklHUsSh3eF9jxDhnK0j+zOHWudnVTwkFFbSRa4aNNPYX2s1iHbN4letYw
tcCA1JShoE4hHyL+F+OVH7iaaBSNpw==
=7e63
-----END PGP SIGNATURE-----

--Sig_/e7IVy5M_L9LZoUIrD0mX70n--
