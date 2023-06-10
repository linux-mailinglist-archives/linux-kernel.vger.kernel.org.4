Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFFA72AC5D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 16:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbjFJOjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 10:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFJOjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 10:39:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B1030E8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 07:39:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F207660E09
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 14:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79E1C433EF;
        Sat, 10 Jun 2023 14:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686407978;
        bh=9p5pjml/DlS80l3WRu22k7z7j0ax57mB6NquHaK1A3A=;
        h=Date:From:To:Cc:Subject:From;
        b=Ec8pKuFED6LSAlp4dD8qdYGjwMXAmpSHnzqJGHs3J8WDF54GmWMFFwtnBT8zuBX8p
         /Ei+sGzweSszA/0VFewK7Rl0ZIocYnkG3Ezlgp1FkQhN0KkGVVcKXWtFpkxtyD0SXu
         7DLfdYfg1jXH4zw/06E2BjiYz5xdRFa+Uqy1Z0rAmGX5B+8RN6qnliPFzUuvplMH1F
         36UduhFtb1Nqlz0zmmjYiIO8sEMcnO+u/G2oB1R1oFraJPrNN+Dr8op8kkawVBwFII
         JGsUirWlKQoewIbcBEThcw+8KMPQ08YzM285tbDdk5sz9cZYWzEz1eld7rZE0xwujd
         o73TesX477jBA==
Date:   Sat, 10 Jun 2023 20:09:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire fixes for v6.4
Message-ID: <ZISLJotNt4Lsk+pt@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XBZJpgmYr66Huz/q"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XBZJpgmYr66Huz/q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive the fixes for soundwire subsytem. This fixes one
core fix for missing flag clear, error patch handling in qcom driver and
BIOS quirk for HP Spectre x360

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.4-fixes

for you to fetch changes up to 58d95889f3c2064c6139ee94bb0e4d86e1ad4eab:

  soundwire: stream: Add missing clear of alloc_slave_rt (2023-06-08 17:08:=
04 +0530)

----------------------------------------------------------------
soundwire fixes for 6.4

 - HP Spectre x360 soundwire DMI quirk
 - Error path handling for qcom driver
 - Core fix for missing clear of alloc_slave_rt

----------------------------------------------------------------
Charles Keepax (1):
      soundwire: stream: Add missing clear of alloc_slave_rt

Krzysztof Kozlowski (1):
      soundwire: qcom: add proper error paths in qcom_swrm_startup()

Pierre-Louis Bossart (1):
      soundwire: dmi-quirks: add new mapping for HP Spectre x360

 drivers/soundwire/dmi-quirks.c |  7 +++++++
 drivers/soundwire/qcom.c       | 17 +++++++++++++----
 drivers/soundwire/stream.c     |  4 +++-
 3 files changed, 23 insertions(+), 5 deletions(-)

--=20
~Vinod

--XBZJpgmYr66Huz/q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmSEiyYACgkQfBQHDyUj
g0cB4Q/9FRl1FkXaZph+ValhzKgH2W5p4Eyydvfcte39aSEXcdbUCPV/Iy2lBoxe
5QoDSrEhKrhhl1PELOQyXNRpF01+ytK30k44kAAWvegZtIY2H9VOcv/YA0Jg+uA4
RYCRlj8hGeUUs+HhM/W5g+xxUGA4ZEWabNpKZvgHv11lK+xQsWs03N+ZO5ENcEQp
LlleMQEShjQNsr7EdP2IpLCpnd5RhIhDRHYlbRNHnrmzmuAPjOxlJXYD7DPBXOmL
st5rUTU8VRk8c7uMknLBLtYLduIACDkHKFP5PQE1K+/8Us8IpOXNgfRCyGzTBMSF
1CohG8DIbWOwj6/PSTXH53HZOnIDAV6XCvizkCOYTuXVI1S9f556mrBOhtDHkozB
Fs98XiLa+Y8d2QLJ5WdWe766DqrvufntbwTV0j9SgnVHqrlRyTM7Jf9t/3MLXKqh
fPLV7oWmgtjY9nW11AboiKyBNcFOg4Z2aIPIkZaQ/O9sMNBdV0UGky7psS5pQpkO
lF1U8SD4SdqS9ULSIUbANRKdCt3ZbRwuQhc/DUQscT5b07/pMzkd2fuhNP8hx1p1
bZejnUsjeFmzAVQRBqMiwiaOpJf42RfEvvJJRtQicf0jMmreqXq2vaEVhhP8vGrN
t3+pLbQgrAMYHdoqDsdj+GEvpg+a098PA9puQCHBnE99KHMY/m0=
=zPsc
-----END PGP SIGNATURE-----

--XBZJpgmYr66Huz/q--
