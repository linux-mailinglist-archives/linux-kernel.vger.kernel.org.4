Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262D3641FA0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 21:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiLDUuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 15:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiLDUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 15:50:06 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB25112609;
        Sun,  4 Dec 2022 12:50:04 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NQJhk3YZjz4x1T;
        Mon,  5 Dec 2022 07:49:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670186998;
        bh=j9MTDZJBbY18ElkNRi1i0GRjz0VQSbbHh7XFvKbnyk4=;
        h=Date:From:To:Cc:Subject:From;
        b=cLh6TLO6nnD4rlOlsLvBNkNrMVziUTKYcw3+nZHJgWhlpSMI4koBf6L6jkQWKUa53
         vXqm1woda+0JH0ZAqrzy1WIDpFb92w++d8jXwLdNRv0tBI9rMSpLzXlAZz5kDspiMt
         HUdMeKO5qMuN8gqu3Qf1y7FIOyIqkDQ/z4A9I3ojk+H2MS4zGjDHq5Fk7I5za3KYUg
         yALcSHkNhMHcQq4WRlPVEjPCciEoamuDrx8Sog00r6Et/Fr5NHXExcYmSLnaPIiIZR
         43pu3z8LWLlrz/Ouz55M7yKOX7Xlw/avk4hyHRbSqnV3uDgsagI+kOYMWtIsVAb08y
         MwaunvY72GqJQ==
Date:   Mon, 5 Dec 2022 07:49:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-bys missing for commit in the mm-hotfixes
 tree
Message-ID: <20221205074938.3191e5d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZY4_Ltf8KWn+QpnwvUP1QjC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZY4_Ltf8KWn+QpnwvUP1QjC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  3649d3bcf64d ("kselftests: cgroup: update kmem test precision tolerance")

is missing Signed-off-bys from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZY4_Ltf8KWn+QpnwvUP1QjC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmONB+IACgkQAVBC80lX
0GzS6wf9FQhAGDJQKpEXKhPN9vY1TcjA7mSw1cwftz3JoesIJvGOMjDtr9XPn06q
JADxrJmABKIBt1gyQRxPxmo6miF6uHZn0ERJFhdEHPawq/WK4pRisIvsOqGo3jms
kXW4ayJZaLgwSA1AhpZB5X8/YoPpwVcGfMtuSbXJvebJLK7DAViktGsyEchrDhCZ
IWuKf3m+bYH0C/baFZ/lA5l7ddt44FZCIPk9KNUllr5C5nSGuvVqQULrR7vtZz6g
OG2Ixkjk/OEDu3/Cwf+KU8mHfNvyUTQZSfrdjIhe9U3J8ES8+8+WQ+yTDFKy5vG2
k2L27J8uaMTilYcl4tfA/4XYnKbc/Q==
=QXuq
-----END PGP SIGNATURE-----

--Sig_/ZY4_Ltf8KWn+QpnwvUP1QjC--
