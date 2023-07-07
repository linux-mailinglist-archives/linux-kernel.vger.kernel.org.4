Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90C774B4E1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjGGQHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjGGQHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:07:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314611BF4;
        Fri,  7 Jul 2023 09:07:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEB46619FE;
        Fri,  7 Jul 2023 16:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41006C433C7;
        Fri,  7 Jul 2023 16:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688746033;
        bh=QEScL6yilSc3ZviTbMvKU7KFSvkrD3Pa7MP8T7mfDDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dw8avhov4Eg5IA9vDOeqV0k2C7KF/9OYCZ/NfWbqADZgVnuk7e1Q+qtrqkHInKieu
         tvGNBnJMXGLcRxvePqIWTIV+pX1tgRTddXtXSF5hRW8z/isGnKuWMAyUoa523t0Hge
         1q9fnMsp33C1btALoA2WWoJe40x0WwFhtO+rgggRPQNNtskg57ItuvOF8XY2HSg+oc
         U0Ks0QSYMH2DNGSXPw5HJrAssmc6s7BUOyoVfmnJ+qWTVILdGuYSp105liHsVFhkUM
         /sQi0y7SQ2hKtAKhEjbJZ4u2Y2uMMpTiNgecMdpeX5jk260C3695Psi/ATOpn/9qAT
         BFS4WP7c3yAsg==
Date:   Fri, 7 Jul 2023 17:07:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?utf-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>
Cc:     Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        ron minnich <rminnich@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Ard Biesheuvel <ardb@kernel.org>, cuiyunhui@bytedance.com,
        jrtc27@jrtc27.com, kernel@esmil.dk,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, weidong.wd@bytedance.com,
        Dong Wei <Dong.Wei@arm.com>
Subject: Re: [External] Re: [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from
 FFI
Message-ID: <20230707-gargle-enjoyable-f9f7f87fc7ea@spud>
References: <CAMj1kXFZren0Q19DimwQaETCLz64D4bZQC5B2N=i3SAWHygkTQ@mail.gmail.com>
 <mhng-b66b085a-eb15-4c9b-b2aa-93ddf16ec7aa@palmer-ri-x1c9a>
 <CAP6exYKwZG=_47r0jAUFYNL5-P-SS==k6vWdKiMJ9nB0upH5Zw@mail.gmail.com>
 <20230707-attach-conjuror-306d967347ce@wendy>
 <ZKfsSsdiso0W8mW6@sunil-laptop>
 <CAN3iYbMhQU5Ng4r6_rQDnLmit1GCmheC5T49rsUP5NgHFEXsHA@mail.gmail.com>
 <ZKgLKvBoWKSxzm6r@sunil-laptop>
 <CAN3iYbOe+i4jVhz0sSQwVQ2PMB7UvaTPyN_sLtZj0uiOD2emDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3EWyQYVnHmvcjPCl"
Content-Disposition: inline
In-Reply-To: <CAN3iYbOe+i4jVhz0sSQwVQ2PMB7UvaTPyN_sLtZj0uiOD2emDA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3EWyQYVnHmvcjPCl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Fri, Jul 07, 2023 at 11:56:48PM +0800, =E8=91=9B=E5=A3=AB=E5=BB=BA wrote:
> On Fri, Jul 7, 2023 at 8:55=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.co=
m> wrote:
>=20
> > On Fri, Jul 07, 2023 at 08:05:48PM +0800, =E8=91=9B=E5=A3=AB=E5=BB=BA w=
rote:
> > > Hi Sunil,
> > >
> > > From Sunil:
> > > IMO, if the question is generic like "Is UEFI mandatory for RISC-V?",
> > > the answer will be solid "no" because we can use DT without UEFI. But=
 if
> > > you ask whether UEFI is mandatory for ACPI support on RISC-V, then the
> > > answer will be "yes".
> > > ---- Why UEFI is mandatory for ACPI support on RISC-V?  As we know, o=
n X86,
> > > ACPI works well without UEFI. Is there any limitation on RISC-V
> > > architecture?
> > Yes, the limitation is RISC-V can not use IA-PC BIOS. Please see
> > section 5.2.5 and 15 in ACPI spec.
> >
> > I don't have much to add to Ard's reasons.
> >
> > https://lore.kernel.org/linux-riscv/CAMj1kXFZren0Q19DimwQaETCLz64D4bZQC=
5B2N=3Di3SAWHygkTQ@mail.gmail.com/
> >

> I don't think that's the limitation on RISC-V. BTW, how does OSPM find the
> RSDP on ARM systems? Does it meet 5.2.5?
>=20
> Here are
> 1. Purpose: purpose is to provide another option on Firmware Solution; Our
> purpose is NOT to ban UEFI.
> 2. Both ARM and RISC-V starts from UBOOT solution, and that's close to
> coreboot, so we would like to enable flexible and rich ecosystem.
> 3. We don't like to push coreboot and UEFI together, so we don't plan to
> enable UEFI in coreboot(maybe from Uboot); because that makes the solution
> complex.
> 4. I think we should fix the request and problem, banning or protecting
> something is NOT the goal of us.
>=20
> I think the solution is for both RISC-V and ARM, and also it works on X86
> if it's done.
> Let me know what the problem and impact is, please.

If you are going to keep arguing this, please stop sending top-posted
HTML to the mailing list. It makes it impossible for those not in the CC
list to follow along.

Thanks,
Conor.

--3EWyQYVnHmvcjPCl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKg4KQAKCRB4tDGHoIJi
0lY3AP41L09JSLOtY+QPj1ZlQioIBJzEht6NkN01HubykTSJ/wEAuE3fkJOEDEZ7
OvvPsCFCqhBpUQ5yg6m+6Cgpu/1CCAw=
=EfKt
-----END PGP SIGNATURE-----

--3EWyQYVnHmvcjPCl--
