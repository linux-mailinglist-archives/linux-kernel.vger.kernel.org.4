Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1658A749DCD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjGFNdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGFNdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:33:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FDA102
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 06:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688650418; x=1720186418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VQYAGOy4mHGCVmcTL61GMJ4UBsZ5/jjfANV8gUIZHI4=;
  b=HGVE1GFqb0EGzUFYP+c4zr8Mbj9+2v1js8CpSGoDxax0K7L4/MLnZE4P
   2/IEpBkWpa014wNxCUJOlx5eQa80MWV2nkAveIGqwJR3jcNCzsjRdj4Xz
   WPvDbZMdJn0w++q5gZ44vXulQWM9PD+SaBxiIn+RDXbI9KGgJkfBfYiQ3
   rpcyixpFAT3W6/TW4FumYRn01RYxF1CrNhZfN3sqblO6OVtWzB+oCpeM/
   TGNgzLyToKeZ+2Vdj0cZcPS8JNcPlBZqBrC3SAKf9AO9PKrvyS9mHyL5i
   OzzXwDOkY6BHlzKQNusOdSGxD9h9odMueqCRkshgyzyxx950U+Ars1HpY
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="asc'?scan'208";a="219183784"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2023 06:33:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Jul 2023 06:33:35 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 6 Jul 2023 06:33:32 -0700
Date:   Thu, 6 Jul 2023 14:33:02 +0100
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
Subject: Re: [PATCH v2 3/3] RISC-V: Implement archrandom when Zkr is available
Message-ID: <20230706-putdown-unedited-012eafe854f6@wendy>
References: <20230628131442.3022772-1-sameo@rivosinc.com>
 <20230628131442.3022772-4-sameo@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jHRuTEvE7B4wrY25"
Content-Disposition: inline
In-Reply-To: <20230628131442.3022772-4-sameo@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--jHRuTEvE7B4wrY25
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 03:14:35PM +0200, Samuel Ortiz wrote:
> The Zkr extension is ratified and provides 16 bits of entropy seed when
> reading the SEED CSR.
>=20
> We can implement arch_get_random_seed_longs() by doing multiple csrrw to
> that CSR and filling an unsigned long with valid entropy bits.
>=20
> Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--jHRuTEvE7B4wrY25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKbCjgAKCRB4tDGHoIJi
0rUUAQD2SibyQT5ig13MedvYPovD5MwTLc3X3FPiCRKhEyiGNgEAxh2SNdG5Av37
RK24M0lgtLEsw/YArvcqo8AUYAdAIA8=
=Pwkn
-----END PGP SIGNATURE-----

--jHRuTEvE7B4wrY25--
