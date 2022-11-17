Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDB662D0A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiKQB3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiKQB32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:29:28 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0D445A0E;
        Wed, 16 Nov 2022 17:29:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NCMl62ctHz4xZY;
        Thu, 17 Nov 2022 12:29:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668648547;
        bh=fP8B8j0cnwPpwvh5O5joRbqzssWzNIbA6xaaNic8Ieg=;
        h=Date:From:To:Cc:Subject:From;
        b=Z5k5XGqWgI7hDfs3N5xjD6r0xEI5Ytmyot7KwcqH/i5mfTXjW9cJ1BA3zZYrCg0zp
         ICBuNaSE0Qlan4AHZqOHZi0jPCxlxtsJU/HHexF10IEnkcIg8BsvAGYyvZWE3hMvot
         Qg0B29IoamiDkSjWctde3JgHqG5obzwmFaigtoA8jS2aEP7pPo2rOheJa1x2qhfUlm
         YjGQHYi0468MPZsIDNKY1brMNKNcZPk/fSbGOQJSUVAxy7hUf7tOF7WoaqxoL4FIDV
         o+e3/IDVAWlDqvXFE1c/R9eiMtE9icpIQr7MCXsmlgjfmvoLX18bokTE1/13z/kESB
         SCsL9tYjmBG2w==
Date:   Thu, 17 Nov 2022 12:29:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: linux-next: manual merge of the thermal tree with the pm tree
Message-ID: <20221117122904.6759427e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZrAe3J9UC6yBWIu=QNLLhrx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZrAe3J9UC6yBWIu=QNLLhrx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the thermal tree got a conflict in:

  drivers/thermal/thermal_sysfs.c

between commit:

  05eeee2b51b4 ("thermal/core: Protect sysfs accesses to thermal operations=
 with thermal zone mutex")

from the pm tree and commits:

  dca20ad5acb7 ("thermal/core: Add a generic thermal_zone_get_trip() functi=
on")
  aed8b46d141c ("thermal/core: Add a generic thermal_zone_set_trip() functi=
on")

from the thermal tree.

This was just too painful to fix up, so please fix it yourselves or
supply me with a resolution.

I have dropped the thermal tree for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZrAe3J9UC6yBWIu=QNLLhrx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN1jmEACgkQAVBC80lX
0Gw5JAf+InuoFbcBGvMK06drQZHaw3V7I4Ip58ojEaqwaXh8L8NidKx+4FDqihs2
3inCYcQF73aFWITgeiaN9lXHxY4vh9pb8TghAifiwgeffgU4n/anraheIrk1DbKd
BdY2/PeqkF16N26fOHqXtqLz89gRdcNlWXbKuqsVQSgA8V0ZOmeZaMjuyehcX937
JpFRhZjgjS/s9onE8oI8YITkPDNkINNE4Gcs7FGlLvd7BzqlPCAnU3KNNYzfMZQR
J78w9nVhu/YZ3X/gvS9um3ff8HY4KOeNJQQ/RqnyT6gPnoUEChRWufRLhJHDVPUR
F4wGWy9ICmRYTdSjgHhYx8R1/hucvA==
=YhCn
-----END PGP SIGNATURE-----

--Sig_/ZrAe3J9UC6yBWIu=QNLLhrx--
