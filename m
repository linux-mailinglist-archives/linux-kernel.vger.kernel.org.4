Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D1D745C19
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjGCMUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjGCMUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:20:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD19C10E;
        Mon,  3 Jul 2023 05:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688386783; x=1719922783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N4gKd8fWbYJ/ABi5Z6Bl0mGhtTl4jH7aIaIsRqTpg5A=;
  b=g2Ef0kTdEjbe3vtIfH+fhNozicmnp+Ca1Mth+bPFPMxpFMN97Unut4PR
   QZInoJY5+0WQnIC+EAzpf4ANq6KTxBejuArvynoF1NgKyRka3YmeOE+Cd
   H8m7tytDAfBwThdZRT4K9KXwBef6Sjvvcj4xpQPRrEv94xLd9CboQN+WZ
   GXx7ZHo7++pVH7clxmVgLFPdGIQsm4v12ecgT8bwfb1oYj/KFKRCe7TSe
   FoK69DOwP9GhJSlIL2hqQQz7pvlWfcSsDvssxl193Bo7CZiWLwC3Xvq0W
   3cTSmJi7bBBm+9Ix3ORLeuYGbhBzkONkcC6uS6pzib04PoUSCMpY5fxZe
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="asc'?scan'208";a="233459359"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2023 05:19:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Jul 2023 05:19:32 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 3 Jul 2023 05:19:28 -0700
Date:   Mon, 3 Jul 2023 13:18:59 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     =?utf-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
CC:     Conor Dooley <conor@kernel.org>, <ardb@kernel.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
        <rminnich@gmail.com>, <mark.rutland@arm.com>,
        <lpieralisi@kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
        <jdelvare@suse.com>, <yc.hung@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <allen-kh.cheng@mediatek.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <tinghan.shen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <geshijian@bytedance.com>,
        <weidong.wd@bytedance.com>, <alexghiti@rivosinc.com>,
        <sunilvl@ventanamicro.com>
Subject: Re: [External] Re: [PATCH v2 1/3] riscv: obtain ACPI RSDP from FFI.
Message-ID: <20230703-handstand-prototype-733d702c946c@wendy>
References: <20230702095735.860-1-cuiyunhui@bytedance.com>
 <20230702-headway-dreamlike-d7ba39ac4910@spud>
 <CAEEQ3wnzf=iDDHJATo2vdVz-SDNYRGBEEb7sXUyGojgP4ZAgaA@mail.gmail.com>
 <20230703-glorified-headless-16e998608eaa@wendy>
 <CAEEQ3wnjYK+Jj9Ce_yEHPL_z3eYn4OKP85YLXnVeaPd+SA3DJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EZbNUtLsl36cHBYP"
Content-Disposition: inline
In-Reply-To: <CAEEQ3wnjYK+Jj9Ce_yEHPL_z3eYn4OKP85YLXnVeaPd+SA3DJw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--EZbNUtLsl36cHBYP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2023 at 06:16:07PM +0800, =E8=BF=90=E8=BE=89=E5=B4=94 wrote:
> Hi Conor,

> This needs to be confirmed with you:

> Continue to follow the current code structure, patch 1/3 is placed in
> arch/riscv/, and 2/3 is placed under driver/firmware?

You do want the SMBIOS stuff to be cross architecture, right?
If so, keeping the code as-is seems to make the most sense to me.

> How about changing the commit log to the following?
>=20
> riscv: obtain ACPI RSDP from devicetree.
>=20
> On RISC-V, when using Coreboot to start, since Coreboot only supports
> DTS but not EFI, and
> RISC-V does not have a reserved address segment.
> When the system enables ACPI, ACPI RSDP needs to be passed through DTS

I would probably write something like:
	On RISC-V, Coreboot does not support booting using EFI, only devicetree
	nor does RISC-V have a reserved address segment.
	To allow using Coreboot on platforms that require ACPI, the ACPI RSDP
	needs to be passed to supervisor mode software using devicetree.
	Add support for parsing the "configtbls" devicetree node to find the
	ACPI entry point and use wire up acpi_arch_get_root_pointer().
	This feature is known as FDT Firmware Interface (FFI).

> > > > > +extern u64 acpi_rsdp;
> > > >
> > > > /stuff/linux/drivers/acpi/osl.c:178:22: error: redefinition of 'acp=
i_rsdp' with a different type: 'unsigned long' vs 'u64' (aka 'unsigned long=
 long')
> > > >
> > > > Fails to build when Kexec is enabled.
> > >
> > > Rename my acpi_rsdp to arch_acpi_rsdp? WDYT?
> >
> > You could do s/arch/riscv/ either, that'd match what we prefix a lot of
> > stuff with.
>=20
>  Sorry, I don't quite understand what you mean. Could you tell me in deta=
il?

What I meant is that variables & functions in /arch/riscv are often
prefixed with riscv_. I was saying that you could change "arch_acpi_rsdp"
to "riscv_acpi_rsdp".

Thanks,
Conor.

--EZbNUtLsl36cHBYP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKK8swAKCRB4tDGHoIJi
0iOsAP9nUhe+52G7iYGgpanW05h65F/yeBcQLU0dulmrEn1S2wD/XL9sbVYP1TMX
cVk+054gMsIjpM3cP3p/ta7JxOrCMwc=
=iWQ3
-----END PGP SIGNATURE-----

--EZbNUtLsl36cHBYP--
