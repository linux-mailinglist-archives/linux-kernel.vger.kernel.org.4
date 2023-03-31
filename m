Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94EC6D157F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 04:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCaCOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 22:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCaCOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 22:14:16 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBE18A7D;
        Thu, 30 Mar 2023 19:14:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PnkPJ5sMXz4xDp;
        Fri, 31 Mar 2023 13:14:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680228853;
        bh=NpE/ZVmO3xm89zodeB5a+4PPfpRqJI47zIn0Q8XXhf8=;
        h=Date:From:To:Cc:Subject:From;
        b=LszhbWRHM8uaVbmW1MQBlCMkwh3OBtf3d9XaobBCb7SvFI5fPeTWS9Yxn4EkI4dy6
         FGcuLEQ+RWDR2gUINAeopIamA8qrwXN4wdwSKCg6QmyIJLpAexEr1yPePWbDHLN+zU
         RrqNE46aBg2tXx3VNNI2TndW1mvF7nLcnkBNc56wl/txNJbwRtSP1aUofSKJ6hux7V
         MUNxzMUUXyyYLgEcl6W7Ar+ZQ/9GVVEFTp8StMUbjPMzftdjqiV3fEos+qjw3pNDqO
         y2R0boinvr8LZ7EU+fvAi6LwlsSFlQCpcALT6t8kszbe7BU311GLMKejcOxqX8uV6c
         uqhFShhHGOv5Q==
Date:   Fri, 31 Mar 2023 13:14:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jianchunfu <jianchunfu@cmss.chinamobile.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: old commit in the unicode tree
Message-ID: <20230331131410.0cb9b3f8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1sgydZJB1YBqpQc1jBjSwqU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1sgydZJB1YBqpQc1jBjSwqU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The unicode tree (git://git.kernel.org/pub/scm/linux/kernel/git/krisman/uni=
code.git#for-next) contains only one commit:

  b500d6d7243d ("unicode: Handle memory allocation failures in mkutf8data")

that was committed in April, 2020.  Is this ever going to be merged
into Linus' tree?  If not, should I just remove the unicode tree fro
linux-next?



--=20
Cheers,
Stephen Rothwell

--Sig_/1sgydZJB1YBqpQc1jBjSwqU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQmQfIACgkQAVBC80lX
0Gxr9gf/XX8rXS9oEJsNtDkvoAzM1um+kmIcLE46i4D/HSsc2aGA73nxVkSPcUJs
EhJxyjBmrReaiSl8Jawr8gyCTWbeHDq69kugNc4Ipq7n5b9kxtoW7Fc47fnpuoHL
gnd1tBV2AJlEWKQOpafcOeMpMOUT79f1hdZq3RUpGvMt21u7i/gRKlu9uf68U5Ce
VTRmZQJRWB3X7VwOwhJ9B7n0a8ke3rwvz88x3zUZlzAL+K5Yl8Z8PIzbhJYKZuRc
wAJxXQM8WF3qWkNMJlL8fBiTUTVl2KKfwEYRog0wDVtC2ZSnyuvVfCOz0GXwSByz
tIJCcdx5WQFBsw6KCEnhYS0PAKyasA==
=Wk6Z
-----END PGP SIGNATURE-----

--Sig_/1sgydZJB1YBqpQc1jBjSwqU--
