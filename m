Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC39719021
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 03:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjFABkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 21:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFABko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 21:40:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75446121;
        Wed, 31 May 2023 18:40:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QWpk05Grzz4x3g;
        Thu,  1 Jun 2023 11:40:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685583641;
        bh=yXnYgbGSBqLsbTFR2/V+58Z3G9mVeTlswbnRoEMAZj0=;
        h=Date:From:To:Cc:Subject:From;
        b=lFx8+2uajuPQKlsqwmr14oyHtPI56C1VrP7OfmoWTX4WOfh2+OZy3NSjLPyw7Ln3J
         OTY0HGGp36hkwto6qdWk6UTqiT42mkhZ8M/bBeAMIepQokcMjolAlJqTc/b61M+L3B
         n+cWNqF5NdbBHaWqYww0M8B77Sh0FN0eT0+1DPzgpRu96SvbongSS7+oJzujUd4CEG
         FbCdB6a17U2duD/2fNqr2cPOycCPy9PGYtwdospin7KXOvFC5xMGAqoCmdeqYUNwKz
         JpwUIi89dHIuKzUe9TS5sqqDPhZNcWH1R5Tcbl5g/QYWC8UOJ0QY7rA83mLlXDeIIL
         PixKF4qLh4x1g==
Date:   Thu, 1 Jun 2023 11:40:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sudeep Holla <sudeep.holla@arm.com>, Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the scmi tree
Message-ID: <20230601114014.52b6dd99@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9AkwAZ+VNsCd6Z77oN9VNEO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9AkwAZ+VNsCd6Z77oN9VNEO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in driver-core.current tree as different
commits (but the same patches):

  78c5fa2c98af ("drivers: base: cacheinfo: Update cpu_map_populated during =
CPU Hotplug")
  3e871b199c9f ("drivers: base: cacheinfo: Fix shared_cpu_map changes in ev=
ent of CPU hotplug")

These are commits

  c26fabe73330 ("drivers: base: cacheinfo: Update cpu_map_populated during =
CPU Hotplug")
  126310c9f669 ("drivers: base: cacheinfo: Fix shared_cpu_map changes in ev=
ent of CPU hotplug")

in the driver-core.current tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/9AkwAZ+VNsCd6Z77oN9VNEO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR39xYACgkQAVBC80lX
0GwVNQf/ZakjTaJrj+FKHAZv18ixFbo4kTblk63bExqEBPGdD0BlczqUdk3e1HLJ
QAAsYdVemQiwlfn08sRmANOLfpQ9HMQ1+e1FUt1VCh3QHVSaJuv/Lqf3yddPJ+e/
YFwXUtVG+O7I+DTkt2nRpM4K2Xje4vWL8VJihSIJtrWSPUavEf+w7E/L316nwGmc
0PEvrn2+j/WB8hiZw05ALJKS9SM7OVpImNkJi4svWILI+jiV2PcO1oH0xQCuIKdm
OBPY5E8NL6DolGR0W1beSqu2P6sBfj0TnRcPdOfgcxKJxpgLbPxG5u/CEaX92K/d
lU1ARMAPgKISXRrkMNa0bs1iTNfxsg==
=9PFc
-----END PGP SIGNATURE-----

--Sig_/9AkwAZ+VNsCd6Z77oN9VNEO--
