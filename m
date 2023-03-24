Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72FB6C76A0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 05:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCXEoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 00:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCXEoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 00:44:22 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E732887A;
        Thu, 23 Mar 2023 21:44:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PjV3f6Pdqz4xD5;
        Fri, 24 Mar 2023 15:44:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679633055;
        bh=xOBbKyMhbgTbQLZzLWvduVWIBBWBypIRj+g/9ZGljYo=;
        h=Date:From:To:Cc:Subject:From;
        b=oTmBjRWSiYf5TI40UFWvKvpfR7iwtcj9ReWAKOcRcRPnB6yyBuI5KDIV93J0cVL0C
         XwH6bchgs6eSrBOrudEzxkRGxHbfFiAPGfRFZAqc1DEXLarkttYUoM6wM9myQieCvx
         s7dbjFwgR1ZS+G55TXhf+Tf7wR3KS9WWzEFfaPsbsrL+ohaHilN/4brQGPCYziZHnQ
         OqkJUDCb6QdlFQQylfdGK0UTUqBM7Dey6+ud6IY72sPDqPnmcaa7DOd83xijmPU4Vv
         KO5RsfZ7Vk/bfRBG08ngZHhHrUvxfpmmOspP+3jwAXkOUBLVMB/z6s5tKgxZPGwi4D
         V7Ccylia8hDdQ==
Date:   Fri, 24 Mar 2023 15:44:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the modules tree
Message-ID: <20230324154413.19cc78be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0B=wHk3dPqZH4I.7o=M0uy6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0B=wHk3dPqZH4I.7o=M0uy6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the modules tree, today's linux-next build (htmldocs)
produced this warning:

Error: Cannot open file kernel/kmod.c

Introduced by commit

  d6f819908f8a ("module: fold usermode helper kmod into modules directory")

$ git grep -w kernel/kmod.c
Documentation/core-api/kernel-api.rst:.. kernel-doc:: kernel/kmod.c
Documentation/translations/zh_CN/core-api/kernel-api.rst:kernel/kmod.c

--=20
Cheers,
Stephen Rothwell

--Sig_/0B=wHk3dPqZH4I.7o=M0uy6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQdKp4ACgkQAVBC80lX
0GxQiggAmc5Pyfohi4u+cvjYveowzDP5aaJ+/Ojs7YBXH4EngoNHPW9rZna5p5h3
Kb6TEbJdpe1dqPnpqAStt+vn2/yWJ3Ge2kv3nQRa3d/iP2qvT7xgkTB8NsnIFUxc
T2mya2L3KOGzCv7fkZii49mIqWc+sM/QpCpCZF9ROvG0sXEQplIfJRZsTzOS84Dp
4abqjEjnQensi813Qhcsu8YHgzLkmPy6hOXlvwoUA69rc0TAhc7WVrZO9rxUQ1Vq
MeKJUnMROtPRaLXCrAlxNK4jlopmPHwTDS5CvsT7ZCIidoxiAgGTDf48KQftNlFD
KPaPcQk147vMen7uzhBscEMq+Nndow==
=5OCC
-----END PGP SIGNATURE-----

--Sig_/0B=wHk3dPqZH4I.7o=M0uy6--
