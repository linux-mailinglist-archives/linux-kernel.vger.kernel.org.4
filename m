Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABC8680222
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 23:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbjA2WIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 17:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjA2WIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 17:08:16 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5521018142;
        Sun, 29 Jan 2023 14:08:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P4ln943Tkz4x1f;
        Mon, 30 Jan 2023 09:08:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675030093;
        bh=C4lVDAF4eURRLLsghSb6h103FMrt1VFw8dfpTF+DBU8=;
        h=Date:From:To:Cc:Subject:From;
        b=T7aqr4iVRKBRHp53JVmeBBzv9KQ/bXCbwDwdXQkupufuG707dtxWvTxSr/dP2URrk
         HWWUuw5ONNeG1OTmc0FFibyTll6JUCb+BvInNc9fAvoODYfQLy2xNLHYDt9H7kE4Oq
         mYGzkLthMq1xdNZOUomHqYrN95eAVLO4lnOaCIMkUYE/a6pz0ZfU/ux0B/Sp3W9Dma
         f2QfmwNRceRnoLqAoot639DS252BGNjCzMhiWLk8NpHCW3cKPKKsSQlMCQOkapNPH/
         doM3kOpsyy23ljqwSNAXX7gJ5GTio+rDsad6VIBokA6IOvAcd8h3FoacLcjoGKLxeW
         9Q/+bPWkDQVNg==
Date:   Mon, 30 Jan 2023 09:08:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the nvmem tree
Message-ID: <20230130090812.425adda2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1S9/T3/omgmOZ+rJPC38hBl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1S9/T3/omgmOZ+rJPC38hBl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  ee0a7b467d3a ("nvmem: stm32: fix OPTEE dependency")

Fixes tag

  Fixes: ae46fd89cc0cc ("nvmem: stm32: add OP-TEE support for STM32MP13x")

has these problem(s):

  - Target SHA1 does not exist

In commit

  32de71ca36e2 ("of: property: fix #nvmem-cell-cells parsing")

Fixes tag

  Fixes: 6a80b3e6fb41 ("of: property: make #.*-cells optional for simple pr=
ops")

has these problem(s):

  - Target SHA1 does not exist

In commit

  059e01d5b3a6 ("nvmem: core: fix nvmem_layout_get_match_data()")

Fixes tag

  Fixes: f61a093b4a0e ("nvmem: core: introduce NVMEM layouts")

has these problem(s):

  - Target SHA1 does not exist

In commit

  c976fd0b6970 ("nvmem: core: fix device node refcounting")

Fixes tag

  Fixes: 69aba7948cbe("nvmem: Add a simple NVMEM framework for consumers")

has these problem(s):

  - missing space between the SHA1 and the subject

Rebased?

--=20
Cheers,
Stephen Rothwell

--Sig_/1S9/T3/omgmOZ+rJPC38hBl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPW7kwACgkQAVBC80lX
0GycDQf+IC2OUhJbN5cCK5bF+zYkK+stylB5GRnsIfZsJtMV/Rw2/EjwXp1FZXBB
d3SItS87StbC/7Gt1SrhvYxd5BUDARufEJRGJKz9/qRW4utYgoh+Y/weac0yxh4/
sybeXpVaCvs11BNcUNWaa/nLPsyfOML159Uxzl2RBV/pE7pt23LiCIb3xJQTCXoF
l42epZQEyxCCuhvzcBKlLx5Rv4CSPCEH9GWxdmyDo8zw+bNdQYTmp5PkWAha5o8n
gm8RXqkH6zfY3vTbtyOj5C7G285tBrcEJE5sfP5d6eKhg4thz1geDI+HgvuIOUbe
p5ur4Yn4aOvqG5v2EJq+svwKz9hkUg==
=1zLW
-----END PGP SIGNATURE-----

--Sig_/1S9/T3/omgmOZ+rJPC38hBl--
