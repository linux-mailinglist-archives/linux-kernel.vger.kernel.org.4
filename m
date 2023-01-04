Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE8F65CBD6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 03:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbjADCT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 21:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjADCT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 21:19:27 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBF512602;
        Tue,  3 Jan 2023 18:19:23 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NmtZs7304z4y07;
        Wed,  4 Jan 2023 13:19:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672798758;
        bh=oouSanPbXNWli5j/55HAPMfr+KI1kWCkMfFpLZN0UpE=;
        h=Date:From:To:Cc:Subject:From;
        b=HQE1uZ+Tiknyq7hiOgnNgffkaZjTTUMaWhU3wxBqsrdVzcCqtmQdWSN0zGLeGUwHi
         cO9jyiqpvLtlKPCOLwePHir7x5b/pzrulRUuXOO0vLNxV3Kc8EjdZpIOvozqldAbvh
         H3uqNxyypMzcItsCfXGbRC0CXiVKx/VxBR/mmb4CLCMwLc33BoPiPPLNsSP8B8DccC
         95FNynvQAPSFkvJJ8TNFtTjgqWMcSL4LmrEMLJVg9yKVOW6rIwZ47B8dpkQR+44xkG
         nY5eWxOaq1oB73K+skDHUvWBGP+39ijhA854jeBKgeYVdQr7/Oix64JwqltikoKtc9
         Nc0kGQIsWFXtQ==
Date:   Wed, 4 Jan 2023 13:18:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pci-current
 tree
Message-ID: <20230104131859.35e68966@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DpSSsfoqAaT1JlpyVsM5M1J";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DpSSsfoqAaT1JlpyVsM5M1J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  b3243d7d121d ("PCI: dwc: Adjust to recent removal of PCI_MSI_IRQ_DOMAIN")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/DpSSsfoqAaT1JlpyVsM5M1J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO04hMACgkQAVBC80lX
0GxB/wf9HfIoRwN6V/MF9yffP/9BE+dEx02rqdsB/Gvz2YLh3U/2lP98lCXahUKo
6zU7J7cSYUj39HWkoQof63TGNWss/3lVauCB8TA0ncdB8vTQFHR07PRUw12aG5um
Sr1kscR0hvP8BPBtiLJdYO9E8JdwNFetLcFjAi6srOwd9+4h2nwgZDmxjdSFoQyy
X0Rbqqf7nR3zzZI9f8lp23yl1L8Q0STdF8EJ3OxHLFvOAGn1heLDVNsFXEzg7S5D
12zUa2mYUB6zplV9IxFfnPemkYB9GzdQflv9hl5Pmf2xLDiO4fGzIKcVE3fDTzSt
ycpiscXsiyACsyTQc0x9X2rXjkm4vg==
=HbPa
-----END PGP SIGNATURE-----

--Sig_/DpSSsfoqAaT1JlpyVsM5M1J--
