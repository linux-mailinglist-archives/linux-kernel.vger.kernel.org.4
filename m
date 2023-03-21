Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2537D6C3591
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjCUPYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjCUPYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:24:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E16A1B2CE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679412271; x=1710948271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aMLLh8V4kf7c9ciTlabKLcKZtNVTiRpS6IoNs5kWFIM=;
  b=utSm9+yxu/Cme58DVnjcRnFqYQ9DPloTnxt/8F7BCDFTBBWaj7NDvgVQ
   QqcbIUpwV9KunAzbNFLRMqycAOLXJ6QiZlLiROCnms45TASVk5Cwv6MHX
   fzzurIZKdqxJtyujfXyLnQGNYawhBEtXCmF8j+x9ZBK4cIaF6bJrFPJti
   We407WBdwWaK+/UlKWlY1/oXBoekHXPn/+i3Oc9FmJx2JbG7NS0njQzKE
   WPa3fJBkn7oHrtFTo9sZBmwERkTy6Zb8BYdhDb89lmmc4XLwows61Knqk
   fIdRG5sVlMsGbmwDDVqGOkZsMW1No7vKu8Ifua5dvbaYqmrrBGDjyKpgb
   g==;
X-IronPort-AV: E=Sophos;i="5.98,279,1673938800"; 
   d="asc'?scan'208";a="202710844"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Mar 2023 08:24:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 08:24:29 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 21 Mar 2023 08:24:27 -0700
Date:   Tue, 21 Mar 2023 15:35:38 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Torsten Duwe <duwe@lst.de>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Li Huafei <lihuafei1@huawei.com>,
        Liao Chang <liaochang1@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <liubao918@huawei.com>
Subject: Re: [PATCH] riscv: relocate R_RISCV_CALL_PLT in kexec_file
Message-ID: <fc1a945d-368c-4385-b1cc-69978e0f4657@spud>
References: <20230310182726.GA25154@lst.de>
 <e02fdfce-4574-8e7e-ec96-8e8eaa4067bc@huawei.com>
 <20230321160349.3b3a46df@blackhole.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6Tf43noRFCb2ZP4i"
Content-Disposition: inline
In-Reply-To: <20230321160349.3b3a46df@blackhole.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--6Tf43noRFCb2ZP4i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2023 at 04:03:49PM +0100, Torsten Duwe wrote:
> On Mon, 13 Mar 2023 11:13:17 +0800
> Li Zhengyu <lizhengyu3@huawei.com> wrote:
>=20
> > On Fri, 10 Mar 2023 19:27:03 +0100, Torsten Duwe <duwe@lst.de> wrote:
> > > Depending on the toolchain (here: gcc-12, binutils-2.40) the
> > > relocation entries for function calls are no longer R_RISCV_CALL, but
> > > R_RISCV_CALL_PLT. When trying kexec_load_file on such kernels, it will
> > > fail with
> > >
> > >   kexec_image: Unknown rela relocation: 19
> > >   kexec_image: Error loading purgatory ret=3D-8
> > >
> > > The binary code at the call site remains the same, so tell
> > > arch_kexec_apply_relocations_add() to handle _PLT alike.
> >=20
> > R_RISCV_CALL has already been deprecated, and replaced by R_RISCV_CALL_=
PLT.
> >=20
> > See Enum 18-19 in Table 3. Relocation types from=20
> > https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-=
elf.adoc=20
> > .
> >=20
> > It was deprecated in ("Deprecated R_RISCV_CALL, prefer=20
> > R_RISCV_CALL_PLT")=20
> > https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a0dced85018=
d7a0ec17023c9389cbd70b1dbc1b0
> >=20
> > >
> > > fixes: 838b3e28488f702 ("Load purgatory in kexec_file")
> > > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > > Cc: stable@vger.kernel.org
> > >
> > > ---
> > > --- a/arch/riscv/kernel/elf_kexec.c
> > > +++ b/arch/riscv/kernel/elf_kexec.c
> > > @@ -425,6 +425,7 @@ int arch_kexec_apply_relocations_add(struct purga=
tory_info *pi,
> > >   		 * sym, instead of searching the whole relsec.
> > >   		 */
> > >   		case R_RISCV_PCREL_HI20:
> > > +		case R_RISCV_CALL_PLT:
> > >   		case R_RISCV_CALL:
> > >   			*(u64 *)loc =3D CLEAN_IMM(UITYPE, *(u64 *)loc) |
> > >   				 ENCODE_UJTYPE_IMM(val - addr);
> > >
> > > .
> >=20
> > Palmer, please apply these references to the commit message.
> >=20
> > Reviewed-by: Li Zhengyu <lizhengyu3@huawei.com>
> >=20
>=20
> Ping?

It's not been all that longer than a week & you're in patchwork so you
won't be forgotten, but I noticed a complaint when I went looking on
patchwork about your fixes tag:

Commit: f28b81e30b4b ("riscv: relocate R_RISCV_CALL_PLT in kexec_file")
	Fixes tag: fixes: 838b3e28488f702 ("Load purgatory in kexec_file")
	Has these problem(s):
		- Subject does not match target commit subject
		  Just use
			git log -1 --format=3D'Fixes: %h ("%s")'

The fixes tag should be:
Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")

Note the capital F & the missed RISC-V: prefix, checkpatch should have
complained about this.
Checkpatch also complains that your suse email in the Signoff doesn't
match the lst.de email that you used to send the patch (IOW you're
missing a From: header that send-email would add).

Could you fix those things up please & I suppose you can take the
opportunity to make the changes that Li Zhengyu suggested to the commit
message itself at the same time.

Thanks,
Conor.



--6Tf43noRFCb2ZP4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBnOxAAKCRB4tDGHoIJi
0hOtAQCLB6C9nIcVqUpFQ7xTtESnOBJTdvu8LY2vIaOeFiMjZwEAqc3Z6nZ80y9z
M7VMSeGNvfoOb5RYfH7UWCUXAJ7SiQQ=
=zuFb
-----END PGP SIGNATURE-----

--6Tf43noRFCb2ZP4i--
