Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E987154EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 07:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjE3F0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 01:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjE3F02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 01:26:28 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2C1EA;
        Mon, 29 May 2023 22:26:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QVgqK0h7rz4x2c;
        Tue, 30 May 2023 15:26:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685424382;
        bh=Qugt1Tk2BjDvxKJ01WVZs3TUzuT5I7W3h1n+/2K7BZM=;
        h=Date:From:To:Cc:Subject:From;
        b=JIP6J4XG2Kz+hsxhmzMT7dM2RroyFMeGgPJ8f5jMf6PtSjpTm+k9tRBrQoqbha7mC
         pRSRNlxWelu3tX15dC+Th+34pAaOYAVxtaEogBT2//cSgwGLK4KBgH4AUXxF5p9ZxD
         PTqjs17l2YA3OU04UR5N0wG+lhMNf/2SaMUmlYjyD1X5r2hTZPlPaoflHSdTO3DP5F
         IT+NNsOFAhjvU3f/twhhEr/xWob+87e3WhUpzvOI2nxiK2s0oiebld0/aFBfIf6uCQ
         l0LLdRc8zUDd9vmtk8AFP2uR7KiHvV5z7iR/9TzQ1L1LlBOMK2x4lGbn3mnXXa1h25
         g7muAc3YDfswA==
Date:   Tue, 30 May 2023 15:26:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning in Linus' tree
Message-ID: <20230530152618.2d61a5da@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kfl11/wQXWGmu80EInJEuFA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kfl11/wQXWGmu80EInJEuFA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In Linus' tree, today's linux-next build (htmldocs) produced this warning:

include/media/v4l2-subdev.h:1130: warning: Function parameter or member 'cl=
ient_caps' not described in 'v4l2_subdev_fh'

Introduced by commit

  f57fa2959244 ("media: v4l2-subdev: Add new ioctl for client capabilities")

I am not sure why this only turned up today.

--=20
Cheers,
Stephen Rothwell

--Sig_/kfl11/wQXWGmu80EInJEuFA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR1iPoACgkQAVBC80lX
0Gx0LwgAm6w3adSRxkawh/GZxrsIgfQE2IaYDNLQ6JzCg61/p35+ZwX0eihPfBmk
jP1T3R93h6i9EihXDo2pCfKAYc1Eb7sQ1PmY3UeWN981zFmS/OCYLhK0zKHlj1vf
i6ulrb3nD1YqOoEhKVbWdrJlU7SzMBDrr5xV4Dia6l+awYmxvIEoJRPWjL5YKUPW
PW3xWIFhWrrIRpcj0j29IuEyVI1exib3LpEufR1qDqKtgifqaW2r7eHa5yQKGPg+
4oE819ayztH9n/KmqnYYX/ybjYH/wnPHdpbsH3uOaMvQLtbhITXZ69j+IgzVie4d
CPUDU3Ywr1LG2rxYZa+UsnWt21/Gkg==
=9vbj
-----END PGP SIGNATURE-----

--Sig_/kfl11/wQXWGmu80EInJEuFA--
