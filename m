Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0401A69535E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjBMVsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBMVsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:48:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A53A17171
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:48:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99C6261305
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 21:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553BCC433D2;
        Mon, 13 Feb 2023 21:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676324906;
        bh=dBzZ22jsdFdLdurrZC+H3eiRkSsrYNJRRtthTIGeCIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E2XW7HexLTB5MVK0Hwhu22aA+t69bH1cBXSFHpSSqaAj+B2RC0bzXo7YfRou+xI2p
         B6CQtYkUUg3Y1pd4fBhCG0ZY8G7OjTa+6np/+RNPvOV9rxH5v3rtPTWIHgihKfxrce
         v240jfXFVHUvG1Ghumxjf7b755JvuUsL+jhxsf1gdfeik4Rhkdsi6W76RC/8EYHI8X
         zxvAV0pXccwlgJZGMjuENyYfyRwhWIYXLk/sjJU7GyKG9aTyqfeLwEYucnPFuGw40e
         suvWZO1KlLghebkoxIP+/wuuAxBUxYfw2LzoRSC2hLu/BVNwamDye0B3HMfeF4Ecg+
         fgUiY3jT/GQhQ==
Date:   Mon, 13 Feb 2023 21:48:21 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yimin Gu <ustcymgu@gmail.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v2 3/3] riscv: configs: Add nommu defconfig for RV32
Message-ID: <Y+qwJYI28c2fxnHU@spud>
References: <20230212205506.1992714-1-Mr.Bossman075@gmail.com>
 <20230212205506.1992714-4-Mr.Bossman075@gmail.com>
 <Y+qUVbhFUrb289xG@spud>
 <cd0faa52-fda9-7b8b-7ce1-8ad33236c430@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mzztALEEGMKUoCod"
Content-Disposition: inline
In-Reply-To: <cd0faa52-fda9-7b8b-7ce1-8ad33236c430@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mzztALEEGMKUoCod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2023 at 04:44:29PM -0500, Jesse Taube wrote:
>=20
>=20
> On 2/13/23 14:49, Conor Dooley wrote:
> > Hey Jesse,
> >=20
> > On Sun, Feb 12, 2023 at 03:55:06PM -0500, Jesse Taube wrote:
> > > 32bit risc-v can be configured to run without MMU. This patch adds
> > > an example configuration for RV32 nommu virtual machine.
> >=20
> > There's a patch on the list (I think it came in after you sent v1) that
> > pointed out that the rv32_defconfig in the tree is not actually used if
> > you do `make ARCH=3Driscv rv32_defconfig`, but instead a make target is
> > used.
> Oh that's interesting. Why is it still int the tree?

See that's the thing - the patch was deleting the rv32_defconfig file:
https://lore.kernel.org/linux-riscv/20230205133307.1058814-1-guoren@kernel.=
org/

> > How would you feel about replacing this final patch with the
> > below? That way rv32_nommu_virt_defconfig would always be kept in sync
> > with the rv64 version.
> Sounds good! The only gripe I have is the nommu_virt_defconfig is not very
> minimal, but that's not my problem.
>=20
> Thanks,
> Jesse Taube
> >=20
> > Cheers,
> > Conor.
> >=20
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index 7123511d977c..785d438ae5fe 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -173,3 +173,7 @@ rv64_randconfig:
> >   PHONY +=3D rv32_defconfig
> >   rv32_defconfig:
> >   	$(Q)$(MAKE) -f $(srctree)/Makefile defconfig 32-bit.config
> > +
> > +PHONY +=3D rv32_nommu_virt_defconfig
> > +rv32_nommu_virt_defconfig:
> > +	$(Q)$(MAKE) -f $(srctree)/Makefile nommu_virt_defconfig 32-bit.config
> >=20

--mzztALEEGMKUoCod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+qwJQAKCRB4tDGHoIJi
0k4ZAP4st6xMRa7BA43WyY+2Q6Ct8iGSkxtiWTM2xjYgFkLVjAD/YtuwVzSWD8ve
u5yDuBXniGRnpj9FQ+iAnX9FD46z6QU=
=v6Ue
-----END PGP SIGNATURE-----

--mzztALEEGMKUoCod--
