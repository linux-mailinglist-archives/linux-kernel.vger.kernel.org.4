Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EF26033E4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJRU03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJRU02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:26:28 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA7C7F13F;
        Tue, 18 Oct 2022 13:26:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MsQPC6301z4xFs;
        Wed, 19 Oct 2022 07:26:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666124783;
        bh=FK5Q8VNWE3orkYGwsDEN4kgJdYgLRepfQDzI6MbhflM=;
        h=Date:From:To:Cc:Subject:From;
        b=UMu9epSKdp4ul5CDz47iujs0WcFyx7UMbtSxs0YHB/VeKnt2Q55OXZcvDmJFbRr/Y
         Orob8tsO7t38B1D40fsTn1Zd5SKyP8PV6bIsiRgUAMqGPQC9a4ExPawmRTlilyAFar
         8m3na7ut6FFvUht2BvwUYJ6j/cvNfT7E7DoIH2E2F3L8Src4eENdkmR285xug01iDH
         0L6JW9MN+mzRy1KxUQOJDmwWzqjUeLI/zsgfC1rJpwIQ1fqbI5mTKIs3JZjCO1rgQR
         XdxnFFeKh7lz3Xn8KP2fkdtQQYCmZ8cBJQ4QaD8EtYbpu/jCGsvqalZAf3dTMLV9er
         8l29FZZzWDHrA==
Date:   Wed, 19 Oct 2022 07:26:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the libata tree
Message-ID: <20221019072605.7d6c8cbd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LSE2hyvAV4fwD0xDQ8/qA=h";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LSE2hyvAV4fwD0xDQ8/qA=h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  61503af327ca ("scsi: libsas: make use of ata_port_is_frozen() helper")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/LSE2hyvAV4fwD0xDQ8/qA=h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNPC90ACgkQAVBC80lX
0GzVDQf+PloIr9d/a9zIMOyG48MSw5fdJEAq+A9YyS51n4LGZIzDe0PGZYSoWk5g
0o4byiiXnM5a7bJInnRTR7g9glXXp4/zNUIz+8ml6DdmNm7nPx8ieJfgZ9fe0uH4
ex/olfNBTTRezwmUMONeaRJWa80CdNZCfQ3RPXoGa/vAXkdkMXyNXDIpwDL2Lrtz
M9YQ9AdtqnXg8CHteVBxZTEYjxwpV5i1RllRUMWwWCsyLSxt+BZnMgUnDBN+sE4x
5qmL9tY90SLRKBwuExFYSx/m8tA36pVXpDlKjd8chMziYK31d/1a57nK5+SqmisF
Rzi+15Sn03uDWx8Y0DWgi0O2wSpF5w==
=Rqfx
-----END PGP SIGNATURE-----

--Sig_/LSE2hyvAV4fwD0xDQ8/qA=h--
