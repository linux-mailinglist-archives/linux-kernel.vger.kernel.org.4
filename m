Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7671C641FAE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 21:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiLDU5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 15:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiLDU5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 15:57:21 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D111260A;
        Sun,  4 Dec 2022 12:57:20 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NQJsC0NM7z4x1V;
        Mon,  5 Dec 2022 07:57:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670187439;
        bh=AyGdNLt9dbyb/llGLbnJtnevYsFFHBC9Kxp+Hm8SVOc=;
        h=Date:From:To:Cc:Subject:From;
        b=jQ+vsv+wffmWtxMEVy2SLXcGMfHqp78TMKucUEcFuLzoM5ZKBnm3/RxZ8iW1N2MRK
         iHEDtIgjyZBDY+XHiwHBRoIA+EiZLjlQ36L6Z5wHD2kVrh/MuR6ANEgfLkP7uVAQbW
         5BH/o1GlzlDMWPMDrlp5UlYZXM8rhz5tZbHKHxSAc/Tzpw85+2Y2vwo+1lCogFvhxX
         bPpXRNnZztRn5qiMVjzttI0mDPbMZhR5VqG0+BdqSS11Dz4s85JNu4PCZ69ZBlqacI
         qtQH/lb0CpSA+3vvuzaC6vRZ6/FioZ1JqtoS+Cx4bd8gDLcTDRm9G+Pc30WFoY1D1I
         iYEky6138vi6A==
Date:   Mon, 5 Dec 2022 07:57:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the devfreq tree
Message-ID: <20221205075717.7c2130ac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xAmpPBdfrtIXnvL918K0P1b";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xAmpPBdfrtIXnvL918K0P1b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  26e9e8e68f5e ("PM / devfreq: event: Use device_match_of_node()")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/xAmpPBdfrtIXnvL918K0P1b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmONCa0ACgkQAVBC80lX
0GyPMgf/YAQNLhICZX9TRhZPlhQy90NY+ehg3WswP0Ne0jwkk9CyVblnmeaGeXur
WwL8gRYkX2B80WQ6BbrUM5/2c8xiINsXY4PEcDNPJmMfts2e6JSllMJ35lm/XWm3
WnCE0A3z4wxDKQCtTGJLP5pd3Ak1WFB/lBKUeXy3mOB8FfhntE65FoQ6AgVN7Ed0
Zkaga55XflXhxdNbJLvqxR/iJIFWx4lEvGzF7nXCRdVCqmChFxzzs8m9rG+fiJ84
JIhjuoqAJQMWKoePpiV6CD5Z2BWwiX0DsxDPirJXSZGaJDAPMjLQaev8wTOvx+qP
32+jP1KZaaQdaa6oqORt6pGStymzGQ==
=yGji
-----END PGP SIGNATURE-----

--Sig_/xAmpPBdfrtIXnvL918K0P1b--
