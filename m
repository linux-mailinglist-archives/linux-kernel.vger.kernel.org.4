Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DE274B503
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjGGQQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjGGQQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:16:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B191FC6;
        Fri,  7 Jul 2023 09:16:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B5A7619F7;
        Fri,  7 Jul 2023 16:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710E5C433C7;
        Fri,  7 Jul 2023 16:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688746589;
        bh=pbnXRhVySf14G9UUJhkd+L9NaIu5G90Mbtsz7TnLfrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iA3khxCeCcZuXExNsjQj7UM6c3HCUDupcSUkpt2D2twVnz4wDXkMnQ+Y0++FfWZjh
         GWRR5FNYbcAvnU+3kEwiOPl0AREYmsoCMaM+N0zjbQ7KSrcr5e5guLS221wxBEb1AQ
         +zQmq+JVyPx/j29K4OEWY94RtVxNE6v9Qs8B7dPd7Z3EH8eDJZt/+IIkd+HItnMbdW
         68QsH1vusOFYYhLEJbD2uyxsAJ+oBrBhBaEEOmqkisbp43qKwqt3sLDQIXPDXRGgi9
         FAOoXXjOxVzMOOuJrhXsMzDWC6fZhtIpUUgC9cRMwtsizhclTj4ePX/92fC+Boae+r
         j2joOl0sQkGag==
Date:   Fri, 7 Jul 2023 17:16:23 +0100
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
Message-ID: <20230707-brigade-myth-86ee252b2e4a@spud>
References: <20230705114251.661-1-cuiyunhui@bytedance.com>
 <20230705114251.661-5-cuiyunhui@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MexQSwawafA3M9FW"
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


--MexQSwawafA3M9FW
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
> @@ -0,0 +1,27 @@
> +FFI(FDT FIRMWARE INTERFACE) driver
> +
> +Required properties:
> + - entry		: acpi or smbios root pointer, u64
> + - reg			: acpi or smbios version, u32
> +
> +Some bootloaders, such as Coreboot do not support EFI,
> +only devicetree and some arches do not have a reserved
> +address segment. Add "ffitbl" subnode to obtain ACPI RSDP
> +and SMBIOS entry.

Since the conversation on this stuff all seems to be going absolutely
nowhere, the ACPI portion of this is intended for use on RISC-V in
violation of the RISC-V ACPI specs. It also goes against the
requirements of the platform spec. Quoting from [1]:

| > Just so we're all on the same page, I just now asked Mark Himelstein
| > of RISC-V International if there is anything in RISC-V standards that
| > requires UEFI, and the answer is a solid "no."
|=20
| Huh? Firstly, running off to invoke RVI is not productive - they don't
| maintain the various operating system kernels etc.
| Secondly, that does not seem to be true. The platform spec mandates UEFI
| for the OS-A server platform, alongside ACPI:
| https://github.com/riscv/riscv-platform-specs/blob/main/riscv-platform-sp=
ec.adoc#32-boot-process
| and the OS-A embedded platform needs to comply with EBBR & use DT:
| https://github.com/riscv/riscv-platform-specs/blob/main/riscv-platform-sp=
ec.adoc#32-boot-process
|=20
| EBBR does say that systems must not provide both ACPI and DT to the OS
| loader, but I am far from an expert on these kind of things & am not
| sure where something like this where the DT "contains" ACPI would stand.
|=20
| The RISC-V ACPI spec also says "UEFI firmware is mandatory to support
| ACPI":
| https://github.com/riscv-non-isa/riscv-acpi/blob/master/riscv-acpi-guidan=
ce.adoc

NAKed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

[1] - https://lore.kernel.org/linux-riscv/20230707-attach-conjuror-306d9673=
47ce@wendy/

--MexQSwawafA3M9FW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKg6VwAKCRB4tDGHoIJi
0tsPAP0bKjMWR0EO3MkRO8EwPjH447Grmd24cJV3uLKXhycVGQEAxlcHMYpTj38j
JvMPxFtO7OquXt3BnCppGSpNCHKakgQ=
=/Xfw
-----END PGP SIGNATURE-----

--MexQSwawafA3M9FW--
