Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D8A74571A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjGCIRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjGCIRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:17:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A3FC5;
        Mon,  3 Jul 2023 01:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688372230; x=1719908230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hxLRx7MJ808MUU2NcCaCNzOa2IUOEx/fbiFCPUlHJNY=;
  b=iicbL266l8AT2U6HbIaJngaUw3TPfa+jKfJm3+MQY8RBrk3VIU7EnQ7l
   TRDD+sUKOBiI/FuHVOoFXcpSm+eEH7lzXop6F4p/xeLEpfi6Mo7UhcM+J
   +T9V/YiBgvV6mdtpSeCRTdpPbcC5BQzd13RRb4ZH8GMl2q6bYtlLg87GO
   zLQyzt7zmR/NrCviZd0eQd79zNnti690lUv6XD/M9L6697Ea+o4lm4biA
   x1JSLIBw7bpW98RhCu3QP7pn2c22ImvRJj4HqRZxXQnMeFV/xYPKRkNUJ
   s+0Tu2OLTwcV+ImMTsb3CiMIDWIbGw7FTaMIGVDF0w1vpulBTNfZR3bQI
   w==;
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="asc'?scan'208";a="221734702"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2023 01:17:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Jul 2023 01:17:06 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 3 Jul 2023 01:17:02 -0700
Date:   Mon, 3 Jul 2023 09:16:33 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     =?utf-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
CC:     Conor Dooley <conor@kernel.org>, <ardb@kernel.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
        <rminnich@gmail.com>, <mark.rutland@arm.com>,
        <lpieralisi@kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
        <jdelvare@suse.com>, <yc.hung@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <allen-kh.cheng@mediatek.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <tinghan.shen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <geshijian@bytedance.com>,
        <weidong.wd@bytedance.com>
Subject: Re: [External] Re: [PATCH v2 3/3] riscv: obtain SMBIOS entry from
 FFI.
Message-ID: <20230703-escapist-granny-14faea3ab0ef@wendy>
References: <20230702095735.860-1-cuiyunhui@bytedance.com>
 <20230702095735.860-3-cuiyunhui@bytedance.com>
 <20230702-confiding-aqueduct-25c3c2852de3@spud>
 <CAEEQ3wkaazkV9MrfvWQMSXixtqahgdYVe=GT9ZZJnW-r1AQ1aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BPBW6SBBuQNafGn+"
Content-Disposition: inline
In-Reply-To: <CAEEQ3wkaazkV9MrfvWQMSXixtqahgdYVe=GT9ZZJnW-r1AQ1aA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--BPBW6SBBuQNafGn+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2023 at 03:50:57PM +0800, =E8=BF=90=E8=BE=89=E5=B4=94 wrote:
> On Sun, Jul 2, 2023 at 8:42=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
> >
> > Hey,
> >
> > On Sun, Jul 02, 2023 at 05:57:34PM +0800, Yunhui Cui wrote:
> > > When we bringup with coreboot on riscv, we need to obtain
> > > the entry address of SMBIOS through the FFI scheme.
> >
> > What do you need it for?
> RISC-V will be server-oriented, and the system needs to be managed
> based on SMBIOS.

Really what this commit message is missing is something that explains
why you need the FFI scheme. Say along the lines of:

	Coreboot on RISC-V does not support EFI, and needs to use the
	FDT Firmware Interface (FFI) to pass the entry address of SMBIOS
	to the kernel.

Cheers,
Conor.

--BPBW6SBBuQNafGn+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKKD4QAKCRB4tDGHoIJi
0k2HAP9pmxxbrgHQrz6OmhH0sGOVhQtFoasv1XCYd14s7Vbq5wEAyAL2LCy+I4Bg
n7AZ/WcCZ+tcNDDs4NqNvkDFVNURsQA=
=dPYG
-----END PGP SIGNATURE-----

--BPBW6SBBuQNafGn+--
