Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF4774A504
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 22:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjGFUnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 16:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjGFUnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 16:43:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B346D19A7;
        Thu,  6 Jul 2023 13:43:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33860612D7;
        Thu,  6 Jul 2023 20:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D73AC433C7;
        Thu,  6 Jul 2023 20:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688676189;
        bh=3PI2BGyiYdsp+NcKWjPsSpXQxXQ/ceNISunVsaOciJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nle0wMHXa9utYvBhOLPBBhlVo+LcZLEHJIcl7Tqo26gEp98Xah+TYoWCC4b0Wole9
         WjQBXap0Y7eiY55GZvtqNo/LYDjgMeoyNsVpFqy3ykmIyg9wwTzPheZvI9crTZCi25
         S4o5SR8ea5ejjBNcEwiVz+5vpXZzf5ph1SJ1/2WfJe0lnpu9mFoG/NlaMo+ACUUGhE
         I7ehmyXjpLL04rNQ3aMKP+EXcZVBaZzBk30LHH2Xppetz2PZqz1GJYZeBNbC54qmsZ
         qq9+IbfXn/qw6dQ279RiFkBG59lyfD0pU0pGvrLFjyjqCsCNdkQgrwY/nx2WVHCPA7
         dEj0OjWLH1ImA==
Date:   Thu, 6 Jul 2023 21:43:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, evan@rivosinc.com,
        heiko@sntech.de, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] RISC-V: Framework for vendor extensions
Message-ID: <20230706-decode-snub-3ccf842d0861@spud>
References: <20230705-thead_vendor_extensions-v1-0-ad6915349c4d@rivosinc.com>
 <20230705-thead_vendor_extensions-v1-1-ad6915349c4d@rivosinc.com>
 <20230706-curly-swinging-afbf79a4cdb7@spud>
 <ZKcbJ9MEP/pBx39J@ghost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OYvwyku6mIIYmpsy"
Content-Disposition: inline
In-Reply-To: <ZKcbJ9MEP/pBx39J@ghost>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OYvwyku6mIIYmpsy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2023 at 12:51:03PM -0700, Charlie Jenkins wrote:
> On Thu, Jul 06, 2023 at 06:15:57PM +0100, Conor Dooley wrote:
> > On Wed, Jul 05, 2023 at 08:30:17PM -0700, Charlie Jenkins wrote:
> > > diff --git a/arch/riscv/Kbuild b/arch/riscv/Kbuild
> > > index afa83e307a2e..bea38010d9db 100644
> > > --- a/arch/riscv/Kbuild
> > > +++ b/arch/riscv/Kbuild
> > > @@ -3,6 +3,7 @@
> > >  obj-y +=3D kernel/ mm/ net/
> > >  obj-$(CONFIG_BUILTIN_DTB) +=3D boot/dts/
> > >  obj-y +=3D errata/
> > > +obj-y +=3D vendor_extensions/
> > >  obj-$(CONFIG_KVM) +=3D kvm/
> > > =20
> > >  obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) +=3D purgatory/
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index c1505c7729ec..19404ede0ee3 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -276,6 +276,7 @@ config AS_HAS_OPTION_ARCH
> > > =20
> > >  source "arch/riscv/Kconfig.socs"
> > >  source "arch/riscv/Kconfig.errata"
> > > +source "arch/riscv/Kconfig.vendor"
> > > =20
> > >  menu "Platform type"
> > > =20
> > > diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
> > > new file mode 100644
> > > index 000000000000..213ac3e6fed5
> > > --- /dev/null
> > > +++ b/arch/riscv/Kconfig.vendor
> > > @@ -0,0 +1,3 @@
> > > +menu "Vendor extensions selection"
> > > +
> > > +endmenu # "Vendor extensions selection"
> >=20
> > These files don't do anything, don't add them until you need to.
>=20
> I wasn't sure if it was more clear to split up the vendor extension
> framework from the T-Head specific calls since the main goal of this
> series is to propose a vendor extension framework. I can merge this with
> the following patch.

Yeah, don't add files that you are not using, until the patch in which
you need them. Say we had to revert your 2/3 patch - we'd be left with
dead files in the tree.

