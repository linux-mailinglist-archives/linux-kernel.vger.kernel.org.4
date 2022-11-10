Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B2B623EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiKJJie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKJJib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:38:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6392612
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:38:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEEA360ADE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AC4C433D6;
        Thu, 10 Nov 2022 09:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668073106;
        bh=AR7Fj20NXrySZvgxQlRDF3rgr/yG548iWXK7mwMhZLk=;
        h=Date:From:To:Cc:Subject:From;
        b=aZdut7A9c6bxixUQRbjs65WSnd64m4vMumtLFeLRYiMrikDv1G1ISiZ3QxzD8pFTu
         aZfZdtnu1B457wwwXmR4eFiVkBt+cN1TplJF3fA+2NL/Dt6bCjv1JsOBEuZvXmEhkE
         NFLeAzp1npgelhka3KqbpvsN7i0fV/MGZTej0dLrdJBZJbChWVI67hh3VotRjSvAxW
         hFofm9DKWQk2GHliAiR/uosYVdjb3nM5sJ3L/PO0K5Ftz2ypxkeubJoPYmPT8IVeFa
         4r6jELDmkJsujASoYs8tbC29WTbPOqtu44S8fLRo98rnncjl+TBR7PfJ003p1UA18a
         2DKQW7+386OPQ==
Date:   Thu, 10 Nov 2022 15:08:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>
Subject: [GIT PULL]: Generic phy fixes for v6.1
Message-ID: <Y2zGjvUEs1402DEw@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mxTQoUQiUzCA1AIn"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mxTQoUQiUzCA1AIn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive the Generic phy subsystem fixes for v6.1. This
contains bunch of odd driver fixes

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes-6.1

for you to fetch changes up to 819b885cd886c193782891c4f51bbcab3de119a4:

  phy: ralink: mt7621-pci: add sentinel to quirks table (2022-11-05 13:01:2=
5 +0530)

----------------------------------------------------------------
phy: fixes for 6.1

- Update Kishon's email
- Fixes in drivers:
  - stms32 error code fix in driver probe
  - tegra: fix for checking valid pointer
  - qcom_qmp: null deref fix
  - sunplus: error check fix
  - ralink: add missing sentinel to table

----------------------------------------------------------------
Dan Carpenter (1):
      phy: stm32: fix an error code in probe

Johan Hovold (1):
      phy: qcom-qmp-combo: fix NULL-deref on runtime resume

John Thomson (1):
      phy: ralink: mt7621-pci: add sentinel to quirks table

Jon Hunter (1):
      phy: tegra: xusb: Fix crash during pad power on/down

Kishon Vijay Abraham I (1):
      MAINTAINERS: Update Kishon's email address in GENERIC PHY FRAMEWORK

Peng Wu (1):
      phy: sunplus: Fix an IS_ERR() vs NULL bug in sp_usb_phy_probe

 MAINTAINERS                               |  2 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c |  2 +-
 drivers/phy/ralink/phy-mt7621-pci.c       |  3 ++-
 drivers/phy/st/phy-stm32-usbphyc.c        |  2 ++
 drivers/phy/sunplus/phy-sunplus-usb2.c    |  4 ++--
 drivers/phy/tegra/xusb.c                  | 20 ++++++++++++++++----
 6 files changed, 24 insertions(+), 9 deletions(-)

Thanks
--=20
~Vinod

--mxTQoUQiUzCA1AIn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmNsxo0ACgkQfBQHDyUj
g0dx6w/9HIS1MJ8BFiuKzcP7pRj6bEN0qXKBHGlDbFoa5BWOmUp33tkDMg11zey6
5Rn4ePX4Oj+zmzoDDiZ6GkiYAiNRsSGBN+igihxtrUZ/BeSCxEfSnXmAgYBCGnTY
beUlpBwkiOZjv+b94I7X8p70Zcs9QdUTQvbynn9a2KbCR9vcMF5H0y7E28uHqzip
wGeLSH1wcahi5YTBiorWa6HqbJI55UHwq3GBKBWrps2uzZp6zrc6aZC1qGiu7FlZ
IK2nTfrN8/hrBNlsAcga9wx4b4ug2kJSeAh6nzIZgaq0WxduwZY6waCtZt0+F4fJ
UlBGcz1CUMgaLKiYmPrEJNHcqZOtHmvQy8NZlkzB5FgKcrCUGhR//LXI8VlHaQKn
jZg6oaXR6dPQcMgYfQXm6izWoBNG8SSRrapXZmfRGBKNDQypGjEmeuNSLhyNMNyJ
IOJ/6zeqlZEGF4DBwKOmWwJpS8oHszZnBQGdUMy4FfejoKYj7IqF3ZR9Utltipuw
FpJw37i07RoMVZCZEkmhY95Uqk6SW7UFJJiXDtExoOpRx1RMbl03nHQUyUPoOltt
IaVSJ5vEaZaYLeL6JvfI0KxTYB09IiopVzdemHxfZpTJu7vid9wIBa/hUyw9PG+I
6eck/7N1nr8UpN9/o+NVWT2OaUaQ7Am715Hw4Fs+t8VCwvNo1Co=
=j+qG
-----END PGP SIGNATURE-----

--mxTQoUQiUzCA1AIn--
