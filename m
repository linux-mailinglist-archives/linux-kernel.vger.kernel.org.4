Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEBB7088B3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjERTxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjERTxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:53:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CD610C6;
        Thu, 18 May 2023 12:53:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E994651E7;
        Thu, 18 May 2023 19:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C131EC433EF;
        Thu, 18 May 2023 19:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684439591;
        bh=97mz22yBYEwl0uvWrtuRvN7tEwZZw/SN6l1zVITlLDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NTO9zbT3tTtj/wiMe3RV534PsCiKjDcTFx7Lmpa+7VeztrSVhtHUZxENUB9q9ZNRS
         TN+dNPikgdKWGSym+QLjodbNSPibWLOJKdWUWxzihD6j7aF2bmnEhzO1ROaz9sdlqu
         1TEdEtR2FFhd4hFIRSbcrCFgJ5KTj5anJF/LMRByTR4AW3NwPqWyZj5jF/r3hsGQ+i
         7927PmZs0vRzQbX/QMeFjUz/mysprIGWNQBiZOnRZx59qP/mRMxZbg1xM3kRsyGgsb
         7Ow0FODITuh3B8Q6YO7+TlJhvzW/4dQNzj1iQIDfqii/0+qSZtm2PJi4cawChCbOER
         0m7Jt9EXo+RPg==
Date:   Thu, 18 May 2023 20:53:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Yangtao Li <frank.li@vivo.com>,
        Wei Fu <wefu@redhat.com>, Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH v2 4/9] dt-binding: riscv: add T-HEAD CPU reset
Message-ID: <20230518-driving-secluding-793b3192776e@spud>
References: <20230518184541.2627-1-jszhang@kernel.org>
 <20230518184541.2627-5-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4uiDuJOB38i7bEfg"
Content-Disposition: inline
In-Reply-To: <20230518184541.2627-5-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4uiDuJOB38i7bEfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Jisheng,

On Fri, May 19, 2023 at 02:45:36AM +0800, Jisheng Zhang wrote:
> The secondary CPUs in T-HEAD SMP capable platforms need some special
> handling. The first one is to write the warm reset entry to entry
> register. The second one is write a SoC specific control value to
> a SoC specific control reg. The last one is to clone some CSRs for
> secondary CPUs to ensure these CSRs' values are the same as the
> main boot CPU. This DT node is mainly used by opensbi firmware.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/riscv/thead,cpu-reset.yaml       | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/thead,cpu-res=
et.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/thead,cpu-reset.yaml=
 b/Documentation/devicetree/bindings/riscv/thead,cpu-reset.yaml
> new file mode 100644
> index 000000000000..ba8c87583b6b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/thead,cpu-reset.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/thead,cpu-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: T-HEAD cpu reset controller
> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>
> +
> +description: |
> +  The secondary CPUs in T-HEAD SMP capable platforms need some special
> +  handling. The first one is to write the warm reset entry to entry
> +  register. The second one is write a SoC specific control value to
> +  a SoC specific control reg. The last one is to clone some CSRs for
> +  secondary CPUs to ensure these CSRs' values are the same as the
> +  main boot CPU.

Okay..

> +
> +properties:
> +  $nodename:
> +    pattern: "^cpurst"

Firstly, why the nodename enforcement? We have a compatible, so we
should be okay, no?

> +
> +  compatible:
> +    oneOf:
> +      - description: CPU reset on T-HEAD TH1520 SoC
> +        items:
> +          - const: thead,reset-th1520

You've only got one thing here, you don't need the oneOf.
Also, s/reset-th1520/th1520-reset/ please - although I do not know if
"reset" is the right word here. Do we know what the IP block is called
in the TRM/T-Head docs? Perhaps Guo Ren does if not.

> +  entry-reg:
> +    $ref: /schemas/types.yaml#/definitions/uint64
> +    description: |
> +      The entry reg address.
> +
> +  entry-cnt:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The entry reg count.
> +
> +  control-reg:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The control reg address.
> +
> +  control-val:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The value to be set into the control reg.
> +
> +  csr-copy:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      The CSR registers to be cloned during CPU warm reset.

All of these values set on a per-soc basis, right?
If so, I don't think they should be in here at all since you should be
able to figure out the offsets from the base & the values to write based
on the compatible string alone, no?

Putting register values into the DT is always "suspect"!

> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cpurst: cpurst@ffff019050 {
               ^^^^^^^^^^^^^^^^^
This is also "suspect" and implies that "entry reg" should just be a
normal "reg" property.


> +      compatible =3D "thead,reset-th1520";
> +      entry-reg =3D <0xff 0xff019050>;
> +      entry-cnt =3D <4>;
> +      control-reg =3D <0xff 0xff015004>;
> +      control-val =3D <0x1c>;
> +      csr-copy =3D <0x7f3 0x7c0 0x7c1 0x7c2 0x7c3 0x7c5 0x7cc>;
> +    };
> --=20
> 2.40.0
>=20

--4uiDuJOB38i7bEfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGaCIQAKCRB4tDGHoIJi
0n9SAP92K/2ImcXGHXRjUY3v5X+WdDMZxN/kIxZBW3btQoK6twD8CWE0LOA195ry
vmZPV/di2h45fbZHO5L8dKmuh9vxHwU=
=0QHL
-----END PGP SIGNATURE-----

--4uiDuJOB38i7bEfg--
