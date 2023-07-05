Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37FF748776
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjGEPGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjGEPGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:06:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66402131;
        Wed,  5 Jul 2023 08:06:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03E676156A;
        Wed,  5 Jul 2023 15:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAC1C433C8;
        Wed,  5 Jul 2023 15:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688569611;
        bh=9lnuLnPUp+a1W5bMi5dat9Uy2/HBvlSTBdYbVbval/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NEuKWqef0mCE5VU9AYbWFNz2ctcq97QILdHxoXbSPPB5PK43juTCFaYlTHdpQxc4k
         2TL9xEW8B0G3TKO9qdCBKgPOyar4v4pPoLlE+TOI0NVkV68hAZckdJZ/vQ2Q/jJ9mb
         TPQ1xAyjuQEgW2aiIRHYKOGA8s6C+OFEtxJ+ehZIubx0z619nW3B8yV5TB5qACf5Qq
         SrNG6L+UpLUiHKsRdy/J+WUB+LdGBzZ4SLrh1VcZ2Gwiixx6NWQXeYSxhx5fGoVvwK
         OtdUhHIPeuOSVpDTaT0HcrWcmt0gb/jMzchnEOdb6ZXL8rZTUzXEfi7uSkc6sZiuMj
         BOscOmuwxX24A==
Date:   Wed, 5 Jul 2023 16:06:45 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yunhui Cui <cuiyunhui@bytedance.com>
Cc:     sunilvl@ventanamicro.com, ardb@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, rminnich@gmail.com,
        mark.rutland@arm.com, lpieralisi@kernel.org, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Subject: Re: [PATCH v3 4/4] dt-bindings: firmware: Document ffitbl binding
Message-ID: <20230705-oblivious-unstuffed-8e028a5b243c@spud>
References: <20230705114251.661-1-cuiyunhui@bytedance.com>
 <20230705114251.661-5-cuiyunhui@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="P4Xlq9WyafqDDvSq"
Content-Disposition: inline
In-Reply-To: <20230705114251.661-5-cuiyunhui@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--P4Xlq9WyafqDDvSq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Jul 05, 2023 at 07:42:51PM +0800, Yunhui Cui wrote:
> Add the description for ffitbl subnode.
>=20
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  .../devicetree/bindings/firmware/ffitbl.txt   | 27 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/ffitbl.txt
>=20
> diff --git a/Documentation/devicetree/bindings/firmware/ffitbl.txt b/Docu=
mentation/devicetree/bindings/firmware/ffitbl.txt
> new file mode 100644
> index 000000000000..c42368626199
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/ffitbl.txt

Firstly, new dt-bindings need to be done in yaml, not in text form.
Secondly, you didn't re-run get_maintainer.pl after adding this binding,
so you have not CCed any of the other dt-binding maintainers nor the
devicetree mailing list.

> @@ -0,0 +1,27 @@

> +FFI(FDT FIRMWARE INTERFACE) driver
> +
> +Required properties:
> + - entry		: acpi or smbios root pointer, u64
> + - reg			: acpi or smbios version, u32

Please go look at any other dt-binding (or the example schema) as to how
these properties should be used. A "reg" certainly should not be being
used to store the revision...

Cheers,
Conor.

> +
> +Some bootloaders, such as Coreboot do not support EFI,
> +only devicetree and some arches do not have a reserved
> +address segment. Add "ffitbl" subnode to obtain ACPI RSDP
> +and SMBIOS entry.
> +This feature is known as FDT Firmware Interface (FFI).
> +
> +Example:
> +	ffitbl {
> +
> +		smbios {
> +				entry =3D "";
> +				reg =3D < 0x03 >;
> +
> +		}
> +		acpi {
> +				entry =3D "";
> +				reg =3D < 0x06 >;
> +
> +		}
> +	}
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9b886ef36587..008257e55062 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7874,6 +7874,7 @@ F:	include/linux/efi*.h
>  FDT FIRMWARE INTERFACE (FFI)
>  M:	Yunhui Cui cuiyunhui@bytedance.com
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/firmware/ffitbl.txt
>  F:	drivers/firmware/ffi.c
>  F:	include/linux/ffi.h
> =20
> --=20
> 2.20.1
>=20

--P4Xlq9WyafqDDvSq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKWHBAAKCRB4tDGHoIJi
0uB+AP0RwrTXNhCYkGKgzXI8nTOE4BWsGObrWS3ZfGAVVwXpbQEA5sW73BLXMhxe
NvzIKstw2Fg1XPTYnUwWjsFH3hHbIg4=
=IUHS
-----END PGP SIGNATURE-----

--P4Xlq9WyafqDDvSq--
