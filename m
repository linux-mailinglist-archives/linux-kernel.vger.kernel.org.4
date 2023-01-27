Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A23E67DD08
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 06:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjA0FMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 00:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjA0FMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 00:12:36 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12F934329;
        Thu, 26 Jan 2023 21:12:35 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P35LB3lFhz4xG5;
        Fri, 27 Jan 2023 16:12:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674796354;
        bh=6344sWondxrbpQGC++v0R1iJ3ikA6LE1vG7khK5E364=;
        h=Date:From:To:Cc:Subject:From;
        b=VRdUuFmgWiebF/pYagtpSC1PCSiyxJlIuwRWbkeUs8wALsRIr0Rnaz370kGJxZsQE
         e7wOShmMPPM1A+Ktl2RMdV1O4opqnBbewejt4oL2EBrPyKwzJDb+AZJzlRva6wv1i6
         7Vr66aV6SPDuamTumxRZ3Lum4yqVYqDzTxl50f9ROo9SKP/wZjkuWUCy37YvzsgI/E
         GbdDryUKXMr0vdp/loJi5eDKSxyusOmP3DiHnx9QbDi9lushVJ05HfrDp4fNzcD9io
         3qstzxOhcBIZJJPGgJZcOdBa371FHCJJ8Y5AuQGbO5LDgeJYuNTZOZ/rFibifWJKUx
         o8bnPbSM4AxAA==
Date:   Fri, 27 Jan 2023 16:12:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the backlight tree
Message-ID: <20230127161233.5c21c04f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FrCnSe3tfG6TGQqej_qnzVk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FrCnSe3tfG6TGQqej_qnzVk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the arm-soc tree as a different commit
(but the same patch):

  6e9b5cad13f0 ("backlight: Remove pxa tosa support")

This ia commit

  9041bd1aff23 ("backlight: remove pxa tosa support")

in the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/FrCnSe3tfG6TGQqej_qnzVk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTXUEACgkQAVBC80lX
0Gzq4wf+I4sSFtli66KGIohaqNHwW5f1b5qYSQB5Oe7GXprBiBgB4AfBj3tf3OoB
KVPM7W7Nf/AgCnMmUjIFWhbJ7YglYrdbpskU45SP+UpSRU8Sm95nUPz0CfXCWNGP
kei+y4XirxU7FbwyaskKhsabkQSAu/WiwD2AyM90BFFMDd0qpWxmuzqwoSYTvvqf
QCgKAtXbWVyO/twnKiAJe3MrogVA6e0JJMfyB4fdyFhd84QxUSKjGXRXCPa9Xq9d
xhwIBn9CmzgNgyl55861Ryb1IQPt5islcNCvBmDWXD5K7qQookComnUAM9MboIYX
YZtFcgZcpAeq01rAWFulAK8OrpjE8Q==
=tOJV
-----END PGP SIGNATURE-----

--Sig_/FrCnSe3tfG6TGQqej_qnzVk--
