Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A17963357F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 07:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiKVGvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 01:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiKVGvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 01:51:08 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684AF21261;
        Mon, 21 Nov 2022 22:51:05 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NGZfH2ZYGz4xDK;
        Tue, 22 Nov 2022 17:51:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669099863;
        bh=FrlHFNe9zvh5AopDqCcGYXZ+bqcNy/5GofTYQkA2+eA=;
        h=Date:From:To:Cc:Subject:From;
        b=qGGV7QUAzCfeZ1z05hKCZnE8Cje16DDnyW6Du9TnTF8gAgIpsIoNcbwYZs+n2NNCC
         /BAOa82/o5QUNqm+DAT7f1JUzrB/7Soo8UhkSwEi/4pAFxt2BkBWswFbvquWegqpBQ
         ZDlcK0jzIyjxrYSsGDNMHOlI5cIl9HAYqB2iDU6U/rx0xKnLxxds2pZptMi6ZNL2yP
         fkWlicGaVl1MOGF0lUxQRQI9ORBirIqUL5UJidByv0bLEIRMHRB2p7qOWf6DH4Gdql
         P1V7oXnGO7bbW4p1si+5yFcVYFWlfFvhjrhTr7F16rojmosx4RLQpMpX+hOcJJE8KK
         C7p6BjI80vPDw==
Date:   Tue, 22 Nov 2022 17:50:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stefan Roesch <shr@devkernel.io>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the mm tree
Message-ID: <20221122175057.52f0cd9f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zj=SY+aGCuy6SA3HUuIg/0X";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zj=SY+aGCuy6SA3HUuIg/0X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
thess warnings:

/home/sfr/next/next/Documentation/ABI/testing/sysfs-class-bdi:76: ERROR: Un=
expected indentation.
/home/sfr/next/next/Documentation/ABI/testing/sysfs-class-bdi:89: ERROR: Un=
expected indentation.
/home/sfr/next/next/Documentation/ABI/testing/sysfs-class-bdi:48: ERROR: Un=
expected indentation.

Introduced by commit

  93e6d447506d ("mm: document /sys/class/bdi/<bdi>/min_bytes knob")
  a0eef74439b2 ("mm: document /sys/class/bdi/<bdi>/max_ratio_fine knob")
  3aafa9ff1d4f ("mm: document /sys/class/bdi/<bdi>/min_ratio_fine knob")

--=20
Cheers,
Stephen Rothwell

--Sig_/zj=SY+aGCuy6SA3HUuIg/0X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN8cVEACgkQAVBC80lX
0GwG6Qf/cWsoDJGRe4tWZSCNwD67oxgXrJZOL490+y+KNNh+Lcy8slvmRRQNxnb2
NXuFCulmd29cNMToU3gaSA9ISX+ahYFPk774zm/5ljIzKUXa9qyirSQgjr9s9Kpi
RFpV8FcEXUbOoBr4BXm81HwLy5GNJh64JvKI0Gcn9ap8QizhjHWfmuzxJa2FNNV4
H5CErvRZ+Xbz5JBUGVDChryqyUuxmIGW/rL553edy02+s6o2iSVB8LaKempdVd6Q
h7lzTMVn9voed39r94+xl/qXy5I+dRH8h4/P0ks0xg5vXzHmrHB/59GUaLADK7Gt
2E719sUyMd1xk2vzIGunlpdEmbCRXw==
=1oC9
-----END PGP SIGNATURE-----

--Sig_/zj=SY+aGCuy6SA3HUuIg/0X--
