Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEAF730EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 07:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242850AbjFOFYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 01:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjFOFY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:24:28 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FD41715;
        Wed, 14 Jun 2023 22:24:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QhW1j4ps4z4wgk;
        Thu, 15 Jun 2023 15:24:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686806665;
        bh=xWgNh7ywjfCJUNXqLn6T63uUi7spK1joWLkrZdYZaog=;
        h=Date:From:To:Cc:Subject:From;
        b=TW65kNnElVpV6H9WioDFYsAL1oHIlZJaETNFqcsDTYOzzUxI+2B/21tVUGDE4UBsI
         QxiP4KGqdGNBe8UdmkJ3slC4TuxYIW3jqRT06G8I8nzgl8Yzl2aFrPo/dM1nOF28k+
         Dl9V3iwLdeTTdNsQ8ZbsrLSUfU4UN6Xs8MAxX5gwQIyRPsveg5oPqmnHe79mgohiZQ
         EPr2MLwpYjiOE2JjTvxqhffbtGJPtMG8TgmlUkAGhwHi88gYxDkaoI1m7pEguYZgax
         XkrdSqO8UWulat1nytBEHrmti8JIXk0ARFiSzpoWIBmTpH4BEp8NyjrAexxTe3a69A
         bIQ6G5oPex6Vg==
Date:   Thu, 15 Jun 2023 15:24:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the ext4 tree
Message-ID: <20230615152424.0ad5a266@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ko7K1uLx4QzOVZ0the6QCEI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ko7K1uLx4QzOVZ0the6QCEI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  f451fd97dd2b ("ext4: drop the call to ext4_error() from ext4_get_group_in=
fo()")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/ko7K1uLx4QzOVZ0the6QCEI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSKoIgACgkQAVBC80lX
0GwXlAgAgB/MPhyB883USUN3qq41KEC4xCPCJEDxD+wypcO85ZfY402Zlkkby16b
VQGekWanYIkLBT5VwWfeYLv9kCmARzfgEe5uGOPuzG5onv+Qc4sqM0i5C1SgWDjb
m7kxTXKZ8lWHHkXUahhxEQY0T5ebs+PnR0LwsfZpniaTI1F4jdyTbMlKOfQyQ8Nc
R7+JLu0CFMultUXYxXpHbfTv44UMemzHZF3Tsl80edJfng+qxOkFEJGJNkd7ir13
m4A4TRlvSRSlpcQvBBcR5+AVp2c9hR/dUHrnnDYmk3WiPzxkOv6nM167W583DxLK
cE4T9gzRUBv5cek68LoWsMxS45GhKQ==
=OBW/
-----END PGP SIGNATURE-----

--Sig_/ko7K1uLx4QzOVZ0the6QCEI--
