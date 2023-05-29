Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C0F714BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjE2OKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjE2OJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:09:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD5C189;
        Mon, 29 May 2023 07:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685369361; x=1716905361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LAVqjlT5utdt7DMAuhjbEVwZtJU7/LMN9PRrAurEyvg=;
  b=rB0CtnHk120np1L9XOffh6sZGCR8t2iltIyYNozqD8POsr916cknR1FT
   Q6wsnWXYXW3N7YREX9HRb3t9QKdR1RdpP9S3sKWwrWs9rD5KU/ZIHoKN7
   8V+/vTevAOyAS9gQL9wqb8/j87W1E6eYc/VfrmqtA8CBJIAfPYMWcBXe7
   s4+TITkUx2jCcH7V5oWIiT4ucEEkYC5a7mkIxIMvfrXwbFPxj6yUHImCI
   rCk6bRHFIf3P5LQ2frG+OHCSzeWbmyB6U7tjknniQrg8G3rTNCPv15On2
   pQiJE0UK2ZuVHEbpRveNh0UjhUPHDjys59fVY/MGf11v+vkcO/1FphlqL
   g==;
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="asc'?scan'208";a="215915290"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 07:08:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 07:08:27 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 29 May 2023 07:08:25 -0700
Date:   Mon, 29 May 2023 15:08:02 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v5 0/3] Add JH7110 MIPI DPHY RX support
Message-ID: <20230529-unsocial-activity-9607a9bd3989@wendy>
References: <20230529121503.3544-1-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4H1iVI5dF5NIHXlZ"
Content-Disposition: inline
In-Reply-To: <20230529121503.3544-1-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--4H1iVI5dF5NIHXlZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2023 at 05:15:00AM -0700, Changhuang Liang wrote:
> This patchset adds mipi dphy rx driver for the StarFive JH7110 SoC.
> It is used to transfer CSI camera data. The series has been tested on
> the VisionFive 2 board.
>=20
> This patchset should be applied after the patchset [1] [2]:
> [1] https://lore.kernel.org/all/20230518101234.143748-1-xingyu.wu@starfiv=
etech.com/
> [2] https://lore.kernel.org/all/20230519060202.15296-1-changhuang.liang@s=
tarfivetech.com/

Are these are only relevant for the dts patch, or for the whole series?

Cheers,
Conor.

--4H1iVI5dF5NIHXlZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHSxwgAKCRB4tDGHoIJi
0igiAQDlI6QDJUu3TjNTah9m7r7vTP0f6tbn/FptSpaZv8dd8gD/aEP+zW8afHh4
LJAt5Ixm+bsLZIzvHRqxm4SBRxVnEQk=
=GyfD
-----END PGP SIGNATURE-----

--4H1iVI5dF5NIHXlZ--
