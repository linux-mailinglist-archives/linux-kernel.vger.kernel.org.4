Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4CB605385
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiJSW5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiJSW5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:57:33 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0FE1C39C4;
        Wed, 19 Oct 2022 15:57:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mt5j146jXz4xGQ;
        Thu, 20 Oct 2022 09:57:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666220248;
        bh=bE8FsV7P/1dHPlwdOCqJYtJ+w6dJbFF/0a+T7QYskUo=;
        h=Date:From:To:Cc:Subject:From;
        b=sa4bbByjkwl667rQ6I35JPts4O6Lff8gBAbOY0fOLMSM9AH736fVbXcXj3Pjow6Qh
         pyX7RsBIhNPTzCTojuNyzi8wX/lOJkLCp/22L+KnfB2Qeg4lJS1FgVfaIiJII+CFUZ
         x4R5f8OZ5AcpeGPa0YsWPhYuNkTFzyVCEHRxqw/JcNkI1FUn4rahYi3FNwYwym/fpV
         Iz4x09Hd0K1wu3QkRB0JX0gkq3BX0CHmKRhJ5ZeaycTjdZYHmbJv0gePNo9ncukF3E
         7oT/y8Od7KEJjQLp0B2Izbx3L7IcDg9GITsHpstJnDjN6sXhnYpo02aswX9M0preUN
         ImJi8nMSkqzKg==
Date:   Thu, 20 Oct 2022 03:23:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Ilan Peer <ilan.peer@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the wireless-next tree with Linus' tree
Message-ID: <20221020032340.5cf101c0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QPch7.CbFCOkhnPOVW._2io";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QPch7.CbFCOkhnPOVW._2io
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

FIXME: Add owner of second tree to To:
       Add author(s)/SOB of conflicting commits.

Today's linux-next merge of the wireless-next tree got a conflict in:

  net/mac80211/util.c

between commit:

  ff05d4b45dd8 ("wifi: mac80211: fix MBSSID parsing use-after-free")

from the origin tree and commit:

  ff05d4b45dd8 ("wifi: mac80211: fix MBSSID parsing use-after-free")

from the wireless-next tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/QPch7.CbFCOkhnPOVW._2io
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNQJIwACgkQAVBC80lX
0GxAlAf/aHM3on2G4e5RKXL4lH05joPGVAbUVxATSIVImtY4deYQEQng/x32Z/bC
avmlu2lCwUTtLaCp94cPwmHu6cjmCCFythOz3w053z16/CO7Uy/Kdjpwdug+J1z5
V9MLMXlFFisDx4aYaJiq0daYJW1yggdqkZpdn34N1c7cw8kvLTeMDmOGEjlERe4Z
Uu5M0EskEgncOljFcwjBmoTe6dNfF3wyXUuj9urIV64MHF68gCsjE6r946trlynH
FkFDqFBgO8B1YsXLWam5snGldbrjGfApd9ky5fhpoi+PejQ+F3+4hz2+XuqZ616Z
6FztdQoZDMH10HHJphQFh9L+s6mtGA==
=fsIU
-----END PGP SIGNATURE-----

--Sig_/QPch7.CbFCOkhnPOVW._2io--
