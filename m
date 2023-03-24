Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833EB6C76CA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 06:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCXFC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 01:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXFC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:02:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1599A19F16;
        Thu, 23 Mar 2023 22:02:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PjVSb4gRYz4xDj;
        Fri, 24 Mar 2023 16:02:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679634144;
        bh=PPfs8v6BX3Euce8+Frl/C+tcADBo/J6lT1zaD8YLChc=;
        h=Date:From:To:Cc:Subject:From;
        b=cf5OqFu6jsazGMxwBSE5Su9pYu1F+RNLaXRr1Ughwr2B8kdvtu7t6VoF4cq6NGXRa
         JPiXtmrFukDZ67HBqO7BoihrS4YRlwkbtB6BTKFvS1SN+/WKTnRcfY2eIw63ksM1Y/
         V9Z/qvme8hWLvUdKZJ6bslai2+g0dBl0xv0Jlrs3XC6OBY9PYj8C64Zq80FmR+hClS
         itTv/rnr9yj0tHy/wNGAg4fy0v5xxKwputgohBVZyFATLM03DtiXCzDQszYdbXhqtt
         zdH63Xg9uT48i57JcOZDVklN58x1jKzkIGemG7It5jZP6WbwbS0/LsohqxCDTOsCiZ
         QtICkot0Wp7dA==
Date:   Fri, 24 Mar 2023 16:02:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: error fetching the arm-soc-fixes tree
Message-ID: <20230324160222.000aad9a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7JAzX_LlO/czboev9+s1RDS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7JAzX_LlO/czboev9+s1RDS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Fetching the arm-soc-fixes tree produces the following error:

fatal: couldn't find remote ref refs/heads/arm/fixes

This has been happening for the past few days.

--=20
Cheers,
Stephen Rothwell

--Sig_/7JAzX_LlO/czboev9+s1RDS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQdLt4ACgkQAVBC80lX
0GyiPgf9FR+qJNH+3QECAFAJIX37UEFcJTMnpGBbhNqHdsd2WB4SfI2R3QAa6CV1
Jd9gRN0daEUiSQicSNKBuY+gaIZur1qotYWVhLvQQdb8E9aG+LAg9HHuIHmHDmBj
UVkfMaBIC8IX13pgn6ka21MgcbhWuE7OYkden5IozAiWIL+XXfkSYHf+nXFjAMp+
9hLAVYQzM5XpKSx02MRBE6D53XTP7RliCmpWMrgENXz9mKVf163184hbcmch3orj
sTY6ge5sN0CM8mzpeh37IlzVW5M9gGA0JeexlPFGrDuuJhKEFBJWcK0eUl5hphTA
qPdqm72UrWsyP3vFDfPI90xEBWSGvw==
=kZmm
-----END PGP SIGNATURE-----

--Sig_/7JAzX_LlO/czboev9+s1RDS--
