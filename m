Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DD26C8765
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjCXVUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjCXVUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36A740CA;
        Fri, 24 Mar 2023 14:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E2C462CAD;
        Fri, 24 Mar 2023 21:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8128CC433D2;
        Fri, 24 Mar 2023 21:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679692836;
        bh=G0qOOGm4rBjqC+kvJ+kcNFs+i54Zpf+/Gfp1bhyPVa0=;
        h=Date:From:To:Cc:Subject:From;
        b=X8cJ9Q1vGcRH7trG7cqbT6IobndnYLjFN1C2hUdYGVBSWecSZCDPE+k9bkK1bbEPY
         PRxS9W2KW8v4DeGM/QZsGPPb0pFO7Y2qlnypBM7Otx+xAghgybfjqqRM5qcv/OAYVW
         sXd3gm5y53ihas7YEJcIjPB+0oWofNWIPlypueLx5WwBlpTAYpLDw2dCFg4nQdG+nI
         HqIJzigZC00hWOVd3Gfg2numzHDrs+Om2abyj8qsqNL4C8LzbsLVgjbERkCi9swgeq
         jHPW7oflZ0FWM2Oe3iKwx8WmtnbCwvLuR73yj6DY0lFa85baS77nkIjw1BiFFyrb7d
         RdAaaBH7W9bOg==
Received: by mercury (Postfix, from userid 1000)
        id D16A11062140; Fri, 24 Mar 2023 22:20:33 +0100 (CET)
Date:   Fri, 24 Mar 2023 22:20:33 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.3-rc
Message-ID: <20230324212033.empobvkrgug5l3x6@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lztrabwzyqs5rdcs"
Content-Disposition: inline
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lztrabwzyqs5rdcs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.3-rc

for you to fetch changes up to 06615d11cc78162dfd5116efb71f29eb29502d37:

  power: supply: da9150: Fix use after free bug in da9150_charger_remove due to race condition (2023-03-12 23:28:04 +0100)

----------------------------------------------------------------
Power Supply Fixes for 6.3 cycle

Fixes for the 6.3 cycle:
 * rk817: Fix compiler warning
 * cros_usbpd-charger: Fix excessive error printing
 * axp288_fuel_gauge: handle platform_get_irq error
 * bq24190: Fix race condition in remove path
 * da9150: Fix race condition in remove path

----------------------------------------------------------------
Denis Arefev (1):
      power: supply: axp288_fuel_gauge: Added check for negative values

Grant Grundler (1):
      power: supply: cros_usbpd: reclassify "default case!" as debug

Jiapeng Chong (1):
      power: supply: rk817: Fix unsigned comparison with less than zero

Zheng Wang (2):
      power: supply: bq24190: Fix use after free bug in bq24190_remove due to race condition
      power: supply: da9150: Fix use after free bug in da9150_charger_remove due to race condition

 drivers/power/supply/axp288_fuel_gauge.c  | 2 ++
 drivers/power/supply/bq24190_charger.c    | 1 +
 drivers/power/supply/cros_usbpd-charger.c | 2 +-
 drivers/power/supply/da9150-charger.c     | 1 +
 drivers/power/supply/rk817_charger.c      | 4 ----
 5 files changed, 5 insertions(+), 5 deletions(-)

--lztrabwzyqs5rdcs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQeFCEACgkQ2O7X88g7
+pqyUBAAjKQnd54kuVKXxj10F/B4DMB3UGMCBAQGphhNOACGn2e3SsWq7/Zq/vCZ
PR9R6E9Iye0M/G87CPjjVaWTChcbFoOajzPD5Xv8TP4cufTIwUB0QNqq+5ZrWlKC
7oP2ysRA55KlKDaxSOwGTi/7xiluBBPGw81uHlAj31COFthapasgncUIpDBRzOgE
cSgsc1dTqzlHuftBJ4cmhz8pboOJ/k62p6c8IWi2DWqZPbWg/DdopKKuwOpsfHEy
yxk9aZWObmqhHVXR/ebHHqQc8Lp4ET/FXB0LrLCmSWFAh2r3Ai+CNcZbdya+i5Br
kDQfB9+UK3K/X/YQjPs6PVW3lp3gIgRaaPPHUW34K6r86xVM5FWBtmQCJF3hJJKq
gaPVDIQ9WGTvyRh1QGpCuzC4Pt/za3iJR4Bw82Ua+IGhN8oDEDVBzA+LAPwwePwQ
8pYCgiw1Jd2eXgRA+JOB64DqyMYU1COqlzjphfvAODEMAmZI6sBBu1wqPWQgglkp
8tJcNR82wh4MkQkP6WIdvoNkCNW4vEf9DE3fwy/Gfw1gWE0SVasR2LvDK854Cph4
1HX0xfaLRGNlrwzEfIWNTPQqTS0ZRlM5GguTjc2g5CWZphBOt6mdZduU6WLxPR1j
UQDqSrTub65juEhpQz8/dY6/qwqVJcFh7Z9Ks6JTtrr/F1+E3LY=
=Xusk
-----END PGP SIGNATURE-----

--lztrabwzyqs5rdcs--
