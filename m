Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA0A734B21
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjFSEhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjFSEhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:37:42 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C871B8;
        Sun, 18 Jun 2023 21:37:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qkxnt2KpFz4wgk;
        Mon, 19 Jun 2023 14:37:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687149458;
        bh=UzrM61r1IFXKbh6idYiejEehjWPMOYqsE7XhnelVeWQ=;
        h=Date:From:To:Cc:Subject:From;
        b=rTHSCykkFPs3IXpjizdmFafwnNJPOZbM7aWgQzELqpPDYJwlThn7ounDXIrc8UgiP
         7WVJgX1Msg+af1INXbtsoxLl0vc23kGosCXEOqRL+yoHgy9eQloTem3f7wHTtqBfTm
         4Ekjss3VW/IZovD14td6psEDG+GsLNrKB1URi8R1E+vBvTuqqczw4i0tC2OhtgNSYg
         5CzH917t4pb0rEDxfC8a4wew64RdLZJQZI0XK7zV8a6yBYbK/eqUXKrVqz4cbbCAmU
         FDDuOrra5UAVkP+D0Pahm5z4N/hn2wPc3O37MZ8C954+sXGy0NnerwkCM451rOyGJr
         ny0ZluOu52AWQ==
Date:   Mon, 19 Jun 2023 14:37:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Will Deacon <will@kernel.org>
Cc:     Junhao He <hejunhao3@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the arm-perf tree
Message-ID: <20230619143736.39949f20@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/F94b7tYnE3==f1hczlOnuU3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/F94b7tYnE3==f1hczlOnuU3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm-perf tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/admin-guide/perf/hisi-pmu.rst:107: ERROR: Unexpected indentat=
ion.

Introduced by commit

  ea8d1c062a0e ("docs: perf: Add new description for HiSilicon UC PMU")

--=20
Cheers,
Stephen Rothwell

--Sig_/F94b7tYnE3==f1hczlOnuU3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSP25AACgkQAVBC80lX
0GyFWgf9H3lJ9rRu2Rtyk5DKKRbBFBHpPmZxd1QWrViKcU8BpIFVjM2V/zlIyNyu
7PAaf0EHfPn6Vx5bIDlRSqxGhRwP2XoLhTSpdN9oTqJj0Y4QYCcfJZGW8/l8yFue
6ha7dvf8ovAYMuLmN38A4YktsPtPEms0a9K4iJSM/JutcFgwkwvnVAfhomNxvSd2
uL0Y++J66z6R0tRUDzHcGzrz1hgoYrgKEkZkEvRDS5mR50Vb6Kcox+gr2bOXWpbD
cBfoXDEpIgvvbTvG6FjMB4nF53qtrI2cDrDa5C8p0KfxknUEnXqg550Hk1PDgL7j
1YgPLo7fjHgMV3l+WtwxWhCybSJBZQ==
=F4J7
-----END PGP SIGNATURE-----

--Sig_/F94b7tYnE3==f1hczlOnuU3--
