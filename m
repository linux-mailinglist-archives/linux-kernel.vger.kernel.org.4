Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E54685F0A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 06:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjBAFhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 00:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBAFhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 00:37:20 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC83453E4E;
        Tue, 31 Jan 2023 21:37:18 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P69fK4GxFz4x1S;
        Wed,  1 Feb 2023 16:37:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675229834;
        bh=kapy6U1iqS5EQIskebYq13LmQ07B6ujHYfriERONEXQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R/WnssNQhNX73eMWsvq6FTfHhaUN/C/lhtpwYXo3f8J27Qd8HL/JLD7V6CX26j6tG
         MtTXbvV2oi8JFFAtOoO0CZRbXm/PNG4kKvcTDNX/x9nFQbz3TyXsTaiJxD8yM4Q/IV
         eGEbTz7JWzw+QAWOf7AfX2ZpkwKDEOuhPD5XdrAC8A2DzyJXsAqGh0tUzq6CY5mMZX
         kiV04nl0fQJ4ZrFWUFUxHy23mo3EQoPB3ZYTG0ibI06wGvjJ1GQZycIoTzxCJSJ6GO
         BDJd9FQLDGADFzRk6pLCGCrYngs/swcEIaCfdhVBjE9r690ZuAdVc/5TKjTFRpcA9E
         KLWPwze2HpzPA==
Date:   Wed, 1 Feb 2023 16:37:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the kunit-next tree with the
 kunit-fixes tree
Message-ID: <20230201163712.4336d3a1@canb.auug.org.au>
In-Reply-To: <CABVgOS=SRvs6fcNzbfDnR=p91TwdKiX5NBeLSCx3FPMCEbzU5A@mail.gmail.com>
References: <20230201134941.46b02711@canb.auug.org.au>
        <CABVgOS=SRvs6fcNzbfDnR=p91TwdKiX5NBeLSCx3FPMCEbzU5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cacTfJJmz./29rDCTs0UjNS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cacTfJJmz./29rDCTs0UjNS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Wed, 1 Feb 2023 12:31:49 +0800 David Gow <davidgow@google.com> wrote:
>
> As you noted, the "hooks" patch is meant to supersede "kunit: Export
> kunit_running()", which is really meant as a fix for older kernels
> which won't get the "hooks" patch.
>=20
> I imagine we'll rebase this once the fixes go upstream.

Or just merge what you ask Linus to merge, for a minimal change.

--=20
Cheers,
Stephen Rothwell

--Sig_/cacTfJJmz./29rDCTs0UjNS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPZ+ogACgkQAVBC80lX
0GwDFwf/XgDnfYlBcpjsG7a13zUvBFZYnjr+bF63Qf/Y81tb8NgIO2MoTx4Aa58c
H9yTmuNumKfwOP1lVQiMuLeqpr40248qR2JSKi+6wngDsVgkwEr6gHPDiPZcpB6e
mu3jSexWoq1lNP/W4AzuDkNPXJVTyO/k510qiY7nqSAvXGcGrwlcSSUA/7XYR0+y
sh/wESUHZrRLvF/YeVgrQabwlYOFYZc9gYs+n8u1ypnvE6s/oHJBMpvDr/WI0vEW
CQC+cxy6Dl3ZTw02FYfue5COCNfDB7UHkVjhAiulncXOqtktXt/tF1Ah/yAzQ9DA
aoDBnQBXT5IYr6biVpxjpDCpCkI0Nw==
=J2Wt
-----END PGP SIGNATURE-----

--Sig_/cacTfJJmz./29rDCTs0UjNS--
