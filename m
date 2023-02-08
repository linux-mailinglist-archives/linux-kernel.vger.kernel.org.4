Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4171768F328
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjBHQ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjBHQ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:28:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E1F48A2C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:28:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 816E261728
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 16:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93BCC433D2;
        Wed,  8 Feb 2023 16:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675873723;
        bh=C7+N9mRaBPOFc2SBvsjZMyh3t4Zdy9AIEyoV7hwJ0gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GgZ54k/UjrcxZLbOevM41Jpx8L/10l4ULONIL5wr8WRLjzeLJ9NnytMYyiaZjZg2F
         R4cntQYSBX6y4/UFrIlT+FlCPhfkvlS0fGvMbcTvrdnE86bc51fOm/YrSwYpSFX7Kv
         biwW2Wk8OHWpl7tFnE4zpaAk+YmSgnGLo1H9TQkYtZazhEYUqAgJfFHZK8fSPjreJ1
         4tTE9mIJmz2MSnjjCl4nxEFSQeKfcUGzaWKHd37Ro646Xtt97fj3l1RRGpznhSNbfJ
         /MCCcAAwAsEsCVoVDpExpJBfBCTKI4BIbpMKQvpB0WxpXH+tbl5h6KJNquTbqj/ipI
         I+7KeCI5yQ0UQ==
Date:   Wed, 8 Feb 2023 16:28:39 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Trevor Woerner <twoerner@gmail.com>, palmer@dabbelt.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS: update Allwinner sunXi SoC support entry
Message-ID: <Y+PNt8JObYK5WZKb@spud>
References: <20230208142841.19597-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qb4K182P4OIRGlj0"
Content-Disposition: inline
In-Reply-To: <20230208142841.19597-1-twoerner@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qb4K182P4OIRGlj0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2023 at 09:28:41AM -0500, Trevor Woerner wrote:
> Update the information in the "Allwinner sunXi SoC support" block:
> - include more RISC-V information
> - move the block to keep it in alphabetical order
> - "L" before "T" (as reported by checkpatch.pl)
>=20
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

> -ARM/Allwinner sunXi SoC support
> -L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -L:	linux-sunxi@lists.linux.dev

> +ARM/RISC-V/Allwinner sunXi SoC support
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +L:	linux-riscv@lists.infradead.org
> +L:	linux-sunxi@lists.linux.dev

IIRC having the arm list is needed here because the arch/arm{,64}
entries specifically exclude the dts subdir. RISC-V doesn't do that
though, so adding the list here is mostly redundant.

Not that it matters for this patch, but might be worth doing for the
RISC-V entry at some point.

Also Trevor, I was about to send the above but noticed that your CC list
is a bit odd, changing the maintainers entry without CCing any of the
maintainers listed in it!
I assume you ran get_maintainer.pl & there was a regex match for riscv
in it, so only got Palmer & co.
I've added the sunxi folk to CC & depending on workflow they may ask you
to resend this.

FWIW if you lot use b4, the msg-id is:
20230208142841.19597-1-twoerner@gmail.com

Cheers,
Conor.


--Qb4K182P4OIRGlj0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+PNtwAKCRB4tDGHoIJi
0kDIAQDWdvyj262sL9izmrDv21mnh+0Sis8AAtWRYHpiSnBjCwD/YCGSzHggTMcl
sFZp9o8YamSATf2K1K7j1rqb3M4tJgA=
=i4oP
-----END PGP SIGNATURE-----

--Qb4K182P4OIRGlj0--
