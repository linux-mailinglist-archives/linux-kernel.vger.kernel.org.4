Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632B173DBFD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjFZKDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjFZKD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:03:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2202CF3;
        Mon, 26 Jun 2023 03:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687773808; x=1719309808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ndQQSMrh9qi21D5rzuuijKcs6vOrnsiA7XIKSTAl9wU=;
  b=IGhCvnrkG8ARZjh1VnD8f6l8UEMzcv4+t48fUUuHiXceWmRqcyBmei7X
   x67N3n7OC/6O6DR9r48CyntgZBpsg5itZKv3EdMPZgedomSAyGne59tar
   et1dOMI9L5kEQ2aXuL9wAxuGCvgiW9I5JqoLfN4o3MkHmDdscgxMfYiqV
   f3a8bdHxDoaHCsI6fm1byE7Sl31jI410idZvH9IPaH7EsJ50z5kR/Wesv
   oo0/al/EYoia3JpwFfVhn4YhyC+q7BWzeM2fh3TyYhWCNAJqd9mU9AcMB
   bFo6rFTSPdjxP18VF0cuxPCAU4R2X+Iymv14fRM3uqKO/PxjXxiHBZ0YO
   w==;
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="asc'?scan'208";a="217659769"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2023 03:03:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 26 Jun 2023 03:03:25 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 26 Jun 2023 03:03:23 -0700
Date:   Mon, 26 Jun 2023 11:02:55 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lucas Tanure <tanure@linux.com>
Subject: Re: [PATCH 0/2] Baisc devicetree support for Amlogic T7
Message-ID: <20230626-viewless-marrow-17838c2172f6@wendy>
References: <20230626095223.721011-1-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ubNKkfHy8zvqeN3N"
Content-Disposition: inline
In-Reply-To: <20230626095223.721011-1-xianwei.zhao@amlogic.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ubNKkfHy8zvqeN3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Mon, Jun 26, 2023 at 05:52:21PM +0800, Xianwei Zhao wrote:
> T7 is an advanced application processor designed for smart display.
>=20
> Add the new T7 SoC/board device tree bindings.
>=20
> Add basic support for the T7 based Amlogic AN400 board, which describes
> the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
> booting up into the serial console.

Lucas has already sent patches for the T7 SoC & is at v5:
https://lore.kernel.org/linux-devicetree/20230623081242.109131-1-tanure@lin=
ux.com/

There's been a bit of discussion there, and there serial stuff in
particular is different in his series (it doesn't use always-on for
examples).
Could you please go and take a look at his series?

Cheers,
Conor.

>=20
> Xianwei Zhao (2):
>   dt-bindings: arm: amlogic: add T7 based AN400 bindings
>   arm64: dts: add support for T7 based Amlogic AN400
>=20
>  .../devicetree/bindings/arm/amlogic.yaml      |   6 +
>  arch/arm64/boot/dts/amlogic/Makefile          |   1 +
>  .../dts/amlogic/amlogic-t7-a311d2-an400.dts   |  30 ++++
>  arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   | 156 ++++++++++++++++++
>  4 files changed, 193 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.d=
ts
>  create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>=20
>=20
> base-commit: 057889cb4244096ea5abcbe76ffd4d311c3078fe
> --=20
> 2.37.1
>=20

--ubNKkfHy8zvqeN3N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJliTwAKCRB4tDGHoIJi
0r3GAPwN8BOPsz32j+YhMZbfTzQJ27DXHYrrA6ARa465C0tCIQD7B7wRgd2djDnj
rRtZKb8Mgt3O6Pi8KuvDXh9pRwgqfQE=
=9w1Y
-----END PGP SIGNATURE-----

--ubNKkfHy8zvqeN3N--
