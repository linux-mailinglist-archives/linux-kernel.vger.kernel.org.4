Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7502466335D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbjAIVnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238140AbjAIVmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:42:55 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A8A25D4;
        Mon,  9 Jan 2023 13:42:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NrS894JNkz4xP3;
        Tue, 10 Jan 2023 08:42:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673300521;
        bh=vFuZMimV3+WILQdsvk/fJXxy0oj3sS4gPr6RYHryZp4=;
        h=Date:From:To:Cc:Subject:From;
        b=dmdXtKajNo7t2OH0jeqz110qh1r12zwT/gws5uXe7pN4fSrOdOoRMnNP72iyUFOVO
         vpEVAOT36LKWpPpE5LheSn93CObyp15nOcC+Kicr2/F7iC0f74EQ+558xNbg4m3mJm
         yS/UE+dAjXrLh9/5+JZtLV+JC0pC7T+CuPV28b6WYz4GduwAkXN+FXw+oekr3a25UM
         l1pN22mfA6SWPVZqpGEUXIUb6eVCGc7nuoC+Y7s5OoWvtHY2KbvHUfz9B4JK0BwOxT
         HevzS3/FvgO5s1DxwDlZeaKK2z/0cq1JBpLisqOWaOB29h9BBDRMq+X3gBMTlgVtNI
         ZvOWYJeCIYUGw==
Date:   Tue, 10 Jan 2023 08:41:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tags need some work in the stm32 tree
Message-ID: <20230110084159.7d20dd38@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/grLQeN+bo9P6DfN18Z=jTv_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/grLQeN+bo9P6DfN18Z=jTv_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commits

  731c05eb8ec3 ("ARM: dts: stm32: Fix qspi pinctrl phandle for stm32mp151a-=
prtt1l")
  1bfe5bf6a0ab ("ARM: dts: stm32: Fix qspi pinctrl phandle for stm32mp157c-=
emstamp-argon")
  b8deada61dd2 ("ARM: dts: stm32: Fix qspi pinctrl phandle for stm32mp15xx-=
dhcom-som")
  4beb2a5e840a ("ARM: dts: stm32: Fix qspi pinctrl phandle for stm32mp15xx-=
dhcor-som")

Fixes tag

  Fixes: ea99a5a02ebc ("ARM: dts: stm32: Create separate pinmux for qspi cs=
 pin in stm32mp15-pinctrl.dtsi)

has these problem(s):

  - Subject has leading but no trailing quotes

Also, please keep all the commit message tags together at the end of
the commit message.  And I don't see any point in the "To:" tag.

--=20
Cheers,
Stephen Rothwell

--Sig_/grLQeN+bo9P6DfN18Z=jTv_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO8iicACgkQAVBC80lX
0GxnAwf6AoQanPneVCJaCu8a2ihYF5ZRv1sV4E5mULmJnvJnoe8zDfTiQBGz0c/C
D1XQbG9LWg6PSpfa8QojmhdL15O7+bKFnQskjDqsIOX3PkVf8arbBHwrR6vqccWi
zBtl/WNoFf4ty1xdL5KvbtrwwQrs0335EtFNJe/ced6HBQeG5qKFoVSbeX8vgZhU
hg2etOo44xw/jJrfeTpS5IQdQ6AD6EO+E+l/Y0n2iw3EMfab5Bni3LPGcHTwGKq0
zFFVK5at+Prz0YBHY5lhFYLmBnpcpKg7dtR7/9oowm5VWhlbnOIB9VrmCzKAU7Gz
KvXI+QudoVigpSCBKYPi8iTdrIVsqA==
=VjKP
-----END PGP SIGNATURE-----

--Sig_/grLQeN+bo9P6DfN18Z=jTv_--
