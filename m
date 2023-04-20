Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51946E8FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbjDTKV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbjDTKV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:21:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA284C30;
        Thu, 20 Apr 2023 03:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681986026; x=1713522026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p04UFiXEk3VmCHfHIzOZk2Ms3A+ezDFOWY1y5ayhRR0=;
  b=kzmaXkhdAzZsybw377rJ8D2Bl6b5eGjOwhcalyRgVao6MrDvn5jC+qfe
   R54/CDmfbGdGdpzarOHFKbW3UfT0d0ib0c0lfotlPIRG0MMLrev33yAS2
   1vg/TKYRK6DiIwDV+X2jSyDkT/RFmhLU/I1HMcKUFCj1tiOUED5ndmxrd
   s/DVPVKClWXvRs7ZCrjPPjsqZuBcPwge7z241pjNV5+sqZ6CjvjHTGh4I
   FBqRNC3R5Fx/557dga1UgOF+5bcanqyxFS1qoPrjWoPRJDTtup08PacwU
   12FU5sCvJPNKqdkc/d+R4GAnnDf4JHQ99JU0GbkTrt+BISXROBZdOoAEw
   w==;
X-IronPort-AV: E=Sophos;i="5.99,212,1677567600"; 
   d="asc'?scan'208";a="221784309"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Apr 2023 03:20:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 20 Apr 2023 03:20:25 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 20 Apr 2023 03:20:22 -0700
Date:   Thu, 20 Apr 2023 11:20:05 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Nylon Chen <nylon.chen@sifive.com>
CC:     <aou@eecs.berkeley.edu>, <conor@kernel.org>,
        <emil.renner.berthing@canonical.com>, <geert+renesas@glider.be>,
        <heiko@sntech.de>, <krzysztof.kozlowski+dt@linaro.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nylon7717@gmail.com>,
        <zong.li@sifive.com>, <greentime.hu@sifive.com>,
        <vincent.chen@sifive.com>
Subject: Re: [PATCH v3 1/2] riscv: dts: sifive: unleashed/unmatched: Remove
 PWM controlled LED's active-low properties
Message-ID: <20230420-backshift-negotiate-1c3d508582d2@wendy>
References: <20230420093457.18936-1-nylon.chen@sifive.com>
 <20230420093457.18936-2-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pPcnETLhjtC5Ocdl"
Content-Disposition: inline
In-Reply-To: <20230420093457.18936-2-nylon.chen@sifive.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--pPcnETLhjtC5Ocdl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2023 at 05:34:56PM +0800, Nylon Chen wrote:
> This removes the active-low properties of the PWM-controlled LEDs in
> the HiFive Unmatched device tree.
>=20
> The reference is hifive-unleashed-a00.pdf[0] and hifive-unmatched-schemat=
ics-v3.pdf[1].
>=20
> Link: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf845=
3f8698_hifive-unleashed-a00-schematics-1.pdf [0]
> Link: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce7=
6f4192_hifive-unmatched-schematics-v3.pdf [1]
>=20

Just a minor nit here, there should not be a blank line between the
link:s and the rest of the trailers.

Cheers,
Conor.

--pPcnETLhjtC5Ocdl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEER1QAKCRB4tDGHoIJi
0pdYAQCPVswMeIM5oND35Up46NzXuOHouWn5KIqzUs0HHAlgLQD/QKvS9/hYcyAB
eE/lmP3GQ/5SacVC8RcfI3No2qzVJQI=
=PEvj
-----END PGP SIGNATURE-----

--pPcnETLhjtC5Ocdl--
