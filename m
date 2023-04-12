Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B626DEA8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 06:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjDLEck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 00:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDLEcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 00:32:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5CF4690;
        Tue, 11 Apr 2023 21:32:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Px8vN54gQz4xDH;
        Wed, 12 Apr 2023 14:32:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681273953;
        bh=79XUsW9JM9lKv08F08HgfhXy4MTjdplbRl0f767X6qQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Cd1QPzYFbmH0OYlbQPSU7dgZRSPSQBUusoNOwWND2WJCOPBeWEJxW6B4J5Nf5N8QY
         ZkSkbA/p8GDHgwyaCgKFbAONrQ2B4qzGzXoJZRk0JT83LivYdgzWv5D5QBlF1fADPD
         5DOrRm2qyBWw2QAf7x8WhnkmIUoFZUjYNsE6VkMIxsohWNPBx5bFkyvlrl2jY17kiZ
         UadsfzA/SRS2IUT+/Nu7pI8Bo6H3r1Onxwxd8W5AOflo9tIRjssXcLAxwfhJyHXqUP
         zJ0HbxeFxn4BOrMFixGi3D0LT9LMj9TlB7/191WW3GSOcGJ0rEIT//KNH8s0I/ewBO
         FTfNduOLiwicA==
Date:   Wed, 12 Apr 2023 14:32:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Yi Liu <yi.l.liu@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the vfio tree
Message-ID: <20230412143229.0c379a7f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZNKm3CLd45G83YMQPnuqCDg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZNKm3CLd45G83YMQPnuqCDg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfio tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/virt/kvm/devices/vfio.rst:45: WARNING: Literal block expected=
; none found.

Introduced by commit

  25e1b301a946 ("docs: kvm: vfio: Suggest KVM_DEV_VFIO_GROUP_ADD vs VFIO_GR=
OUP_GET_DEVICE_FD ordering")

--=20
Cheers,
Stephen Rothwell

--Sig_/ZNKm3CLd45G83YMQPnuqCDg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ2NF0ACgkQAVBC80lX
0GxJbwf9GQ5WcPU5ovoOpWdfDVHAvUlN5AN++GHQCGuM1/OM18yMYByonmB3y9K6
uL7yu/dfvDawMfQTt4ZvM+Sy2+963qt8JCx1zPSOuo4pRrxGwWMk6afSd4s5bnHh
2JMzJbHnn46rKPenp8SgG4YO96xiFq5RGVod4FAE30bMuvqWoN6nza4BcYmzTcD5
U22QqtZhluQD0tlKCnRMir1uPLFj8Z8YgwhHxR0qHhIMoQJ6BTlUDXNjV0WGgpaP
vS9rRzemnzf3g0vwmhB7Mkc3er9NcO5ZrK0IC8pOQCodhc5jpFZ7EhDkfa33c+Rx
X34luicoXE+aDpF/IFJCbZPLwugzfQ==
=Zs8B
-----END PGP SIGNATURE-----

--Sig_/ZNKm3CLd45G83YMQPnuqCDg--
