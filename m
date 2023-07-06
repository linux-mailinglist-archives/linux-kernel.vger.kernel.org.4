Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EF9749DCC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjGFNdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjGFNcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:32:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B348219B2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 06:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688650372; x=1720186372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A0ITg5p0s9I1F/WCN2U7WmRQJ4A2utSLS9UEHI39G98=;
  b=hZwDf+yYOOx4vW0seZ0I3AAjfspUOo8e2DcrdpK9/s/sTfvUkFXPmHB9
   ldrHmgtC/90RIXWzAOL9j/DhdsOCjVeLbrQdg7BkhXHAUwe5I//QluVAq
   bsTXS1371UX6xS8+RqarDtammD8ryULo4lL/b/vlNMwC7WvjHiACKhY4+
   R6J9X4zM2whTkiDcnEF2nLE8ahwtTEGYZnqOz93UxaXkSC7zRgSQhZLS7
   suvJzJV4y1ceQ/X8bTv6HNSeD21WGj3ZeRzre+H2VChiq94U5lR5vglFR
   T1XvTeON1tpAPn6wZ23BawJHSimIAcDVNXLgr4hoecBtqPH9/OIcOkPS/
   w==;
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="asc'?scan'208";a="222382636"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2023 06:32:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Jul 2023 06:32:48 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 6 Jul 2023 06:32:46 -0700
Date:   Thu, 6 Jul 2023 14:32:16 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Samuel Ortiz <sameo@rivosinc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        <linux-kernel@vger.kernel.org>,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Guo Ren <guoren@kernel.org>, Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Evan Green <evan@rivosinc.com>
Subject: Re: [PATCH v2 2/3] RISC-V: hwprobe: Expose Zbc and the scalar crypto
 extensions
Message-ID: <20230706-overeater-dodgy-666f80dc473d@wendy>
References: <20230628131442.3022772-1-sameo@rivosinc.com>
 <20230628131442.3022772-3-sameo@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QpzfrTlSAhHgCxB4"
Content-Disposition: inline
In-Reply-To: <20230628131442.3022772-3-sameo@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--QpzfrTlSAhHgCxB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 03:14:34PM +0200, Samuel Ortiz wrote:
> Zbc was missing from a previous Bit-Manipulation extension hwprobe
> patch.
>=20
> Add all scalar crypto extensions bits, and define a macro for setting
> the hwprobe key/pair in a more readable way.
>=20
> Reviewed-by: Evan Green <evan@rivosinc.com>
> Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--QpzfrTlSAhHgCxB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKbCYAAKCRB4tDGHoIJi
0tbXAQCIxfRmR+GN+J8R+D7XmU0NWeOqMMdJrYWW6TnKKys34wD/ShnmOs1Onsju
BlFI6gGbwYUXJ5X+igIw1MVZKKiGOQ8=
=Wil8
-----END PGP SIGNATURE-----

--QpzfrTlSAhHgCxB4--
