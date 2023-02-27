Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50846A4216
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 13:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjB0M42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 07:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjB0M40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 07:56:26 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708891CF71;
        Mon, 27 Feb 2023 04:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677502585; x=1709038585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SYzO1Z5QiAchp6VlN8dlhG1cZc1ViNp1xpnQxa5rYlA=;
  b=whhPiTvRV8SCNiS13Zw1r6cz03GFz4J/Q9OUbE11dmPTdKC+Ys7GoqKY
   NpbQj1wRGO/zjzARMs3uVYmZGfuFgDWJsrafS0PcCZwLXHqkJpj1RbfVy
   VuiXa+dNqWaJ4lpd5d8sAEgorKHKIxXh66Ly+dC5KTt1qjInfwujnlH6b
   KO5uoqyZH/HmEtInxF8QuPtwx2bvfdVfY5MjWOU0JS7TZn4jss1sBoLTv
   bumcto7oY2fqBcV8TUiB8zTXBx4ipC8EBG3wvJSqMok+06I6kL3HwOklN
   b0Uh4W1T2e62rBWNGf1DF0IlZQ5KBjzMNO+sCdEFwQqlxNq12mL1uI3no
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,332,1669100400"; 
   d="asc'?scan'208";a="202388109"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Feb 2023 05:56:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 05:56:23 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 27 Feb 2023 05:56:21 -0700
Date:   Mon, 27 Feb 2023 12:55:54 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Song Shuai <suagrfillet@gmail.com>
CC:     <corbet@lwn.net>, <alexs@kernel.org>, <siyanteng@loongson.cn>,
        <robh@kernel.org>, <palmer@rivosinc.com>,
        <leyfoon.tan@starfivetech.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] sched/doc: supplement CPU capacity with RISC-V
Message-ID: <Y/yoWt+Y7n8/A6m9@wendy>
References: <20230227105941.2749193-1-suagrfillet@gmail.com>
 <Y/yagE7jfRGo1FgY@wendy>
 <CAAYs2=jSt9=d=N98DCVvtNA9FE6KcVYVdHPG-wpuDPknBFUndQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wnAnL+HDoyre5KCO"
Content-Disposition: inline
In-Reply-To: <CAAYs2=jSt9=d=N98DCVvtNA9FE6KcVYVdHPG-wpuDPknBFUndQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--wnAnL+HDoyre5KCO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2023 at 12:40:45PM +0000, Song Shuai wrote:
> Conor Dooley <conor.dooley@microchip.com> =E4=BA=8E2023=E5=B9=B42=E6=9C=
=8827=E6=97=A5=E5=91=A8=E4=B8=80 11:57=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Mon, Feb 27, 2023 at 06:59:41PM +0800, Song Shuai wrote:
> > > This commit 7d2078310cbf ("dt-bindings: arm: move cpu-capacity to a
> > > shared loation") updates some references about capacity-dmips-mhz
> >
> > Not requesting a respin for this, but mentioning commit 991994509ee9
> > ("dt-bindings: riscv: add a capacity-dmips-mhz cpu property") is
> > probably more relevant as a justification for this change.
> >
> Thanks for your correction, I'll pay attention next time.
>=20
> I have a question about the patch you mentioned:
> The patch uses cpu_scale per_cpu variable to store the CPU capacity
> through arch_topology,
> But arch_scale_cpu_capacity() interface seems not defined to deliver
> the cpu_scale to the scheduler
> In contrast, arm64 defines it as the topology_get_cpu_scale() in its
> arch/arm64/include/asm/topology.h.
> Is this an oversight or a particular purpose?

Intentional oversight I suppose? It wasn't my intention to do anything
other than document the property that people were already using in
their devicetrees (and finding bugs with!).
In retrospect, perhaps it is better if I un-review this patch until
we know it is plumbed into the scheduler properly?

Ley Foon Tan is the one that found the RISC-V bugs with this property in
their devicetree, so perhaps they've already done the work here?

Thanks,
Conor.

--wnAnL+HDoyre5KCO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/yoWgAKCRB4tDGHoIJi
0lWMAP9MODOvtDm5vvcJ/DtkXxIsbk5s7zLjS+U2FljJQmwtiAD/bGwqZS4S3cwB
OaA5EaPDOFOMmnwePguHgv/seh1dFAM=
=ZDSm
-----END PGP SIGNATURE-----

--wnAnL+HDoyre5KCO--
