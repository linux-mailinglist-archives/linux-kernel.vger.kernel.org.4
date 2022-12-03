Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C05164162C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 11:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiLCK46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 05:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiLCK45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 05:56:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C143D907;
        Sat,  3 Dec 2022 02:56:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 728F660B9D;
        Sat,  3 Dec 2022 10:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88071C433C1;
        Sat,  3 Dec 2022 10:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670065015;
        bh=rPBLAbIQU5/KfDfhpmV4aB0A37Grw8nWz3gWe/n2IIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aUaIqTomeftDAKUaiw2KZ7m+Rp/8vsvmFj+DsFn7RYJ8gDFwi7uAPW9z9RlIxa2iy
         lP85bWV9vnGFdwBKuUSFY2fg6ts+L2KnctqLU0V8AXsH0MJw2W3M+33nQmy0x3W60v
         rYg0/dWBHQSrhTZ/vsKcBFnf/hrHsUWUe+bddhAFfbo3SOrYsf0Z61HuCwmZYTd6yu
         ZAM6dpHs5R2xLxzLB4Pcg3tPAD4id8Mc6jKSk8y2VvAOtHA+5VY9H68/Yv7n1poo6Q
         8ZKjI4ku6raLVgFS6d1Jq2z+4qHH7BHXrwSlYpa8d/lTSetDRXm+sSsbs1eHFmzCii
         vv4H3dlZdwnRg==
Date:   Sat, 3 Dec 2022 10:56:52 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: riscv: note that counter access is part
 of the uABI
Message-ID: <Y4srdBCmYJFx+ypW@spud>
References: <mhng-72f383f6-a85f-4587-9fa6-f85fb9f27ec8@palmer-ri-x1c9a>
 <87359wpy9y.fsf@meer.lwn.net>
 <87y1rooje8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cIOy0Str+DzswXPd"
Content-Disposition: inline
In-Reply-To: <87y1rooje8.fsf@meer.lwn.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cIOy0Str+DzswXPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 03, 2022 at 03:45:35AM -0700, Jonathan Corbet wrote:
> Jonathan Corbet <corbet@lwn.net> writes:
>=20
> > Palmer Dabbelt <palmer@dabbelt.com> writes:
> >> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> >> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> >>
> >> I think I merged the last one of these, but if the doc folks pick it u=
p=20
> >> that's fine with me.  Otherwise I'll take it when it comes back around=
,=20
> >> so folks have time to take a look.
> >
> > "Doc folks" applied it, thanks. :)
>=20
> Actually, I take that back.  I'd missed this part from the patch:
>=20
> > Based on an, as yet, unsent v2 of my other uABI changes. I don't expect
> > it to be applicable, just getting a patch into patchwork while I don't
> > forget about this.
>=20
> ...but b4 happily picked up a couple of *other* patches from this thread
> and applied them instead; I've now undone that.  Sorry for the noise.

Huh, I accidentally put an "in-reply-to" header on this patch. I have
been updating some of my submission helper scripts & I must have left
the field populated from sending another set by accident:
https://lore.kernel.org/linux-riscv/20221129144742.2935581-1-conor.dooley@m=
icrochip.com/

Apologies!


--cIOy0Str+DzswXPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY4srawAKCRB4tDGHoIJi
0iG/AP0XmMTWGZ5BNQ5fse4/Pi6ZWZLGRKm/cu2uJJeL1h5nvgD+LoVTVJjfsNBo
t+SdsF9w9KgG8q1LbGORN3MvXU0uQAQ=
=hMHg
-----END PGP SIGNATURE-----

--cIOy0Str+DzswXPd--
