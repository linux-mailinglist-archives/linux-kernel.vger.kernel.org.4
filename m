Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D5966344E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbjAIWub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjAIWnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:43:12 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DFB1DDCC;
        Mon,  9 Jan 2023 14:42:52 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NrTVH4jN9z4xND;
        Tue, 10 Jan 2023 09:42:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673304171;
        bh=7DWiRV4Q8QRPF+LkxUekuAC1Y3rOnAapGW2ZUhPDazc=;
        h=Date:From:To:Cc:Subject:From;
        b=jPZAuhG6Q8tIhNIKwTjfEZzNYrg62mhClnT5xWVHU4s1dpekt/G49cn9WPuTzUOUg
         m0mCMScACPVRU49PlzXhRrKKIZgk/akXvI13+HVnnGkhRMXVM94NgNAP+TxTrjM69C
         VMNwrx5RuneoiGlQ/sKKa7TzbkO1C608GVa1ie3+VKokGi+xeFC44X7PS6Z4NnZcau
         lLT6L44PLmR385Zt32eI9BiN7FPktG03fTgetyjPs0m+K/1aarFixU1IMnnK8ZfGkq
         RbHcIthg7lYOjlTPHV0RBChzmIfCFAws9cIR+Cu6GWsMR6LleWknMvGP+8bw/xMgd3
         y/KbQlT7mcrpw==
Date:   Tue, 10 Jan 2023 09:42:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the davinci tree with the arm-soc tree
Message-ID: <20230110094246.1497d12e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UX9MyVrSXCmEHSFeNun/8Nf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UX9MyVrSXCmEHSFeNun/8Nf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the davinci tree got a conflict in:

  arch/arm/mach-davinci/board-dm365-evm.c

between commit:

  fef6ca600ba7 ("ARM: davinci: remove unused board support")

from the arm-soc tree and commit:

  84bde55c050b ("ARM: davinci: fix repeated words in comments")

from the davinci tree.

I fixed it up (I removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/UX9MyVrSXCmEHSFeNun/8Nf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO8mGYACgkQAVBC80lX
0GyBzwf+MrEGJvgsywvPzzoCE37N7+H9UpELbyC59ORp+P+lx+bgM2XX/f8RMlDl
S12t59Sl2OaA4zpvj7EmiMy/o9M7bcV8DxdgOwWJmqis0nbxNlkqICgs6xays8Go
/0GZW68ZcG4J7GZo5GSdVdakiF8lTgbzi0va6gVn/dv7cU1TOu+NZO/SS7xJleaG
IyFxC0h0ubN2xutH0JkOvxiEjUAVMFlBxm3NTEilphlG6MxsuJsIKjNfVEiPusyA
AlmX48QgOVQq7XyPmN4aUXS0WqV+Or5LLHb90fUJe6NHmrQhqqrxI4MeEKytAmuW
BuKToJEQHzMwZbmgDI2d81paR4zFZw==
=sCXs
-----END PGP SIGNATURE-----

--Sig_/UX9MyVrSXCmEHSFeNun/8Nf--
