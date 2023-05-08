Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21436FA0B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjEHHKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjEHHKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:10:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A35D1A113;
        Mon,  8 May 2023 00:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683529801; x=1715065801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gIJQeimsaJg9aD/2efIKyUiZi5Rpjyt1p5VyLjuLh18=;
  b=dbM+RMNL490k5OVTR3iWNxEGYuMnH9nA4ns1+iyqFbGwkDUDPk0ek5eU
   th2YdrH+q+fevkcGPB0/Cjta8+vHgZNs7EHtCO/osXYvVbcov9r2IKTxj
   XeXXwL6s+7vGRxsOx8ScbVNas4HKxhjDVEdogRnkZTg4qzOm7+NdZv5ep
   H49VlFILCWMio9USdTJ5F+GSEe7wsdAugTaWyQXyVjFSGohVSBKQtmLMO
   6w3k+kLK/gKIC2Au5zTqxCuAXzMhfJMGP0menSF5F8Lw/RcmGfFrViSgD
   LUCNDYnlTeS6DUlDnj/7q6K0dk/P1vwApva/aPDQUdttLPI7S3qWNMLwY
   w==;
X-IronPort-AV: E=Sophos;i="5.99,258,1677567600"; 
   d="asc'?scan'208";a="224269826"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 May 2023 00:08:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 8 May 2023 00:07:59 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 8 May 2023 00:07:57 -0700
Date:   Mon, 8 May 2023 08:07:37 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Guo Ren <guoren@kernel.org>
CC:     Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 1/5] irqchip/sifive-plic: Support T-HEAD's C910 PLIC
Message-ID: <20230508-shining-slug-ac097b6e84ae@wendy>
References: <20230507182304.2934-1-jszhang@kernel.org>
 <20230507182304.2934-2-jszhang@kernel.org>
 <CAJF2gTTni=G5FP80rSArErXGWQatR1P8rCy9nNOggeA4vtXftQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7VenwF0zXlIg4UWR"
Content-Disposition: inline
In-Reply-To: <CAJF2gTTni=G5FP80rSArErXGWQatR1P8rCy9nNOggeA4vtXftQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--7VenwF0zXlIg4UWR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 08, 2023 at 02:52:29PM +0800, Guo Ren wrote:

> Another question, Could we change the name of Sifive to RISC-V when
> "cat /proc/interrupts" ?

Previously NAKed by Marc as it is ABI:
https://lore.kernel.org/all/20511a05f39408c8ffbcc98923c4abd2@kernel.org

Cheers,
Conor.

--7VenwF0zXlIg4UWR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFifuQAKCRB4tDGHoIJi
0h/FAQD5GQTBSDo5ioR96jkLYSfHS+30cKqxlbjj1g/5O8mwYwD/dNHbabmC3eDn
FM78yqmpsQLOkYOMt/l/5SXnme+0Cws=
=jZRC
-----END PGP SIGNATURE-----

--7VenwF0zXlIg4UWR--
