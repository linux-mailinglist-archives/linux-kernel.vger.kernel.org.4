Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643B26A4141
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 12:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjB0L5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 06:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB0L5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:57:22 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2757BAD15;
        Mon, 27 Feb 2023 03:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677499039; x=1709035039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OYWmC+11VkZ07K9SxaUsII3U3gMEbonSgeOzevEiM9w=;
  b=bJ9Vci8cErnadxxIVKZNe5esHuvRBAtMyZb9qiUbw6Pv9iDgPTY5uYP7
   d6+fONMTgixAJYmboGqQfyG+PwIo251neOtRh/Z+Mra0XVp/kMiGnfQH5
   /0tFEj57KWItbO7WUttQatPfuWcB41X+jKu+AnuSkNzlA9ig8b6NgYGBe
   uYXSecPgs59X8yc3X8+iLsLvpcfTrI7RLu+8Ngk/IpvwsNWLGln5qjMfY
   DjwqlN+ggTAENh3p19DP0QVEwbGpTYY2lOBMOhdSsxlM/TycYSa67HpRX
   pw41gZkBrMPB+H1ln+s4z843rry9YPOK0IIMO1hyvAJLZBLEgNzgjqCf0
   w==;
X-IronPort-AV: E=Sophos;i="5.97,331,1669100400"; 
   d="asc'?scan'208";a="198902334"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Feb 2023 04:57:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 04:57:16 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 27 Feb 2023 04:57:15 -0700
Date:   Mon, 27 Feb 2023 11:56:48 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Song Shuai <suagrfillet@gmail.com>
CC:     <corbet@lwn.net>, <alexs@kernel.org>, <siyanteng@loongson.cn>,
        <robh@kernel.org>, <palmer@rivosinc.com>,
        <leyfoon.tan@starfivetech.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] sched/doc: supplement CPU capacity with RISC-V
Message-ID: <Y/yagE7jfRGo1FgY@wendy>
References: <20230227105941.2749193-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qu+vqTjLVyvhigH7"
Content-Disposition: inline
In-Reply-To: <20230227105941.2749193-1-suagrfillet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Qu+vqTjLVyvhigH7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2023 at 06:59:41PM +0800, Song Shuai wrote:
> This commit 7d2078310cbf ("dt-bindings: arm: move cpu-capacity to a
> shared loation") updates some references about capacity-dmips-mhz

Not requesting a respin for this, but mentioning commit 991994509ee9
("dt-bindings: riscv: add a capacity-dmips-mhz cpu property") is
probably more relevant as a justification for this change.

> property in this document.
>=20
> The list of architectures using capacity-dmips-mhz omits RISC-V, so
> supplements it here.
>=20
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>  Documentation/scheduler/sched-capacity.rst                    | 2 +-
>  Documentation/translations/zh_CN/scheduler/sched-capacity.rst | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/scheduler/sched-capacity.rst b/Documentation/s=
cheduler/sched-capacity.rst
> index 8e2b8538bc2b..e2c1cf743158 100644
> --- a/Documentation/scheduler/sched-capacity.rst
> +++ b/Documentation/scheduler/sched-capacity.rst
> @@ -258,7 +258,7 @@ Linux cannot currently figure out CPU capacity on its=
 own, this information thus
>  needs to be handed to it. Architectures must define arch_scale_cpu_capac=
ity()
>  for that purpose.
> =20
> -The arm and arm64 architectures directly map this to the arch_topology d=
river
> +The arm, arm64, and RISC-V architectures directly map this to the arch_t=
opology driver

My grep clearly missed this change, thanks.
For the only part of the patch I understand:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--Qu+vqTjLVyvhigH7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/yacQAKCRB4tDGHoIJi
0jMuAPUS3U8wKt0dDvUC5JFcU2VrD5RRUuYkkJESmDvd+oMvAPsE9NZjwV40Eqvv
MRChuLnLfK6qyIngBouG73xf0TMeBQ==
=v5xR
-----END PGP SIGNATURE-----

--Qu+vqTjLVyvhigH7--
