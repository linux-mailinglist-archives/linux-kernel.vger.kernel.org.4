Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB16A164B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 06:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBXFed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 00:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBXFeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 00:34:31 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203F3166D9;
        Thu, 23 Feb 2023 21:34:30 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PNJVX1Vkxz4x1N;
        Fri, 24 Feb 2023 16:34:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677216868;
        bh=6A7twci1N4LarMfKhdKYaWjpyVlHaS+Pf63aEFyRu0c=;
        h=Date:From:To:Cc:Subject:From;
        b=q6bjbrK1zku1eAlWyWqsSS1KWz+z/hCmQSimDhn7gzqK0JG6FgK6dV2cHAeMwxFM9
         sGSKadWlAABmrrQHAPsZLVyipKwuaemCRTc4AVx4AISJqQWHze65jDTCmFrXhTcQqQ
         maFE5KevOTpBarR+TlYmGIs/iSyuip9i9BG2pEjmct8h0fkN4P1tc6IOhMYxUOBz01
         PA8OvJcPoQI90hQCF5rBpJQ9jDv0US7L5eewha3gCl3FjaF7QQmHLE4d00jrV7ZboP
         pQgDBJ22so1Fhrzx/535CbHdZqvt2D3c2536bJHFTaOaQQ6O1KEQ7fUPbmya90+ajM
         Rq79DcxAD3wGg==
Date:   Fri, 24 Feb 2023 16:34:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Donglin Peng <dolinux.peng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the ftrace tree
Message-ID: <20230224163426.7e4d956b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WmOnlEwEiVnO8d7QI=6q3U8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WmOnlEwEiVnO8d7QI=6q3U8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  2740abcc36cb ("Allow forcing unconditional bootconfig processing")
  d3a1913404bf ("bootconfig: Default BOOT_CONFIG_FORCE to y if BOOT_CONFIG_=
EMBED")
  9739868a6e5b ("bootconfig: Increase max nodes of bootconfig from 1024 to =
8192 for DCC support")
  9f58b99c9c40 ("tracing/probe: add a char type to show the character value=
 of traced arguments")

These are commits

  b743852ccc1d ("Allow forcing unconditional bootconfig processing")
  6ded8a28ed80 ("bootconfig: Default BOOT_CONFIG_FORCE to y if BOOT_CONFIG_=
EMBED")
  6c40624930c5 ("bootconfig: Increase max nodes of bootconfig from 1024 to =
8192 for DCC support")
  8478cca1e3ab ("tracing/probe: add a char type to show the character value=
 of traced arguments")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/WmOnlEwEiVnO8d7QI=6q3U8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP4TGIACgkQAVBC80lX
0Gz7BAf9FQ2pqTGHXxrcyr89r6TOLGTVWqh7F44aa3B5IrXR7ZGxdp94uV3xDiFi
IxpegDozpZ0bUR43NVKjEGD36zcbPYZOAnTlGO18atFBTb9pGjc6ZGSX3gqlWCJH
tLFhGa2XKWNVwAYIQa2D9OiPBicy3jLltxWM6K4X81xFWREd9mMgDWPf8aBcQ2D/
H486M4Qf+O4M2l43hrtfvyVNbvq9q1GQs27yqkkjjcN4GTa7bJCA+WQQ9QQbNjzK
PEFtAWIW/jz/LtzeW2+lT7a/TxexOqh2jpfxBQXEThosfDRABGhmYI9vxK6TaLK0
NZYFFOATPVy8aS+v3hEKNfV119+18g==
=2jcZ
-----END PGP SIGNATURE-----

--Sig_/WmOnlEwEiVnO8d7QI=6q3U8--
