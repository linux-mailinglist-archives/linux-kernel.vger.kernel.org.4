Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564896EE327
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjDYNda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbjDYNdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:33:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BDA13FAB;
        Tue, 25 Apr 2023 06:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682429570; x=1713965570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n+UYdOVx4WUXne2QA73wy1xrjCHvnCZyxya9YmSho+E=;
  b=n0zGd2vjgKaZrgiFnogkk/eTKOntVL+biJeIv0dLR6GY4DBVAH27/nAc
   tYsr/yiTg4QRmrXSaxEe1GQTb3wvWAh7RGgJCULfBhWsShjzpsJmRtHYU
   pD5As2wsN7S+SdmXfE9CdoLXZtFIftwhnp+jWC/pmXSKdWhvZaAWRDGMu
   ZDv1UoXs1yeuNHpKdmYi/f3h4JfysuCcko38F9FtnSlzLFMyVNDceWgQv
   pKnlTtFJJ78XF9p5b3qprn+LNk4dTyrlYfx3UlZL43Ok/Aape+cWxe5fw
   Zl6TY+UoVK7OlicRgxVdBL9X5iMDuku6kbT+w8QMyxpPGkn8gzUPG/5WT
   A==;
X-IronPort-AV: E=Sophos;i="5.99,225,1677567600"; 
   d="asc'?scan'208";a="208183674"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Apr 2023 06:32:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 25 Apr 2023 06:32:39 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 25 Apr 2023 06:32:37 -0700
Date:   Tue, 25 Apr 2023 14:32:20 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Yangyu Chen <cyy@cyyself.name>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Wende Tan <twd2.me@gmail.com>, Soha Jin <soha@lohu.info>,
        Hongren Zheng <i@zenithal.me>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] docs: dt: allow case-insensitive RISC-V ISA string
Message-ID: <20230425-echo-elusive-bc38bc625053@wendy>
References: <20230425120016.187010-1-cyy@cyyself.name>
 <tencent_221A82C2DAF38E66B85B313221958DDD7C08@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/hVUEV3z0EeUnQAU"
Content-Disposition: inline
In-Reply-To: <tencent_221A82C2DAF38E66B85B313221958DDD7C08@qq.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--/hVUEV3z0EeUnQAU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Yangyu Chen,

On Tue, Apr 25, 2023 at 08:00:16PM +0800, Yangyu Chen wrote:
> After allowing case-insensitive ISA string parsing in the kernel code,
> the docs should be updated.

As I pointed out in my reply to your cover letter [1], I don't think this
patch is backwards compatible, and should instead be fixed in
rocket-chip's codebase, where it appears the capital letters were added
without actually testing the output against the binding.
If we allow caps here, booting old kernels with new devicetrees may
experience the crash you mention in your cover letter.

NAK, on the basis that this should be fixed in rocket-chip (or any other
core-generator that outputs invalid devicetrees).

Otherwise, the $subject doesn't match what is used for dt-bindings (use
`git log --oneline -- /path/to/file` for examples) nor did you CC the
output of get_maintainer.pl, with the devicetree maintainers notably
being absent.

Cheers,
Conor.

1 - https://lore.kernel.org/linux-riscv/20230425-flyable-prompter-5b1e4cebf=
9db@wendy/

> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index 001931d526ec..70afd1e8638b 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -79,11 +79,10 @@ properties:
>        User-Level ISA document, available from
>        https://riscv.org/specifications/
> =20
> -      While the isa strings in ISA specification are case
> -      insensitive, letters in the riscv,isa string must be all
> -      lowercase to simplify parsing.
> +      According to RISC-V ISA specification, the isa strings are
> +      case insensitive.
>      $ref: "/schemas/types.yaml#/definitions/string"
> -    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)?(?:=
_[hsxz](?:[a-z])+)*$
> +    pattern: (?i)^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)=
?(?:_[hsxz](?:[a-z])+)*$
> =20
>    # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
>    timebase-frequency: false
> --=20
> 2.40.0
>=20

--/hVUEV3z0EeUnQAU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEfWZAAKCRB4tDGHoIJi
0kXEAQCz6v6VsoqWREz45zSf4bLpIftWmQRW94Qb4+4AhCYrFgD7B+LRePncGOQL
yoi9Mw9yN2LKGNsxMgXC+I80FU9lMQE=
=yiKa
-----END PGP SIGNATURE-----

--/hVUEV3z0EeUnQAU--
