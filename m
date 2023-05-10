Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C756FE7D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbjEJXAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbjEJXAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:00:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D578E64;
        Wed, 10 May 2023 16:00:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QGr8x67C8z4x1f;
        Thu, 11 May 2023 09:00:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683759634;
        bh=QzCFn1h29G/bL/3Cx7X3b+tfyK5M2OFZLl+RPDBwflI=;
        h=Date:From:To:Cc:Subject:From;
        b=Z0rVdoAWq9UibTNPKD71/nJ3Q+IjOlb/cwFNhD2m5xHJAVVDqGG82opnrC0fmP28r
         7+WZTAvclUWeE0x6sLnUX5dgUuad1gOtQl86hkMRcIWx+JAI7weC6gutqrNoA5CPCj
         wgERIQF8n9G8puNEDkYC2K2TCjvA5Uo9mhDJCux4C0glhcY3AslZ0GFDStdi8fFZgn
         nRAyRTldg5x0Bi7WVDLQ+SdJWCrNtA7C4xNDqmsJzUX4Vyq0ll43t7BjqagvYfc9kX
         JGBXHms5DCPRJsAvL97UgY/yopOQ08zPG2j42uGe6yswUUvwdOMPw7S40r3m0vDIV7
         1sJgt7+Xm/9Jg==
Date:   Thu, 11 May 2023 09:00:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the rcu tree
Message-ID: <20230511090010.2916e9d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cWMP8pMeBl8/GQPDZfDGahB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cWMP8pMeBl8/GQPDZfDGahB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the kselftest-fixes tree as a different
commit (but the same patch):

  6d9ed63d8bc3 ("tools/nolibc: Fix build of stdio.h due to header ordering")

This is commit

  d7eafa64a158 ("tools/nolibc: Fix build of stdio.h due to header ordering")

in the kselftest-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/cWMP8pMeBl8/GQPDZfDGahB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRcIfsACgkQAVBC80lX
0GxtVggAl58IIBbzXmmlw5jkg8O6jGeWQLan9BcXuw4YzxDGovpw4ghpKS61/lnB
WnyVn0UJfkWfuih0bhgH5Y0L1mkVjDxsuBLHLEl8m5cWHZYRMgPH2OH9Jw3bqPDV
TAGjnI7Be4m3Ez0L6KzWfuNYLdcrXi4zR1QuU7ZS90OA+7mvxO77Rx0dGN6apo46
lDW/2lnLfT0GKO7Xm4xdCLnkbwm/L7NVqCkaF1FrwnKpQhu7vcg8nWL4yB7yDfUI
ZOvwBoS0xdSjwjXkTX2sW738KL1xT3KbmVVI7utYGG18o/WJXlNxKlHAXng1tXuq
Jr8Oq2WuXitV9Ks/kIY9I0bo31XhQw==
=dS1F
-----END PGP SIGNATURE-----

--Sig_/cWMP8pMeBl8/GQPDZfDGahB--
