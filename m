Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE4C66B53D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 02:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjAPB2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 20:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjAPB2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 20:28:47 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC0D5BBC;
        Sun, 15 Jan 2023 17:28:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NwDtz00Hgz4xyB;
        Mon, 16 Jan 2023 12:28:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673832523;
        bh=2JQwmdONR49qLSV63BLUZCr8jhKJZ1RZqRrqhd3tLgU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E6C1g/JOPpyoqtrX23Hgy+hd8z96UsmXkQ9Xx7Rakfi1Q1I5ICFKRNM7oF1/Pr5OY
         s78MmO7+8vCflfM3eQE8h4czBpOQrhyBPdycuklMwGWE8YfCdHwtxMkHIDil2aB4f0
         OB7bxM4Jt+bHoTrYZPR7o1FhRh8rCr9BOqdURLBbeYHWxV2kMvLPBh4lBTMBhIDuqd
         rcsKLBwZel5o+7SzX1e5ev14cIOMQAroxwz1Cq76XWesbHtu9Xk9Jo7GNRf89XF0Q8
         cpQHicc5OhnXQINysl7KRuXUGpc4vo6zxUxt9dfB6mX4qMeS9I6y5epzf01tKzLtkI
         4wG2K+PUtPDrw==
Date:   Mon, 16 Jan 2023 12:28:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: linux-next: manual merge of the rcu tree with the tomoyo tree
Message-ID: <20230116122841.67cbc7fc@canb.auug.org.au>
In-Reply-To: <20230111111439.4c4745d2@canb.auug.org.au>
References: <20230111111439.4c4745d2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Exd0zAR3QVCHs4ILx9Fy6VI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Exd0zAR3QVCHs4ILx9Fy6VI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 11 Jan 2023 11:14:39 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the rcu tree got a conflict in:
>=20
>   security/tomoyo/Kconfig
>=20
> between commit:
>=20
>   80f8be7af03f ("tomoyo: Omit use of bin2c")
>=20
> from the tomoyo tree and commit:
>=20
>   ed87f6865857 ("tomoyo: Remove "select SRCU"")
>=20
> from the rcu tree.

So the rcu tree commit is now duplicated in the tomoyo tree (but
slightly different due to the bin2c commit).

--=20
Cheers,
Stephen Rothwell

--Sig_/Exd0zAR3QVCHs4ILx9Fy6VI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPEqEkACgkQAVBC80lX
0Gx78wf/T/IlJR9wx9whzkc/tXn2OScn+S9ZFKoMzdhvF+p7gNBWddR50+Eze++g
t+AT8prQqroQpjLRuWvx9SgXo/nHppLvA7C4xqXxLzmH6JwOAFCyJOpoMa9ldPOM
6Ul7CrAjjtfwnOQKaC/5rbh1igxdtyCp4Q9D0o0cguDPvQPPvBUvyJZ6LOC0s22z
fafq7D+UlVgYKsEgn4RS9BhsY3bcxkwGWmqIuORo4Y1Km6xI7PCaDYV0WOdpdQO7
N7Glh6qjh/vcUJz7yHeJtVMzPM4n0fimrmalaj0+4qiq1/yGIr35Uta+Cp6M0JkU
bgL6KHL8Mqe6FU1gwK3U3Yh5txPbYg==
=kom3
-----END PGP SIGNATURE-----

--Sig_/Exd0zAR3QVCHs4ILx9Fy6VI--
