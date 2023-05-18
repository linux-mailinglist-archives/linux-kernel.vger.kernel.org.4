Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6ED707F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjERLZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjERLZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:25:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CF5E7A;
        Thu, 18 May 2023 04:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684409142; x=1715945142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KPipI87LRIbP/OpMGuyK3E2LESwrrGgto5bVP90IVRI=;
  b=P/qV5f+cG5iJCedF9IFvL4R0dAtMDNdT8uxhvAOl9Hr7JKXJAoLeI7Up
   85/r3z8H588QQaLVJ8IsepEwMS6zTAFx4LxDC+TRgnycy6V3RQA45qcrV
   36bt0V+RgpBJFPskBv+LE/Eh5F6n3CP2s38rv7insKCkOCWgef1CaEBrT
   oZrPlzn2IvS0/W2meepBStrKiwNEwYCHq8Ja1jLmkl/ojCFF8CjSlckkk
   RQzOmbh486oTjcF51eLMgQoVT13Nsh+nyLjXg3zuaTHTyjvwgXWTbtA3u
   EBHssavHGaSDBQq02XJYXsCKYwY2cPCdE4vPGFYkQP9ld2vMqq3AHRfac
   A==;
X-IronPort-AV: E=Sophos;i="5.99,285,1677567600"; 
   d="asc'?scan'208";a="216085961"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 May 2023 04:25:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 18 May 2023 04:25:35 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 18 May 2023 04:25:32 -0700
Date:   Thu, 18 May 2023 12:25:11 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     <palmer@dabbelt.com>, <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
        <linux-riscv@lists.infradead.org>, <qemu-riscv@nongnu.org>,
        <u-boot@lists.denx.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] dt-bindings: riscv: deprecate riscv,isa
Message-ID: <20230518-resurrect-copy-0ecd9eaaca1e@wendy>
References: <20230518-thermos-sanitary-cf3fbc777ea1@wendy>
 <20230518-4050231ca8dbe93c08cf9c9a@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kb7QvTX+biQwTglT"
Content-Disposition: inline
In-Reply-To: <20230518-4050231ca8dbe93c08cf9c9a@orel>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--kb7QvTX+biQwTglT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 12:31:51PM +0200, Andrew Jones wrote:
> > +  # Additional Standard Extensions, sorted by category then alphabetic=
ally
>=20
> Can we just do pure alphabetically? And the single-letter extensions above
> don't have a "sorted by" comment above them. I guess they need one, or
> maybe they can also be alphabetical?

Maybe it is just me, but my brain is too used to seeing those ones in
something approaching canonical order. I'd rather keep them that way &
then alphanumerical for everything else?

I also noticed that the CMO stuff wasn't actually in the comment's order
anyway, so needs a re-sort to begin with. A vote in favour of
alphanumerical.

--kb7QvTX+biQwTglT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGYLFwAKCRB4tDGHoIJi
0grUAQCAc20dh6ItbijltjfIQVgSoT3hDJT0l6RFsHHzB6r/XgEA+HoYzGYleux9
54r2MbYTuE0fuZ9acteU6CIgBsX0Fg0=
=8leH
-----END PGP SIGNATURE-----

--kb7QvTX+biQwTglT--
