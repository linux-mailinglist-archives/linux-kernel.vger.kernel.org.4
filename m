Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FB6745E78
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjGCOXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjGCOXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:23:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D90FB3;
        Mon,  3 Jul 2023 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688394223; x=1719930223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+L1E/N9RqavBPrenoP9G4WVhEe4u338kfR3kCGQlQfA=;
  b=DQevfpXL2emIahI1iTsbPMz/xv1PF3c1OzXv7i5r2qNgCTXIsgDN5ntD
   DZPtWpS4u5Y5jm2iE2MHrab/02tutAh9l/yIls3Rw63cMkq0W2t2r+SJ2
   HG4IX8Skapz7YEBZ8sAzbus6Bqi70Vh6q0Fvc+mrRRxWg2pwmK572wl4n
   UvwxaRYNUnoBxtcrYHRV7psHNLQKnCaLIM/FMgMKwujlJSEWhz2COE9ng
   BiNsVeQnaeWHcdXQVvIcYu4CkWbTiI1IJrZk6ud9tdNWd3fp8hXAHTG3p
   w9sbvgQTHs443Dtab7sKlS5r/X6Xsz5i/NDcRQroWRF1oEre0N7jaM5iu
   w==;
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="asc'?scan'208";a="221805980"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2023 07:23:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Jul 2023 07:23:40 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 3 Jul 2023 07:23:36 -0700
Date:   Mon, 3 Jul 2023 15:23:07 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     =?utf-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>,
        <ardb@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <rminnich@gmail.com>,
        <mark.rutland@arm.com>, <lpieralisi@kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <jdelvare@suse.com>,
        <yc.hung@mediatek.com>, <angelogioacchino.delregno@collabora.com>,
        <allen-kh.cheng@mediatek.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <tinghan.shen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <geshijian@bytedance.com>,
        <weidong.wd@bytedance.com>
Subject: Re: [External] Re: [PATCH v2 1/3] riscv: obtain ACPI RSDP from FFI.
Message-ID: <20230703-operation-mankind-778882d8d350@wendy>
References: <20230702095735.860-1-cuiyunhui@bytedance.com>
 <20230703-71f67eb66a037f5c0fb825c6@orel>
 <CAEEQ3w=7tBHyG=CvuktPN5cvfpY6ayamnbry6eOYxMDrPN+oZg@mail.gmail.com>
 <20230703-6ac90a2de15f1017bc0ced74@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E+2R2X9wOGgH+Gca"
Content-Disposition: inline
In-Reply-To: <20230703-6ac90a2de15f1017bc0ced74@orel>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--E+2R2X9wOGgH+Gca
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2023 at 04:17:07PM +0200, Andrew Jones wrote:
> On Mon, Jul 03, 2023 at 09:30:10PM +0800, =E8=BF=90=E8=BE=89=E5=B4=94 wro=
te:
> > On Mon, Jul 3, 2023 at 9:01=E2=80=AFPM Andrew Jones <ajones@ventanamicr=
o.com> wrote:
> > >
> > >
> > > (This is a reply to a non-existent cover letter.)
> >=20
> > This has been discussed many times with Ard, Please refer to :
> > https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16-1=
-cuiyunhui@bytedance.com/
>=20
> There's nothing in that thread that convinces me this is a good idea.
> Indeed, afaict from that thread, Ard nacked this. It was only when it
> was suggested that arch/riscv would own the code, that he stopped
> complaining about it. I wouldn't call that an endorsement.

In fact, he expressly said that it would then be up to the RISC-V
maintainers as to what to do:
	But please check with the RISC-V maintainers
	if they are up for this, and whether they want to see this mechanism
	contributed to one of the pertinent specifications.


--E+2R2X9wOGgH+Gca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKLZywAKCRB4tDGHoIJi
0lN2AQDpIYP//3WSQfuOdQ5ge5coGys/iiBPLD9RjiOuc+OMJAD/bZh8USr333vM
nyvylIQXi4vnoVBU3XUmLLWvRqRzpgE=
=n7aW
-----END PGP SIGNATURE-----

--E+2R2X9wOGgH+Gca--
