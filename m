Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601AA709687
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjESL2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjESL2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:28:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CC7CF
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 04:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684495712; x=1716031712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cf7E+oHz/GLsISrXOLO5vv/QNIi3P7viGOf6I6RP7jc=;
  b=b1g/IcmhQGLdoCOx/Baw7XLoZE39/aUdaaagqV+do/SGAqelutt51N9l
   rPJPX6QdqgQFGqIzDjeEqi+U5AfYY8VVD0bfaiNRV1poGBzWncKSbO93q
   IrMuPB2CQAsHdAHREhGX/2dRL+ppxCeqZtSB/hvxmuEJJFDFfgmzxrszD
   vkx8z2/Xq00mBW8PYjENIlndzKkzpiDcvCPuQIuPii/EJG0fHMJRa6zVa
   J4OTTumzUJ8qKikjCvxBZ4SJ95+sarlNIF1nGF7X5s81iFyTDOSYXok9V
   6bDyK4umykLAoGeAN+hZM2yM+BEky9AfLqendWc4MVkp36X/MGVh1GeK4
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="asc'?scan'208";a="226063882"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2023 04:28:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 19 May 2023 04:28:30 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 19 May 2023 04:28:29 -0700
Date:   Fri, 19 May 2023 12:28:07 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>
CC:     Song Shuai <suagrfillet@gmail.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Song Shuai <songshuaishuai@tinylab.org>
Subject: Re: [PATCH] riscv: hibernation: Remove duplicate call of
 suspend_restore_csrs
Message-ID: <20230519-clarinet-collar-ba2c0fa37e11@wendy>
References: <20230519102908.253458-1-suagrfillet@gmail.com>
 <9a274a44b61345e8aba747a44250c4d8@EXMBX066.cuchost.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EJxUDy+0o/zIR+OB"
Content-Disposition: inline
In-Reply-To: <9a274a44b61345e8aba747a44250c4d8@EXMBX066.cuchost.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--EJxUDy+0o/zIR+OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Fri, May 19, 2023 at 11:14:27AM +0000, JeeHeng Sia wrote:

> > The suspend_restore_csrs is called in both __hibernate_cpu_resume
> > and the `else` of subsequent swsusp_arch_suspend.
> >=20
> > Removing the first call makes both suspend_{save,restore}_csrs
> > left in swsusp_arch_suspend for clean code.
> >=20
> > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>

BTW, why the two email addresses? The tinylab one here seems entirely
redundant - unless it is your employer, in which case should it be the
only SoB address & also in the author field?

Also, Fixes tag?

> > ---
> >  arch/riscv/kernel/hibernate-asm.S | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
> > diff --git a/arch/riscv/kernel/hibernate-asm.S b/arch/riscv/kernel/hibe=
rnate-asm.S
> > index 5c76671c7e15..d698dd7df637 100644
> > --- a/arch/riscv/kernel/hibernate-asm.S
> > +++ b/arch/riscv/kernel/hibernate-asm.S
> > @@ -28,7 +28,6 @@ ENTRY(__hibernate_cpu_resume)
> >=20
> >  	REG_L	a0, hibernate_cpu_context
> >=20
> > -	suspend_restore_csrs
> >  	suspend_restore_regs

> Good catch. This function is invoked twice to restore the CSRs.
> I am good with removing this function from here.

If that's a review, then please either give an R-b or A-b tag :)

Thanks,
Conor.

--EJxUDy+0o/zIR+OB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGddRwAKCRB4tDGHoIJi
0mipAP9UCMmbIp4f083gUWLawat8G9jMwBB9ejHima6/7Ti7gQEAhWrQ5erXm8Ci
dgutF7nRdqiQDx9tH1J275jBm3gXIQc=
=IWm6
-----END PGP SIGNATURE-----

--EJxUDy+0o/zIR+OB--
