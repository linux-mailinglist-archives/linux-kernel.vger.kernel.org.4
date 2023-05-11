Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEC46FE90D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 03:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjEKBIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 21:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236569AbjEKBH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 21:07:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C1335A6;
        Wed, 10 May 2023 18:07:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QGtzr2gb8z4x41;
        Thu, 11 May 2023 11:07:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683767272;
        bh=XZSZUAZVLj2+UzRacgu3j7yyCTBTrxNnC4byOTcfx0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t1ooUHYsdcB+LhPqR7Ug9oT/QFkaKAZlk7iODnk/EM6CggoUdkTvplyYKWUOd8E2U
         ESLTA6sQgNCX+vzIiMIBQp2zGTuwUKUqW9E2WYOyQ68AjbDoIhlfnTZ7dIKmBSNjwz
         pa1ER/u0xqv5M4S2WuaWIcWEcpUY9rS9pIxwYdd2rWjnV4tHKI9iVteZhtX/D18H+n
         /SEEh7TD/ORjf1hWvWTj6QE8H03jQ7XJQ8In2PxCeM36828bTaeQq6aWjwAKRUiTjN
         uj5gzR1EVP8SVYw8Od6ROGd33vx+D9jh33jVFi4TOsP201Wf7CQYu8HPO9HAEcRx5s
         lnd5vRQOku91A==
Date:   Thu, 11 May 2023 11:07:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the block tree with the
 vfs-idmapping tree
Message-ID: <20230511110750.76a33556@canb.auug.org.au>
In-Reply-To: <b5c0b1b9-9896-2637-458b-ca1003ba7d74@kernel.dk>
References: <20230510105543.165f102b@canb.auug.org.au>
        <b5c0b1b9-9896-2637-458b-ca1003ba7d74@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zp6IJU1/hKF4ilVOf8xCEZ0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zp6IJU1/hKF4ilVOf8xCEZ0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Wed, 10 May 2023 06:48:39 -0600 Jens Axboe <axboe@kernel.dk> wrote:
>
> Yes, since Linus didn't like the original approach, it was redone
> and that particular patch was originally forgotten and then redone
> without the 'nonblock' variable. So you should just ignore the
> old version, and Christian should just drop that branch from his
> for-next tree as it's dead.

That appears to have been done now, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/zp6IJU1/hKF4ilVOf8xCEZ0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRcP+cACgkQAVBC80lX
0Gy3Kwf+K4TyZ3emIIjnNaQ4YcxjGKGUkUqZx9rUwUaghOF1di44YpcUoqXOJMl2
OUHbvrrJ4lFq+dn/1EgrrC6D2JkaQo6ukW5Qy1hb6KLXRshtXLdmDlL1JoVXgHMR
Gtl7RwXLDODiQMjDwZg5/DX+2rIkSpo71fV8EDn9TOzAH/6PgKn7SjYFrHjNJi6q
+MRL4dknOujdwrvuee4/yewEJKp01h5Px/OgZuZFHhmT2i/nK+96xx6hlAmDHXxZ
nM8+5D57peLheum2PReS6SVegMeoSsoz7dCAW1r5qmLDo0JC6jDsfPgybhwvfbi1
pf7HQve14XEaAKXE/1ZBZZs/UcFVxA==
=BgHY
-----END PGP SIGNATURE-----

--Sig_/zp6IJU1/hKF4ilVOf8xCEZ0--
