Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6906D1DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjCaKZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjCaKYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:24:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79B621A85;
        Fri, 31 Mar 2023 03:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680258126; x=1711794126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O97ADEtm/OjO7nPRNILELGyEc11czzC4AfiYhLq7BVU=;
  b=HmgZ2yvpCgu50LcQ0XZdjkdbu8zEj0yTXiq1sYpUSN3f4wrFbmtQ0XDG
   YIDq4+uHX/6nbnH1hkO/rgDCcCR60riM5mOkesZFqyiLW0SiD+9WFsgXE
   SS0NXziZJSAy5hT5dPIs5r4yUB/Ap1Vs0JYGPq/zVp/StDNf/M2tb6Z9n
   HgOB44RS2JS5WH2PI3Oy5aPIIMJ8g+ghSGRdywYoHCoQR4q7T4m5hnlXc
   KPmh9hnbbp3grfaG3Plg2R0optrAkrYCQDTpeNQIVbaMLXT/MnJiVv7eT
   1DMSgRP0YxBAMNVvcJymWfZ5JkXR8Jh0c7tErM2KvKB064ScKoJ49iQZw
   w==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673938800"; 
   d="asc'?scan'208";a="207167804"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2023 03:22:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 03:22:05 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 31 Mar 2023 03:22:02 -0700
Date:   Fri, 31 Mar 2023 11:21:48 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        <linux-riscv@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 4/6] dt-bindings: cache: r9a07g043f-l2-cache: Add DT
 binding documentation for L2 cache controller
Message-ID: <65394572-33ae-4241-8936-0ccc8353d1a2@spud>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZaakkSvjL3VDjlgv"
Content-Disposition: inline
In-Reply-To: <20230330204217.47666-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ZaakkSvjL3VDjlgv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

$subject: t-bindings: cache: r9a07g043f-l2-cache: Add DT binding documentation for L2 cache controller
                             ^^^^^^^^^^^^^^^^^^^
I assume this should be updated to be ax45mp-foo instead?

Cheers,
Conor.

--ZaakkSvjL3VDjlgv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCa0PAAKCRB4tDGHoIJi
0p5iAP9SWWenRmTwVMmV5yA0RKo8s1JsMjzzWaOTHtxbXLVfuAEArMTwVtQ8gzTS
RxcRbytq2gWtJbpyS6svV1wo0kiDews=
=ilmE
-----END PGP SIGNATURE-----

--ZaakkSvjL3VDjlgv--
