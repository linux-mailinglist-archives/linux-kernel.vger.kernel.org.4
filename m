Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B5967C552
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbjAZIAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjAZIAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:00:53 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B8666F8D;
        Thu, 26 Jan 2023 00:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674720051; x=1706256051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GBE/VjADrLDKieC7b5itKGUOfGov2KepyoUCPJ4/mf0=;
  b=qNStwrT4L45OfwhAcie+UYU/GQ4il/tkx8GeqMRfNED8IHioy1kSoeFb
   5X0+mEnDjIh9Jgqg1KgYwqyJoeaZQkOq/GgID83VF4d/tW/HEFt7rSNXQ
   RnZCFvGe0EmfRUwshI0tSeXOQXC/3etub3R9b7Byw2B7TIL4SkPhKLfNK
   HHkn1arGR/gRkHtlY+TuSB0mGRvRM2igyQP45e5Y6KRW5DsiJmswJOKRp
   Dlj/gZQSh1hNx4fLM6Em+DRYwmMb4YghQ7mzl+WSnvo/0k4nPhX6LMCXO
   k8YRAzSX3piSAeCmKwAvTve8wC6uHlN9+Gr5FBP4V/7xhQKrNrYAnra5E
   w==;
X-IronPort-AV: E=Sophos;i="5.97,247,1669100400"; 
   d="asc'?scan'208";a="197475984"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jan 2023 01:00:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 01:00:42 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 26 Jan 2023 01:00:40 -0700
Date:   Thu, 26 Jan 2023 08:00:16 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Samuel Holland <samuel@sholland.org>
CC:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        <linux-sunxi@lists.linux.dev>, <linux-riscv@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 00/11] riscv: Allwinner D1/D1s platform support
Message-ID: <Y9IzELYtub1DmGB5@wendy>
References: <20230126045738.47903-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fj2Wr4MQdoooWJdA"
Content-Disposition: inline
In-Reply-To: <20230126045738.47903-1-samuel@sholland.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--fj2Wr4MQdoooWJdA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2023 at 10:57:27PM -0600, Samuel Holland wrote:
> This series adds the Kconfig/defconfig plumbing and devicetrees for a
> range of Allwinner D1 and D1s-based boards. Many features are already
> enabled, including USB, Ethernet, and WiFi.
>=20
> This version drops all boards/nodes with missing YAML bindings, so at
> least some support can get merged for v6.3.

That'd be great! Pity the LDO stuff isn't ready yet, but definitely
better to have this stuff in rather than out. In case it helps:
Acked-by: Conor Dooley <conor.dooley@microchip.com>


--fj2Wr4MQdoooWJdA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9IzDAAKCRB4tDGHoIJi
0jEzAPwL157GoMnwml3kupueIMZ1KSMy5IfVKW2YSqP7GD6KxQD7BKmIo2ITQ2fu
ftVmGqWDLJvwGoS4PdqMF78cCMPU6gc=
=hIJW
-----END PGP SIGNATURE-----

--fj2Wr4MQdoooWJdA--
