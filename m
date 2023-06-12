Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66E672B955
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbjFLH5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbjFLH4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:56:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DDFD7;
        Mon, 12 Jun 2023 00:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686556545; x=1718092545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jA7o0JwUUEMJ7PGR+QxIapP6oJQeu3JEWSvSB5PLVFc=;
  b=QWSEEmcmDtvqKK0SVzq5Xgn82KAdXipA3pgdMj40AYeNdFXU5trIQozl
   yErMsqC3cBqCIarp6dvtcAJg0kOvlgZYL69Afn7TS2fqa9W3uNzIHJ6WT
   V1IMaHCnsvX2z1QA5PtSe9JexrSVrecQIaVlgMBOlVsHvVzt1hioOhtzt
   Mlr1e+5Oev03wW0ihat/TEFsQAHiH9GutEyrHRgXjwEl95kqCYXISx/oe
   WdzhkvOpwJGwW1KXlC20kwGACgpXDsFCKPDhtI4KCheWmiJi6vMFWIyqK
   RHCV3gGQNcKtIornqIRvrOBtWJnI+IF9J2CCDmAzmsrzIVUDrKbCxmv/M
   A==;
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="asc'?scan'208";a="229595197"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jun 2023 00:55:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 12 Jun 2023 00:55:05 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 12 Jun 2023 00:55:02 -0700
Date:   Mon, 12 Jun 2023 08:54:36 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Maksim Kiselev <bigunclemax@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 3/3] riscv: dts: allwinner: d1: Add thermal sensor and
 thermal zone
Message-ID: <20230612-wriggle-remindful-89d5105c94ee@wendy>
References: <20230612063429.3343061-1-bigunclemax@gmail.com>
 <20230612063429.3343061-4-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VdbpNF3ZZ/nmLTbI"
Content-Disposition: inline
In-Reply-To: <20230612063429.3343061-4-bigunclemax@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--VdbpNF3ZZ/nmLTbI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 09:34:19AM +0300, Maksim Kiselev wrote:
> From: Maxim Kiselev <bigunclemax@gmail.com>
>=20
> This patch adds a thermal sensor controller node for the D1/T113s.
> Also it adds a THS calibration data cell and thermal zone.
>=20
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>

The RISC-V patchwork automation is complaining about this patch while
running dtbs_check:
arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dtb: thermal-zones: cpu=
-thermal: 'trips' is a required property
	From schema: Documentation/devicetree/bindings/thermal/thermal-zones.yaml


Cheers,
Conor.

--VdbpNF3ZZ/nmLTbI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIbPPAAKCRB4tDGHoIJi
0ibyAQCc2Wg5AsmDCSijdOu5bt0CIG4+oV84B4Zg3GCvq/B54QEAxeQLtUBX8gk3
dSYcrQQGLBN0lJ0DSEYtSDsFq2awGQU=
=36LZ
-----END PGP SIGNATURE-----

--VdbpNF3ZZ/nmLTbI--
