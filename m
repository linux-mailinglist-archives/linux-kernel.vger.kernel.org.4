Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610F67327E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242116AbjFPGxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjFPGxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:53:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1D11FE8;
        Thu, 15 Jun 2023 23:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686898386; x=1718434386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DfP80aMX1lRvp8K1WgBYcBrOAn2IwplXBMRbzSQMTDY=;
  b=nAnXo1/thGtdTJpt8Wxb4QTlYrDSnerJFVQat+Q0Y3+0Lf/xNzVVzxrB
   /F0pAxCVtZeSWp5ytlQU8wevgUssP4LPyNe7gFpuEfLrwjV5GS0xK3kIU
   xAWdHIZyJNGxsXHuf3DoKurMKJAbIBsTW0WxvQ69bkdA4FbUwyf7GIhGo
   y8ui3SE2FzPQHIGOIQK62RJ/3QfeCcMTXFG76EkmQTs62Wbog7pV6krmJ
   1cZ2JiZogZhjrgPTwv6BxPqqO2mfO8oSiEDy2qzP4xmP78qp8wlzLoPU4
   ZDfeZ0vsbFewq8Kn381eRfUhuUZyViDXwqJanHJUIf08W9acxmLBSiytU
   w==;
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="asc'?scan'208";a="218198302"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2023 23:53:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 15 Jun 2023 23:53:06 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 15 Jun 2023 23:53:03 -0700
Date:   Fri, 16 Jun 2023 07:52:37 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     zhuyinbo <zhuyinbo@loongson.cn>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <loongarch@lists.linux.dev>, Jianmin Lv <lvjianmin@loongson.cn>,
        <wanghongliang@loongson.cn>, Liu Peibao <liupeibao@loongson.cn>,
        <loongson-kernel@lists.loongnix.cn>
Subject: Re: [PATCH v3 3/3] soc: loongson2_pm: add power management support
Message-ID: <20230616-renewal-protract-78c3958f25db@wendy>
References: <20230615091757.24686-1-zhuyinbo@loongson.cn>
 <968b7c81-a24e-1e0d-31a4-f633a82d17b0@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iP03JPSlBlXaHcqU"
Content-Disposition: inline
In-Reply-To: <968b7c81-a24e-1e0d-31a4-f633a82d17b0@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--iP03JPSlBlXaHcqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 05:37:18PM +0800, zhuyinbo wrote:
> From 6edcb9d6a1b18ccbecaf283b4f543afc9e7126d6 Mon Sep 17 00:00:00 2001
> From: Yinbo Zhu <zhuyinbo@loongson.cn>
> Date: Tue, 18 Apr 2023 14:18:00 +0800
> Subject: [PATCH v3 3/3] soc: loongson2_pm: add power management support
>=20
> The Loongson-2's power management controller was ACPI, supports ACPI
> S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To
> Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up methods
> (USB, GMAC, PWRBTN, etc.). This driver was to add power management
> controller support that base on dts for Loongson-2 series SoCs.
>=20
> Signed-off-by: Liu Yun <liuyun@loongson.cn>
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>

3 SoBs, should 2 of these have corresponding co-developed-bys?

--iP03JPSlBlXaHcqU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIwGtQAKCRB4tDGHoIJi
0qo+AQDEcsnXEK+TzB141FVZZK/bIeAQVbsVMSYqMCNyjDcNiAEAifjrCdvsuUOO
6GHuexf14yzPAw3u0jvbilovsBQFpAA=
=mq2y
-----END PGP SIGNATURE-----

--iP03JPSlBlXaHcqU--
