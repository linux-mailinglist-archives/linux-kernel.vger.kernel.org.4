Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D036D8BEC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjDFAcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDFAcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:32:33 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380006A41;
        Wed,  5 Apr 2023 17:32:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PsMs76TXVz4wgv;
        Thu,  6 Apr 2023 10:32:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680741149;
        bh=1/M9Rd2F+mKLerjuGEAq0/rt3cV+S/DkP+paMW04Pvo=;
        h=Date:From:To:Cc:Subject:From;
        b=DMKNVQ/L67mbAZlkhaDMmzNocvdRDbhqsmqZy1tP3nmb4KML3HRMVAPgqSgXHc0ML
         vkhoN39PtiZiP8KcU6XFvXSYbfqOmjlbFpSMrQJ6kIOdaAB/vfthgxd7yNFyoiA0Lc
         /UJsIrn7pa34uZ4mDafG8zpApZzJsim0PVY81UqE0Cb0Vp2SDE8xxVYIqFDMSqAc+4
         Jz23Cek+by0G3jlxLxcSoUpFClmha+KOl+HZHokKeEzUqoS7WHq68YkQ9ttUJitiG0
         9YljEz1bGfKSXcNrUWFEb62n15Ns9KDIxpZbTDQLIvVRqtHtaS0eT0TVBotwpLPXcf
         v6wj3fwirmnvw==
Date:   Thu, 6 Apr 2023 10:32:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Kao <michael.kao@mediatek.com>
Subject: linux-next: manual merge of the thermal tree with the pm tree
Message-ID: <20230406103225.1ff571db@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fhVQ.JNALbM5x83cKJDWn+Q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fhVQ.JNALbM5x83cKJDWn+Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the thermal tree got a conflict in:

  drivers/thermal/mediatek/auxadc_thermal.c

between commit:

  10debf8c2da8 ("thermal/drivers/mediatek: Add delay after thermal banks in=
itialization")

from the pm tree and commit:

  ed18ce7b06cc ("thermal/drivers/mediatek: Add delay after thermal banks in=
itialization")

from the thermal tree.

I fixed it up (it is just a comment difference, so I used the former
version) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/fhVQ.JNALbM5x83cKJDWn+Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQuExoACgkQAVBC80lX
0GycMAf+KqbSdx6gmDSlKED0fpWmxVK4SQEupml1/XYvdt4+hNOJmQ+nQz5QaVdY
YMgUUUR4f7cA1U12nhcLyj3FAQUb+LJGBSHt5TIogSv5P0yH7kdH412kbeTruhBI
V+sIVjgDzBHX+ydkL+W3GyvhwgEoluiRapejk3DKRFf1DfZ2X7UrwOciEC7NGc9s
b5r/+YNWx7XaPtDA23wLRr5lxUaYhSTlWhNaY9G4Z2Rzvjb6P6TUohRuku3wNALC
kOZrNocUohDf8V55um3NSBYy73E4sIEoItssEh6QVMBBLahCSR+Z3DvY7Wm3o6ZJ
PBvp+6qNdrHCJ/uKlJXPBrYRDWQLaA==
=UzLV
-----END PGP SIGNATURE-----

--Sig_/fhVQ.JNALbM5x83cKJDWn+Q--
