Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98B6609A92
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 08:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiJXGeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 02:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJXGeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 02:34:05 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E325C378;
        Sun, 23 Oct 2022 23:34:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mwlf11YZBz4x1V;
        Mon, 24 Oct 2022 17:34:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666593242;
        bh=3eIP8TJRgX3pfB62JavefRCci5PsgV1Uc3dFFxPAOPU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nm2X4A/tccyE/53hOASvlOPGa4dVwgMemuut/bMuFtLozRGdhLMG6cgzmxEwdob7T
         Lf96GZ+YRJ9MbdzlKK9RZI+0riQJUbqSuVK3W7HkbpPnJ16Bvloy1AjGaQBuhb1s71
         S1Nllt5zKnFAhs9p8qXhoktZ61KenrzN9nZdQd7CtTa36xCH/VE7p1F7W2a/gmLBJ+
         516srarOsHOmy3HmW72Imy0nf5KE6iYQh6GHKsuxMWlBfEoD67rZRRupQUscaHM3AQ
         MRE6aTDv9p+8XHOOn+bgpqNayHibOS4DyaQpENSgx/QK+CJlEWpXjmJHBi8NLgobRf
         pew0AaWqApgPw==
Date:   Mon, 24 Oct 2022 17:33:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the random tree
Message-ID: <20221024173358.43de55f6@canb.auug.org.au>
In-Reply-To: <Y1YUhaHXpMV80gQO@zx2c4.com>
References: <20221024132319.4b3910ad@canb.auug.org.au>
        <Y1YUhaHXpMV80gQO@zx2c4.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/83c648kI+Dlm_h3XYGb8NOb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/83c648kI+Dlm_h3XYGb8NOb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Mon, 24 Oct 2022 06:28:53 +0200 "Jason A. Donenfeld" <Jason@zx2c4.com> w=
rote:
>
> I'll remove the removal commit for now and will plan on handling that
> separately at the end of the 6.2 merge window.

OK, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/83c648kI+Dlm_h3XYGb8NOb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNWMdcACgkQAVBC80lX
0GxImgf7BB6rs/X6unMpvO0EcNeGWymZSA9Z2/UgCw1Bdej+iGrj2yHTMvTfR/PE
+LAbBhvgNhijQYBYbZkyWssootUS7j72bPHqdW5wKThtlU7lJbHK6qsrug6xGClL
lBpPRUIk/ZnnwyxPcnej57rfTU2jxZLOoIFf3+E9JwT4KPaCneAINFzZSt2rNOBk
K594M6ewWMxaj/i2MapMK6B2nBWu0mMPn5evYw9klilfUGgDTIQYS3iUl9uptnZS
6zZVJNt+Bzb1pIaggyrVsHrdzb7ZL57jN4v4wqT5uRabiNcbgm+YMG+Dgv6/Qdgm
zzHNxW4geD4H8MCBp7igchGD/CsXIg==
=OCAP
-----END PGP SIGNATURE-----

--Sig_/83c648kI+Dlm_h3XYGb8NOb--
