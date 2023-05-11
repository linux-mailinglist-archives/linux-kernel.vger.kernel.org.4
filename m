Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE75C6FE9C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 04:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjEKCQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 22:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEKCQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 22:16:43 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AA349F6;
        Wed, 10 May 2023 19:16:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QGwW95y8Nz4x3r;
        Thu, 11 May 2023 12:16:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683771397;
        bh=GHeX8XHYRuOhQoQKqkiFaNsusHVH2YKoZhPZH1BYuuI=;
        h=Date:From:To:Cc:Subject:From;
        b=WfIeaA7S6YuOLLHAx1et/Zn6Crfn6S/3J5UdNRZRQrHsnTs7uGTFK+DvvOiupSICv
         F3ox9QA88ZWcJ+Gsf2ffoTZ7CVQmLgGcCfJA0/2AkvGuGEBivmreaG781M8OOYZ+To
         FYhrcrlTrYvW8KLdPpOAI4lKNwAeNx5cR1k+lhaYCdU8QR5Pxt+AxlTTA+H+j718WL
         3O3Dc6k1Ue5LAuJaqTFYdxGHUeaI6knHhjzfOYk4HEwbhd5IqJj58Kv0HkNw1LmD4R
         G22lQf68ewCamMXiYwnCH2ROm35x8FOiEfE4jA8QFy2ko/wrb0DXZkLWZ3LgDh5GIw
         LodzWYtUrIiGw==
Date:   Thu, 11 May 2023 12:16:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings in powercp build
Message-ID: <20230511121635.0a6764a0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+9ffUtm.EyILFy5cWQg4miV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+9ffUtm.EyILFy5cWQg4miV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's (and a few before) linux-next build (powerpc pseries_le_defconfig)
produced these warnings:

Building: powerpc pseries_le_defconfig
Using /home/sfr/next/next/arch/powerpc/configs/ppc64_defconfig as base
Merging /home/sfr/next/next/arch/powerpc/configs/le.config
Merging /home/sfr/next/next/arch/powerpc/configs/guest.config
Value of CONFIG_VIRTIO_BLK is redefined by fragment /home/sfr/next/next/arc=
h/powerpc/configs/guest.config:
Previous value: CONFIG_VIRTIO_BLK=3Dm
New value: CONFIG_VIRTIO_BLK=3Dy

Value of CONFIG_SCSI_VIRTIO is redefined by fragment /home/sfr/next/next/ar=
ch/powerpc/configs/guest.config:
Previous value: CONFIG_SCSI_VIRTIO=3Dm
New value: CONFIG_SCSI_VIRTIO=3Dy

Value of CONFIG_VIRTIO_NET is redefined by fragment /home/sfr/next/next/arc=
h/powerpc/configs/guest.config:
Previous value: CONFIG_VIRTIO_NET=3Dm
New value: CONFIG_VIRTIO_NET=3Dy

Value of CONFIG_VIRTIO_CONSOLE is redefined by fragment /home/sfr/next/next=
/arch/powerpc/configs/guest.config:
Previous value: CONFIG_VIRTIO_CONSOLE=3Dm
New value: CONFIG_VIRTIO_CONSOLE=3Dy

Value of CONFIG_VIRTIO_PCI is redefined by fragment /home/sfr/next/next/arc=
h/powerpc/configs/guest.config:
Previous value: CONFIG_VIRTIO_PCI=3Dm
New value: CONFIG_VIRTIO_PCI=3Dy

Value of CONFIG_VIRTIO_BALLOON is redefined by fragment /home/sfr/next/next=
/arch/powerpc/configs/guest.config:
Previous value: CONFIG_VIRTIO_BALLOON=3Dm
New value: CONFIG_VIRTIO_BALLOON=3Dy

Value of CONFIG_VHOST_NET is redefined by fragment /home/sfr/next/next/arch=
/powerpc/configs/guest.config:
Previous value: CONFIG_VHOST_NET=3Dm
New value: CONFIG_VHOST_NET=3Dy

Value of CONFIG_IBMVETH is redefined by fragment /home/sfr/next/next/arch/p=
owerpc/configs/guest.config:
Previous value: CONFIG_IBMVETH=3Dm
New value: CONFIG_IBMVETH=3Dy

Value of CONFIG_IBMVNIC is redefined by fragment /home/sfr/next/next/arch/p=
owerpc/configs/guest.config:
Previous value: CONFIG_IBMVNIC=3Dm
New value: CONFIG_IBMVNIC=3Dy

I am not sure exactly which change(s) introduced these warnings.

--=20
Cheers,
Stephen Rothwell

--Sig_/+9ffUtm.EyILFy5cWQg4miV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRcUAQACgkQAVBC80lX
0Gy9KQf9GUZWVHlmfc2HT7kK21mwaSSr6gmP/VHH9Y0QK1AYpre6aQZXg3wimnuW
iuZHsQk4Heto0gXX4Co/aqfVGE1HRDCigJL3Wc70xGxyZV0ui+QjV7Lk5j3rQIJK
9/8/hkO1eBeVSwn9eOCepCy3jB+mivWJdGSbdTXWqJZpR0AcBo04OTBJVQBYEyPg
uu8F4mMFzHeuIW9SpsVY3mVrVs1KMG9IrYPwk+lMO+CJ1jIEo8RDDM00VVoKhz7w
+qDwKwOhFbcLFLB2/azEK1XQhiWGgcnhZoEnHOMsnLlDn3qLsSgWTPdIZybSpcz5
5oiwOUZaWWOz/SNx2486RQ1tmIkZhQ==
=dPow
-----END PGP SIGNATURE-----

--Sig_/+9ffUtm.EyILFy5cWQg4miV--