> > >  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> > >  			     const struct cpumask *cpus)
> > >  {
> > > +	int err;
> > > +
> > > +	if (((unsigned long) pair->key) >=3D RISCV_HWPROBE_VENDOR_EXTENSION=
_SPACE) {
> >=20
> > Hopefully Bjorn or someone that actually knows a thing or two about uapi
> > stuff can chime in here, but I think what you are doing here (where the
> > vendor space sets the MSB) really muddies the api. These keys are defin=
ed
> > as signed 64 bit numbers & -1 is the value set when a key is not valid.
> > I'd much rather we kept the negative space off-limits, and used the 62nd
> > bit instead, avoiding using negative numbers for valid keys.
> >=20
> Yeah that makes sense, I can change this up.
> > > +		struct riscv_hwprobe mvendorid =3D {
> > > +			.key =3D RISCV_HWPROBE_KEY_MVENDORID,
> > > +			.value =3D 0
> > > +		};
> > > +
> > > +		hwprobe_arch_id(&mvendorid, cpus);
> >=20
> > I think this needs a comment explaining why you do this hwprobe call,=
=20
> > > +		if (mvendorid.value !=3D -1ULL)
> > > +			err =3D hwprobe_vendor(mvendorid.value, pair, cpus);
> > > +		else
> > > +			err =3D -1;
> > > +	}
> >=20
> > I don't really understand the control flow here. Why are you continuing
> > on to the switch statement, if you have either a) already ran
> > hwprobe_vendor() or b) noticed that mvendorid.value is not valid?
> >=20
> The purpose of this was to consolidate the error handling to a single
> spot at the bottom of the file. It would fall through the switch
> statement and set the values appropriately. I guess it does seem a bit
> awkward.

Use a goto? It seems to do exactly what you want here.
You could also define err as -1 to begin with, and drop the else branch.

The other limitation of this stuff, while I think of it, is that you
preclude more than one vendor implementing an extension.

> > >  	switch (pair->key) {
> > >  	case RISCV_HWPROBE_KEY_MVENDORID:
> > >  	case RISCV_HWPROBE_KEY_MARCHID:
> > > @@ -217,13 +243,21 @@ static void hwprobe_one_pair(struct riscv_hwpro=
be *pair,
> > > =20
> > >  	/*
> > >  	 * For forward compatibility, unknown keys don't fail the whole
> > > -	 * call, but get their element key set to -1 and value set to 0
> > > -	 * indicating they're unrecognized.
> > > +	 * call, instead an error is raised to indicate the element key
> > > +	 * is unrecognized.
> > >  	 */
> > >  	default:
> > > +		err =3D -1;
> > > +		break;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Setting the element key to -1 and value to 0 indicates that
> > > +	 * hwprobe was unable to find the requested key.
> > > +	 */
> > > +	if (err !=3D 0) {
> > >  		pair->key =3D -1;
> > >  		pair->value =3D 0;
> > > -		break;
> > >  	}
> > >  }
> > > =20
> > > diff --git a/arch/riscv/vendor_extensions/Makefile b/arch/riscv/vendo=
r_extensions/Makefile
> > > new file mode 100644
> > > index 000000000000..e815895e9372
> > > --- /dev/null
> > > +++ b/arch/riscv/vendor_extensions/Makefile
> > > @@ -0,0 +1,3 @@
> > > +ifdef CONFIG_RELOCATABLE
> > > +KBUILD_CFLAGS +=3D -fno-pie
> > > +endif
> >=20
> > There are no files in this directory, why do you need to do a dance
> > about relocatable kernels?
> >=20
> This is framework for the following patch in the series. I saw these
> lines in the errata Makefile so I created this Makefile to set up the
> following patch in the series. I can merge this patch with the following
> patch to make this series more clear.

The errata code gets called super early on, so it needs it. What you
have here does not. We want to remove it from the errata Makefile
anyway.

Cheers,
Conor.

--OYvwyku6mIIYmpsy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKcnWAAKCRB4tDGHoIJi
0mupAQC6ECf2yHm1pNuFe6s0GK2zdRQTq6kkAOceDcR9OAvPsAD/WURPSMWbBRYN
MO9cTHjqrmlEa2csS3I6ONsoGzqU4gA=
=F2R7
-----END PGP SIGNATURE-----

--OYvwyku6mIIYmpsy--
