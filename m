Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A456FFA05
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbjEKTVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjEKTVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:21:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2EC10C9;
        Thu, 11 May 2023 12:21:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0797B650EA;
        Thu, 11 May 2023 19:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E670C433D2;
        Thu, 11 May 2023 19:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683832872;
        bh=MJODu8cjkXd6OoV0TmVTxhOZBvGy+7TMYzFGXyH5VYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DlVvLRfwPacQywkHeT/JHDv3yu9Tj//cfXhlpXTon41JA+Nfwjreym7+i2DeCO/wY
         0iSug93frk80OT1fgPtM77WbI/jEO42Abgbrn378TcHcHqgvUcUooYk7CPYBerqccC
         JlQRx0icWvUyeuej3XLJK5UJsy53fnx+ZUXmc7Wn8oW2Qd2pijw4DnBTPjJLVz8STq
         qlNnmFnQiGq6LSm2kqi52xSY3DnXMrWwGE/sNDMwvCzoynASVYpm3rb87m6XutvG1P
         1cHjhUONgjSXpVn3kwP8lLvcWlDqrda8bVcieH8TWZVDHyqxejWMTPvM/ktJnNynVy
         oX9/ZwaSE7IBw==
Date:   Thu, 11 May 2023 20:21:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefank@nvidia.com
Subject: Re: [PATCH v4 4/6] dt-bindings: Add support for DRAM MRQ GSCs
Message-ID: <20230511-carnivore-legend-17206803d713@spud>
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
 <20230511132048.1122075-5-pdeschrijver@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ucUeK4weGJVTHNSS"
Content-Disposition: inline
In-Reply-To: <20230511132048.1122075-5-pdeschrijver@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ucUeK4weGJVTHNSS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 04:20:49PM +0300, Peter De Schrijver wrote:
> Add bindings for DRAM MRQ GSC support.
>=20
> Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>
> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

Perhaps Krzysztof will disagree, but looks fine to me, with some minor
remarks below.
Just to note, I didn't get the cover letter & therefore didn't get the
changelog :/
I know you had a back and forth with him about that, *my* =E2=82=AC0.02 is =
that
either you put the changelog in the cover & send it to everyone, or you
put it in each patch.

> ---
>  .../nvidia,tegra264-bpmp-shmem.yaml           | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/nvi=
dia,tegra264-bpmp-shmem.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/reserved-memory/nvidia,teg=
ra264-bpmp-shmem.yaml b/Documentation/devicetree/bindings/reserved-memory/n=
vidia,tegra264-bpmp-shmem.yaml
> new file mode 100644
> index 000000000000..4087459c01db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-b=
pmp-shmem.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reserved-memory/nvidia,tegra264-bpmp-=
shmem.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tegra CPU-NS - BPMP IPC reserved memory
> +
> +maintainers:
> +  - Peter De Schrijver <pdeschrijver@nvidia.com>
> +
> +description: |

You don't appear to have any formatting to preserve, so the | is not
needed.

> +  Define a memory region used for communication between CPU-NS and BPMP.
> +  Typically this node is created by the bootloader as the physical addre=
ss
> +  has to be known to both CPU-NS and BPMP for correct IPC operation.
> +  The memory region is defined using a child node under /reserved-memory.
> +  The sub-node is named shmem@<address>.
> +
> +allOf:
> +  - $ref: reserved-memory.yaml
> +
> +properties:
> +  compatible:
> +    const: nvidia,tegra264-bpmp-shmem
> +
> +  reg:
> +    description: The physical address and size of the shared SDRAM region
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - no-map
> +
> +examples:
> +  - |
> +    reserved-memory {
> +       #address-cells =3D <2>;
> +       #size-cells =3D <2>;

You also do not need these size/address-cells, because...

> +       dram_cpu_bpmp_mail: shmem@f1be0000  {
(nit: double space                          ^^)

> +           compatible =3D "nvidia,tegra264-bpmp-shmem";
> +           reg =3D <0x0 0xf1be0000 0x0 0x2000>;

=2E..the 64-bit registers here are both 0x0.

With those fixed:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> +           no-map;
> +       };
> +    };
> +...
> --=20
> 2.34.1
>=20

--ucUeK4weGJVTHNSS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZF1AIwAKCRB4tDGHoIJi
0hbVAPoC6OwAmplzwpoHvCInrWR1V+vNUoeq0VCpxoxhwlYCiAEAyZ7YPJfcr4GB
kA8X40rOpyVck/Forfn6KiNw7KrzJgo=
=+I2s
-----END PGP SIGNATURE-----

--ucUeK4weGJVTHNSS--
