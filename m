Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A8765DF1D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbjADViC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjADViA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:38:00 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3661C130;
        Wed,  4 Jan 2023 13:37:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnNHp1Bbtz4xyY;
        Thu,  5 Jan 2023 08:37:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672868278;
        bh=C0JXtlD5/fPVtB3SLUEcSMT8FPurnJz6/P9y9AZtMos=;
        h=Date:From:To:Cc:Subject:From;
        b=Ro41s/jBU6k+p6n73qa2rJV047u8eM7RxAN4J3RLlVOd2BPs7aMtGMjj5wa01tNd1
         py+FbMOdlPQ1SyPUAo99Z7FG28FH5T/KNYqETgYFHdvSZ3yx13B+Ux9/RkiGgTlfFa
         0GNTs83kIUs3MJuKBhHnTg4X7y7gFcGkiIF9W86cjtl/UC/RhbCjUHqG6dk8A8O5xs
         NRM4tZq/BiGxogwqbufqBxLCG38CxHl9E5YLRInt16NwIQe5zK3aUAHnTC3MENLysp
         +YOjzw9YdI5iEZvDDQsoWxpCCzGs91RxPpWvsCY9W5aIRKb1oOg85Z3Oinemgjqrsn
         v4u9KbFdjGGNw==
Date:   Thu, 5 Jan 2023 08:37:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the stm32 tree
Message-ID: <20230105083757.0eddcd51@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/H17erjzSWIqXgY8UXvbs4V3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H17erjzSWIqXgY8UXvbs4V3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits already exist in Linus Torvald's tree as different
commits (but the same patches):

  7ad436adc788 ("ARM: multi_v7_defconfig: enable Type-C UCSI and STM32G0 as=
 modules")
  f6309efcf037 ("ARM: dts: stm32: add mcp23017 pinctrl entry for stm32mp13")
  c07696f72ebb ("ARM: dts: stm32: add mcp23017 IO expander on I2C1 on stm32=
mp135f-dk")
  4cca342b840e ("ARM: dts: stm32: Rename mdio0 to mdio on DHCOR Testbench b=
oard")

--=20
Cheers,
Stephen Rothwell

--Sig_/H17erjzSWIqXgY8UXvbs4V3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO18bUACgkQAVBC80lX
0GyWIQf/c12L7FBcJIasyn8HZO8Ye9lHy0fOcqKSwH9lgRZc60jy4ACrSp5JPkpI
pbGYKNUfq/UvA0R5PWX6djdm6OSozWyVdl8SifKWcsbXJHNJoZ27Pw99fjEcN9IO
YAL2pD4GWIqaw8uLJxWbED0um0ImCqXC7rYZh8ZPiVOwhZ250pBa7R7sMn91zelY
qr2y5Ryqo+xFglcc/x2FPnuddq9vimmgi82WQmFeRiIlTYySfYDWsQJ83ybtsC/o
f3Mk2U+d25EMTkmyCCASm/eLs8OdZ9F/VoGis9pyAPIXLNshXmWOZzVfaE58Vjtg
DuvUEsdEot5VF4EGKcN9tf422pT6wQ==
=2RWQ
-----END PGP SIGNATURE-----

--Sig_/H17erjzSWIqXgY8UXvbs4V3--
