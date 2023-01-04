Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA4365DF25
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbjADVkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjADVkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:40:45 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA70A1C40C;
        Wed,  4 Jan 2023 13:40:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnNLx6M3nz4xyY;
        Thu,  5 Jan 2023 08:40:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672868442;
        bh=zJhtLw3aBK2NpY6Wxf4DFD3lYJxp7eS+GaWYia5Rccg=;
        h=Date:From:To:Cc:Subject:From;
        b=GqIo4leB+vwcJVjlKEb4Gj/MS4rlW1YCUPoFPanjgZk5eqr5kafidrsJpZ/6/J3m9
         3S3aKC7SjrDRy7JdiB4Ea5RoiPjwtFVHJr7RfTaunyICX//eD98YgTlwdyXrdZztxB
         Fit/pQ/lgPOM8nW6YhqcDTpXB9+sMHgZGOIRT54UDDXWjLRo327ogS46N3zruusjjo
         ZhpqGwRGGb6CCSu+QbA/LvCSj9a2oyebGU4whLdCuF0vCDx0H+zPbEP+v3gaJPpU0e
         MqwgO0IX4fUkqBW7uqLzKu0w3xSPsjhw6VMKQbjXh5wnJWXalqCDRxcIzLz0YTgOK8
         WPcKUbHizTBsA==
Date:   Thu, 5 Jan 2023 08:40:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the tegra tree
Message-ID: <20230105084040.10a6d048@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/12kIBwt5YYdhQPrV7h499zc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/12kIBwt5YYdhQPrV7h499zc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit already exists in Linus Torvald's tree as a different
commit (but the same patch):

  ec5b8269b96d ("dt-bindings: usb: tegra-xusb: Remove path references")

--=20
Cheers,
Stephen Rothwell

--Sig_/12kIBwt5YYdhQPrV7h499zc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO18lgACgkQAVBC80lX
0Gw8IQf+MBI3wYY43OhH7O2gdffNdi6yDv9wwdMYgHBMTWNRn5G0bjqOD8sOn0kT
b2YtJe9wmc1Ayg9JAh47PUYBzjM7cJziQrU0CZrWvHZG/VXk499RDYz2z/exgDKS
APhsqIpoh1DQDTme84Lp74Cgsn4CrmPG0uSPNojS5At1nWDrSyLqQWm0Um2h+l6C
sD2mk2tRScF8Pp2npO76iAWZ4orhywKDfj9hd4L1TT6iQC0PuT12RUGVfmQ3g09X
Tw22y+R28enUG6p/44/3hbkvYbmkU1/3sPrr0lQnZRoHHKo+AzC7Jqxz6z/41eDI
K3iNQ9Fpr+Nb/Q9/giHKKtutaAVu6g==
=cBeC
-----END PGP SIGNATURE-----

--Sig_/12kIBwt5YYdhQPrV7h499zc--
