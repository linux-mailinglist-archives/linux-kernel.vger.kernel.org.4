Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D547E71483C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjE2KyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjE2KyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:54:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA9ADC
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685357640; x=1716893640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0GG7xQh59rv35kj2DWfbqqMT5MkAeoUx7+wufm854Kc=;
  b=W3C8cNzhG5H3+XQWwp6Om6RYJ9TFUiod0KOiN1DBn4H8EAtHECJr1N7F
   R8uaKniLSJLFcQjWUXl8NwReK6GLCPNTHiK/2ShIB9BTFTS37i6rNmN9l
   6BJDZbJ3B67eqB/cb4AtTlVlpjYAKbe0wtT84PfiboZR7dfRDYZgl6b/m
   P0YI87v9L7TBS4GM4+3SCfyPj+UyvnaOCZCEMKKT81gXNQnj+EirW0cTq
   6BFAlwo0/YmSmdBrNGlXvyX08ko1DD10DLEDBG7GY+4Jl+nRAKo3oZW79
   i1Cq0pToqFaGBsnhiwOMWEAFL/xIgYZ+ldWe0AyX4oWQatUqCh/TIHNXC
   w==;
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="asc'?scan'208";a="154416048"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 03:53:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 03:53:57 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 29 May 2023 03:53:56 -0700
Date:   Mon, 29 May 2023 11:53:33 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jisheng Zhang <jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 3/6] riscv: mm: mark noncoherent_supported as
 __ro_after_init
Message-ID: <20230529-gainfully-promotion-2ad5fc7e0249@wendy>
References: <20230526165958.908-1-jszhang@kernel.org>
 <20230526165958.908-4-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hNYOrDLkJGVN45Wj"
Content-Disposition: inline
In-Reply-To: <20230526165958.908-4-jszhang@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--hNYOrDLkJGVN45Wj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 27, 2023 at 12:59:55AM +0800, Jisheng Zhang wrote:
> The noncoherent_supported indicates whether the HW is coherent or not,
> it won't change after booting, mark it as __ro_after_init.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--hNYOrDLkJGVN45Wj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHSELQAKCRB4tDGHoIJi
0ruJAQCJd3CbSBp8SNN1vC0dxORKjn8mwSILbRaoZmTDQInPLQEA65OQk3pFn8Xp
dWD1T5GU6696MQpp46flDfg4bD3e8go=
=IcbH
-----END PGP SIGNATURE-----

--hNYOrDLkJGVN45Wj--
