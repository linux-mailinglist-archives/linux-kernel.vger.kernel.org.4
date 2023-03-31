Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9756D1918
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjCaHzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjCaHzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:55:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185A51A457;
        Fri, 31 Mar 2023 00:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680249308; x=1711785308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G06WLXOVFAFnLBBUsp6Jlr0u7jQcjZ+I3gaWkuDCem4=;
  b=edKMwGFar8ioxxHgrSOanZhFrdU4zLo3oB+f4F5xYI1+/AuXw0cVs6fV
   RYWD7dH5dQ9SJoFR7XOr0oMw4O4HA2z1B2G1m0efbLEtWeEj+5VJMVO+l
   llVxWizHn/6tOThoYJcPe6CKHISwINlsExvqmIJKNAIi3d32LOso0Kcn5
   tOkcbjgl0VEmcV4/JdlG4fbjLWIc/R53uR6Mi5E4/YjlHGoAIdfBVLlPg
   xTavGRNlZe7C9t1GUYCiVfex93/1PWNazxmcM2hPhgoF+mGBZBAlYW0ce
   tEcwiqrzQbUFbjK/tz5jtwQS+WkZkuPxpYu49e2Z2BwWvZGKV/skgX0OK
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673938800"; 
   d="asc'?scan'208";a="208206452"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2023 00:55:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 00:55:06 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 31 Mar 2023 00:55:04 -0700
Date:   Fri, 31 Mar 2023 08:54:50 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        guoren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        <linux-riscv@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
Message-ID: <c63bace6-1046-4428-97ba-6f12fd119dc6@spud>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <6ca5941a-8803-477d-8b40-17292decc5af@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3+eEFpkaOtz7KiLx"
Content-Disposition: inline
In-Reply-To: <6ca5941a-8803-477d-8b40-17292decc5af@app.fastmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--3+eEFpkaOtz7KiLx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2023 at 11:34:02PM +0200, Arnd Bergmann wrote:
> On Thu, Mar 30, 2023, at 22:42, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> > +#ifdef CONFIG_ERRATA_THEAD_CMO
>=20
> I would rename this to not call this an 'ERRATA' but
> just make it a driver. Not important though, and there
> was probably a reason you did it like this.

I think what was discussed in a prior iteration was that we'd leave
refactoring the T-HEAD bits into a driver for a subsequent work.

--3+eEFpkaOtz7KiLx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCaRuwAKCRB4tDGHoIJi
0henAQDzrAo67Su8ED56Dq3c08Eyq7o64Jv8WJBe/+zTzHdyxwEA9bnQTwb2UDwF
/2XfB1c09QrVeBENyd3hleXb77tXbgo=
=4qUu
-----END PGP SIGNATURE-----

--3+eEFpkaOtz7KiLx--
