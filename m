Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98267644D96
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiLFU5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLFU5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:57:02 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD162AC40;
        Tue,  6 Dec 2022 12:57:01 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NRXlt6CNqz4wgr;
        Wed,  7 Dec 2022 07:56:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670360220;
        bh=JxRjRky6kxw/hiyZLYuAnw0ZAsHp+uk7eckprPLT7mM=;
        h=Date:From:To:Cc:Subject:From;
        b=UrTfeVXV7AF8ctJrjci3pMQOvyezYJ5meOxtSqKOc+VMqumnoFxBjRGYgJN+KZJR/
         BZk4ze1O9x9VcdOHhUnyP/V4wZ8EpI+CFu3PunPrndXuki/JrW6IPyDbf4HnLjhSxI
         ELdjqJATYucIGewHZH0vQKNX44uFFpda2VRcKVQKEhwfCvQ7DrlzHr8ZZNPVYSOwjd
         umhi6IFgssZg43z7D2HztfFqSk4Z1h22GULsPIZocLltWeecwakYUFWdePqZzXSksk
         yKcCVjAvbuHagRs/fJNH07afP6sfDlWFSgS8vEd3B7SM7sHLOvEqYZMFqKr2KLOwpF
         3MrGpPOA1iVcg==
Date:   Wed, 7 Dec 2022 07:56:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb-next
 tree
Message-ID: <20221207075657.39b5552c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_qqfRlezoHCKYh9Tnay.tix";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_qqfRlezoHCKYh9Tnay.tix
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  85abf40b56af ("media: ipu3-cio2: make the bridge depend on i2c")
  ca61babacbe8 ("media: MAINTAINERS: Add Hans de Goede as staging/atomisp m=
aintainer")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/_qqfRlezoHCKYh9Tnay.tix
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOPrJoACgkQAVBC80lX
0GyIuAf+MyQ+x5WLboKPdQ5Mg1348Lutv0kY+WDmVOD1gZbZFs21o7SxKRZ2zKXA
pZVoVapxC/Rfzx2/c94/PoKKhkYI/CM+6qRM9zHJ4YFduzxWAMHBPaWUTQbc2HOL
aWFPQB5chcU+ugCeTYbCRU/2EztKXORjY92h5a1GSwq+TAnJhQOcQcLwrzaT1+HR
6qIhB4kxJG8tocjsfIG0I+Xy7iKAZckCej9DmHvgMxcMSag5qUIjmNbEe1I17/c3
ijsQw6fDmWb4dt418eRbhYLnRDHrLNLaec23XetLykSfPOOXBBfieoGgPU3vFT8v
VYSXwpIdSkEFwohzZg2dgRKbrCF/sA==
=MXxZ
-----END PGP SIGNATURE-----

--Sig_/_qqfRlezoHCKYh9Tnay.tix--
