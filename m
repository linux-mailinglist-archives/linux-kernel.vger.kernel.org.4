Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1F06C764E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 04:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCXDk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 23:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjCXDk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:40:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0910B25978
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 20:40:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98C936292A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89E6C433EF;
        Fri, 24 Mar 2023 03:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679629226;
        bh=/hcF7XZI8PgySqtxHJ0zm4hx/ClWIFlH7C7h49xzGyM=;
        h=Date:From:To:Cc:Subject:From;
        b=eFrRalOEMqFZr/ma9negUNrgCXQkXlrpGVGDljZ6KorqZHKG/m8nBDHjgycEzaB5Y
         HGos534ga3fwbmkQK1ZBCWOOpoQUGH1iKUuSt/AdaZkA9nar+Rn5bAZP0Fsy3aZLRb
         BVRmsXtC9r995w2j9z+cEQ3HzSceQtryz0cSItZoM1KIjlRKlsmkZX0DUSJ1eUP4XN
         IuxplmaOXhhwBAwnYhxbJ55FZNGMOvbfPwkfF5k/aM5REtvJxuh0CyoRwpFEcLijU6
         c8nz/W5mbMCzJh1MFKh30kNuw5Fre0OCl8yyzOXq8dZZZKuI3OJifLJvjnxk323A7Q
         mdOL2BWSqr1zA==
Date:   Fri, 24 Mar 2023 11:40:22 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org,
        tzungbi@kernel.org, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev
Subject: [GIT PULL] chrome-platform fixes for v6.3-rc4
Message-ID: <ZB0bphQcL7KLRuV6@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9y+5mO0/TvXHp/Am"
Content-Disposition: inline
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9y+5mO0/TvXHp/Am
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull chrome-platform fixes for v6.3-rc4.

Thanks,
TzungBi.

The following changes since commit b0d8a67715dae445c065c83a40a581d6563a341f:

  platform/chrome: cros_ec_typec: Fix spelling mistake (2023-02-08 18:21:03 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-fixes-for-v6.3-rc4

for you to fetch changes up to b20cf3f89c56b5f6a38b7f76a8128bf9f291bbd3:

  platform/chrome: cros_ec_chardev: fix kernel data leak from ioctl (2023-03-24 10:56:28 +0800)

----------------------------------------------------------------
chrome-platform fixes for v6.3-rc4

Fix a kernel data leak vulnerability.

----------------------------------------------------------------
Tzung-Bi Shih (1):
      platform/chrome: cros_ec_chardev: fix kernel data leak from ioctl

 drivers/platform/chrome/cros_ec_chardev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--9y+5mO0/TvXHp/Am
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCZB0bpgAKCRArxTEGBto8
9N7sAP9TO6u+JoOQ6sC6mRBino8DqZ2099nNDe8Tl+xOLwk6NAD/U2u+v0uNqfs7
08CmMXfw3gyZEW2F3J4/S5ciRKDj1gI=
=m9la
-----END PGP SIGNATURE-----

--9y+5mO0/TvXHp/Am--
