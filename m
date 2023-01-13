Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E4966A559
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjAMVwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjAMVwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:52:12 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0D910FEC;
        Fri, 13 Jan 2023 13:52:10 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ntw9v5ZZmz4xGM;
        Sat, 14 Jan 2023 08:52:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673646726;
        bh=RxeRAYswbnUK0H5CEMGCbTuBQWWxqAX388X15Xp37iE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l2Gh/0PrHTOUIlo5ZI35+zbf5UYMrVMx/7OKs47BE012qPDyyRpeGbGTJYFNmxoSL
         pCGMwEm0/z6YA9plawdyreiFYhsQTuBihxW6XMSX7i2sK5mLeFGz8XRkQcTEiGtdRu
         qc6VOGUOJXJlrK1pR+0Y9ttI2ij5FXgx7LzqYbolVL1yLNvb1rsa+R3kA3CcLaCLPw
         /LZURVgfmq8NRPLUTOwKq4GYY0LC5/Ix2F5YkHyDYEIBaiK3TBl0jMTcgLsFBrJZRS
         xpPj5yn48imvQWIZSvbpfZ4oTMKZkpm2SInuNmaMx6XIGu65DHQeqcVwDXMo0i3hoD
         zZniDeVHWMrDg==
Date:   Sat, 14 Jan 2023 08:51:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the tip tree
Message-ID: <20230114085153.59c0866e@canb.auug.org.au>
In-Reply-To: <87358es8lh.fsf@meer.lwn.net>
References: <20230113124053.5a75633d@canb.auug.org.au>
        <87358es8lh.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+wzkIZRyY4fGas17gqIax=B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+wzkIZRyY4fGas17gqIax=B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jon,

On Fri, 13 Jan 2023 09:27:38 -0700 Jonathan Corbet <corbet@lwn.net> wrote:
>
> I'm sure I checked before applying that ... I guess maybe not.  I've
> disappeared it now, thanks.

You may well have checked, both commits appeared in linux-next for the
first time yesterday.

--=20
Cheers,
Stephen Rothwell

--Sig_/+wzkIZRyY4fGas17gqIax=B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPB0nkACgkQAVBC80lX
0GyOtgf/SI4G/W5kptF6GeC79HPNjVeGa2vyJRrm0143M9qZ97RSNf1sgnsH+A5q
RC1Cpjb7jl0CHtBrdko7EPgsxoCGhSGgzsEaOHaNw06DK+PPsUP4VscLbAfv9D5w
klc6EI2Ms4jYUKI2QnIWXapaKWxwO1WoYAWzydxRx8/w++j36jJyg32NSo+s8o4a
dXpgFkriGGh9ATUXX78Rulppmoauie8uisajIBDoFVfxEetiMpabiS6dbRMmf3wb
RRTLbYIYrvfIwI3zxq0to0hSC1wX/j1E6PbNjUQuv7f8fRBPt96kwedyNPU8n4H5
fc3vJp8Y0LJ43HnQj4vk+DaltzaGuA==
=7/7H
-----END PGP SIGNATURE-----

--Sig_/+wzkIZRyY4fGas17gqIax=B--
