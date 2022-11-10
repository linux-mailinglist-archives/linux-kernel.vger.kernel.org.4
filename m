Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7EA623EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiKJJoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKJJoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:44:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2D0201B1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:44:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30140B82141
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47408C433D6;
        Thu, 10 Nov 2022 09:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668073447;
        bh=BM8Ot8eEycesSBIR17cMVlm7uxZppspXpTBm4R+zEbM=;
        h=Date:From:To:Cc:Subject:From;
        b=QPsqoCtdAfxw26dzLCqtiai/2Pm0SRNi8AHW8DB1w7/S3gBRXCyFZIn0rs5V+Uf2X
         3vN58PCM7pq98fapuy+oxGCtQlc5uTI6TLQ0Ra6Xr4Xk4ZlPUnbi80iMfQMa3KJYOK
         p7+ri5Oqg4E8A7pdxidKhX4nZzw25gVXY4gYtbyRWVEcbAEdWbta8hbL1FWKD23N6e
         c4uFwJ7CWRZjVQdE0/+zUPoLpyjnMSpcP4gHbG/BPpkrGmZej4BybFhXgkPp42YQpp
         CyW4scADDY4FHtsvbeT6CFGQdWT2u3+618U/gUFL3/M6ycMl3Aa1jOxmveQKorm/dQ
         7B4BXdlpw3g3w==
Date:   Thu, 10 Nov 2022 15:14:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: SoundWire subsystem fixes for v6.1
Message-ID: <Y2zH4zDyx5kWaUvz@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9YfQFbXW7v+9ZXot"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9YfQFbXW7v+9ZXot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Please pull to receive three fixes in drivers for this cycle.

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.1-fixes

for you to fetch changes up to 49a467310dc4fae591a3547860ee04d8730780f4:

  soundwire: qcom: check for outanding writes before doing a read (2022-10-=
28 17:00:38 +0530)

----------------------------------------------------------------
soundwire fixes for v6.1

This contains two qcom driver fixes for broadcast completion reinit and
check for outanding writes. Lone Intel driver fix for clock stop timeout

----------------------------------------------------------------
Sjoerd Simons (1):
      soundwire: intel: Initialize clock stop timeout

Srinivas Kandagatla (2):
      soundwire: qcom: reinit broadcast completion
      soundwire: qcom: check for outanding writes before doing a read

 drivers/soundwire/intel.c | 1 +
 drivers/soundwire/qcom.c  | 9 +++++++++
 2 files changed, 10 insertions(+)

Thanks
--=20
~Vinod

--9YfQFbXW7v+9ZXot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmNsx+MACgkQfBQHDyUj
g0dWcw//Uq4z8WcOMxBWFNyHHu5aggpAKedfqxlIeZHeiXcYz1tVy2wnbTClZDO/
r1WN6HbeC8K0A20I0SJ9c2cmeDxyIUk90Kotw+KOPs9BS0ylRpXdrWGJw9KfC3+B
fNTypJ9GTajBLPhTGRTNpAR0AHqgmBvzPriSL+qrhfpPhiS7oPxucZMMbYg+VIFs
6CaOOUFcMDcTMW1uKjFVXfSc8c7qeI0P9fek2NURYhq2D13LnQtyBitDc7KYWfRT
xa4N3m98KcDWuZDhuXaDY+iJd8Z6RneSxyD1fAJDexAJV2oRYXiW9kyNHa5ZJcft
Erukkot3SDGe0MpvPCayf2fvyY6wq3jz9DcDY44eqDzostvP2m2au/NhW+1KwTkd
gkIvy05285XUPjmCeX3Uw9HVfaKcg64WKAsVorQI9aTX52zCSFZFOMxjXVCAqzRn
ywOtDwbKxbb9RhreTACpHt2mt8ch2zW32Orl2Qv96PXAcK3bgiT9BlbmLbcLt+NE
dN3hTTA88M1oUn98Ayl+3UoSQaIxRzYanta+ZTWW6c3++RVJDjBQkR2zCxTARM3v
x+P+Tf+woHq24L1FvNDDqr4nIowF+4dKedbti8j6tEa9CeUGQTqB0bcD1fKiM6sy
5rLKg1xCYt2X4zDnJoRtT8aUG1YrR6iN2MD7fAUc6T3sNThnofw=
=mmmE
-----END PGP SIGNATURE-----

--9YfQFbXW7v+9ZXot--
