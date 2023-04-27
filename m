Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DB76F03E0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243448AbjD0KAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242972AbjD0KAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:00:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FF53ABC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682589637; x=1714125637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wtiAvihgzjHl3CGGZqSE5VqXArzx6rcWqXav7rpAM7o=;
  b=Cl5oG5BdVHskq09E7yJ76UKThzW7A7055UWAzKUR/ZlBp56GNnlKSAUB
   rDXnmv/KeRG882zTERT2N+aME+jjJhf9RBgK1aMShvjM3ZEeV427Sw0Ix
   f8nL1oQUrSTYVCxg0aCGw2bZEveBVLxOxjJSf475+4tgUTFGHJKCk7+0c
   Dza/q1E5xDrNGnR44HW8cMJ1hzYHRSv1zuN7UEbqlEFkKQoEz8HmHYfQ5
   fsHZK6BNHsg/3iMA9aYgy+0he6ru/bNfOkpmViVqvENOYhNLopm6CMI/r
   uw0SoouZwIqzjBknvCgOhxCkEOP3264CMfI/AjZDpC8ugAf3YbwNDnwhY
   A==;
X-IronPort-AV: E=Sophos;i="5.99,230,1677567600"; 
   d="asc'?scan'208";a="210940020"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Apr 2023 03:00:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 27 Apr 2023 03:00:36 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 27 Apr 2023 03:00:34 -0700
Date:   Thu, 27 Apr 2023 11:00:16 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Yangyu Chen <cyy@cyyself.name>
CC:     <ajones@ventanamicro.com>, <aou@eecs.berkeley.edu>,
        <conor@kernel.org>, <i@zenithal.me>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>, <soha@lohu.info>,
        <twd2.me@gmail.com>
Subject: Re: [PATCH 1/2] riscv: allow case-insensitive ISA string parsing
Message-ID: <20230427-related-generic-7573069edc67@wendy>
References: <20230427-unveiling-kiwi-631e966f77cc@wendy>
 <tencent_D9A598A810BDC656BE2BC15A6D0FC76C5C07@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kuwsqOfIl6S7aHip"
Content-Disposition: inline
In-Reply-To: <tencent_D9A598A810BDC656BE2BC15A6D0FC76C5C07@qq.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--kuwsqOfIl6S7aHip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2023 at 05:36:25PM +0800, Yangyu Chen wrote:
> Hi, Conor

>=20
> On Thu, 27 Apr 2023 10:04:34 +0100, Conor Dooley wrote:
> > Preventing the input of absolute rubbish is dt-validate's job & if the =
dtb
> > itself has been corrupted somehow I suspect that we have bigger problems
> > than checking for "rv" will solve.
>=20
> > > also do a strlen(isa) >=3D 4 check first, though. of_property_read_st=
ring()
> > > will succeed even when the string is "".
>=20
> > I don't think that checking that there are at least 4 characters isn't
> > even sufficient. Either we should confirm that this is a valid riscv,isa
> > to run on (so rv##ima w/ ## matching the kernel) or not bother at all.
>=20
> What will happen if we have a bootloader in the future which allows
> overriding isa string in the DT or ACPI table, the memory corruption could
> happen if we didn't check it first.

You can do this right now, no?
You can also overwrite the memory nodes and all sorts of other things
that'll cause your system to crash too. The isa string is nothing
special in that regard ;)

> Although the kernel will not boot in this case, anything about the user
> input string should be parse carefuly that you never know what the future
> code will be but leave a checker here will remind someone who will change
> the parse in the future to check the length carefully.

of_property_read_string() will always return something that is null
terminated on success, so we can just call strncmp() to make sure that
the hart supports something usable, no?

> I have a different opinion about whether the isa string length should be
> checked.

> So I agree with drew, we should do check strlen before check the first
> two characters.

In case it was lost in translation, I was never disputing checking that
there is a string before accessing it like this, but rather questioning
why we do such a limited check here at all.

Cheers,
Conor.

--kuwsqOfIl6S7aHip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEpHsAAKCRB4tDGHoIJi
0tVOAP9yB9QiDDkjzXlfN9sch23r/K4ll1odi/MQ+szxdGmt/gEA+VVbVqUJXUeS
mN+uJOVX0fufcXgSRjLlyNP/H4luEQA=
=O1Zd
-----END PGP SIGNATURE-----

--kuwsqOfIl6S7aHip--
