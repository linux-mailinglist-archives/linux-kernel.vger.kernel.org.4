Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A137698B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 04:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjBPDkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 22:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBPDki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 22:40:38 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A542885E;
        Wed, 15 Feb 2023 19:40:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PHLLm1DY2z4x5R;
        Thu, 16 Feb 2023 14:40:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676518832;
        bh=IhhtNy3W6goacXun/EPhiJafiIJA87yrMDChswJsA90=;
        h=Date:From:To:Cc:Subject:From;
        b=TukCD6eB0yr67J/ISyBFD4uzlbdNHnDHK+OwVPsOPMgHa6kjH1makxS4VeLGNjNqo
         sqQwZcBreZfl5gqXuVKqCNKhuVEqjXcFVkrPrN2D0AZksI/hH4f4CbMCXG8bFS4aVP
         tPejZIl1xmvaW15KOFUiZ++bCqu1Gnxr9Hrb9g7A3R/3gDuRJMORZUfOS9y0zADGPG
         GMYxnTVB5te/tmUDysECrJpQ6i2eqQl01IL8EfEcBriMhLVqlvq7mpoXDsDIXCvlZc
         agVIMRme8hdpN186gT//b8ysxJOHHY8//Dc/IWKASPaNi/OMPq6lfxTbHB1vQewR7V
         AJ/jl+nxmdtow==
Date:   Thu, 16 Feb 2023 14:40:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the powerpc tree
Message-ID: <20230216144031.45b1fc12@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dglXHvi7hVb4e17fbyF=Xyc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dglXHvi7hVb4e17fbyF=Xyc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the powerpc tree, today's linux-next build (powerpc
pseries_le_defconfig) produced this warning:

arch/powerpc/kernel/head_64.o: warning: objtool: .text+0x6128: unannotated =
intra-function call

I have no idea what caused this.

--=20
Cheers,
Stephen Rothwell

--Sig_/dglXHvi7hVb4e17fbyF=Xyc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPtpa8ACgkQAVBC80lX
0GyOCAf/XT5HWVB0yvKvhPl6Utb11p2X3m1l7VIfHcuzgHN+Z/xTBb2rrVxumHd7
iX6kl5zHsMfENpxd4UFnvNs8zZwFOQSVs70FcXCN7R4cEAmggxuAzsAZezYC+kIu
zmmev8elNVcUwN4dxm7gNT4dhXgJKqhJ2BRSF2c9C3Ws4WhKYj4sJh+njnErk5XZ
oQuBOjHzJdaZ7Qy03QyKgLPpKO/ceWRUi43ZZUJx13MBGmwCBOJBRhh+1Aar55v5
2Mt/qdGd6L0ESMSOwyjQrBlCnOX9w9PNB3K7D9Fmw1Cjkadt3v2X2au5h5pwrNuZ
GXgASLbb2L/dEn6q9FuPEw5953tRIg==
=S3YE
-----END PGP SIGNATURE-----

--Sig_/dglXHvi7hVb4e17fbyF=Xyc--
