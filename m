Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C1074FAF7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjGKWfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjGKWfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:35:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94A21A3;
        Tue, 11 Jul 2023 15:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689114903;
        bh=NeXn+ybZp/Kp0tyVls+58Athw9u+en3RKeIIRyLD3R0=;
        h=Date:From:To:Cc:Subject:From;
        b=FI+L2Z6V/Vmew4kop28pVWVXfwpOaaW/fWvyZuTolHoy6t30ilMlxaeMInTspSUzw
         ehEdtlQjbkYUkcOC/oRsgNWA/Ns6lFvqwpxwHlCOstAeAAPdYhj5E6wjtc1z5Zd3Bp
         y2kmEkbrx7m6Re3Q4570IhbQ6ATerSGX9kUtfuiyQkslyjCw/+sbp+ciL0Nh0xD2qA
         a/sduFpofzOa2ijgTHR+HTjcpTYfoa3slaG3vmhKmGXtHvhpNS9qCcu0+0FygY2N2x
         Xd43wTD8Uf3vcaiOFZDu2Y8iP7DUY4vUBoun5nbBs8kyw5VMGiB4okRBgmbd5ch0lI
         fJ3KJqydwv4Jg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R0wfv40qcz4wy7;
        Wed, 12 Jul 2023 08:35:02 +1000 (AEST)
Date:   Wed, 12 Jul 2023 08:35:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saket Dumbre <saket.dumbre@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pm tree
Message-ID: <20230712083501.60b2968b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+2zh/w.H886DPBX=O1Sfdp3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+2zh/w.H886DPBX=O1Sfdp3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  ed9aa118e4e1 ("ACPICA: Add support for _DSC as per ACPI 6.5")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/+2zh/w.H886DPBX=O1Sfdp3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSt2RUACgkQAVBC80lX
0GxBugf/XgDSh5QIP+Hv8Su6cNHnhlQp+z47MMzfJdE6qZ/KHIPrY/IVkoCya2FS
NSiV12hyvEBFqny0QqTJDGKHXH3pdzTrLmVtX8Q54Zfn6//BWFjduoEtN3J/Ss2Y
XXeTMrAV3LnI5YQUFT0kJlaGR/08/taUvAsVzWHQPJ5J5Oai1Ub22dSAtGkIS5Qz
hC4jn9Dm9ww/Iwp5TQ7me8z3EsczSCMHlTbqADLFjBRpwLhc1EgMUvWiNqFdAT/u
Vpg8TRDPULsRNCiNhTANkEylMinwEKxitbHRe8AyidtgXjlm3K0robOIkAq2wGUI
81S2xbo/IsSLrG2NzoaD7GgOyzVfMg==
=r2pi
-----END PGP SIGNATURE-----

--Sig_/+2zh/w.H886DPBX=O1Sfdp3--
