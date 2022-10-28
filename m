Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B175610950
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 06:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJ1EdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 00:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJ1EdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 00:33:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC2B18F0C0;
        Thu, 27 Oct 2022 21:33:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mz8mY0zBzz4x1F;
        Fri, 28 Oct 2022 15:33:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666931581;
        bh=duF9702P4Kzom/HhPkLEeI2cVM0U+aqzbpwIwr/XX40=;
        h=Date:From:To:Cc:Subject:From;
        b=VuY8h+68qj0/m4O30RDrGAetEWP38A3IHW1ms6rbXDGgr3NCFbjDGgeBFCBIxL2fq
         kG67BngT/uL9ttzTFs0KPakVw88MLaGBd00vwYkZPQVIvum/gxGHRUNpft+ftb7d98
         OTp6jmnYLGcnwlcSuVSE8Jc0mQR13ZeK70nl4Vvl85VjufUnyOSXd7yH3gqugtzEwx
         BPL1P5RY8fb8WJ7HqRZlDER/uDOVLkqWdo7KlwnRnq1ARk5tFppxGyHwoX9nsXHFnC
         h1gvfi2jHrxQR5hpeT6ag5e+6UwuZnAlZyiL4vRmdDaArhLgs3aXocp6ye/YGrD7kL
         w6owZP3R4ZAhg==
Date:   Fri, 28 Oct 2022 15:32:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the f2fs tree
Message-ID: <20221028153259.5d3bb474@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2aS0AS0eijcoAUMeE3veGAi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2aS0AS0eijcoAUMeE3veGAi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4662849550f1 ("f2fs: fix the assign logic of iocb")

Fixes tag

  Fixes: 18ae8d12991b ("f2fs: show more DIO information in tracepoint")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: bd984c03097b ("f2fs: show more DIO information in tracepoint")

--=20
Cheers,
Stephen Rothwell

--Sig_/2aS0AS0eijcoAUMeE3veGAi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNbW3wACgkQAVBC80lX
0GyYjAgAl+9VEIHAvlrKoxMNcuAWQGeMEdQknibNjTFR3QESW+8klrPR4cAVuBDK
6HWz7sdSWV4GxRSwymzfpxLsA2eFAJgX4JxIdzS0VzSDJPGteqK5mzBmFT5D2Ax7
La/LGZKcxc4XTC8tSSOw6YRMF1Xv3FN1yX7TcsTI9v8WAfSRNJhlsU7fwGeiZA1A
gdbtvqyFH/m8yS41SiB9G/U7mlQ+p84FRgYAHfXr2iNVb6qA6bExvi34/7u3zTEP
hUpCy9Xe+XuSypYZ1/c4IYyAfvgtS/gIgePc4sDsmY+H8cDTf8T5mVl7Ov1+Ns2p
uTBd7UYpc+mAE9M88X8MuH6pWpnmsg==
=SOdI
-----END PGP SIGNATURE-----

--Sig_/2aS0AS0eijcoAUMeE3veGAi--
