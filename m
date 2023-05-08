Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DB66FA069
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjEHHCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjEHHCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:02:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E438130EA;
        Mon,  8 May 2023 00:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683529326; x=1715065326;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hdj4TzgRhzV/x+XxHlljcCtlZHqEWc7KZNXoQ5/botI=;
  b=ES1ZOKtqMqCR3yPAGJCSWTKUW6HPWHofZtS6awFjrLIyHaOzclDIft39
   dldZCUMSnK3iev/I7NxH3/ETNjjoCTFD+ccch4x5/gi8PhF51lgz5XOCB
   FWqxrNJIxbYkJy2oQBI7lH3bFZtFLNdVmrfLMtl2MQDQhvqgVoeXoZ2cl
   YPKPkcFbSphs1bA9csa8kH0rqtAysCfRbXycFf/Ve6eiwRZrtT8KH0SLy
   QI/Ui5QOADh+l0gMHDS0oOVeP8+aQAh57iVwlYTKT2rlxdK4JJ/VEiL9Z
   ASPHN4sNDETolMJJ6WgJUWdUl2Eyh/y/Udtm1CeMkGEvfKUQ6W0I2hauY
   w==;
X-IronPort-AV: E=Sophos;i="5.99,258,1677567600"; 
   d="asc'?scan'208";a="212855997"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 May 2023 00:02:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 8 May 2023 00:02:03 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 8 May 2023 00:02:01 -0700
Date:   Mon, 8 May 2023 08:01:41 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Icenowy Zheng <uwu@icenowy.me>
CC:     Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, Guo Ren <guoren@kernel.org>,
        <heiko@sntech.de>
Subject: Re: [PATCH 3/5] riscv: dts: add initial T-HEAD light SoC device tree
Message-ID: <20230508-deviator-departed-55af603e50c6@wendy>
References: <20230507182304.2934-1-jszhang@kernel.org>
 <20230507182304.2934-4-jszhang@kernel.org>
 <20230507-calamari-gentleman-bbe62af06f92@spud>
 <394696a52bf1d767044e3f990cebfbaf69dabe70.camel@icenowy.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ALAuARajoO6A4R1+"
Content-Disposition: inline
In-Reply-To: <394696a52bf1d767044e3f990cebfbaf69dabe70.camel@icenowy.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ALAuARajoO6A4R1+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 08, 2023 at 11:32:17AM +0800, Icenowy Zheng wrote:

> P.S. which one is preferred by DT binding maintainers, the marketing
> name or the codename?

I don't see the benefit of using internal product codenames (even if it
did appear on their gitee) over the name by which it'll appear in board
datasheets etc etc.

Cheers,
Conor.

--ALAuARajoO6A4R1+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFieVQAKCRB4tDGHoIJi
0gpSAP9HMdmnHVMuFAiBvTS7zPx1QXPED1lHmFJ801dZR6FXUwEA6B+p+yA5dAYb
WcAMknoDtM3tL5ZpSUEfOSlY9jB8wQQ=
=LqF2
-----END PGP SIGNATURE-----

--ALAuARajoO6A4R1+--
