Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F1E732D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbjFPKNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjFPKN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:13:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBA5AC;
        Fri, 16 Jun 2023 03:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686910408; x=1718446408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YpSM1w+IYXXoUKSojagF+UoCf/8hiOK0HsM860yz38E=;
  b=x8GaDBO93AJNI8beGQfsCylbIlpJpJ1JtTbkYnJJ2VixP1g/c5tHwlEj
   mwOZMy22M9szW7tj+PWRko9VdMntMEmJFxSQpEQ4Xsni6N08QnyrdPoED
   whnePP9zBT/opuxDiSo4b9Ny+Yk0MtQKtAPnLrsb1C6YBl4WmampdEPFn
   yvsGfErYNlmY+mUPjHVyKvQaMY5hH48//RmX0EDWaqsGz+8V7I7wUs1hs
   oOQQo2zb74lZjeIAuHA4Xkwbz5TGKPPauPSyMeLyaUqSm3E5m7hWXtzUi
   3Xj+AC/Of7TGmjYdIX3lrYtQ4GuMEbhWxoyPzdcztwmRfZpEQHId0OqsP
   w==;
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="asc'?scan'208";a="157251792"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2023 03:13:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 16 Jun 2023 03:13:27 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 16 Jun 2023 03:13:23 -0700
Date:   Fri, 16 Jun 2023 11:12:57 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Eric Lin <eric.lin@sifive.com>
CC:     <conor@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <maz@kernel.org>, <chenhuacai@kernel.org>,
        <baolu.lu@linux.intel.com>, <will@kernel.org>,
        <kan.liang@linux.intel.com>, <nnac123@linux.ibm.com>,
        <pierre.gondois@arm.com>, <huangguangbin2@huawei.com>,
        <jgross@suse.com>, <chao.gao@intel.com>, <maobibo@loongson.cn>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dslin1010@gmail.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>, Nick Hu <nick.hu@sifive.com>
Subject: Re: [PATCH 2/3] soc: sifive: Add SiFive private L2 cache PMU driver
Message-ID: <20230616-revision-speed-a83dc926b334@wendy>
References: <20230616063210.19063-1-eric.lin@sifive.com>
 <20230616063210.19063-3-eric.lin@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ElvD8fTDzec/LOV5"
Content-Disposition: inline
In-Reply-To: <20230616063210.19063-3-eric.lin@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ElvD8fTDzec/LOV5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2023 at 02:32:09PM +0800, Eric Lin wrote:
> From: Greentime Hu <greentime.hu@sifive.com>
>=20
> This adds SiFive private L2 cache PMU driver. User
> can use perf tool to profile by event name and event id.
>=20
> Example:
> $ perf stat -C 0 -e /sifive_pl2_pmu/inner_acquire_block_btot/
>                 -e /sifive_pl2_pmu/inner_acquire_block_ntob/
>                 -e /sifive_pl2_pmu/inner_acquire_block_ntot/ ls
>=20
>  Performance counter stats for 'CPU(s) 0':
>=20
>                300      sifive_pl2_pmu/inner_acquire_block_btot/
>              17801      sifive_pl2_pmu/inner_acquire_block_ntob/
>               5253      sifive_pl2_pmu/inner_acquire_block_ntot/
>=20
>        0.088917326 seconds time elapsed
>=20
> $ perf stat -C 0 -e /sifive_pl2_pmu/event=3D0x10001/
>                 -e /sifive_pl2_pmu/event=3D0x4001/
>                 -e /sifive_pl2_pmu/event=3D0x8001/ ls
>=20
>  Performance counter stats for 'CPU(s) 0':
>=20
>                251      sifive_pl2_pmu/event=3D0x10001/
>               2620      sifive_pl2_pmu/event=3D0x4001/
>                644      sifive_pl2_pmu/event=3D0x8001/
>=20
>        0.092827110 seconds time elapsed
>=20
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Nick Hu <nick.hu@sifive.com>
> ---
>  drivers/soc/sifive/Kconfig            |   9 +
>  drivers/soc/sifive/Makefile           |   1 +
>  drivers/soc/sifive/sifive_pl2.h       |  20 +
>  drivers/soc/sifive/sifive_pl2_cache.c |  16 +
>  drivers/soc/sifive/sifive_pl2_pmu.c   | 669 ++++++++++++++++++++++++++

Perf drivers should be in drivers/perf, no?

Cheers,
Conor.

--ElvD8fTDzec/LOV5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIw1qQAKCRB4tDGHoIJi
0q20AP0SJ+XMu+AbrLQcuJNmsYqvVW9wc6xBagHa9pzRoEw0mwD+K5s2+gB8wow+
BqnI6l1BRUx8VsrF6VfTnTaE4ZlUJQM=
=YDC2
-----END PGP SIGNATURE-----

--ElvD8fTDzec/LOV5--
