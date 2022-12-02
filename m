Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC3B6405EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiLBLiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbiLBLhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:37:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEECC44;
        Fri,  2 Dec 2022 03:37:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E86962277;
        Fri,  2 Dec 2022 11:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7995EC433D6;
        Fri,  2 Dec 2022 11:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669981067;
        bh=YewXzhIS8GyLTLE7PPwddgjQzKBIgxmttnLpVTqiblg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cm++C5xa4tPbx5jWoaJN6Z8Gn8yBsULaVlvS9EenvDLj3tBu1qotBlqgpFc1GbYle
         8p1RuOv+rUsLEpqOeE3OWHEA+9HqG4WI1jl7i8K5FTv0ljpjFH1un8Y2ZxIVxawpsy
         oQaESvOXmVR3Vasytk9X1A0sZuejOt2fwx1nW6E/4yng19flUEsE5TCJQMkhvYxcAZ
         TPVy7LvI/8NIHoZ7OrlSuFZXx5UCQpEgTAMj+xow5Kf42PHu6w0eC5rKA7WFI70dYR
         ArknVmEAjSyjamVj8pp1S04Sn7EvIOrbrBircUFpB18pmVtSadfEfGGsYGtTZG3TRO
         pxhBKT4qH59CQ==
Date:   Fri, 2 Dec 2022 11:37:42 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, ajones@ventanamicro.com,
        aou@eecs.berkeley.edu, corbet@lwn.net, guoren@kernel.org,
        heiko@sntech.de, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 3/3] Documentation: riscv: add a section about ISA
 string ordering in /proc/cpuinfo
Message-ID: <Y4njhrGft++1rVRj@spud>
References: <20221130234125.2722364-1-conor@kernel.org>
 <20221130234125.2722364-4-conor@kernel.org>
 <Y4gZ/KZz9rdYj/0r@debian.me>
 <Y4hjIWHTuYcf90ja@wendy>
 <66b3fd78-31bc-c435-ccc8-c8682b3cacee@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q5Y2pBB/5VxqMAhM"
Content-Disposition: inline
In-Reply-To: <66b3fd78-31bc-c435-ccc8-c8682b3cacee@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q5Y2pBB/5VxqMAhM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2022 at 09:14:08AM +0700, Bagas Sanjaya wrote:
> On 12/1/22 15:17, Conor Dooley wrote:
> > On Thu, Dec 01, 2022 at 10:05:32AM +0700, Bagas Sanjaya wrote:
> >> On Wed, Nov 30, 2022 at 11:41:26PM +0000, Conor Dooley wrote:
> >>> +#. Single-letter extensions come first, in "canonical order", so
> >>> +   "IMAFDQLCBKJTPVH".
> >>
> >> "..., that is ... ."
> >=20
> > Hmm, that reads strangely to me. s/that/which/.
> >=20
>=20
> OK.
>=20
> >>
> >>> +#. The first letter following the 'Z' conventionally indicates the m=
ost
> >>> +   closely related alphabetical extension category, IMAFDQLCBKJTPVH.
> >>> +   If multiple 'Z' extensions are named, they should be ordered firs=
t by
> >>> +   category, then alphabetically within a category.
> >>> +
> >>
> >> Did you mean "most closely related alphabetical extension category in
> >> canonical order"?
> >=20
> > I am not 100% sure what you are suggesting a replacement of here. I
> > think I may reword this as:
> >   For additional standard extensions, the first letter following the 'Z'
> >   conventionally indicates the most closely related alphabetical
> >   extension category. If multiple 'Z' extensions are named, they will
> >   be ordered first by category, in canonical order as listed above, then
> >   alphabetically within a category.
> >=20
>=20
> That LGTM.
>=20
> >>> +An example string following the order is:
> >>> +   rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
> >>> +
> >> =20
> >> IMO literal code block should be better fit for the example above,
> >> rather than definition list:
> >=20
> > Uh, sure? I'm not sure what impact that has on the output, but I can
> > switch to a pre-formatted block.
> >=20
>=20
> Something like ``foo``?

Not posting a v2 for another few days, but this is what I currently
have:
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/tree/Docume=
ntation/riscv/uabi.rst?h=3Driscv-uabi_docs


--Q5Y2pBB/5VxqMAhM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY4njhgAKCRB4tDGHoIJi
0nG3AQDN11twX+XbGwoN9/XYbdJzgY33yW3WXUGANYI/mtCVIwEA91AUTZo73nDi
o+yCNCSVVUcFUSw6gPxGDo39EVTHCwQ=
=8KH2
-----END PGP SIGNATURE-----

--Q5Y2pBB/5VxqMAhM--
