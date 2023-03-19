Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB2C6C0570
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjCSVXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCSVXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:23:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AFA11E8C;
        Sun, 19 Mar 2023 14:23:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PfrSt3vSPz4xDh;
        Mon, 20 Mar 2023 08:23:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679261006;
        bh=XkS7pprV68cGMowEZ+ra4Y4qjCJrNuxnxjTHRouwXtc=;
        h=Date:From:To:Cc:Subject:From;
        b=sjYPMmYLY1wQolMzmjeBuVebkcD25MQOhflUX+7z6NLltcf6+78UQ6UXaKBip+KfK
         L3eugIc0ueQC4IlUU9yjA5fuHveThMp/fQZzrnpJbSnHWBASioZ8hUjOoDwYaPu1/U
         vW23NVALdA33AkHn+cXezl5uYEGupnEiyOif86ob08sa1gFuY4wWicW9/PELYBBaJq
         HeEr/VtRtQunzAkKC0q7jXC90yA3s8wFDUxYp2pEibTB3CUzwpH2dlzPD76EHGtISk
         pbEWkQFZEKfYJWe0y3eoqdT7IglEHu7GpvAJ7wnGWq9+FcCA/jsE4uBN0zxYKwNTW7
         bshXl+30cwaKw==
Date:   Mon, 20 Mar 2023 08:23:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the arm-soc tree
Message-ID: <20230320082323.61889e67@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7dNVcUZ2iI/1zWk=87VNLFw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7dNVcUZ2iI/1zWk=87VNLFw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  41341224e4fd ("ARM: mmp: remove obsolete config USB_EHCI_MV_U2O")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/7dNVcUZ2iI/1zWk=87VNLFw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQXfUwACgkQAVBC80lX
0Gz63Qf8CZv7XpPwiosE7ejDdQaWC1B0XO1cyfMzaTZISJkKoXdJgoBCJVfiztUp
9PMI//KhMSaETYLBUJyfcCbLErSlJ1O6KUO+3kak48jbo1Tk94rP3Xeg3yAWsZRy
gwV3GG12vGDrOpxntNIMnyLIIjRKZIA8abu72gZRnlYtmp07UlvBlK3mFJ/wJV4Z
zvmqeR4TNh6QQoS2ZEHi0kGVwNP0onz0fBO716xDFC2M7NXW73ztSccMALUdr+8d
hJPXDDXp/2dgefrjZBw2bzycMwCsxcz5Rcu2MKDThqTdO5q3nji9tn/D7V8iWahx
MZ3FVA7InDNs1sGDgNv1c+j+BiPSQg==
=B3gN
-----END PGP SIGNATURE-----

--Sig_/7dNVcUZ2iI/1zWk=87VNLFw--
