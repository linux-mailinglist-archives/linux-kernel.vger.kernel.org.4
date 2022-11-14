Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F42962764D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbiKNHSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbiKNHSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:18:02 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C2FDE9E;
        Sun, 13 Nov 2022 23:18:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N9gd16Ff6z4x1D;
        Mon, 14 Nov 2022 18:17:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668410278;
        bh=qZpRMBfulR0hk3+nMHk6MPbGdFAiexHBzM8ZJegSEbc=;
        h=Date:From:To:Cc:Subject:From;
        b=Sr79NbvOA7ED/G0Su7rh6bM5EX0B3FB5ub313wiJXFvGu08G3tTBeGc8rHEJ3V+UR
         8VYiILJZ3gFidx/czLR1PIQrOO3w+uBC8Pa0s7Qa1ICFOmu4RY0u/kqSKPixWKRqyL
         8hazMf/GX+yIluWbyoKWhskUXqyciKNvnH8SY8Y6cecaeG+Zs9GCy3F0lCjqB3yibw
         FNzB4OT44eya2OebpAP90LjPSepJLkWvk6ykhsAoCat+c4f9UCMQG4y91sjZjUv0k9
         st2kDUd150pVWD1dQcIWPgrz74X57qgKKBr07cHnqlY00wqBCRUbflOwu7ynyzAJmg
         wQLDo4CqsfrIg==
Date:   Mon, 14 Nov 2022 18:17:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liu Ying <victor.liu@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the char-misc tree
Message-ID: <20221114181752.08a850f0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//PUj8r=6+n+YxL7hcZB0qik";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//PUj8r=6+n+YxL7hcZB0qik
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the char-misc tree, today's linux-next build (powerpc
allnoconfig) produced these warnings:

drivers/bus/simple-pm-bus.c:96:12: warning: 'simple_pm_bus_runtime_resume' =
defined but not used [-Wunused-function]
   96 | static int simple_pm_bus_runtime_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/bus/simple-pm-bus.c:87:12: warning: 'simple_pm_bus_runtime_suspend'=
 defined but not used [-Wunused-function]
   87 | static int simple_pm_bus_runtime_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  882cf4c913d7 ("drivers: bus: simple-pm-bus: Use clocks")

--=20
Cheers,
Stephen Rothwell

--Sig_//PUj8r=6+n+YxL7hcZB0qik
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNx66AACgkQAVBC80lX
0GxrPQf/cYjGwXQIJMzHXo7fdAsJq2HGRt9lkyxppFUVTqKEBfeIl2nGGV+SN1Fk
FQiOyOu9EydGgESHWyXfNZAgTXVSx9tmbvsLEBWF5mrTsx73aHb5ePEfBMIO2bXQ
OrhUZv1csZ5BAqFQ+1YEG7XpIZ1Lmyf4u2L4Ut61ri+boG5/mkbS71boho6eyowG
UATEzuGaF6v2+99ov48QfMcJj8kQrkAVUb+EKfqGP8H8M1ccOa2yvtH4kUnDN/AT
Zi+4rhgoVdSnROA8oWgHIbbkMBTyhApz6owgRDbEYSKDS5z3XT/goFo5/j/qwJwU
vPgYsRlCAZw2IE2r6FE14fnTR03o4g==
=AKaA
-----END PGP SIGNATURE-----

--Sig_//PUj8r=6+n+YxL7hcZB0qik--
